import { type Antagonist, Category } from '../base';

const Obsessed: Antagonist = {
  key: 'obsessed',
  name: '痴迷者',
  description: [
    `
    你痴迷于某个人！你的痴迷对象可能会发现
    私人物品被盗，同事接连失踪，
    但对方能否及时意识到自己就是你的下一个受害者？
    `,
  ],
  category: Category.Midround,
};

export default Obsessed;
