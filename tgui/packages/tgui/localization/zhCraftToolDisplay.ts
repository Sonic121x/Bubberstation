const toolNames: Record<string, string> = {
  crowbar: '撬棍', multitool: '多功能工具', screwdriver: '螺丝刀',
  cutters: '钢丝钳', wrench: '扳手', welder: '焊枪', analyzer: '分析仪',
  mining: '采矿工具', shovel: '铲子', retractor: '牵开器', hemostat: '止血钳',
  cautery: '烧灼器', drill: '钻头', scalpel: '手术刀', saw: '锯子',
  bonesetter: '接骨器', knife: '刀', bloodfilter: '血液过滤器',
  'rolling pin': '擀面杖', rustscraper: '除锈铲',
};

export const craftToolDisplay = (value: string) =>
  value.split(' / ').map((tool) => toolNames[tool.toLowerCase()] ?? tool).join(' / ');
