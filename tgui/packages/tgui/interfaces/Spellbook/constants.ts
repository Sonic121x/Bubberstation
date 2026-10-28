import { EnscribedName } from './EnscribedName';
import { Loadouts } from './Loadouts';
import { Randomize } from './Randomize';
import { TableOfContents } from './TableOfContents';
import type { TabType } from './types';

export const TAB2NAME: TabType[] = [
  {
    title: 'Enscribed Name',
    blurb:
      '本书只听命于它的主人——当然，它必须有一位主人。法术书与主人之间的契约永久有效，确保这件强大的神器不会落入敌手，也不会被用于交换法术等违反巫师联邦规定的行为。',
    component: EnscribedName,
  },
  {
    title: 'Table of Contents',
    component: TableOfContents,
  },
  {
    title: 'Offensive',
    blurb: '用于削弱与毁灭的法术和物品。',
    scrollable: true,
  },
  {
    title: 'Defensive',
    blurb:
      '用于提高生存能力或削弱敌人攻击能力的法术和物品。',
    scrollable: true,
  },
  {
    title: 'Mobility',
    blurb:
      '用于提高移动能力的法术和物品。建议至少选取一种。',
    scrollable: true,
  },
  {
    title: 'Assistance',
    blurb:
      '用于召来外援，或强化其他物品与能力的法术和物品。',
    scrollable: true,
  },
  {
    title: 'Challenges',
    blurb:
      '巫师联邦期待你展现力量。武装空间站来对抗自己会增加危险，但也能为法术书增加充能。',
    locked: true,
    scrollable: true,
  },
  {
    title: 'Rituals',
    blurb:
      '这些强大的法术能够改变现实的根基，但结果未必对你有利。',
    scrollable: true,
  },
  {
    title: 'Loadouts',
    blurb:
      '巫师联邦承认，有时做出选择并不容易。你可以在此选用经过认可的巫师配装。',
    component: Loadouts,
  },
  {
    title: 'Randomize',
    blurb:
      '如果你不喜欢现有的配装，也可以拥抱混沌。不建议新手巫师使用。',
    component: Randomize,
  },
  {
    title: 'Perks',
    blurb:
      '特长是从宇宙各处收集的身心强化效果，有的实用，有的则不那么实用。',
    scrollable: true,
  },
  {
    title: 'Table of Contents',
    component: TableOfContents,
  },
];

export const BUYWORD2ICON = {
  Learn: 'plus',
  Summon: 'hat-wizard',
  Cast: 'meteor',
};
