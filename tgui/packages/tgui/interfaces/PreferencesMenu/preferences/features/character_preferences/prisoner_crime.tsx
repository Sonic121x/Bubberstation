import type { FeatureChoiced } from '../base';
import { FeatureDropdownInput } from '../dropdowns';

export const prisoner_crime: FeatureChoiced = {
  name: '囚犯罪名',
  description:
    '作为囚犯时，这将被写入你的档案，作为你被捕的原因。',
  component: FeatureDropdownInput,
};
