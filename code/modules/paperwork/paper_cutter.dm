/obj/item/papercutter
	name = "裁纸机"
	desc = "标准办公设备。用大刀片精确裁切纸张。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "papercutter"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	pass_flags = PASSTABLE

	/// The paper currently loaded inside the cutter
	var/obj/item/paper/stored_paper

	/// The blade currently loaded inside the cutter
	var/obj/item/hatchet/cutterblade/stored_blade

	/// Whether the cutter blade is secured or not.
	var/blade_secured = TRUE

	/// The chance for a clumsy person to cut themselves on the blade
	/// Should probably be low-ish to prevent people spamming it quite so easily
	var/cut_self_chance = 5

/obj/item/papercutter/Initialize(mapload)
	. = ..()
	stored_blade = new /obj/item/hatchet/cutterblade(src)
	register_context()
	update_appearance()
	AddElement(/datum/element/drag_pickup)

/obj/item/papercutter/Destroy(force)
	if(!isnull(stored_paper))
		QDEL_NULL(stored_paper)
	if(!isnull(stored_blade))
		QDEL_NULL(stored_blade)
	return ..()

/obj/item/papercutter/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(!isnull(held_item))
		if(held_item.tool_behaviour == TOOL_SCREWDRIVER)
			if(isnull(stored_blade))
				return NONE
			context[SCREENTIP_CONTEXT_LMB] = "[(blade_secured ? "松开" : "固定")]刀片"
		if(istype(held_item, /obj/item/paper))
			if(!isnull(stored_paper))
				return NONE
			context[SCREENTIP_CONTEXT_LMB] = "放入纸张"
		if(istype(held_item, /obj/item/hatchet/cutterblade))
			if(!isnull(stored_blade))
				return NONE
			context[SCREENTIP_CONTEXT_LMB] = "放入刀片"

	if(!isnull(stored_paper))
		context[SCREENTIP_CONTEXT_ALT_LMB] = "取出纸张"
		if(!(isnull(stored_blade)) && blade_secured)
			context[SCREENTIP_CONTEXT_RMB] = "裁切纸张"

	else if(!isnull(stored_blade) && !blade_secured)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "取出刀片"

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/papercutter/atom_deconstruct(disassembled)
	if(!disassembled)
		return

	if(!isnull(stored_paper))
		stored_paper.forceMove(drop_location())
	if(!isnull(stored_blade))
		stored_blade.forceMove(drop_location())

/obj/item/papercutter/Exited(atom/movable/leaving, atom/new_loc)
	. = ..()
	if(leaving == stored_paper)
		stored_paper = null
	if(leaving == stored_blade)
		stored_blade = null

/obj/item/papercutter/suicide_act(mob/living/user)
	if(iscarbon(user) && stored_blade)
		var/mob/living/carbon/carbon_user = user
		var/obj/item/bodypart/user_head = carbon_user.get_bodypart(BODY_ZONE_HEAD)
		if(isnull(user_head)) // So no head?
			user.visible_message(span_suicide("[user] 试图用 [src] 砍下自己的头，但早就没有头了！真是丢人！"))
			return SHAME
		user.visible_message(span_suicide("[user] 正用 [src] 砍自己的头！看起来是想自杀！"))
		user_head.drop_limb()
		playsound(loc, SFX_DESECRATION, 50, TRUE, -1)
		return BRUTELOSS
	// If we have no blade, just beat ourselves up
	user.visible_message(span_suicide("[user] 反复用 [src] 砸自己！看起来是想自杀！"))
	playsound(loc, 'sound/items/gavel.ogg', 50, TRUE, -1)
	return BRUTELOSS

/obj/item/papercutter/update_overlays()
	. = ..()
	if(!isnull(stored_paper))
		. += "paper"
	if(!isnull(stored_blade))
		. += "cutter_overlay"

