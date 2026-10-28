import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  FeatureShortTextInput,
  FeatureTextInput,
  FeatureTriColorInput,
  type FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const emote_length: FeatureChoiced = {
  name: '偏好的动作描述长度',
  category: 'ADVERT',
  description:
    '角色扮演时偏好的动作描述长度，如有。显示在角色招募信息中。',
  component: FeatureDropdownInput,
};

export const approach_pref: FeatureChoiced = {
  name: '偏好的接洽方式',
  category: 'ADVERT',
  description:
    '希望别人如何与你接洽角色扮演，或是否接受接洽。显示在角色招募信息中。',
  component: FeatureDropdownInput,
};

export const furry_pref: FeatureChoiced = {
  name: '吸引偏好：毛绒兽人',
  category: 'ADVERT',
  description:
    '是否愿意以及如何与拟人兽、鸟人或昆虫人等兽人角色扮演。',
  component: FeatureDropdownInput,
};

export const scalie_pref: FeatureChoiced = {
  name: '吸引偏好：鳞族',
  category: 'ADVERT',
  description:
    '是否愿意以及如何与蜥蜴、鱼或龙等鳞族角色扮演。',
  component: FeatureDropdownInput,
};

export const other_pref: FeatureChoiced = {
  name: '吸引偏好：其他种族',
  category: 'ADVERT',
  description:
    '是否愿意以及如何与硅基生命、半人兽、巨型生物和异形等特殊角色扮演。',
  component: FeatureDropdownInput,
};

export const demihuman_pref: FeatureChoiced = {
  name: '吸引偏好：亚人',
  category: 'ADVERT',
  description:
    '是否愿意以及如何与猫耳人、犬耳人、魔物人或恶魔等亚人角色扮演。',
  component: FeatureDropdownInput,
};

export const human_pref: FeatureChoiced = {
  name: '吸引偏好：人类',
  category: 'ADVERT',
  description:
    '是否愿意以及如何与人类角色扮演。你知道人类是什么。',
  component: FeatureDropdownInput,
};

export const character_ad: Feature<string> = {
  name: '角色招募信息',
  description:
    '为角色撰写的扮演招募信息。说明你希望进行何种扮演，以及如何接洽，尽量写得具体。',
  component: FeatureTextInput,
};

export const attraction: FeatureChoiced = {
  name: '角色吸引偏好',
  description:
    '角色会被什么对象吸引。显示在角色名录中。',
  component: FeatureDropdownInput,
};

export const display_gender: FeatureChoiced = {
  name: '角色性别',
  description:
    '角色的性别认同。显示在角色名录中。',
  component: FeatureDropdownInput,
};

export const flavor_text_nsfw: Feature<string> = {
  name: '外观描述（成人内容）',
  description:
    '外观描述中的成人内容部分，用于记录可见的性特征细节。',
  component: FeatureTextInput,
};

export const low_arousal_text: Feature<string> = {
  name: '性兴奋描述——轻度',
  description: '角色轻度性兴奋时可被观察到的表现。',
  component: FeatureShortTextInput,
};

export const medium_arousal_text: Feature<string> = {
  name: '性兴奋描述——中度',
  description: '角色中度性兴奋时可被观察到的表现。',
  component: FeatureShortTextInput,
};

export const high_arousal_text: Feature<string> = {
  name: '性兴奋描述——强烈',
  description: '角色强烈性兴奋时可被观察到的表现。',
  component: FeatureShortTextInput,
};

export const silicon_flavor_text_nsfw: Feature<string> = {
  name: '硅基角色成人外观描述',
  description:
    '检视硅基角色时显示的成人外观描述，用于记录可见的性特征细节。',
  component: FeatureTextInput,
};

export const headshot_silicon: Feature<string> = {
  name: '硅基角色头像',
  description:
    '链接须以.png、.jpeg或.jpg结尾，以\
  https://开头，托管于Catbox、Imgbox、Gyazo、Lensdump或F-List。\
  图像会显示在详细检视窗口的角色预览下方。\
  超过250×250的图像会缩放至250×250。\
  请尽量使用250×250的图像。',
  component: FeatureShortTextInput,
};

export const headshot_nsfw: Feature<string> = {
  name: '头像（成人内容）',
  description:
    '用于成人内容参考的头像。\
    链接须以.png、.jpeg或.jpg结尾，以\
    https://开头，托管于Catbox、Imgbox、Gyazo、Lensdump或F-List。\
    图像会显示在详细检视窗口的角色预览下方。\
    超过250×250的图像会缩放至250×250。\
    请尽量使用250×250的图像。',
  component: FeatureShortTextInput,
};

export const headshot_silicon_nsfw: Feature<string> = {
  name: '硅基角色头像（成人内容）',
  description:
    '用于硅基角色成人内容参考的头像。\
    链接须以.png、.jpeg或.jpg结尾，以\
    https://开头，托管于Catbox、Imgbox、Gyazo、Lensdump或F-List。\
    图像会显示在详细检视窗口的角色预览下方。\
    超过250×250的图像会缩放至250×250。\
    请尽量使用250×250的图像。',
  component: FeatureShortTextInput,
};

export const ooc_notes_silicon: Feature<string> = {
  name: '场外备注（硅基角色）',
  description: '与场外备注相同，但用于你的硅基角色！',
  component: FeatureTextInput,
};

export const custom_species_silicon: Feature<string> = {
  name: '硅基角色型号名称',
  description:
    '硅基角色所属公司的型号名称，例如“阿玛达因享乐型”。',
  component: FeatureShortTextInput,
};

export const custom_species_lore_silicon: Feature<string> = {
  name: '硅基角色型号背景',
  description:
    '硅基角色的背景，通常包括所属公司、制造商、型号以及诞生经过。',
  component: FeatureTextInput,
};

export const art_ref: Feature<string> = {
  name: '美术参考图',
  description:
    '供其他人查看的角色美术参考图。\
    链接须以.png、.jpeg或.jpg结尾，以\
    https://开头，托管于Catbox、Imgbox、Gyazo、Lensdump或F-List。',
  component: FeatureShortTextInput,
};

export const art_ref_nsfw: FeatureToggle = {
  name: '美术参考图（成人内容）',
  description: '参考图是否含有成人内容？',
  component: CheckboxInput,
};

export const mutant_colors_color: Feature<string[]> = {
  name: '身体颜色',
  component: FeatureTriColorInput,
  description: '非人类种族使用的身体颜色。',
};
