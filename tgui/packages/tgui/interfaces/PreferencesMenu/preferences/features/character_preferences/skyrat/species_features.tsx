// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureColorInput,
  FeatureNumberInput,
  FeatureShortTextInput,
  FeatureTextInput,
  type FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const feature_leg_type: FeatureChoiced = {
  name: '腿部类型',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_mcolor2: Feature<string> = {
  name: '变异部位颜色 2',
  component: FeatureColorInput,
};
export const feature_mcolor3: Feature<string> = {
  name: '变异部位颜色 3',
  component: FeatureColorInput,
};

export const flavor_text: Feature<string> = {
  name: '角色描述',
  description:
    '被查看时显示，提供带有个性的外貌描述，让其他角色形成对你的第一印象。需要帮助时请查阅 Wiki 指南。',
  component: FeatureTextInput,
};

export const silicon_flavor_text: Feature<string> = {
  name: '硅基角色描述',
  description: "扮演半机械人或 AI 时显示的角色描述。",
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: '戏外备注',
  description:
    '可填写性偏好、玩家本人信息、额外的美术参考及其他细节。这里介绍的是你本人，而非你的角色。',
  component: FeatureTextInput,
};

export const custom_species: Feature<string> = {
  name: '自定义物种名称',
  description:
    '自定义物种的名称。留空时使用所选物种的名称，例如人类、蜥蜴人。',
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: '自定义物种设定',
  description:
    "若不使用服务器设定，可在此填写自定义物种的设定。留空则使用所选物种的设定。",
  component: FeatureTextInput,
};

export const custom_taste: Feature<string> = {
  name: '角色味道',
  description: '别人舔你的角色时，会尝到什么味道？',
  component: FeatureShortTextInput,
};

export const custom_smell: Feature<string> = {
  name: '角色气味',
  description: '别人嗅闻你的角色时，会闻到什么气味？',
  component: FeatureShortTextInput,
};

export const general_record: Feature<string> = {
  name: '档案 - 一般信息',
  description:
    '用于描述你的档案的第一部分。\
    可填写简要描述、语言、出身和生日。',
  component: FeatureTextInput,
};

export const security_record: Feature<string> = {
  name: '档案 - 安保',
  description:
    '仅供安保、指挥部和纳米传讯顾问查看的受限信息。\
    用于为这些角色提供更多可用于互动的信息。\
    可填写工作和犯罪记录、忠诚对象、可利用的细节等。',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: '档案 - 医疗',
  description:
    '拥有医疗权限者可查看。\
  可填写病史、处方、拒绝复苏指令等。',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: '档案 - 可利用信息',
  description:
    '可包含戏内或戏外信息，供特定反派、敌对势力玩家及幽灵查看。通常包含\
  弱点、优势、重要背景、触发词等。也可以填写\
  对反派互动的偏好，例如是否希望遭遇敌对行为、希望由谁实施、以何种方式等。',
  component: FeatureTextInput,
};

export const background_info: Feature<string> = {
  name: '档案 - 背景',
  description:
    '仅你自己和幽灵可见。这里可以填写任何内容，帮助你理清角色的定位。',
  component: FeatureTextInput,
};

export const pda_ringer: Feature<string> = {
  name: 'PDA 铃声消息',
  description:
    '想让 PDA 发出“哔”以外的声音吗？仅取前 20 个字符。',
  component: FeatureShortTextInput,
};

export const allow_mismatched_parts_toggle: FeatureToggle = {
  name: '允许混搭部位',
  description: '允许选择任意物种的部位。',
  component: CheckboxInput,
};

export const allow_mismatched_hair_color_toggle: FeatureToggle = {
  name: '允许自定义发色',
  description:
    '允许通常具有固定发色的物种使用其他发色，包括回合内染发、改变形态等方式。目前仅适用于史莱姆。',
  component: CheckboxInput,
};

export const allow_genitals_toggle: FeatureToggle = {
  name: '允许生殖器部位',
  description: '想让角色拥有生殖器时启用。',
  component: CheckboxInput,
};

export const allow_emissives_toggle: FeatureToggle = {
  name: '允许发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: CheckboxInput,
};

export const eye_emissives: FeatureToggle = {
  name: '眼睛发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: CheckboxInput,
};

export const eyes_opacity: Feature<number> = {
  name: '眼睛不透明度',
  component: FeatureNumberInput,
};

export const body_markings_toggle: FeatureToggle = {
  name: '身体斑纹',
  component: CheckboxInput,
};

export const feature_body_markings: Feature<string> = {
  name: '身体斑纹选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const body_markings_color: Feature<string[]> = {
  name: '身体斑纹颜色',
  component: FeatureTriColorInput,
};

export const body_markings_emissive: Feature<boolean[]> = {
  name: '身体斑纹发光部位',
  component: FeatureTriBoolInput,
};

export const tail_toggle: FeatureToggle = {
  name: '尾巴',
  component: CheckboxInput,
};

export const feature_tail: Feature<string> = {
  name: '尾巴选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const tail_color: Feature<string[]> = {
  name: '尾巴颜色',
  component: FeatureTriColorInput,
};

export const tail_emissive: Feature<boolean[]> = {
  name: '尾巴发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const snout_toggle: FeatureToggle = {
  name: '口鼻',
  component: CheckboxInput,
};

export const feature_snout: Feature<string> = {
  name: '口鼻选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const snout_color: Feature<string[]> = {
  name: '口鼻颜色',
  component: FeatureTriColorInput,
};

export const snout_emissive: Feature<boolean[]> = {
  name: '口鼻发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const horns_toggle: FeatureToggle = {
  name: '角',
  component: CheckboxInput,
};

export const feature_horns: Feature<string> = {
  name: '角选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const horns_color: Feature<string[]> = {
  name: '角颜色',
  component: FeatureTriColorInput,
};

export const horns_emissive: Feature<boolean[]> = {
  name: '角发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const ears_toggle: FeatureToggle = {
  name: '耳朵',
  component: CheckboxInput,
};

export const feature_ears: Feature<string> = {
  name: '耳朵选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ears_color: Feature<string[]> = {
  name: '耳朵颜色',
  component: FeatureTriColorInput,
};

export const ears_emissive: Feature<boolean[]> = {
  name: '耳朵发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const quad_eyes: FeatureToggle = {
  name: '四眼',
  description:
    '赋予角色四只眼睛。特殊眼睛可能显示异常，例如蜗牛、蛾人、影裔、阿库拉等。- ( ** v ** )',
  component: CheckboxInput,
};

export const quad_eyes_offset: Feature<number> = {
  name: '四眼偏移',
  component: FeatureNumberInput,
};

export const quad_eyes_offset_width: Feature<number> = {
  name: '四眼水平偏移',
  component: FeatureNumberInput,
};

export const wings_toggle: FeatureToggle = {
  name: '翅膀',
  component: CheckboxInput,
};

export const feature_wings: Feature<string> = {
  name: '翅膀选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const wings_color: Feature<string[]> = {
  name: '翅膀颜色',
  component: FeatureTriColorInput,
};

export const wings_emissive: Feature<boolean[]> = {
  name: '翅膀发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const frills_toggle: FeatureToggle = {
  name: '颈褶',
  component: CheckboxInput,
};

export const feature_frills: Feature<string> = {
  name: '颈褶选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const frills_color: Feature<string[]> = {
  name: '颈褶颜色',
  component: FeatureTriColorInput,
};

export const frills_emissive: Feature<boolean[]> = {
  name: '颈褶发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const spines_toggle: FeatureToggle = {
  name: '背刺',
  component: CheckboxInput,
};

export const feature_spines: Feature<string> = {
  name: '背刺选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const spines_color: Feature<string[]> = {
  name: '背刺颜色',
  component: FeatureTriColorInput,
};

export const spines_emissive: Feature<boolean[]> = {
  name: '背刺发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const digitigrade_legs: FeatureChoiced = {
  name: '腿部',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_toggle: FeatureToggle = {
  name: '菌盖',
  component: CheckboxInput,
};

export const feature_caps: Feature<string> = {
  name: '菌盖选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_color: Feature<string[]> = {
  name: '菌盖颜色',
  component: FeatureTriColorInput,
};

export const caps_emissive: Feature<boolean[]> = {
  name: '菌盖发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const moth_antennae_toggle: FeatureToggle = {
  name: '蛾触角',
  component: CheckboxInput,
};

export const feature_moth_antennae: Feature<string> = {
  name: '蛾触角选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_antennae_color: Feature<string[]> = {
  name: '蛾触角颜色',
  component: FeatureTriColorInput,
};

export const moth_antennae_emissive: Feature<boolean[]> = {
  name: '蛾触角发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const moth_markings_toggle: FeatureToggle = {
  name: '蛾斑纹',
  component: CheckboxInput,
};

export const feature_moth_markings: Feature<string> = {
  name: '蛾斑纹选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_markings_color: Feature<string[]> = {
  name: '蛾斑纹颜色',
  component: FeatureTriColorInput,
};

export const moth_markings_emissive: Feature<boolean[]> = {
  name: '蛾斑纹发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const fluff_toggle: FeatureToggle = {
  name: '绒毛',
  component: CheckboxInput,
};

export const feature_fluff: Feature<string> = {
  name: '绒毛选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const fluff_color: Feature<string[]> = {
  name: '绒毛颜色',
  component: FeatureTriColorInput,
};

export const fluff_emissive: Feature<boolean[]> = {
  name: '绒毛发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const head_acc_toggle: FeatureToggle = {
  name: '头部配饰',
  component: CheckboxInput,
};

export const feature_head_acc: Feature<string> = {
  name: '头部配饰选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const head_acc_color: Feature<string[]> = {
  name: '头部配饰颜色',
  component: FeatureTriColorInput,
};

export const head_acc_emissive: Feature<boolean[]> = {
  name: '头部配饰发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'IPC 屏幕选择',
  description: '可在回合内更改。',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_screen_color: Feature<string> = {
  name: 'IPC 屏幕灰度着色',
  component: FeatureColorInput,
};

export const ipc_screen_emissive: Feature<boolean> = {
  name: 'IPC 屏幕发光',
  description: '发光部位会在黑暗中发亮。',
  component: CheckboxInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: '合成人天线',
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: '合成人天线选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_antenna_color: Feature<string[]> = {
  name: '合成人天线颜色',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: '合成人天线发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: '合成人机体选择',
  description: '仅对合成人生效。',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_chassis_color: Feature<string> = {
  name: '合成人机体颜色',
  description:
    '仅对合成人和支持灰度着色的机体生效。',
  component: FeatureColorInput,
};

export const feature_ipc_head: Feature<string> = {
  name: '合成人头部选择',
  description: '仅对合成人生效。',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_head_color: Feature<string> = {
  name: '合成人头部颜色',
  component: FeatureColorInput,
};

export const feature_hair_opacity_toggle: Feature<boolean> = {
  name: '覆盖头发不透明度',
  component: CheckboxInput,
};

export const feature_hair_opacity: Feature<number> = {
  name: '头发不透明度',
  component: FeatureNumberInput,
};

export const neck_acc_toggle: FeatureToggle = {
  name: '颈部配饰',
  component: CheckboxInput,
};

export const feature_neck_acc: Feature<string> = {
  name: '颈部配饰选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const neck_acc_color: Feature<string[]> = {
  name: '颈部配饰颜色',
  component: FeatureTriColorInput,
};

export const neck_acc_emissive: Feature<boolean[]> = {
  name: '颈部配饰发光部位',
  component: FeatureTriBoolInput,
};

export const skrell_hair_toggle: FeatureToggle = {
  name: '斯克雷尔头发',
  component: CheckboxInput,
};

export const feature_skrell_hair: Feature<string> = {
  name: '斯克雷尔发型选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const skrell_hair_color: Feature<string[]> = {
  name: '斯克雷尔发色',
  component: FeatureTriColorInput,
};

export const skrell_hair_emissive: Feature<boolean[]> = {
  name: '斯克雷尔头发发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const taur_toggle: FeatureToggle = {
  name: '半人马身躯',
  component: CheckboxInput,
};

export const feature_taur: Feature<string> = {
  name: '半人马身躯选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const taur_color: Feature<string[]> = {
  name: '半人马身躯颜色',
  component: FeatureTriColorInput,
};

export const taur_emissive: Feature<boolean[]> = {
  name: '半人马身躯发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const naga_sole: FeatureToggle = {
  name: '半人马（纳迦）禁用硬化腹鳞',
  description:
    '使用蛇形半人马身躯时，决定是否免疫铁蒺藜和部分赤足效果。',
  component: CheckboxInput,
};

export const synthetic_taur: FeatureToggle = {
  name: '机械半人马身躯',
  description:
    "使用半人马身躯时，决定该身躯是否为机械结构；不适用于本来就是机械结构的身躯。",
  component: CheckboxInput,
};

export const xenodorsal_toggle: FeatureToggle = {
  name: '异形背管',
  component: CheckboxInput,
};

export const feature_xenodorsal: Feature<string> = {
  name: '异形背管选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenodorsal_color: Feature<string[]> = {
  name: '异形背管颜色',
  component: FeatureTriColorInput,
};

export const xenodorsal_emissive: Feature<boolean[]> = {
  name: '异形背管发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const xenohead_toggle: FeatureToggle = {
  name: '异形头部',
  component: CheckboxInput,
};

export const feature_xenohead: Feature<string> = {
  name: '异形头部选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenohead_color: Feature<string[]> = {
  name: '异形头部颜色',
  component: FeatureTriColorInput,
};

export const xenohead_emissive: Feature<boolean[]> = {
  name: '异形头部发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const undershirt_color: Feature<string> = {
  name: '内衫颜色',
  component: FeatureColorInput,
};

export const socks_color: Feature<string> = {
  name: '袜子颜色',
  component: FeatureColorInput,
};

export const heterochromia_toggle: FeatureToggle = {
  name: '异色瞳',
  component: CheckboxInput,
};

export const feature_heterochromia: Feature<string> = {
  name: '异色瞳选择',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const heterochromia_color: Feature<string[]> = {
  name: '异色瞳颜色',
  component: FeatureTriColorInput,
};

export const heterochromia_emissive: Feature<boolean[]> = {
  name: '异色瞳发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const vox_bodycolor: Feature<string> = {
  name: '沃克斯身体颜色',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const pod_hair_color: Feature<string[]> = {
  name: '花朵头发颜色',
  component: FeatureTriColorInput,
};

export const pod_hair_emissive: Feature<boolean> = {
  name: '花朵头发发光',
  description: '发光部位会在黑暗中发亮。',
  component: CheckboxInput,
};
