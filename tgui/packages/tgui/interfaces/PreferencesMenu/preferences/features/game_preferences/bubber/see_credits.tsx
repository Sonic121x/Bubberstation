import { CheckboxInput, type FeatureToggle } from '../../base';

export const see_credits: FeatureToggle = {
  name: '显示回合结束演职员表',
  category: 'GAMEPLAY',
  description: '启用后，回合结束时会显示演职员表。',
  component: CheckboxInput,
};
