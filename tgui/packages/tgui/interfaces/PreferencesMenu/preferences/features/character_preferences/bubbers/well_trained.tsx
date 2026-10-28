// THIS IS A BUBBER UI FILE #BUBBERGANG😝
import { CheckboxInput, type Feature } from '../../base';

export const well_trained__prefers_males: Feature<boolean> = {
  name: '臣服于使用He/Him代词者',
  component: CheckboxInput,
};

export const well_trained__prefers_females: Feature<boolean> = {
  name: '臣服于使用She/Her代词者',
  component: CheckboxInput,
};

export const well_trained__prefers_plurals: Feature<boolean> = {
  name: '臣服于使用They/Them代词者',
  component: CheckboxInput,
};

export const well_trained__prefers_neuters: Feature<boolean> = {
  name: '臣服于使用It/Its代词者',
  component: CheckboxInput,
};

export const well_trained__prefers_other: Feature<boolean> = {
  name: '臣服于其他性别者',
  component: CheckboxInput,
};

export const well_trained__snap: Feature<boolean> = {
  name: '接受*snap命令',
  component: CheckboxInput,
};

export const well_trained__snap2: Feature<boolean> = {
  name: '接受*snap2命令',
  component: CheckboxInput,
};

export const well_trained__snap3: Feature<boolean> = {
  name: '接受*snap3命令',
  component: CheckboxInput,
};

export const well_trained__clicker: Feature<boolean> = {
  name: '接受响片命令',
  component: CheckboxInput,
};

export const well_trained__sub_inspect_dom: Feature<boolean> = {
  name: '检视支配者时感到害羞',
  component: CheckboxInput,
  description:
    '取消勾选后，检视偏好相符的支配者时不会脸红并转身。',
};

export const well_trained__sub_sense_dom: Feature<boolean> = {
  name: '支配者感知',
  component: CheckboxInput,
  description:
    '取消勾选后，不会自动感知偏好相符的支配者，也不会因靠近对方而获得正面心情。',
};
