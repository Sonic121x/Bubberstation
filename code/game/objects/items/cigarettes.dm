//cleansed 9/15/2012 17:48

/*
CONTAINS:
MATCHES
CIGARETTES
CIGARS
SMOKING PIPES

CIGARETTE PACKETS ARE IN FANCY.DM
*/

///////////
//MATCHES//
///////////
/obj/item/match
	name = "火柴"
	desc = "一根简单的火柴，用于点燃上好的烟草制品。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	inhand_icon_state = "cigoff"
	base_icon_state = "match"
	w_class = WEIGHT_CLASS_TINY
	heat = 1000
	/// Whether this match has been lit.
	var/lit = FALSE
	/// Whether this match has burnt out.
	var/burnt = FALSE
	/// How long the match lasts in seconds
	var/smoketime = 10 SECONDS
	/// If the match is broken
	var/broken = FALSE

/obj/item/match/grind_results()
	return list(/datum/reagent/phosphorus = 2)

/obj/item/match/process(seconds_per_tick)
	smoketime -= seconds_per_tick * (1 SECONDS)
	if(smoketime <= 0)
		matchburnout()
	else
		open_flame(heat)

/obj/item/match/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	matchignite()

/obj/item/match/update_name(updates)
	. = ..()
	if(lit)
		name = "点燃的[initial(name)]"
	else if(burnt)
		name = "烧尽的[initial(name)]"
	else if(broken)
		name = "折断的[initial(name)]"
	else
		name = "[initial(name)]"

/obj/item/match/update_desc(updates)
	. = ..()
	if(lit)
		desc = "[initial(desc)]这根已经点燃。"
	else if(burnt)
		desc = "[initial(desc)]这根已不复往日光彩。"
	else if(broken)
		desc = "[initial(desc)]这根已经折断。"
	else
		desc = initial(desc)

/obj/item/match/update_icon_state()
	. = ..()
	inhand_icon_state = "cigoff"
	if(lit)
		icon_state = "[base_icon_state]_lit"
		inhand_icon_state = "cigon"
	else if(burnt)
		icon_state = "[base_icon_state]_burnt"
	else if(broken)
		icon_state = "[base_icon_state]_broken"
	else
		icon_state = "[base_icon_state]_unlit"

/obj/item/match/proc/snap()
	if(broken)
		return
	if(lit)
		matchburnout()

	playsound(src, 'sound/effects/snap.ogg', 15, TRUE)
	broken = TRUE
	attack_verb_continuous = string_list(list("弹击"))
	attack_verb_simple = string_list(list("弹击"))
	STOP_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/match/proc/matchignite()
	if(lit || burnt || broken)
		return
	playsound(src, 'sound/items/match_strike.ogg', 15, TRUE)
	lit = TRUE
	damtype = BURN
	force = 3
	hitsound = 'sound/items/tools/welder.ogg'
	attack_verb_continuous = string_list(list("烧灼", "燎烧"))
	attack_verb_simple = string_list(list("烧灼", "燎烧"))
	if(isliving(loc))
		var/mob/living/male_model = loc
		if(male_model.fire_stacks && !(male_model.on_fire))
			male_model.ignite_mob()
	START_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/match/proc/matchburnout()
	if(!lit)
		return

	lit = FALSE
	burnt = TRUE
	damtype = BRUTE
	force = initial(force)
	attack_verb_continuous = string_list(list("弹击"))
	attack_verb_simple = string_list(list("弹击"))
	STOP_PROCESSING(SSobj, src)
	update_appearance()

/obj/item/match/extinguish()
	. = ..()
	matchburnout()

/obj/item/match/dropped(mob/user)
	matchburnout()
	return ..()

/obj/item/match/attack(mob/living/target_mob, mob/living/carbon/user)
	if(!isliving(target_mob))
		return

	if(lit && target_mob.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)]在[AREACOORD(user)]用[src]点燃了[key_name_admin(target_mob)]")
		user.log_message("set [key_name(target_mob)] on fire with [src]", LOG_ATTACK)

	var/obj/item/cigarette/cig = help_light_cig(target_mob)
	if(!lit || !cig || user.combat_mode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("[cig]已经点燃了！"))
		return

	cig.attempt_light(user, src, target_mob == user ? null : span_notice("[user]向[target_mob]递出[src]，点燃了[cig]。"))

/// Finds a cigarette on another mob to help light.
/obj/item/proc/help_light_cig(mob/living/M)
	var/mask_item = M.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(mask_item, /obj/item/cigarette))
		return mask_item

/obj/item/match/get_temperature()
	return lit * heat

/obj/item/match/firebrand
	name = "引火棒"
	desc = "一根未点燃的引火棒。你不禁想问，为什么不干脆叫它木棍。"
	smoketime = 40 SECONDS
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/match/firebrand/grind_results()
	return list(/datum/reagent/carbon = 2)

/obj/item/match/firebrand/Initialize(mapload)
	. = ..()
	matchignite()

/obj/item/match/battery
	name = "电池打火器"
	desc = "用电池和一些铝制成的廉价打火器。紧握即可点燃。"
	icon_state = "battery_unlit"
	base_icon_state = "battery"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5)

/obj/item/match/battery/attack_self(mob/living/user, modifiers)
	. = ..()
	if(!do_after(user, 4 SECONDS, src))
		return
	user.apply_damage(5, BURN, user.get_active_hand())
	matchignite()

//////////////////
//FINE SMOKABLES//
//////////////////

