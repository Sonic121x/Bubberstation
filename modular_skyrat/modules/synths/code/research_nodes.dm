/datum/techweb_node/improved_robotic_tend_wounds
	display_name = "改良机械维修手术"
	description = "事实证明，支撑杆只是擦伤的话，其实没必要把整根都切掉！"
	prerequisite_nodes = list(/datum/techweb_node/construction)
	unlocked_designs = list(
		/datum/design/surgery/tend_wounds_combo/synth,
		/datum/design/surgery/tend_wounds_upgrade/synth,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
	required_experiments = list(/datum/experiment/scanning/people/augmented_organs)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/datum/techweb_node/advanced_robotic_tend_wounds
	display_name = "高级机械手术"
	description = "你知道赫菲斯托斯其实提供免费的合成人创伤维修在线教程吗？是真的！"
	prerequisite_nodes = list(/datum/techweb_node/improved_robotic_tend_wounds)
	unlocked_designs = list(
		/datum/design/surgery/tend_wounds_combo/synth/upgrade,
		/datum/design/surgery/tend_wounds_combo/synth/upgrade/femto,
		/datum/design/surgery/tend_wounds_upgrade/synth/femto
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

/**
 * Wound tending
 */

// basic
/datum/design/surgery/tend_wounds_upgrade/synth
	name = "结构修复升级"
	desc = "提高单项伤口处理手术的效率。"
	surgery = /datum/surgery_operation/basic/repair_synth/upgraded
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_upgrade/synth/femto
	name = "结构修复升级"
	surgery = /datum/surgery_operation/basic/repair_synth/upgraded/master

// combo
/datum/design/surgery/tend_wounds_combo/synth
	name = "综合结构修复"
	desc = "一种同时处理物理损伤与烧伤的替代手术，但单项效率低于分别处理。"
	surgery = /datum/surgery_operation/basic/repair_synth/combo
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_combo/synth/upgrade
	name = "综合结构修复升级"
	surgery = /datum/surgery_operation/basic/repair_synth/combo/upgraded

/datum/design/surgery/tend_wounds_combo/synth/upgrade/femto
	name = "综合结构修复升级"
	desc = "终极伤口处理手术，同时治疗物理损伤与烧伤，且比单独处理更快。"
	surgery = /datum/surgery_operation/basic/repair_synth/combo/upgraded/master

/**
 * Subsystem Upgrades - there's none that involve bleeding or anything that wouldn't make sense for a synth to have
 */

// Techweb
/datum/techweb_node/robotic_surgery_exp
	display_name = "实验性合成人手术"
	description = "当机器人学有点贪得无厌的时候。"
	prerequisite_nodes = list(/datum/techweb_node/improved_robotic_tend_wounds)
	unlocked_designs = list(
		/datum/design/surgery/cortex_folding/synth,
		/datum/design/surgery/cortex_imprint/synth,
		/datum/design/surgery/ligament_reinforcement/synth,
		/datum/design/surgery/muscled_veins/synth,
		/datum/design/surgery/nerve_grounding/synth,
		/datum/design/surgery/nerve_splicing/synth,
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	discount_experiments = list(/datum/experiment/scanning/people/android = TECHWEB_TIER_2_POINTS)
	announce_channels = list(RADIO_CHANNEL_SCIENCE)

// nerve splicing - Reinforced Servos
/datum/design/surgery/nerve_splicing/synth
	desc = "升级合成人患者的运动伺服机构，使其更能抵抗眩晕的手术。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/nerve_splicing
	research_icon_state = "surgery_chest"

// nerve grounding - Reinforced Capacitors
/datum/design/surgery/nerve_grounding/synth
	desc = "安装额外电容组以吸收电击的手术。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/nerve_grounding
	research_icon_state = "surgery_chest"

// Muscled Veins - Hydraulics Redundancy Subroutine
/datum/design/surgery/muscled_veins/synth
	desc = "为机械患者的液压系统添加冗余，使其没有驱动机或泵也能推动液体。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/muscled_veins
	research_icon_state = "surgery_chest"

// ligament reinforcement - Anchor Point Reinforcement
/datum/design/surgery/ligament_reinforcement/synth
	desc = "加固机械患者的肢体关节以防止断肢的手术，\
		代价是神经连接更容易中断。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/ligament_reinforcement
	research_icon_state = "surgery_chest"

// cortex imprinting - Anti-Cascade 2.0
/datum/design/surgery/cortex_imprint/synth
	desc = "将机械患者的底层操作系统更新到“较新版本”，提高整体性能和韧性的手术。\
		可惜捆绑了太多广告软件。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/cortex_imprint
	research_icon_state = "surgery_chest"

// cortex folding - Neuropathing Reinforcement
/datum/design/surgery/cortex_folding/synth
	desc = "使用诡异至极的编程语言重写机械患者的神经网络，为非标准神经模式腾出空间的手术。\
		绝对不是恶意软件。"
	surgery = /datum/surgery_operation/limb/subsystem_upgrade/cortex_folding
	research_icon_state = "surgery_chest"
