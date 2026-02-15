import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // PDFs are served as static files from public/pdfs at /pdfs/...
  // (no API route — avoids Vercel serverless function size limit)
};

export default nextConfig;
