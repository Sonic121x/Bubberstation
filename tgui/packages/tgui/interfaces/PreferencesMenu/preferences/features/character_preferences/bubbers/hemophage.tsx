import { CheckboxInput, type FeatureToggle } from '../../base';

export const masquerade_toggle: FeatureToggle = {
  name: '启用或禁用避世伪装',
  description:
    '启用后可以进食，但无法获得营养。',
  component: CheckboxInput,
};

export const sol_weakness_toggle: FeatureToggle = {
  name: '启用或禁用日光弱点',
  description:
    '启用后，白天必须躲进棺材或柜子，否则可能被烧成灰烬。\
		好在棺材中治疗伤口的消耗也会减半。',
  component: CheckboxInput,
};

export const pseudo_respiration_toggle: FeatureToggle = {
  name: '启用或禁用拟态呼吸',
  description: '启用后能够再次呼吸。',
  component: CheckboxInput,
};
