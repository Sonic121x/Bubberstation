import {
  FeatureIconnedDropdownInput,
  type FeatureWithIcons,
} from '../dropdowns';

export const preferred_ai_emote_display: FeatureWithIcons<string> = {
  name: 'AI表情显示',
  description:
    '作为AI时，空间站所有AI显示屏默认显示的图像。',
  component: FeatureIconnedDropdownInput,
};
