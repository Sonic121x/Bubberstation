// THIS IS A SKYRAT SECTOR UI FILE
import { type Feature, FeatureNumberInput } from '../../base';

export const chrono_age: Feature<number> = {
  name: '年龄（实际历年）',
  description:
    '实际历年年龄表示角色自出生以来在宇宙中实际存在的时间。\
    包括低温休眠时间，以及处于重力或速度导致时间膨胀的区域内的时间。',
  component: FeatureNumberInput,
};
