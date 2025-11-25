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
    title: 'Вуглеводні та їх галогенопохідні',
    slug: 'vuhlevodni-ta-yikh-halohhenopokhidni',
    topics: [
      { title: 'Насичені вуглеводні', slug: 'nasyshcheni-vuhlevodni' },
      { title: 'Ненасичені вуглеводні', slug: 'nenasyshcheni-vuhlevodni' },
      { title: 'Ароматичні вуглеводні', slug: 'aromatychni-vuhlevodni' },
      { title: 'Галогенопохідні вуглевод', slug: 'halohhenopokhidni-vuhlevod' }
    ]
  },
  {
    title: 'Нітрогеновмісні органічні сполуки',
    slug: 'nitrohenovmisni-orhannichi-spoluky',
    topics: [
      { title: 'Нітросполуки', slug: 'nitrospoluky' },
      { title: 'Аміни', slug: 'aminy' }
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

