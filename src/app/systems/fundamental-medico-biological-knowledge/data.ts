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
    title: 'Молекулярні механізми реалізації генетичної інформації',
    slug: 'section-1',
    topics: [
      { title: 'структура і реплікація ДНК', slug: 'struktura-i-replikatsiya-dnk' },
      { title: 'експресія генів: транскрипція', slug: 'ekspresiya-geniv-transkriptsiya' },
      { title: 'експресія генів: трансляція', slug: 'ekspresiya-geniv-translyatsiya' },
      { title: 'структура і функції протеїнів', slug: 'struktura-i-funktsiyi-proteiniv' }
    ],
    videos: ['1134678461', '1137477282'],
    notes: [
      {
        title: 'Молекулярні механізми: конспект 1',
        description: 'Повна версія конспекту від HelpKrok',
        file: '/pdfs/section-1-conspect-1.pdf'
      },
      {
        title: 'Молекулярні механізми: конспект 2',
        description: 'Альтернативна редакція конспекту',
        file: '/pdfs/section-1-conspect-2.pdf'
      }
    ]
  },
  {
    title: 'Метаболізм основних класів біомолекул',
    slug: 'section-2',
    topics: [],
    notes: [
      {
        title: 'Метаболізм: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-2-conspect.pdf'
      }
    ]
  },
  {
    title: 'Біологія клітин',
    slug: 'section-3',
    topics: [],
    videos: ['1142516421'],
    notes: [
      {
        title: 'Біологія клітин: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-3-conspect.pdf'
      },
      {
        title: 'Біологія клітин: конспект 2',
        description: 'Конспект біології клітин',
        file: '/pdfs/section-3-conspect-2.pdf'
      }
    ]
  },
  {
    title: 'Розвиток людини й основи генетики',
    slug: 'section-4',
    topics: [],
    notes: [
      {
        title: 'Розвиток людини й основи генетики: конспект 1',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-4-conspect-1.pdf'
      },
      {
        title: 'Розвиток людини й основи генетики: конспект 2',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-4-conspect-2.pdf'
      }
    ]
  },
  {
    title: 'Основні патологічні процеси',
    slug: 'section-5',
    topics: [],
    notes: [
      {
        title: 'Основні патологічні процеси: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-5-conspect.pdf'
      }
    ]
  },
  {
    title: 'Клітинні процеси адаптації і компенсації',
    slug: 'section-6',
    topics: [],
    notes: [
      {
        title: 'Клітинні процеси адаптації і компенсації: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-6-conspect.pdf'
      }
    ]
  },
  {
    title: 'Запалення',
    slug: 'section-7',
    topics: [],
    notes: [
      {
        title: 'Запалення: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-7-conspect.pdf'
      }
    ]
  },
  {
    title: 'Новоутвореня',
    slug: 'section-8',
    topics: [],
    notes: [
      {
        title: 'Новоутвореня: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-8-conspect.pdf'
      }
    ]
  },
  {
    title: 'Температурний гомеостаз і його порушення/ Гіпоксія/ Порушення метаболізму',
    slug: 'section-9',
    topics: [],
    notes: [
      {
        title: 'Температурний гомеостаз: конспект 1',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-9-conspect-1.pdf'
      },
      {
        title: 'Температурний гомеостаз: конспект 2',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-9-conspect-2.pdf'
      }
    ]
  },
  {
    title: 'Мультисистемні процеси',
    slug: 'section-10',
    topics: [],
    notes: [
      {
        title: 'Мультисистемні процеси: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-10-conspect.pdf'
      }
    ]
  },
  {
    title: 'Мікробіологічні основи діагностики, профілактики, лікування інфекційних хвороб',
    slug: 'section-11',
    topics: [],
    notes: [
      {
        title: 'Мікробіологічні основи: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-11-conspect.pdf'
      }
    ]
  },
  {
    title: 'Гриби і захворювання, спричинені грибами/паразити',
    slug: 'section-12',
    topics: [],
    notes: [
      {
        title: 'Гриби і захворювання: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-12-conspect.pdf'
      }
    ]
  },
  {
    title: 'Імунна система, види імунітету, імунні реакції організму',
    slug: 'section-13',
    topics: [],
    notes: [
      {
        title: 'Імунна система: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/section-13-conspect.pdf'
      }
    ]
  },
  {
    title: 'Імунопатологія',
    slug: 'section-14',
    topics: []
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

