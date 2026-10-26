/**
 * Bluespace artillery goal
 *
 * Requires the crew to construct an artillery piece by shift end.
 */

/datum/station_goal/bluespace_cannon
	name = "蓝空间火炮"

/datum/station_goal/bluespace_cannon/get_report()
	return list(
		"<blockquote>我方在你所在星区的军事力量不足。",
		"我们需要你在空间站上建造 BSA-[rand(1,99)] 火炮阵地。",
		"",
		"基础部件可通过货运订购。",
		"-纳米传讯海军指挥部</blockquote>",
	).Join("\n")

/datum/station_goal/bluespace_cannon/on_report()
	//Unlock BSA parts
	var/datum/supply_pack/engineering/bsa/parts = SSshuttle.supply_packs[/datum/supply_pack/engineering/bsa]
	parts.order_flags = ORDER_SPECIAL | ORDER_SPECIAL_ENABLED

/datum/station_goal/bluespace_cannon/check_completion()
	if(..())
		return TRUE
	var/obj/machinery/bsa/full/built_cannon = locate()
	if(built_cannon && !built_cannon.machine_stat)
		return TRUE
	return FALSE
