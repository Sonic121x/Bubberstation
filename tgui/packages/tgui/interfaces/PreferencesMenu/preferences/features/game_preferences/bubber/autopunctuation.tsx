import { CheckboxInput, type FeatureToggle } from '../../base';

export const autopunctuation: FeatureToggle = {
  name: '自动标点',
  category: 'CHAT',
  description: '启用后，会为缺少标点的消息自动添加标点。',
  component: CheckboxInput,
};
