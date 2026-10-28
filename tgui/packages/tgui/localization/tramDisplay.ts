import { chineseDisplay } from './zhDisplay';

const labels: Record<string, string> = {
  Arrivals: '抵达区', Service: '服务部', Command: '指挥部',
  Security: '安保部', Medical: '医疗部', Engineering: '工程部',
  Cargo: '货运部', Science: '科研部', Departures: '离站区',
  Reception: '接待处', Botany: '植物培育室', Chemistry: '化学室',
  Processing: '加工区', Xenobiology: '异种生物学实验室',
  Ordnance: '军械部', Office: '办公室', Dormitories: '宿舍',
  'Arrivals Terminal': '抵达航站楼', 'Cryogenic Sleepers': '低温休眠舱',
  'Main Station': '主站', 'Departures/Evac': '离站／撤离',
};

export const tramDisplay = (value: string) => labels[value] ?? chineseDisplay(value);
