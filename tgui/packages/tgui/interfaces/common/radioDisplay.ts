// Display labels only; callers must retain the original channel for actions.
const radioDisplayNames: Readonly<Record<string, string>> = {
  Common: '公共',
  Security: '安保',
  Engineering: '工程',
  Command: '指挥',
  Science: '科研',
  Medical: '医疗',
  Supply: '后勤',
  Service: '服务',
  'AI Private': 'AI 专用',
  Entertainment: '娱乐',
  Syndicate: '辛迪加',
  CentCom: '中央指挥部',
  Uplink: '上行链路',
  'Red Team': '红队',
  'Blue Team': '蓝队',
  'Green Team': '绿队',
  'Yellow Team': '黄队',
  Cybersun: '赛博太阳',
  Interdyne: '英特戴恩',
  Guild: '公会',
  Tarkon: '塔肯',
  TARKON: '塔肯',
  TerraGov: '地球政府',
  Faction: '派系',
  Nanotrasen: '纳米传讯',
  NANOTRASEN: '纳米传讯',
  Binary: '二进制',
};

export const radioDisplay = (channel: string): string =>
  Object.hasOwn(radioDisplayNames, channel)
    ? radioDisplayNames[channel]
    : channel;
