import { type Antagonist, Category } from '../base';

const Spy: Antagonist = {
  key: 'spy',
  name: '间谍',
  description: [
    `
      如果你选择接受，你的任务是：潜入 13 号空间站。
      伪装成船员，窃取关键设备。
      如果你被捕或死亡，你的雇主将否认知晓
      你的一切行动。祝你好运，特工。
    `,

    `
      完成间谍悬赏，从雇主那里获取奖励。
      利用这些奖励制造混乱和恶作剧！
    `,
  ],
  category: Category.Roundstart,
};

export default Spy;
