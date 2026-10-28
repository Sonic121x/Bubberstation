import { type Antagonist, Category } from '../base';
import { OPERATIVE_MECHANICAL_DESCRIPTION } from './operative';

const ClownoOperativeMidround: Antagonist = {
  key: 'clownoperativemidround',
  name: '小丑捣蛋特工',
  description: [
    `
     在班次进行中向幽灵开放的
     一种小丑特工角色。
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default ClownoOperativeMidround;
