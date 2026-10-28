const labels: Record<string, string> = {
  welder: '焊枪',
  translator: '翻译器',
  laser: '激光器',
  multitool: '多功能工具',
  drill: '钻头',
  idle: '待机',
  travel: '航行',
  exploration: '探索',
  adventure: '冒险',
  busy: '忙碌',
};

export const explorationDisplay = (value: string): string => Object.hasOwn(labels, value) ? labels[value] : value;
