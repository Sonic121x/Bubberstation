// Only translate channel labels; commands and CSS selectors keep their original values.
const labels: Readonly<Record<string, string>> = {
  Command: '命令', Say: '说话', Me: '动作', Radio: '无线电', Whis: '低语',
  Admin: '管理员', Hive: '蜂巢', io: '二进制', Cmd: '指挥', Engi: '工程',
  Cling: '变形怪', Med: '医疗', Sci: '科研', AI: '人工智能', Ent: '娱乐',
  Sec: '安保', Synd: '辛迪加', Syndi: '辛迪加', Supp: '货运', Svc: '服务', CCom: '中央指挥部',
};

export function zhChatDisplay(value: string): string {
  return Object.hasOwn(labels, value) ? labels[value] : value;
}
