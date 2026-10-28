export const CRIMESTATUS2COLOR = {
  Arrest: 'bad',
  Discharged: 'blue',
  Incarcerated: 'average',
  Parole: 'good',
  Suspected: 'teal',
} as const;

export const CRIMESTATUS2DESC = {
  Arrest: '逮捕。目标必须有有效罪名才能设置此状态。',
  Discharged: '无罪释放。此人已被判定无罪。',
  Incarcerated: '监禁。此人正在服刑。',
  Parole: '假释。已出狱，但仍受监管。',
  Suspected: '嫌疑。密切监视其是否有犯罪行为。',
} as const;
