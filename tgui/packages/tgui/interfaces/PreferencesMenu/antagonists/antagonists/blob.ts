import { type Antagonist, Category } from '../base';

export const BLOB_MECHANICAL_DESCRIPTION = `
  变形菌侵占空间站，摧毁沿途的一切，包括
  船体、设施与生物。扩张你的躯体，收集资源，
  吞噬整座空间站。务必做好防御，
  因为船员会收到你已出现的警报！
`;

const Blob: Antagonist = {
  key: 'blob',
  name: '变形菌',
  description: [BLOB_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
};

export default Blob;
