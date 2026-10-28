import { createDropdownInput, type Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: '多层渲染深度',
  category: 'GAMEPLAY',
  description:
    '决定渲染多少层后开始剔除更深的楼层。多层地图卡顿时，可降低此值以提高性能。',
  component: createDropdownInput({
    [-1]: '不剔除',
    2: '高',
    1: '中',
    0: '低',
  }),
};
