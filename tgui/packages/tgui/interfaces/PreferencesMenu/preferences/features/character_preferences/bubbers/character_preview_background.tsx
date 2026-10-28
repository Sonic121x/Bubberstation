import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const bgstate: FeatureChoiced = {
  name: '角色预览背景',
  description:
    '选择角色创建界面中角色预览的背景。',
  component: FeatureDropdownInput,
};
