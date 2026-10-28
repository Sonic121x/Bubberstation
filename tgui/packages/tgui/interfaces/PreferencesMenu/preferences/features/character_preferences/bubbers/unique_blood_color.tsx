import {
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const input_blood_color: Feature<string> = {
  name: '自定义颜色',
  description:
    '注意：该颜色对应最亮的像素。因此，请将HSL亮度设得比期望的血液颜色略高，约高10。',
  component: FeatureColorInput,
};

export const select_blood_color: FeatureChoiced = {
  name: '预设颜色',
  description: '注意：需要自定义颜色时，请选择“自定义”。',
  component: FeatureDropdownInput,
};
