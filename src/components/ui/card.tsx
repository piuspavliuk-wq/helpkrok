import { ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface CardProps {
  className?: string
  children: ReactNode
}

export function Card({ className, children }: CardProps) {
  return (
    <div className={cn('card', className)}>
      {children}
    </div>
  )
}

interface CardHeaderProps {
  className?: string
  children: ReactNode
}

export function CardHeader({ className, children }: CardHeaderProps) {
  return (
    <div className={cn('px-6 py-4', className)}>
      {children}
    </div>
  )
}

interface CardTitleProps {
  className?: string
  children: ReactNode
}

export function CardTitle({ className, children }: CardTitleProps) {
  return (
    <h3 className={cn('text-xl font-semibold text-gray-900', className)}>
      {children}
    </h3>
  )
}

interface CardDescriptionProps {
  className?: string
  children: ReactNode
}

export function CardDescription({ className, children }: CardDescriptionProps) {
  return (
    <p className={cn('text-gray-600 mt-1', className)}>
      {children}
    </p>
  )
}

interface CardContentProps {
  className?: string
  children: ReactNode
}

export function CardContent({ className, children }: CardContentProps) {
  return (
    <div className={cn('px-6 pb-6', className)}>
      {children}
    </div>
  )
}
