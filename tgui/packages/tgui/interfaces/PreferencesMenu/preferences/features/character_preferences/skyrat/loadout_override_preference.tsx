// THIS IS A SKYRAT UI FILE
import type { Feature } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const loadout_override_preference: Feature<string> = {
  name: '配装物品优先方式',
  component: FeatureDropdownInput,
};
