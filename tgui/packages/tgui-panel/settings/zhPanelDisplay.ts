// Display labels only; settings values remain stable.
const labels: Readonly<Record<string, string>> = {
  default: '默认',
  Default: '默认',
  classic: '经典',
  scrollable: '可滚动',
  dark: '深色',
  light: '浅色',
};

export function zhPanelDisplay(value: string): string {
  return Object.hasOwn(labels, value) ? labels[value] : value;
}
