import { NextRequest, NextResponse } from 'next/server'
import crypto from 'crypto'
import { prisma } from '@/lib/prisma'
import { supabase } from '@/lib/supabase'

interface PlataWebhookPayload {
  invoiceId?: string
  paymentId?: string
  status?: string
  amount?: number
  ccy?: number
  merchantPaymInfo?: {
    reference?: string
  }
  orderId?: string
  externalData?: unknown
  statementId?: string
}

const SUCCESS_STATUSES = new Set(['success', 'processed', 'hold_confirmed'])
const FAILED_STATUSES = new Set(['expired', 'declined', 'reversed', 'refunded', 'failed'])

export async function POST(request: NextRequest) {
  const token = process.env.MONOBANK_API_TOKEN

  if (!token) {
    console.error('MONOBANK_API_TOKEN is not configured')
    return NextResponse.json({ error: 'Server configuration error' }, { status: 500 })
  }

  const rawBody = await request.text()
  const signature = request.headers.get('x-signature') ?? ''

  if (!validateSignature(rawBody, signature, token)) {
    console.error('Invalid Plata by mono signature', { signature })
    return NextResponse.json({ error: 'Invalid signature' }, { status: 400 })
  }

  let payload: PlataWebhookPayload
  try {
    payload = JSON.parse(rawBody)
  } catch (error) {
    console.error('Failed to parse Plata webhook payload', error)
    return NextResponse.json({ error: 'Invalid JSON' }, { status: 400 })
  }

  const reference =
    payload.merchantPaymInfo?.reference ||
    payload.orderId ||
    payload.invoiceId ||
    payload.paymentId

  if (!reference) {
    console.error('Webhook payload without reference', payload)
    return NextResponse.json({ error: 'Missing reference' }, { status: 400 })
  }

  const status = payload.status?.toLowerCase() ?? 'unknown'

  try {
    if (SUCCESS_STATUSES.has(status)) {
      await updateSubscriptionStatus(reference, 'active')
    } else if (FAILED_STATUSES.has(status)) {
      await updateSubscriptionStatus(reference, 'failed')
    } else {
      console.log('Unhandled Plata status', status)
    }

    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Failed to process Plata webhook', error)
    return NextResponse.json({ error: 'Internal error' }, { status: 500 })
  }
}

function validateSignature(body: string, signature: string, token: string): boolean {
  if (!signature) return false

  try {
    const hmacHex = crypto.createHmac('sha256', token).update(body).digest('hex')
    const hmacBase64 = crypto.createHmac('sha256', token).update(body).digest('base64')

    return signature === hmacHex || signature === hmacHex.toUpperCase() || signature === hmacBase64
  } catch (error) {
    console.error('Failed to validate Plata signature', error)
    return false
  }
}

async function updateSubscriptionStatus(subscriptionId: string, status: 'active' | 'failed') {
  await prisma.userSubscription.updateMany({
    where: {
      OR: [{ id: subscriptionId }, { paymentId: subscriptionId }],
    },
    data: {
      status,
      updatedAt: new Date(),
    },
  })

  if (!supabase) {
    console.warn('Supabase is not configured, skipping sync for', subscriptionId)
    return
  }

  await supabase
    .from('user_subscriptions')
    .update({
      status,
      updated_at: new Date().toISOString(),
    })
    .or(`id.eq.${subscriptionId},payment_id.eq.${subscriptionId}`)
}


