// THIS IS A SKYRAT UI FILE
import { CheckboxInput, type Feature, FeatureNumberInput } from '../../base';

export const dc_starting_degradation: Feature<number> = {
  name: 'A_初始退化程度',
  component: FeatureNumberInput,
  description: '你开始游戏时的退化程度。',
};

export const dc_max_degradation: Feature<number> = {
  name: 'A_最大退化程度',
  component: FeatureNumberInput,
  description: '你的退化程度所能达到的绝对上限。',
};

export const dc_living_degradation_recovery_per_second: Feature<number> = {
  name: 'B_存活时每秒恢复量',
  component: FeatureNumberInput,
  description:
    '存活时，你的退化程度每秒降低此数值。如果为负值，则会让你慢慢死去。',
};

export const dc_dead_degradation_per_second: Feature<number> = {
  name: 'B_死亡时每秒退化量',
  component: FeatureNumberInput,
};

export const dc_degradation_on_death: Feature<number> = {
  name: 'B_死亡时立即增加的退化量',
  component: FeatureNumberInput,
  description: '两次死亡之间有约 5 分钟的冷却时间。',
};

export const dc_stasis_dead_degradation_mult: Feature<number> = {
  name: 'B_停滞状态退化倍率',
  component: FeatureNumberInput,
  description:
    '处于停滞状态时，被动退化会按此倍率降低。',
};

export const dc_formeldahyde_dead_degradation_mult: Feature<number> = {
  name: 'C_甲醛死亡退化倍率',
  component: FeatureNumberInput,
  description:
    '如果你是有机生物且体内含有甲醛，死亡造成的被动退化会乘以此倍率。',
};

export const dc_rezadone_living_degradation_reduction: Feature<number> = {
  name: 'C_纯雷扎酮退化恢复量',
  component: FeatureNumberInput,
  description:
    '如果你是存活的有机生物，且正在代谢纯度为 100% 的雷扎酮，退化程度将以此速率每秒被动恢复。',
};

export const dc_eigenstasium_degradation_reduction: Feature<number> = {
  name: 'C_本征态素退化恢复量',
  component: FeatureNumberInput,
  description:
    '如果你体内含有本征态素，退化程度将以此速率每秒被动恢复。此效果对合成人和死者也有效。',
};

export const dc_crit_threshold_reduction_min_percent_of_max: Feature<number> = {
  name: '濒死阈值：开始降低的退化百分比',
  component: FeatureNumberInput,
  description:
    '退化程度达到上限的此百分比时，濒死阈值开始降低。',
};

export const dc_crit_threshold_reduction_percent_of_max: Feature<number> = {
  name: '濒死阈值：停止降低的退化百分比',
  component: FeatureNumberInput,
  description:
    '退化程度达到上限的此百分比时，濒死阈值停止降低，达到最大降幅。',
};

export const dc_max_crit_threshold_reduction: Feature<number> = {
  name: '濒死阈值：最大降幅',
  component: FeatureNumberInput,
  description:
    '达到终止退化百分比时，濒死阈值会降低此数值，\
	    较低百分比则按比例降低，例如退化程度为 50% 时会应用此数值的 50%。',
};

export const dc_stamina_damage_min_percent_of_max: Feature<number> = {
  name: '耐力伤害：开始增加的退化百分比',
  component: FeatureNumberInput,
  description:
    '退化程度达到上限的此百分比时，耐力伤害下限开始增加。',
};

export const dc_stamina_damage_percent_of_max: Feature<number> = {
  name: '耐力伤害：停止增加的退化百分比',
  component: FeatureNumberInput,
  description:
    '退化程度达到上限的此百分比时，耐力伤害下限达到其最大值。',
};

export const dc_max_stamina_damage: Feature<number> = {
  name: '耐力伤害：最大值',
  component: FeatureNumberInput,
  description:
    '达到终止退化百分比时，你的耐力伤害始终至少为此数值，\
        较低百分比则按比例设定下限，例如退化程度为 50%、最大耐力伤害为 80 时，下限为 40 点伤害。',
};

export const dc_permakill_at_max: Feature<boolean> = {
  name: '永久死亡：退化至上限时永久幽灵化',
  component: CheckboxInput,
  description:
    '启用后，退化程度达到上限时，你将永久变成幽灵。',
};

export const dc_force_death_if_permakilled: Feature<boolean> = {
  name: '永久死亡：永久幽灵化时强制死亡',
  component: CheckboxInput,
  description: '启用后，永久幽灵化也会使你永久死亡。',
};
