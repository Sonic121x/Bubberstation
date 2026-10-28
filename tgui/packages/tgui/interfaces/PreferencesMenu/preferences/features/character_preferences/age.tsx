import { type Feature, FeatureNumberInput } from '../base';

export const age: Feature<number> = {
  // name: 'Age', // ORIGINAL
  name: '生理年龄', // SKYRAT EDIT CHANGE - Chronological age
  // SKYRAT EDIT ADDITION BEGIN - Chronological age
  description:
    "生理年龄表示角色身心发育的程度。\
    包括正常衰老、使身体老化的经历，以及抗衰老医疗程序带来的变化。\
    不计入冷冻休眠时间。",
  // SKYRAT EDIT ADDITION END
  component: FeatureNumberInput,
};
