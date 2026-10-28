import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const junkie: FeatureChoiced = {
  name: '成瘾物质',
  component: FeatureDropdownInput,
};

export const smoker: FeatureChoiced = {
  name: '偏爱品牌',
  component: FeatureDropdownInput,
};

export const alcoholic: FeatureChoiced = {
  name: '偏爱饮品',
  component: FeatureDropdownInput,
};
