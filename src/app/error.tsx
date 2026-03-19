'use client'

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <html>
      <body>
        <div style={{ maxWidth: 720, margin: '40px auto', fontFamily: 'system-ui, sans-serif' }}>
          <h1 style={{ fontSize: 24, fontWeight: 700, marginBottom: 12 }}>Сталася помилка</h1>
          <p style={{ marginBottom: 16 }}>
            Спробуйте оновити сторінку або повторити дію.
          </p>
          <button
            type="button"
            onClick={() => reset()}
            style={{
              padding: '10px 14px',
              borderRadius: 8,
              border: '1px solid #d1d5db',
              background: '#fff',
              cursor: 'pointer',
            }}
          >
            Спробувати знову
          </button>
          {process.env.NODE_ENV === 'development' && (
            <pre
              style={{
                marginTop: 16,
                padding: 12,
                borderRadius: 8,
                background: '#111827',
                color: '#e5e7eb',
                overflowX: 'auto',
                fontSize: 12,
              }}
            >
              {error.message}
            </pre>
          )}
        </div>
      </body>
    </html>
  )
}

