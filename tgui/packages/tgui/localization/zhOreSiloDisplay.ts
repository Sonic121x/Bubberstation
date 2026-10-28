import { displayRole } from './roleDisplay';

const labels: Record<string, string> = {
  DEPOSITED: '存入', WITHDRAWN: '取出', PROCESSED: '加工', RESTOCKED: '补充',
  'NAME_RES_FAIL': '姓名读取失败', 'ASSGN-RES_FAIL': '职务读取失败',
  sheet: '片', sheets: '片',
};

export function oreSiloDisplay(value: string): string {
  return labels[value] ?? displayRole(value);
}
