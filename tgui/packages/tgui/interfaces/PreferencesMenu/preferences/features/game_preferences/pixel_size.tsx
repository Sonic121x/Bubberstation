import { createDropdownInput, type Feature } from '../base';

export const pixel_size: Feature<number> = {
  name: '像素缩放',
  category: 'UI',
  component: createDropdownInput({
    0: '拉伸适配',
    1: '像素精确 1 倍',
    1.5: '像素精确 1.5 倍',
    2: '像素精确 2 倍',
    3: '像素精确 3 倍',
    4: '像素精确 4 倍',
    4.5: '像素精确 4.5 倍',
    5: '像素精确 5 倍',
    6: '像素精确 6 倍',
    7: '像素精确 7 倍',
    8: '像素精确 8 倍',
    9: '像素精确 9 倍',
  }),
};
