/obj/structure/chair/shibari_stand
	name = "绳缚架"
	desc = "用绳索将人束缚在上面的架子。"
	icon = 'icons/map_icons/objects.dmi'
	icon_state = "/obj/structure/chair/shibari_stand"
	post_init_icon_state = "shibari_stand"
	max_integrity = 75
	layer = 4
	item_chair = null
	buildstacktype = null
	flags_1 = parent_type::flags_1 | NO_NEW_GAGS_PREVIEW_1
	///Overlays for ropes
	var/static/mutable_appearance/shibari_rope_overlay
	var/static/mutable_appearance/shibari_rope_overlay_behind
	var/static/mutable_appearance/shibari_shadow_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/shibari_stand.dmi', "shibari_shadow", LOW_OBJ_LAYER)

	greyscale_config = /datum/greyscale_config/shibari_stand
	greyscale_colors = "#bd8fcf"

	///obviously, this is for doing things to the currentmob
	var/mob/living/carbon/human/current_mob = null

	///The rope inside the stand, that's actually tying the person to it
	var/obj/item/stack/shibari_rope/ropee = null

/obj/structure/chair/shibari_stand/MakeRotate()
	return

/obj/structure/chair/shibari_stand/Destroy()
	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	if(ropee)
		ropee.forceMove(get_turf(src))
	. = ..()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
	unbuckle_all_mobs(TRUE)

//Examine changes for this structure
/obj/structure/chair/shibari_stand/examine(mob/user)
	. = ..()
	if(!has_buckled_mobs() && can_buckle)
		. += span_notice("对方需要穿戴<b>全身绳缚装</b>，而你需要<b>手持绳索</b>！")

// previously NO_DECONSTRUCT
/obj/structure/chair/shibari_stand/wrench_act_secondary(mob/living/user, obj/item/weapon)
	return NONE

/obj/structure/chair/shibari_stand/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	var/mob/living/buckled = buckled_mob
	if(buckled)
		if(buckled != user)
			buckled.visible_message(span_notice("[user]开始为[buckled]解开[src]上的绳索。"),\
				span_notice("[user]试着为你解开[src]上的绳索。"),\
				span_hear("你听见绳索松开的声音。"))
			if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 5 SECONDS : 10 SECONDS, buckled))
				return FALSE
			buckled.visible_message(span_notice("[user]将[buckled]从[src]上解了下来。"),\
				span_notice("[user]将你从[src]上解了下来。"),\
				span_hear("你听见绳索松开的声音。"))
		else
			user.visible_message(span_notice("[user]开始解开将自己绑在[src]上的绳索。"),\
				span_notice("你将自己从[src]上解了下来。"),\
				span_hear("你听见绳索松开的声音。"))
		add_fingerprint(user)
		if(isliving(buckled.pulledby))
			var/mob/living/living_mob = buckled.pulledby
			living_mob.set_pull_offsets(buckled, living_mob.grab_state)
	unbuckle_mob(buckled_mob)
	return buckled

/obj/structure/chair/shibari_stand/user_buckle_mob(mob/living/buckled, mob/user, check_loc = TRUE)

	if(!buckled.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("看来[buckled]不希望你这样做。"))
		return FALSE

	if(!is_user_buckle_possible(buckled, user, check_loc))
		return FALSE
	add_fingerprint(user)

	if(!ishuman(buckled))
		return FALSE

	var/mob/living/carbon/human/hooman = buckled
	if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari/full)))
		to_chat(user, span_warning("你需要先捆住对方全身！"))
		return FALSE
	if(!istype(user.get_active_held_item(), /obj/item/stack/shibari_rope))
		to_chat(user, span_warning("你需要手持绳缚绳索才能将对方绑在架子上！"))
		return FALSE

	if(buckled != user)
		buckled.visible_message(span_warning("[user]开始将[buckled]绑在[src]上！"),\
			span_userdanger("[user]开始将你绑在[src]上！"),\
			span_hear("你听见绳索拉紧的声音。"))
		if(!do_after(user, HAS_TRAIT(user, TRAIT_RIGGER) ? 5 SECONDS : 10 SECONDS, buckled))
			return FALSE

		if(!is_user_buckle_possible(buckled, user, check_loc))
			return FALSE

		if(!(istype(hooman.w_uniform, /obj/item/clothing/under/shibari/full)))
			to_chat(user, span_warning("你需要先捆住对方全身！"))
			return FALSE
		if(!istype(user.get_active_held_item(), /obj/item/stack/shibari_rope))
			to_chat(user, span_warning("你需要手持绳缚绳索才能将对方绑在架子上！"))
			return FALSE

		if(buckle_mob(buckled, check_loc = check_loc))
			var/obj/item/stack/shibari_rope/rope = user.get_active_held_item()
			ropee = new()
			ropee.set_greyscale(rope.greyscale_colors)
			rope.use(1)
			add_overlay(shibari_shadow_overlay)
			add_rope_overlays(ropee.greyscale_colors, hooman?.dna?.species?.mutant_bodyparts[FEATURE_TAUR])
			buckled.visible_message(span_warning("[user]将[buckled]绑在了[src]上！"),\
				span_userdanger("[user]将你绑在了[src]上！"),\
				span_hear("你听见绳索彻底拉紧的声音。"))
			return TRUE
		else
			return FALSE
	else
		to_chat(user, span_warning("你无法将自己绑在这个架子上，没人能做到这种程度的自缚！"))
		return FALSE