/obj/item/cigarette
	name = "香烟"
	desc = "一卷烟草和尼古丁。它不是食物。"
	icon = 'icons/obj/cigarettes.dmi'
	worn_icon = 'icons/mob/clothing/mask.dmi'
	icon_state = "cigoff"
	inhand_icon_state = "cigon" //gets overriden during intialize(), just have it for unit test sanity.
	throw_speed = 0.5
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MASK
	heat = 1000
	light_range = 1
	light_color = LIGHT_COLOR_FIRE
	light_system = OVERLAY_LIGHT
	light_on = FALSE
	throw_verb = "弹出"
	/// Whether this cigarette has been lit.
	VAR_FINAL/lit = FALSE
	/// Whether this cigarette should start lit.
	var/starts_lit = FALSE
	// Note - these are in masks.dmi not in cigarette.dmi
	/// The icon state used when this is lit.
	var/icon_on = "cigon"
	/// The icon state used when this is extinguished.
	var/icon_off = "cigoff"
	/// The inhand icon state used when this is lit.
	var/inhand_icon_on = "cigon"
	/// The inhand icon state used when this is extinguished.
	var/inhand_icon_off = "cigoff"
	/// How long the cigarette lasts in seconds
	var/smoketime = 6 MINUTES
	/// How much time between drags of the cigarette.
	var/dragtime = 10 SECONDS
	/// The cooldown that prevents just huffing the entire cigarette at once.
	COOLDOWN_DECLARE(drag_cooldown)
	/// The type of cigarette butt spawned when this burns out.
	var/type_butt = /obj/item/cigbutt
	/// The capacity for chems this cigarette has.
	var/chem_volume = 30
	/// The reagents that this cigarette starts with.
	var/list/list_reagents = list(/datum/reagent/drug/nicotine = 15)
	/// Should we smoke all of the chems in the cig before it runs out. Splits each puff to take a portion of the overall chems so by the end you'll always have consumed all of the chems inside.
	var/smoke_all = FALSE
	/// How much damage this deals to the lungs per drag.
	var/lung_harm = 1
	/// If, when glorf'd, we will choke on this cig forever
	var/choke_forever = FALSE
	/// When choking, what is the maximum amount of time we COULD choke for
	var/choke_time_max = 30 SECONDS // I am mean
	/// The particle effect of the smoke rising out of the cigarette when lit
	VAR_PRIVATE/obj/effect/abstract/particle_holder/cig_smoke
	/// The particle effect of the smoke rising out of the mob when...smoked
	VAR_PRIVATE/obj/effect/abstract/particle_holder/mob_smoke
	/// How long the current mob has been smoking this cigarette
	VAR_FINAL/how_long_have_we_been_smokin = 0 SECONDS
	/// Which people ate cigarettes and how many
	var/static/list/cigarette_eaters = list()

/obj/item/cigarette/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/knockoff, 90, list(BODY_ZONE_PRECISE_MOUTH), slot_flags) //90% to knock off when wearing a mask
	AddElement(/datum/element/update_icon_updates_onmob)
	RegisterSignal(src, COMSIG_ATOM_TOUCHED_SPARKS, PROC_REF(sparks_touched))
	icon_state = icon_off
	inhand_icon_state = inhand_icon_off

	// "It is called a cigarette"
	AddComponentFrom(
		SOURCE_EDIBLE_INNATE,\
		/datum/component/edible,\
		initial_reagents = list_reagents,\
		food_flags = FOOD_NO_EXAMINE,\
		foodtypes = JUNKFOOD,\
		volume = chem_volume,\
		eat_time = 0 SECONDS,\
		tastes = list("前所未有的滋味", "站了一辈子终于坐下的感觉"),\
		eatverbs = list("品尝"),\
		bite_consumption = chem_volume,\
		junkiness = 0,\
		reagent_purity = null,\
		on_consume = CALLBACK(src, PROC_REF(on_consume)),\
	)
	if(starts_lit)
		light()

/obj/item/cigarette/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(mob_smoke)
	QDEL_NULL(cig_smoke)
	return ..()

/obj/item/cigarette/proc/on_consume(mob/living/eater, mob/living/feeder)
	if(isnull(eater.client))
		return
	var/ckey = eater.client.ckey
	// We must have more!
	cigarette_eaters[ckey]++
	if(cigarette_eaters[ckey] >= 500)
		eater.client.give_award(/datum/award/achievement/misc/cigarettes)

/obj/item/cigarette/equipped(mob/equipee, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_MASK))
		UnregisterSignal(equipee, list(COMSIG_HUMAN_FORCESAY, COMSIG_ATOM_DIR_CHANGE))
		return
	RegisterSignal(equipee, COMSIG_HUMAN_FORCESAY, PROC_REF(on_forcesay))
	RegisterSignal(equipee, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_mob_dir_change))
	if(lit && iscarbon(loc))
		make_mob_smoke(loc)

/obj/item/cigarette/dropped(mob/dropee)
	. = ..()
	// Moving the cigarette from mask to hands (or pocket I guess) will emit a larger puff of smoke
	if(!QDELETED(src) && !QDELETED(dropee) && how_long_have_we_been_smokin >= 4 SECONDS && dropee == loc && iscarbon(dropee))
		// This relies on the fact that dropped is called before slot is nulled
		if(dropee.get_item_by_slot(ITEM_SLOT_MASK) == src && !dropee.incapacitated)
			long_exhale(dropee)

	UnregisterSignal(dropee, list(COMSIG_HUMAN_FORCESAY, COMSIG_ATOM_DIR_CHANGE))
	QDEL_NULL(mob_smoke)
	how_long_have_we_been_smokin = 0 SECONDS

/obj/item/cigarette/proc/on_forcesay(mob/living/source, major)
	SIGNAL_HANDLER

	if(!major)
		return
	source.apply_status_effect(/datum/status_effect/choke, src, lit, choke_forever ? -1 : rand(25 SECONDS, choke_time_max))

/obj/item/cigarette/proc/on_mob_dir_change(mob/living/source, old_dir, new_dir)
	SIGNAL_HANDLER
	if(isnull(mob_smoke))
		return
	update_particle_position(mob_smoke, new_dir)

/obj/item/cigarette/proc/update_particle_position(obj/effect/abstract/particle_holder/to_edit, new_dir = loc.dir)
	var/new_x = 0
	var/new_layer = initial(to_edit.layer)
	if(new_dir & NORTH)
		new_x = 4
		new_layer = BELOW_MOB_LAYER
	else if(new_dir & SOUTH)
		new_x = -4
	else if(new_dir & EAST)
		new_x = 8
	else if(new_dir & WEST)
		new_x = -8
	to_edit.set_particle_position(new_x, 8, 0)
	to_edit.layer = new_layer

