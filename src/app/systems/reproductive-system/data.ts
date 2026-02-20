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
    title: 'Репродуктивна система',
    slug: 'reproduktivna-systema',
    sectionNumberLabel: '35',
    topics: [],
    videos: ['IjaWcTgKRzc'],
    notes: [
      {
        title: 'Репродуктивна система: конспект',
        description: 'Конспект репродуктивної системи',
        file: '/pdfs/ilovepdf_merged-7.pdf'
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
