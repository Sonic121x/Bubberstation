import { type Antagonist, Category } from '../base';

const BloodWorm: Antagonist = {
  key: 'bloodworm',
  name: '血虫',
  description: [
    `
      成为巨型寄生血虫，从宿主体内的幼虫开始，
      吞食鲜血，与同胞一起征服整座空间站！
    `,
  ],
  category: Category.Roundstart,
};

export default BloodWorm;
