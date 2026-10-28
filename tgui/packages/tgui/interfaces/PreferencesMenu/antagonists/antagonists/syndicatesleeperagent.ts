import { type Antagonist, Category } from '../base';
import { TRAITOR_MECHANICAL_DESCRIPTION } from './traitor';

const SyndicateSleeperAgent: Antagonist = {
  key: 'syndicatesleeperagent',
  name: '辛迪加潜伏特工',
  description: [
    `
      叛徒的一种形式，可能在班次中途的
      任意时刻激活。
    `,
    TRAITOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
  priority: -1,
};

export default SyndicateSleeperAgent;
