const labels: Record<string, string> = {
  blue: '蓝色', brown: '棕色', crimson: '绯红色', cyan: '青色',
  gold: '金色', green: '绿色', grey: '灰色', lime: '亮绿色',
  magenta: '品红色', orange: '橙色', pink: '粉色', purple: '紫色',
  red: '红色', silver: '银色', violet: '紫罗兰色', white: '白色',
  yellow: '黄色', 'dim grey': '暗灰色', 'light grey': '浅灰色',
};

export const wireDisplay = (value: string) => labels[value] ?? value;
