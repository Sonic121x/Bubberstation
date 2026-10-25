import { radioDisplay } from './radioDisplay';

// Only known preset labels are localized; routing keys and custom text stay intact.
const labels: Readonly<Record<string, string>> = {
  tcommsat: '电信卫星网络',
  Hub: '集线器',
  'Broadcaster A': '广播器 A',
  'Broadcaster B': '广播器 B',
  'Receiver A': '接收器 A',
  'Receiver B': '接收器 B',
  'Processor 1': '处理器 1',
  'Processor 2': '处理器 2',
  'Processor 3': '处理器 3',
  'Processor 4': '处理器 4',
  'Bus 1': '总线 1',
  'Bus 2': '总线 2',
  'Bus 3': '总线 3',
  'Bus 4': '总线 4',
  'Station Relay': '空间站中继器',
  'Telecomms Relay': '电信中继器',
  'Mining Relay': '采矿中继器',
  'Ruskie Relay': '俄国中继器',
  'Messaging Server': '消息服务器',
  'Science Server': '科研服务器',
  'Medical Server': '医疗服务器',
  'Supply Server': '货运服务器',
  'Service & Entertainment Server': '服务与娱乐服务器',
  'Common & AI Server': '公共与 AI 服务器',
  'Command Server': '指挥服务器',
  'Engineering Server': '工程服务器',
  'Security Server': '安保服务器',
  'Corrupt File': '损坏文件',
  'Speech File': '语音文件',
  Normal: '普通',
  High: '高',
  Extreme: '极高',
  Undetermined: '未确定',
};

export const telecommsDisplay = (value: string): string =>
  Object.hasOwn(labels, value) ? labels[value] : radioDisplay(value);
