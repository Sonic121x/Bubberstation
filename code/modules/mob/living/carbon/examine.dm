/// Adds a newline to the examine list if the above entry is not empty and it is not the first element in the list
#define ADD_NEWLINE_IF_NECESSARY(list) if(length(list) > 0 && list[length(list)]) { list += "" }
#define CARBON_EXAMINE_EMBEDDING_MAX_DIST 4

/mob/living/carbon/human/get_examine_icon(mob/user)
	return null

/mob/living/carbon/examine(mob/user)
	if(HAS_TRAIT(src, TRAIT_UNKNOWN_APPEARANCE) && !isobserver(user))
		return list(span_warning("你竭力想看清任何细节，却什么也辨认不出来……"))
	// BUBBER EDIT ADDITION BEGIN
	if (HAS_TRAIT(user, TRAIT_PARANOIAS_EYE))
		return list(span_hypnophrase("那道光芒刺得你睁不开眼。"))
	// BUBBER EDIT ADDITION END

	// var/t_He = p_They()
	// var/t_His = p_Their()
	// var/t_his = p_their()
	// var/t_him = p_them()
	// var/t_has = p_have()
	// var/t_is = p_are()

	. = list()
	. += get_clothing_examine_info(user)
	// give us some space between clothing examine and the rest
	ADD_NEWLINE_IF_NECESSARY(.)

	var/appears_dead = FALSE
	var/just_sleeping = FALSE

	if(IS_DEAD_OR_FAKING(src))
		appears_dead = TRUE

		var/obj/item/clothing/glasses/shades = get_item_by_slot(ITEM_SLOT_EYES)
		var/are_we_in_weekend_at_bernies = shades?.tint && buckled && istype(buckled, /obj/vehicle/ridden/wheelchair)

		if(isliving(user) && (HAS_MIND_TRAIT(user, TRAIT_NAIVE) || are_we_in_weekend_at_bernies))
			just_sleeping = TRUE

		if(!just_sleeping)
			// since this is relatively important and giving it space makes it easier to read
			ADD_NEWLINE_IF_NECESSARY(.)
			if(HAS_TRAIT(src, TRAIT_SUICIDED))
				. += span_warning("看起来是自杀……已经没有复苏的希望了。")

			. += generate_death_examine_text()

	//Status effects
	var/list/status_examines = get_status_effect_examinations()
	if (length(status_examines))
		. += status_examines

	if(get_bodypart(BODY_ZONE_HEAD) && !get_organ_by_type(/obj/item/organ/brain))
		. += span_deadsay("看起来大脑不见了……")

	var/list/disabled = list()
	for(var/obj/item/bodypart/body_part as anything in get_bodyparts())
		if(body_part.bodypart_disabled)
			disabled += body_part

		var/treatment_distance = isliving(user) && get_dist(src, user) <= CARBON_EXAMINE_EMBEDDING_MAX_DIST
		for(var/obj/item/embedded as anything in body_part.embedded_objects)
			if(embedded.get_embed().stealthy_embed)
				continue
			var/harmless = embedded.get_embed().is_harmless()
			var/stuck_wordage = harmless ? "粘在" : "嵌在"
			var/embed_line = "\a [embedded]"
			if (treatment_distance)
				embed_line = "<a href='byond://?src=[REF(src)];embedded_object=[REF(embedded)];embedded_limb=[REF(body_part)]'>\a [embedded]</a>"
			var/embed_text = "[icon2html(embedded, user)] [embed_line] [stuck_wordage] [body_part.plaintext_zone]！"
			if (harmless)
				. += span_italics(span_notice(embed_text))
			else
				. += span_boldwarning(embed_text)

		var/obj/item/tourniquet/current_tourniquet = LAZYACCESS(body_part.applied_items, LIMB_ITEM_TOURNIQUET)
		if(current_tourniquet)
			var/tourniquet_href = "\a [current_tourniquet]"
			if(treatment_distance)
				tourniquet_href = "<a href='byond://?src=[REF(src)];remove_tourniquet=[REF(body_part)]'>[tourniquet_href]</a>"
			var/tourniquet_msg = "[icon2html(current_tourniquet, user)] [tourniquet_href] 紧紧地绑在[body_part.body_zone == BODY_ZONE_HEAD ? "脖子" : body_part.plaintext_zone]上。"
			if(body_part.body_zone == BODY_ZONE_HEAD)
				. += span_boldwarning(tourniquet_msg)
			else
				. += span_notice(tourniquet_msg)

		for(var/datum/wound/iter_wound as anything in body_part.wounds)
			. += span_danger(iter_wound.get_examine_description(user))

		var/surgery_examine = body_part.get_surgery_examine()
		if(surgery_examine)
			. += surgery_examine


	for(var/obj/item/bodypart/body_part as anything in disabled)
		var/damage_text
		if(HAS_TRAIT(body_part, TRAIT_DISABLED_BY_WOUND))
			continue // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
		if(body_part.get_damage() < body_part.max_damage) //we don't care if it's stamcritted
			damage_text = "瘫软无力"
		else
			damage_text = (body_part.brute_dam >= body_part.burn_dam) ? body_part.heavy_brute_msg : body_part.heavy_burn_msg
		. += span_boldwarning("[body_part.plaintext_zone]看起来[damage_text]！")

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/missing_limb in get_missing_limbs())
		if(missing_limb == BODY_ZONE_HEAD)
			. += span_deadsay("<B>[parse_zone(missing_limb)]不见了！</B>")
			continue
		if(missing_limb == BODY_ZONE_L_ARM || missing_limb == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(missing_limb == BODY_ZONE_R_ARM || missing_limb == BODY_ZONE_R_LEG)
			r_limbs_missing++

		. += span_boldwarning("[parse_zone(missing_limb)]不见了！")

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		. += span_tinydanger("看起来现在倒也没什么问题……")
	else if(l_limbs_missing == 0 && r_limbs_missing >= 2)
		. += span_tinydanger("真是对左边情有独钟……")
	else if(l_limbs_missing >= 2 && r_limbs_missing >= 2)
		. += span_tinydanger("看起来不太完整……")

	if(!(user == src && has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy))) //fake healthy
		var/temp
		if(user == src && has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_crit))//fake damage
			temp = 50
		else
			temp = get_brute_loss()
		var/list/damage_desc = get_majority_bodypart_damage_desc()
		if(temp)
			if(temp < 25)
				. += span_danger("有一些轻微的[damage_desc[BRUTE]]。")
			else if(temp < 50)
				. += span_danger("有<b>中度的</b>[damage_desc[BRUTE]]！")
			else
				. += span_bolddanger("有严重的[damage_desc[BRUTE]]！")

		temp = get_fire_loss()
		if(temp)
			if(temp < 25)
				. += span_danger("有一些轻微的[damage_desc[BURN]]。")
			else if (temp < 50)
				. += span_danger("有<b>中度的</b>[damage_desc[BURN]]！")
			else
				. += span_bolddanger("有严重的[damage_desc[BURN]]！")

	if(pulledby?.grab_state)
		. += span_warning("被 [pulledby] 抓住了。")

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		. += span_warning("严重营养不良。")
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			. += span_hypnophrase("看起来圆润又可口——就像一只肥嘟嘟的小猪。一只美味的小猪。")
		else
			. += "<b>看起来相当胖乎乎的。</b>"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			. += "看起来有点恶心。"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			. += "看起来非常恶心。"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			. += "看起来厌恶极了。"

	var/apparent_blood_volume = CAN_HAVE_BLOOD(src) ? get_blood_volume(apply_modifiers = TRUE) : BLOOD_VOLUME_NORMAL
	if(HAS_TRAIT(src, TRAIT_USES_SKINTONES) && ishuman(src))
		var/mob/living/carbon/human/husrc = src // gross istypesrc but easier than refactoring even further for now
		if(husrc.skin_tone == "albino")
			apparent_blood_volume -= (BLOOD_VOLUME_NORMAL * 0.25) // knocks you down a few pegs
	switch(apparent_blood_volume)
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			. += span_warning("皮肤苍白。")
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
			. += span_boldwarning("面色苍白如死。")
		if(-INFINITY to BLOOD_VOLUME_BAD)
			. += span_deadsay("<b>看起来像一只被压扁的空果汁袋。</b>")

	if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()
		var/list/obj/item/bodypart/grasped_limbs = list()

		for(var/obj/item/bodypart/body_part as anything in get_bodyparts())
			if(body_part.cached_bleed_rate)
				bleeding_limbs += body_part.plaintext_zone
			if(body_part.grasped_by)
				grasped_limbs += body_part.plaintext_zone

		if(LAZYLEN(bleeding_limbs))
			var/bleed_text = "<b>"
			if(appears_dead)
				bleed_text += "<span class='deadsay'>"
				bleed_text += "可以看到血液从敞开的"
			else
				bleed_text += "<span class='warning'>"
				bleed_text += "正在从以下部位流血："

			bleed_text += english_list(bleeding_limbs, and_text = "和")

			if(appears_dead)
				bleed_text += "处渗出，但已经淤积，不再流动。"
			else
				if(HAS_TRAIT(src, TRAIT_BLOOD_FOUNTAIN))
					bleed_text += "，速度快得惊人"
				bleed_text += "！"

			if(appears_dead)
				bleed_text += "<span class='deadsay'>"
			else
				bleed_text += "<span class='warning'>"
			bleed_text += "</b>"

			. += bleed_text
			if(LAZYLEN(grasped_limbs))
				for(var/grasped_part in grasped_limbs)
					. += "正按住[grasped_part]以减缓流血！"

	if(reagents.has_reagent(/datum/reagent/teslium, needs_metabolizing = TRUE))
		. += span_smallnoticeital("正散发着柔和的蓝色光芒！") // this should be signalized

	var/mob/living/living_user = user
	SEND_SIGNAL(living_user, COMSIG_CARBON_MID_EXAMINE, src, .) // Adds examine text after clothing and wounds but before death and scars
	if(just_sleeping)
		. += span_notice("对周围的一切都没有反应，似乎睡着了。")
	else if(!appears_dead)
		if(src != user)
			if(HAS_TRAIT(user, TRAIT_SPIRITUAL) && mind?.holy_role && user != src)
				. += "身上有一股神圣的光环。"
				living_user.add_mood_event("religious_comfort", /datum/mood_event/religiously_comforted)

		if(IS_UNCONSCIOUS(src))
			. += span_notice("对周围的一切都没有反应，似乎睡着了。")
		else if(stat == SOFT_CRIT)
			. += span_notice("几乎失去了意识。")
		else if(HAS_TRAIT(src, TRAIT_DUMB))
			. += "脸上挂着呆滞的表情。"

		var/obj/item/organ/brain/brain = get_organ_by_type(/obj/item/organ/brain)
		if(brain && isnull(ai_controller))
			var/npc_message = ""
			if(HAS_TRAIT(brain, TRAIT_GHOSTROLE_ON_REVIVE) || HAS_TRAIT(src, TRAIT_GHOSTROLE_ON_REVIVE))
				npc_message = "灵魂尚待归位……"
			else if(!key)
				npc_message = "完全处于紧张性木僵状态。深空生活的压力对它来说肯定太沉重了。恢复的可能性微乎其微。"
			else if(!client)
				npc_message = "目光呆滞、心不在焉，已经完全没有任何反应，持续了 [round(((world.time - lastclienttime) / (1 MINUTES)),1)] 分钟。可能很快就会回过神来。" // BUBBER EDIT CHANGE - SSD_INDICATOR - ORIGINAL: npc_message ="[t_He] [t_has] a blank, absent-minded stare and appears completely unresponsive to anything. [t_He] may snap out of it soon."
			if(npc_message)
				// give some space since this is usually near the end
				ADD_NEWLINE_IF_NECESSARY(.)
				. += span_deadsay(npc_message)

	var/scar_severity = 0
	for(var/datum/scar/scar as anything in all_scars)
		if(scar.is_visible(user))
			scar_severity += scar.severity

	if(scar_severity >= 1)
		// give some space since this is even more usually near the end
		ADD_NEWLINE_IF_NECESSARY(.)
		switch(scar_severity)
			if(1 to 4)
				. += span_tinynoticeital("身上有明显的疤痕，你可以再看一次以仔细观察……")
			if(5 to 8)
				. += span_smallnoticeital("身上有几道难看的疤痕，你可以再看一次以仔细观察……")
			if(9 to 11)
				. += span_notice("<i>身上有严重毁容的疤痕，你可以再看一次以仔细观察……</i>")
			if(12 to INFINITY)
				. += span_notice("<b><i>身上简直烂得不成样子，你可以再看一次以仔细观察……</i></b>")

	if(HAS_TRAIT(src, TRAIT_HUSK))
		if(HAS_TRAIT_FROM(src, TRAIT_HUSK, /datum/status_effect/zombie::id))
			. += span_warning("皮肤已经腐烂成病态的绿色。") // future todo: lizards don't have skin, they have scales
		else
			. += span_warning("这具身体已经沦为一具怪诞的干尸。")
	if(HAS_MIND_TRAIT(user, TRAIT_MORBID))
		if(HAS_TRAIT(src, TRAIT_DISSECTED))
			. += span_notice("看起来已经被解剖过。对检查没什么用了……<b><i>暂时如此。</i></b>")
		if(HAS_TRAIT(src, TRAIT_SURGICALLY_ANALYZED))
			. += span_notice("一只熟练的手已经摸清了这具身体的内部构造。日后对其进行实验会容易得多。<b><i>太精美了。</i></b>")
	if(isliving(user) && HAS_MIND_TRAIT(user, TRAIT_EXAMINE_FITNESS))
		. += compare_fitness(user)

	var/hud_info = get_hud_examine_info(user)
	if(length(hud_info))
		. += hud_info

	if(isobserver(user))
		ADD_NEWLINE_IF_NECESSARY(.)
		. += "<b>特质：</b> [get_quirk_string(FALSE, CAT_QUIRK_ALL)]"

	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	if(!isnull(dna?.species))
		for(var/genital in GLOB.possible_genitals)
			if(dna.species.mutant_bodyparts[genital])
				var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
				if(G)
					if(!(G.is_hidden(src)))
						. += "<span class='notice'>露出了生殖器…… <a href='byond://?src=[REF(src)];lookup_info=genitals'>\[仔细查看……\]</a></span>"
						break

	var/flavor_text_link = get_flavor_text()
	if(flavor_text_link)
		. += flavor_text_link

	//BUBBER EDIT ADDITION BEGIN - EXAMINE RECORDS
	if (isobserver(user) || user.mind.can_see_exploitables || user.mind.has_exploitables_override)
		var/perpname = get_face_name(get_id_name(""))
		var/datum/record/locked/target_records = find_record(perpname, TRUE) //apparantly golden is okay with offstation roles having no records, FYI
		var/exploitable_text = target_records?.exploitable_information
		if (target_records && ((length(exploitable_text) > RECORDS_INVISIBLE_THRESHOLD) && ((exploitable_text) != EXPLOITABLE_DEFAULT_TEXT)))
			. += "<a href='byond://?src=[REF(src)];exprecords=1'>\[查看可利用信息\]</a>"
	//BUBBER EDIT END

	//Temporary flavor text addition:
	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) < TEMPORARY_FLAVOR_PREVIEW_LIMIT)
			. += span_revennotice("<br>看起来与平时不同：[temporary_flavor_text]")
		else
			. += span_revennotice("<br>看起来与平时不同：[copytext_char(temporary_flavor_text, 1, TEMPORARY_FLAVOR_PREVIEW_LIMIT)]…… <a href='byond://?src=[REF(src)];temporary_flavor=1'>更多……</a>")

	if(client)
		var/erp_status_pref = client.prefs.read_preference(/datum/preference/choiced/erp_status)
		var/free_use_pref = client.prefs.read_preference(/datum/preference/toggle/erp_free_use)
		if(erp_status_pref && !CONFIG_GET(flag/disable_erp_preferences))
			. += EXAMINE_SECTION_BREAK
			. += span_info("ERP 状态：[span_revenboldnotice(erp_status_pref)][free_use_pref ? "[span_revenboldnotice(" - 免费使用")]" : ""]")
		var/line = get_gender_attraction_string(client.prefs.read_preference(/datum/preference/choiced/display_gender), client.prefs.read_preference(/datum/preference/choiced/attraction))
		if(line)
			. += span_info(line)
	// SKYRAT EDIT END

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE, user, .)
	if(length(.))
		.[1] = "<span class='info'>" + .[1]
		.[length(.)] += "</span>"
	return .

