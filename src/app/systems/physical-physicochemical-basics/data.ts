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
    videos: ['M5JFasR5rzI', 'hdF-6mz6LBk'],
    notes: [
      {
        title: 'Фазова рівновага: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/fazova-rivnovaga.pdf'
      },
      {
        title: 'Екстракція',
        description: 'Конспект з екстракції',
        file: '/pdfs/3/р10.pdf'
      }
    ]
  },
  {
    title: 'Колігативні властивості розчинів',
    slug: 'koligativni-vlastyvosti-rozchyniv',
    topics: [],
    videos: ['MOthfEHsjMc'],
    notes: [
      {
        title: 'Колігативні властивості розчинів: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р11.pdf'
      }
    ]
  },
  {
    title: 'Властивості розчинів електролітів',
    slug: 'vlastyvosti-rozchyniv-elektrolitiv',
    topics: [],
    videos: ['HQVL8WU_qec'],
    notes: [
      {
        title: 'Властивості розчинів електролітів: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р12.pdf'
      }
    ]
  },
  {
    title: 'Хімічна кінетика',
    slug: 'himichna-kinetyka',
    topics: [],
    videos: ['ATeHazjDEFs'],
    notes: [
      {
        title: 'Хімічна кінетика: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р13.pdf'
      }
    ]
  },
  {
    title: 'Поверхневий натяг розчинів',
    slug: 'poverhneviy-natyah-rozchyniv',
    topics: [],
    videos: ['h8VeFpvq5UE'],
    notes: [
      {
        title: 'Поверхневий натяг розчинів: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р14.pdf'
      }
    ]
  },
  {
    title: 'Адсорбція поверхнево активних речовин рідиною',
    slug: 'adsorbtsiya-poverhnevo-aktivnyh-rechovin-ridinoyu',
    topics: [],
    videos: ['4fUTafYlHug'],
    notes: [
      {
        title: 'Адсорбція поверхнево активних речовин рідиною: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р15 2.pdf'
      },
      {
        title: 'Адсорбція поверхнево активних речовин рідиною: конспект 2',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р15.pdf'
      }
    ]
  },
  {
    title: 'Адсорбція на твердих адсорбентах',
    slug: 'adsorbtsiya-na-tverdih-adsorbentah',
    topics: [],
    videos: ['4w_3rFIBefk'],
    notes: [
      {
        title: 'Адсорбція на твердих адсорбентах: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р16.pdf'
      }
    ]
  },
  {
    title: 'Загальна характеристика дисперсних систем',
    slug: 'zagalna-harakteristika-dispersnyh-system',
    topics: [],
    videos: ['5wDrnIlscXI'],
    notes: []
  },
  {
    title: 'Молекулярно-кінетичні та оптичні властивості дисперсних систем',
    slug: 'molekulyarno-kinetychni-ta-optichni-vlastyvosti-dispersnyh-system',
    topics: [],
    videos: ['fD3w2CQxxlU'],
    notes: []
  },
  {
    title: 'Електрокінетичні явища Коагуляція',
    slug: 'elektrokinetychni-yavishcha-koagulyatsiya',
    topics: [],
    videos: ['NgkFHU_NPog'],
    notes: [
      {
        title: 'Термічний аналіз',
        description: 'Конспект з термічного аналізу',
        file: '/pdfs/3/р10 2.pdf'
      }
    ]
  },
  {
    title: 'Грубодисперсні системи',
    slug: 'hrubodispersni-systemy',
    topics: [],
    videos: ['ZnqyFBJskMM'],
    notes: []
  },
  {
    title: 'Властивості високомолекулярних сполук Гелі',
    slug: 'vlastyvosti-visokomolekulyarnyh-spoluk-heli',
    topics: [],
    videos: ['2r8ChNWhsH4'],
    notes: [
      {
        title: 'Властивості високомолекулярних сполук Гелі: конспект',
        description: 'Конспект від HelpKrok',
        file: '/pdfs/3/р21.pdf'
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

