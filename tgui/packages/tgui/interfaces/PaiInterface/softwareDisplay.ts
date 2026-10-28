const softwareNames: Record<string, string> = {
  'Atmospheric Sensor': '大气传感器',
  'Crew Manifest': '船员名单',
  'Crew Monitor': '船员监控',
  'Digital Messenger': '数字信使',
  'Door Jack': '门禁破解器',
  'Encryption Slot': '加密密钥插槽',
  'Host Scan': '宿主扫描',
  'Internal GPS': '内置 GPS',
  'Medical HUD': '医疗 HUD',
  'Music Synthesizer': '音乐合成器',
  Newscaster: '新闻播报器',
  'Photography Module': '摄影模块',
  'Remote Signaler': '远程信号器',
  'Security HUD': '安保 HUD',
  'Universal Translator': '通用翻译器',
};

export const softwareDisplay = (name: string): string => softwareNames[name] ?? name;
