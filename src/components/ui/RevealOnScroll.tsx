'use client'

import React, { useEffect, useRef, useState } from 'react'

type Direction = 'up' | 'down' | 'left' | 'right'

interface RevealOnScrollProps {
  children: React.ReactNode
  direction?: Direction
  threshold?: number
  delayMs?: number
  className?: string
}

/**
 * Reveals children with a fade and directional translate when scrolled into view.
 */
export default function RevealOnScroll({
  children,
  direction = 'up',
  threshold = 0.15,
  delayMs = 0,
  className = '',
}: RevealOnScrollProps) {
  const ref = useRef<HTMLDivElement | null>(null)
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    const element = ref.current
    if (!element) return

    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            if (delayMs > 0) {
              const timer = setTimeout(() => setIsVisible(true), delayMs)
              return () => clearTimeout(timer)
            }
            setIsVisible(true)
          }
        })
      },
      { threshold }
    )

    observer.observe(element)
    return () => observer.disconnect()
  }, [threshold, delayMs])

  const baseHidden = 'opacity-0'
  const baseShown = 'opacity-100'
  const transition = 'transition-all duration-700 ease-out will-change-transform'

  const translateHidden = {
    up: 'translate-y-6',
    down: '-translate-y-6',
    left: 'translate-x-6',
    right: '-translate-x-6',
  }[direction]

  const translateShown = 'translate-x-0 translate-y-0'

  const stateClass = isVisible
    ? `${baseShown} ${translateShown}`
    : `${baseHidden} ${translateHidden}`

  return (
    <div ref={ref} className={`${transition} ${stateClass} ${className}`}>
      {children}
    </div>
  )
}







