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
    title: 'ВСТУП. Основи знань про органічні сполуки',
    slug: 'vstup-osnovy-znan-pro-orhannichi-spoluky',
    description: 'Будова, номенклатура, ізомерія, хімічні властивості та ідентифікація',
    topics: [],
    videos: ['CToJi7hJiIU'],
    presentations: [
      {
        title: 'ВСТУП. Основи знань про органічні сполуки',
        file: '/pdfs/osnovy/1.Розділ1 ВСТУП Основи знань про органічні сполуки (будова, номенклатура, ізомерія, хімічні властивості та ідентифікація).pdf',
        description: 'Презентація: будова, номенклатура, ізомерія, хімічні властивості та ідентифікація'
      }
    ]
  },
  {
    title: 'Вуглеводні та їх галогенопохідні',
    slug: 'vuhlevodni-ta-yikh-halohhenopokhidni',
    topics: [
      { title: 'Насичені вуглеводні', slug: 'nasyshcheni-vuhlevodni' },
      { title: 'Ненасичені вуглеводні', slug: 'nenasyshcheni-vuhlevodni' },
      { title: 'Ароматичні вуглеводні', slug: 'aromatychni-vuhlevodni' },
      { title: 'Галогенопохідні вуглевод', slug: 'halohhenopokhidni-vuhlevod' }
    ],
    videos: ['Q6JUgFUc6bI'],
    presentations: [
      {
        title: 'Вуглеводні та їх галогенопохідні',
        file: '/pdfs/osnovy/2.ПідрозділВуглеводні та їх галогенопохідні.Тема1,2,3,4. Насич, ненасич аромат..pdf',
        description: 'Презентація: Тема 1, 2, 3, 4 - Насичені, ненасичені, ароматичні вуглеводні'
      }
    ]
  },
  {
    title: 'Нітрогеновмісні органічні сполуки',
    slug: 'nitrohenovmisni-orhannichi-spoluky',
    topics: [
      { title: 'Нітросполуки', slug: 'nitrospoluky' },
      { title: 'Аміни', slug: 'aminy' }
    ],
    videos: ['sD7rzOlDkFs'],
    presentations: [
      {
        title: 'Нітрогеновмісні органічні сполуки',
        file: '/pdfs/osnovy/3.ПідрозділНітрогеновмісні_органічні_сполуки. ТЕМА 5,6 Нітросполуки. АМІНИ.pdf',
        description: 'Презентація: Тема 5, 6 - Нітросполуки, Аміни'
      }
    ]
  },
  {
    title: 'Оксигено- та сульфуровмісні органічні сполуки',
    slug: 'oksyheno-ta-sulfurovmisni-orhannichi-spoluky',
    topics: [
      { title: 'Спирти', slug: 'spyrti' },
      { title: 'Феноли', slug: 'fenoly' },
      { title: 'Карбонові кислоти та сульфокислоти', slug: 'karbonovi-kysloty-ta-sulfokysloty' },
      { title: 'Функціональні похідні карбонових кислот та сульфокислот', slug: 'funktsionalni-pokhidni-karbonovykh-kyslot-ta-sulfokyslot' },
      { title: 'Гетерофункціональні карбонові кислоти: амінокислоти, оксокислоти, гідроксикислоти', slug: 'heterofunktsionalni-karbonovi-kysloty-aminokysloty-oksokysloty-hidroksykysloty' }
    ],
    videos: ['0tFICRybBtk', 'FiQ806HhOSQ'],
    presentations: [
      {
        title: 'Оксигено- та сульфуровмісні органічні сполуки. Частина 1',
        file: '/pdfs/osnovy/4.ПідрозділОксигено_та_сульфуровмісні_органічні_сполуки. ТЕМА7Спирти. 8Феноли. 9Альдегіди. Кетони.pdf',
        description: 'Презентація: Тема 7 - Спирти, Тема 8 - Феноли, Тема 9 - Альдегіди, Кетони'
      },
      {
        title: 'Оксигено- та сульфуровмісні органічні сполуки. Частина 2',
        file: '/pdfs/osnovy/4.Підрозділ.ТЕМА10_Карбонові_кислоти_та_сульфокислоти. 11 Функц.12 Гетерофункц..pdf',
        description: 'Презентація: Тема 10 - Карбонові кислоти та сульфокислоти, Тема 11 - Функціональні похідні, Тема 12 - Гетерофункціональні'
      }
    ]
  },
  {
    title: 'Гетероциклічні сполуки 28,6',
    slug: 'heterotsyklichni-spoluky-28-6',
    topics: [
      { title: 'П\'ятичленні гетероциклічні сполуки з одним гетероатомом: фуран, пірол та їх гідровані аналоги', slug: 'pyatychlenni-heterotsyklichni-spoluky-z-odnym-heteroatomom-furan-pirol-ta-yikh-hidrovani-analohy' },
      { title: 'П\'ятичленні гетероциклічні сполуки з двома гетероатомами: піразол, імідазол, тіазол, оксазол та їх гідровані аналоги', slug: 'pyatychlenni-heterotsyklichni-spoluky-z-dvoma-heteroatomamy-pirazol-imidazol-tiazol-oksazol-ta-yikh-hidrovani-analohy' },
      { title: 'Шестичленні гетероциклічні сполуки з одним гетероатомом: піридин, піперидин', slug: 'shestychlenni-heterotsyklichni-spoluky-z-odnym-heteroatomom-pirydyn-piperydyn' },
      { title: 'Шестичленні гетероциклічні сполуки з двома гетероатомами: піридазин, піримідин, піразин, тіазин та їх гідровані аналоги', slug: 'shestychlenni-heterotsyklichni-spoluky-z-dvoma-heteroatomamy-piradazyn-pirymidyn-pirazyn-tiazyn-ta-yikh-hidrovani-analohy' },
      { title: 'Конденсовані гетероциклічні сполуки: пурин, бензімідазол, індол, хінолін, ізохінолін, фенотіазин', slug: 'kondensovani-heterotsyklichni-spoluky-puryn-benzimidazol-indol-khinolin-izokhinolin-fenotiazyn' }
    ],
    videos: ['aNJRk0vB4a8', 'ERdFDvU6QlQ', 'jYXMwIuOQAY'],
    presentations: [
      {
        title: 'Гетероциклічні сполуки. Частина 1',
        file: '/pdfs/osnovy/5.ПІДРОЗДІЛ_Гетероциклічні_сполуки. Тема12 5-чл з одним, Тема13 5-чл з двума..pdf',
        description: 'Презентація: Тема 12 - П\'ятичленні з одним гетероатомом, Тема 13 - П\'ятичленні з двома гетероатомами'
      },
      {
        title: 'Гетероциклічні сполуки. Частина 2',
        file: '/pdfs/osnovy/5.ПідрозділГетероциклічні. Тема14,15Шестичленні_гетероциклічні_сполуки_з_одним_гетероатомом_піридин.pdf',
        description: 'Презентація: Тема 14, 15 - Шестичленні гетероциклічні сполуки з одним гетероатомом (піридин)'
      },
      {
        title: 'Гетероциклічні сполуки. Частина 3',
        file: '/pdfs/osnovy/5.Підрозділ. Тема16 конденовані гетероциклічні сполуки.pdf',
        description: 'Презентація: Тема 16 - Конденсовані гетероциклічні сполуки'
      }
    ]
  },
  {
    title: 'Вуглеводи',
    slug: 'vuhlevody',
    description: 'моносахариди, ди- та полісахариди',
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

