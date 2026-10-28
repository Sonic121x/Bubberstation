// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const do_emote_overlay: FeatureToggle = {
  name: '显示或隐藏自己的表情特效',
  category: 'CHAT',
  description:
    '显示或隐藏你自己使用表情动作时的叠层动画。',
  component: CheckboxInput,
};
