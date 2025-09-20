import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import { Resend } from 'resend';
import crypto from 'crypto';

const resend = new Resend(process.env.RESEND_API_KEY || 're_test_key');
const appUrl = process.env.NEXT_PUBLIC_APP_URL || 'http://localhost:3000';

export async function POST(request: NextRequest) {
  try {
    const { email } = await request.json();

    if (!email) {
      return NextResponse.json({ error: 'Email is required' }, { status: 400 });
    }

    const supabase = createSupabaseClientForServer();

    // 1. Find the user by email
    const { data: user, error: userError } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .single();

    if (userError || !user) {
      console.error('User not found for password reset:', userError?.message);
      // Return a generic success message to prevent email enumeration
      return NextResponse.json({ message: 'If an account with that email exists, a password reset link has been sent.' });
    }

    const userId = user.id;

    // 2. Generate a unique token
    const token = crypto.randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours from now

    // 3. Store the token in the database
    const { error: insertError } = await supabase
      .from('password_reset_tokens')
      .insert({ user_id: userId, token, expires_at: expiresAt });

    if (insertError) {
      console.error('Error inserting password reset token:', insertError.message);
      return NextResponse.json({ error: 'Failed to generate reset token' }, { status: 500 });
    }

    // 4. Send the reset email
    const resetLink = `${appUrl}/auth/reset-password?token=${token}`;

    // Перевіряємо, чи є API ключ
    if (process.env.RESEND_API_KEY) {
      try {
        await resend.emails.send({
          from: 'Help Krok <noreply@helpkrok.com>',
          to: email,
          subject: 'Відновлення пароля - Help Krok',
          html: `
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
              <h2 style="color: #2563eb;">Відновлення пароля</h2>
              <p>Ви запросили відновлення пароля для вашого акаунту Help Krok.</p>
              <p>Натисніть кнопку нижче, щоб скинути пароль:</p>
              <div style="text-align: center; margin: 30px 0;">
                <a href="${resetLink}" 
                   style="background-color: #2563eb; color: white; padding: 12px 24px; text-decoration: none; border-radius: 6px; display: inline-block;">
                  Скинути пароль
                </a>
              </div>
              <p>Або скопіюйте це посилання в браузер:</p>
              <p style="word-break: break-all; color: #666;">${resetLink}</p>
              <p><strong>Це посилання дійсне 24 години.</strong></p>
              <p>Якщо ви не запитували відновлення пароля, проігноруйте це повідомлення.</p>
              <hr style="margin: 30px 0; border: none; border-top: 1px solid #eee;">
              <p style="color: #666; font-size: 14px;">
                З повагою,<br>
                Команда Help Krok
              </p>
            </div>
          `,
        });

        console.log(`Password reset email sent to ${email}`);
      } catch (emailError) {
        console.error('Error sending email:', emailError);
        // Якщо email не відправився, все одно повертаємо успіх для безпеки
      }
    } else {
      // Якщо немає API ключа, показуємо посилання в логах
      console.log(`Password reset link for ${email}: ${resetLink}`);
      console.log('💡 Для відправки email додайте RESEND_API_KEY в .env.local');
    }

    return NextResponse.json({ 
      message: 'If an account with that email exists, a password reset link has been sent.',
      resetLink: resetLink
    });

  } catch (error) {
    console.error('Forgot password API error:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}