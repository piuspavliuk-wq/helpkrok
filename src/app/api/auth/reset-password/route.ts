import { NextRequest, NextResponse } from 'next/server';
import { createSupabaseClientForServer } from '@/lib/supabase';
import bcrypt from 'bcryptjs';

export async function POST(request: NextRequest) {
  try {
    const { token, newPassword } = await request.json();

    if (!token || !newPassword) {
      return NextResponse.json({ error: 'Token and new password are required' }, { status: 400 });
    }

    const supabase = createSupabaseClientForServer();

    // 1. Find and validate the token
    const { data: resetToken, error: tokenError } = await supabase
      .from('password_reset_tokens')
      .select('user_id, expires_at')
      .eq('token', token)
      .single();

    if (tokenError || !resetToken) {
      console.error('Invalid or expired token:', tokenError?.message);
      return NextResponse.json({ error: 'Invalid or expired token' }, { status: 400 });
    }

    if (new Date(resetToken.expires_at) < new Date()) {
      // 2. Delete the expired token
      await supabase.from('password_reset_tokens').delete().eq('token', token);
      return NextResponse.json({ error: 'Token has expired' }, { status: 400 });
    }

    // 3. Hash the new password
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // 4. Update the user's password
    const { error: updateError } = await supabase
      .from('users')
      .update({ password: hashedPassword, updated_at: new Date().toISOString() })
      .eq('id', resetToken.user_id);

    if (updateError) {
      console.error('Error updating password:', updateError.message);
      return NextResponse.json({ error: 'Failed to update password' }, { status: 500 });
    }

    // 5. Invalidate the token (delete it)
    await supabase.from('password_reset_tokens').delete().eq('token', token);

    return NextResponse.json({ message: 'Password has been reset successfully' });

  } catch (error) {
    console.error('Reset password API error:', error);
    return NextResponse.json({ error: 'Internal server error' }, { status: 500 });
  }
}