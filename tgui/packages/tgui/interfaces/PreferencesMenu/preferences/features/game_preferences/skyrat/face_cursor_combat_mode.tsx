// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const face_cursor_combat_mode: FeatureToggle = {
  name: '战斗模式下面向光标',
  category: 'GAMEPLAY',
  description: `
    启用后，在战斗模式下
    你会面向鼠标光标。
  `,
  component: CheckboxInput,
};
