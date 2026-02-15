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
    title: 'Нормальний розвиток і структура, вікові зміни. Фізіологічні, метаболічні і регуляторні процеси в нормі',
    slug: 'normalnij-rozvitok-i-struktura',
    topics: [],
    videos: ['OG4JMFiB1sk'],
    notes: [
      {
        title: 'Дихальна система: конспект',
        description: 'Конспект дихальної системи',
        file: '/pdfs/Дихальна система .pdf.pdf.pdf'
      }
    ]
  },
  {
    title: 'Патологічні процеси дихальної системи',
    slug: 'patologichni-procesi-dyhalnoji-sistemi',
    topics: [],
    videos: ['z8vmczDhfNQ'],
    notes: [
      {
        title: 'Патологічні процеси дихальної системи: конспект',
        description: 'Конспект патологічних процесів дихальної системи',
        file: '/pdfs/Патологічні_процеси_Дихальної_сист.pdf'
      }
    ]
  },
  {
    title: 'Лікарські засоби які впливають на дихальну систему',
    slug: 'likarski-zasobi-dyhalna-systema',
    topics: [],
    videos: ['-LlBpT1Rwkk'],
    notes: [
      {
        title: 'Лікарські засоби дихальної системи: конспект',
        description: 'Конспект лікарських засобів, що впливають на дихальну систему',
        file: '/pdfs/Лікарські_засоби_Дихальна_система.pdf'
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
