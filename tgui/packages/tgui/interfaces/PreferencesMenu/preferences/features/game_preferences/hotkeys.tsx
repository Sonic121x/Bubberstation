import { CheckboxInputInverse, type FeatureToggle } from '../base';

export const hotkeys: FeatureToggle = {
  name: '经典快捷键',
  category: 'GAMEPLAY',
  description:
    '启用后恢复旧版快捷键，使用输入栏而不是弹窗。',
  component: CheckboxInputInverse,
};
