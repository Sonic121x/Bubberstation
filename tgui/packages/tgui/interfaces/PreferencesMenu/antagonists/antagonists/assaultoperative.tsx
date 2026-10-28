// THIS IS A SKYRAT UI FILE
import { type Antagonist, Category } from '../base';

export const OPERATIVE_MECHANICAL_DESCRIPTION = `
  尽可能取得黄金眼认证密钥，并用它们启动
  黄金眼。密钥由纳米传讯主管的心智碎片生成，
  使用审讯器提取这些心智碎片。
`;

const AssaultOperative: Antagonist = {
  key: 'assaultoperative',
  name: '突击特工',
  description: [
    `
      下午好，0013。你已被选中加入精锐突击小队，
      负责寻找并制造黄金眼密钥。你的任务是
      获取密钥，利用纳米传讯的黄金眼防御网络反击其自身。
      黄金眼网络需要3枚密钥才能启动。
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default AssaultOperative;
