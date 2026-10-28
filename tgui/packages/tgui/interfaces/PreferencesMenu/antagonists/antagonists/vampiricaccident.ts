import { type Antagonist, Category } from '../base';

export const VAMPIRE_MECHANICAL_DESCRIPTION = `
死后，你再次醒来，发现自己成了不死怪物。
尽你所能运用吸血鬼的能力。
在 13 号空间站苟且求生，或将他人转化为血仆，夺取整个空间站。
`;

const VampiricAccident: Antagonist = {
  key: 'bloodsuckermidround',
  name: '吸血鬼（中途）',
  description: [VAMPIRE_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
};

export default VampiricAccident;
