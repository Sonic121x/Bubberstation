// THIS IS A SKYRAT UI FILE
import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  type FeatureToggle,
} from '../../base';

export const echolocation_outline: Feature<string> = {
  name: '回声轮廓颜色',
  component: FeatureColorInput,
};

export const echolocation_use_echo: FeatureToggle = {
  name: '显示回声叠层',
  component: CheckboxInput,
};
