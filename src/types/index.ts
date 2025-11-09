// User types
export interface User {
  id: string
  first_name: string | null
  last_name: string | null
  faculty: 'medical' | 'pharmaceutical' | null
  created_at: string
  updated_at: string
}

// Subscription types
export interface UserSubscription {
  id: string
  user_id: string
  subscription_type: 'medical' | 'pharmaceutical' | 'premium'
  status: 'active' | 'expired' | 'cancelled'
  start_date: string
  end_date: string
  payment_provider: 'mono'
  payment_id: string | null
  created_at: string
  updated_at: string
}

// Course types
export interface Course {
  id: string
  title: string
  description: string | null
  faculty: 'medical' | 'pharmaceutical'
  order_index: number
  is_active: boolean
  created_at: string
  updated_at: string
  topics?: Topic[]
}

// Topic types
export interface Topic {
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
  questions?: Question[]
  progress?: UserTopicProgress
}

// Question types
export interface Question {
  id: string
  topic_id: string
  question_text: string
  explanation: string | null
  difficulty: 'easy' | 'medium' | 'hard'
  order_index: number
  is_active: boolean
  created_at: string
  updated_at: string
  options?: QuestionOption[]
}

export interface QuestionOption {
  id: string
  question_id: string
  option_text: string
  is_correct: boolean
  order_index: number
  created_at: string
  updated_at: string
}

// Progress types
export interface UserTopicProgress {
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

export interface TestAttempt {
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

// Access control types
export interface UserTopicAccess {
  id: string
  user_id: string
  topic_id: string
  access_granted: boolean
  granted_at: string | null
  expires_at: string | null
  created_at: string
  updated_at: string
}

// Payment types
export interface PaymentPlan {
  id: string
  name: string
  type: 'medical' | 'pharmaceutical' | 'premium'
  price: number
  currency: 'UAH'
  duration_months: number
  description: string
  features: string[]
}

// Analytics types
export interface UserAnalytics {
  total_topics_completed: number
  total_tests_taken: number
  average_score: number
  total_study_time: number
  weak_areas: string[]
  strong_areas: string[]
  progress_by_faculty: {
    medical: number
    pharmaceutical: number
  }
}

// NextAuth types
declare module "next-auth" {
  interface Session {
    user: {
      id: string
      name?: string | null
      email?: string | null
      image?: string | null
      role?: string
    }
  }

  interface User {
    id: string
    name?: string | null
    email?: string | null
    image?: string | null
    role?: string
  }
}

declare module "next-auth/jwt" {
  interface JWT {
    id: string
    role?: string
  }
}

// API Response types
export interface ApiResponse<T> {
  data: T | null
  error: string | null
  success: boolean
}

// Form types
export interface LoginForm {
  first_name: string
  last_name?: string
  faculty: 'medical' | 'pharmaceutical'
}

export interface TestAnswer {
  question_id: string
  selected_option_id: string
  time_spent: number
}

export interface TestResult {
  score: number
  total_questions: number
  correct_answers: number
  time_spent: number
  passed: boolean
  answers: TestAnswer[]
}
