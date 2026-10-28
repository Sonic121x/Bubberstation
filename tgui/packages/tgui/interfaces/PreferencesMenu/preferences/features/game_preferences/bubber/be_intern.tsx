import { CheckboxInput, type FeatureToggle } from '../../base';

export const be_intern: FeatureToggle = {
  name: '显示实习生标记',
  category: 'GAMEPLAY',
  description:
    '在游玩时长较少的职业中，是否将你标记为实习生。',
  component: CheckboxInput,
};
