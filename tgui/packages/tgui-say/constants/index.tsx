/** Radio channels */
export const CHANNELS = [
  'Say',
  'Radio',
  'Me',
  'Whis', // SKYRAT EDIT ADDITION - CUSTOMIZATION
  'LOOC', // SKYRAT EDIT ADDITION - CUSTOMIZATION
  'OOC',
  'Admin',
] as const;

/** Window sizes in pixels */
export enum WINDOW_SIZES {
  small = 30,
  medium = 50,
  large = 70,
  width = 231,
}

/** Line lengths for autoexpand */
export enum LINE_LENGTHS {
  small = 20,
  medium = 35,
}

/**
 * Radio prefixes.
 * Contains the properties:
 * id - string. css class identifier.
 * label - string. button label.
 */
export const RADIO_PREFIXES = {
  ':a ': {
    id: 'hive',
    label: '蜂巢',
  },
  ':b ': {
    id: 'binary',
    label: '0101',
  },
  ':c ': {
    id: 'command',
    label: '指挥',
  },
  ':e ': {
    id: 'engi',
    label: '工程',
  },
  ':m ': {
    id: 'medical',
    label: '医疗',
  },
  ':n ': {
    id: 'science',
    label: '科研',
  },
  ':o ': {
    id: 'ai',
    label: '人工智能',
  },
  ':s ': {
    id: 'security',
    label: '安保',
  },
  ':t ': {
    id: 'syndicate',
    label: '辛迪加',
  },
  ':u ': {
    id: 'supply',
    label: '货运',
  },
  ':v ': {
    id: 'service',
    label: '服务',
  },
  ':y ': {
    id: 'centcom',
    label: '中央指挥部',
  },
} as const;
