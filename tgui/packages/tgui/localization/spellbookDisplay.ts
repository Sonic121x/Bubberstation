const labels: Record<string, string> = {
  'Enscribed Name': '铭刻姓名',
  'Table of Contents': '目录',
  Offensive: '攻击',
  Defensive: '防御',
  Mobility: '机动',
  Assistance: '援助',
  Challenges: '挑战',
  Rituals: '仪式',
  Loadouts: '配装',
  Randomize: '随机配装',
  Perks: '特长',
  Learn: '学习',
  Summon: '召唤',
  Cast: '施放',
};

export const spellbookDisplay = (value: string) => labels[value] ?? value;
