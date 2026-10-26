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
