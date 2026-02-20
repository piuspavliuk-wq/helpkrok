export interface Topic {
  title: string
  slug: string
}

export interface SectionNote {
  title: string
  file: string
  description?: string
}

export interface Section {
  title: string
  slug: string
  topics: Topic[]
  videos?: string[]
  notes?: SectionNote[]
  tests?: string[]
  sectionNumberLabel?: string
}

export const sections: Section[] = [
  {
    title: 'Ендокринна система нормальний розвиток',
    slug: 'endokrynna-systema-normalnyj-rozvytok',
    sectionNumberLabel: '36',
    topics: [],
    videos: ['vVgG6eb1z8Q'],
    notes: [
      {
        title: 'Ендокринна система: конспект',
        description: 'Конспект ендокринної системи',
        file: '/pdfs/Ендокринна система 2.pdf'
      }
    ]
  },
  {
    title: 'Патологія ендокринної системи',
    slug: 'patolohiya-endokrynnoji-systemy',
    sectionNumberLabel: '37',
    topics: [],
    videos: ['DfGOgtFPhIc'],
    notes: [
      {
        title: 'Патологія ендокринної системи: конспект',
        description: 'Конспект патології ендокринної системи',
        file: '/pdfs/37 тема Патологія ендокринної .pdf'
      }
    ]
  }
]

export const sectionMap = sections.reduce<Record<string, Section>>(
  (acc, section) => {
    acc[section.slug] = section
    return acc
  },
  {}
)

export const topicMap = sections.reduce<Record<string, { title: string; sectionTitle: string }>>(
  (acc, section) => {
    section.topics.forEach((topic) => {
      acc[topic.slug] = { title: topic.title, sectionTitle: section.title }
    })
    return acc
  },
  {}
)
