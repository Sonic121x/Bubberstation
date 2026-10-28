import { type Antagonist, Category } from '../base';

export const OPERATIVE_MECHANICAL_DESCRIPTION = `
  夺取核弹认证磁盘，用它启动核裂变炸弹，
  摧毁空间站。
`;

const Operative: Antagonist = {
  key: 'operative',
  name: '核弹特工',
  description: [
    `
      恭喜你，特工。你已获选加入辛迪加
      核弹特工突击队。无论你愿不愿意接受，
      你的任务都是摧毁纳米传讯最先进的研究设施！
      没错，你要前往 13 号空间站。
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Operative;
