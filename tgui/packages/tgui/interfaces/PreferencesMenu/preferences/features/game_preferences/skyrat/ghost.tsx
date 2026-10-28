// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const soulcatcher_join_action: FeatureToggle = {
  name: '进入灵魂捕手动作',
  category: 'GHOST',
  description:
    '是否显示作为幽灵进入灵魂捕手的动作按钮。无论此项如何设置，都可使用对应指令。',
  component: CheckboxInput,
};
