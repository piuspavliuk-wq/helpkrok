import { ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'default' | 'destructive'
  size?: 'sm' | 'md' | 'lg' | 'default' | 'sm' | 'lg' | 'icon'
  children: ReactNode
}

export function Button({ 
  variant = 'default', 
  size = 'default', 
  className, 
  children, 
  ...props 
}: ButtonProps) {
  const baseClasses = 'inline-flex items-center justify-center rounded-xl font-medium transition-colors duration-200 focus-ring disabled:opacity-50 disabled:pointer-events-none'
  
  const variants = {
    default: 'bg-primary-500 text-white hover:bg-primary-600',
    primary: 'bg-primary-500 text-white hover:bg-primary-600',
    secondary: 'bg-gray-100 text-gray-700 hover:bg-gray-200',
    outline: 'border-2 border-primary-500 text-primary-500 hover:bg-primary-500 hover:text-white',
    ghost: 'text-gray-600 hover:text-gray-900 hover:bg-gray-100',
    destructive: 'bg-red-500 text-white hover:bg-red-600'
  }
  
  const sizes = {
    default: 'px-6 py-3 text-base',
    sm: 'px-3 py-2 text-sm',
    md: 'px-6 py-3 text-base',
    lg: 'px-8 py-4 text-lg',
    icon: 'h-10 w-10'
  }
  
  return (
    <button
      className={cn(baseClasses, variants[variant], sizes[size], className)}
      {...props}
    >
      {children}
    </button>
  )
}
