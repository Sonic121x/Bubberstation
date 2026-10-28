const labels: Readonly<Record<string, string>> = {
  command: '指挥部',
  engineering: '工程部',
  medical: '医疗部',
  security: '安保部',
  science: '科研部',
  cargo: '货运部',
  service: '服务部',
  civilian: '民事部门',
  centcom: '中央指挥部',
  'central command': '中央指挥部',
  supply: '补给部',
  silicon: '硅基单位',
  mining: '采矿部',
  unknown: '未知',
  green: '绿色',
  blue: '蓝色',
  red: '红色',
  delta: '德尔塔',
  violet: '紫色',
  orange: '橙色',
  amber: '琥珀色',
  epsilon: '艾普西隆',
};

export function jobSelectionDisplay(raw: string): string {
  const key = raw.toLowerCase();
  return Object.hasOwn(labels, key) ? labels[key] : raw;
}
