const labels: Record<string, string> = {
  Safe: '安全', Digest: '消化', Absorb: '吸收', Unabsorb: '解除吸收',
};

export const voreDisplay = (value: string) => labels[value] ?? value;
