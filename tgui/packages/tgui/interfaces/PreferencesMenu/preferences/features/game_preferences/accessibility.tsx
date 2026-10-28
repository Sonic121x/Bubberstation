import { CheckboxInput, type Feature, type FeatureToggle, FeatureSliderInput } from '../base';

export const darkened_flash: FeatureToggle = {
  name: '启用暗色闪光',
  category: 'ACCESSIBILITY',
  description: `
    启用后，被闪光照射时屏幕会变暗，
    而不是变亮。
  `,
  component: CheckboxInput,
};

export const screen_shake_darken: FeatureToggle = {
  name: '屏幕震动时变暗',
  category: 'ACCESSIBILITY',
  description: `
      启用后，发生屏幕震动时屏幕会变暗。
    `,
  component: CheckboxInput,
};

export const remove_double_click: FeatureToggle = {
  name: '免用双击',
  category: 'ACCESSIBILITY',
  description: `
      启用后，需要双击的操作会提供替代方式，
      适合鼠标不太灵敏的情况。
    `,
  component: CheckboxInput,
};

export const min_recoil_multiplier: Feature<number> = {
  name: '视觉后坐力强度',
  category: 'ACCESSIBILITY',
  description: `
      调整后坐力视觉效果对镜头的影响强度。
      设为 0 将完全关闭视觉后坐力，但不影响实际后坐力机制。
    `,
  component: FeatureSliderInput,
};

export const stair_indicator: FeatureToggle = {
  name: '启用楼梯指示',
  category: 'ACCESSIBILITY',
  description: `
      启用后，楼梯会显示视觉指示，
      标明切换楼层时应行走的方向。
    `,
  component: CheckboxInput,
};

export const twelve_hour: FeatureToggle = {
  name: '十二小时制时钟',
  category: 'ACCESSIBILITY',
  description: `
      启用后，许多现实时间显示将改用带上午/下午标记的十二小时制。
    `,
  component: CheckboxInput,
};

