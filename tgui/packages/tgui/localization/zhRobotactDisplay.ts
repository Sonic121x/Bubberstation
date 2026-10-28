// Diagnostic protocol values are translated only when displayed.
const labels: Readonly<Record<string, string>> = {
  ACTIVE: '已启用',
  DISABLED: '已禁用',
  ENABLED: '已启用',
  LOCKED: '已锁定',
  UNLOCKED: '已解锁',
  FAULT: '故障',
  NOMINAL: '正常',
  CONNECTED: '已连接',
  READY: '就绪',
};

export const robotactDisplay = (raw: string): string =>
  Object.hasOwn(labels, raw) ? labels[raw] : raw;
