import {
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const hypnotic_quirk_text: Feature<string> = {
  name: '催眠检视文本',
  description:
    '检视角色时显示的文本。请使用第三人称，例如“他”“她”“他们”。',
  component: FeatureShortTextInput,
};

export const flashy_text: FeatureChoiced = {
  name: '文本颜色选择',
  component: FeatureDropdownInput,
};
