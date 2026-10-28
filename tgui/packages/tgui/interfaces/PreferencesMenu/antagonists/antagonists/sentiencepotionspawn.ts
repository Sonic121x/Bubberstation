import { type Antagonist, Category } from '../base';

const SentientCreature: Antagonist = {
  key: 'sentiencepotionspawn',
  name: '智慧生物',
  description: [
    `
		无论是宇宙中的偶然，还是船员胡闹的结果，你获得了
		智慧！
	  `,

    `
		这项偏好涵盖多种角色。较友善的角色包括随机获得人类
		水平智慧的事件角色、货运大猩猩，以及通过启智药水
		获得智慧的生物。较危险的角色包括鼠王，以及强化后的
		矿区精英生物。
	  `,
  ],
  category: Category.Midround,
};

export default SentientCreature;