/obj/item/cigarette/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正拼命猛吸[src]！看起来是想让自己得癌症。"))
	return (TOXLOSS|OXYLOSS)

/obj/item/cigarette/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	return attempt_light(user, tool)

/obj/item/cigarette/proc/attempt_light(mob/living/user, obj/item/tool, text_override = null)
	if(lit)
		return NONE

	if(isnull(text_override))
		text_override = tool.ignition_effect(src, user)
		if(!text_override)
			return NONE
	// Maybe jank, but the reason it's like this is that you can ignore ignition_effect() and also provide no text by giving an empty string to text_override, while still lighting.

	if(!check_oxygen(user)) //cigarettes need oxygen
		balloon_alert(user, "没有空气！")
		return ITEM_INTERACT_BLOCKING

	if(!smoketime)
		to_chat(user, span_warning("没有可抽的东西！"))
		return ITEM_INTERACT_BLOCKING

	light(text_override)
	return ITEM_INTERACT_SUCCESS

/// Checks that we have enough air to smoke
/obj/item/cigarette/proc/check_oxygen(mob/user)
	if (reagents.has_reagent(/datum/reagent/oxygen))
		return TRUE
	var/datum/gas_mixture/air = return_air()
	if (!isnull(air) && air.has_gas(/datum/gas/oxygen, 1))
		return TRUE
	if (!ishuman(user))
		return FALSE
	var/mob/living/carbon/human/the_smoker = user
	return the_smoker.can_breathe_helmet()

/obj/item/cigarette/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(lit) //can't dip if cigarette is lit (it will heat the reagents in the glass instead)
		return NONE
	var/obj/item/reagent_containers/cup/glass = interacting_with
	if(!istype(glass)) //you can dip cigarettes into beakers
		return NONE
	if(istype(glass, /obj/item/reagent_containers/cup/mortar))
		return NONE
	if(glass.reagents.trans_to(src, chem_volume, transferred_by = user)) //if reagents were transferred, show the message
		to_chat(user, span_notice("你把[src]浸入[glass]。"))
	//if not, either the beaker was empty, or the cigarette was full
	else if(!glass.reagents.total_volume)
		to_chat(user, span_warning("[glass]是空的！"))
	else
		to_chat(user, span_warning("[src]已经装满了！"))
	return ITEM_INTERACT_SUCCESS

/obj/item/cigarette/update_icon_state()
	. = ..()
	if(lit)
		icon_state = icon_on
		inhand_icon_state = inhand_icon_on
	else
		icon_state = icon_off
		inhand_icon_state = inhand_icon_off


/obj/item/cigarette/proc/sparks_touched(datum/source, obj/effect/particle_effect)
	SIGNAL_HANDLER

	if(lit)
		return
	light()

/// Lights the cigarette with given flavor text.
/obj/item/cigarette/proc/light(flavor_text = null)
	if(lit)
		return

	lit = TRUE
	playsound(src.loc, 'sound/items/lighter/cig_light.ogg', 100, 1)
	make_cig_smoke()
	set_light_on(TRUE)
	if(!(flags_1 & INITIALIZED_1))
		update_appearance(UPDATE_ICON)
		return

	attack_verb_continuous = string_list(list("烧灼", "燎烧"))
	attack_verb_simple = string_list(list("烧灼", "燎烧"))
	hitsound = 'sound/items/tools/welder.ogg'
	damtype = BURN
	force = 4

	if(reagents?.spark_act(0, NONE, banned_reagents = /datum/reagent/flash_powder) & SPARK_ACT_DESTRUCTIVE)
		usr?.log_message("lit a rigged cigarette", LOG_VICTIM)
		qdel(src)
		return

	// Custom handling for the hallucination effect
	if(reagents?.has_reagent(/datum/reagent/flash_powder))
		if(!isliving(loc))
			loc.visible_message(span_hear("[src]烧尽了！"))
			qdel(src)
			return
		var/mob/living/user = loc
		loc.visible_message(span_hear("[user]的[name]烧尽了，[p_they(user)]随即倒在地上！"), span_danger("溶液猛烈爆炸了！"))
		user.flash_act(INFINITY, visual = TRUE, length = 5 SECONDS)
		user.playsound_local(get_turf(user), SFX_EXPLOSION, 50, TRUE)
		user.cause_hallucination(/datum/hallucination/death, "trick trick [name]")
		qdel(src)
		return

	if(reagents?.has_reagent(/datum/reagent/drug/methamphetamine))
		reagents.flags |= NO_REACT

	// allowing reagents to react after being lit
	reagents.handle_reactions()
	if(QDELETED(src))
		return
	START_PROCESSING(SSobj, src)

	update_appearance(UPDATE_ICON)
	if(flavor_text)
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)

	if(iscarbon(loc))
		var/mob/living/carbon/smoker = loc
		if(smoker.get_item_by_slot(ITEM_SLOT_MASK) == src)
			make_mob_smoke(smoker)

/obj/item/cigarette/extinguish()
	. = ..()
	if(!lit)
		return
	attack_verb_continuous = null
	attack_verb_simple = null
	hitsound = null
	damtype = BRUTE
	force = 0
	STOP_PROCESSING(SSobj, src)
	reagents.flags |= NO_REACT
	lit = FALSE
	playsound(src.loc, 'sound/items/lighter/cig_snuff.ogg', 100, 1)
	update_appearance(UPDATE_ICON)
	set_light_on(FALSE)
	if(ismob(loc))
		to_chat(loc, span_notice("你的[name]熄灭了。"))
	QDEL_NULL(cig_smoke)
	QDEL_NULL(mob_smoke)

