import { CheckboxInput, type FeatureToggle } from '../../base';

export const be_antag_pref: FeatureToggle = {
  name: '参与反派抽选',
  category: 'GAMEPLAY',
  description: '选择是否愿意扮演反派。',
  component: CheckboxInput,
};
