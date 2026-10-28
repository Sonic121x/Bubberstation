import { type Antagonist, Category } from '../base';
import { BLOB_MECHANICAL_DESCRIPTION } from './blob';

const BlobInfection: Antagonist = {
  key: 'blobinfection',
  name: '变形菌感染',
  description: [
    `
      在班次进行中的任意时刻受到感染，
      随后变成可怕的变形菌。
    `,
    BLOB_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Midround,
};

export default BlobInfection;
