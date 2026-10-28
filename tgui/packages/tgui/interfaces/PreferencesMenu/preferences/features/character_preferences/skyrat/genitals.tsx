// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureNumberInput,
  type FeatureNumeric,
  type FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const feature_penis: Feature<string> = {
  name: '阴茎样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const penis_skin_tone: FeatureToggle = {
  name: '阴茎使用肤色',
  component: CheckboxInput,
};

export const penis_skin_color: FeatureToggle = {
  name: '阴茎使用皮肤颜色',
  component: CheckboxInput,
};

export const penis_color: Feature<string[]> = {
  name: '阴茎颜色',
  component: FeatureTriColorInput,
};

export const penis_emissive: Feature<boolean[]> = {
  name: '阴茎发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const penis_sheath: Feature<string> = {
  name: '阴茎鞘',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const penis_length: FeatureNumeric = {
  name: '阴茎长度',
  description:
    '单位为英寸。\
     体型不大于 1，或没有超大体型特质的角色，\
     此数值上限为 20。允许的最大值会随角色体型增大，\
     最高为 36。',
  component: FeatureNumberInput,
};

export const penis_girth: FeatureNumeric = {
  name: '阴茎周长',
  description:
    '数值为周长，单位为英寸。\
    体型不大于 1，或没有超大体型特质的角色，\
    此数值上限为 15。允许的最大值会随角色体型增大，\
    最高为 20。',
  component: FeatureNumberInput,
};

export const penis_taur_mode_toggle: FeatureToggle = {
  name: '阴茎半人马模式',
  description:
    '如果所选半人马身躯带有阴茎图像，\
    则使用该图像代替普通图像。',
  component: CheckboxInput,
};

export const feature_testicles: Feature<string> = {
  name: '睾丸样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const testicles_skin_tone: FeatureToggle = {
  name: '睾丸使用肤色',
  component: CheckboxInput,
};

export const testicles_skin_color: FeatureToggle = {
  name: '睾丸使用皮肤颜色',
  component: CheckboxInput,
};

export const testicles_color: Feature<string[]> = {
  name: '睾丸颜色',
  component: FeatureTriColorInput,
};

export const testicles_emissive: Feature<boolean[]> = {
  name: '睾丸发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const balls_size: FeatureNumeric = {
  name: '睾丸大小',
  component: FeatureNumberInput,
};

export const feature_vagina: Feature<string> = {
  name: '阴道样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const vagina_skin_tone: FeatureToggle = {
  name: '阴道使用肤色',
  component: CheckboxInput,
};

export const vagina_skin_color: FeatureToggle = {
  name: '阴道使用皮肤颜色',
  component: CheckboxInput,
};

export const vagina_color: Feature<string[]> = {
  name: '阴道颜色',
  component: FeatureTriColorInput,
};

export const vagina_emissive: Feature<boolean[]> = {
  name: '阴道发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const feature_womb: Feature<string> = {
  name: '子宫样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_breasts: Feature<string> = {
  name: '乳房样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const breasts_skin_tone: FeatureToggle = {
  name: '乳房使用肤色',
  component: CheckboxInput,
};

export const breasts_skin_color: FeatureToggle = {
  name: '乳房使用皮肤颜色',
  component: CheckboxInput,
};

export const breasts_color: Feature<string[]> = {
  name: '乳房颜色',
  component: FeatureTriColorInput,
};

export const breasts_emissive: Feature<boolean[]> = {
  name: '乳房发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: '乳房泌乳',
  component: CheckboxInput,
};

export const breasts_size: Feature<string> = {
  name: '乳房大小',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const feature_anus: Feature<string> = {
  name: '肛门样式',
  component: FeatureDropdownInput,
};

export const feature_butt: Feature<string> = {
  name: '臀部样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const butt_skin_tone: FeatureToggle = {
  name: '臀部使用肤色',
  component: CheckboxInput,
};

export const butt_skin_color: FeatureToggle = {
  name: '臀部使用皮肤颜色',
  component: CheckboxInput,
};

export const butt_color: Feature<string[]> = {
  name: '臀部颜色',
  component: FeatureTriColorInput,
};

export const butt_emissive: Feature<boolean[]> = {
  name: '臀部发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const butt_size: FeatureNumeric = {
  name: '臀部大小',
  component: FeatureNumberInput,
};

export const anus_skin_tone: FeatureToggle = {
  name: '肛门使用肤色',
  component: CheckboxInput,
};

export const anus_skin_color: FeatureToggle = {
  name: '肛门使用皮肤颜色',
  component: CheckboxInput,
};

export const anus_color: Feature<string[]> = {
  name: '肛门颜色',
  component: FeatureTriColorInput,
};

export const anus_emissive: Feature<boolean[]> = {
  name: '肛门发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const feature_belly: Feature<string> = {
  name: '腹部样式',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const belly_size: FeatureNumeric = {
  name: '腹部大小',
  component: FeatureNumberInput,
};

export const belly_skin_tone: FeatureToggle = {
  name: '腹部使用肤色',
  component: CheckboxInput,
};

export const belly_skin_color: FeatureToggle = {
  name: '腹部使用皮肤颜色',
  component: CheckboxInput,
};

export const belly_color: Feature<string[]> = {
  name: '腹部颜色',
  component: FeatureTriColorInput,
};

export const belly_emissive: Feature<boolean[]> = {
  name: '腹部发光部位',
  description: '发光部位会在黑暗中发亮。',
  component: FeatureTriBoolInput,
};

export const body_size: FeatureNumeric = {
  name: '体型大小',
  component: FeatureNumberInput,
};

export const erp_status_pref: FeatureChoiced = {
  name: '成人角色扮演意愿',
  description:
    '所有成人角色扮演状态偏好都只是向其他玩家说明，\
  你对各大类成人角色扮演的意愿。选择“否”将基本排除\
  所有以你为对象的成人角色扮演。',
  component: FeatureDropdownInput,
};

export const erp_status_pref_nc: FeatureChoiced = {
  name: '非自愿主题成人角色扮演意愿',
  component: FeatureDropdownInput,
};

export const erp_status_pref_v: FeatureChoiced = {
  name: '吞食主题成人角色扮演意愿',
  component: FeatureDropdownInput,
};

export const erp_status_pref_hypnosis: FeatureChoiced = {
  name: '催眠主题成人角色扮演意愿',
  component: FeatureDropdownInput,
};

export const erp_status_pref_mechanics: FeatureChoiced = {
  name: '成人角色扮演游戏机制意愿',
  component: FeatureDropdownInput,
};

export const erp_free_use: FeatureToggle = {
  name: '成人角色扮演自由使用意愿',
  component: CheckboxInput,
};
