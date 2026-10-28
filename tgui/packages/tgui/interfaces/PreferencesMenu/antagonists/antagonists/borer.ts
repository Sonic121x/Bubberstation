import { type Antagonist, Category } from '../base';

export const BORER_MECHANICAL_DESCRIPTION = `
一种会钻进人类大脑的小型蠕行怪物。
感染宿主，生长并繁殖。
成为有用的帮手，强化宿主；或大开杀戒，统治空间站。
`;

const Borer: Antagonist = {
  key: 'borer',
  name: '皮层钻虫',
  description: [BORER_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
  priority: -1,
};

export default Borer;
