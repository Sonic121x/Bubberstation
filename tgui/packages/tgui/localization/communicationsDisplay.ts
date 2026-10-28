const levels: Record<string, string> = {
  green: '绿色', blue: '蓝色', red: '红色', delta: '德尔塔',
  violet: '紫色', orange: '橙色', amber: '琥珀色', epsilon: '艾普西隆', gamma: '伽马',
};

export const communicationsAlertDisplay = (level: string) => Object.hasOwn(levels, level) ? levels[level] : level;
