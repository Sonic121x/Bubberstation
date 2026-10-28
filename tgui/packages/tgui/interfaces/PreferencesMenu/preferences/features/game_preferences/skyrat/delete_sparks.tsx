// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const delete_sparks_pref: FeatureToggle = {
  name: '删除火花',
  category: 'ADMIN',
  description:
    '管理员删除对象时，是否播放火花动画。',
  component: CheckboxInput,
};
