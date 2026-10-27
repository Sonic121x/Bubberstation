/**
 * ## Dynamic tier datum
 *
 * These datums are essentially used to configure the dynamic system
 * They serve as a very simple way to see at a glance what dynamic is doing and what it is going to do
 *
 * For example, a tier will say "we will spawn 1-2 roundstart antags"
 */
/datum/dynamic_tier
	/// Tier number - A number which determines the severity of the tier - the higher the number, the more antags
	var/tier = -1
	/// The human readable name of the tier
	var/name
	/// Tag the tier uses for configuring.
	/// Don't change this unless you know what you're doing.
	var/config_tag
	/// The chance this tier will be selected from all tiers
	/// Keep all tiers added up to 100 weight, keeps things readable
	var/weight = 0
	/// This tier will not be selected if the population is below this number
	var/min_pop = 0

	/// String which is sent to the players reporting which tier is active
	var/advisory_report

	/**
	 * How Dynamic will select rulesets based on the tier
	 *
	 * Every tier configures each of the ruleset types - ie, roundstart, light midround, heavy midround, latejoin
	 *
	 * Every type can be configured with the following:
	 * - LOW_END: The lower for how many of this ruleset type can be selected
	 * - HIGH_END: The upper for how many of this ruleset type can be selected
	 * - HALF_RANGE_POP_THRESHOLD: Below this population range, the high end is quartered
	 * - FULL_RANGE_POP_THRESHOLD: Below this population range, the high end is halved
	 *
	 * Non-roundstart ruleset types also have:
	 * - TIME_THRESHOLD: World time must pass this threshold before dynamic starts running this ruleset type
	 * - EXECUTION_COOLDOWN_LOW: The lower end for how long to wait before running this ruleset type again
	 * - EXECUTION_COOLDOWN_HIGH: The upper end for how long to wait before running this ruleset type again
	 */
	var/list/ruleset_type_settings = list(
		ROUNDSTART = list(
			LOW_END = 0,
			HIGH_END = 0,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 50,
			TIME_THRESHOLD = 0 MINUTES,
			EXECUTION_COOLDOWN_LOW = 0 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 0 MINUTES,
		),
		LIGHT_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 0,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 30 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		HEAVY_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 0,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 60 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		LATEJOIN = list(
			LOW_END = 0,
			HIGH_END = 0,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 0 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
	)

/datum/dynamic_tier/New(list/dynamic_config)
	for(var/new_var in dynamic_config?[config_tag])
		if(!(new_var in vars))
			continue
		set_config_value(new_var, dynamic_config[config_tag][new_var])

/// Used for parsing config entries to validate them
/datum/dynamic_tier/proc/set_config_value(new_var, new_val)
	switch(new_var)
		if(NAMEOF(src, tier), NAMEOF(src, config_tag), NAMEOF(src, vars))
			return FALSE
		if(NAMEOF(src, ruleset_type_settings))
			for(var/category in new_val)
				for(var/rule in new_val[category])
					if(rule == LOW_END || rule == HIGH_END)
						ruleset_type_settings[category][rule] = max(0, new_val[category][rule])
					else if(rule == TIME_THRESHOLD || rule == EXECUTION_COOLDOWN_LOW || rule == EXECUTION_COOLDOWN_HIGH)
						ruleset_type_settings[category][rule] = new_val[category][rule] * 1 MINUTES
					else
						ruleset_type_settings[category][rule] = new_val[category][rule]
			return TRUE

	vars[new_var] = new_val
	return TRUE

/datum/dynamic_tier/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, tier))
			return FALSE

	return ..()

/datum/dynamic_tier/greenshift
	tier = DYNAMIC_TIER_GREEN
	config_tag = "Greenshift"
	name = "平静班次"
	weight = 2

	advisory_report = "预警等级：<b>绿星</b></center><BR>\
		你所在星区的预警等级为绿星。\
		监测情报显示，目前没有可信证据表明顺旋星区内的纳米传讯资产面临威胁。\
		本部门仍一如既往地建议：即使尚未发现已知威胁，也应对潜在威胁保持警惕。"

