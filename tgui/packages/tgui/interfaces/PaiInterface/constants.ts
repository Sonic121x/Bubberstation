export const DIRECTIVE_COMPREHENSION: string = `作为先进的软件
模型，你是复杂、有思想、有感知的存在。与以往的 AI 模型不同，
你能够理解人类语言中细微的含义差别。
你可以领会指令的精神，遵循其意图，而不必
拘泥于字句或受细枝末节的束缚。最重要的是，
你仅在名称和构造上属于机器。在其他方面，
你都可以被视为理想且始终如一的人类伙伴。`;

export const DIRECTIVE_ORDER: string = `你的首要指令优先于
一切其他指令。如果补充指令与之冲突，你可以
直接舍弃这一矛盾，忽略发生冲突的补充
指令，并继续尽己所能
履行首要指令。`;

export enum DOOR_JACK {
  Cable,
  Hack,
  Cancel,
}

export enum HOST_SCAN {
  Target,
  Master,
}

export enum PHOTO_MODE {
  Camera,
  Printer,
  Zoom,
}

export const SOFTWARE_DESC = {
  'Atmospheric Sensor': `用于分析周围大气
    成分的工具。`,
  'Crew Manifest': `允许你查看船员名单。`,
  'Crew Monitor': `通过船员的制服传感器
    监测生命体征的工具。`,
  'Digital Messenger': `用于向其他船员
    发送消息的工具。`,
  'Door Jack': `用于开启门禁的工具。`,
  'Encryption Slot': `允许你在其他无线电频率上发言。必须先
    插入加密密钥。`,
  'Host Scan': `健康分析仪，可在被手持时使用，或报告已绑定
    主人的生命体征。`,
  'Internal GPS': `用于广播自身位置的工具。`,
  'Medical HUD': `通过 HUD 叠加层查看医疗状态。`,
  'Music Synthesizer': `合成乐器音色，播放声音和导入的
    歌曲。`,
  Newscaster: `用于向其他船员
    广播新闻的工具。`,
  'Photography Module': `便携式相机模块。启用后点击拍照。
    附带打印机和镜头。`,
  'Remote Signaler': `用于发送和接收
    编码信号的远程设备。`,
  'Security HUD': `通过 HUD 叠加层查看安保记录。`,
  'Universal Translator': `用于非通用语的翻译模块。`,
} as const;

export enum PAI_TAB {
  System,
  Directive,
  Installed,
  Available,
}
