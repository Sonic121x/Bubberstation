import { type Antagonist, Category } from '../base';

const Revenant: Antagonist = {
  key: 'revenant',
  name: '亡魂',
  description: [
    `
      成为神秘的亡魂。打碎窗户，让灯具过载，吞食
      船员的生命力，同时还能与你熟悉的那群
      满腹怨气的幽灵聊天。
    `,
  ],
  category: Category.Midround,
};

export default Revenant;