/mob/living/carbon/examine_more(mob/user)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_INVISIBLE_MAN))
		return
	for(var/datum/scar/iter_scar as anything in all_scars)
		if(iter_scar.is_visible(user))
			. += iter_scar.get_examine_description(user)

/**
 * Shows any and all examine text related to any status effects the user has.
 */
/mob/living/proc/get_status_effect_examinations()
	var/list/examine_list = list()

	for(var/datum/status_effect/effect as anything in status_effects)
		var/effect_text = effect.get_examine_text()
		if(!effect_text)
			continue

		examine_list += effect_text

	if(!length(examine_list))
		return

	return examine_list.Join("<br>")

/// Returns death message for mob examine text
/mob/living/carbon/proc/generate_death_examine_text()
	var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
	// var/t_He = p_They()
	// var/t_his = p_their()
	// var/t_is = p_are()
	//This checks to see if the body is revivable
	var/obj/item/organ/brain = get_organ_by_type(/obj/item/organ/brain)
	if((brain && HAS_TRAIT(brain, TRAIT_GHOSTROLE_ON_REVIVE)) || HAS_TRAIT(src, TRAIT_GHOSTROLE_ON_REVIVE))
		return span_deadsay("身体瘫软、毫无反应；没有生命迹象，但可能有另一个灵魂来接管这具身体……")
	var/client_like = client || HAS_TRAIT(src, TRAIT_MIND_TEMPORARILY_GONE)
	var/valid_ghost = ghost?.can_reenter_corpse && ghost?.client
	var/valid_soul = brain || !HAS_TRAIT(src, TRAIT_FAKE_SOULLESS)
	if((brain && client_like) || (valid_ghost && valid_soul))
		return span_deadsay("身体瘫软、毫无反应；没有生命迹象……")
	return span_deadsay("身体瘫软、毫无反应；没有生命迹象，灵魂已经离去……")

