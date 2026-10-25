/obj/item/stack/medical/wrap/sticky_tape
	name = "黏性胶带"
	singular_name = "黏性胶带"
	desc = "用于把东西粘上，好把那些东西粘到人身上。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/stack/medical/wrap/sticky_tape"
	post_init_icon_state = "tape"
	novariants = TRUE
	item_flags = NOBLUDGEON
	amount = 5
	max_amount = 5
	self_delay = 8 SECONDS
	other_delay = 5 SECONDS
	splint_factor = 0.65
	merge_type = /obj/item/stack/medical/wrap/sticky_tape
	greyscale_config = /datum/greyscale_config/tape
	greyscale_colors = "#B2B2B2#BD6A62"
	apply_verb = "缠贴"
	heal_begin_sound = 'sound/items/duct_tape/duct_tape_rip.ogg'
	heal_end_sound = 'sound/items/duct_tape/duct_tape_rip.ogg'
	mats_per_unit = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT)

	/// Prefix applied to the target when wrapped with this tape.
	var/prefix = "黏性"
	/// Embed applied to the target when wrapped with this tape.
	var/conferred_embed = /datum/embedding/sticky_tape
	///The tape type you get when ripping off a piece of tape.
	var/obj/tape_gag = /obj/item/clothing/mask/muzzle/tape

/datum/embedding/sticky_tape
	pain_mult = 0
	jostle_pain_mult = 0
	ignore_throwspeed_threshold = TRUE
	immune_traits = null

/obj/item/stack/medical/wrap/sticky_tape/grind_results()
	return list(/datum/reagent/cellulose = 5)

/obj/item/stack/medical/wrap/sticky_tape/attack_hand(mob/user, list/modifiers)
	if(user.get_inactive_held_item() == src)
		if(is_zero_amount(delete_if_zero = TRUE))
			return
		playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)
		if(!do_after(user, 1 SECONDS))
			return
		var/new_tape_gag = new tape_gag(src)
		user.put_in_hands(new_tape_gag)
		use(1)
		to_chat(user, span_notice("你撕下了一段胶带。"))
		playsound(user, 'sound/items/duct_tape/duct_tape_snap.ogg', 50, TRUE)
		return TRUE
	return ..()

/obj/item/stack/medical/wrap/sticky_tape/examine(mob/user)
	. = ..()
	. += "[span_notice("你可以用空着的手撕下一段。")]"

/obj/item/stack/medical/wrap/sticky_tape/interact_with_atom(obj/item/target, mob/living/user, list/modifiers)
	if(!isitem(target))
		return NONE

	if(target.get_embed()?.type == conferred_embed)
		to_chat(user, span_warning("[target]上已经裹有[src]了！"))
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user]开始用[src]缠绕[target]。"), span_notice("你开始用[src]缠绕[target]。"))
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)

	if(!do_after(user, 3 SECONDS, target=target))
		return ITEM_INTERACT_BLOCKING

	playsound(user, 'sound/items/duct_tape/duct_tape_snap.ogg', 50, TRUE)
	use(1)
	if(istype(target, /obj/item/clothing/gloves/fingerless))
		var/obj/item/clothing/gloves/tackler/offbrand/O = new /obj/item/clothing/gloves/tackler/offbrand
		to_chat(user, span_notice("你用[src]把[target]变成了[O]。"))
		QDEL_NULL(target)
		user.put_in_hands(O)
		return ITEM_INTERACT_SUCCESS

	if(target.get_embed()?.type == conferred_embed)
		to_chat(user, span_warning("[target]上已经裹有[src]了！"))
		return ITEM_INTERACT_BLOCKING

	target.set_embed(conferred_embed)
	to_chat(user, span_notice("你用[src]缠好了[target]。"))
	target.name = "[prefix] [target.name]"

	if(isgrenade(target))
		var/obj/item/grenade/sticky_bomb = target
		sticky_bomb.sticky = TRUE

	return ITEM_INTERACT_SUCCESS

/obj/item/stack/medical/wrap/sticky_tape/super
	name = "超黏胶带"
	singular_name = "超黏胶带"
	desc = "这大概是全银河最恶作剧的东西了。使用时请极度不要小心。"
	prefix = "超黏"
	conferred_embed = /datum/embedding/sticky_tape/super
	splint_factor = 0.4
	merge_type = /obj/item/stack/medical/wrap/sticky_tape/super
	greyscale_colors = "#4D4D4D#75433F"
	tape_gag = /obj/item/clothing/mask/muzzle/tape/super
	mats_per_unit = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT * 3)

/datum/embedding/sticky_tape/super
	embed_chance = 100
	fall_chance = 0.1

