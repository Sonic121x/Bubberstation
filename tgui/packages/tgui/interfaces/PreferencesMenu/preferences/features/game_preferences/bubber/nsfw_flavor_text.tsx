import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const show_flavor_text_nsfw: FeatureChoiced = {
  name: '成人角色描述可见性',
  description:
    '选择成人角色描述的显示方式。硅基角色始终显示成人描述，除非设为“从不”。',
  category: 'ERP',
  component: FeatureDropdownInput,
};
