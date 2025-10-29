import NextAuth from "next-auth"
import { authOptions } from "@/lib/auth"

// Створюємо handler з кращою обробкою помилок
const handler = NextAuth(authOptions)

// Експортуємо з обробкою помилок
export const GET = async (req: Request, res: any) => {
  try {
    return await handler(req, res)
  } catch (error) {
    console.error('NextAuth GET error:', error)
    return new Response('Internal Server Error', { status: 500 })
  }
}

export const POST = async (req: Request, res: any) => {
  try {
    return await handler(req, res)
  } catch (error) {
    console.error('NextAuth POST error:', error)
    return new Response('Internal Server Error', { status: 500 })
  }
}
