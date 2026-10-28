import { CheckboxInput, type FeatureToggle } from '../../base';

export const random_heirloom_toggle: FeatureToggle = {
  name: '启用随机传家宝',
  description:
    '启用后将获得随机传家宝，而不能自行指定。',
  component: CheckboxInput,
};
