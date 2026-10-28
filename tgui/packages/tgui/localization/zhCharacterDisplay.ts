import { chineseDisplay } from './zhDisplay';
import { skyratAugmentDisplay } from './skyratSystemsDisplay';

const characterNames: Record<string, string> = {
  Head: '头部', Chest: '胸部', 'Left Hand': '左手', 'Right Hand': '右手',
  Brain: '大脑', Eyes: '眼睛', Tongue: '舌头', Ears: '耳朵',
  'Brain implant': '脑部植入体', 'Chest implant': '胸部植入体',
  'Eyes implant': '眼部植入体', 'Mouth implant': '口部植入体',
  'Left Arm implant': '左臂植入体', 'Right Arm implant': '右臂植入体',
};

const languageNames: Record<string, string> = {
  Carptongue: '鲤鱼语', Draconic: '龙语', Calcic: '骨语',
  Gibbering: '胡言乱语', 'Encoded Audio Language': '编码音频语言',
  Buzzwords: '嗡鸣语', Beachtongue: '海滩俚语', Codespeak: '暗语',
  'Galactic Common': '银河通用语', 'Sol Common': '太阳系通用语',
  Moffic: '蛾语', Mothic: '蛾语', Drone: '无人机语',
  Chimpanzee: '黑猩猩语', Mushroom: '蘑菇语', "Nar'Sian": '纳尔西语',
  Piratespeak: '海盗黑话', Nekomimetic: '猫语', Shadowtongue: '暗影语',
  Slime: '史莱姆语', Spinwarder: '顺旋语', Sylvan: '林语',
  Terrum: '岩语', 'Galactic Uncommon': '银河异通用语', Voltaic: '电语',
  Wormspeak: '虫语', Xenomorph: '异形语', Ratvarian: '拉特瓦尔语',
  Ættmál: '部族语', Ashtongue: '灰烬语', Canilunzt: '犬语',
  Chitinclick: '甲壳鸣语', Plutonian: '冥王星语', Skrelluq: '斯克雷尔语',
  Spacer: '太空人语', 'Te Velu Akko': '泰维鲁阿科语', 'Vox Pidgin': '沃克斯混合语',
  Xerxian: '薛西斯语', 'Martian Yangyu': '火星洋语', Konjin: '火星洋语',
  Marish: '玛尔语', Empathy: '共感语', 'Lesser Hivemind': '次级蜂巢意识',
  Interslavic: '斯拉夫共通语', 'Federation Legalese': '联邦法律语',
  "Siik'maas": '西克玛斯语', Enochian: '以诺语', 'Terran Uncommon': '地球异通用语',
  Schechi: '谢奇语',
};

export const characterDisplay = (value: string): string =>
  characterNames[value] ?? chineseDisplay(skyratAugmentDisplay(value));

export const characterOptions = (values: string[]) =>
  values.map((value) => ({ value, displayText: characterDisplay(value) }));

export const languageDisplay = (value: string): string =>
  languageNames[value] ?? value;
