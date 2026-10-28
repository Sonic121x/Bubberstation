// Describes the three modes of scanning available for health analyzers
#define SCANMODE_HEALTH 0
#define SCANMODE_WOUND 1
#define SCANMODE_COUNT 2 // Update this to be the number of scan modes if you add more

/obj/item/healthanalyzer
	name = "健康分析仪"
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "health"
	inhand_icon_state = "healthanalyzer"
	worn_icon_state = "healthanalyzer"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	desc = "能检测受检者生命体征的手持人体扫描仪。侧面按钮可用于扫描化学物质，也可切换为伤口扫描。"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)
	interaction_flags_click = NEED_LITERACY|NEED_LIGHT|ALLOW_RESTING
	custom_price = PAYCHECK_COMMAND
	sound_vary = TRUE
	pickup_sound = SFX_GENERIC_DEVICE_PICKUP
	drop_sound = SFX_GENERIC_DEVICE_DROP
	/// Verbose/condensed
	var/mode = SCANNER_VERBOSE
	/// HEALTH/WOUND
	var/scanmode = SCANMODE_HEALTH
	/// Health analyzing power
	var/scanpower = SCANPOWER_BASIC
	/// If this analyzer will give a bonus to wound treatments apon woundscan.
	var/give_wound_treatment_bonus = FALSE
	var/last_scan_text
	var/scanner_busy = FALSE
	/// Weakref to the last mob scanned by a health analyzer. Used to generate official medical reports.
	var/datum/weakref/last_healthy_scanned

/obj/item/healthanalyzer/Initialize(mapload)
	. = ..()
	register_item_context()

/obj/item/healthanalyzer/examine(mob/user)
	. = ..()
	if(src.mode != SCANNER_NO_MODE)
		. += span_notice("按住Alt点击[src]可开关肢体损伤读数。按住Ctrl和Shift点击可打印报告。")

/obj/item/healthanalyzer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始用[src]分析自己！屏幕显示[user.p_they()]已经死了！"))
	return BRUTELOSS

/obj/item/healthanalyzer/attack_self(mob/user)
	if(!user.can_read(src)) //SKYRAT EDIT: Blind People Can Analyze Again
		return

	scanmode = (scanmode + 1) % SCANMODE_COUNT
	switch(scanmode)
		if(SCANMODE_HEALTH)
			to_chat(user, span_notice("你将健康分析仪切换为身体健康检查模式。"))
		if(SCANMODE_WOUND)
			to_chat(user, span_notice("你将健康分析仪切换为伤口详细信息模式。"))

/obj/item/healthanalyzer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE

	var/mob/living/M = interacting_with

	. = ITEM_INTERACT_SUCCESS

	flick("[icon_state]-scan", src) //makes it so that it plays the scan animation upon scanning, including clumsy scanning

	// Clumsiness/brain damage check
	if ((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))
		var/turf/scan_turf = get_turf(user)
		user.visible_message(
			span_warning("[user]在分析[scan_turf]的生命体征！"),
			span_notice("你傻乎乎地试图分析[scan_turf]的生命体征！"),
		)

		var/floor_text = "<span class='info'><b>[scan_turf]</b>的分析结果（[round_timestamp()]）：</span><br>"
		floor_text += "<span class='info ml-1'>整体状况：<i>未知</i></span><br>"
		floor_text += "<span class='alert ml-1'>受检者没有大脑。</span><br>"
		floor_text += "<span class='info ml-1'>体温：[scan_turf?.return_air()?.return_temperature() || "???"]</span><br>"

		if(user.can_read(src)) // BUBBER EDIT - Blind people can analyze again
			to_chat(user, custom_boxed_message("blue_box", floor_text))
		last_scan_text = floor_text
		return

	if(HAS_TRAIT(M, TRAIT_REQUIRED_ADV_HEALTH_SCANNER) && scanpower < SCANPOWER_ADVANCED)
		to_chat(user, span_info("[M]的生物结构过于复杂，健康分析仪无法分析。"))
		return

	user.visible_message(span_notice("[user]正在分析[M]的生命体征。"))
	balloon_alert(user, "正在分析生命体征")
	playsound(user.loc, 'sound/items/healthanalyzer.ogg', 50)

	var/readability_check = user.can_read(src) // BUBBER EDIT CHANGE - Blind people can analyze again - ORIGINAL: user.can_read(src) && !user.is_blind()
	switch (scanmode)
		if (SCANMODE_HEALTH)
			last_scan_text = healthscan(user, M, mode, scanpower, tochat = readability_check)
			if((M.health / M.maxHealth) > CLEAN_BILL_OF_HEALTH_RATIO)
				last_healthy_scanned = WEAKREF(M)
			else
				last_healthy_scanned = null
		if (SCANMODE_WOUND)
			if(readability_check)
				woundscan(user, M, src)

	add_fingerprint(user)

