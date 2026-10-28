import { type Feature, FeatureShortTextInput } from '../../base';

export const nameless_quirk_name: Feature<string> = {
  name: '姓名前缀',
  description:
    '例如：（前缀）#1334。留空则默认使用职业名称，至少3个字符。',
  component: FeatureShortTextInput,
};
