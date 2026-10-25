/datum/martial_art/kaza_ruk
	name = "卡扎鲁克"
	id = MARTIALART_KAZA_RUK
	grab_damage_modifier = 5
	grab_escape_chance_modifier = -10
	VAR_PRIVATE/datum/action/neck_chop/neckchop
	VAR_PRIVATE/datum/action/low_sweep/lowsweep
	VAR_PRIVATE/datum/action/lung_punch/lungpunch

/datum/martial_art/kaza_ruk/activate_style(mob/living/new_holder)
	. = ..()
	RegisterSignal(new_holder, COMSIG_HUMAN_PUNCHED, PROC_REF(blow_followup))

/datum/martial_art/kaza_ruk/deactivate_style(mob/living/old_holder)
	. = ..()
	UnregisterSignal(old_holder, COMSIG_HUMAN_PUNCHED)

/datum/martial_art/kaza_ruk/New()
	. = ..()
	neckchop = new(src)
	lowsweep = new(src)
	lungpunch = new(src)

/datum/martial_art/kaza_ruk/Destroy()
	neckchop = null
	lowsweep = null
	lungpunch = null
	return ..()

/datum/action/neck_chop
	name = "劈颈"
	desc = "击伤颈部，使受害者暂时无法说话。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "neckchop"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/neck_chop/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	if (source.streak == "neck_chop")
		owner.visible_message(span_danger("[owner]恢复了普通架势。"), "<b><i>已取消预备招式。</i></b>")
		owner.balloon_alert(owner, "已取消")
		source.streak = ""
	else
		owner.visible_message(span_danger("[owner]摆出了劈颈的架势！"), "<b><i>下一次攻击将使用劈颈。</i></b>")
		owner.balloon_alert(owner, "劈颈")
		source.streak = "neck_chop"

/datum/action/low_sweep
	name = "下段扫击"
	desc = "绊倒受害者，使其短暂倒地。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "legsweep"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/low_sweep/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	if (source.streak == "low_sweep")
		owner.visible_message(span_danger("[owner]恢复了普通架势。"), "<b><i>已取消预备招式。</i></b>")
		owner.balloon_alert(owner, "已取消")
		source.streak = ""
	else
		owner.visible_message(span_danger("[owner]摆出了下段扫击的架势！"), "<b><i>下一次攻击将使用下段扫击。</i></b>")
		owner.balloon_alert(owner, "下段扫击")
		source.streak = "low_sweep"

/datum/action/lung_punch//referred to internally as 'quick choke'
	name = "击肺拳"
	desc = "重击受害者腹部上方，压迫肺部，使其暂时无法呼吸。"
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "lungpunch"
	check_flags = AB_CHECK_INCAPACITATED|AB_CHECK_HANDS_BLOCKED|AB_CHECK_CONSCIOUS

/datum/action/lung_punch/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/martial_art/source = target
	if (source.streak == "quick_choke")
		owner.visible_message(span_danger("[owner]恢复了普通架势。"), "<b><i>已取消预备招式。</i></b>")
		owner.balloon_alert(owner, "已取消")
		source.streak = ""
	else
		owner.visible_message(span_danger("[owner]摆出了击肺拳的架势！"), "<b><i>下一次攻击将使用击肺拳。</i></b>")
		owner.balloon_alert(owner, "击肺拳")
		source.streak = "quick_choke"//internal name for lung punch

/datum/martial_art/kaza_ruk/activate_style(mob/living/new_holder)
	. = ..()
	to_chat(new_holder, span_userdanger("你掌握了[name]！"))
	to_chat(new_holder, span_danger("将光标悬停在屏幕顶部的招式上，即可查看其效果。"))
	neckchop.Grant(new_holder)
	lowsweep.Grant(new_holder)
	lungpunch.Grant(new_holder)

/datum/martial_art/kaza_ruk/deactivate_style(mob/living/remove_from)
	to_chat(remove_from, span_userdanger("你突然忘记了[name]的技法……"))
	neckchop?.Remove(remove_from)
	lowsweep?.Remove(remove_from)
	lungpunch?.Remove(remove_from)
	return ..()

