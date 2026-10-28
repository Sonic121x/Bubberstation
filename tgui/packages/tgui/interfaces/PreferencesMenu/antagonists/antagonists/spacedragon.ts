import { type Antagonist, Category } from '../base';

const SpaceDragon: Antagonist = {
  key: 'spacedragon',
  name: '太空龙',
  description: [
    `
      成为凶猛的太空龙。喷吐火焰，召唤太空鲤鱼
      大军，撞碎墙壁，让整个空间站陷入恐慌。
    `,
  ],
  category: Category.Midround,
};

export default SpaceDragon;
