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
    title: 'Нормальний розвиток і структура, вікові зміни',
    slug: 'normalnij-rozvitok-i-struktura-vikovi-zmini-33',
    sectionNumberLabel: '33',
    topics: [],
    videos: ['8TcHVrzErio'],
    notes: [
      {
        title: 'Конспект',
        description: 'Нормальний розвиток і структура, вікові зміни',
        file: '/pdfs/Сечова система .pdf.pdf'
      }
    ]
  },
  {
    title: 'Сечова система патологія',
    slug: 'sechova-systema-patologiya',
    sectionNumberLabel: '34',
    topics: [],
    videos: ['6fizTF84ETc'],
    notes: [
      {
        title: 'Сечова система: конспект',
        description: 'Конспект сечової системи',
        file: '/pdfs/Сечова система.pdf'
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
