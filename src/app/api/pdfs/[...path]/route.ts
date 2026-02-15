import { NextRequest, NextResponse } from 'next/server'
import { readFile } from 'fs/promises'
import path from 'path'

const PUBLIC_PDFS = path.join(process.cwd(), 'public', 'pdfs')
const SRC_PDFS = path.join(process.cwd(), 'src', 'pdfs')

function safePath(segments: string[]): string {
  const joined = path.join(...segments)
  const resolved = path.normalize(joined)
  if (resolved.startsWith('..') || path.isAbsolute(resolved)) {
    return ''
  }
  return resolved
}

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ path: string[] }> }
) {
  const { path: pathSegments } = await params
  if (!pathSegments?.length) {
    return new NextResponse(null, { status: 404 })
  }
  const relativePath = safePath(pathSegments)
  if (!relativePath) {
    return new NextResponse(null, { status: 400 })
  }

  const publicFile = path.join(PUBLIC_PDFS, relativePath)
  const srcFile = path.join(SRC_PDFS, relativePath)

  try {
    try {
      const buf = await readFile(publicFile)
      return new NextResponse(buf, {
        headers: {
          'Content-Type': 'application/pdf',
          'Content-Length': String(buf.length),
        },
      })
    } catch {
      const buf = await readFile(srcFile)
      return new NextResponse(buf, {
        headers: {
          'Content-Type': 'application/pdf',
          'Content-Length': String(buf.length),
        },
      })
    }
  } catch {
    return new NextResponse(null, { status: 404 })
  }
}

export async function HEAD(
  request: NextRequest,
  { params }: { params: Promise<{ path: string[] }> }
) {
  const { path: pathSegments } = await params
  if (!pathSegments?.length) {
    return new NextResponse(null, { status: 404 })
  }
  const relativePath = safePath(pathSegments)
  if (!relativePath) {
    return new NextResponse(null, { status: 400 })
  }

  const { stat } = await import('fs/promises')
  const publicFile = path.join(PUBLIC_PDFS, relativePath)
  const srcFile = path.join(SRC_PDFS, relativePath)

  try {
    try {
      await stat(publicFile)
    } catch {
      await stat(srcFile)
    }
    return new NextResponse(null, {
      status: 200,
      headers: { 'Content-Type': 'application/pdf' },
    })
  } catch {
    return new NextResponse(null, { status: 404 })
  }
}
