const ticketActions: Record<string, string> = {
  Reconnected: '重新连接',
  'Ticket Opened': '工单已创建',
  Reopened: '重新打开',
  Closed: '已关闭',
  Resolved: '已解决',
  Rejected: '已驳回',
  'IC Issue': '角色内问题',
  Interaction: '交互',
  Reply: '回复',
};

export const ticketActionDisplay = (value: string) => ticketActions[value] ?? value;

export function ticketMessageDisplay(action: string, message: string): string {
  if (action === 'Reconnected' && message === 'Client reconnected') {
    return '客户端已重新连接';
  }
  const prefixes: Record<string, [string, string]> = {
    Reopened: ['Reopened by ', '重新打开工单：'],
    Closed: ['Closed by ', '关闭工单：'],
    Resolved: ['Resolved by ', '解决工单：'],
    Rejected: ['Rejected by ', '驳回工单：'],
    'IC Issue': ['Marked as IC issue by ', '标记为角色内问题：'],
  };
  const prefix = prefixes[action];
  return prefix && message.startsWith(prefix[0])
    ? prefix[1] + message.slice(prefix[0].length)
    : message;
}
