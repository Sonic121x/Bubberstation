import { CheckboxInput, type FeatureToggle } from '../../base';

export const obscurity_examine_pref: FeatureToggle = {
  name: '隐藏身份不明时的查看面板',
  category: 'GAMEPLAY',
  description: '身份不明时，是否隐藏你的查看面板。',
  component: CheckboxInput,
};
