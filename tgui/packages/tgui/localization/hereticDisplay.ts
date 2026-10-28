const themeSuffixes: Record<string, string> = {
  灰烬之道: 'AshPath',
  锈蚀之道: 'RustPath',
  血肉之道: 'FleshPath',
  虚空之道: 'VoidPath',
  刀锋之道: 'BladePath',
  星辰之道: 'CosmicPath',
  启锁之道: 'LockPath',
  月华之道: 'MoonPath',
};

export function hereticThemeSuffix(route: string): string {
  return themeSuffixes[route] ?? route.replace(' ', '');
}

export function hereticComplexityDisplay(value: string): string {
  const labels: Record<string, string> = {
    Easy: '简单',
    Medium: '中等',
    Hard: '困难',
    Varies: '因情况而异',
    Insane: '极难',
  };
  return labels[value] ?? value;
}
