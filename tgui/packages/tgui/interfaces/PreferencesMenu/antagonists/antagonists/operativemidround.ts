import { type Antagonist, Category } from '../base';
import { OPERATIVE_MECHANICAL_DESCRIPTION } from './operative';

const OperativeMidround: Antagonist = {
  key: 'operativemidround',
  name: '核弹袭击者',
  description: [
    `
      核弹特工的一种形式，可在班次中途
      供幽灵玩家加入。
    `,
    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default OperativeMidround;
