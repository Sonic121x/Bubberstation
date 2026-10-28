// Pet states and emote keys are kept intact for icon lookup and trick actions.
const labels: Readonly<Record<string, string>> = {
  hungry: '饥饿',
  asleep: '熟睡',
  happy: '开心',
  neutral: '平静',
  none: '无',
  flip: '翻跟头',
  jump: '跳跃',
  shiver: '颤抖',
  spin: '转圈',
  beep: '哔哔声',
  'No location set': '未设置位置',
};

export const virtualPetDisplay = (raw: string): string =>
  Object.hasOwn(labels, raw) ? labels[raw] : raw;

export const virtualPetOptions = (raw: string[]) =>
  raw.map((value) => ({ value, displayText: virtualPetDisplay(value) }));
