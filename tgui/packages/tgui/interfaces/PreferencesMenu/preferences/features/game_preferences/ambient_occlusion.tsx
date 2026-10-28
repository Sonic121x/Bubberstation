import { CheckboxInput, type FeatureToggle } from '../base';

export const ambientocclusion: FeatureToggle = {
  name: '启用环境光遮蔽',
  category: 'GAMEPLAY',
  description: '启用环境光遮蔽，在角色周围显示淡淡的阴影。',
  component: CheckboxInput,
};
