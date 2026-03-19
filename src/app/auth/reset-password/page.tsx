'use client';

import { Suspense, useMemo, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { Loader2 } from 'lucide-react';

function ResetPasswordContent() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const token = useMemo(() => searchParams.get('token') || '', [searchParams]);

  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  const canSubmit =
    !!token &&
    newPassword.length >= 8 &&
    confirmPassword.length >= 8 &&
    newPassword === confirmPassword &&
    !isLoading;

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMessage('');
    setError('');

    if (!token) {
      setError('Посилання для скидання пароля недійсне або не містить токен.');
      return;
    }

    if (newPassword.length < 8) {
      setError('Пароль має бути мінімум 8 символів.');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Паролі не співпадають.');
      return;
    }

    setIsLoading(true);
    try {
      const response = await fetch('/api/auth/reset-password', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ token, newPassword }),
      });

      const data = await response.json();

      if (response.ok) {
        setMessage(data.message || 'Пароль успішно змінено. Зараз можете увійти.');
        setNewPassword('');
        setConfirmPassword('');
        setTimeout(() => router.push('/auth/signin'), 800);
      } else {
        setError(data.error || 'Не вдалося змінити пароль. Спробуйте ще раз.');
      }
    } catch (err) {
      console.error('Reset password request error:', err);
      setError('Сталася несподівана помилка. Спробуйте ще раз.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
      <div className="max-w-md w-full space-y-8">
        <div className="text-center">
          <h2 className="mt-6 text-3xl font-extrabold text-gray-900">Скидання пароля</h2>
          <p className="mt-2 text-sm text-gray-600">
            Введіть новий пароль для вашого акаунту.
          </p>
        </div>

        <div className="mt-8 space-y-6">
          <div className="bg-white p-8 rounded-lg shadow-lg">
            {!token && (
              <div className="mb-4 p-3 rounded-md bg-red-50 border border-red-200 text-sm text-red-700">
                Посилання недійсне або токен відсутній. Спробуйте ще раз через “Відновлення пароля”.
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label htmlFor="newPassword" className="block text-sm font-medium text-gray-700">
                  Новий пароль
                </label>
                <input
                  id="newPassword"
                  name="newPassword"
                  type="password"
                  required
                  value={newPassword}
                  onChange={(e) => setNewPassword(e.target.value)}
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                  placeholder="********"
                  disabled={isLoading || !token}
                  minLength={8}
                  autoComplete="new-password"
                />
                <p className="mt-1 text-xs text-gray-500">Мінімум 8 символів.</p>
              </div>

              <div>
                <label htmlFor="confirmPassword" className="block text-sm font-medium text-gray-700">
                  Підтвердіть пароль
                </label>
                <input
                  id="confirmPassword"
                  name="confirmPassword"
                  type="password"
                  required
                  value={confirmPassword}
                  onChange={(e) => setConfirmPassword(e.target.value)}
                  className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                  placeholder="********"
                  disabled={isLoading || !token}
                  minLength={8}
                  autoComplete="new-password"
                />
              </div>

              {message && <p className="text-sm text-green-600 text-center">{message}</p>}
              {error && <p className="text-sm text-red-600 text-center">{error}</p>}

              <button
                type="submit"
                disabled={!canSubmit}
                className="w-full flex justify-center items-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isLoading ? <Loader2 className="w-5 h-5 animate-spin mr-2" /> : null}
                Змінити пароль
              </button>
            </form>

            <div className="mt-6 text-center space-y-2">
              <button
                onClick={() => router.push('/auth/signin')}
                className="text-blue-600 hover:text-blue-500 text-sm font-medium"
              >
                Повернутися до входу
              </button>
              <div>
                <button
                  onClick={() => router.push('/auth/forgot-password')}
                  className="text-gray-600 hover:text-gray-500 text-sm"
                >
                  Надіслати нове посилання для скидання
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default function ResetPasswordPage() {
  return (
    <Suspense
      fallback={
        <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
          <div className="text-center">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600 mx-auto"></div>
          </div>
        </div>
      }
    >
      <ResetPasswordContent />
    </Suspense>
  );
}