/obj/item/healthanalyzer/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(user.can_read(src)) // SKYRAT EDIT CHANGE - Blind people can analyze again - ORIGINAL: if(user.can_read(src) && !user.is_blind())
		chemscan(user, interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/healthanalyzer/add_item_context(
	obj/item/source,
	list/context,
	atom/target,
)
	if (!isliving(target))
		return NONE

	switch (scanmode)
		if (SCANMODE_HEALTH)
			context[SCREENTIP_CONTEXT_LMB] = "扫描健康状况"
		if (SCANMODE_WOUND)
			context[SCREENTIP_CONTEXT_LMB] = "扫描伤口"

	context[SCREENTIP_CONTEXT_RMB] = "扫描化学物质"

	return CONTEXTUAL_SCREENTIP_SET

/**
 * healthscan
 * returns a list of everything a health scan should give to a player.
 * Examples of where this is used is Health Analyzer and the Physical Scanner tablet app.
 * Args:
 * user - The person with the scanner
 * target - The person being scanned
 * mode - Uses SCANNER_CONDENSED or SCANNER_VERBOSE to decide whether to give a list of all individual limb damage
 * advanced - Whether it will give more advanced details, such as husk source.
 * tochat - Whether to immediately post the result into the chat of the user, otherwise it will return the results.
 */
/proc/healthscan(mob/user, mob/living/target, mode = SCANNER_VERBOSE, scanpower = SCANPOWER_BASIC, tochat = TRUE)
	if(user.incapacitated)
		return

	// the final list of strings to render
	var/list/render_list = list()

	// Damage specifics
	var/oxy_loss = target.get_oxy_loss()
	var/tox_loss = target.get_tox_loss()
	var/fire_loss = target.get_fire_loss()
	var/brute_loss = target.get_brute_loss()
	var/mob_status = (IS_DEAD_OR_FAKING(target) ? span_alert("<b>已死亡</b>") : "<b>健康度[round(target.health / target.maxHealth, 0.01) * 100]%</b>")

	if(HAS_TRAIT(target, TRAIT_FAKEDEATH) && target.stat != DEAD)
		// if we don't appear to actually be in a "dead state", add fake oxyloss
		if(oxy_loss + tox_loss + fire_loss + brute_loss < 200)
			oxy_loss += 200 - (oxy_loss + tox_loss + fire_loss + brute_loss)
			oxy_loss = clamp(oxy_loss, 0, 200)

	render_list += "[span_info("<b>[target]</b>的分析结果（[round_timestamp()]）：")]<br><span class='info ml-1'>整体状况：[mob_status]</span><br>"

	if(!scanpower == SCANPOWER_BASIC && target.has_reagent(/datum/reagent/inverse/technetium))
		scanpower = SCANPOWER_ADVANCED

	SEND_SIGNAL(target, COMSIG_LIVING_HEALTHSCAN, render_list, scanpower, user, mode, tochat)

	// Husk detection
	if(HAS_TRAIT(target, TRAIT_HUSK))
		// BUBBER EDIT BEGIN - Better unhusk info with rezadone and exact units mentioned
		var/husk_reason = "不明原因"
		if(scanpower >= SCANPOWER_ADVANCED)
			if(HAS_TRAIT_FROM(target, TRAIT_HUSK, CHANGELING_DRAIN))
				render_list += "<span class='alert ml-1'>受检者因[conditional_tooltip("脱水干瘪", "无法修复。通常只能通过大脑移植复活。", tochat)]而躯体损毁。</span><br>"
			else if(HAS_TRAIT_FROM(target, TRAIT_HUSK, SKELETON_TRAIT))
				render_list += "<span class='alert ml-1'>受检者因严重血肉缺失而躯体损毁。</span><br>"
			else if(HAS_TRAIT_FROM(target, TRAIT_HUSK, /datum/status_effect/zombie::id))
				render_list += "<span class='alert ml-1'>受检者因[conditional_tooltip("僵尸化", \
					"通过手术移除通常位于头部的感染源。如找不到感染源，则无法修复。", tochat)]而躯体损毁。</span><br>"
			else if(!HAS_TRAIT_FROM(target, TRAIT_HUSK, BURN)) // prioritize showing unknown causes over burns
				render_list += "<span class='alert ml-1'>受检者因不明原因而躯体损毁。</span><br>"
			else
				render_list += "<span class='alert ml-1'>受检者因[conditional_tooltip("严重烧伤", "治疗烧伤并使用躯体修复药剂，如[/datum/reagent/medicine/c2/synthflesh::name]。", tochat)]而躯体损毁。</span><br>"

		render_list += "<span class='alert ml-1'>受检者因[husk_reason]而[conditional_tooltip("躯体损毁", "修复烧伤后，任选以下药物：[SYNTHFLESH_UNHUSK_AMOUNT]单位纯净[/datum/reagent/medicine/c2/synthflesh::name]／至多[SYNTHFLESH_UNHUSK_MAX]单位不纯[/datum/reagent/medicine/c2/synthflesh::name]／5单位[/datum/reagent/medicine/rezadone::name]。", tochat)]。</span><br>"
		// BUBBER EDIT END

	if(target.get_stamina_loss())
		if(scanpower >= SCANPOWER_ADVANCED)
			render_list += "<span class='alert ml-1'>疲劳程度：[target.get_stamina_loss()]%。</span><br>"
		else
			render_list += "<span class='alert ml-1'>受检者似乎感到疲劳。</span><br>"

	// Check for brain - both organic (carbon) and synthetic (cyborg MMI)
	var/has_brain = FALSE
	if(target.get_organ_slot(ORGAN_SLOT_BRAIN))
		has_brain = TRUE
	else if(iscyborg(target))
		var/mob/living/silicon/robot/cyborg_target = target
		if(astype(cyborg_target.mmi, /obj/item/brain_processor/organic)?.brain)
			has_brain = TRUE

	if(!has_brain) // kept exclusively for soul purposes
		render_list += "<span class='alert ml-1'>受检者没有大脑。</span><br>"

	if(iscarbon(target))
		var/mob/living/carbon/carbontarget = target
		if(LAZYLEN(carbontarget.quirks))
			render_list += "<span class='info ml-1'>受检者主要障碍：[carbontarget.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY, from_scan = TRUE)]。</span><br>"
			if(scanpower >= SCANPOWER_ADVANCED)
				render_list += "<span class='info ml-1'>受检者次要障碍：[carbontarget.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY, TRUE)]。</span><br>"

	// Body part damage report
	if(iscarbon(target))
		var/mob/living/carbon/carbontarget = target
		var/any_damage = brute_loss > 0 || fire_loss > 0 || oxy_loss > 0 || tox_loss > 0 || fire_loss > 0
		var/any_missing = length(carbontarget.get_missing_limbs())
		var/any_wounded = length(carbontarget.all_wounds)
		var/any_embeds = carbontarget.has_embedded_objects()
		if(any_damage || (mode == SCANNER_VERBOSE && (any_missing || any_wounded || any_embeds)))
			render_list += "<hr>"
			var/dmgreport = "<span class='info ml-1'>身体状况：</span>\
							<font face='Verdana'>\
							<table class='ml-2'>\
							<tr>\
							<td style='width:7em;'><font color='#ff0000'><b>损伤：</b></font></td>\
							<td style='width:5em;'><font color='#ff3333'><b>物理</b></font></td>\
							<td style='width:4em;'><font color='#ff9933'><b>烧伤</b></font></td>\
							<td style='width:4em;'><font color='#00cc66'><b>毒素</b></font></td>\
							<td style='width:8em;'><font color='#00cccc'><b>窒息</b></font></td>\
							</tr>\
							<tr>\
							<td><font color='#ff3333'><b>总计：</b></font></td>\
							<td><font color='#ff3333'><b>[ceil(brute_loss)]</b></font></td>\
							<td><font color='#ff9933'><b>[ceil(fire_loss)]</b></font></td>\
							<td><font color='#00cc66'><b>[ceil(tox_loss)]</b></font></td>\
							<td><font color='#33ccff'><b>[ceil(oxy_loss)]</b></font></td>\
							</tr>"

			if(mode == SCANNER_VERBOSE)
				// Follow same body zone list every time so it's consistent across all humans
				for(var/zone in carbontarget.get_all_limbs())
					var/obj/item/bodypart/limb = carbontarget.get_bodypart(zone)
					if(isnull(limb))
						dmgreport += "<tr>"
						dmgreport += "<td><font color='#cc3333'>[capitalize(parse_zone(zone))]:</font></td>"
						dmgreport += "<td><font color='#cc3333'>-</font></td>"
						dmgreport += "<td><font color='#ff9933'>-</font></td>"
						dmgreport += "</tr>"
						dmgreport += "<tr><td colspan=6><span class='alert ml-2'>&rdsh; 外伤：[conditional_tooltip("肢体缺失", "通过手术重新接合或更换。", tochat)]</span></td></tr>"
						continue
					var/has_any_embeds = LAZYLEN(limb.embedded_objects) >= 1
					var/has_any_wounds = length(limb.wounds) >= 1
					var/is_damaged = limb.burn_dam > 0 || limb.brute_dam > 0
					if(!is_damaged && (zone != BODY_ZONE_CHEST || (tox_loss <= 0 && oxy_loss <= 0)) && !has_any_embeds && !has_any_wounds)
						continue
					dmgreport += "<tr>"
					dmgreport += "<td><font color='#cc3333'>[chinese_scanner_label((limb.bodytype & BODYTYPE_ROBOTIC) ? limb.name : limb.plaintext_zone)]：</font></td>"
					dmgreport += "<td><font color='#cc3333'>[limb.brute_dam > 0 ? ceil(limb.brute_dam) : "0"]</font></td>"
					dmgreport += "<td><font color='#ff9933'>[limb.burn_dam > 0 ? ceil(limb.burn_dam) : "0"]</font></td>"
					if(zone == BODY_ZONE_CHEST) // tox/oxy is stored in the chest
						dmgreport += "<td><font color='#00cc66'>[tox_loss > 0 ? ceil(tox_loss) : "0"]</font></td>"
						dmgreport += "<td><font color='#33ccff'>[oxy_loss > 0 ? ceil(oxy_loss) : "0"]</font></td>"
					dmgreport += "</tr>"
					if(has_any_embeds)
						var/list/embedded_names = list()
						for(var/obj/item/embed as anything in limb.embedded_objects)
							embedded_names[capitalize(embed.name)] += 1
						for(var/embedded_name in embedded_names)
							var/displayed = embedded_name
							var/embedded_amt = embedded_names[embedded_name]
							if(embedded_amt > 1)
								displayed = "[embedded_amt]x [embedded_name]"
							dmgreport += "<tr><td colspan=6><span class='alert ml-2'>&rdsh; 异物：[conditional_tooltip(displayed, "用止血钳取出。", tochat)]</span></td></tr>"
					if(has_any_wounds)
						for(var/datum/wound/wound as anything in limb.wounds)
							dmgreport += "<tr><td colspan=6><span class='alert ml-2'>&rdsh; 外伤：[conditional_tooltip("[wound.name]（[wound.severity_text()]）", wound.treat_text_short, tochat)]</span></td></tr>"

			dmgreport += "</table></font>"
			render_list += dmgreport // tables do not need extra linebreak

	if(ishuman(target))
		var/mob/living/carbon/human/humantarget = target

		// Organ damage, missing organs
		var/render = FALSE
		var/toReport = "<span class='info ml-1'>器官状况：</span>\
			<font face='Verdana'>\
			<table class='ml-2'>\
			<tr>\
			<td style='width:8em;'><font color='#ff0000'><b>器官：</b></font></td>\
			[scanpower >= SCANPOWER_ADVANCED ? "<td style='width:4em;'><font color='#ff0000'><b>损伤</b></font></td>" : ""]\
			<td style='width:30em;'><font color='#ff0000'><b>状态</b></font></td>\
			</tr>"

		var/list/missing_organs = humantarget.get_missing_organs()
		// Follow same order as in the organ_process_order so it's consistent across all humans
		for(var/sorted_slot in GLOB.organ_process_order)
			var/obj/item/organ/organ = humantarget.get_organ_slot(sorted_slot)
			if(isnull(organ))
				if(missing_organs[sorted_slot])
					render = TRUE
					toReport += "<tr><td><font color='#cc3333'>[chinese_scanner_label(missing_organs[sorted_slot])]：</font></td>\
						[scanpower >= SCANPOWER_ADVANCED ? "<td><font color='#ff3333'>-</font></td>" : ""]\
						<td><font color='#cc3333'>缺失</font></td></tr>"
				continue
			if(mode != SCANNER_VERBOSE && !organ.show_on_condensed_scans())
				continue
			var/status = chinese_scanner_organ_status(organ.get_status_text(scanpower, tochat))
			var/appendix = chinese_scanner_organ_status(organ.get_status_appendix(scanpower, tochat))
			if(status || appendix)
				status ||= "<font color='#ffcc33'>正常</font>" // otherwise flawless organs have no status reported by default
				render = TRUE
				toReport += "<tr>\
					<td><font color='#cc3333'>[chinese_scanner_label(organ.name)]：</font></td>\
					[scanpower >= SCANPOWER_ADVANCED ? "<td><font color='#ff3333'>[organ.damage > 0 ? ceil(organ.damage) : "0"]</font></td>" : ""]\
					<td>[status]</td>\
					</tr>"
				if(appendix)
					toReport += "<tr><td colspan=4><span class='alert ml-2'>&rdsh; [appendix]</span></td></tr>"

		if(render)
			render_list += "<hr>"
			render_list += toReport + "</table></font>" // tables do not need extra linebreak

		// Cybernetics & mutant
		var/mutant = HAS_TRAIT(humantarget, TRAIT_HULK)
		var/list/cyberimps
		for(var/obj/item/organ/target_organ as anything in humantarget.organs)
			if(IS_ROBOTIC_ORGAN(target_organ) && !(target_organ.organ_flags & ORGAN_HIDDEN))
				LAZYADD(cyberimps, target_organ.examine_title(user))
			if(target_organ.organ_flags & ORGAN_MUTANT)
				mutant = TRUE
		if(LAZYLEN(cyberimps))
			if(!render)
				render_list += "<hr>"
			render_list += "<span class='notice ml-1'>检测到义体改造：</span><br>"
			render_list += "<span class='notice ml-2'>[jointext(cyberimps, "、")]</span><br>"

		render_list += "<hr>"

		//Genetic stability
		if(scanpower >= SCANPOWER_ADVANCED && humantarget.has_dna() && humantarget.dna.stability != initial(humantarget.dna.stability))
			render_list += "<span class='info ml-1'>基因稳定性：[humantarget.dna.stability]%。</span><br>"

		//body temperature
		var/datum/species/targetspecies = humantarget.dna.species
		var/disguised = !ishumanbasic(humantarget) && HAS_TRAIT(humantarget, TRAIT_HUMAN_DISGUISE)
		var/species_name = "[disguised ? "\"[chinese_footprint_species_display(/datum/species/human::name)]\"" : chinese_footprint_species_display(targetspecies.name)][mutant ? "衍生突变体" : ""]"

		render_list += "<span class='info ml-1'>物种：<b>[species_name]</b></span><br>" // Bubber Edit: Bold species name
		var/core_temperature_message = "核心体温：[round(humantarget.coretemperature-T0C, 0.1)] &deg;C ([round(humantarget.coretemperature*1.8-459.67,0.1)] &deg;F)"
		if(humantarget.coretemperature >= humantarget.get_body_temp_heat_damage_limit())
			render_list += "<span class='alert ml-1'>☼ [core_temperature_message] ☼</span><br>"
		else if(humantarget.coretemperature <= humantarget.get_body_temp_cold_damage_limit())
			render_list += "<span class='alert ml-1'>❄ [core_temperature_message] ❄</span><br>"
		else
			render_list += "<span class='info ml-1'>[core_temperature_message]</span><br>"

	var/body_temperature_message = "体温：[round(target.bodytemperature-T0C, 0.1)] &deg;C ([round(target.bodytemperature*1.8-459.67,0.1)] &deg;F)"
	if(target.bodytemperature >= target.get_body_temp_heat_damage_limit())
		render_list += "<span class='alert ml-1'>☼ [body_temperature_message] ☼</span><br>"
	else if(target.bodytemperature <= target.get_body_temp_cold_damage_limit())
		render_list += "<span class='alert ml-1'>❄ [body_temperature_message] ❄</span><br>"
	else
		render_list += "<span class='info ml-1'>[body_temperature_message]</span><br>"

	// Blood Level
	var/datum/blood_type/blood_type = target.get_bloodtype()
	if(blood_type)
		var/cached_blood_volume = target.get_blood_volume(apply_modifiers = TRUE)
		var/blood_percent = round((cached_blood_volume / BLOOD_VOLUME_NORMAL) * 100)
		var/blood_type_format
		var/level_format
		if(cached_blood_volume <= BLOOD_VOLUME_SAFE && cached_blood_volume > BLOOD_VOLUME_OKAY)
			level_format = "偏低 [blood_percent]%，[cached_blood_volume] cl"
			if (blood_type.restoration_chem)
				level_format = conditional_tooltip(level_format, "建议：补充[blood_type.restoration_chem::name]。", tochat)
		else if(cached_blood_volume <= BLOOD_VOLUME_OKAY)
			level_format = "<b>危急 [blood_percent]%</b>，[cached_blood_volume] cl"
			var/recommendation = list()
			if (blood_type.restoration_chem)
				recommendation += "补充[blood_type.restoration_chem::name]"
			if (blood_type.restoration_chem == /datum/reagent/iron)
				recommendation += "[/datum/reagent/medicine/salglu_solution::name]"
			if (length(recommendation))
				recommendation += "输注[chinese_scanner_label(blood_type.get_blood_name())]"
			else
				recommendation += "立即输注[chinese_scanner_label(blood_type.get_blood_name())]"
			level_format = conditional_tooltip(level_format, "建议：[jointext(recommendation, "或")]。", tochat)
		else
			level_format = "[blood_percent]%, [cached_blood_volume] cl"

		if (blood_type.get_type())
			blood_type_format = "[blood_type.get_type()]"
			if(tochat && length(blood_type.compatible_types))
				var/list/compatible_types_readable = list()
				for(var/datum/blood_type/comp_blood_type as anything in blood_type.compatible_types)
					compatible_types_readable |= initial(comp_blood_type.name)
				blood_type_format = span_tooltip("可以接受以下血型的输血：[jointext(compatible_types_readable, "、")]。", blood_type_format)

		render_list += "<span class='[cached_blood_volume < BLOOD_VOLUME_SAFE ? "alert" : "info"] ml-1'>[chinese_scanner_label(blood_type.get_blood_name())]含量：[level_format]</span> <span class='info'>[blood_type_format]</span><br>"

	var/blood_alcohol_content = target.get_blood_alcohol_content()
	if(blood_alcohol_content > 0)
		if(blood_alcohol_content >= 0.24)
			// "Oil alcohol content" is kinda funny if you think about it from a technical standpoint
			render_list += "<span class='alert ml-1'>[chinese_scanner_label(blood_type?.get_blood_name() || "Blood")]酒精浓度：<b>危急 [blood_alcohol_content]%</b></span><br>"
		else
			render_list += "<span class='info ml-1'>[chinese_scanner_label(blood_type?.get_blood_name() || "Blood")]酒精浓度：[blood_alcohol_content]%</span><br>"

	// Ethereal Charge
	if(istype(target.get_organ_slot(ORGAN_SLOT_STOMACH), /obj/item/organ/stomach/ethereal))
		var/obj/item/organ/stomach/ethereal/battery_stomach = target.get_organ_slot(ORGAN_SLOT_STOMACH)
		var/charge = battery_stomach.cell.charge
		var/charge_dangerous = charge > ETHEREAL_CHARGE_FULL || charge < ETHEREAL_CHARGE_LOWPOWER
		var/charge_format = "[display_power(charge)] / [display_power(ETHEREAL_CHARGE_FULL)]"

		if(charge_dangerous)
			var/recommendation = "建议："
			switch(charge)
				if(-INFINITY to ETHEREAL_CHARGE_LOWPOWER)
					recommendation += "食用添加液态电流的食物以充电"
				if(ETHEREAL_CHARGE_FULL to ETHEREAL_CHARGE_OVERLOAD)
					recommendation += "向最近的未充满区域电力控制器放电"
				if(ETHEREAL_CHARGE_OVERLOAD to ETHEREAL_CHARGE_DANGEROUS)
					recommendation += "为即将发生的剧烈心脏放电做好准备"
					recommendation = uppertext(recommendation)
			charge_format = span_tooltip("[recommendation]，随后治疗毒素损伤。", charge_format)

		render_list += "<span class='[charge_dangerous ? "alert" : "info"] ml-1'>电荷量：[charge_format]</span><br>"

	//Diseases
	var/disease_hr = FALSE
	for(var/datum/disease/disease as anything in target.diseases)
		if(disease.visibility_flags & HIDDEN_SCANNER)
			continue
		if(!disease_hr)
			render_list += "<hr>"
			disease_hr = TRUE
		var/cure_text
		if(istype(disease, /datum/disease/advance))
			var/datum/disease/advance/advanced_disease = disease
			var/cure_count = 2
			switch(scanpower)
				if(SCANPOWER_ADVANCED)
					cure_count = 3
				if(SCANPOWER_SUPER)
					cure_count = INFINITY
			cure_text = advanced_disease.generate_cure_text(cure_count)
		else
			cure_text = disease.cure_text
		render_list += "<span class='alert ml-1'>\
			[conditional_tooltip("<b>警告：检测到[disease.form]</b>", "使用列出的治疗药物或[/datum/reagent/medicine/spaceacillin::name]，也可通过饮食与休息治疗。", tochat)]<br>\
			<div class='ml-2'>\
			名称：[disease.name]。<br>\
			类型：[disease.spread_text]。<br>\
			阶段：[disease.stage]/[disease.max_stages]。<br>\
			治疗：[cure_text]</div>\
			</span>"

	// Time of death
	if(target.station_timestamp_timeofdeath && IS_DEAD_OR_FAKING(target))
		render_list += "<hr>"
		render_list += "<span class='info ml-1'>死亡时间：[target.station_timestamp_timeofdeath]</span><br>"
		render_list += "<span class='alert ml-1'><b>受检者已死亡[DisplayTimeText(round(world.time - target.timeofdeath))]。</b></span><br>"

	. = jointext(render_list, "")
	if(tochat)
		to_chat(user, custom_boxed_message("blue_box", .), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)
	SEND_SIGNAL(target, COMSIG_NANITE_SCAN, user, FALSE) // BUBBER EDIT ADDITION - NANITES
	return .

