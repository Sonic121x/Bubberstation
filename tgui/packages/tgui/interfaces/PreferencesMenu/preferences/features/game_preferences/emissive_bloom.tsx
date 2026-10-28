import { type Feature, FeatureSliderInput } from '../base';

export const emissive_bloom: Feature<number> = {
  name: '发光泛光强度',
  category: 'GAMEPLAY',
  description: `电脑屏幕等发光物体的泛光强度。此项对性能的影响可以忽略。`,
  component: FeatureSliderInput,
};
