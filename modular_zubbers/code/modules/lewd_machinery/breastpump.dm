/obj/item/breastpump
	name = "吸乳泵"
	icon = 'modular_zubbers/icons/obj/lewd.dmi'
	icon_state = "breastpump"
	desc = "一台吸乳泵，可接入烧杯或杯子，用以帮助需要泌乳的患者。"
	w_class = WEIGHT_CLASS_SMALL
	/// Only allowed to input beaker or cup type objects
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/cup/glass)
	/// The presently-inserted container.
	var/obj/item/reagent_containers/cup/container
	/// Flags used by the injection/draw
	var/inject_flags = NONE
	/// Can you hotswap beakers? - Yes
	var/quickload = TRUE


/obj/item/breastpump/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/breastpump/examine(mob/user)
	. = ..()
	if(container)
		. += "[container] 中含有 [container.reagents.total_volume]u 液体。"
	else
		. += "它尚未装入容器。"

/obj/item/breastpump/proc/unload_container(obj/object, mob/user)
	if(!object)
		to_chat(user, span_notice("尚未装入容器！"))
		return

	container.forceMove(user.loc)
	user.put_in_hands(container)
	to_chat(user, span_notice("你将 [object] 从 [src] 中取出。"))
	container = null
	update_icon()
	playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)

/obj/item/breastpump/proc/insert_container(obj/item/new_container, mob/living/user)
	var/atom/quickswap_loc = new_container.loc
	if(!user.transferItemToLoc(new_container, src))
		return FALSE
	if(!isnull(container))
		if(quickswap_loc == user)
			user.put_in_hands(container)
		else
			container.forceMove(quickswap_loc)
	container = new_container
	user.visible_message(span_notice("[user] 将容器装入了 [src]。"), span_notice("你将 [container] 装入了 [src]。"))
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/breastpump/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!is_type_in_list(tool, allowed_containers))
		to_chat(user, span_notice("[src] 不接受这种容器。"))
		return NONE
	if(isnull(container) || quickload)
		insert_container(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] 只能容纳一个容器！"))
	return ITEM_INTERACT_BLOCKING

/obj/item/breastpump/proc/try_pump(atom/target, mob/user)
	if(!target.reagents)
		return FALSE

	if(isliving(target))
		var/mob/living/living_target = target
		if(!living_target.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE|inject_flags))
			return FALSE

	return TRUE

/obj/item/breastpump/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!target.reagents)
		return NONE
	if(!src.container)
		to_chat(user, span_warning("未装入容器！"))
		return ITEM_INTERACT_BLOCKING
	if(!try_pump(target, user))
		return ITEM_INTERACT_BLOCKING
	if(target != user)
		to_chat(user, span_warning("你不能对别人使用吸乳泵！"))
		return ITEM_INTERACT_BLOCKING

	SEND_SIGNAL(target, COMSIG_LIVING_TRY_SYRINGE_WITHDRAW, user)

	if(src.container.reagents.holder_full())
		to_chat(user, span_notice("[src] 已满。"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/organ/genital/breasts/breasts = user.get_organ_slot(ORGAN_SLOT_BREASTS)

	if (breasts == null)
		to_chat(user, span_notice("[user] 没有可用的乳房。"))
		return ITEM_INTERACT_BLOCKING

	if (breasts.reagents.total_volume <= 0)
		to_chat(user, span_notice("[user] 的乳房是空的。"))
		return ITEM_INTERACT_BLOCKING

	var/fluid_multiplier = 3

	if(user.has_status_effect(/datum/status_effect/climax))
		fluid_multiplier = 5

	to_chat(user, span_notice("[src] 嗡嗡转动……"))
	var/trans = breasts.reagents.trans_to(src.container, 1 * fluid_multiplier, transferred_by = user) // transfer from, transfer to - who cares?
	if(trans)
		to_chat(user, span_notice("你向 [src.container] 中注入了 [trans] 单位溶液。现在它含有 [src.container.reagents.total_volume] 单位。"))
	return ITEM_INTERACT_SUCCESS

/obj/item/breastpump/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated)
			return
		else if(!container)
			. = ..()
			return
		else
			unload_container(container,user)
	else
		. = ..()

/obj/item/breastpump/examine(mob/user)
	. = ..()
	. += span_notice("一台个人吸乳泵，在拥有一对功能正常的乳房时可对自己使用。对自己<b>左键点击</b>即可使用。")