/obj/item/healthanalyzer/click_ctrl_shift(mob/user)
	. = ..()
	if(!LAZYLEN(last_scan_text))
		balloon_alert(user, "没有扫描记录！")
		return
	if(scanner_busy)
		balloon_alert(user, "分析仪忙碌中！")
		return
	scanner_busy = TRUE
	balloon_alert(user, "正在打印报告……")
	addtimer(CALLBACK(src, PROC_REF(print_report), user), 2 SECONDS)

/obj/item/healthanalyzer/proc/print_report(mob/user)
	var/obj/item/paper/medical_report/report_paper = new(get_turf(src))

	report_paper.color = "#99ccff"
	report_paper.name = "健康扫描报告 - [server_timestamp(format = "hh:mm", ic_time = TRUE)]"
	var/report_text = "<center><B>健康扫描报告</br>\
		获取时间：[UNDERLINED_HTML_TEXT("[server_timestamp(format = "hh:mm", ic_time = TRUE)]", "当班时间：[round_timestamp(format = "hh:mm")]")]</B></center><HR>"
	report_text += last_scan_text

	report_paper.add_raw_text(report_text, advanced_html = TRUE)
	report_paper.update_appearance()

	user.put_in_hands(report_paper)
	balloon_alert(user, "记录已清空")

	resolve_patient_eligibility(report_paper, user)
	report_text = list()
	scanner_busy = FALSE

