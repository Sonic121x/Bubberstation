#define HYPO_INJECT 1
#define HYPO_SPRAY 0

#define WAIT_INJECT 2 SECONDS
#define WAIT_SPRAY 1.5 SECONDS
#define SELF_INJECT 1.5 SECONDS
#define SELF_SPRAY 1.5 SECONDS

#define DELUXE_WAIT_INJECT 0.5 SECONDS
#define DELUXE_WAIT_SPRAY 0
#define DELUXE_SELF_INJECT 1 SECONDS
#define DELUXE_SELF_SPRAY 1 SECONDS

#define COMBAT_WAIT_INJECT 0
#define COMBAT_WAIT_SPRAY 0
#define COMBAT_SELF_INJECT 0
#define COMBAT_SELF_SPRAY 0

/obj/item/hypospray/mkii
	name = "无针注射器 Mk.II"
	icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'
	icon_state = "hypo2"
	greyscale_config = /datum/greyscale_config/hypospray_mkii
	desc = "德福雷斯特医疗公司的新产品，这款无针注射器使用 50 单位药瓶作为药剂来源，便于快速更换。"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
	)
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	/// Is the hypospray only able to use small vials. Relates to the loaded overlays
	var/small_only = TRUE
	/// The presently-inserted vial.
	var/obj/item/reagent_containers/cup/vial/vial
	/// If the Hypospray starts with a vial, which vial does it start with?
	var/obj/item/reagent_containers/cup/vial/start_vial

	/// Time taken to inject others
	var/inject_wait = WAIT_INJECT
	/// Time taken to spray others
	var/spray_wait = WAIT_SPRAY
	/// Time taken to inject self
	var/inject_self = SELF_INJECT
	/// Time taken to spray self
	var/spray_self = SELF_SPRAY

	/// Can you hotswap vials? - now all hyposprays can!
	var/quickload = TRUE
	/// Does it penetrate clothing?
	var/penetrates = null
	/// Used for GAGS-ified hypos.
	var/gags_bodystate = "hypo2_normal"
	/// The original icon file where our overlays reside.
	var/original_icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'

/obj/item/hypospray/mkii/combat
	name = "无针注射器 Mk.II 战斗型"
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	icon_state = "combathypo2"
	gags_bodystate = "hypo2_combat"
	desc = "德福雷斯特无针注射器 Mk. II 系列的战斗型号，可刺穿厚重护甲，并能在战斗中快速自我注射。"
	inject_wait = WAIT_INJECT
	spray_wait = WAIT_SPRAY
	spray_self = COMBAT_SELF_SPRAY
	inject_self = COMBAT_SELF_INJECT
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/piercing
	name = "无针注射器 Mk.II 高级型"
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small)
	icon_state = "piercinghypo2"
	gags_bodystate = "hypo2_piercing"
	desc = "德福雷斯特无针注射器 Mk. II 系列的高级型号，可刺穿厚重护甲，并快速喷洒或注射药剂。"
	spray_self = DELUXE_SELF_INJECT
	inject_self = DELUXE_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

// Deluxe hypo upgrade Kit
/obj/item/custom_kit/deluxe_hypo2
	name = "无针注射器 Mk. II 豪华改装套件"
	desc = "将德福雷斯特无针注射器 Mk. II 升级为可支持更大药瓶的版本。"
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/hypospray/mkii
	to_obj = /obj/item/hypospray/mkii/deluxe
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 8)

/obj/item/custom_kit/deluxe_hypo2/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/hypospray/mkii/our_hypo = target_obj
	if(our_hypo.type in subtypesof(/obj/item/hypospray/mkii/))
		balloon_alert(user, "只能用于基础款 Mk. II 无针注射器！")
		return FALSE
	if(our_hypo.vial != null)
		balloon_alert(user, "请先取出药瓶！")
		return FALSE
	return TRUE

/obj/item/hypospray/mkii/deluxe
	name = "无针注射器 Mk.II 豪华型"
	icon_state = "bighypo2"
	gags_bodystate = "hypo2_deluxe"
	desc = "无针注射器 Mk. II 的豪华型号，可兼容 100 单位与 50 单位药瓶。"
	allowed_containers = list(/obj/item/reagent_containers/cup/vial/small, /obj/item/reagent_containers/cup/vial/large)

