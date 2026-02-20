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
    title: 'Серцево-судинна система, патологічні процеси',
    slug: 'serdevo-sudynna-systema-tema-patologichni-procesy',
    topics: [],
    videos: ['RfEXMXI8RIw', 'm9NuK44KcBQ'],
    notes: [
      {
        title: 'Серцево-судинна система: конспект',
        description: 'Конспект серцево-судинної системи',
        file: '/pdfs/Серцево-судинна система.pdf'
      }
    ]
  },
  {
    title: 'Лікарські засоби серцево-судинної системи',
    slug: 'likarski-zasoby-serdevo-sudynnoji-systemy',
    topics: [],
    videos: ['ORCjFFQ40XI'],
    notes: []
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
