// Pierce
// Slow to rise but high damage overall
// Hard-ish to fix
/datum/wound/electrical_damage/pierce
	heat_differential_healing_mult = 0.01
	simple_desc = "电缆管道被刺穿，形成一处会<b>缓慢</b>加剧的故障，但最大电压<b>极高</b>！"

/datum/wound_pregen_data/electrical_damage/pierce
	abstract = TRUE
	wound_series = WOUND_SERIES_WIRE_PIERCE_ELECTRICAL_DAMAGE
	required_wounding_type = WOUND_PIERCE

/datum/wound/burn/electrical_damage/pierce/get_limb_examine_description()
	return span_warning("这条肢体上的金属被刺穿了。")

/datum/wound/electrical_damage/pierce/moderate
	name = "电容被击穿"
	desc = "一个主要电容被击穿，造成缓慢但明显的电损伤。"
	occur_text = "喷出一小串火花"
	examine_desc = "轻微颤抖，动作有些无力"
	treat_text = "更换受损线路，不过用剪线工具或缝合器修理或许也能凑合，只是效率有限。紧急情况下，\
				可以给对象施加高温，让焊锡重新凝固。"
	treat_text_short = "更换受损线路。"

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T1.ogg'

	severity = WOUND_SEVERITY_MODERATE

	sound_volume = 30

	threshold_penalty = 30

	intensity = 10 SECONDS
	processing_full_shock_threshold = 7 MINUTES

	processing_shock_power_per_second_max = 1.2
	processing_shock_power_per_second_min = 1.1

	processing_shock_stun_chance = 0.5
	processing_shock_spark_chance = 35

	process_shock_spark_count_max = 1
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.078
	wire_repair_percent = 0.036

	initial_sparks_amount = 1

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/moderate

	a_or_from = "a"

	scar_keyword = "piercemoderate"

/datum/wound_pregen_data/electrical_damage/pierce/moderate
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/moderate
	threshold_minimum = 40

/datum/wound/electrical_damage/pierce/severe
	name = "变压器被穿透"
	desc = "一个主要变压器被穿透，造成进展缓慢但最终猛烈的电损伤。"
	occur_text = "噼啪作响并短暂瘫软，同时喷出一串火花"
	examine_desc = "剧烈颤抖，伺服电机有节奏地短暂失灵"
	treat_text = "先用纱布固定受损线路，然后敷上新线路/缝合，或用剪线钳/牵开器把错位的线路复位。"
	treat_text_short = "包扎纱布并更换线路。"

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T2.ogg'

	severity = WOUND_SEVERITY_SEVERE

	sound_volume = 15

	threshold_penalty = 40

	intensity = 20 SECONDS
	processing_full_shock_threshold = 6.5 MINUTES

	processing_shock_power_per_second_max = 1.6
	processing_shock_power_per_second_min = 1.5

	processing_shock_stun_chance = 2.5
	processing_shock_spark_chance = 60

	process_shock_spark_count_max = 2
	process_shock_spark_count_min = 1

	wirecut_repair_percent = 0.046
	wire_repair_percent = 0.024

	initial_sparks_amount = 3

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/severe

	a_or_from = "a"

	scar_keyword = "piercemoderate"

/datum/wound_pregen_data/electrical_damage/pierce/severe
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/severe
	threshold_minimum = 60

/datum/wound/electrical_damage/pierce/critical
	name = "PSU 破裂"
	desc = "这条肢体的本地 PSU 发生了核心破裂，导致逐步发展的供电故障，最终会缓慢加剧为猛烈的电损伤。"
	occur_text = "闪出耀眼的蓝光，发出的声响颇像雅各布天梯"
	examine_desc = "的 PSU 清晰可见，中间有一个相当大的洞"
	treat_text = "立即用纱布固定，然后紧急更换线缆，并用剪线钳或止血钳固定。\
		若故障已无法控制，建议采用极端高温疗法。"
	treat_text_short = "包扎纱布、更换线路，并使用剪线钳或止血钳。"

	severity = WOUND_SEVERITY_CRITICAL
	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|CAN_BE_GRASPED|SPLINT_OVERLAY)

	sound_effect = 'modular_skyrat/modules/medical/sound/robotic_slash_T3.ogg'

	sound_volume = 30

	threshold_penalty = 60

	intensity = 30 SECONDS
	processing_full_shock_threshold = 5.5 MINUTES

	processing_shock_power_per_second_max = 2.2
	processing_shock_power_per_second_min = 2.1

	processing_shock_stun_chance = 1
	processing_shock_spark_chance = 90

	process_shock_spark_count_max = 3
	process_shock_spark_count_min = 2

	wirecut_repair_percent = 0.032
	wire_repair_percent = 0.017

	initial_sparks_amount = 8

	status_effect_type = /datum/status_effect/wound/electrical_damage/pierce/critical

	a_or_from = "a"

	scar_keyword = "piercecritical"

/datum/wound_pregen_data/electrical_damage/pierce/critical
	abstract = FALSE
	wound_path_to_generate = /datum/wound/electrical_damage/pierce/critical
	threshold_minimum = 110
