const labels: Record<string, string> = {
  combat: '战斗', spooky: '恐怖', destructive: '破坏', communal: '群体',
  targeted: '定向', clown: '小丑', positive: '有益', neutral: '中性',
  crew_antag: '船员反派', team_antag: '团队反派', away_antag: '外来反派',
  npc_antag: '非玩家反派', chaotic: '混乱', overmap: '星图',
  space: '太空', planetary: '行星', antag_reroll: '重新分配反派',
};

export const storytellerTagDisplay = (value: string) => labels[value] ?? value;