/**
 * Checks the mob and the medical report that the scanner is trying to print, checks the traits and statuses of the mob, and then resolves by true or false.
 * Applies traits to the patient if the scanning is eligable to turn in for a bounty, with callbacks to remove after a cooldown.
 */
/obj/item/healthanalyzer/proc/resolve_patient_eligibility(obj/item/paper/medical_report/report_paper, mob/scanner)
	var/mob/living/patient = last_healthy_scanned?.resolve()
	if(!patient)
		return FALSE

	if(scanner == patient)
		return FALSE //You can't just scan yourself.

	if(HAS_TRAIT(patient, TRAIT_RECENTLY_TREATED))
		return FALSE

	report_paper.last_healthy_scanned_mob = last_healthy_scanned
	ADD_TRAIT(patient, TRAIT_RECENTLY_TREATED, ANALYZER_TRAIT)
	addtimer(TRAIT_CALLBACK_REMOVE(patient, RECENTLY_HEALED_COOLDOWN, ANALYZER_TRAIT), RECENTLY_HEALED_COOLDOWN)
	return TRUE

/obj/item/healthanalyzer/proc/clear_treatment(mob/living/target)
	if(!target)
		return
	if(QDELETED(target))
		return
	REMOVE_TRAIT(target, TRAIT_RECENTLY_TREATED, ANALYZER_TRAIT)
	return TRUE