/// Returns a list of "damtype" => damage description based off of which bodypart description is most common
/mob/living/carbon/proc/get_majority_bodypart_damage_desc()
	var/list/seen_damage = list() // This looks like: ({Damage type} = list({Damage description for that damage type} = {number of times it has appeared}, ...), ...)
	var/list/most_seen_damage = list() // This looks like: ({Damage type} = {Frequency of the most common description}, ...)
	var/list/final_descriptions = list() // This looks like: ({Damage type} = {Most common damage description for that type}, ...)
	for(var/obj/item/bodypart/part as anything in get_bodyparts())
		for(var/damage_type in part.damage_examines)
			var/damage_desc = part.damage_examines[damage_type]
			if(!seen_damage[damage_type])
				seen_damage[damage_type] = list()

			if(!seen_damage[damage_type][damage_desc])
				seen_damage[damage_type][damage_desc] = 1
			else
				seen_damage[damage_type][damage_desc] += 1

			if(seen_damage[damage_type][damage_desc] > most_seen_damage[damage_type])
				most_seen_damage[damage_type] = seen_damage[damage_type][damage_desc]
				final_descriptions[damage_type] = damage_desc
	return final_descriptions

// BUBBER EDIT BEGIN - replaced examine_title with examine_title_worn across whole proc
/// Coolects examine information about the mob's clothing and equipment
/mob/living/carbon/proc/get_clothing_examine_info(mob/living/user)
	. = list()
	// var/t_He = p_They()
	// var/t_His = p_Their()
	// var/t_his = p_their()
	// var/t_has = p_have()
	// var/t_is = p_are()
	//Hands
	for(var/obj/item/held_thing in held_items)
		if((held_thing.item_flags & (ABSTRACT|HAND_ITEM)) || HAS_TRAIT(held_thing, TRAIT_EXAMINE_SKIP))
			continue
		. += "在[get_held_index_name(get_held_index_of_item(held_thing))]中握着 [held_thing.examine_title_worn(user)]。" // BUBBER EDIT CHANGE - ORIGINAL: . += "[t_He] [t_is] holding [held_thing.examine_title(user)] in [t_his] [get_held_index_name(get_held_index_of_item(held_thing))]."
	for(var/obj/item/bodypart/arm/part in get_bodyparts())
		if(!(part.bodypart_flags & BODYPART_PSEUDOPART))
			continue
		var/obj/item/corresponding_item = get_item_for_held_index(part.held_index) || part
		. += "用 [corresponding_item.examine_title(user)] 代替了[initial(part.plaintext_zone)]。"
	//handcuffed?
	if(handcuffed)
		var/cables_or_cuffs = istype(handcuffed, /obj/item/restraints/handcuffs/cable) ? "被线缆绑住" : "被手铐铐住"
		. += span_warning("[icon2html(handcuffed, user)] [cables_or_cuffs]！")
	//eyes
	if(!(obscured_slots & HIDEEYES))
		if(HAS_TRAIT(src, TRAIT_UNNATURAL_RED_GLOWY_EYES))
			. += span_warning("<B>双眼散发着不自然的红色光芒！</B>")
		else if(HAS_TRAIT(src, TRAIT_BLOODSHOT_EYES))
			. += span_warning("<B>双眼布满血丝！</B>")

