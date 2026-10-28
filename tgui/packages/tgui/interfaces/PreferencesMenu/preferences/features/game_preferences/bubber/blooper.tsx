import { CheckboxInput, type FeatureToggle } from '../../base';

export const blooper_send: FeatureToggle = {
  name: '启用自己的说话音效',
  category: 'SOUND',
  description:
    '启用后，你的角色说话时会播放可自定义的音效。',
  component: CheckboxInput,
};

export const blooper_hear: FeatureToggle = {
  name: '启用其他人的说话音效',
  category: 'SOUND',
  description: `启用后，你可以听到其他角色的说话音效。`,
  component: CheckboxInput,
};
