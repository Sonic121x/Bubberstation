// THIS IS A SKYRAT UI FILE
import { type Feature, FeatureShortTextInput } from '../../base';

export const headshot: Feature<string> = {
  name: '头像',
  description:
    '链接必须以 .png、.jpeg 或 .jpg 结尾，以\
    https:// 开头，且托管于 Catbox、Imgbox、Gyazo、Lensdump 或 F-List。\
    图片将显示在详细查看窗口的角色预览下方。\
    大于 250x250 的图片会缩放为 250x250。\
    请尽量使用 250x250 的图片。',
  component: FeatureShortTextInput,
};
