import { type Antagonist, Category } from '../base';

const BloodWormInfestation: Antagonist = {
  key: 'bloodworminfestation',
  name: '血虫侵袭',
  description: [
    `
      成为巨型寄生血虫，从幼虫开始，侵占宿主，
      吞食鲜血，与同胞一起征服整座空间站！
    `,
  ],
  category: Category.Midround,
};

export default BloodWormInfestation;
