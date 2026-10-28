import { CheckboxInput, type FeatureToggle } from '../base';

// BUBBER EDIT START - Replaced with choiced dropdown in bubber/screen.tsx
/*
export const widescreenpref: FeatureToggle = {
  name: 'Enable widescreen',
  category: 'UI',
  component: CheckboxInput,
};
*/
// BUBBER EDIT END

export const fullscreen_mode: FeatureToggle = {
  name: '切换全屏',
  category: 'UI',
  description: '切换游戏全屏模式，也可按 F11 切换。',
  component: CheckboxInput,
};