/obj/item/cigarette/proc/long_exhale(mob/living/carbon/smoker)
	// Find a mob to blow smoke at
	var/mob/living/guy_infront
	for(var/mob/living/guy in get_step(smoker, smoker.dir))
		// one of you has to get on the other's level
		if(guy.body_position != smoker.body_position)
			continue
		// ensures we're face to face
		if(!(REVERSE_DIR(guy.dir) & smoker.dir))
			continue
		guy_infront = guy
		// in case we get a living first, we wanna prioritize humans
		if(ishuman(guy_infront))
			break

	if(isnull(guy_infront))
		smoker.visible_message(
			span_notice("[smoker]吐出一大团[src]的烟雾。"),
			span_notice("你吐出一大团[src]的烟雾。"),
		)

	else if(ishuman(guy_infront) && guy_infront.get_bodypart(BODY_ZONE_HEAD) && !guy_infront.is_pepper_proof())
		smoker.visible_message(
			span_notice("[smoker]把一大团[src]的烟雾直接吐到[guy_infront]脸上！"),
			span_notice("你把一大团[src]的烟雾直接吐到[guy_infront]脸上。"),
			ignored_mobs = guy_infront,
		)
		to_chat(guy_infront, span_warning("[smoker]的[name]烟雾喷了你一脸！"))
		smoke_in_face(guy_infront)

	else
		smoker.visible_message(
			span_notice("[smoker]朝[guy_infront]吐出一大团[src]的烟雾。"),
			span_notice("你朝[guy_infront]吐出一大团[src]的烟雾。"),
		)

	if(!isturf(smoker.loc))
		return

	var/obj/effect/abstract/particle_holder/big_smoke = new(smoker.loc, /particles/smoke/cig/big)
	update_particle_position(big_smoke, smoker.dir)
	QDEL_IN(big_smoke, big_smoke.particles.lifespan)

/// Called when a mob gets smoke blown in their face.
/obj/item/cigarette/proc/smoke_in_face(mob/living/getting_smoked)
	getting_smoked.add_mood_event("smoke_bm", /datum/mood_event/smoke_in_face)
	if(prob(20) && !HAS_TRAIT(getting_smoked, TRAIT_SMOKER) && !HAS_TRAIT(getting_smoked, TRAIT_ANOSMIA))
		getting_smoked.emote("cough")

/// Handles processing the reagents in the cigarette.
/obj/item/cigarette/proc/handle_reagents(seconds_per_tick)
	if(!reagents.total_volume)
		return
	reagents.expose_temperature(heat, 0.05)
	if(!reagents.total_volume) //may have reacted and gone to 0 after expose_temperature
		return

	var/to_smoke = smoke_all ? (reagents.total_volume * (dragtime / smoketime)) : REAGENTS_METABOLISM
	var/mob/living/carbon/smoker = loc
	// These checks are a bit messy but at least they're fairly readable
	// Check if the smoker is a carbon mob, since it needs to have wear_mask
	if(!istype(smoker))
		// If not, check if it's a gas mask
		if(!istype(smoker, /obj/item/clothing/mask/gas))
			reagents.remove_all(to_smoke)
			return

		smoker = smoker.loc

		// If it is, check if that mask is on a carbon mob
		if(!istype(smoker) || smoker.get_item_by_slot(ITEM_SLOT_MASK) != loc)
			reagents.remove_all(to_smoke)
			return
	else
		if(smoker.get_item_by_slot(ITEM_SLOT_MASK) != src)
			reagents.remove_all(to_smoke)
			return

	how_long_have_we_been_smokin += seconds_per_tick * (1 SECONDS)
	reagents.expose(smoker, INHALE, min(to_smoke / reagents.total_volume, 1))
	var/obj/item/organ/lungs/lungs = smoker.get_organ_slot(ORGAN_SLOT_LUNGS)
	if(lungs && IS_ORGANIC_ORGAN(lungs))
		var/smoker_resistance = HAS_TRAIT(smoker, TRAIT_SMOKER) ? 0.5 : 1
		smoker.adjust_organ_loss(ORGAN_SLOT_LUNGS, lung_harm * smoker_resistance)
	if(!reagents.trans_to(smoker, to_smoke, methods = INHALE, ignore_stomach = TRUE))
		reagents.remove_all(to_smoke)

/obj/item/cigarette/process(seconds_per_tick)
	var/mob/living/user = isliving(loc) ? loc : null
	user?.ignite_mob()

	if(!check_oxygen(user))
		extinguish()
		return

	smoketime -= seconds_per_tick * (1 SECONDS)
	if(smoketime <= 0)
		put_out(user)
		return

	open_flame(heat)
	if((reagents?.total_volume) && COOLDOWN_FINISHED(src, drag_cooldown))
		COOLDOWN_START(src, drag_cooldown, dragtime)
		handle_reagents(seconds_per_tick)

/obj/item/cigarette/attack_self(mob/user)
	if(lit)
		put_out(user, TRUE)
	return ..()

/obj/item/cigarette/proc/put_out(mob/user, done_early = FALSE)
	var/atom/location = drop_location()
	if(!isnull(user))
		if(done_early)
			if(isfloorturf(location) && location.has_gravity())
				user.visible_message(span_notice("[user]从容地丢下[src]，一脚将它踩灭。"))
				new /obj/effect/decal/cleanable/ash(location)
				long_exhale(user)
			else
				user.visible_message(span_notice("[user]掐灭了[src]。"))
			how_long_have_we_been_smokin = 0 SECONDS
		else
			to_chat(user, span_notice("你的[name]熄灭了。"))
	new type_butt(location)
	qdel(src)

/obj/item/cigarette/attack(mob/living/target_mob, mob/living/carbon/user)
	if(!istype(target_mob, /mob/living/carbon))
		return ..()

	var/mob/living/carbon/fire_guy = target_mob
	if(fire_guy.on_fire && !lit)
		light(span_notice("[user]用[fire_guy]燃烧的身体点燃了[src]。真是个冷血狠人。"))
		return
	var/obj/item/cigarette/cig = help_light_cig(fire_guy)
	if(!lit || !cig || user.combat_mode)
		return ..()

	if(cig.lit)
		to_chat(user, span_warning("[cig]已经点燃了！"))
		return

	cig.attempt_light(user, src, fire_guy == user ? null : span_notice("[user]向[fire_guy]递出[src]，点燃了[fire_guy.p_their()][cig.name]。"))

