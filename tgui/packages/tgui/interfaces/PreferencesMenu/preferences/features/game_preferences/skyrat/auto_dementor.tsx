// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const auto_dementor_pref: FeatureToggle = {
  name: '自动卸任导师',
  category: 'ADMIN',
  description: '启用后，你会自动卸任导师。',
  component: CheckboxInput,
};
