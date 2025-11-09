'use client'

import { useCallback } from 'react'
import { useRouter } from 'next/navigation'
import { ArrowLeft } from 'lucide-react'
import { Button } from '@/components/ui/button'

interface TestBackButtonProps {
  className?: string
  fallbackHref?: string
  label?: string
}

export default function TestBackButton({
  className = '',
  fallbackHref = '/',
  label = 'Назад',
}: TestBackButtonProps) {
  const router = useRouter()

  const handleClick = useCallback(() => {
    if (typeof window !== 'undefined' && window.history.length > 1) {
      router.back()
      return
    }

    router.push(fallbackHref)
  }, [router, fallbackHref])

  return (
    <Button
      type="button"
      variant="outline"
      onClick={handleClick}
      className={`flex items-center gap-2 bg-white/80 hover:bg-white border border-gray-200 text-gray-700 hover:text-gray-700 shadow-sm transition-colors duration-200 ${className}`}
    >
      <ArrowLeft className="w-4 h-4" />
      {label}
    </Button>
  )
}

