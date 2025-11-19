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
    title: 'Біохімія крові',
    slug: 'biohimiya-krovi',
    topics: [],
    notes: [
      {
        title: 'Біохімія крові: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/blood-biochemistry-conspect.pdf'
      }
    ]
  },
  {
    title: 'Нормальний розвиток і структура, вікові зміни',
    slug: 'normalnij-rozvitok-i-struktura',
    topics: []
  },
  {
    title: 'Центральна нервова система (ЦНС) і периферична нервова система (ПНС). Органи чуття',
    slug: 'tsns-ta-pns-organi-chuttya',
    topics: [],
    notes: [
      {
        title: 'Патологічні процеси: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/blood-pathological-processes-conspect.pdf'
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

