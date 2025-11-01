'use client'

import React from 'react'

interface SystemCardProps {
  title: string
  description?: string
  onClick?: () => void
}

export function SystemCard({ title, description, onClick }: SystemCardProps) {
  return (
    <div
      className="w-full max-w-[480px] bg-white/60 backdrop-blur-sm rounded-lg shadow-md border border-white/40 p-8 hover:shadow-lg hover:bg-white/70 transition-all duration-300 cursor-default min-h-44"
      onClick={onClick}
    >
      <h3 className="text-xl font-semibold text-gray-900 mb-3">{title}</h3>
      {description && (
        <p className="text-sm text-gray-600">{description}</p>
      )}
    </div>
  )
}


