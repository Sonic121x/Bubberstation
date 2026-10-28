import { CheckboxInput, type FeatureToggle } from '../base';

export const rds_limit: FeatureToggle = {
  name: '解除幻觉限制',
  description:
    '勾选此项将移除幻觉限制，\
    使幻觉更频繁、更具干扰性，而且通常更加离奇。',
  component: CheckboxInput,
};
