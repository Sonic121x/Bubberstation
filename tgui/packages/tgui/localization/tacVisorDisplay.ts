const labels: Record<string, string> = {
  None: '无',
  Syndicate: '辛迪加',
  Crew: '船员',
  'Security & Command': '安保与指挥',
  CentCom: '中央指挥部',
  'Non-Allies': '非友军',
  Cross: '十字',
  Eyes: '眼睛',
  Line: '横线',
};

export const tacVisorDisplay = (value: string) => labels[value] ?? value;