/proc/chemscan(mob/living/user, mob/living/target, reagent_types_to_check = null, tochat = TRUE)
	if(user.incapacitated)
		return

	if(istype(target) && target.reagents)
		var/list/render_list = list() //The master list of readouts, including reagents in the blood/stomach, addictions, quirks, etc.
		var/list/render_block = list() //A second block of readout strings. If this ends up empty after checking stomach/blood contents, we give the "empty" header.

		// Blood reagents
		if(target.reagents.reagent_list.len)
			for(var/r in target.reagents.reagent_list)
				var/datum/reagent/reagent = r
				if(reagent.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
					continue
				if(reagent_types_to_check)
					if(!istype(reagent, reagent_types_to_check))
						continue
				render_block += "<span class='notice ml-2'>[round(reagent.volume, 0.001)]单位[reagent.name][reagent.overdosed ? "</span> - [span_bolddanger("过量")]" : "。</span>"]<br>"

		if(!length(render_block)) //If no VISIBLY DISPLAYED reagents are present, we report as if there is nothing.
			render_list += "<span class='notice ml-1'>受检者的[chinese_scanner_label(target.get_bloodtype()?.get_blood_name() || "blood")]中不含任何试剂。</span><br>"
		else
			render_list += "<span class='notice ml-1'>受检者的[chinese_scanner_label(target.get_bloodtype()?.get_blood_name() || "blood")]中含有以下试剂：</span><br>"
			render_list += render_block //Otherwise, we add the header, reagent readouts, and clear the readout block for use on the stomach.
			render_block.Cut()

		// Stomach reagents
		var/obj/item/organ/stomach/belly = target.get_organ_slot(ORGAN_SLOT_STOMACH)
		if(belly)
			if(belly.reagents.reagent_list.len)
				for(var/bile in belly.reagents.reagent_list)
					var/datum/reagent/bit = bile
					if(bit.chemical_flags & REAGENT_INVISIBLE)
						continue
					if(reagent_types_to_check)
						if(!istype(bit, reagent_types_to_check))
							continue
					if(!belly.food_reagents[bit.type])
						render_block += "<span class='notice ml-2'>[round(bit.volume, 0.001)]单位[bit.name][bit.overdosed ? "</span> - [span_bolddanger("过量")]" : "。</span>"]<br>"
					else
						var/bit_vol = bit.volume - belly.food_reagents[bit.type]
						if(bit_vol > 0)
							render_block += "<span class='notice ml-2'>[round(bit_vol, 0.001)]单位[bit.name][bit.overdosed ? "</span> - [span_bolddanger("过量")]" : "。</span>"]<br>"

			if(!length(render_block))
				render_list += "<span class='notice ml-1'>受检者的胃中不含任何试剂。</span><br>"
			else
				render_list += "<span class='notice ml-1'>受检者的胃中含有以下试剂：</span><br>"
				render_list += render_block

		// Addictions
		if(LAZYLEN(target.mind?.active_addictions))
			render_list += "<span class='boldannounce ml-1'>受检者对以下类型药物成瘾：</span><br>"
			for(var/datum/addiction/addiction_type as anything in target.mind.active_addictions)
				render_list += "<span class='alert ml-2'>[initial(addiction_type.name)]</span><br>"

		// Special eigenstasium addiction
		if(target.has_status_effect(/datum/status_effect/eigenstasium))
			render_list += "<span class='notice ml-1'>受检者处于时间不稳定状态。建议使用稳定剂减少扰动。</span><br>"

		// Allergies
		for(var/datum/quirk/quirky as anything in target.quirks)
			if(istype(quirky, /datum/quirk/item_quirk/allergic))
				var/datum/quirk/item_quirk/allergic/allergies_quirk = quirky
				var/allergies = allergies_quirk.allergy_string
				render_list += "<span class='alert ml-1'>受检者对以下化学物质严重过敏：</span><br>"
				render_list += "<span class='alert ml-2'>[allergies]</span><br>"

		// we handled the last <br> so we don't need handholding
		if(tochat)
			to_chat(user, custom_boxed_message("blue_box", jointext(render_list, "")), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)
		else
			return jointext(render_list, "")

/obj/item/healthanalyzer/click_alt(mob/user)
	if(mode == SCANNER_NO_MODE)
		return CLICK_ACTION_BLOCKING

	mode = !mode
	to_chat(user, mode == SCANNER_VERBOSE ? "扫描仪现在会显示各肢体的损伤。" : "扫描仪不再显示肢体损伤。")
	return CLICK_ACTION_SUCCESS

/obj/item/healthanalyzer/advanced
	name = "高级健康分析仪"
	icon_state = "health_adv"
	desc = "可高精度检测受检者生命体征的手持人体扫描仪。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/silver = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75)
	scanpower = SCANPOWER_ADVANCED

/obj/item/healthanalyzer/super
	name = "超级健康分析仪"
	icon_state = "health_super"
	desc = "供调试人员使用的健康扫描仪。功能与幽灵的健康扫描相同。"
	scanpower = SCANPOWER_SUPER

#define AID_EMOTION_NEUTRAL "neutral"
#define AID_EMOTION_HAPPY "happy"
#define AID_EMOTION_WARN "cautious"
#define AID_EMOTION_ANGRY "angery"
#define AID_EMOTION_SAD "sad"

/// Displays wounds with extended information on their status vs medscanners
/proc/woundscan(mob/user, mob/living/carbon/patient, obj/item/healthanalyzer/scanner, simple_scan = FALSE)
	if(!istype(patient) || user.incapacitated)
		return

	var/render_list = ""
	var/advised = FALSE
	for(var/limb in patient.get_wounded_bodyparts())
		var/obj/item/bodypart/wounded_part = limb
		render_list += "<span class='alert ml-1'><b>警告：在[chinese_scanner_label(wounded_part.name)]检测到外伤</b>"
		for(var/limb_wound in wounded_part.wounds)
			var/datum/wound/current_wound = limb_wound
			render_list += "<div class='ml-2'>[simple_scan ? current_wound.get_simple_scanner_description() : current_wound.get_scanner_description()]</div><br>"
			if (scanner.give_wound_treatment_bonus)
				ADD_TRAIT(current_wound, TRAIT_WOUND_SCANNED, ANALYZER_TRAIT)
				if(!advised)
					to_chat(user, span_notice("你看到自己的[(length(wounded_part.wounds) || length(patient.get_wounded_bodyparts()) ) > 1 ? "多处伤口" : "伤口"]上浮现出明亮的全息影像。上面似乎满是实用信息，治疗应该会更容易！"))
					advised = TRUE
		render_list += "</span>"

	if(render_list == "")
		if(simple_scan)
			var/obj/item/healthanalyzer/simple/simple_scanner = scanner
			// Only emit the cheerful scanner message if this scan came from a scanner
			playsound(simple_scanner, 'sound/machines/ping.ogg', 50, FALSE)
			to_chat(user, span_notice("[simple_scanner]欢快地叮了一声，短暂显示了一张带有好几个感叹号的笑脸！它兴高采烈地报告：[patient]没有伤口！"))
			simple_scanner.show_emotion(AID_EMOTION_HAPPY)
		to_chat(user, "<span class='notice ml-1'>受检者身上未检测到伤口。</span>")
	else
		to_chat(user, custom_boxed_message("blue_box", jointext(render_list, "")), type = MESSAGE_TYPE_INFO)
		if(simple_scan)
			var/obj/item/healthanalyzer/simple/simple_scanner = scanner
			simple_scanner.show_emotion(AID_EMOTION_WARN)
			playsound(simple_scanner, 'sound/machines/beep/twobeep.ogg', 50, FALSE)


/obj/item/healthanalyzer/simple
	name = "伤口分析仪"
	icon_state = "first_aid"
	desc = "美洛科技出品的医疗扫描仪，实用、防儿童误操作，最重要的是极其便宜，用于诊断伤情并推荐重伤治疗方案。告诉你身上有没有个大窟窿听起来没多大用，但它会在伤口附近投射临时全息影像，其中的信息保证能让治疗效果与速度翻倍。"
	mode = SCANNER_NO_MODE
	give_wound_treatment_bonus = TRUE

	/// Cooldown for when the analyzer will allow you to ask it for encouragement. Don't get greedy!
	var/next_encouragement
	/// The analyzer's current emotion. Affects the sprite overlays and if it's going to prick you for being greedy or not.
	var/emotion = AID_EMOTION_NEUTRAL
	/// Encouragements to play when attack_selfing
	var/list/encouragements = list("短暂显示一张笑脸，空洞地望着你", "短暂显示一颗旋转的卡通爱心", "显示鼓励健康饮食与锻炼的信息", \
			"提醒你每个人都在尽力而为", "显示祝你安康的信息", "真诚地感谢你对急救的关注", "郑重地赦免了你的一切罪过")
	/// How often one can ask for encouragement
	var/patience = 10 SECONDS
	/// What do we scan for, only used in descriptions
	var/scan_for_what = "严重创伤"

/obj/item/healthanalyzer/simple/attack_self(mob/user)
	if(next_encouragement < world.time)
		playsound(src, 'sound/machines/ping.ogg', 50, FALSE)
		to_chat(user, span_notice("[src]欢快地叮了一声，并[pick(encouragements)]！"))
		next_encouragement = world.time + 10 SECONDS
		show_emotion(AID_EMOTION_HAPPY)
	else if(emotion != AID_EMOTION_ANGRY)
		greed_warning(user)
	else
		violence(user)

/obj/item/healthanalyzer/simple/proc/greed_warning(mob/user)
	to_chat(user, span_warning("[src]显示了一张清晰得诡异的苦脸，责备你索取了太多鼓励。"))
	show_emotion(AID_EMOTION_ANGRY)

/obj/item/healthanalyzer/simple/proc/violence(mob/user)
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)
	if(isliving(user))
		var/mob/living/L = user
		to_chat(L, span_warning("[src]失望地嗡了一声，扎了一下你的手指，惩罚你的贪心。哎哟！"))
		flick(icon_state + "_pinprick", src)
		violence_damage(user)
		user.dropItemToGround(src)
		show_emotion(AID_EMOTION_HAPPY)

