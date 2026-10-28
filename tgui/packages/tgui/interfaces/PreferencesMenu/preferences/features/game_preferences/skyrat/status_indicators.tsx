import { CheckboxInput, type FeatureToggle } from '../../base';

export const enable_status_indicators: FeatureToggle = {
  name: '显示状态指示',
  category: 'GAMEPLAY',
  description: '选择是否显示状态指示。',
  component: CheckboxInput,
};
