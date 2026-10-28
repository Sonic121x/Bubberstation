import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const preferred_map: Feature<string> = {
  name: '偏好地图',
  category: 'GAMEPLAY',
  description: `
    轮换地图时优先选择此地图。
    此设置不影响地图投票，仅在未举行投票时
    影响随机轮换。
  `,
  component: FeatureDropdownInput,
};
