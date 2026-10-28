import type { Dispatch, SetStateAction } from 'react';
import type { BooleanLike } from 'tgui-core/react';

export type ReagentsData = {
  beakerSync: BooleanLike;
  bitflags: Record<string, number>;
  currentReagents: string[];
  linkedBeaker: string;
  master_reaction_list: Reaction[];
  reagent_mode_reagent: Reagent | null;
  reagent_mode_recipe: Recipe | null;
  selectedBitflags: number;
};

export type ReagentsProps = {
  pageState: [number, Dispatch<SetStateAction<number>>];
};

type Pairs = [
  [number, number],
  [number, number],
  [number, number],
  [number, number],
];

export type Recipe = {
  catalysts: Reagent[];
  explodeTemp: number;
  explosive: Pairs;
  hasProduct: BooleanLike;
  id: string;
  inversePurity: string;
  isColdRecipe: BooleanLike;
  lowerpH: number;
  minPurity: number;
  name: string;
  reactants: Reactant[];
  reagentCol: string;
  reqContainer: string | null;
  subReactIndex: number;
  subReactLen: number;
  tempMin: number;
  thermics: string;
  thermodynamics: Pairs;
  thermoUpper: number;
  upperpH: number;
};

type Reactant = {
  color: string;
  id: string;
  name: string;
  ratio: number;
  tooltip: string | null;
  tooltipBool: BooleanLike;
};

export type Reagent = {
  addictions: string[];
  desc: string;
  id: string;
  metaRate: number;
  name: string;
  OD: number;
  pH: number;
  pHCol: string;
  reagentCol: string;
};

type ReactionReagent = {
  id: string;
  name: string;
};

export type Reaction = {
  bitflags: number;
  id: string;
  name: string;
  reactants: ReactionReagent[];
};

export const bitflagInfo = [
  {
    flag: 'BRUTE',
    icon: 'gavel',
    tooltip: '生成治疗或造成物理伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_brute', // future todo : just make this use ui state
  },
  {
    flag: 'BURN',
    icon: 'burn',
    tooltip: '生成治疗或造成烧伤的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_burn',
  },
  {
    flag: 'TOXIN',
    icon: 'biohazard',
    tooltip: '生成治疗或造成毒素伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_toxin',
  },
  {
    flag: 'OXY',
    icon: 'wind',
    tooltip: '生成治疗或造成窒息伤害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_oxy',
  },
  {
    flag: 'HEALING',
    icon: 'medkit',
    tooltip: '生成治疗用试剂。',
    category: 'Type',
    toggle: 'toggle_tag_healing',
  },
  {
    flag: 'DAMAGING',
    icon: 'skull-crossbones',
    tooltip: '生成造成伤害的试剂。',
    category: 'Type',
    toggle: 'toggle_tag_damaging',
  },
  {
    flag: 'EXPLOSIVE',
    icon: 'bomb',
    tooltip: '生成会爆炸的试剂，或反应本身会爆炸。',
    category: 'Type',
    toggle: 'toggle_tag_explosive',
  },
  {
    flag: 'OTHER',
    icon: 'question',
    tooltip: '生成具有其他副作用的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_other',
  },
  {
    flag: 'DANGEROUS',
    icon: 'exclamation-triangle',
    tooltip: '反应可能产生危险的即时效果。',
    category: 'Difficulty',
    toggle: 'toggle_tag_dangerous',
  },
  {
    flag: 'EASY',
    icon: 'chess-pawn',
    tooltip: '容易进行的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_easy',
  },
  {
    flag: 'MODERATE',
    icon: 'chess-knight',
    tooltip: '难度中等的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_moderate',
  },
  {
    flag: 'HARD',
    icon: 'chess-queen',
    tooltip: '难以进行的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_hard',
  },
  {
    flag: 'ORGAN',
    icon: 'brain',
    tooltip: '生成治疗或造成器官损伤的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_organ',
  },
  {
    flag: 'DRINK',
    icon: 'cocktail',
    tooltip: '生成可饮用的试剂，通常在酒吧调制。',
    category: 'Type',
    toggle: 'toggle_tag_drink',
  },
  {
    flag: 'FOOD',
    icon: 'drumstick-bite',
    tooltip: '生成食物，通常在厨房制作。',
    category: 'Type',
    toggle: 'toggle_tag_food',
  },
  {
    flag: 'SLIME',
    icon: 'microscope',
    tooltip: '与异种生物学有关的反应。',
    category: 'Type',
    toggle: 'toggle_tag_slime',
  },
  {
    flag: 'DRUG',
    icon: 'pills',
    tooltip:
      '生成具有正面和负面效果的成瘾性试剂。',
    category: 'Type',
    toggle: 'toggle_tag_drug',
  },
  {
    flag: 'UNIQUE',
    icon: 'puzzle-piece',
    tooltip: '独特或特殊的反应。',
    category: 'Type',
    toggle: 'toggle_tag_unique',
  },
  {
    flag: 'CHEMICAL',
    icon: 'flask',
    tooltip: '生成会影响其他反应的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_chemical',
  },
  {
    flag: 'PLANT',
    icon: 'seedling',
    tooltip: '生成对植物有益或有害的试剂。',
    category: 'Affects',
    toggle: 'toggle_tag_plant',
  },
  {
    flag: 'COMPETITIVE',
    icon: 'recycle',
    tooltip: '与其他反应竞争的反应。',
    category: 'Difficulty',
    toggle: 'toggle_tag_competitive',
  },
  {
    flag: 'COMPONENT',
    icon: 'question',
    tooltip: '生成常用于其他反应的试剂。',
    category: 'Type',
    toggle: 'toggle_tag_component',
  },
  {
    flag: 'ACTIVE',
    icon: 'question',
    tooltip: '反应会产生即时效果。',
    category: 'Type',
    toggle: 'toggle_tag_active',
  },
];
