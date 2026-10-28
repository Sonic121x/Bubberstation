const labels: Record<string, string> = {
  'SYSTEM READY': '系统就绪',
  '! SYSTEM PREFIRING !': '！系统预备开火！',
  'SYSTEM FIRING': '系统正在开火',
  'SYSTEM RELOADING': '系统正在重新装填',
  'SYSTEM POWER LOW': '系统电量不足',
  'SYSTEM CHARGING CAPACITORS': '系统正在为电容器充电',
  blue: '蓝色',
  brown: '棕色',
  crimson: '绯红色',
  cyan: '青色',
  gold: '金色',
  green: '绿色',
  grey: '灰色',
  lime: '黄绿色',
  magenta: '品红色',
  orange: '橙色',
  pink: '粉色',
  purple: '紫色',
  red: '红色',
  silver: '银色',
  violet: '紫罗兰色',
  white: '白色',
  yellow: '黄色',
  black: '黑色',
  'dim grey': '暗灰色',
  'light grey': '浅灰色',
};

export function machineStatusDisplay(value: string): string {
  return labels[value] ?? value;
}