/obj/item/papercutter/screwdriver_act(mob/living/user, obj/item/tool)
	if(!stored_blade && !blade_secured)
		balloon_alert(user, "没有刀片！")
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	balloon_alert(user, "[blade_secured ? "已松开" : "已固定"]")
	blade_secured = !blade_secured
	return ITEM_INTERACT_SUCCESS

/obj/item/papercutter/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/paper))
		if(is_type_in_list(tool, list(/obj/item/paper/holy_writ, /obj/item/paper/pamphlet, /obj/item/paper/paperslip)))
			balloon_alert(user, "装不下！")
			return ITEM_INTERACT_BLOCKING
		if(stored_paper)
			balloon_alert(user, "里面已经有纸了！")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		playsound(loc, SFX_PAGE_TURN, 60, TRUE)
		balloon_alert(user, "已放入纸张")
		stored_paper = tool
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/hatchet/cutterblade))
		if(stored_blade)
			balloon_alert(user, "里面已经有刀片了！")
			return ITEM_INTERACT_BLOCKING
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		balloon_alert(user, "已放入刀片")
		tool.forceMove(src)
		stored_blade = tool
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/papercutter/click_alt(mob/user)
	// can only remove one at a time; paper goes first, as its most likely what players will want to be taking out
	if(!isnull(stored_paper))
		user.put_in_hands(stored_paper)
	else if(!isnull(stored_blade) && !blade_secured)
		user.put_in_hands(stored_blade)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/papercutter/attack_hand_secondary(mob/user, list/modifiers)
	if(!stored_blade)
		balloon_alert(user, "没有刀片！")
	else if(!blade_secured)
		balloon_alert(user, "刀片未固定！")
	else if(!stored_paper)
		balloon_alert(user, "没有可裁切的东西！")
	else
		cut_paper(user)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/papercutter/proc/cut_paper(mob/user)
	playsound(src.loc, 'sound/items/weapons/slash.ogg', 50, TRUE)
	var/clumsy = (iscarbon(user) && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(cut_self_chance))
	to_chat(user, span_userdanger("你整齐地裁开了 [stored_paper][clumsy ? "……顺便还裁到了自己的手指！" : "。"]"))
	if(clumsy)
		var/obj/item/bodypart/finger = user.get_active_hand()
		if (iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			carbon_user.cause_wound_of_type_and_severity(WOUND_SLASH, finger, WOUND_SEVERITY_MODERATE, wound_source = "纸割伤")
	stored_paper = null
	qdel(stored_paper)
	new /obj/item/paper/paperslip(get_turf(src))
	new /obj/item/paper/paperslip(get_turf(src))
	update_appearance()

/obj/item/paper/paperslip
	name = "纸条"
	desc = "一张大纸被裁开后剩下的小纸条。哇哦。"
	icon_state = "paperslip"
	inhand_icon_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/paper/paperslip/grind_results()
	return list(/datum/reagent/cellulose = 1.5)

/obj/item/paper/paperslip/fortune
	name = "幸运纸条"

/obj/item/paper/paperslip/fortune/Initialize(mapload)
	default_raw_text = pick(GLOB.wisdoms)
	return ..()

///More fancy and sturdy paper slip which is a "plastic card", used for things like spare ID safe code
/obj/item/paper/paperslip/corporate
	name = "企业塑料卡"
	desc = "用于企业机密事务的塑料卡。不知怎么的还能用笔书写。"
	icon_state = "corppaperslip"
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 3, /datum/material/paper = HALF_SHEET_MATERIAL_AMOUNT / 2)
	max_integrity = 130 //Slightly more sturdy because of being made out of a plastic
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound = 'sound/items/handling/disk_pickup.ogg'
	throw_range = 6
	throw_speed = 2

/obj/item/paper/paperslip/corporate/grind_results()
	return list(/datum/reagent/plastic_polymers = 1.5)

/obj/item/hatchet/cutterblade
	name = "裁纸机刀片"
	desc = "裁纸机的刀片。多半是为了打磨或磨锐而拆下来的。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "cutterblade"
	inhand_icon_state = "knife"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
