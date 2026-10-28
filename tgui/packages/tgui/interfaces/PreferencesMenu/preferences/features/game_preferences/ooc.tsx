import { type Feature, FeatureColorInput } from '../base';

export const ooccolor: Feature<string> = {
  name: '戏外消息颜色',
  category: 'CHAT',
  description: '你在戏外频道发送的消息颜色。',
  component: FeatureColorInput,
};
