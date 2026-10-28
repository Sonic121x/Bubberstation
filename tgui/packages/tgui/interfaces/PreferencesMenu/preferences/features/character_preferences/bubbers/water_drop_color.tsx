import { type Feature, FeatureColorInput } from '../../base';

export const input_dripping_color: Feature<string> = {
  name: '自定义颜色',
  description: '滴落液滴的颜色。',
  component: FeatureColorInput,
};