/obj/item/cigarette/fire_act(exposed_temperature, exposed_volume)
	light()

/obj/item/cigarette/get_temperature()
	return lit * heat

/obj/item/cigarette/proc/make_mob_smoke(mob/living/smoker)
	mob_smoke = new(smoker, /particles/smoke/cig)
	update_particle_position(mob_smoke, smoker.dir)
	return mob_smoke

/obj/item/cigarette/proc/make_cig_smoke()
	cig_smoke = new(src, /particles/smoke/cig)
	cig_smoke.particles?.scale *= 1.5
	return cig_smoke

// Cigarette brands.
/obj/item/cigarette/space_cigarette
	desc = "一支随时随地都能抽的太空牌香烟。"
	list_reagents = list(/datum/reagent/drug/nicotine = 9, /datum/reagent/oxygen = 9)
	smoketime = 4 MINUTES // space cigs have a shorter burn time than normal cigs
	smoke_all = TRUE // so that it doesn't runout of oxygen while being smoked in space

/obj/item/cigarette/dromedary
	desc = "一支单峰驼公司牌香烟。与普遍看法不同，它不含甘汞，不过据说味道寡淡。"
	list_reagents = list(/datum/reagent/drug/nicotine = 13, /datum/reagent/water = 5) //camel has water

/obj/item/cigarette/uplift
	desc = "一支提神柔顺牌香烟，闻起来清新怡人。"
	list_reagents = list(/datum/reagent/drug/nicotine = 13, /datum/reagent/consumable/menthol = 5)

/obj/item/cigarette/robust
	desc = "一支强劲牌香烟。"

/obj/item/cigarette/greytide
	name = "灰色维保薄荷烟"
	desc = "手工制作，气味古怪。"
	chem_volume = 60
	lung_harm = 2.5
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/consumable/menthol = 6, /datum/reagent/medicine/oculine = 1)

/obj/item/cigarette/greytide/Initialize(mapload)
	. = ..()
	/// Weighted list of random reagents to add
	var/list/possible_reagents = list(
		/datum/reagent/toxin/fentanyl = 2,
		/datum/reagent/glitter/random = 2,
		/datum/reagent/drug/aranesp = 2,
		/datum/reagent/consumable/laughter = 2,
		/datum/reagent/medicine/insulin = 2,
		/datum/reagent/drug/maint/powder = 2,
		/datum/reagent/drug/maint/sludge = 2,
		/datum/reagent/toxin/staminatoxin = 2,
		/datum/reagent/toxin/leadacetate = 2,
		/datum/reagent/drug/space_drugs = 2,
		/datum/reagent/drug/pumpup = 2,
		/datum/reagent/drug/kronkaine = 2,
		/datum/reagent/consumable/mintextract = 2,
		/datum/reagent/pax = 1,
	)
	if(prob(40))
		reagents.add_reagent(pick_weight(possible_reagents), rand(10, 15))

/obj/item/cigarette/robustgold
	desc = "一支强劲金牌香烟。"
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/gold = 3) // Just enough to taste a hint of expensive metal.

/obj/item/cigarette/carp
	desc = "一支经典鲤鱼牌香烟。侧面的小标签注明它不含鲤鱼毒素。"

/obj/item/cigarette/carp/Initialize(mapload)
	. = ..()
	if(!prob(5))
		return
	reagents?.add_reagent(/datum/reagent/toxin/carpotoxin , 3) // They lied

/obj/item/cigarette/syndicate
	desc = "一支牌子不明的香烟。"
	chem_volume = 60
	smoketime = 2 MINUTES
	smoke_all = TRUE
	lung_harm = 1.5
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/medicine/omnizine = 15)

/obj/item/cigarette/syndicate/smoke_in_face(mob/living/getting_smoked)
	. = ..()
	getting_smoked.adjust_eye_blur(6 SECONDS)
	getting_smoked.adjust_temp_blindness(2 SECONDS)

/obj/item/cigarette/shadyjims
	desc = "一支可疑吉姆超细香烟。"
	lung_harm = 1.5
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/toxin/lipolicide = 4, /datum/reagent/ammonia = 2, /datum/reagent/toxin/plantbgone = 1, /datum/reagent/toxin = 1.5)

/obj/item/cigarette/xeno
	desc = "一支异形过滤牌香烟。"
	lung_harm = 2
	list_reagents = list (/datum/reagent/drug/nicotine = 20, /datum/reagent/medicine/regen_jelly = 15, /datum/reagent/drug/krokodil = 4)

/obj/item/cigarette/flash_powder
	desc = /obj/item/cigarette/space_cigarette::desc
	list_reagents = list (/datum/reagent/drug/nicotine = 9, /datum/reagent/flash_powder = 5)

// Rollies.

/obj/item/cigarette/rollie
	name = "手卷烟"
	desc = "一卷用薄纸包裹的干燥植物材料。"
	icon_state = "spliffoff"
	icon_on = "spliffon"
	icon_off = "spliffoff"
	type_butt = /obj/item/cigbutt/roach
	throw_speed = 0.5
	smoketime = 4 MINUTES
	chem_volume = 50
	list_reagents = null
	choke_time_max = 40 SECONDS

/obj/item/cigarette/rollie/Initialize(mapload)
	name = pick(list(
		"大麻卷",
		"大麻烟卷",
		"小鸟烟",
		"粗卷烟",
		"混合卷烟",
		"呛口烟",
		"大呛口烟",
		"轰炸烟",
		"骨头烟",
		"面包卷烟",
		"大粗烟",
		"嘟嘟烟",
		"大嘟嘟烟",
		"小嘟嘟烟",
		"荷兰卷",
		"肥烟卷",
		"大块头烟",
		"猫头鹰烟",
		"小猫头鹰烟",
		"\improper J 字烟",
		"松鸦烟",
		"吉米烟",
		"大麻手卷",
		"巫术烟",
		"神经兮兮烟",
		"一根烟",
		"夜枭烟",
		"胖烟卷",
		"喷云烟",
		"草烟",
		"草叶卷",
		"手卷烟",
		"史酷比烟",
		"短烟卷",
		"混合烟",
		"混合大麻烟",
		"一口烟",
		"鱼雷烟",
		"飘飘烟",
		"大飘飘烟"))
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/cigarette/rollie/nicotine
	list_reagents = list(/datum/reagent/drug/nicotine = 15)