// Yes there's a lot of copypasta here, we can improve this later when carbons are less dumb in general
// BUBBER EDIT BEGIN - replaced examine_title with examine_title_worn across whole proc
/mob/living/carbon/human/get_clothing_examine_info(mob/living/user)
	. = list()
	// var/t_He = p_They()
	// var/t_His = p_Their()
	// var/t_his = p_their()
	// var/t_has = p_have()
	// var/t_is = p_are()

	//uniform
	if(w_uniform && !(obscured_slots & HIDEJUMPSUIT) && !HAS_TRAIT(w_uniform, TRAIT_EXAMINE_SKIP))
		//accessory
		var/accessory_message = ""
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/undershirt = w_uniform
			var/list/accessories = undershirt.list_accessories_with_icon(user)
			if(length(accessories))
				accessory_message = "，并附有 [english_list(accessories)]"

		. += "穿着 [w_uniform.examine_title_worn(user)][accessory_message]。"
	//head
	if(head && !(obscured_slots & HIDEHEADGEAR) && !HAS_TRAIT(head, TRAIT_EXAMINE_SKIP))
		. += "头上戴着 [head.examine_title_worn(user)]。"
	//mask
	if(wear_mask && !(obscured_slots & HIDEMASK)  && !HAS_TRAIT(wear_mask, TRAIT_EXAMINE_SKIP))
		. += "脸上戴着 [wear_mask.examine_title_worn(user)]。"
	//neck
	if(wear_neck && !(obscured_slots & HIDENECK)  && !HAS_TRAIT(wear_neck, TRAIT_EXAMINE_SKIP))
		. += "脖子上戴着 [wear_neck.examine_title_worn(user)]。"
	//eyes
	if(!(obscured_slots & HIDEEYES))
		if(glasses  && !HAS_TRAIT(glasses, TRAIT_EXAMINE_SKIP))
			. += "眼睛上戴着 [glasses.examine_title_worn(user)]。"
		else if(HAS_TRAIT(src, TRAIT_UNNATURAL_RED_GLOWY_EYES))
			. += span_warning("<B>双眼散发着不自然的红色光芒！</B>")
		else if(HAS_TRAIT(src, TRAIT_BLOODSHOT_EYES))
			. += span_warning("<B>双眼布满血丝！</B>")
	//ears
	if(ears && !(obscured_slots & HIDEEARS) && !HAS_TRAIT(ears, TRAIT_EXAMINE_SKIP))
		. += "耳朵上戴着 [ears.examine_title_worn(user)]。"
	//suit/armor
	if(wear_suit && !HAS_TRAIT(wear_suit, TRAIT_EXAMINE_SKIP))
		. += "穿着 [wear_suit.examine_title_worn(user)]。"
		//suit/armor storage
		if(s_store && !(obscured_slots & HIDESUITSTORAGE) && !HAS_TRAIT(s_store, TRAIT_EXAMINE_SKIP))
			. += "在[wear_suit.name]上挂着 [s_store.examine_title_worn(user)]。"
	//back
	if(back && !HAS_TRAIT(back, TRAIT_EXAMINE_SKIP))
		. += "背上背着 [back.examine_title_worn(user)]。"
	//ID
	if(wear_id && !HAS_TRAIT(wear_id, TRAIT_EXAMINE_SKIP))
		var/obj/item/card/id/id = wear_id.GetID()
		if(id && get_dist(user, src) <= ID_EXAMINE_DISTANCE)
			var/id_href = "<a href='byond://?src=[REF(src)];see_id=1;id_ref=[REF(id)];id_name=[id.registered_name];examine_time=[world.time]'>[wear_id.examine_title(user)]</a>"
			. += "戴着 [id_href]。"

		else
			. += "戴着 [wear_id.examine_title_worn(user)]。"
	//Hands
	for(var/obj/item/held_thing in held_items)
		if((held_thing.item_flags & (ABSTRACT|HAND_ITEM)) || HAS_TRAIT(held_thing, TRAIT_EXAMINE_SKIP))
			continue
		. += "在[get_held_index_name(get_held_index_of_item(held_thing))]中握着 [held_thing.examine_title_worn(user)]。" // BUBBER EDIT CHANGE - ORIGINAL: . += "[t_He] [t_is] holding [held_thing.examine_title(user)] in [t_his] [get_held_index_name(get_held_index_of_item(held_thing))]."
	for(var/obj/item/bodypart/arm/part in get_bodyparts())
		if(!(part.bodypart_flags & BODYPART_PSEUDOPART))
			continue
		var/obj/item/corresponding_item = get_item_for_held_index(part.held_index) || part
		. += "用 [corresponding_item.examine_title_worn(user)] 代替了[initial(part.plaintext_zone)]。" // BUBBER EDIT CHANGE - ORIGINAL: . += "[t_He] [t_has] [corresponding_item.examine_title(user)] in place of [t_his] [initial(part.plaintext_zone)]."
	//gloves
	if(gloves && !(obscured_slots & HIDEGLOVES) && !HAS_TRAIT(gloves, TRAIT_EXAMINE_SKIP))
		. += "手上戴着 [gloves.examine_title(user)]。"
	else if(GET_ATOM_BLOOD_DECAL_LENGTH(src) && num_hands)
		var/list/blood_stains = GET_ATOM_BLOOD_DECALS(src)
		var/datum/blood_type/blood_type = blood_stains[blood_stains[length(blood_stains)]]
		var/blood_descriptior = "血液"
		if(istype(blood_type))
			blood_descriptior = chinese_scanner_label(LOWER_TEXT(blood_type.get_blood_name()))
		. += span_warning("[num_hands > 1 ? "双手" : "一只手"]沾满了[blood_descriptior]！")
	else if (blood_in_hands && num_hands)
		. += span_warning("[num_hands > 1 ? "双手" : "一只手"]沾满了血！")
	//handcuffed?
	if(handcuffed)
		var/cables_or_cuffs = istype(handcuffed, /obj/item/restraints/handcuffs/cable) ? "被线缆绑住" : "被手铐铐住"
		. += span_warning("[icon2html(handcuffed, user)] [cables_or_cuffs]！")
	//belt
	if(belt && !(obscured_slots & HIDEBELT) && !HAS_TRAIT(belt, TRAIT_EXAMINE_SKIP))
		. += "腰上别着 [belt.examine_title_worn(user)]。"
	//shoes
	if(shoes && !(obscured_slots & HIDESHOES)  && !HAS_TRAIT(shoes, TRAIT_EXAMINE_SKIP))
		. += "脚上穿着 [shoes.examine_title_worn(user)]。"
