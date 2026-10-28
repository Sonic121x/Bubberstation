import {
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const seamless_heel_type: FeatureChoiced = {
  name: '鞋跟类型',
  component: FeatureDropdownInput,
};

export const seamless_shoe_color: Feature<string> = {
  name: '鞋子颜色',
  component: FeatureColorInput,
};
