import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const footstep_sound: FeatureChoiced = {
  name: '脚步声',
  description: '赤脚行走时发出的声音类型。',
  component: FeatureDropdownInput,
};
