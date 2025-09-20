import { createClient as createSupabaseClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY

// Створюємо Supabase клієнт тільки якщо змінні середовища налаштовані
export const supabase = supabaseUrl && supabaseAnonKey 
  ? createSupabaseClient(supabaseUrl, supabaseAnonKey)
  : null

// Створюємо Supabase клієнт з service role key для адміністративних операцій
export const supabaseAdmin = supabaseUrl && supabaseServiceKey
  ? createSupabaseClient(supabaseUrl, supabaseServiceKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    })
  : supabaseUrl && supabaseAnonKey
  ? createSupabaseClient(supabaseUrl, supabaseAnonKey, {
      auth: {
        autoRefreshToken: false,
        persistSession: false
      }
    })
  : null

// Функція для створення клієнта (для серверних компонентів)
export function createSupabaseClientForServer() {
  if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error('Supabase URL або ключ не налаштовані')
  }
  return createSupabaseClient(supabaseUrl, supabaseAnonKey)
}

// Database types
export interface Database {
  public: {
    Tables: {
      users: {
        Row: {
          id: string
          first_name: string
          last_name: string
          email: string
          password: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          first_name: string
          last_name: string
          email: string
          password: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          first_name?: string
          last_name?: string
          email?: string
          password?: string
          created_at?: string
          updated_at?: string
        }
      }
      user_subscriptions: {
        Row: {
          id: string
          user_id: string
          subscription_type: 'medical' | 'pharmaceutical' | 'premium'
          status: 'active' | 'expired' | 'cancelled'
          start_date: string
          end_date: string
          payment_provider: 'stripe' | 'liqpay' | 'fondy'
          payment_id: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          subscription_type: 'medical' | 'pharmaceutical' | 'premium'
          status?: 'active' | 'expired' | 'cancelled'
          start_date: string
          end_date: string
          payment_provider: 'stripe' | 'liqpay' | 'fondy'
          payment_id?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          subscription_type?: 'medical' | 'pharmaceutical' | 'premium'
          status?: 'active' | 'expired' | 'cancelled'
          start_date?: string
          end_date?: string
          payment_provider?: 'stripe' | 'liqpay' | 'fondy'
          payment_id?: string | null
          created_at?: string
          updated_at?: string
        }
      }
      courses: {
        Row: {
          id: string
          title: string
          description: string | null
          faculty: 'medical' | 'pharmaceutical'
          order_index: number
          is_active: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          title: string
          description?: string | null
          faculty: 'medical' | 'pharmaceutical'
          order_index: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          title?: string
          description?: string | null
          faculty?: 'medical' | 'pharmaceutical'
          order_index?: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
      }
      topics: {
        Row: {
          id: string
          course_id: string
          title: string
          description: string | null
          video_url: string | null
          lecture_notes: string | null
          order_index: number
          is_active: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          course_id: string
          title: string
          description?: string | null
          video_url?: string | null
          lecture_notes?: string | null
          order_index: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          course_id?: string
          title?: string
          description?: string | null
          video_url?: string | null
          lecture_notes?: string | null
          order_index?: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
      }
      questions: {
        Row: {
          id: string
          topic_id: string
          question_text: string
          explanation: string | null
          difficulty: 'easy' | 'medium' | 'hard'
          order_index: number
          is_active: boolean
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          topic_id: string
          question_text: string
          explanation?: string | null
          difficulty?: 'easy' | 'medium' | 'hard'
          order_index: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          topic_id?: string
          question_text?: string
          explanation?: string | null
          difficulty?: 'easy' | 'medium' | 'hard'
          order_index?: number
          is_active?: boolean
          created_at?: string
          updated_at?: string
        }
      }
      question_options: {
        Row: {
          id: string
          question_id: string
          option_text: string
          is_correct: boolean
          order_index: number
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          question_id: string
          option_text: string
          is_correct: boolean
          order_index: number
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          question_id?: string
          option_text?: string
          is_correct?: boolean
          order_index?: number
          created_at?: string
          updated_at?: string
        }
      }
      user_topic_progress: {
        Row: {
          id: string
          user_id: string
          topic_id: string
          video_progress: number
          video_completed: boolean
          test_completed: boolean
          test_score: number | null
          last_accessed: string
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          topic_id: string
          video_progress?: number
          video_completed?: boolean
          test_completed?: boolean
          test_score?: number | null
          last_accessed?: string
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          topic_id?: string
          video_progress?: number
          video_completed?: boolean
          test_completed?: boolean
          test_score?: number | null
          last_accessed?: string
          created_at?: string
          updated_at?: string
        }
      }
      test_attempts: {
        Row: {
          id: string
          user_id: string
          topic_id: string | null
          attempt_type: 'topic_test' | 'krok_simulation' | 'year_booklet'
          total_questions: number
          correct_answers: number
          score: number
          time_spent: number
          completed_at: string
          created_at: string
        }
        Insert: {
          id?: string
          user_id: string
          topic_id?: string | null
          attempt_type: 'topic_test' | 'krok_simulation' | 'year_booklet'
          total_questions: number
          correct_answers: number
          score: number
          time_spent: number
          completed_at: string
          created_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          topic_id?: string | null
          attempt_type?: 'topic_test' | 'krok_simulation' | 'year_booklet'
          total_questions?: number
          correct_answers?: number
          score?: number
          time_spent?: number
          completed_at?: string
          created_at?: string
        }
      }
      user_topic_access: {
        Row: {
          id: string
          user_id: string
          topic_id: string
          access_granted: boolean
          granted_at: string | null
          expires_at: string | null
          created_at: string
          updated_at: string
        }
        Insert: {
          id?: string
          user_id: string
          topic_id: string
          access_granted?: boolean
          granted_at?: string | null
          expires_at?: string | null
          created_at?: string
          updated_at?: string
        }
        Update: {
          id?: string
          user_id?: string
          topic_id?: string
          access_granted?: boolean
          granted_at?: string | null
          expires_at?: string | null
          created_at?: string
          updated_at?: string
        }
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
  }
}