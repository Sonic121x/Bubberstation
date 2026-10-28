import { CheckboxInput, type FeatureToggle } from '../../base';

export const subtler_sound: FeatureToggle = {
  name: '切换隐蔽表情音效',
  category: 'SOUND',
  description: '是否播放 subtle/r 隐蔽表情动作的音效。',
  component: CheckboxInput,
};
