const factionNames: Record<string, string> = {
  None: '无',
  neutral: '中立',
  crew: '船员',
  hostile: '敌对',
  mining: '采矿',
  pirate: '海盗',
  spider: '蜘蛛',
  syndicate: '辛迪加',
  wizard: '巫师',
  Custom: '自定义',
};

export const factionDisplay = (value: string) => factionNames[value] || value;

export const factionOptions = (values: string[]) =>
  values.map((value) => ({ value, displayText: factionDisplay(value) }));

const narrateColourNames: Record<string, string> = {
  White: '白色',
  Dark: '深色',
  Red: '红色',
  'Red Bright': '亮红色',
  Velvet: '暗红色',
  Green: '绿色',
  Blue: '蓝色',
  Purple: '紫色',
  'Purple Dark': '深紫色',
  Narsie: '纳尔西',
  Ratvar: '拉特瓦尔',
};

export const narrateColourDisplay = (value: string) =>
  narrateColourNames[value] ?? value;

export const narrateColourOptions = (values: string[]) =>
  values.map((value) => ({ value, displayText: narrateColourDisplay(value) }));