/obj/item/healthanalyzer/simple/proc/violence_damage(mob/living/user)
	user.adjust_brute_loss(4)

/obj/item/healthanalyzer/simple/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		return NONE
	if(!user.can_read(src)) //SKYRAT EDIT CHANGE - Blind People Can Analyze Again - ORIGINAL: if(!user.can_read(src) || user.is_blind())
		return ITEM_INTERACT_BLOCKING

	add_fingerprint(user)
	user.visible_message(
		span_notice("[user]扫描[interacting_with]，检查是否存在[scan_for_what]。"),
		span_notice("你扫描[interacting_with]，检查是否存在[scan_for_what]。"),
	)

	if(!iscarbon(interacting_with))
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		to_chat(user, span_notice("[src]悲伤地嗡了一声，短暂显示一张不开心的脸，表示无法扫描[interacting_with]。"))
		show_emotion(AI_EMOTION_SAD)
		return ITEM_INTERACT_BLOCKING

	do_the_scan(interacting_with, user)
	flick(icon_state + "_pinprick", src)
	update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/item/healthanalyzer/simple/proc/do_the_scan(mob/living/carbon/scanning, mob/living/user)
	woundscan(user, scanning, src, simple_scan = TRUE)

/obj/item/healthanalyzer/simple/update_overlays()
	. = ..()
	switch(emotion)
		if(AID_EMOTION_HAPPY)
			. += mutable_appearance(icon, "+no_wounds")
		if(AID_EMOTION_WARN)
			. += mutable_appearance(icon, "+wound_warn")
		if(AID_EMOTION_ANGRY)
			. += mutable_appearance(icon, "+angry")
		if(AID_EMOTION_SAD)
			. += mutable_appearance(icon, "+fail_scan")

