import { CheckboxInput, type FeatureToggle } from '../../base';

export const be_round_removed: FeatureToggle = {
  name: '接受本回合出局',
  description:
    '向其他玩家表明你接受角色在本回合永久出局。',
  component: CheckboxInput,
};
