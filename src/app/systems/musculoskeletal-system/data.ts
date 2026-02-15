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
    title: 'Опорно-руховий апарат. Анатомія',
    slug: 'oporno-ruhovij-aparat-anatomiya',
    topics: [],
    notes: [
      {
        title: 'Опорно-руховий апарат. Анатомія: конспект',
        description: 'Конспект анатомії опорно-рухового апарату',
        file: '/pdfs/Опорно-руховий апарат анатомія..pdf'
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
