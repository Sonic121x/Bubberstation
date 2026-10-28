// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const emote_panel: FeatureToggle = {
  name: '表情动作面板',
  category: 'CHAT',
  description: '切换表情动作面板；游戏中修改后需重新连接才能生效。',
  component: CheckboxInput,
};
