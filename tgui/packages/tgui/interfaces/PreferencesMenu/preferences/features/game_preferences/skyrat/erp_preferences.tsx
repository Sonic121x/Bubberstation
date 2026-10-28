// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type FeatureChoiced,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const master_erp_pref: FeatureToggle = {
  name: '显示或隐藏成人角色扮演偏好',
  category: 'ERP',
  description: '显示或隐藏成人角色扮演偏好设置。',
  component: CheckboxInput,
};

export const erp_pref: FeatureToggle = {
  name: '成人角色扮演互动',
  category: 'ERP',
  description: '告知其他玩家你是否愿意参与成人角色扮演。',
  component: CheckboxInput,
};

export const erp_sounds_pref: FeatureToggle = {
  name: '成人角色扮演音效',
  category: 'ERP',
  description: '是否播放成人角色扮演机制的音效。',
  component: CheckboxInput,
};

export const bimbofication_pref: FeatureToggle = {
  name: '艳俗化',
  category: 'ERP',
  description:
    '是否会受到艳俗化效果的影响。',
  component: CheckboxInput,
};

export const aphro_pref: FeatureToggle = {
  name: '催情剂',
  category: 'ERP',
  description:
    '是否愿意受到催情剂效果的影响。',
  component: CheckboxInput,
};

export const sextoy_pref: FeatureToggle = {
  name: '情趣用品互动',
  category: 'ERP',
  description: '启用后，可以与情趣用品互动。',
  component: CheckboxInput,
};

export const sextoy_sounds_pref: FeatureToggle = {
  name: '情趣用品音效',
  category: 'ERP',
  description: '是否播放情趣用品的音效。',
  component: CheckboxInput,
};

export const vore_enable_pref: FeatureToggle = {
  name: '启用吞食机制',
  category: 'ERP',
  description: '是否可以使用吞食机制。',
  component: CheckboxInput,
};

// BUBBER EDIT START: MECHANICAL HYPNOSIS PREF
export const hypnosis_pref: FeatureToggle = {
  name: '催眠',
  category: 'ERP',
  description:
    '是否允许将催眠或催眠药物用于成人互动。',
  component: CheckboxInput,
};
// BUBBER EDIT END

export const breast_enlargement_pref: FeatureToggle = {
  name: '乳房增大',
  category: 'ERP',
  description:
    '是否愿意受到乳房增大药物的影响。',
  component: CheckboxInput,
};

export const breast_shrinkage_pref: FeatureToggle = {
  name: '乳房缩小',
  category: 'ERP',
  description:
    '是否愿意受到乳房缩小药物的影响。',
  component: CheckboxInput,
};

export const breast_removal_pref: FeatureToggle = {
  name: '乳房完全缩小',
  category: 'ERP',
  description:
    '是否愿意接受乳房缩小药物的完整效果。',
  component: CheckboxInput,
};

export const penis_enlargement_pref: FeatureToggle = {
  name: '阴茎增大',
  category: 'ERP',
  description:
    '是否愿意受到阴茎增大药物的影响。',
  component: CheckboxInput,
};

export const penis_shrinkage_pref: FeatureToggle = {
  name: '阴茎缩小',
  category: 'ERP',
  description:
    '是否愿意受到阴茎缩小药物的影响。',
  component: CheckboxInput,
};

export const gender_change_pref: FeatureToggle = {
  name: '强制性别改变',
  category: 'ERP',
  description: '是否允许强制改变性别。',
  component: CheckboxInput,
};

export const autocum_pref: FeatureToggle = {
  name: '自动高潮',
  category: 'ERP',
  description:
    '选择通过兴奋度系统自动高潮，还是需要手动操作。',
  component: CheckboxInput,
};

export const autoemote_pref: FeatureToggle = {
  name: '自动表情动作',
  category: 'ERP',
  description:
    '选择通过兴奋度系统自动发出表情动作，还是需要手动操作。',
  component: CheckboxInput,
};

export const erp_sexuality_pref: FeatureChoiced = {
  name: '性取向偏好',
  category: 'ERP',
  description:
    '决定显示哪些成人内容，适用范围有限。选择“无”将显示全部内容。',
  component: FeatureDropdownInput,
};

export const genitalia_removal_pref: FeatureToggle = {
  name: '成人互动：生殖器移除',
  category: 'ERP',
  description:
    '勾选后，允许药物移除角色已有的生殖器。',
  component: CheckboxInput,
};

export const new_genitalia_growth_pref: FeatureToggle = {
  name: '成人互动：新生殖器生长',
  category: 'ERP',
  description:
    '勾选后，允许药物让角色长出新的生殖器。',
  component: CheckboxInput,
};

export const vore_overlays: FeatureToggle = {
  name: '吞食叠层',
  category: 'ERP',
  description:
    '启用后，位于灵魂捕手中时显示全屏吞食叠层。',
  component: CheckboxInput,
};

export const vore_overlay_options: FeatureToggle = {
  name: '吞食叠层选项',
  category: 'ERP',
  description:
    '是否将全屏吞食叠层列为灵魂捕手叠层的可选项？',
  component: CheckboxInput,
};
