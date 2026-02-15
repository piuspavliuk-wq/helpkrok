export interface Topic {
  title: string
  slug: string
}

export interface SectionNote {
  title: string
  file: string
  description?: string
}

export interface SectionPresentation {
  title: string
  file: string
  description?: string
}

export interface Section {
  title: string
  slug: string
  description?: string
  topics: Topic[]
  videos?: string[]
  notes?: SectionNote[]
  presentations?: SectionPresentation[]
  tests?: string[]
}

export const sections: Section[] = [
  {
    title: 'Лімбічна система й емоційна поведінка',
    slug: 'section-18',
    topics: [],
    videos: ['jrYeu1YfTU8'],
    notes: [
      {
        title: 'Лімбічна система: конспект',
        description: 'Конспект лімбічної системи',
        file: '/pdfs/Лімбічна система.pdf'
      }
    ]
  },
  {
    title: 'Автономна нервова система і її регуляція',
    slug: 'section-20',
    topics: [],
    videos: ['E3uOfpwFbfU'],
    notes: [
      {
        title: 'Автономна нервова система: конспект',
        description: 'Конспект автономної нервової системи',
        file: '/pdfs/Автономна нс.pdf'
      }
    ]
  },
  {
    title: 'Патологічні процеси',
    slug: 'section-21',
    topics: [],
    videos: ['I7kwb7LmzOY'],
    notes: [
      {
        title: 'Патологічні процеси ЦНС і ПНС: конспект',
        description: 'Конспект патологічних процесів ЦНС і ПНС',
        file: '/pdfs/Патологічні процеси ЦНС ПНС.pdf'
      }
    ]
  },
  {
    title: 'Лікарські засоби, що впливають на ЦНС і ПНС',
    slug: 'section-22',
    topics: [],
    videos: ['LpM2-bV6hfw'],
    notes: [
      {
        title: 'Лікарські засоби ЦНС і ПНС: конспект',
        description: 'Конспект лікарських засобів, що впливають на ЦНС і ПНС',
        file: '/pdfs/Лікарські засоби ЦНС ПНС.pdf'
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

