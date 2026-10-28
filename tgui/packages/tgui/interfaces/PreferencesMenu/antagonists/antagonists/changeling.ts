import { type Antagonist, Category } from '../base';

export const CHANGELING_MECHANICAL_DESCRIPTION = `
改变自己或他人的身份，并利用收集的DNA
购买各种生物武器。
`;

const Changeling: Antagonist = {
  key: 'changeling',
  name: '变形怪',
  description: [
    `
      一种高度智慧的外星掠食者，能够改变
      自身形态，完美模仿人类。
    `,
    CHANGELING_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Changeling;
