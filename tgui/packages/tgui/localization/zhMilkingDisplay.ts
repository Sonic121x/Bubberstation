const labels: Readonly<Record<string, string>> = {
  off: '关闭',
  low: '低强度',
  medium: '中强度',
  hard: '高强度',
  breasts: '乳房',
  vagina: '阴道',
  testicles: '睾丸',
  'the breasts': '乳房',
  'the vagina': '阴道',
  'the testicles': '睾丸',
};

export function milkingDisplay(raw: string | null | undefined): string { // 自定义修改：空状态或器官显示值不触发字符串转换异常
  if (raw == null) return '';
  const key = raw.toLowerCase();
  return Object.hasOwn(labels, key) ? labels[key] : raw;
}