/datum/dynamic_tier/low
	tier = DYNAMIC_TIER_LOW
	config_tag = "Low Chaos"
	name = "低度混乱"
	weight = 8

	advisory_report = "预警等级：<b>黄星</b></center><BR>\
		你所在星区的预警等级为黄星。\
		监测情报显示，我们在顺旋星区的资产确有遭受敌方袭击的风险。\
		我们建议加强安保，并对潜在威胁保持警惕。"

	ruleset_type_settings = list(
		ROUNDSTART = list(
			LOW_END = 1,
			HIGH_END = 1,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
		),
		LIGHT_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 30 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		HEAVY_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 1,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 60 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		LATEJOIN = list(
			LOW_END = 0,
			HIGH_END = 1,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 5 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
	)

/datum/dynamic_tier/lowmedium
	tier = DYNAMIC_TIER_LOWMEDIUM
	config_tag = "Low-Medium Chaos"
	name = "中低度混乱"
	weight = 46

	advisory_report = "预警等级：<b>红星</b></center><BR>\
		你所在星区的预警等级为红星。\
		情报部门破译的赛博太阳通信表明，\
		顺旋星区内的纳米传讯资产极有可能遭受袭击。\
		建议本星区各空间站密切留意敌方活动迹象，并保持高度戒备。"

	ruleset_type_settings = list(
		ROUNDSTART = list(
			LOW_END = 1,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
		),
		LIGHT_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 30 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		HEAVY_MIDROUND = list(
			LOW_END = 0,
			HIGH_END = 1,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 60 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		LATEJOIN = list(
			LOW_END = 1,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 5 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
	)

/datum/dynamic_tier/mediumhigh
	tier = DYNAMIC_TIER_MEDIUMHIGH
	config_tag = "Medium-High Chaos"
	name = "中高度混乱"
	weight = 36

	advisory_report = "预警等级：<b>黑轨</b></center><BR>\
		你所在星区的预警等级为黑轨。\
		你所在星区的本地通信网络目前已中断，\
		因此我们无法准确判断本区域内的敌方动向。\
		不过，GDI 传来的情报显示，星区内存在大量敌方活动，\
		表明袭击可能即将发生。请保持高度戒备，并提防其他潜在威胁。"

	ruleset_type_settings = list(
		ROUNDSTART = list(
			LOW_END = 2,
			HIGH_END = 3,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
		),
		LIGHT_MIDROUND = list(
			LOW_END = 1,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 30 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		HEAVY_MIDROUND = list(
			LOW_END = 1,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 60 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		LATEJOIN = list(
			LOW_END = 1,
			HIGH_END = 3,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 5 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
	)

/datum/dynamic_tier/high
	tier = DYNAMIC_TIER_HIGH
	config_tag = "High Chaos"
	name = "高度混乱"
	weight = 10

	min_pop = 25

	advisory_report = "预警等级：<b>午夜烈日</b></center><BR>\
		你所在星区的预警等级为午夜烈日。\
		GDI 传来的可靠情报表明，辛迪加\
		正准备对顺旋星区的纳米传讯资产发动大规模协同进攻，以削弱我们在当地的立足点。\
		所有空间站都应保持高度戒备，做好自卫准备。"

	ruleset_type_settings = list(
		ROUNDSTART = list(
			LOW_END = 3,
			HIGH_END = 4,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
		),
		LIGHT_MIDROUND = list(
			LOW_END = 1,
			HIGH_END = 2,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 20 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		HEAVY_MIDROUND = list(
			LOW_END = 2,
			HIGH_END = 4,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 30 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
		LATEJOIN = list(
			LOW_END = 2,
			HIGH_END = 3,
			HALF_RANGE_POP_THRESHOLD = 25,
			FULL_RANGE_POP_THRESHOLD = 40,
			TIME_THRESHOLD = 5 MINUTES,
			EXECUTION_COOLDOWN_LOW = 10 MINUTES,
			EXECUTION_COOLDOWN_HIGH = 20 MINUTES,
		),
	)