/obj/item/hypospray/mkii/deluxe/cmo
	name = "无针注射器 Mk.II 豪华型：首席医疗官版"
	icon_state = "cmo2"
	gags_bodystate = "hypo2_cmo"
	desc = "首席医疗官珍视的无针注射器 Mk. II 豪华型，可兼容 100 单位与 50 单位药瓶，起效更快，每次喷洒可注入更多试剂。"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/deluxe/combat
	name = "无针注射器 Mk.II 豪华型：战斗版"
	icon_state = "combat2"
	gags_bodystate = "hypo2_tactical"
	desc = "无针注射器 Mk. II 豪华型的变体，可兼容 100 单位与 50 单位药瓶，配有超载喷嘴与穿甲针尖。"
	// Made non-indestructible since this is typically an admin spawn.  still robust though!
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!isnull(start_vial))
		var/init_vial = new start_vial()
		vial = init_vial
		start_vial = null
		update_appearance()

/obj/item/hypospray/mkii/update_overlays()
	. = ..()
	if(!vial)
		return
	if(vial.reagents.total_volume)
		var/vial_spritetype = "chem-color"
		if(istype(vial, /obj/item/reagent_containers/cup/vial/large))
			vial_spritetype += "[vial.type_suffix]"
		else
			vial_spritetype += "-s"
		var/mutable_appearance/chem_loaded = mutable_appearance(original_icon, vial_spritetype)
		chem_loaded.color = vial.chem_color
		. += chem_loaded
	if(vial.greyscale_colors != null)
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, "[vial.icon_state]-body")
		vial_overlay.color = vial.greyscale_colors
		. += vial_overlay
		var/mutable_appearance/vial_overlay_glass = mutable_appearance(original_icon, "[vial.icon_state]-glass")
		. += vial_overlay_glass
	else
		var/mutable_appearance/vial_overlay = mutable_appearance(original_icon, vial.icon_state)
		. += vial_overlay

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	if(vial)
		. += "[vial] 中还剩 [vial.reagents.total_volume]u。"
	else
		. += "它没有装入药瓶。"
	. += span_notice("按住 Ctrl-Shift 点击可更改颜色或恢复默认。")

/obj/item/hypospray/mkii/click_ctrl_shift(mob/user)
	var/choice = tgui_input_list(user, "要将注射器改为 GAGS 配色，还是恢复默认？", "外观", list("GAGS", "不了"))
	if(choice == "GAGS")
		icon_state = gags_bodystate
		//choices go here
		var/atom/fake_atom = src
		var/list/allowed_configs = list()
		var/config = initial(fake_atom.greyscale_config)
		allowed_configs += "[config]"
		if(greyscale_colors == null)
			greyscale_colors = "#00AAFF#FFAA00"

		var/datum/greyscale_modify_menu/menu = new(src, usr, allowed_configs)
		menu.ui_interact(usr)
	else
		icon_state = initial(icon_state)
		icon = original_icon
		greyscale_colors = null

/obj/item/hypospray/mkii/proc/unload_hypo(obj/item/hypo, mob/user)
	if(!hypo)
		to_chat(user, span_notice("这支注射器没有装填药瓶！"))
		return

	hypo.forceMove(user.loc)
	user.put_in_hands(hypo)
	to_chat(user, span_notice("你从 [src] 中取出了 [vial]。"))
	vial = null
	update_icon()
	playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)

/obj/item/hypospray/mkii/proc/insert_vial(obj/item/new_vial, mob/living/user)
	if(!is_type_in_list(new_vial, allowed_containers))
		to_chat(user, span_notice("[src] 无法使用这种药瓶。"))
		return FALSE
	var/atom/quickswap_loc = new_vial.loc
	if(!user.transferItemToLoc(new_vial, src))
		return FALSE
	if(!isnull(vial))
		if(quickswap_loc == user)
			user.put_in_hands(vial)
		else
			vial.forceMove(quickswap_loc)
	vial = new_vial
	user.visible_message(span_notice("[user] 将一支药瓶装入了 [src]。"), span_notice("你将 [vial] 装入 [src]。"))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/hypospray/mkii/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/vial))
		return NONE
	if(isnull(vial) || quickload)
		insert_vial(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] 只能容纳一支药瓶！"))
	return ITEM_INTERACT_BLOCKING

/obj/item/hypospray/mkii/attack_self(mob/user)
	. = ..()
	if(vial)
		vial.attack_self(user)
		return TRUE

/obj/item/hypospray/mkii/attack_self_secondary(mob/user)
	. = ..()
	if(vial)
		vial.attack_self_secondary(user)
		return TRUE

