const labels: Record<string, string> = {
  pills: '药丸',
  patches: '贴片',
  bottles: '药瓶',
  vials: '试剂瓶',
  hypos: '注射瓶',
  'pen injectors': '注射笔',
  darts: '飞镖',
  tubes: '软管',
  condiments: '调味品',
};

export const chemPackagingDisplay = (value: string): string =>
  labels[value.toLowerCase()] ?? value;
