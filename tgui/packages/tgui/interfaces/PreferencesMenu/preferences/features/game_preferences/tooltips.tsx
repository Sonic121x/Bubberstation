import {
  CheckboxInput,
  type Feature,
  FeatureNumberInput,
  type FeatureToggle,
} from '../base';

export const enable_tips: FeatureToggle = {
  name: '启用悬浮提示',
  category: 'TOOLTIPS',
  description: `
    鼠标悬停在物品上时是否显示提示？
  `,
  component: CheckboxInput,
};

export const tip_delay: Feature<number> = {
  name: '悬浮提示延迟（毫秒）',
  category: 'TOOLTIPS',
  description: `
    鼠标在物品上悬停多久后显示提示？
  `,
  component: FeatureNumberInput,
};
