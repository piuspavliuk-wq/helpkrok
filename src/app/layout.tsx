import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { SessionProvider } from "@/components/providers/SessionProvider";
import Sidebar from "@/components/layout/Sidebar";

const inter = Inter({
  subsets: ["latin", "cyrillic"],
  variable: "--font-inter",
});

export const metadata: Metadata = {
  title: "Help Krok - Підготовка до екзаменів КРОК",
  description: "Сучасна платформа для підготовки студентів медичного та фармацевтичного факультетів до складання екзаменів КРОК. Відеолекції, тести, аналітика прогресу.",
  keywords: "КРОК, медицина, фармація, підготовка до екзаменів, тести, відеолекції",
  authors: [{ name: "Help Krok Team" }],
  creator: "Help Krok",
  publisher: "Help Krok",
  icons: {
    icon: [
      { url: '/favicon.png', sizes: '32x32', type: 'image/png' },
      { url: '/favicon.png', sizes: '16x16', type: 'image/png' },
    ],
    apple: [
      { url: '/favicon.png', sizes: '180x180', type: 'image/png' },
    ],
    other: [
      { rel: 'icon', url: '/favicon.png' },
    ],
  },
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  metadataBase: new URL('https://helpkrok.ua'),
  alternates: {
    canonical: '/',
  },
  openGraph: {
    title: "Help Krok - Підготовка до екзаменів КРОК",
    description: "Сучасна платформа для підготовки студентів медичного та фармацевтичного факультетів до складання екзаменів КРОК",
    url: 'https://helpkrok.ua',
    siteName: 'Help Krok',
    locale: 'uk_UA',
    type: 'website',
    images: [
      {
        url: '/favicon.png',
        width: 1200,
        height: 630,
        alt: 'Help Krok Logo',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: "Help Krok - Підготовка до екзаменів КРОК",
    description: "Сучасна платформа для підготовки студентів медичного та фармацевтичного факультетів до складання екзаменів КРОК",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="uk">
      <body className={`${inter.variable} font-sans antialiased`}>
        <SessionProvider>
          <div className="min-h-screen">
            <Sidebar />
            <main className="bg-white pb-20 min-h-screen md:pl-64">
              {children}
            </main>
          </div>
        </SessionProvider>
      </body>
    </html>
  );
}
