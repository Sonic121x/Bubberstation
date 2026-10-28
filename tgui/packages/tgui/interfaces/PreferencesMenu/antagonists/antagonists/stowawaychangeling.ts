import { type Antagonist, Category } from '../base';
import { CHANGELING_MECHANICAL_DESCRIPTION } from './changeling';

const Stowaway_Changeling: Antagonist = {
  key: 'stowawaychangeling',
  name: '偷渡变形怪',
  description: [
    `
      一只悄悄混上穿梭机的变形怪，
      机上的船员毫不知情。
    `,
    CHANGELING_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Latejoin,
};

export default Stowaway_Changeling;
