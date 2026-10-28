import { CheckboxInput, type FeatureToggle } from '../base';

export const windowflashing: FeatureToggle = {
  name: '启用窗口闪烁',
  category: 'UI',
  description: `
    启用后，某些重要事件会让游戏图标
    在任务栏中闪烁。
  `,
  component: CheckboxInput,
};
