import type { Feature } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const mod_select: Feature<string> = {
  name: 'MOD 主动模块按键',
  category: 'GAMEPLAY',
  description: '使用 MOD 套装主动模块所需的按键。',
  component: FeatureDropdownInput,
};