/obj/item/hypospray/mkii/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		to_chat(user, "[src] 的控制电路已经被超载过了。")
		return FALSE
	//all these are 0
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK
	to_chat(user, "你超载了 [src] 的控制电路。")
	obj_flags |= EMAGGED
	return TRUE

/obj/item/hypospray/mkii/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/item/reagent_containers/cup/vial))
		insert_vial(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return do_inject(interacting_with, user, mode=HYPO_SPRAY)

/obj/item/hypospray/mkii/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return do_inject(interacting_with, user, mode=HYPO_INJECT)

/obj/item/hypospray/mkii/proc/do_inject(mob/living/injectee, mob/living/user, mode)
	if(!isliving(injectee))
		return NONE

	if(!injectee.reagents || !injectee.can_inject(user, user.zone_selected, penetrates))
		return NONE

	if(iscarbon(injectee))
		var/obj/item/bodypart/affecting = injectee.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("肢体缺失！"))
			return ITEM_INTERACT_BLOCKING
	//Always log attemped injections for admins
	var/contained = vial.reagents.get_reagent_log_string()
	log_combat(user, injectee, "试图注射", src, addition="其中含有 [contained]")

	if(!vial)
		to_chat(user, span_notice("[src] 没有装入药瓶！"))
		return ITEM_INTERACT_BLOCKING
	if(!vial.reagents.total_volume)
		to_chat(user, span_notice("[src] 的药瓶是空的！"))
		return ITEM_INTERACT_BLOCKING

	var/fp_verb = mode == HYPO_SPRAY ? "喷洒" : "注射"

	if(injectee != user)
		injectee.visible_message(span_danger("[user] 正试图用 [src] [fp_verb] [injectee]！"), \
						span_userdanger("[user] 正试图用 [src] [fp_verb]你！"))

	var/selected_wait_time
	if(injectee == user)
		selected_wait_time = (mode == HYPO_INJECT) ? inject_self : spray_self
	else
		selected_wait_time = (mode == HYPO_INJECT) ? inject_wait : spray_wait

	if(!do_after(user, selected_wait_time, injectee, extra_checks = CALLBACK(injectee, /mob/living/proc/can_inject, user, user.zone_selected, penetrates)))
		return ITEM_INTERACT_BLOCKING
	if(!vial || !vial.reagents.total_volume)
		return ITEM_INTERACT_BLOCKING
	log_attack("<font color='red'>[user.name]（[user.ckey]）对 [injectee.name]（[injectee.ckey]）使用了 [src]，其中含有 [contained]（战斗模式：[uppertext(user.combat_mode)]）（模式：[mode]）</font>")
	if(injectee != user)
		injectee.visible_message(span_danger("[user] 对 [injectee] 使用了 [src]！"), \
						span_userdanger("[user] 对你使用了 [src]！"))
	else
		injectee.log_message("<font color='orange'>对自己使用了 [src]（[contained]）。</font>", LOG_ATTACK)

	switch(mode)
		if(HYPO_INJECT)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = INJECT)
		if(HYPO_SPRAY)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = PATCH)

	var/long_sound = vial.amount_per_transfer_from_this >= 15
	playsound(loc, long_sound ? 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg' : pick('modular_skyrat/modules/hyposprays/sound/hypospray.ogg','modular_skyrat/modules/hyposprays/sound/hypospray2.ogg'), 50, 1, -1)
	to_chat(user, span_notice("你[fp_verb]了 [vial.amount_per_transfer_from_this] 单位溶液。注射器的药瓶现在装有 [vial.reagents.total_volume] 单位。"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/hypospray/mkii/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!vial)
			. = ..()
			return
		else
			unload_hypo(vial,user)
	else
		. = ..()

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	. += span_notice("对患者<b>左键点击</b>可喷洒，<b>右键点击</b>可注射。")

#undef HYPO_INJECT
#undef HYPO_SPRAY
#undef WAIT_INJECT
#undef WAIT_SPRAY
#undef SELF_INJECT
#undef SELF_SPRAY
#undef DELUXE_WAIT_INJECT
#undef DELUXE_WAIT_SPRAY
#undef DELUXE_SELF_INJECT
#undef DELUXE_SELF_SPRAY
#undef COMBAT_WAIT_INJECT
#undef COMBAT_WAIT_SPRAY
#undef COMBAT_SELF_INJECT
#undef COMBAT_SELF_SPRAY
