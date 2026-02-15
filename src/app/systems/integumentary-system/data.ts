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
}

export const sections: Section[] = [
  {
    title: 'Нормальний розвиток і структура, вікові зміни',
    slug: 'normalnij-rozvitok-i-struktura',
    topics: [],
    videos: ['pEGP50N0fQk'],
    notes: [
      {
        title: 'Загальний покрив: конспект 2.0',
        description: 'Конспект загального покриву (шкіра та її деривати)',
        file: '/pdfs/Загальний покрив 2.0.pdf'
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
