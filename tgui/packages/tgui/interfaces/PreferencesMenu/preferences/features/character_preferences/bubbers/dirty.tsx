import { FeatureColorInput, FeatureTextInput, type Feature } from '../../base';

export const dirty_quirk_color: Feature<string> = {
  name: '污垢颜色',
  component: FeatureColorInput,
};

export const dirty_quirk_text: Feature<string> = {
  name: '外观描述',
  description:
    '身上脏污时显示的描述。',
  component: FeatureTextInput,
};
