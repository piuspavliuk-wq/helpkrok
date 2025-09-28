'use client';

import { useState, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { Loader2 } from 'lucide-react';
import dynamic from 'next/dynamic';

const ResetPasswordForm = dynamic(() => Promise.resolve(function ResetPasswordForm() {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');
  const [token, setToken] = useState<string | null>(null);
  const router = useRouter();
  const searchParams = useSearchParams();

  useEffect(() => {
    const tokenFromUrl = searchParams.get('token');
    if (tokenFromUrl) {
      setToken(tokenFromUrl);
    } else {
      setError('Reset token is missing.');
    }
  }, [searchParams]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    setMessage('');
    setError('');

    if (!token) {
      setError('Reset token is missing.');
      setIsLoading(false);
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Passwords do not match.');
      setIsLoading(false);
      return;
    }

    if (newPassword.length < 6) {
      setError('Password must be at least 6 characters long.');
      setIsLoading(false);
      return;
    }

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
        setMessage(data.message || 'Your password has been reset successfully.');
        setNewPassword('');
        setConfirmPassword('');
        // Optionally redirect to login after a short delay
        setTimeout(() => router.push('/auth/signin'), 3000);
      } else {
        setError(data.error || 'Failed to reset password. Please try again.');
      }
    } catch (err) {
      console.error('Reset password request error:', err);
      setError('An unexpected error occurred. Please try again.');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
      <div className="max-w-md w-full space-y-8">
        <div className="text-center">
          <h2 className="mt-6 text-3xl font-extrabold text-gray-900">
            Скидання пароля
          </h2>
          <p className="mt-2 text-sm text-gray-600">
            Введіть ваш новий пароль.
          </p>
        </div>

        <div className="mt-8 space-y-6">
          <div className="bg-white p-8 rounded-lg shadow-lg">
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
                  placeholder="Мінімум 6 символів"
                  disabled={isLoading}
                />
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
                  placeholder="Повторіть новий пароль"
                  disabled={isLoading}
                />
              </div>

              {message && (
                <p className="text-sm text-green-600 text-center">{message}</p>
              )}
              {error && (
                <p className="text-sm text-red-600 text-center">{error}</p>
              )}

              <button
                type="submit"
                disabled={isLoading || !token}
                className="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {isLoading ? (
                  <Loader2 className="w-5 h-5 animate-spin mr-2" />
                ) : (
                  'Скинути пароль'
                )}
              </button>
            </form>

            <div className="mt-6 text-center">
              <button
                onClick={() => router.push('/auth/signin')}
                className="text-blue-600 hover:text-blue-500 text-sm font-medium"
              >
                Повернутися до входу
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}), {
  ssr: false,
  loading: () => <div>Loading...</div>
});

export default function ResetPasswordPage() {
  return <ResetPasswordForm />;
}