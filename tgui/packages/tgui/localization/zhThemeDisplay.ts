// Theme identifiers remain unchanged for rendering and saved preferences.
const labels: Readonly<Record<string, string>> = {
  abductor: '绑架者',
  cardtable: '牌桌',
  hackerman: '黑客',
  malfunction: '故障',
  default: '默认',
  ntos: '纳米传讯操作系统',
  ntos_darkmode: '纳米传讯操作系统（深色）',
  ntOS95: '纳米传讯操作系统 95',
  ntos_synth: '纳米传讯操作系统（合成波）',
  ntos_terminal: '纳米传讯操作系统（终端）',
  wizard: '巫师',
};

export const themeDisplay = (raw: string): string =>
  Object.hasOwn(labels, raw) ? labels[raw] : raw;

export const themeOptions = (raw: string[]) =>
  raw.map((value) => ({ value, displayText: themeDisplay(value) }));