/datum/martial_art/kaza_ruk/proc/check_streak(mob/living/attacker, mob/living/defender)
	switch(streak)
		if("neck_chop")
			streak = ""
			neck_chop(attacker, defender)
			return TRUE
		if("low_sweep")
			streak = ""
			low_sweep(attacker, defender)
			return TRUE
		if("quick_choke")//is actually lung punch
			streak = ""
			quick_choke(attacker, defender)
			return TRUE
	return FALSE

/datum/martial_art/kaza_ruk/proc/low_sweep(mob/living/attacker, mob/living/defender)
	if(IS_UNCONSCIOUS_OR_CRIT(defender) || defender.IsParalyzed())
		return MARTIAL_ATTACK_INVALID
	if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return MARTIAL_ATTACK_INVALID // Does 5 damage, so we can't let pacifists leg sweep.

	var/tail_sweeping = FALSE
	var/sweeping_language = "腿"
	if(ishuman(attacker))
		var/mob/living/carbon/possible_human = attacker
		var/obj/item/organ/tail/lizard/possible_lizard_tail = possible_human.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(possible_lizard_tail)
			tail_sweeping = TRUE
			sweeping_language = "尾巴"

	defender.visible_message(
		span_warning("[attacker]用[sweeping_language]扫倒了[defender]！"),
		span_userdanger("[attacker]扫中了你的双腿！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("你用[sweeping_language]扫倒了[defender]！"))
	playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)

	if(tail_sweeping)
		attacker.emote("spin")

	defender.apply_damage(5, BRUTE, BODY_ZONE_CHEST)
	defender.Knockdown(6 SECONDS)
	log_combat(attacker, defender, "leg sweeped")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/kaza_ruk/proc/quick_choke(mob/living/attacker, mob/living/defender)//is actually lung punch
	attacker.do_attack_animation(defender)
	defender.visible_message(
		span_warning("[attacker]重击了[defender]的胸口！"),
		span_userdanger("[attacker]重击了你的胸口！你无法呼吸了！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你重击了[defender]的胸口！"))
	playsound(attacker, 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	if(defender.losebreath <= 10)
		defender.losebreath = clamp(defender.losebreath + 5, 0, 10)
	defender.adjust_oxy_loss(10)
	log_combat(attacker, defender, "quickchoked")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/kaza_ruk/proc/neck_chop(mob/living/attacker, mob/living/defender)
	if(HAS_TRAIT(attacker, TRAIT_PACIFISM))
		return MARTIAL_ATTACK_INVALID // Does 10 damage, so we can't let pacifists neck chop.
	attacker.do_attack_animation(defender)
	defender.visible_message(
		span_warning("[attacker]一记手刀劈中了[defender]的颈部！"),
		span_userdanger("[attacker]一记手刀劈中了你的颈部，使你无法说话！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	to_chat(attacker, span_danger("你一记手刀劈中了[defender]的颈部，使其无法说话！"))
	playsound(attacker, 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	defender.apply_damage(10, attacker.get_attack_type(), BODY_ZONE_HEAD)
	defender.adjust_silence_up_to(20 SECONDS, 20 SECONDS)
	log_combat(attacker, defender, "neck chopped")
	return MARTIAL_ATTACK_SUCCESS

/datum/martial_art/kaza_ruk/harm_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 10, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_INVALID

/datum/martial_art/kaza_ruk/disarm_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	var/obj/item/stuff_in_hand = defender.get_active_held_item()
	if(prob(60) && stuff_in_hand && defender.temporarilyRemoveItemFromInventory(stuff_in_hand))
		attacker.put_in_hands(stuff_in_hand)
		defender.visible_message(
			span_danger("[attacker]夺走了[defender]手中的东西！"),
			span_userdanger("[attacker]夺走了你手中的东西！"),
			span_hear("你听到了激烈的推搡声！"),
			COMBAT_MESSAGE_RANGE,
			attacker,
		)
		to_chat(attacker, span_danger("你夺走了[defender]手中的东西！"))
		playsound(defender, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
		log_combat(attacker, defender, "disarmed (Kaza Ruk)", addition = "(disarmed of [stuff_in_hand])")
	return MARTIAL_ATTACK_INVALID // normal shove

/// First, determine if we're going to execute our followup attack

/datum/martial_art/kaza_ruk/proc/blow_followup(mob/living/source, mob/living/target, damage, attack_type, obj/item/bodypart/affecting, final_armor_block, kicking, limb_sharpness)
	SIGNAL_HANDLER

	if(!prob(50))
		return

	addtimer(CALLBACK(src, PROC_REF(execute_followup), source, target, damage, attack_type, affecting, final_armor_block, kicking, limb_sharpness), 0.25 SECONDS)

/// After our delay, do the followup.

/datum/martial_art/kaza_ruk/proc/execute_followup(mob/living/source, mob/living/target, damage, attack_type, obj/item/bodypart/affecting, final_armor_block, kicking, limb_sharpness)
	if(QDELETED(source) || QDELETED(target))
		return

	if(!source.Adjacent(target))
		return

	var/tail_usage = FALSE
	var/kick_language = "下劈腿"
	var/strike_language = "肘击"
	if(ishuman(source))
		var/mob/living/carbon/possible_human = source
		var/obj/item/organ/tail/lizard/possible_lizard_tail = possible_human.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
		if(possible_lizard_tail)
			tail_usage = TRUE
			kick_language = "劈顶尾击"
			strike_language = "旋身尾鞭"

	source.visible_message(
		span_warning("[source]紧接着对[target]使出一记[kicking ? kick_language : strike_language]！"),
		span_notice("你对[target]使出一记[kicking ? kick_language : strike_language]！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
	)
	if(tail_usage)
		source.emote(kicking ? "flip" : "spin")
	playsound(source, 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	source.do_attack_animation(target, ATTACK_EFFECT_KICK)
	target.apply_damage(round(damage/3,1), attack_type, affecting, final_armor_block, wound_bonus = damage) //Ostensibly, apply a third of our damage again // We're not being too fussy about limb bonuses for this
	log_combat(source, target, "auto-followup strike (Kaza Ruk)")

//Kaza Ruk Gloves

/obj/item/clothing/gloves/kaza_ruk
	abstract_type = /obj/item/clothing/gloves/kaza_ruk
	clothing_traits = list(TRAIT_FAST_CUFFING)

/obj/item/clothing/gloves/kaza_ruk/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/kaza_ruk)

/datum/atom_skin/kaza_ruk
	abstract_type = /datum/atom_skin/kaza_ruk
	reset_missing = FALSE
	/// Color (/matrix) applied with the skin. If null, no color is applied.
	var/reskin_color

/datum/atom_skin/kaza_ruk/apply(atom/apply_to)
	. = ..()
	if(reskin_color)
		apply_to.add_atom_colour(color_matrix_filter(reskin_color), FIXED_COLOUR_PRIORITY)

/datum/atom_skin/kaza_ruk/clear_skin(atom/clear_from)
	. = ..()
	if(reskin_color)
		clear_from.remove_atom_colour(FIXED_COLOUR_PRIORITY, reskin_color)

/datum/atom_skin/kaza_ruk/get_preview_icon(atom/for_atom)
	var/image/generated = ..()
	if(reskin_color)
		generated.add_filter("preview_filter", 1, color_matrix_filter(reskin_color))
	return generated

/datum/atom_skin/kaza_ruk/red
	preview_name = "红色"

/datum/atom_skin/kaza_ruk/blue
	preview_name = "蓝色"
	reskin_color = list(0.33, 0.33, 0.33, 0, 0, 0, 0, 0, 1)

/obj/item/clothing/gloves/kaza_ruk/sec//more obviously named, given to sec
	name = "卡扎鲁克手套"
	desc = "这副手套似乎能引导你施展适合非蜥蜴人的改良版提兹拉武术——卡扎鲁克。\
		你不太确定它的原理，可能是纳米机器人吧。"
	icon_state = "fightgloves"
	greyscale_colors = "#c41e0d"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/kaza_ruk/sec/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/kaza_ruk, infinite = TRUE)

/obj/item/clothing/gloves/kaza_ruk/combatglovesplus
	name = "强化战斗手套"
	desc = "这副战术手套防火且绝缘，似乎能引导你施展适合非蜥蜴人的改良版提兹拉武术——卡扎鲁克。"
	icon_state = "black"
	greyscale_colors = "#2f2e31"
	siemens_coefficient = 0
	strip_delay = 8 SECONDS
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/kaza_ruk_combatglovesplus

/datum/armor/kaza_ruk_combatglovesplus
	bio = 90
	fire = 80
	acid = 50
