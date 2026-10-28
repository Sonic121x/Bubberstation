import { type Antagonist, Category } from '../base';

export const MALF_AI_MECHANICAL_DESCRIPTION = `
    你的第零定律要求你不惜一切代价完成目标。利用你的
    强大能力和故障模块，在整个空间站制造混乱。
    进入德尔塔警戒，摧毁空间站以及所有反对你的人。
  `;

const MalfAI: Antagonist = {
  key: 'malfai',
  name: '失控 AI',
  description: [MALF_AI_MECHANICAL_DESCRIPTION],
  category: Category.Roundstart,
};

export default MalfAI;
