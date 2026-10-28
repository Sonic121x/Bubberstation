import { type Antagonist, Category } from '../base';

export const TRAITOR_MECHANICAL_DESCRIPTION = `
      开局获得上行链路，用它购买装备，执行邪恶的
      任务。逐步晋升，成为恶名远扬的传奇。
   `;

const Traitor: Antagonist = {
  key: 'traitor',
  name: '叛徒',
  description: [
    `
      一笔未偿的债，一场未报的仇。也许你只是在错误的时间
      出现在了错误的地方。无论原因如何，你都已获选
      潜入 13 号空间站。
    `,
    TRAITOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
  priority: -1,
};

export default Traitor;
