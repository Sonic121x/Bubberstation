import { type Antagonist, Category } from '../base';

export const WIZARD_MECHANICAL_DESCRIPTION = `
      从多种强大法术中做出选择，
      在 13 号空间站制造混乱。
    `;

const Wizard: Antagonist = {
  key: 'wizard',
  name: '巫师',
  description: [
    `“你们好。我们是巫师联邦的巫师。”`,
    WIZARD_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Wizard;