// BUBBER EDIT END

/// Collects info displayed about any HUDs the user has when examining src
/mob/living/carbon/proc/get_hud_examine_info(mob/living/user)
	return

/mob/living/carbon/human/get_hud_examine_info(mob/living/user)
	. = list()

	var/perpname = get_face_name(get_id_name(""))
	var/title = ""
	if(perpname && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)) && (!IS_UNCONSCIOUS_OR_CRIT(user) || isobserver(user)) && user != src)
		var/datum/record/crew/target_record = find_record(perpname)
		if(target_record)
			. += "职衔：[target_record.rank]"
			. += "<a href='byond://?src=[REF(src)];hud=1;photo_front=1;examine_time=[world.time]'>\[正面照\]</a><a href='byond://?src=[REF(src)];hud=1;photo_side=1;examine_time=[world.time]'>\[侧面照\]</a>"
		if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD) && HAS_TRAIT(user, TRAIT_SECURITY_HUD))
			title = separator_hr("医疗与安保分析")
			. += get_medhud_examine_info(user, target_record)
			. += get_sechud_examine_info(user, target_record)

		else if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
			title = separator_hr("医疗分析")
			. += get_medhud_examine_info(user, target_record)

		else if(HAS_TRAIT(user, TRAIT_SECURITY_HUD))
			title = separator_hr("安保分析")
			. += get_sechud_examine_info(user, target_record)

	// applies the separator correctly without an extra line break
	if(title && length(.))
		.[1] = title + .[1]
	return .

