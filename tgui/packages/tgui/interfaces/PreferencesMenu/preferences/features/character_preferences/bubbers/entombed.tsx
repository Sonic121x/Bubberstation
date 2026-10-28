// Sponsored by Zubberstation, ported from Nova Sector
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const entombed_deploy_lock: FeatureToggle = {
  name: '外骨骼保持展开（间接拒绝复苏）',
  description:
    '除头盔外，任何人都无法收回你的模块化外骨骼部件，包括你自己。警告：这会极大增加复苏难度，可视为间接拒绝复苏。请慎重选择。',
  component: CheckboxInput,
};

export const entombed_skin: FeatureChoiced = {
  name: '模块化外骨骼外观',
  component: FeatureDropdownInput,
};

export const entombed_hardlight_theme: FeatureChoiced = {
  name: '模块化外骨骼硬光主题',
  component: FeatureDropdownInput,
};

export const entombed_mod_name: Feature<string> = {
  name: '模块化外骨骼控制单元名称',
  component: FeatureShortTextInput,
};

export const entombed_mod_desc: Feature<string> = {
  name: '模块化外骨骼控制单元描述',
  component: FeatureShortTextInput,
};

export const entombed_mod_prefix: Feature<string> = {
  name: '模块化外骨骼展开部件前缀',
  description:
    "此前缀用于展开的模块化外骨骼部件，例如胸甲、头盔等。默认值意为“融合的”，请尽量使用形容词。",
  component: FeatureShortTextInput,
};
