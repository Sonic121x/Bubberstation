/datum/wound/blunt/robotic/moderate
	name = "螺丝松动"
	desc = "多种半外露的紧固装置已经松动，导致部件晃动，影响肢体控制。"
	treat_text = "建议用螺丝刀对紧固装置进行外部重新固定，不过用低力度钝击进行敲击维护或许也行——\
	只是有加重伤势的风险。"
	examine_desc = "看起来固定得很松"
	occur_text = "别扭地晃动，似乎有些松脱"
	severity = WOUND_SEVERITY_MODERATE
	simple_treat_text = "<b>包扎</b>伤口可减轻影响，直到<b>螺丝被固定</b>——若由<b>别人</b>、\
	<b>机器人学家</b>、<b>工程师</b>操作，或借助<b>诊断 HUD</b>，速度会<b>更快</b>。"
	homemade_treat_text = "紧急情况下，<b>敲击维护</b>可以让螺丝复位——由<b>别人</b>操作或借助<b>诊断 HUD</b>\
	时，成功率会更高！"
	status_effect_type = /datum/status_effect/wound/blunt/robotic/moderate
	treat_text_short = "使用螺丝刀或敲击维护"
	treatable_tools = list(TOOL_SCREWDRIVER)
	interaction_efficiency_penalty = 1.2
	limp_slowdown = 2.5
	limp_chance = 30
	threshold_penalty = 20
	can_scar = FALSE
	a_or_from = "from"

/datum/wound_pregen_data/blunt_metal/loose_screws
	abstract = FALSE
	wound_path_to_generate = /datum/wound/blunt/robotic/moderate
	viable_zones = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	threshold_minimum = 30

/datum/wound/blunt/robotic/moderate/uses_percussive_maintenance()
	return TRUE

/datum/wound/blunt/robotic/moderate/treat(obj/item/potential_treater, mob/user)
	if (potential_treater.tool_behaviour == TOOL_SCREWDRIVER)
		fasten_screws(potential_treater, user)
		return TRUE

	return ..()

/// The main treatment for T1 blunt. Uses a screwdriver, guaranteed to always work, better with a diag hud. Removes the wound.
/datum/wound/blunt/robotic/moderate/proc/fasten_screws(obj/item/screwdriver_tool, mob/user)
	if (!screwdriver_tool.tool_start_check())
		return

	var/delay_mult = 1

	if (user == victim)
		delay_mult *= 2

	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5

	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.5

	var/their_or_other = (user == victim ? "自己的" : "[victim]的")
	var/your_or_other = (user == victim ? "你的" : "[victim]的")
	victim.visible_message(span_notice("[user] 开始拧紧[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]上的螺丝……"), \
		span_notice("你开始拧紧[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]上的螺丝……"))

	if (!screwdriver_tool.use_tool(target = victim, user = user, delay = (6 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	victim.visible_message(span_green("[user] 拧紧了[their_or_other][chinese_body_zone_display(limb.plaintext_zone)]的螺丝！"), \
		span_green("你拧紧了[your_or_other][chinese_body_zone_display(limb.plaintext_zone)]的螺丝！"))

	remove_wound()
