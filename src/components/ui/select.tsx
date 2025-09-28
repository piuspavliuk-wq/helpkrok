'use client'

import { ReactNode } from 'react'
import { cn } from '@/lib/utils'
import { ChevronDown } from 'lucide-react'

interface SelectProps {
  value: string
  onValueChange: (value: string) => void
  children: ReactNode
  className?: string
}

interface SelectTriggerProps {
  className?: string
  children: ReactNode
}

interface SelectContentProps {
  className?: string
  children: ReactNode
}

interface SelectItemProps {
  value: string
  className?: string
  children: ReactNode
}

interface SelectValueProps {
  placeholder?: string
}

export function Select({ children, className }: SelectProps) {
  return (
    <div className={cn('relative', className)}>
      {children}
    </div>
  )
}

export function SelectTrigger({ className, children }: SelectTriggerProps) {
  return (
    <button
      className={cn(
        'flex h-10 w-full items-center justify-between rounded-md border border-gray-300 bg-white px-3 py-2 text-sm ring-offset-white placeholder:text-gray-500 focus:outline-none focus:ring-2 focus:ring-primary-500 focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50',
        className
      )}
    >
      {children}
      <ChevronDown className="h-4 w-4 opacity-50" />
    </button>
  )
}

export function SelectContent({ className, children }: SelectContentProps) {
  return (
    <div
      className={cn(
        'absolute top-full z-50 mt-1 w-full rounded-md border border-gray-200 bg-white shadow-md',
        className
      )}
    >
      {children}
    </div>
  )
}

export function SelectItem({ className, children }: SelectItemProps) {
  return (
    <div
      className={cn(
        'relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none hover:bg-gray-100 focus:bg-gray-100',
        className
      )}
    >
      {children}
    </div>
  )
}

export function SelectValue({ placeholder }: SelectValueProps) {
  return <span className="text-gray-500">{placeholder}</span>
}