/obj/structure/chair/shibari_stand/atom_deconstruct(disassembled)
	qdel(src)

/obj/structure/chair/shibari_stand/proc/add_rope_overlays(color, taur)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)
	var/icon/rope_overlays = SSgreyscale.GetColoredIconByType(/datum/greyscale_config/shibari_stand_ropes, color)
	shibari_rope_overlay = mutable_appearance(rope_overlays, "ropes_above[taur ? "_snek" : ""]", ABOVE_MOB_LAYER)
	shibari_rope_overlay_behind = mutable_appearance(rope_overlays, "ropes_behind", BELOW_MOB_LAYER)
	add_overlay(shibari_rope_overlay)
	add_overlay(shibari_rope_overlay_behind)

/obj/structure/chair/shibari_stand/post_buckle_mob(mob/living/buckled)
	buckled.add_offsets(type, y_add = 4)
	buckled.layer = BELOW_MOB_LAYER

	if(LAZYLEN(buckled_mobs))
		if(ishuman(buckled_mobs[1]))
			current_mob = buckled_mobs[1]

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.forceMove(loc)
			current_mob.handcuffed.dropped(current_mob)
			current_mob.set_handcuffed(null)
			current_mob.update_handcuffed()

		var/obj/item/restraints/handcuffs/milker/shibari/cuffs = new (current_mob)
		current_mob.set_handcuffed(cuffs)
		cuffs.parent_chair = WEAKREF(src)
		if(HAS_TRAIT(current_mob, TRAIT_ROPEBUNNY))
			current_mob.handcuffed.breakouttime = 4 MINUTES
		current_mob.update_abstract_handcuffed()

//Restore the position of the mob after unbuckling.
/obj/structure/chair/shibari_stand/post_unbuckle_mob(mob/living/buckled)
	buckled.remove_offsets(type)
	buckled.layer = initial(buckled.layer)

	cut_overlay(shibari_shadow_overlay)
	cut_overlay(shibari_rope_overlay)
	cut_overlay(shibari_rope_overlay_behind)

	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()

	if(ropee)
		ropee.forceMove(get_turf(src))
	current_mob = null

/obj/item/restraints/handcuffs/milker/shibari
	name = "绳索"
	desc = "用于束缚双手的绳缚绳索。"
	breakouttime = 2 MINUTES

//Disassembling shibari stand
/obj/structure/chair/shibari_stand/click_ctrl_shift(mob/user)
	to_chat(user, span_notice("你开始松开[src]的框架……"))
	if(!do_after(user, 8 SECONDS, src))
		to_chat(user, span_warning("你没能拆卸[src]。"))
		return

	to_chat(user, span_notice("你拆卸了[src]。"))
	var/obj/item/construction_kit/bdsm/shibari/kit = new(get_turf(src))
	kit.set_greyscale(greyscale_colors)
	unbuckle_all_mobs()
	qdel(src)

//Changing color of shibari stand
/obj/structure/chair/shibari_stand/click_ctrl(mob/user)
	var/list/allowed_configs = list()
	allowed_configs += "[greyscale_config]"
	var/datum/greyscale_modify_menu/menu = new(
		src, usr, allowed_configs, null, \
		starting_icon_state = icon_state, \
		starting_config = greyscale_config, \
		starting_colors = greyscale_colors
	)
	menu.ui_interact(usr)
	to_chat(user, span_notice("你更改了框架塑料配件的颜色。"))
	return CLICK_ACTION_SUCCESS

/obj/structure/chair/shibari_stand/examine(mob/user)
	. = ..()
	. += span_purple("可通过<b>Ctrl+Shift+单击</b>拆卸[src]。")
	. += span_purple("可通过<b>Ctrl+单击</b>自定义[src]的颜色。")
