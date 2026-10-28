import { TabBay, TabDrop, TabPod } from './Tabs';
import type { PodDelay, PodEffect } from './types';

export const POD_GREY = {
  color: 'grey',
} as const;

export const TABPAGES = [
  {
    title: '查看空投舱',
    component: TabPod,
  },
  {
    title: '查看装载区',
    component: TabBay,
  },
  {
    title: '查看卸货地点',
    component: TabDrop,
  },
] as const;

type Option = {
  title: string;
  key?: string;
  icon?: string;
};

export const REVERSE_OPTIONS: Option[] = [
  {
    title: '生物', key: 'Mobs',
    icon: 'user',
  },
  {
    title: '未固定\n物体',
    key: 'Unanchored',
    icon: 'cube',
  },
  {
    title: '已固定\n物体',
    key: 'Anchored',
    icon: 'anchor',
  },
  {
    title: '地板下物体',
    key: 'Underfloor',
    icon: 'eye-slash',
  },
  {
    title: '壁挂物体',
    key: 'Wallmounted',
    icon: 'link',
  },
  {
    title: '地板', key: 'Floors',
    icon: 'border-all',
  },
  {
    title: '墙壁', key: 'Walls',
    icon: 'square',
  },
  {
    title: '机甲',
    key: 'Mecha',
    icon: 'truck',
  },
];

export const DELAYS: PodDelay[] = [
  {
    title: '抵达前',
    tooltip: '空投舱抵达空间站所需的时间',
  },
  {
    title: '下落',
    tooltip: '空投舱下落\n动画的时长',
  },
  {
    title: '开启',
    tooltip: '空投舱着陆后到开启所需的时间',
  },
  {
    title: '离开',
    tooltip: '空投舱开启后\n到离开所需的时间',
  },
];

export const REV_DELAYS: PodDelay[] = [
  {
    title: '抵达前',
    tooltip: '空投舱出现在卸货地点上方所需的时间',
  },
  {
    title: '下落',
    tooltip: '空投舱下落\n动画的时长',
  },
  {
    title: '开启',
    tooltip: '空投舱着陆后到开启所需的时间',
  },
  {
    title: '离开',
    tooltip: '空投舱开启后\n到离开所需的时间',
  },
];

export const SOUNDS = [
  {
    title: '下落',
    act: 'fallingSound',
    tooltip: '下落时播放，着陆时结束',
  },
  {
    title: '着陆',
    act: 'landingSound',
    tooltip: '空投舱着陆后播放',
  },
  {
    title: '开启',
    act: 'openingSound',
    tooltip: '空投舱开启时播放',
  },
  {
    title: '离开',
    act: 'leavingSound',
    tooltip: '空投舱离开时播放',
  },
];

export const BAYS = [
  { title: '1' },
  { title: '2' },
  { title: '3' },
  { title: '4' },
  { title: 'ERT' },
] as const;

export const EFFECTS_LOAD: PodEffect[] = [
  {
    act: 'launchAll',
    choiceNumber: 0,
    icon: 'globe',
    selected: 'launchChoice',
    title: '投送所有地格',
  },
  {
    act: 'launchOrdered',
    choiceNumber: 1,
    icon: 'sort-amount-down-alt',
    selected: 'launchChoice',
    title: '依次投送地格',
  },
  {
    act: 'launchRandomTurf',
    choiceNumber: 2,
    icon: 'dice',
    selected: 'launchChoice',
    title: '随机选择地格',
  },
  {
    divider: true,
  },
  {
    act: 'launchWholeTurf',
    choiceNumber: 0,
    icon: 'expand',
    selected: 'launchRandomItem',
    title: '投送整个地格的内容',
  },
  {
    act: 'launchRandomItem',
    choiceNumber: 1,
    icon: 'dice',
    selected: 'launchRandomItem',
    title: '随机选择物品',
  },
  {
    divider: true,
  },
  {
    act: 'launchClone',
    icon: 'clone',
    soloSelected: 'launchClone',
    title: '复制',
  },
];

export const EFFECTS_NORMAL: PodEffect[] = [
  {
    act: 'effectTarget',
    icon: 'user-check',
    soloSelected: 'effectTarget',
    title: '指定目标',
  },
  {
    act: 'effectBluespace',
    choiceNumber: 0,
    icon: 'hand-paper',
    selected: 'effectBluespace',
    title: '空投舱留在原地',
  },
  {
    act: 'effectStealth',
    icon: 'user-ninja',
    soloSelected: 'effectStealth',
    title: '隐蔽',
  },
  {
    act: 'effectQuiet',
    icon: 'volume-mute',
    soloSelected: 'effectQuiet',
    title: '静音',
  },
  {
    act: 'effectMissile',
    icon: 'rocket',
    soloSelected: 'effectMissile',
    title: '导弹模式',
  },
  {
    act: 'effectBurst',
    icon: 'certificate',
    soloSelected: 'effectBurst',
    title: '连发',
  },
  {
    act: 'effectCircle',
    icon: 'ruler-combined',
    soloSelected: 'effectCircle',
    title: '任意下降角度',
  },
  {
    act: 'effectAnnounce',
    choiceNumber: 0,
    icon: 'ghost',
    selected: 'effectAnnounce',
    title: '不通知幽灵\n（如果你不想\n给无聊的幽灵找乐子）',
  },
];

export const EFFECTS_HARM: PodEffect[] = [
  {
    act: 'create_sparks',
    choiceNumber: 1,
    icon: 'certificate',
    selected: 'create_sparks',
    title: '产生火花；空气中有等离子体时可能引发火灾',
  },
  {
    divider: true,
  },
  {
    act: 'explosionCustom',
    choiceNumber: 1,
    icon: 'bomb',
    selected: 'explosionChoice',
    title: '自定义爆炸',
  },
  {
    act: 'explosionBus',
    choiceNumber: 2,
    icon: 'bomb',
    selected: 'explosionChoice',
    title: '管理员特大爆炸\n他们还能怎么办，封禁你吗？',
  },
  {
    divider: true,
  },
  {
    act: 'damageCustom',
    choiceNumber: 1,
    icon: 'skull',
    selected: 'damageChoice',
    title: '自定义伤害',
  },
  {
    act: 'damageGib',
    choiceNumber: 2,
    icon: 'skull-crossbones',
    selected: 'damageChoice',
    title: '炸成碎块',
  },
  {
    divider: true,
  },
  {
    act: 'effectShrapnel',
    details: true,
    icon: 'cloud-meatball',
    soloSelected: 'effectShrapnel',
    title: '弹幕',
  },
  {
    act: 'effectStun',
    icon: 'sun',
    soloSelected: 'effectStun',
    title: '眩晕',
  },
  {
    act: 'effectLimb',
    icon: 'socks',
    soloSelected: 'effectLimb',
    title: '断肢',
  },
  {
    act: 'effectOrgans',
    icon: 'book-dead',
    soloSelected: 'effectOrgans',
    title: '抛出器官',
  },
];

type Effect = {
  list: typeof EFFECTS_LOAD | typeof EFFECTS_NORMAL | typeof EFFECTS_HARM;
  label: string;
  alt_label?: string;
  tooltipPosition: string;
};

export const EFFECTS_ALL: Effect[] = [
  {
    list: EFFECTS_LOAD,
    label: '装载来源',
    alt_label: '装载',
    tooltipPosition: 'right',
  },
  {
    list: EFFECTS_NORMAL,
    label: '普通效果',
    tooltipPosition: 'bottom',
  },
  {
    list: EFFECTS_HARM,
    label: '伤害效果',
    tooltipPosition: 'bottom',
  },
];
