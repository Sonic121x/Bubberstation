import { CheckboxInput, type FeatureToggle } from '../base';

export const itemoutline_pref: FeatureToggle = {
  name: '物品轮廓',
  category: 'GAMEPLAY',
  description: '启用后，鼠标悬停在物品上时会显示其轮廓。',
  component: CheckboxInput,
};
