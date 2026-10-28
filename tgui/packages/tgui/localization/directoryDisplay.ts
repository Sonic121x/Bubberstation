import { chineseDisplay } from './zhDisplay';

const labels: Record<string, string> = {
  Unset: '未设置', 'Check OOC': '查看场外说明',
  'Check OOC Notes': '查看场外备注', 'Ask (L)OOC': '通过场外频道询问',
  Yes: '是', No: '否', Maybe: '也许', 'No ERP': '不进行成人角色扮演',
  Straight: '异性恋', Lesbian: '女同性恋', Gay: '男同性恋',
  Bisexual: '双性恋', Pansexual: '泛性恋', Polysexual: '多性恋',
  Asexual: '无性恋', Aromantic: '无浪漫倾向', 'Aro/Ace': '无浪漫／无性恋',
  Skoliosexual: '非二元性别吸引倾向', Omnisexual: '全性恋',
  Male: '男性', Female: '女性', Nonbinary: '非二元性别',
  Genderfluid: '流动性别', Trans: '跨性别', Transmasc: '跨男性',
  Transfem: '跨女性', Andromorph: '男性形态', Gynomorph: '女性形态',
  Agender: '无性别', Plural: '多重身份', Omnigender: '全性别',
  'Top - Dom': '主动方－支配', 'Top - Switch': '主动方－可切换',
  'Top - Sub': '主动方－顺从', 'Bottom - Dom': '接受方－支配',
  'Bottom - Switch': '接受方－可切换', 'Bottom - Sub': '接受方－顺从',
  'Verse - Dom': '双方皆可－支配', 'Verse - Switch': '双方皆可－可切换',
  'Verse - Sub': '双方皆可－顺从', 'Verse-Top - Dom': '偏主动方－支配',
  'Verse-Top - Switch': '偏主动方－可切换', 'Verse-Top - Sub': '偏主动方－顺从',
  'Verse-Bottom - Dom': '偏接受方－支配', 'Verse-Bottom - Switch': '偏接受方－可切换',
  'Verse-Bottom - Sub': '偏接受方－顺从',
};

export const directoryDisplay = (value: string) => labels[value] ?? chineseDisplay(value);
