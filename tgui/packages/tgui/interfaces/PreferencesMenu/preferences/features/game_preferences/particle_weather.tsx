import { CheckboxInput, type FeatureToggle } from '../base';

export const particle_weather: FeatureToggle = {
  name: '启用粒子天气（不兼容 AMD 显卡）',
  category: 'GAMEPLAY',
  description:
    '启用精细的粒子天气效果。由于 BYOND 的缺陷，此功能不兼容 AMD 显卡，会导致严重卡顿。',
  component: CheckboxInput,
};
