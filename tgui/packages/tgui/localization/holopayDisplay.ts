const labels: Record<string, string> = {
  angry: '愤怒', ankh: '生命之符', bacon: '培根', 'band-aid': '创可贴',
  cannabis: '大麻', cat: '猫', cocktail: '鸡尾酒', coins: '硬币',
  'comments-dollar': '交易洽谈', cross: '十字架', cut: '剪刀', dog: '狗',
  donate: '捐款', dna: 'DNA', 'fist-raised': '举起的拳头', flask: '烧瓶',
  'glass-cheers': '干杯', 'glass-martini-alt': '马天尼杯', hamburger: '汉堡',
  'hand-holding-usd': '手托钱币', 'hat-wizard': '巫师帽',
  'head-side-cough-slash': '禁止咳嗽', heart: '爱心', 'heart-broken': '心碎',
  'laugh-beam': '开怀大笑', leaf: '叶子', 'money-check-alt': '支票',
  music: '音乐', 'piggy-bank': '小猪存钱罐', 'pizza-slice': '披萨片',
  'prescription-bottle-alt': '处方药瓶', radiation: '辐射', robot: '机器人',
  smile: '微笑', 'skull-crossbones': '骷髅与交叉骨', smoking: '吸烟',
  'space-shuttle': '太空穿梭机', tram: '电车', trash: '垃圾桶',
  'user-ninja': '忍者', utensils: '餐具', wrench: '扳手',
};

export const holopayDisplay = (value: string): string => Object.hasOwn(labels, value) ? labels[value] : value;
