import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureColorInput,
  type FeatureToggle,
} from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const screentip_color: Feature<string> = {
  name: '屏幕提示：颜色',
  category: 'UI',
  description: `
    鼠标悬停在对象上时显示的屏幕提示文字颜色。
  `,
  component: FeatureColorInput,
};

export const screentip_images: FeatureToggle = {
  name: '屏幕提示：允许图像',
  category: 'UI',
  description: `启用后，屏幕提示用鼠标按钮图像
    代替 LMB/RMB 文字。`,
  component: CheckboxInput,
};

export const screentip_pref: FeatureChoiced = {
  name: '屏幕提示：启用',
  category: 'UI',
  description: `
    启用鼠标悬停在对象上时显示的屏幕提示。
    设为“仅有操作提示时”后，只有在名称以外还有更多信息时才会显示，
    例如右键点击的作用。
  `,
  component: FeatureDropdownInput,
};
