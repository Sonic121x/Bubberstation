import { type Antagonist, Category } from '../base';

const Cultist: Antagonist = {
  key: 'cultist',
  name: '血教徒',
  description: [
    `
      鲜血几何之神纳尔西派遣了一批信徒前往
      空间站13。身为血教徒，你拥有丰富的血教法术，
      足以应对各种情况。你必须与同胞协作，
      召唤邪异女神的化身！
    `,

    `
      运用鲜血魔法将船员转化为血教徒，献祭
      一切阻挠者，召唤纳尔西。
    `,
  ],
  category: Category.Roundstart,
};

export default Cultist;
