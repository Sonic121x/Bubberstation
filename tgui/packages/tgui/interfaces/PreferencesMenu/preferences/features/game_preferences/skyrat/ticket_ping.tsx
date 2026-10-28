// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const ticket_ping_pref: FeatureToggle = {
  name: '工单提醒',
  category: 'ADMIN',
  description:
    '启用后，会定期提醒你处理尚未受理的工单。',
  component: CheckboxInput,
};
