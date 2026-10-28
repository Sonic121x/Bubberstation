const labels: Record<string, string> = {
  alpha: '透明度', angular_blur: '角度模糊', bloom: '泛光',
  color: '颜色', displace: '置换', drop_shadow: '投影', blur: '模糊',
  layer: '图层', motion_blur: '运动模糊', outline: '轮廓',
  radial_blur: '径向模糊', rays: '光芒', ripple: '涟漪', wave: '波浪',
  x: '横坐标', y: '纵坐标', icon: '图标', render_source: '渲染来源',
  flags: '标志', size: '大小', offset: '偏移', radius: '半径',
  falloff: '衰减', density: '密度', threshold: '阈值', factor: '系数',
  repeat: '重复次数', space: '色彩空间', blend_mode: '混合模式', transform: '变换',
  MASK_INVERSE: '反转遮罩', MASK_SWAP: '交换遮罩',
  FILTER_OVERLAY: '上层叠加', FILTER_UNDERLAY: '下层叠加',
  OUTLINE_SHARP: '锐利轮廓', OUTLINE_SQUARE: '方形轮廓',
  WAVE_BOUNDED: '限制波浪范围', WAVE_SIDEWAYS: '横向波浪',
  FILTER_COLOR_RGB: 'RGB色彩空间', FILTER_COLOR_HSV: 'HSV色彩空间',
  FILTER_COLOR_HSL: 'HSL色彩空间', FILTER_COLOR_HCY: 'HCY色彩空间',
  BLEND_DEFAULT: '默认混合', BLEND_OVERLAY: '叠加混合',
  BLEND_ADD: '加法混合', BLEND_SUBTRACT: '减法混合',
  BLEND_MULTIPLY: '正片叠底', BLEND_INSET_OVERLAY: '内嵌叠加',
  'Not Set': '未设置',
};

export function filterDisplay(value: string): string {
  return Object.hasOwn(labels, value) ? `${labels[value]} (${value})` : value;
}