/// Sets a new emotion display on the scanner, and resets back to neutral in a moment
/obj/item/healthanalyzer/simple/proc/show_emotion(new_emotion)
	emotion = new_emotion
	update_appearance(UPDATE_OVERLAYS)
	if (emotion != AID_EMOTION_NEUTRAL)
		addtimer(CALLBACK(src, PROC_REF(reset_emotions), AID_EMOTION_NEUTRAL), 2 SECONDS)

// Resets visible emotion back to neutral
/obj/item/healthanalyzer/simple/proc/reset_emotions()
	emotion = AID_EMOTION_NEUTRAL
	update_appearance(UPDATE_OVERLAYS)

/obj/item/healthanalyzer/simple/miner
	name = "矿用伤口分析仪"
	icon_state = "miner_aid"
	desc = "美洛科技出品的医疗扫描仪，实用、防儿童误操作，最重要的是极其便宜，用于诊断伤情并推荐重伤治疗方案。告诉你身上有没有个大窟窿听起来没多大用，但它会在伤口附近投射临时全息影像，其中的信息保证能让治疗效果与速度翻倍。这款还装着一根毫无实际用途的酷炫天线！"

/obj/item/healthanalyzer/simple/disease
	name = "病情分析仪"
	desc = "又一款实用性存疑的美洛科技医学扫描仪，如今已相当少见——纳米传讯发现，给医院配发最低档的防疫设备，会造成过多的经济与生命损失，根本无利可图。据传其内置AI很嫉妒急救分析仪的成功。"
	icon_state = "disease_aid"
	mode = SCANNER_NO_MODE
	encouragements = list("鼓励你按时服药", "短暂显示一颗旋转的卡通爱心", "安慰你不必太担心病情", \
			"提醒你每个人都在尽力而为", "显示祝你安康的信息", "显示信息称为你照顾好自己而感到骄傲", "郑重地赦免了你的一切罪过")
	patience = 20 SECONDS
	scan_for_what = "疾病"

