import {
  type Feature,
  FeatureNumberInput,
} from '../../base';

export const cursekin_char_slot: Feature<number> = {
  name: '狼人角色槽位',
  description:
    "变身时使用的狼人角色槽位编号，按从上到下的顺序计数。\
    不加载怪癖、植入物或设定姓名。若选择非狼人角色槽位，则仅切换种族，不加载槽位。",
  component: FeatureNumberInput,
};
