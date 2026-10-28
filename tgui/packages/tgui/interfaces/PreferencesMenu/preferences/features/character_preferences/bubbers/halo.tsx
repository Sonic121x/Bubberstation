import { type Feature, FeatureColorInput } from '../../base';

export const halo_color: Feature<string> = {
  name: '光环颜色',
  component: FeatureColorInput,
};
