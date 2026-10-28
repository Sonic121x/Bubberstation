import { type Antagonist, Category } from '../base';

const Fugitive: Antagonist = {
  key: 'fugitive',
  name: '逃犯',
  description: [
    `
    无论你来自哪里，你都在被追捕。你有 10 分钟的准备时间，
    随后赏金猎人就会抵达，开始追捕你和你的朋友！
    `,
  ],
  category: Category.Midround,
};

export default Fugitive;
