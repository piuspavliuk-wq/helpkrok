import { NextAuthOptions } from "next-auth"
import { createClient } from '@supabase/supabase-js'
import CredentialsProvider from "next-auth/providers/credentials"
import bcrypt from "bcryptjs"

// Створюємо Supabase клієнт безпосередньо в auth файлі
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

const supabaseAdmin = supabaseUrl && supabaseServiceKey
  ? createClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    })
  : null

export const authOptions: NextAuthOptions = {
  secret: process.env.NEXTAUTH_SECRET,
  providers: [
    CredentialsProvider({
      name: "credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) {
          console.log('Missing credentials')
          return null
        }

        if (!supabaseAdmin) {
          console.error('Supabase admin client not initialized')
          console.error('Environment variables:', {
            supabaseUrl: process.env.NEXT_PUBLIC_SUPABASE_URL,
            supabaseServiceKey: process.env.SUPABASE_SERVICE_ROLE_KEY ? 'SET' : 'NOT SET'
          })
          return null
        }

        try {
          if (!supabaseAdmin) {
            console.error('Supabase admin client is null')
            return null
          }

          const { data: user, error } = await supabaseAdmin
            .from('users')
            .select('id, first_name, last_name, email, password, role')
            .eq('email', credentials.email)
            .single()

          if (error || !user) {
            console.error('User not found:', error)
            return null
          }

          if (!user.password) {
            console.error('User has no password')
            return null
          }

          const isPasswordValid = await bcrypt.compare(credentials.password, user.password)

          if (!isPasswordValid) {
            console.error('Invalid password')
            return null
          }

          return {
            id: user.id,
            email: user.email,
            name: `${user.first_name} ${user.last_name}`,
            role: user.role || 'student',
          }
        } catch (error) {
          console.error('Auth error:', error)
          return null
        }
      },
    }),
  ],
  session: {
    strategy: "jwt",
  },
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id
        token.role = (user as { role?: string }).role
      }
      return token
    },
    async session({ session, token }) {
      if (token && session.user) {
        session.user.id = token.id as string
        session.user.role = token.role as string
      }
      return session
    },
  },
  pages: {
    signIn: "/auth/signin",
    error: "/auth/error",
  },
}
