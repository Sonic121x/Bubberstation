const doomMessages = [
  '买黄金！',
  '低买高卖！',
  '投资加密货币！',
  '把一切都卖掉！',
  '经济正在崩溃！',
  '经济完蛋了！',
  '市场正在暴跌！',
  '空间站要破产了！',
];

// Used when the economy is crashing to get a random funny message.
export function getRandomDoomMessage(): string {
  return doomMessages[Math.floor(Math.random() * doomMessages.length)];
}
