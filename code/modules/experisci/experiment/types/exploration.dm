/datum/experiment/exploration_scan
	name = "探索实验"
	description = "一项需要通过无人机探索来推进的实验"
	exp_tag = "Exploration"
	performance_hint = "找到具有特定特征的站点并进行扫描。"
	// Site type, scan needs to be of that type
	var/required_site_type
	// Condition type, scan needs to be of site with this condition
	var/required_condition
	// Required scan type
	var/required_scan_type = EXOSCAN_POINT

/datum/experiment/exploration_scan/is_complete()
	for(var/datum/exploration_site/site in GLOB.exploration_sites)
		switch(required_scan_type)
			if(EXOSCAN_DEEP)
				if(!site.deep_scan_complete)
					continue
			if(EXOSCAN_POINT)
				if(!site.point_scan_complete)
					continue
		if(required_site_type && !istype(site,required_site_type))
			continue
		if(required_condition && !(locate(required_condition) in site.scan_conditions))
			continue
		return TRUE
	return FALSE

/datum/experiment/exploration_scan/perform_experiment_actions(datum/component/experiment_handler/experiment_handler)
	return is_complete()

/datum/experiment/exploration_scan/actionable(datum/component/experiment_handler/experiment_handler)
	return !is_complete()

/datum/experiment/exploration_scan/asteroid_belt
	name = "扫描小行星带"
	description = "我们在找一处站点来测试爆破雷管。对其中一处进行点扫描。"
	required_site_type = /datum/exploration_site/asteroid_belt
	required_scan_type = EXOSCAN_POINT

/datum/experiment/exploration_scan/black_hole
	name = "深度扫描黑洞"
	description = "我们需要更多关于黑洞的研究数据，请对受黑洞影响的星系进行深度扫描。"
	required_condition = /datum/scan_condition/black_hole
	required_scan_type = EXOSCAN_DEEP

/datum/experiment/exploration_scan/random
	name = "随机外部扫描实验"
	description = "我们需要特定类型站点的扫描数据"
	/// If not null the required_site_type will be picked from this list
	var/list/possible_random_conditions
	/// If not null the required_condition will be picked from this list
	var/list/possible_random_site_types

/datum/experiment/exploration_scan/random/New(datum/techweb/techweb)
	. = ..()
	if(length(possible_random_site_types))
		required_site_type = pick(possible_random_site_types)
	if(length(possible_random_conditions))
		required_condition = pick(possible_random_conditions)
	var/list/name_parts = list()
	name_parts += "[required_scan_type] 扫描："
	if(required_site_type)
		var/datum/exploration_site/site = required_site_type
		name_parts += initial(site.name)
	else
		name_parts += "站点"
	if(required_condition)
		var/datum/scan_condition/condition = required_condition
		name_parts += "（受[initial(condition.name)]影响）"
	name = capitalize(name_parts.Join(""))
	description = name

/datum/experiment/exploration_scan/random/condition
	possible_random_conditions = list(/datum/scan_condition/asteroid_belt,/datum/scan_condition/black_hole,/datum/scan_condition/nebula,/datum/scan_condition/pulsar)

/datum/experiment/exploration_scan/random/site_type
	possible_random_site_types = list(/datum/exploration_site/asteroid_belt,/datum/exploration_site/uncharted_planet,/datum/exploration_site/junkyard)
