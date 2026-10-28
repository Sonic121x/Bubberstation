import { CheckboxInput, type FeatureToggle } from '../base';

export const tgui_input: FeatureToggle = {
  name: '输入：启用 TGUI',
  category: 'UI',
  description: '使用 TGUI 显示输入框。',
  component: CheckboxInput,
};

export const tgui_input_large: FeatureToggle = {
  name: '输入：较大按钮',
  category: 'UI',
  description: '让 TGUI 按钮采用更实用的现代布局。',
  component: CheckboxInput,
};

export const tgui_input_swapped: FeatureToggle = {
  name: '输入：交换提交和取消按钮',
  category: 'UI',
  description: '让 TGUI 按钮采用更实用的现代布局。',
  component: CheckboxInput,
};

export const tgui_lock: FeatureToggle = {
  name: '将 TGUI 锁定在主显示器',
  category: 'UI',
  description: '将 TGUI 窗口限制在主显示器上。',
  component: CheckboxInput,
};

export const tgui_unlimited_windows: FeatureToggle = {
  name: '解除 TGUI 窗口数量限制',
  category: 'UI',
  description:
    '解除 TGUI 窗口数量限制。打开超过 5 个窗口可能严重影响低配置电脑的性能。',
  component: CheckboxInput,
};

export const ui_scale: FeatureToggle = {
  name: '切换界面缩放',
  category: 'UI',
  description: '界面是否随显示器缩放设置放大。',
  component: CheckboxInput,
};

export const tgui_say_light_mode: FeatureToggle = {
  name: '发言：浅色模式',
  category: 'UI',
  description: '让 TGUI 发言窗口使用浅色模式。',
  component: CheckboxInput,
};
