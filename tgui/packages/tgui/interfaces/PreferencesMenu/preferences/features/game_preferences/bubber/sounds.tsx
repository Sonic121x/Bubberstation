import { type Feature, FeatureSliderInput } from '../../base';

export const sound_emote: Feature<number> = {
  name: '表情动作音量',
  category: 'SOUND',
  description: '有声表情动作的音量。',
  component: FeatureSliderInput,
};
