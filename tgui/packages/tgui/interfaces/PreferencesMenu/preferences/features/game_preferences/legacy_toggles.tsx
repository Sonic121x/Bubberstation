import {
  CheckboxInput,
  CheckboxInputInverse,
  type FeatureToggle,
} from '../base';

export const admin_ignore_cult_ghost: FeatureToggle = {
  name: '禁止被召唤为血教幽灵',
  category: 'ADMIN',
  description: `
    启用后，在观察状态下防止灵界能力
    强制将你变为血教幽灵。
  `,
  component: CheckboxInput,
};

export const announce_login: FeatureToggle = {
  name: '公告登录',
  category: 'ADMIN',
  description: '你登录时会通知管理员。',
  component: CheckboxInput,
};

export const combohud_lighting: FeatureToggle = {
  name: '启用全亮综合 HUD',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const deadmin_always: FeatureToggle = {
  name: '自动卸任 - 始终',
  category: 'ADMIN',
  description: '启用后，你会自动卸任管理员。',
  component: CheckboxInput,
};

export const deadmin_antagonist: FeatureToggle = {
  name: '自动卸任 - 反派',
  category: 'ADMIN',
  description: '启用后，扮演反派时会自动卸任管理员。',
  component: CheckboxInput,
};

export const deadmin_position_head: FeatureToggle = {
  name: '自动卸任 - 部门主管',
  category: 'ADMIN',
  description:
    '启用后，扮演部门主管时会自动卸任管理员。',
  component: CheckboxInput,
};

export const deadmin_position_security: FeatureToggle = {
  name: '自动卸任 - 安保',
  category: 'ADMIN',
  description:
    '启用后，扮演安保人员时会自动卸任管理员。',
  component: CheckboxInput,
};

export const deadmin_position_silicon: FeatureToggle = {
  name: '自动卸任 - 硅基',
  category: 'ADMIN',
  description: '启用后，扮演硅基角色时会自动卸任管理员。',
  component: CheckboxInput,
};

export const disable_arrivalrattle: FeatureToggle = {
  name: '新船员抵达通知',
  category: 'GHOST',
  description: '启用后，新船员抵达时会通知处于幽灵状态的你。',
  component: CheckboxInputInverse,
};

export const disable_deathrattle: FeatureToggle = {
  name: '死亡通知',
  category: 'GHOST',
  description:
    '启用后，有人死亡时会通知处于幽灵状态的你。',
  component: CheckboxInputInverse,
};

export const member_public: FeatureToggle = {
  name: '公开 BYOND 会员身份',
  category: 'CHAT',
  description:
    '启用后，戏外频道中你的名字旁会显示 BYOND 标志。',
  component: CheckboxInput,
};

export const sound_adminhelp: FeatureToggle = {
  name: '启用管理员求助音效',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const sound_prayers: FeatureToggle = {
  name: '启用祈祷音效',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const split_admin_tabs: FeatureToggle = {
  name: '拆分管理员标签页',
  category: 'ADMIN',
  description: "启用后，会把管理员面板拆分为多个标签页。",
  component: CheckboxInput,
};
