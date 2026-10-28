import { CheckboxInput, type FeatureToggle } from '../base';

export const chat_bankcard: FeatureToggle = {
  name: '启用收入通知',
  category: 'CHAT',
  description: '接收你的银行账户通知。',
  component: CheckboxInput,
};

export const chat_dead: FeatureToggle = {
  name: '启用亡者频道',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const chat_ghostears: FeatureToggle = {
  name: '听见全部发言',
  category: 'GHOST',
  description: `
    启用后，作为幽灵时可以听见所有发言。
    关闭后，只能听见附近的发言。
  `,
  component: CheckboxInput,
};

export const chat_ghostlaws: FeatureToggle = {
  name: '启用定律变更通知',
  category: 'GHOST',
  description: '启用后，作为幽灵时会收到所有定律变更通知。',
  component: CheckboxInput,
};

export const chat_ghostpda: FeatureToggle = {
  name: '启用 PDA 通知',
  category: 'GHOST',
  description: '启用后，作为幽灵时会收到所有 PDA 消息通知。',
  component: CheckboxInput,
};

export const chat_ghostradio: FeatureToggle = {
  name: '启用无线电',
  category: 'GHOST',
  description: '启用后，作为幽灵时会收到所有无线电消息。',
  component: CheckboxInput,
};

export const chat_ghostsight: FeatureToggle = {
  name: '查看所有表情动作',
  category: 'GHOST',
  description: '启用后，作为幽灵时可以看见所有表情动作。',
  component: CheckboxInput,
};

export const chat_ghostwhisper: FeatureToggle = {
  name: '查看所有低语',
  category: 'GHOST',
  description: `
    启用后，作为幽灵时可以听见所有低语。
    关闭后，只能听见附近的低语。
  `,
  component: CheckboxInput,
};

export const chat_login_logout: FeatureToggle = {
  name: '查看登录和退出消息',
  category: 'GHOST',
  description: '启用后，玩家登录或退出时会收到通知。',
  component: CheckboxInput,
};

export const chat_ooc: FeatureToggle = {
  name: '启用戏外频道',
  category: 'CHAT',
  component: CheckboxInput,
};

export const chat_prayer: FeatureToggle = {
  name: '聆听祈祷',
  category: 'ADMIN',
  component: CheckboxInput,
};

export const chat_pullr: FeatureToggle = {
  name: '启用拉取请求通知',
  category: 'CHAT',
  description: '拉取请求被创建、关闭或合并时接收通知。',
  component: CheckboxInput,
};
