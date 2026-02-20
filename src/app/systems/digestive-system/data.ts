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
  /** Якщо задано, показується замість baseSectionNumber + index (наприклад "31+32") */
  sectionNumberLabel?: string
}

export const sections: Section[] = [
  {
    title: 'Нормальний розвиток і структура, вікові зміни. Фізіологічні, метаболічні і регуляторні процеси в нормі',
    slug: 'normalnij-rozvitok-i-struktura-travna-systema',
    topics: [],
    videos: ['9D8I1h0T02o'],
    notes: [
      {
        title: 'Травна система: конспект',
        description: 'Конспект травної системи',
        file: '/pdfs/травна.pdf'
      }
    ]
  },
  {
    title: 'Патологічні процеси',
    slug: 'patologichni-procesy-travna-systema',
    sectionNumberLabel: '31+32',
    topics: [],
    videos: ['IrG0ujphGDQ'],
    notes: [
      {
        title: 'Патологічні процеси: конспект',
        description: 'Конспект патологічних процесів травної системи',
        file: '/pdfs/Патологічні процесии2.pdf'
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
