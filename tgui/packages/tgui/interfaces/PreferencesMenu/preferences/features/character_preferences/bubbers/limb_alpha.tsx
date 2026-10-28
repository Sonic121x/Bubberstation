import {
  CheckboxInput,
  type Feature,
  FeatureSliderInput,
  type FeatureToggle,
} from '../../base';

// Names share the "Limb Transparency" prefix so the panel (which sorts secondary features
// alphabetically by name) keeps them grouped together, toggle first.
export const limb_alpha_per_limb: FeatureToggle = {
  name: '肢体透明度',
  description:
    '显示手臂和腿部各自的透明度滑块。关闭时，这些肢体保持完全不透明。',
  component: CheckboxInput,
};

export const limb_alpha_head: Feature<number> = {
  name: '肢体透明度：头部',
  description:
    '头部的不透明程度。0表示连接身体时完全不可见；掉落的肢体仍会隐约可见，方便拾取。',
  component: FeatureSliderInput,
};

export const limb_alpha_chest: Feature<number> = {
  name: '肢体透明度：胸部',
  description:
    '胸部的不透明程度。0表示连接身体时完全不可见；掉落的肢体仍会隐约可见，方便拾取。',
  component: FeatureSliderInput,
};

export const limb_alpha_l_arm: Feature<number> = {
  name: '肢体透明度：左臂',
  description: '左臂的不透明程度。',
  component: FeatureSliderInput,
};

export const limb_alpha_r_arm: Feature<number> = {
  name: '肢体透明度：右臂',
  description: '右臂的不透明程度。',
  component: FeatureSliderInput,
};

export const limb_alpha_l_leg: Feature<number> = {
  name: '肢体透明度：左腿',
  description: '左腿的不透明程度。',
  component: FeatureSliderInput,
};

export const limb_alpha_r_leg: Feature<number> = {
  name: '肢体透明度：右腿',
  description: '右腿的不透明程度。',
  component: FeatureSliderInput,
};
