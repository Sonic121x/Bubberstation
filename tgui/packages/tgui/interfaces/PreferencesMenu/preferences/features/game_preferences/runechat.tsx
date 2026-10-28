import {
  CheckboxInput,
  FeatureNumberInput,
  type FeatureNumeric,
  type FeatureToggle,
} from '../base';

export const chat_on_map: FeatureToggle = {
  name: '启用头顶聊天',
  category: 'RUNECHAT',
  description: '在头顶显示聊天消息。',
  component: CheckboxInput,
};

export const see_chat_non_mob: FeatureToggle = {
  name: '启用物体上方聊天',
  category: 'RUNECHAT',
  description: '物体说话时，在其上方显示聊天消息。',
  component: CheckboxInput,
};

export const chat_on_ghosts: FeatureToggle = {
  name: '启用幽灵头顶聊天',
  category: 'RUNECHAT',
  description: '幽灵说话时，在其上方显示聊天消息。',
  component: CheckboxInput,
};

export const see_rc_emotes: FeatureToggle = {
  name: '启用头顶表情动作',
  category: 'RUNECHAT',
  description: '在头顶显示表情动作。',
  component: CheckboxInput,
};

export const max_chat_length: FeatureNumeric = {
  name: '最大聊天长度',
  category: 'RUNECHAT',
  description: '头顶聊天消息显示的最大长度。',
  component: FeatureNumberInput,
};
