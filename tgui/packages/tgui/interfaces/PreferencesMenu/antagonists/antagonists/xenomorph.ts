import { type Antagonist, Category } from '../base';

const Xenomorph: Antagonist = {
  key: 'xenomorph',
  name: '异形',
  description: [
    `
      成为外星异形。从幼体开始，逐步晋升
      阶级，甚至成为女王！
    `,
  ],
  category: Category.Midround,
};

export default Xenomorph;
