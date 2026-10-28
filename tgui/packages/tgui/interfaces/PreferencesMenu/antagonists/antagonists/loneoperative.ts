import { type Antagonist, Category } from '../base';
import { OPERATIVE_MECHANICAL_DESCRIPTION } from './operative';

const LoneOperative: Antagonist = {
  key: 'loneoperative',
  name: '独狼特工',
  description: [
    `
      独自行动的核弹特工。核弹认证磁盘在同一个地方
      停留得越久，其出现的概率就越高。
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default LoneOperative;
