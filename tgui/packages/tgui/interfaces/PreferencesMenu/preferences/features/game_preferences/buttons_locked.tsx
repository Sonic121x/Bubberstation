import { CheckboxInput, type FeatureToggle } from '../base';

export const buttons_locked: FeatureToggle = {
  name: '锁定动作按钮',
  category: 'GAMEPLAY',
  description: '启用后，动作按钮的位置将被锁定。',
  component: CheckboxInput,
};
