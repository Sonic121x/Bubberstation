import { CheckboxInput, type FeatureToggle } from '../base';

export const typingIndicator: FeatureToggle = {
  name: '显示自己的输入指示',
  category: 'GAMEPLAY',
  description: "显示你正在输入消息的指示标记。",
  component: CheckboxInput,
};
