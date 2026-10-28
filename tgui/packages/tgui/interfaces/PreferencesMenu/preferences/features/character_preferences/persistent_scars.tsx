import { CheckboxInput, type FeatureToggle } from '../base';

export const persistent_scars: FeatureToggle = {
  name: '保留伤疤',
  description:
    '勾选后，如果你存活到回合结束，伤疤会保留到后续回合。',
  component: CheckboxInput,
};