/obj/item/healthanalyzer/simple/disease/violence_damage(mob/living/user)
	user.adjust_brute_loss(1)
	user.reagents.add_reagent(/datum/reagent/toxin, rand(1, 3))

/obj/item/healthanalyzer/simple/disease/do_the_scan(mob/living/carbon/scanning, mob/living/user)
	diseasescan(user, scanning, src)

/obj/item/healthanalyzer/simple/disease/update_overlays()
	. = ..()
	switch(emotion)
		if(AID_EMOTION_HAPPY)
			. += mutable_appearance(icon, "+not_infected")
		if(AID_EMOTION_WARN)
			. += mutable_appearance(icon, "+infected")
		if(AID_EMOTION_ANGRY)
			. += mutable_appearance(icon, "+rancurous")
		if(AID_EMOTION_SAD)
			. += mutable_appearance(icon, "+unknown_scan")
	if(emotion != AID_EMOTION_NEUTRAL)
		addtimer(CALLBACK(src, PROC_REF(reset_emotions)), 4 SECONDS) // longer on purpose

/// Checks the individual for any diseases that are visible to the scanner, and displays the diseases in the attacked to the attacker.
/proc/diseasescan(mob/user, mob/living/carbon/patient, obj/item/healthanalyzer/simple/scanner)
	if(!istype(patient) || user.incapacitated)
		return

	var/list/render = list()
	for(var/datum/disease/disease as anything in patient.diseases)
		if(!(disease.visibility_flags & HIDDEN_SCANNER))
			var/disease_cure = disease.cure_text
			if(istype(disease, /datum/disease/advance))
				var/datum/disease/advance/advanced_disease = disease
				disease_cure = advanced_disease.generate_cure_text(1)
			render += "<span class='alert ml-1'><b>警告：检测到[disease.form]</b><br>\
			<div class='ml-2'>名称：[disease.name]。<br>类型：[disease.spread_text]。<br>阶段：[disease.stage]/[disease.max_stages]。<br>治疗：[disease_cure]</div>\
			</span>"

	if(!length(render))
		playsound(scanner, 'sound/machines/ping.ogg', 50, FALSE)
		to_chat(user, span_notice("[scanner]欢快地叮了一声，短暂显示了一张带有好几个感叹号的笑脸！它兴高采烈地报告：[patient]没有疾病！"))
		scanner.emotion = AID_EMOTION_HAPPY
	else
		to_chat(user, span_notice(render.Join("")))
		scanner.emotion = AID_EMOTION_WARN
		playsound(scanner, 'sound/machines/beep/twobeep.ogg', 50, FALSE)

/obj/item/paper/medical_report
	color = "#99ccff"
	desc = "由计算机医疗扫描仪生成的正式健康证明。"
	/// A reference to a mob's weakref that was last scanned by the medical scanner.
	var/datum/weakref/last_healthy_scanned_mob

/obj/item/paper/medical_report/examine(mob/user)
	. = ..()
	if(last_healthy_scanned_mob)
		. += span_notice("此医疗报告可用于完成医疗悬赏。")


#undef SCANMODE_HEALTH
#undef SCANMODE_WOUND
#undef SCANMODE_COUNT

#undef AID_EMOTION_NEUTRAL
#undef AID_EMOTION_HAPPY
#undef AID_EMOTION_WARN
#undef AID_EMOTION_ANGRY
#undef AID_EMOTION_SAD
