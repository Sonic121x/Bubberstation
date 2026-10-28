import { type Antagonist, Category } from '../base';
// BUBBER EDIT CHANGE - description completely rewritten
export const HERETIC_MECHANICAL_DESCRIPTION = `
      寻找隐藏的影响物及获取魔法力量的途径，
      选择一条道路，逐步变得强大。
   `;

const Heretic: Antagonist = {
  key: 'heretic',
  name: '侍徒', // BUBBER EDIT CHANGE - renamed to Acolyte
  description: [
    `
      遗忘、吞噬、掏空。人类早已忘却那些掌控腐朽的
      诡异力量，但漫宿的帷幕已然薄弱。我们将让他们
      再次品尝恐惧……
    `,
    HERETIC_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Heretic;
