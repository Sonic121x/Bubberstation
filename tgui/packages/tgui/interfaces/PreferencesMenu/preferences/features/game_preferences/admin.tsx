import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

// BUBBER EDIT ADDITION START
export const use_tgui_player_panel: FeatureToggle = {
  name: '使用新版玩家面板',
  category: 'ADMIN',
  description: '选择使用新版 TGUI 玩家面板还是旧版 HTML 面板。',
  component: CheckboxInput,
};
// BUBBER EDIT ADDITION END

export const asaycolor: Feature<string> = {
  name: '管理员聊天颜色',
  category: 'ADMIN',
  description: '你在管理员频道发送的消息颜色。',
  component: FeatureColorInput,
};

export const brief_outfit: Feature<string> = {
  name: '简报官装备',
  category: 'ADMIN',
  description: '作为简报官生成时获得的装备。',
  component: FeatureDropdownInput,
};

export const bypass_deadmin_in_centcom: FeatureToggle = {
  name: '在中央指挥部时跳过卸任设置',
  category: 'ADMIN',
  description:
    '在中央指挥部生成时是否始终保留管理员身份。',
  component: CheckboxInput,
};

export const fast_mc_refresh: FeatureToggle = {
  name: '启用 MC 状态面板快速刷新',
  category: 'ADMIN',
  description:
    '是否快速刷新状态面板的主控制器页。此功能开销较大，请按需启用。',
  component: CheckboxInput,
};

export const ghost_roles_as_admin: FeatureToggle = {
  name: '担任管理员时接收幽灵角色通知',
  category: 'ADMIN',
  description: `
    取消选择后，担任管理员时不会收到任何
    幽灵角色弹窗！所有此类弹窗都会被屏蔽。
    但卸任管理员、作为普通玩家游玩时，
    仍会正常收到通知。
`,
  component: CheckboxInput,
};

export const comms_notification: FeatureToggle = {
  name: '启用通信控制台声音',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const auto_deadmin_on_ready_or_latejoin: FeatureToggle = {
  name: '自动卸任 - 准备或中途加入',
  category: 'ADMIN',
  description: `
    启用后，点击准备或中途加入回合时会自动卸任管理员。
`,
  component: CheckboxInput,
};