/obj/item/cigarette/rollie/trippy
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/drug/mushroomhallucinogen = 35)
	starts_lit = TRUE

/obj/item/cigarette/rollie/cannabis
	list_reagents = list(/datum/reagent/drug/cannabis = 15)

/obj/item/cigarette/rollie/mindbreaker
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 35, /datum/reagent/toxin/lipolicide = 15)

/obj/item/cigarette/candy
	name = "\improper 小蒂米糖果香烟"
	desc = "老少皆宜*！不含任何尼古丁。健康与安全风险说明见烟头。"
	smoketime = 2 MINUTES
	icon_state = "candyoff"
	icon_on = "candyon"
	icon_off = "candyoff" //make sure to add positional sprites in icons/obj/cigarettes.dmi if you add more.
	inhand_icon_off = "candyoff"
	type_butt = /obj/item/food/candy_trash
	heat = 473.15 // Lowered so that the sugar can be carmalized, but not burnt.
	lung_harm = 0.5
	list_reagents = list(/datum/reagent/consumable/sugar = 20)
	choke_time_max = 70 SECONDS // This shit really is deadly

/obj/item/cigarette/candy/nicotine
	desc = "老少皆宜*！不含任何*尼古丁。健康与安全风险说明见烟头。"
	type_butt = /obj/item/food/candy_trash/nicotine
	list_reagents = list(/datum/reagent/consumable/sugar = 20, /datum/reagent/drug/nicotine = 20) //oh no!
	smoke_all = TRUE //timmy's not getting out of this one

/obj/item/cigbutt/roach
	name = "大麻烟蒂"
	desc = "一截脏兮兮的老烟蒂，给不抽大麻的人解释一下，就是抽剩的手卷烟。"
	icon_state = "roach"

/obj/item/cigbutt/greycigbutt
	name = "烟蒂"
	desc = "现在只剩一地狼藉。"
	icon_state = "cigbutt"

/obj/item/cigbutt/roach/Initialize(mapload)
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)


/obj/item/cigarette/dart
	name = "巨型香烟"
	desc = "猛嘬一口这根巨型香烟。"
	icon_state = "bigon"
	icon_on = "bigon"
	icon_off = "bigoff"
	w_class = WEIGHT_CLASS_BULKY
	smoketime = 18 MINUTES
	chem_volume = 65
	list_reagents = list(/datum/reagent/drug/nicotine = 45)
	choke_time_max = 40 SECONDS
	lung_harm = 2

/obj/item/cigarette/dart/Initialize(mapload)
	. = ..()
	//the compiled icon state is how it appears when it's on.
	//That's how we want it to show on orbies (little virtual PDA pets).
	//However we should reset their appearance on runtime.
	update_appearance(UPDATE_ICON_STATE)


////////////
// CIGARS //
////////////
/obj/item/cigarette/cigar
	name = "雪茄"
	desc = "一卷棕色烟草和……好吧，你也不太确定。这玩意儿真大！"
	icon_state = "cigaroff"
	icon_on = "cigaron"
	icon_off = "cigaroff" //make sure to add positional sprites in icons/obj/cigarettes.dmi if you add more.
	inhand_icon_state = "cigaron" //gets overriden during intialize(), just have it for unit test sanity.
	inhand_icon_on = "cigaron"
	inhand_icon_off = "cigaroff"
	type_butt = /obj/item/cigbutt/cigarbutt
	throw_speed = 0.5
	smoketime = 11 MINUTES
	chem_volume = 40
	list_reagents = list(/datum/reagent/drug/nicotine = 25)
	choke_time_max = 40 SECONDS

/obj/item/cigarette/cigar/premium
	name = "高级雪茄"
	//this is the version that actually spawns in premium cigar cases, the distinction is made so that the smoker quirk can differentiate between the default cigar box and its subtypes

/obj/item/cigarette/cigar/cohiba
	name = "\improper 高希霸罗布图雪茄"
	desc = "对于一支雪茄，你几乎已别无所求。"
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 20 MINUTES
	chem_volume = 80
	list_reagents = list(/datum/reagent/drug/nicotine = 40)
	type_butt = /obj/item/cigbutt/cigarbutt/cohiba

/obj/item/cigarette/cigar/havana
	name = "高级哈瓦那雪茄"
	desc = "只有精英中的精英才配享用的雪茄。"
	icon_state = "cigar3off"
	icon_on = "cigar3on"
	icon_off = "cigar3off"
	smoketime = 30 MINUTES
	chem_volume = 60
	list_reagents = list(/datum/reagent/drug/nicotine = 45)
	type_butt = /obj/item/cigbutt/cigarbutt/havana

/obj/item/cigbutt
	name = "香烟烟蒂"
	desc = "一截脏兮兮的旧香烟烟蒂。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigbutt"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0

/obj/item/cigbutt/grind_results()
	return list(/datum/reagent/carbon = 2)

/obj/item/cigbutt/cigarbutt
	name = "雪茄烟蒂"
	desc = "一截脏兮兮的旧雪茄烟蒂。"
	icon_state = "cigarbutt"

/obj/item/cigbutt/cigarbutt/cohiba
	icon_state = "cigar2butt"

/obj/item/cigbutt/cigarbutt/havana
	icon_state = "cigar3butt"

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/cigarette/pipe
	name = "烟斗"
	desc = "用来抽烟的斗，大概是海泡石之类的材质制成的。"
	icon_state = "pipeoff"
	icon_on = "pipeoff"  //Note - these are in masks.dmi
	icon_off = "pipeoff"
	inhand_icon_state = null
	inhand_icon_on = null
	inhand_icon_off = null
	smoketime = 0
	chem_volume = 200 // So we can fit densified chemicals plants
	list_reagents = null
	w_class = WEIGHT_CLASS_SMALL
	choke_forever = TRUE
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 2)
	///name of the stuff packed inside this pipe
	var/packeditem

