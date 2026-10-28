const labels: Record<string, string> = {
  'Reaction Temp': '反应温度',
  'Forced Temp': '强制温度',
  'Minimum Temp': '最低温度',
  'Optimal Temp': '最佳温度',
  'Overheat Temp': '过热温度',
  'Next Reaction': '下一个反应',
  'Previous Reaction': '上一个反应',
  'Pick Reaction': '选择反应',
  'Required Temp': '所需温度',
  'Optimal Min Ph': '最佳 pH 下限',
  'Optimal Max Ph': '最佳 pH 上限',
  'Ph Range': 'pH 范围',
  'Temp Exp Factor': '温度指数因子',
  'Ph Exp Factor': 'pH 指数因子',
  'Thermic Constant': '热量常数',
  'H Ion Release': '氢离子释放量',
  'Rate Up Limit': '反应速率上限',
  'Purity Min': '最低纯度',
};

export const chemDebugDisplay = (value: string): string => labels[value] ?? value;