/// Collects information displayed about src when examined by a user with a medical HUD.
/mob/living/carbon/proc/get_medhud_examine_info(mob/living/user, datum/record/crew/target_record)
	. = list()

	var/list/cybers = list()
	for(var/obj/item/organ/cyberimp/cyberimp in organs)
		if(IS_ROBOTIC_ORGAN(cyberimp) && !(cyberimp.organ_flags & ORGAN_HIDDEN))
			cybers += cyberimp.examine_title(user)
	if(length(cybers))
		. += "<span class='notice ml-1'>检测到赛博植入改造：</span>"
		. += "<span class='notice ml-2'>[english_list(cybers, and_text = "和")]</span>"
	if(target_record)
		. += "<a href='byond://?src=[REF(src)];hud=m;physical_status=1;examine_time=[world.time]'>\[[target_record.physical_status]\]</a>"
		. += "<a href='byond://?src=[REF(src)];hud=m;mental_status=1;examine_time=[world.time]'>\[[target_record.mental_status]\]</a>"
	else
		. += "\[记录缺失\]"
		. += "\[记录缺失\]"
	. += "<a href='byond://?src=[REF(src)];hud=m;evaluation=1;examine_time=[world.time]'>\[医疗评估\]</a>"
	. += "<a href='byond://?src=[REF(src)];hud=m;quirk=1;examine_time=[world.time]'>\[查看特质\]</a>"

