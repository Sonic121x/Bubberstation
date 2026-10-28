// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const dom_aura__prefers_males: Feature<boolean> = {
  name: '支配使用He/Him代词者',
  component: CheckboxInput,
};

export const dom_aura__prefers_females: Feature<boolean> = {
  name: '支配使用She/Her代词者',
  component: CheckboxInput,
};

export const dom_aura__prefers_plurals: Feature<boolean> = {
  name: '支配使用They/Them代词者',
  component: CheckboxInput,
};

export const dom_aura__prefers_neuters: Feature<boolean> = {
  name: '支配使用It/Its代词者',
  component: CheckboxInput,
};

export const dom_aura__prefers_other: Feature<boolean> = {
  name: '支配其他性别者',
  component: CheckboxInput,
};

export const dom_aura__snap: Feature<boolean> = {
  name: '使用*snap命令臣服者',
  component: CheckboxInput,
};

export const dom_aura__snap2: Feature<boolean> = {
  name: '使用*snap2命令臣服者',
  component: CheckboxInput,
};

export const dom_aura__snap3: Feature<boolean> = {
  name: '使用*snap3命令臣服者',
  component: CheckboxInput,
};

export const dom_aura__clicker: Feature<boolean> = {
  name: '使用响片命令臣服者',
  component: CheckboxInput,
};

export const dom_aura__sub_inspect_dom: Feature<boolean> = {
  name: '被臣服者检视时使其害羞',
  component: CheckboxInput,
  description:
    '取消勾选后，偏好相符的臣服者检视你时不会脸红并转身。',
};

export const dom_aura__sub_sense_dom: Feature<boolean> = {
  name: '气场',
  component: CheckboxInput,
  description:
    '取消勾选后，偏好相符的臣服者不会自动感知你的存在，也不会因靠近你而获得正面心情。',
};
