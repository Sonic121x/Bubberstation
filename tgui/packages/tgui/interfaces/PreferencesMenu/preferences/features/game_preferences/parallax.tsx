import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const parallax: Feature<string> = {
  name: '视差（太空背景效果）',
  category: 'GAMEPLAY',
  component: FeatureDropdownInput,
};