/obj/item/cigarette/pipe/Initialize(mapload)
	. = ..()
	update_appearance(UPDATE_NAME)

/obj/item/cigarette/pipe/update_name()
	. = ..()
	name = packeditem ? "装有[packeditem]的[initial(name)]" : "空[initial(name)]"

/obj/item/cigarette/pipe/put_out(mob/user, done_early = FALSE)
	lit = FALSE
	if(done_early)
		user.visible_message(span_notice("[user]熄灭了[src]。"), span_notice("你熄灭了[src]。"))

	else
		if(user)
			to_chat(user, span_notice("你的[name]熄灭了。"))
		packeditem = null
	update_appearance(UPDATE_ICON)
	set_light_on(FALSE)
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(cig_smoke)

/obj/item/cigarette/pipe/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!(istype(tool, /obj/item/food/grown) || istype(tool, /obj/item/food/drug)))
		return ..()

	if(packeditem)
		to_chat(user, span_warning("里面已经填满了！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/to_smoke = tool
	if(istype(to_smoke, /obj/item/food/grown) && !HAS_TRAIT(to_smoke, TRAIT_DRIED))
		to_chat(user, span_warning("必须先将它晒干！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把[to_smoke]塞进[src]。"))
	smoketime = 13 MINUTES
	packeditem = to_smoke.name
	update_name()
	if(to_smoke.reagents)
		to_smoke.reagents.trans_to(src, to_smoke.reagents.total_volume, transferred_by = user)
	qdel(to_smoke)
	return ITEM_INTERACT_SUCCESS


/obj/item/cigarette/pipe/attack_self(mob/user)
	var/atom/location = drop_location()
	if(packeditem && !lit)
		to_chat(user, span_notice("你将[src]里的东西倒在[location]上。"))
		new /obj/effect/decal/cleanable/ash(location)
		packeditem = null
		smoketime = 0
		reagents.clear_reagents()
		update_name()
		return
	return ..()

/obj/item/cigarette/pipe/cobpipe
	name = "玉米芯烟斗"
	desc = "一种由朴实的乡野居民带火的尼古丁输送装置，太空潮人让它在现代乃至未来继续流行。可以往里面填东西。"
	icon_state = "cobpipeoff"
	icon_on = "cobpipeoff"  //Note - these are in masks.dmi
	icon_off = "cobpipeoff"
	inhand_icon_on = null
	inhand_icon_off = null

/obj/item/cigarette/pipe/crackpipe
	name = "玻璃烟斗"
	desc = "一种符合人体工学又低调的燃烧物吸入工具。这件器具曾让古人领悟不少智慧。"
	icon_state = "crackpipe"
	icon_on = "crackpipeon"
	icon_off = "crackpipe"
	inhand_icon_on = null
	inhand_icon_off = null
	lung_harm = 2
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3)

///////////
//ROLLING//
///////////
/obj/item/rollingpaper
	name = "卷烟纸"
	desc = "用于制作上好烟草制品的薄纸。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig_paper"
	w_class = WEIGHT_CLASS_TINY

/obj/item/rollingpaper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/cigarette/rollie, CUSTOM_INGREDIENT_ICON_NOCHANGE, ingredient_type=CUSTOM_INGREDIENT_TYPE_DRYABLE, max_ingredients=2)


///////////////
//VAPE NATION//
///////////////
/obj/item/vape
	name = "\improper 电子烟"
	desc = "一款高雅精致的电子烟，专为有品位、有风度的绅士打造。警示标签写着：“警告：请勿填充易燃物质。”"//<<< i'd vape to that.
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/vape"
	post_init_icon_state = "vape"
	worn_icon_state = "vape_worn"
	worn_icon_muzzled = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi' //SKYRAT EDIT: ADDITION
	greyscale_config = /datum/greyscale_config/vape
	greyscale_config_worn = /datum/greyscale_config/vape/worn
	greyscale_config_worn_muzzled = /datum/greyscale_config/vape/worn/muzzled //SKYRAT EDIT ADDITION
	greyscale_colors = "#2e2e2e"
	inhand_icon_state = null
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MASK
	flags_1 = IS_PLAYER_COLORABLE_1
	light_range = 1
	light_color = LIGHT_COLOR_HALOGEN
	light_system = OVERLAY_LIGHT
	light_on = FALSE

	/// The capacity of the vape.
	var/chem_volume = 100
	/// The amount of time between drags.
	var/dragtime = 8 SECONDS
	/// A cooldown to prevent huffing the vape all at once.
	COOLDOWN_DECLARE(drag_cooldown)
	/// Whether the resevoir is open and we can add reagents.
	var/screw = FALSE
	/// Whether the vape has been overloaded to spread smoke.
	var/super = FALSE

/obj/item/vape/Initialize(mapload)
	. = ..()
	create_reagents(chem_volume, NO_REACT)
	reagents.add_reagent(/datum/reagent/drug/nicotine, 50)

/obj/item/vape/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正疯狂猛嘬电子烟，想在另一个世界继续吞云吐雾！"))//it doesn't give you cancer, it is cancer
	return (TOXLOSS|OXYLOSS)

/obj/item/vape/screwdriver_act(mob/living/user, obj/item/tool)
	if(!screw)
		screw = TRUE
		to_chat(user, span_notice("你打开了[src]的盖子。"))
		reagents.flags |= OPENCONTAINER
		if(obj_flags & EMAGGED)
			icon_state = "vapeopen_high"
			set_greyscale(new_config = /datum/greyscale_config/vape/open_high)
		else if(super)
			icon_state = "vapeopen_med"
			set_greyscale(new_config = /datum/greyscale_config/vape/open_med)
		else
			icon_state = "vapeopen_low"
			set_greyscale(new_config = /datum/greyscale_config/vape/open_low)
	else
		screw = FALSE
		to_chat(user, span_notice("你合上了[src]的盖子。"))
		reagents.flags &= ~(OPENCONTAINER)
		icon_state = initial(post_init_icon_state) || initial(icon_state)
		set_greyscale(new_config = initial(greyscale_config))

