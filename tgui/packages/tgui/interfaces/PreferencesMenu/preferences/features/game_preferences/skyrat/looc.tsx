// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const looc_admin_pref: FeatureToggle = {
  name: '查看远处的本地戏外聊天',
  category: 'ADMIN',
  description:
    '作为管理员时，是否查看任意位置的本地戏外聊天。',
  component: CheckboxInput,
};

export const enable_looc_runechat: FeatureToggle = {
  name: '启用本地戏外头顶聊天',
  category: 'RUNECHAT',
  description:
    "启用后，本地戏外聊天除了显示在聊天栏，还会显示在发言者头顶。",
  component: CheckboxInput,
};
