import { CheckboxInput, type FeatureToggle } from '../../base';

export const chat_examine_headshot: FeatureToggle = {
  name: '在查看消息中显示头像',
  category: 'GAMEPLAY',
  description: '角色有头像时，在聊天栏的查看信息中显示。',
  component: CheckboxInput,
};
