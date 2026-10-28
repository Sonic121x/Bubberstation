import { type Antagonist, Category } from '../base';
import { OPERATIVE_MECHANICAL_DESCRIPTION } from './operative';

const ClownOperative: Antagonist = {
  key: 'clownoperative',
  name: '小丑特工',
  description: [
    `
      Honk！不论是福是祸，你已被选中加入辛迪加
      小丑特工突击队。不管你是否愿意笑纳，
      任务都是把纳米传讯最先进的研究设施闹个天翻地覆！
      没错，你将前往小丑空间站13。
    `,

    OPERATIVE_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default ClownOperative;
