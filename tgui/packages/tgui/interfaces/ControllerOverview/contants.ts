type SortType = {
  label: string;
  propName: string;
  inDeciseconds: boolean;
};

export const SORTING_TYPES: readonly SortType[] = [
  {
    label: '名称顺序',
    propName: 'name',
    inDeciseconds: false,
  },
  {
    label: '耗时',
    propName: 'cost_ms',
    inDeciseconds: true,
  },
  {
    label: '初始化顺序',
    propName: 'init_order',
    inDeciseconds: false,
  },
  {
    label: '上次执行',
    propName: 'last_fire',
    inDeciseconds: false,
  },
  {
    label: '下次执行',
    propName: 'next_fire',
    inDeciseconds: false,
  },
  {
    label: '时刻占用率',
    propName: 'tick_usage',
    inDeciseconds: true,
  },
  {
    label: '每时刻平均占用率',
    propName: 'usage_per_tick',
    inDeciseconds: true,
  },
  {
    label: '子系统超时',
    propName: 'overtime',
    inDeciseconds: true,
  },
];
