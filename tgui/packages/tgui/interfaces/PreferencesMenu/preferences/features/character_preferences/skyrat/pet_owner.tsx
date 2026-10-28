// THIS IS A SKYRAT UI FILE
import {
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const pet_owner: FeatureChoiced = {
  name: '宠物种类',
  component: FeatureDropdownInput,
};

export const pet_name: Feature<string> = {
  name: '宠物名字',
  description:
    "留空时使用生物的默认名字，例如“美西螈”或“龙猫”。",
  component: FeatureShortTextInput,
};

export const pet_desc: Feature<string> = {
  name: '宠物描述',
  description: "留空时使用生物的默认描述。",
  component: FeatureShortTextInput,
};
