import {
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureColorInput,
  type FeatureValueProps,
} from './base';
import { FeatureDropdownInput } from './dropdowns';

export const eye_color: Feature<string> = {
  name: '眼睛颜色',
  component: FeatureColorInput,
};

export const facial_hair_color: Feature<string> = {
  name: '面部毛发颜色',
  component: FeatureColorInput,
};

export const facial_hair_gradient: FeatureChoiced = {
  name: '面部毛发渐变',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const facial_hair_gradient_color: Feature<string> = {
  name: '面部毛发渐变颜色',
  component: FeatureColorInput,
};

export const hair_color: Feature<string> = {
  name: '头发颜色',
  component: FeatureColorInput,
};

export const hair_gradient: FeatureChoiced = {
  name: '头发渐变',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const hair_gradient_color: Feature<string> = {
  name: '头发渐变颜色',
  component: FeatureColorInput,
};

export const feature_cat_ears: FeatureChoiced = {
  name: '耳朵',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_cat_tail: FeatureChoiced = {
  name: '尾巴',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_monkey_tail: FeatureChoiced = {
  name: '尾巴',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_legs: FeatureChoiced = {
  name: '腿部',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_spines: FeatureChoiced = {
  name: '背刺',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_lizard_tail: FeatureChoiced = {
  name: '尾巴',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor: Feature<string> = {
  name: '变异部位颜色',
  component: FeatureColorInput,
};

export const underwear_color: Feature<string> = {
  name: '内裤颜色',
  component: FeatureColorInput,
};

export const bra_color: Feature<string> = {
  name: '胸罩颜色',
  component: FeatureColorInput,
};

export const feature_vampire_status: Feature<string> = {
  name: '吸血鬼身份',
  component: FeatureDropdownInput,
};

export const heterochromatic: Feature<string> = {
  name: '异色瞳（右眼）颜色',
  component: FeatureColorInput,
};