/obj/item/stack/medical/wrap/sticky_tape/pointy
	name = "尖刺胶带"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/stack/medical/wrap/sticky_tape/pointy"
	post_init_icon_state = "tape_spikes"
	singular_name = "尖刺胶带"
	desc = "用于把东西粘上，好把那些东西粘进人体内。"
	prefix = "尖刺"
	conferred_embed = /datum/embedding/pointy_tape
	merge_type = /obj/item/stack/medical/wrap/sticky_tape/pointy
	greyscale_config = /datum/greyscale_config/tape/spikes
	greyscale_colors = "#E64539#808080#AD2F45"
	tape_gag = /obj/item/clothing/mask/muzzle/tape/pointy
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 1.5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)

/datum/embedding/pointy_tape
	ignore_throwspeed_threshold = TRUE

/obj/item/stack/medical/wrap/sticky_tape/pointy/super
	name = "超尖刺胶带"
	singular_name = "超尖刺胶带"
	desc = "你不知道胶带也能看起来这么邪恶。欢迎来到空间站 13。"
	prefix = "超尖刺"
	conferred_embed = /datum/embedding/pointy_tape/super
	merge_type = /obj/item/stack/medical/wrap/sticky_tape/pointy/super
	greyscale_colors = "#8C0A00#4F4F4F#300008"
	tape_gag = /obj/item/clothing/mask/muzzle/tape/pointy/super
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)

/datum/embedding/pointy_tape/super
	embed_chance = 100

/obj/item/stack/medical/wrap/sticky_tape/surgical
	name = "手术胶带"
	singular_name = "手术胶带"
	desc = "与骨胶配合，用于把断裂的骨骼重新拼合，而不是用来恶作剧。"
	prefix = "手术"
	conferred_embed = /datum/embedding/sticky_tape/surgical
	splint_factor = 0.5
	custom_price = PAYCHECK_CREW
	merge_type = /obj/item/stack/medical/wrap/sticky_tape/surgical
	greyscale_colors = "#70BAE7#BD6A62"
	tape_gag = /obj/item/clothing/mask/muzzle/tape/surgical

/datum/embedding/sticky_tape/surgical
	embed_chance = 30

/obj/item/stack/medical/wrap/sticky_tape/surgical/get_surgery_tool_overlay(tray_extended)
	return "tape" + (tray_extended ? "" : "_out")

/obj/item/stack/medical/wrap/sticky_tape/duct
	name = "管道胶带"
	singular_name = "管道胶带"
	desc = "专为封堵物体上的刺孔、破洞和破损而设计的胶带。工程师们几乎在所有维修工作中都离不开它。也许有点太离不开了……"
	prefix = "经管道胶带加固"
	conferred_embed = /datum/embedding/sticky_tape/duct
	merge_type = /obj/item/stack/medical/wrap/sticky_tape/duct
	var/object_repair_value = 30
	amount = 10
	max_amount = 10

/datum/embedding/sticky_tape/duct
	embed_chance = 0 //Wrapping something in duct tape is basically ensuring it never embeds.

/obj/item/stack/medical/wrap/sticky_tape/duct/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(!object_repair_value)
		return NONE

	if(issilicon(interacting_with))
		var/mob/living/silicon/robotic_pal = interacting_with
		var/robot_is_damaged = robotic_pal.get_brute_loss()

		if(!robot_is_damaged)
			user.balloon_alert(user, "[robotic_pal]没有受损！")
			return ITEM_INTERACT_BLOCKING

		user.visible_message(span_notice("[user]开始用[src]修理[robotic_pal]。"), span_notice("你开始用[src]修理[robotic_pal]。"))
		playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)

		if(!do_after(user, 3 SECONDS, target = robotic_pal))
			return ITEM_INTERACT_BLOCKING

		robotic_pal.adjust_brute_loss(-object_repair_value)
		use(1)
		to_chat(user, span_notice("你用[src]修好了[interacting_with]。"))
		return ITEM_INTERACT_SUCCESS

	if(!isobj(interacting_with) || iseffect(interacting_with))
		return NONE

	if(HAS_TRAIT(interacting_with, TRAIT_DUCT_TAPE_UNREPAIRABLE))
		user.balloon_alert(user, "无法用管道胶带修复！")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/object_to_repair = interacting_with
	var/object_is_damaged = object_to_repair.get_integrity() < object_to_repair.max_integrity

	if(!object_is_damaged)
		user.balloon_alert(user, "[object_to_repair]没有受损！")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user]开始用[src]修理[object_to_repair]。"), span_notice("你开始用[src]修理[object_to_repair]。"))
	playsound(user, 'sound/items/duct_tape/duct_tape_rip.ogg', 50, TRUE)

	if(!do_after(user, 3 SECONDS, target = object_to_repair))
		return ITEM_INTERACT_BLOCKING

	if(isclothing(object_to_repair))
		var/obj/item/clothing/clothing_to_repair = object_to_repair
		clothing_to_repair.repair()
	else
		object_to_repair.repair_damage(object_repair_value)

	use(1)
	to_chat(user, span_notice("你用[src]修好了[interacting_with]。"))
	return ITEM_INTERACT_SUCCESS
