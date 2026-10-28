import { type Antagonist, Category } from '../base';

const BloodBrother: Antagonist = {
  key: 'bloodbrother',
  name: '血盟兄弟',
  description: [
    `
      与其他船员结为血盟兄弟，整合各自
      部门的优势，互相协助越狱，
      合力压倒整座空间站。
    `,
  ],
  category: Category.Roundstart,
};

export default BloodBrother;
