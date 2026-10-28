import { displayRole } from './roleDisplay';

const labels: Record<string, string> = {
  Health: '健康', Orbiters: '跟随者', Department: '部门',
  cargo: '货运', command: '指挥', engineering: '工程', medical: '医疗',
  science: '科研', security: '安保', service: '服务',
  Abductors: '绑架者', 'Ash Walkers': '灰行者', Biohazards: '生物危害',
  'Bounty Hunters': '赏金猎人', CentCom: '中央指挥部',
  'Digital Anomalies': '数字异常', 'Emergency Response Team': '紧急响应小队',
  'Escaped Fugitives': '逃犯', 'Xenomorph Infestation': '异形侵袭',
  'Spacetime Aberrations': '时空畸变', 'Deviant Crew': '异常船员',
  'Invasive Overgrowth': '入侵性蔓生植物',
};

export function orbitDisplay(value: string): string {
  return labels[value] ?? displayRole(value);
}
