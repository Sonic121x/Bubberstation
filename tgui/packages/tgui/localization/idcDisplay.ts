const forms: Record<string, string> = {
  symptom: '症状',
  condition: '病症',
  infection: '感染',
  parasite: '寄生虫',
  virus: '病毒',
  bacteria: '细菌',
  fungus: '真菌',
};
const codes: Record<string, string> = {
  症状: 'symptom',
  病症: 'condition',
  感染: 'infection',
  寄生虫: 'parasite',
  病毒: 'virus',
  细菌: 'bacteria',
  真菌: 'fungus',
  空气传播: 'airborne',
  空气: 'airborne',
  接触传播: 'contact',
  接触: 'contact',
  皮肤接触: 'skin contact',
  体液接触: 'fluid contact',
  血液: 'blood',
  无: 'none',
};
export const idcCode = (value: string) => codes[value] ?? value.toLowerCase();
export const idcDisplay = (value: string) => forms[value.toLowerCase()] ?? value;
