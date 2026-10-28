import {
  FeatureIconnedDropdownInput,
  type FeatureWithIcons,
} from '../dropdowns';

export const preferred_ai_hologram_display: FeatureWithIcons<string> = {
  name: 'AI全息投影',
  description: '使用全息投影台时呈现的全息形态。',
  component: FeatureIconnedDropdownInput,
};
