import { type Antagonist, Category } from '../base';

export const REVOLUTIONARY_MECHANICAL_DESCRIPTION = `
      手持闪光器，尽可能多地招募革命者。
      杀死或放逐空间站上的所有部门主管。
   `;

const HeadRevolutionary: Antagonist = {
  key: 'headrevolutionary',
  name: '革命领袖',
  description: ['革命万岁！', REVOLUTIONARY_MECHANICAL_DESCRIPTION],
  category: Category.Roundstart,
};

export default HeadRevolutionary;
