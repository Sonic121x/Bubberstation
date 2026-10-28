// Keep interaction identifiers unchanged when sending actions to the backend.
const labels: Readonly<Record<string, string>> = {
  penis: '阴茎',
  vagina: '阴道',
  anus: '肛门',
  nipples: '乳头',
  Beckon: '招手', Cheer: '加油', Fistbump: '碰拳', Handshake: '握手',
  Headpat: '摸头', Highfive: '击掌', Pat: '拍肩', Salute: '敬礼',
  Miscellaneous: '杂项',
};

export function interactionDisplay(raw: string): string {
  return Object.hasOwn(labels, raw) ? labels[raw] : raw;
}
