import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const ghost_lighting: FeatureChoiced = {
  name: '幽灵照明',
  component: FeatureDropdownInput,
  category: 'GHOST',
  description: '调整幽灵视角下的照明亮度。',
};
