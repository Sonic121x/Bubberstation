const labels: Record<string, string> = {
  Dark: '黑暗', Hellish: '地狱', Fallen: '堕落', Fiery: '烈焰',
  Sinful: '罪恶', Blood: '鲜血', Fluffy: '毛茸茸',
  Lord: '领主', Prelate: '教长', Count: '伯爵', Viscount: '子爵',
  Vizier: '维齐尔', Elder: '长老', Adept: '行家',
  'the Red': '赤红者', 'the Soulless': '无魂者', 'the Master': '主宰',
  'the Lord of all things': '万物之主', 'Jr.': '小辈',
};

export const codexGigasDisplay = (value: string): string =>
  labels[value] ? `${labels[value]}（${value}）` : value;
