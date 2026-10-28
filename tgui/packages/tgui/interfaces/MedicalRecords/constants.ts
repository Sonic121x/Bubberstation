export const PHYSICALSTATUS2ICON = {
  Active: 'person-running',
  Debilitated: 'crutch',
  Unconscious: 'moon-o',
  Deceased: 'skull',
};

export const PHYSICALSTATUS2COLOR = {
  Active: 'green',
  Debilitated: 'purple',
  Unconscious: 'orange',
  Deceased: 'red',
} as const;

export const PHYSICALSTATUS2DESC = {
  Active: '正常。该人员意识清醒，身体健康。',
  Debilitated: '虚弱。该人员意识清醒，但健康状况不佳。',
  Unconscious: '昏迷。该人员可能需要医疗救治。',
  Deceased: '死亡。该人员已死亡，并开始腐烂。',
} as const;

export const MENTALSTATUS2ICON = {
  Stable: 'face-smile-o',
  Watch: 'eye-o',
  Unstable: 'scale-unbalanced-flip',
  Insane: 'head-side-virus',
};

export const MENTALSTATUS2COLOR = {
  Stable: 'green',
  Watch: 'purple',
  Unstable: 'orange',
  Insane: 'red',
} as const;

export const MENTALSTATUS2DESC = {
  Stable: '稳定。该人员神志正常，无心理障碍。',
  Watch:
    '留观。该人员有精神疾病症状，请密切观察。',
  Unstable: '不稳定。该人员患有一种或多种精神疾病。',
  Insane: '精神失常。该人员表现出严重的异常精神行为。',
} as const;
