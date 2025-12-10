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
    title: 'Нормальний розвиток і структура, вікові зміни',
    slug: 'section-18',
    topics: [],
    notes: [
      {
        title: 'Нормальний розвиток і структура, вікові зміни: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-18-conspect.pdf'
      }
    ]
  },
  {
    title: 'Лімбічна система й емоційна поведінка',
    slug: 'section-19',
    topics: [],
    notes: [
      {
        title: 'Лімбічна система й емоційна поведінка: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-19-conspect.pdf'
      }
    ]
  },
  {
    title: 'Автономна нервова система і її регуляція',
    slug: 'section-20',
    topics: [],
    notes: [
      {
        title: 'Автономна нервова система і її регуляція: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-20-conspect.pdf'
      }
    ]
  },
  {
    title: 'Лікарські засоби, що впливають на ЦНС і ПНС',
    slug: 'section-21',
    topics: [],
    notes: [
      {
        title: 'Лікарські засоби, що впливають на ЦНС і ПНС: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-21-conspect.pdf'
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

