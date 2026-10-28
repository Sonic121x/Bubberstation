import { CheckboxInput, type FeatureToggle } from '../../base';

export const mapvote_hud: FeatureToggle = {
  name: '在屏幕界面中显示投票',
  category: 'UI',
  description:
    '在屏幕右上角的界面中显示新发起的投票。',
  component: CheckboxInput,
};

export const mapvote_autoclose: FeatureToggle = {
  name: '投票后自动关闭投票界面',
  category: 'UI',
  description:
    '选定选项后，自动关闭屏幕上的投票界面。',
  component: CheckboxInput,
};
