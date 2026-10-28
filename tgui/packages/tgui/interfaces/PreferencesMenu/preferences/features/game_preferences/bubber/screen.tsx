import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const viewport_size: FeatureChoiced = {
  name: '宽高比（视口）',
  category: 'UI',
  description: '选择你偏好的视口尺寸。',
  component: FeatureDropdownInput,
};
