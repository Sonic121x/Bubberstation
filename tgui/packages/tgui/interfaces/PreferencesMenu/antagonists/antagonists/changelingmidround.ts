import { type Antagonist, Category } from '../base';
import { CHANGELING_MECHANICAL_DESCRIPTION } from './changeling';

const ChangelingMidround: Antagonist = {
  key: 'changelingmidround',
  name: '太空变形怪',
  description: [
    `
    中途出现的变形怪没有船员身份，而是从
    太空抵达。这比开局担任变形怪更困难！
    `,
    CHANGELING_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default ChangelingMidround;
