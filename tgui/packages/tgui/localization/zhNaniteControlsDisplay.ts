// Display-only labels; mode and research category keys remain unchanged.
const labels: Readonly<Record<string, string>> = {
  Off: '关闭',
  Local: '自身',
  Targeted: '指定目标',
  Area: '区域',
  Relay: '中继',
  Utility: '实用',
  Medical: '医疗',
  Augmentation: '强化',
  Defective: '缺陷',
  Weaponized: '武器化',
  Suppression: '抑制',
  Sensor: '传感',
  Protocols: '协议',
};

export const naniteControlsDisplay = (raw: string): string =>
  Object.hasOwn(labels, raw) ? labels[raw] : raw;
