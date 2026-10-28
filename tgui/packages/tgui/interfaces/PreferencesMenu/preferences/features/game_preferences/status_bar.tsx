import { CheckboxInput, type FeatureToggle } from '../base';

export const status_bar: FeatureToggle = {
  name: '启用状态栏',
  category: 'UI',
  description: `
      启用后，屏幕左下角的状态栏会显示
      鼠标光标下对象的名称。
    `,
  component: CheckboxInput,
};
