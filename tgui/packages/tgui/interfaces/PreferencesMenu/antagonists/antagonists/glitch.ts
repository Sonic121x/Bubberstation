import { type Antagonist, Category } from '../base';

const Glitch: Antagonist = {
  key: 'glitch',
  name: '系统故障',
  description: [
    `
    虚拟领域对比特潜行者而言危机四伏。让他们切身体会这一点。
    `,

    `
    你是一名短期反派，是系统中的故障。使用武术 \
    和致命武器消灭有机生命。
    `,
  ],
  category: Category.Midround,
};

export default Glitch;
