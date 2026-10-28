import { CheckboxInput, type FeatureToggle } from '../../base';

export const resilient_traumas_permanent_traumas: FeatureToggle = {
  name: '永久脑创伤',
  description:
    '获得的脑创伤将变为永久，无法通过受祝福的神经切除术治愈。',
  component: CheckboxInput,
};

export const resilient_traumas_hardcore: FeatureToggle = {
  name: '硬核模式',
  description:
    '普通脑创伤只能通过神经切除术治愈；其余脑创伤将永久存在，或只能通过受祝福的神经切除术治愈。',
  component: CheckboxInput,
};
