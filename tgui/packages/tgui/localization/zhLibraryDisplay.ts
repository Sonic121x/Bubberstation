const actions: Readonly<Record<string, string>> = {
  delete: '删除',
  restore: '恢复',
  deleted: '已删除',
  undeleted: '已恢复',
};

export function libraryActionDisplay(raw: string): string {
  return Object.hasOwn(actions, raw) ? actions[raw] : raw;
}