/obj/item/vape/multitool_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(screw && !(obj_flags & EMAGGED))//also kinky
		if(!super)
			super = TRUE
			to_chat(user, span_notice("你提高了[src]的电压。"))
			icon_state = "vapeopen_med"
			set_greyscale(new_config = /datum/greyscale_config/vape/open_med)
		else
			super = FALSE
			to_chat(user, span_notice("你降低了[src]的电压。"))
			icon_state = "vapeopen_low"
			set_greyscale(new_config = /datum/greyscale_config/vape/open_low)

	if(screw && (obj_flags & EMAGGED))
		to_chat(user, span_warning("无法改装[src]！"))

/obj/item/vape/emag_act(mob/user, obj/item/card/emag/emag_card) // I WON'T REGRET WRITTING THIS, SURLY.

	if (!screw)
		balloon_alert(user, "先打开盖子！")
		return FALSE

	if (obj_flags & EMAGGED)
		balloon_alert(user, "已经被电磁卡破解！")
		return FALSE

	obj_flags |= EMAGGED
	super = FALSE
	balloon_alert(user, "电压已调至最大")
	icon_state = "vapeopen_high"
	set_greyscale(new_config = /datum/greyscale_config/vape/open_high)
	do_sparks(5, TRUE, src)
	return TRUE

/obj/item/vape/attack_self(mob/user)
	if(!screw)
		balloon_alert(user, "先打开盖子！")
		return
	if(reagents.total_volume > 0)
		to_chat(user, span_notice("你倒空了[src]中的所有试剂。"))
		reagents.clear_reagents()

/obj/item/vape/equipped(mob/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_MASK))
		return

	if(screw)
		to_chat(user, span_warning("你需要先合上盖子！"))
		return

	to_chat(user, span_notice("你开始抽电子烟。"))
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	if(QDELETED(src))
		return
	set_light_on(TRUE)
	START_PROCESSING(SSobj, src)

/obj/item/vape/dropped(mob/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_MASK) == src)
		reagents.flags |= NO_REACT
		STOP_PROCESSING(SSobj, src)
		set_light_on(FALSE)

/obj/item/vape/proc/handle_reagents()
	if(!reagents.total_volume)
		return

	var/mob/living/carbon/vaper = loc
	if(!iscarbon(vaper) || vaper.get_item_by_slot(ITEM_SLOT_MASK) != src)
		reagents.remove_all(REAGENTS_METABOLISM)
		return

	if(reagents.get_reagent_amount(/datum/reagent/fuel))
		//HOT STUFF
		vaper.adjust_fire_stacks(2)
		vaper.ignite_mob()

	// Preserve old welding fuel behavior
	if(reagents.spark_act(0, TRUE, banned_reagents = /datum/reagent/fuel) & SPARK_ACT_DESTRUCTIVE)
		qdel(src)
		return

	if(!reagents.trans_to(vaper, REAGENTS_METABOLISM, methods = INHALE, ignore_stomach = TRUE))
		reagents.remove_all(REAGENTS_METABOLISM)

/obj/item/vape/process(seconds_per_tick)
	var/mob/living/M = loc

	if(isliving(loc))
		M.ignite_mob()

	if(!reagents.total_volume)
		if(ismob(loc))
			to_chat(M, span_warning("[src]是空的！"))
			STOP_PROCESSING(SSobj, src)
			//it's reusable so it won't unequip when empty
		return

	if(!COOLDOWN_FINISHED(src, drag_cooldown))
		return

	//Time to start puffing those fat vapes, yo.
	COOLDOWN_START(src, drag_cooldown, dragtime)

	if(obj_flags & EMAGGED)
		var/smoke_amount = DIAMOND_AREA(4)
		do_chem_smoke(amount = smoke_amount, holder = src, location = loc, carry = reagents, carry_limit = 20, smoke_type = /datum/effect_system/fluid_spread/smoke/chem/smoke_machine)
		reagents.remove_all(smoke_amount / 24)
		if(prob(5)) //small chance for the vape to break and deal damage if it's emagged
			playsound(get_turf(src), 'sound/effects/pop_expl.ogg', 50, FALSE)
			M.apply_damage(20, BURN, BODY_ZONE_HEAD)
			M.Paralyze(300)
			do_sparks(5, TRUE, src)
			to_chat(M, span_userdanger("[src]突然在你嘴里炸开了！"))
			qdel(src)
			return
	else if(super)
		var/smoke_amount = DIAMOND_AREA(1)
		do_chem_smoke(amount = smoke_amount, holder = src, location = loc, carry = reagents, carry_limit = 20, smoke_type = /datum/effect_system/fluid_spread/smoke/chem/smoke_machine)
		reagents.remove_all(smoke_amount / 24)

	handle_reagents()

/obj/item/vape/red
	icon_state = "/obj/item/vape/red"
	greyscale_colors = "#A02525"
	flags_1 = NONE

/obj/item/vape/blue
	icon_state = "/obj/item/vape/blue"
	greyscale_colors = "#294A98"
	flags_1 = NONE

/obj/item/vape/purple
	icon_state = "/obj/item/vape/purple"
	greyscale_colors = "#9900CC"
	flags_1 = NONE

/obj/item/vape/green
	icon_state = "/obj/item/vape/green"
	greyscale_colors = "#3D9829"
	flags_1 = NONE

/obj/item/vape/yellow
	icon_state = "/obj/item/vape/yellow"
	greyscale_colors = "#DAC20E"
	flags_1 = NONE

/obj/item/vape/orange
	icon_state = "/obj/item/vape/orange"
	greyscale_colors = "#da930e"
	flags_1 = NONE

/obj/item/vape/black
	greyscale_colors = "#2e2e2e"
	flags_1 = NO_NEW_GAGS_PREVIEW_1 // same color as basetype

/obj/item/vape/white
	icon_state = "/obj/item/vape/white"
	greyscale_colors = "#DCDCDC"
	flags_1 = NONE
