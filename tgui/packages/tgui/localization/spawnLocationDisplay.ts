const labels: Record<string, string> = {
  'Current location': '当前位置',
  'Current location (droppod)': '当前位置（空投舱）',
  "In own mob's hand": '自己角色的手中',
  'At a marked object': '标记物体的位置',
  'In the marked object': '标记物体内部',
  'Targeted location': '指定位置',
  'Targeted location (droppod)': '指定位置（空投舱）',
  "In targeted mob's hand": '指定角色的手中',
};

export const spawnLocationDisplay = (value: string): string => labels[value] ?? value;
