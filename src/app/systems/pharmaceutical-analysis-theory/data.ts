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
    title: 'Фазова рівновага',
    slug: 'fazova-rivnovaga',
    topics: [],
    notes: [
      {
        title: 'Фазова рівновага: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/PDF-файл.pdf'
      }
    ]
  },
  {
    title: 'Якісний аналіз. Реакції ідентифікації іонів',
    slug: 'yakisniy-analiz-reaktsiyi-identifikatsiyi-ioniv',
    topics: [],
    videos: ['1144978763', '1144979768', '1144990679'],
    notes: [
      {
        title: 'Якісний аналіз. Реакції ідентифікації іонів: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/yakisniy-analiz-reaktsiyi-identifikatsiyi-ioniv.pdf'
      },
      {
        title: 'Реакції катіонів II-VI аналітичних груп: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/roz-dil-teoretichni-osnovi-farmatsevtichnogo-analizu.pdf'
      },
      {
        title: 'Теорія та практика аналізу катіонів: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/teoret-osn-sintezu-yakisni-kationi.pdf'
      }
    ]
  },
  {
    title: 'Методи кількісного хімічного аналізу',
    slug: 'metodi-kil-kisnogo-himichnogo-analizu',
    topics: [],
    videos: ['1144992161', '1145230055', 'driUJSmcW18'],
    notes: [
      {
        title: 'Титриметричний метод аналізу: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/kilkisni-titrimetriya.pdf'
      },
      {
        title: 'Гравіметричний аналіз: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/metodi-kil-kisnogo-himichnogo-analizu.pdf'
      }
    ]
  },
  {
    title: 'Інструментальні методи дослідження',
    slug: 'instrumentalni-metodi-doslidzhennya',
    topics: [],
    videos: ['Re3RS_0FNBg', 'QKXZRLSwlck', 'BlUqF8f5AHQ'],
    notes: [
      {
        title: 'Оптичні методи аналізу: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/instrumentalni-metodi-optichni.pdf'
      },
      {
        title: 'Потенціометричні методи аналізу: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/instrumentalni-potentsiometriya.pdf'
      },
      {
        title: 'Хроматографічні методи аналізу: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/instrumentalni-hromatografiya.pdf'
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