/// Collects information displayed about src when examined by a user with a security HUD.
/mob/living/carbon/proc/get_sechud_examine_info(mob/living/user, datum/record/crew/target_record)
	. = list()

	var/wanted_status = WANTED_NONE
	var/security_note = "无。"

	if(target_record)
		wanted_status = target_record.wanted_status
		if(target_record.security_note)
			security_note = target_record.security_note
	// BUBBER EDIT ADDITION START - silly HUDsunglasses replace the criminal status field outright
	var/mob/living/carbon/human/human_examiner = user
	if(ishuman(user) && istype(human_examiner.glasses, /obj/item/clothing/glasses/hud/security/sunglasses/guard/silly))
		. += "犯罪状态：<a href='byond://?src=[REF(src)];hud=s;honkstatus=1;examine_time=[world.time]'>\[[wanted_status]\]</a>"
	else if(ishuman(user))
	// BUBBER EDIT ADDITION END
		. += "犯罪状态：<a href='byond://?src=[REF(src)];hud=s;status=1;examine_time=[world.time]'>\[[wanted_status]\]</a>"
	else
		. += "犯罪状态：[wanted_status]"
	. += "重要备注：[security_note]"
	. += "安保记录：<a href='byond://?src=[REF(src)];hud=s;view=1;examine_time=[world.time]'>\[查看\]</a>"
	if(ishuman(user))
		. += "<a href='byond://?src=[REF(src)];hud=s;add_citation=1;examine_time=[world.time]'>\[添加传票\]</a>\
			<a href='byond://?src=[REF(src)];hud=s;add_crime=1;examine_time=[world.time]'>\[添加罪行\]</a>\
			<a href='byond://?src=[REF(src)];hud=s;add_note=1;examine_time=[world.time]'>\[添加备注\]</a>"

