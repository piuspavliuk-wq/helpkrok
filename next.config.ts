import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  async rewrites() {
    return [
      { source: '/pdfs/:path*', destination: '/api/pdfs/:path*' },
    ]
  },
};

export default nextConfig;
