import { createDropdownInput, type Feature } from '../base';

export const scaling_method: Feature<string> = {
  name: '缩放方式',
  category: 'UI',
  component: createDropdownInput({
    blur: '双线性插值',
    distort: '最近邻插值',
    normal: '点采样',
  }),
};
