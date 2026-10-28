import { type Antagonist, Category } from '../base';
import { REVOLUTIONARY_MECHANICAL_DESCRIPTION } from './headrevolutionary';

const Provocateur: Antagonist = {
  key: 'provocateur',
  name: '煽动者',
  description: [
    `
      革命领袖的一种形式，可能在加入进行中的
      班次时激活。
    `,

    REVOLUTIONARY_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default Provocateur;
