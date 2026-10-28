import { chineseDisplay } from './zhDisplay';

const labels: Record<string, string> = {
  Airlocks: '气闸',
  'Airlock Access': '气闸权限',
  Machines: '机器',
  Windoors: '玻璃门',
  'Glass Airlocks': '玻璃气闸',
  'Solid Airlocks': '实体气闸',
  'Plastic Grass Patch': '塑料草丛',
  'Plastic Brown Grass': '塑料枯草',
  'Plastic Jungle Grass': '塑料丛林草',
  'Plastic Jungle Grass B': '塑料丛林草B型',
  'Plastic Bush': '塑料灌木',
  'Plastic Reeds': '塑料芦苇',
  'Plastic Leafy Bush': '塑料阔叶灌木',
  'Plastic Pale Bush': '塑料浅色灌木',
  'Plastic Stalky Bush': '塑料长茎灌木',
  'Plastic Grassy Bush': '塑料草状灌木',
  'Plastic Sparse Grass': '塑料稀疏草丛',
  'Plastic Full Grass': '塑料茂密草丛',
  'Plastic Ferny Bush': '塑料蕨类灌木',
  'Plastic Sunny Bush': '塑料向阳灌木',
  'Plastic Generic Bush': '塑料普通灌木',
  'Plastic Pointy Bush': '塑料尖叶灌木',
  'Plastic Lavender Grass': '塑料薰衣草',
  'Plastic Yellow-White Flowers': '塑料黄白花',
  'Plastic Blue-Red Flowers': '塑料蓝红花',
  'Plastic Purple Flowers': '塑料紫花',
  'Plastic Snowy Bush': '塑料覆雪灌木',
  'Plastic Jungle Bush': '塑料丛林灌木',
  'Plastic Jungle Bush B': '塑料丛林灌木B型',
  'Plastic Jungle Bush C': '塑料丛林灌木C型',
  'Large Plastic Bush': '大型塑料灌木',
  'Plastic Rock': '塑料岩石',
  'Plastic Rock Pile': '塑料石堆',
  'Plastic Jungle Rocks': '塑料丛林岩石',
  'Large Plastic Rocks': '大型塑料岩石',
  'Plastic Volcano Pore': '塑料火山孔',
  'Plastic Glowgrowth Colony': '塑料发光菌群',
};

export function constructionDisplay(value: string): string {
  const variant = value.match(/^(.*) \((Alt ?\d*|Random)\)$/);
  if (variant && labels[variant[1]]) {
    const suffix = variant[2] === 'Random' ? '随机' : `变体${variant[2].slice(3).trim()}`;
    return `${labels[variant[1]]}（${suffix}）`;
  }
  return labels[value] ?? chineseDisplay(value);
}
