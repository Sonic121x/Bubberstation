/**
 * Adds a disease outbreak epidemic function to incident displays
 */

/// Display days since last delam on incident sign
#define DISPLAY_DELAM (1<<0)
/// Display current number of tram hits on incident sign
#define DISPLAY_TRAM (1<<1)
/// Display current number of tram hits on incident sign
#define DISPLAY_DISEASE (1<<2)

#define TREND_RISING "rising"
#define TREND_FALLING "falling"

#define NAME_DELAM "崩解事故显示屏"
#define NAME_TRAM "电车事故显示屏"
#define NAME_DISEASE "疫情显示屏"

#define DESC_DELAM "显示距离上次崩解事故过去了多久的标牌，上面还有安全蛾的广告。"
#define DESC_TRAM "显示本班次电车相关安全事故数量的屏幕。"
#define DESC_DISEASE "显示本班次现有传染病例数量的屏幕。<br/><span class='boldwarning'>本站不遵守医患保密原则。</span>" // BUBBER EDIT ADDITION - Disease Counter


/obj/machinery/incident_display
	icon = 'modular_zubbers/icons/obj/machines/incident_display.dmi'
	/// Disease metric digits color
	var/disease_display_color = "#4bfba5"
	/// Current active event diseases
	var/current_disease_metric = 0
	/// Previous event disease metric
	var/prev_disease_metric = 0
	var/static/list/disease_slogan_good = list(
		"发生疫情时，请尽量不要惊慌。",
		"发生疫情时，请尽量不要呼吸。",
		"请提防看不见且可能致命的疾病。",
		"提醒工作人员：请勿当着病人的面嘲笑病人。谢谢。",
		"不要与其他船员接触，你不知道他们去过什么地方。",
		"提醒各位船员：请勿生病。",
	)
	var/static/list/disease_slogan_bad = list(
		"如果你有疑问，请先问问自己为什么会有疑问。",
		"请高度警惕看不见且可能致命的疾病！",
		"提醒工作人员：请勿当着病人的面嘲笑病人。谢谢。",
		"我们希望你在医务室住得愉快，但别愉快到不想离开……拜托，迟早还是要走的。",
		"假装你的医生比实际更高明，或许有助于康复。",
		"不要与其他船员接触，你不知道他们去过什么地方。",
		"治疗质量可能取决于病人的表现。",
		"治愈的病人应在染上其他疾病前离开医务室。",
		"请不要问我们的疫苗如何起效，因为我们也不太确定。",
	)
	/// How long between slogans
	var/slogan_delay = 10 MINUTES
	COOLDOWN_DECLARE(slogan_cooldown)
	verb_say = "哔哔道"
	verb_ask = "哔哔道"
	verb_exclaim = "哔哔道"

/// Counter board for disease outbreak
/obj/machinery/incident_display/disease
	name = NAME_DISEASE
	desc = DESC_DISEASE
	sign_features = DISPLAY_DISEASE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/incident_display/disease, 32)

/obj/machinery/incident_display/post_machine_initialize()
	. = ..()
	COOLDOWN_START(src, slogan_cooldown, rand(0, slogan_delay))

/obj/machinery/incident_display/process()
	if(COOLDOWN_FINISHED(src, slogan_cooldown) && (sign_features & DISPLAY_DISEASE))
		if(current_disease_metric == 0)
			speak(pick(disease_slogan_good))
		else
			speak(pick(disease_slogan_bad))

		COOLDOWN_START(src, slogan_cooldown, slogan_delay)

	return ..()

/**
 * Speak the given message verbally
 *
 * Checks if the machine is powered and the message exists
 *
 * Arguments:
 * * message - the message to speak
 */
/obj/machinery/incident_display/proc/speak(message)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(!message)
		return

	say(message)

/obj/machinery/incident_display/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!isliving(user))
		return

	var/mob/living/living_user = user

	if(held_item?.tool_behaviour == TOOL_WELDER && !living_user.combat_mode && atom_integrity < max_integrity)
		context[SCREENTIP_CONTEXT_LMB] = "修理显示屏"

	if(held_item?.tool_behaviour == TOOL_MULTITOOL && !living_user.combat_mode)
		if(sign_features == DISPLAY_TRAM)
			context[SCREENTIP_CONTEXT_LMB] = "切换至疫情模式"
		else if(sign_features == DISPLAY_DISEASE)
			context[SCREENTIP_CONTEXT_LMB] = "切换至崩解模式"
		else if(sign_features == DISPLAY_DELAM)
			context[SCREENTIP_CONTEXT_LMB] = "切换至电车模式"

	return CONTEXTUAL_SCREENTIP_SET

/// Switch modes with multitool
/obj/machinery/incident_display/multitool_act(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return FALSE

	if(sign_features == DISPLAY_TRAM)
		tool.play_tool_sound(src)
		balloon_alert(user, "已切换至疫情模式")
		name = NAME_DISEASE
		desc = DESC_DISEASE
		sign_features = DISPLAY_DISEASE
		update_appearance()
		return TRUE
	else if(sign_features == DISPLAY_DISEASE)
		tool.play_tool_sound(src)
		balloon_alert(user, "已切换至崩解模式")
		name = NAME_DELAM
		desc = DESC_DELAM
		sign_features = DISPLAY_DELAM
		update_delam_count(SSpersistence.rounds_since_engine_exploded, SSpersistence.delam_highscore)
		update_appearance()
		return TRUE
	else
		tool.play_tool_sound(src)
		balloon_alert(user, "已切换至电车模式")
		name = NAME_TRAM
		desc = DESC_TRAM
		sign_features = DISPLAY_TRAM
		update_tram_count(src, SSpersistence.tram_hits_this_round)
		update_appearance()
		return TRUE

/**
 * Update the disease count on the display
 *
 * Use the provided args to update the incident display when in disease mode.
 * Arguments:
 * * current - current active event disease metric
 * * previous - previous cached event disease metric
 */
/obj/machinery/incident_display/proc/update_disease_count(source, current, previous)
	current_disease_metric = min(current, 199)
	prev_disease_metric = min(previous, 199)
	update_appearance()

/obj/machinery/incident_display/examine(mob/user)
	. = ..()
	if(sign_features & DISPLAY_DISEASE)
		. += span_notice("可以用[EXAMINE_HINT("多功能工具")]将其改为显示无崩解事故班次数。")
		. += span_info("空间站目前报告了 [current_disease_metric] 例现有感染。")
		if(current_disease_metric == 0)
			. += span_notice("<b>[pick(disease_slogan_good)]</b><br/>")
		else
			. += span_notice("<b>[pick(disease_slogan_bad)]</b><br/>")

#undef DISPLAY_DELAM
#undef DISPLAY_TRAM
#undef DISPLAY_DISEASE

#undef NAME_DELAM
#undef NAME_TRAM
#undef NAME_DISEASE

#undef DESC_DELAM
#undef DESC_TRAM
#undef DESC_DISEASE

#undef TREND_RISING
#undef TREND_FALLING
