import { ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface BadgeProps {
  variant?: 'default' | 'secondary' | 'destructive' | 'outline'
  className?: string
  children: ReactNode
}

export function Badge({ 
  variant = 'default', 
  className, 
  children 
}: BadgeProps) {
  const variants = {
    default: 'bg-primary-500 text-white',
    secondary: 'bg-gray-100 text-gray-700',
    destructive: 'bg-red-500 text-white',
    outline: 'border border-gray-300 text-gray-700 bg-white'
  }
  
  return (
    <span
      className={cn(
        'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
        variants[variant],
        className
      )}
    >
      {children}
    </span>
  )
}
