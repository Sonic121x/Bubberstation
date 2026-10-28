import { CheckboxInput, type FeatureToggle } from '../../base';

export const ready_job: FeatureToggle = {
  name: '显示准备职业',
  category: 'UI',
  description:
    '是否在开局前的职业估计面板中显示你优先级最高的职业。',
  component: CheckboxInput,
};