/mob/living/carbon/human/examine_more(mob/user)
	. = ..()

	if(istype(w_uniform, /obj/item/clothing/under) && !(obscured_slots & HIDEJUMPSUIT) && !HAS_TRAIT(w_uniform, TRAIT_EXAMINE_SKIP))
		var/obj/item/clothing/under/undershirt = w_uniform
		if(undershirt.has_sensor == BROKEN_SENSORS)
			. += list(span_notice("\The [undershirt] 的医疗传感器正在冒火花。"))

	if((HAS_TRAIT(src, TRAIT_UNKNOWN_APPEARANCE) || HAS_TRAIT(src, TRAIT_INVISIBLE_MAN)) && !isobserver(user))
		return

	var/limbs_text = get_mismatched_limb_text()
	if(LAZYLEN(limbs_text))
		. += limbs_text

	var/agetext = get_age_text()
	if(agetext)
		. += agetext

/// Reports all body parts which are mismatched with the user's species
/mob/living/carbon/human/proc/get_mismatched_limb_text()
	var/list/covered = get_covered_body_zones()
	var/list/texts = list()
	for(var/obj/item/bodypart/part as anything in get_bodyparts())
		var/part_id = part.limb_id
		var/obj/item/bodypart/expected_part = dna?.species?.bodypart_overrides[part.body_zone]
		var/expected_id = initial(expected_part?.limb_id)
		// only report abnormal bodyparts
		if(part_id == expected_id)
			continue
		// same shape bodyparts are concealed by clothing
		// this means you can see ex. digitigrade legs through clothes
		// but you can't see ex. cybernetic legs through clothes
		if(part.bodyshape == initial(expected_part?.bodyshape) && (part.body_zone in covered))
			continue
		texts += span_notice("身上长着 \a [part]。")

	return texts

/// Reports how old the mob appears to be
/mob/living/carbon/human/proc/get_age_text()
	if(obscured_slots & HIDEFACE)
		return

	var/age_text
	switch(age)
		if(-INFINITY to 17) // BUBBER EDIT ADD START -- AGE EXAMINE
			age_text = "太年轻了，不该出现在这里"
		if(18 to 25)
			age_text = "一个年轻人"
		if(26 to 35)
			age_text = "一个成年人" // BUBBER EDIT END
		if(36 to 55)
			age_text = "中年人"
		if(56 to 75)
			age_text = "相当年长"
		if(76 to 100)
			age_text = "非常苍老"
		if(101 to INFINITY)
			age_text = "日渐衰朽"

	return span_notice("看起来[age_text]。")

#undef ADD_NEWLINE_IF_NECESSARY
#undef CARBON_EXAMINE_EMBEDDING_MAX_DIST
