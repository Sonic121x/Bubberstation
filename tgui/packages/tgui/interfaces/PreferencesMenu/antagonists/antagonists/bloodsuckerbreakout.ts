import { type Antagonist, Category } from '../base';

export const VAMPIRE_MECHANICAL_DESCRIPTION = `
死后苏醒，你发现自己变成了不死怪物。
尽情运用你的吸血鬼能力。
在空间站13艰难求生，或转化血仆，一路夺取空间站。
`;

const BloodsuckerBreakout: Antagonist = {
  key: 'bloodsuckerlatejoin',
  name: '吸血鬼（中途加入）',
  description: [VAMPIRE_MECHANICAL_DESCRIPTION],
  category: Category.Latejoin,
};

export default BloodsuckerBreakout;
