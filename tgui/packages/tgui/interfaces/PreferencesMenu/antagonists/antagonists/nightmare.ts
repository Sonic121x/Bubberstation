import { type Antagonist, Category } from '../base';

const Nightmare: Antagonist = {
  key: 'nightmare',
  name: '梦魇',
  description: [
    `
      使用噬光之刃摧毁光源，生存并壮大。
      穿行于黑暗之中，利用夜视能力寻找猎物。
    `,
  ],
  category: Category.Midround,
};

export default Nightmare;
