import { CheckboxInput, type FeatureToggle } from '../../base';

export const show_in_directory: FeatureToggle = {
  name: '显示在角色名录中',
  category: 'ADVERT',
  description: '启用后，角色会显示在角色名录中。',
  component: CheckboxInput,
};
