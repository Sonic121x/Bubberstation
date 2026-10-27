/datum/surgery_operation/limb/prepare_cavity
	name = "撑开胸腔"
	desc = "撑开病人的胸腔，以便植入更大的物品。"
	implements = list(
		TOOL_RETRACTOR = 1,
		TOOL_CROWBAR = 1.5,
	)
	time = 4.8 SECONDS
	preop_sound = 'sound/items/handling/surgery/retractor1.ogg'
	success_sound = 'sound/items/handling/surgery/retractor2.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT
	any_surgery_states_blocked = SURGERY_CAVITY_WIDENED

/datum/surgery_operation/limb/prepare_cavity/get_default_radial_image()
	return image(/obj/item/retractor)

/datum/surgery_operation/limb/prepare_cavity/all_required_strings()
	return list("对胸部施术（目标胸部）") + ..()

/datum/surgery_operation/limb/prepare_cavity/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/prepare_cavity/on_preop(obj/item/bodypart/chest/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把[FORMAT_LIMB_OWNER(limb)]大大撑开……"),
		span_notice("[surgeon] 开始把[FORMAT_LIMB_OWNER(limb)]大大撑开。"),
		span_notice("[surgeon] 开始把[FORMAT_LIMB_OWNER(limb)]大大撑开。"),
	)
	display_pain(limb.owner, "你感到[chinese_body_zone_display(limb.plaintext_zone)]被撑开时传来的压迫感！")

/datum/surgery_operation/limb/prepare_cavity/on_success(obj/item/bodypart/chest/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	limb.add_surgical_state(SURGERY_CAVITY_WIDENED)

/datum/surgery_operation/limb/undo_prepare_cavity
	name = "闭合胸腔"
	desc = "复位病人的胸腔。"
	implements = list(
		TOOL_RETRACTOR = 1,
		TOOL_CROWBAR = 1.5,
	)
	time = 4.8 SECONDS
	preop_sound = 'sound/items/handling/surgery/retractor1.ogg'
	success_sound = 'sound/items/handling/surgery/retractor2.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_CAVITY_WIDENED

/datum/surgery_operation/limb/undo_prepare_cavity/get_default_radial_image()
	return image(/obj/item/retractor)

/datum/surgery_operation/limb/undo_prepare_cavity/all_required_strings()
	return list("对胸部施术（目标胸部）") + ..()

/datum/surgery_operation/limb/undo_prepare_cavity/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/undo_prepare_cavity/on_preop(obj/item/bodypart/chest/limb, mob/living/surgeon, tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始闭合[FORMAT_LIMB_OWNER(limb)]……"),
		span_notice("[surgeon] 开始闭合[FORMAT_LIMB_OWNER(limb)]。"),
		span_notice("[surgeon] 开始闭合[FORMAT_LIMB_OWNER(limb)]。"),
	)
	display_pain(limb.owner, "你感到[chinese_body_zone_display(limb.plaintext_zone)]被闭合时的压迫感！")

/datum/surgery_operation/limb/undo_prepare_cavity/on_success(obj/item/bodypart/chest/limb, mob/living/surgeon, tool, list/operation_args)
	. = ..()
	limb.remove_surgical_state(SURGERY_CAVITY_WIDENED)

/datum/surgery_operation/limb/cavity_implant
	name = "腔体植入"
	desc = "将物品植入病人的体腔。"
	operation_flags = OPERATION_NOTABLE
	implements = list(
		/obj/item = 1,
	)
	time = 3.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/organ1.ogg'
	success_sound = 'sound/items/handling/surgery/organ2.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_CAVITY_WIDENED
	/// Items that bypass normal size restrictions for cavity implantation
	var/list/heavy_cavity_implants

/datum/surgery_operation/limb/cavity_implant/New()
	. = ..()
	heavy_cavity_implants = typecacheof(list(
		/obj/item/transfer_valve,
	))

/datum/surgery_operation/limb/cavity_implant/all_required_strings()
	return list("对胸部施术（目标胸部）") + ..()

/datum/surgery_operation/limb/cavity_implant/get_default_radial_image()
	return image('icons/hud/screen_gen.dmi', "arrow_large_still")

/datum/surgery_operation/limb/cavity_implant/state_check(obj/item/bodypart/chest/limb)
	if(limb.body_zone != BODY_ZONE_CHEST)
		return FALSE
	if(!isnull(limb.cavity_item))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/cavity_implant/snowflake_check_availability(obj/item/bodypart/chest/limb, mob/living/surgeon, obj/item/tool, operated_zone)
	if(!surgeon.canUnEquip(tool))
		return FALSE
	// Stops accidentally putting a tool you meant to operate with
	// Besides who really wants to put a scalpel or a wrench inside someone that's lame
	if(IS_ROBOTIC_LIMB(limb) && (tool.tool_behaviour in GLOB.all_mechanical_tools))
		return FALSE
	if(IS_ORGANIC_LIMB(limb) && (tool.tool_behaviour in GLOB.all_surgical_tools))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/cavity_implant/tool_check(obj/item/tool)
	if(tool.w_class > WEIGHT_CLASS_NORMAL && !is_type_in_typecache(tool, heavy_cavity_implants))
		return FALSE
	if(tool.item_flags & (ABSTRACT|DROPDEL|HAND_ITEM))
		return FALSE
	if(isorgan(tool))
		return FALSE // use organ manipulation
	return TRUE

/datum/surgery_operation/limb/cavity_implant/on_preop(obj/item/bodypart/chest/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始把 [tool] 插入[FORMAT_LIMB_OWNER(limb)]……"),
		span_notice("[surgeon] 开始把 [tool] 插入[FORMAT_LIMB_OWNER(limb)]。"),
		span_notice("[surgeon] 开始把 [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "某样东西"] 插入[FORMAT_LIMB_OWNER(limb)]。"),
	)
	display_pain(limb.owner, "你感到有东西被插入[chinese_body_zone_display(limb.plaintext_zone)]，疼得要命！")

/datum/surgery_operation/limb/cavity_implant/on_success(obj/item/bodypart/chest/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	if (!surgeon.transferItemToLoc(tool, limb.owner, force = TRUE)) // shouldn't fail but just in case
		display_results(
			surgeon,
			limb.owner,
			span_warning("你似乎没法把 [tool] 塞进[limb.owner]的[chinese_body_zone_display(limb.plaintext_zone)]！"),
			span_warning("[surgeon] 似乎没法把 [tool] 塞进[limb.owner]的[chinese_body_zone_display(limb.plaintext_zone)]！"),
			span_warning("[surgeon] 似乎没法把 [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "某样东西"] 塞进[limb.owner]的[chinese_body_zone_display(limb.plaintext_zone)]！"),
		)
		return

	limb.cavity_item = tool
	limb.remove_surgical_state(SURGERY_CAVITY_WIDENED)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把 [tool] 硬塞进了[FORMAT_LIMB_OWNER(limb)]。"),
		span_notice("[surgeon] 把 [tool] 硬塞进了[FORMAT_LIMB_OWNER(limb)]！"),
		span_notice("[surgeon] 把 [tool.w_class > WEIGHT_CLASS_SMALL ? tool : "某样东西"] 硬塞进了[FORMAT_LIMB_OWNER(limb)]。"),
	)


/datum/surgery_operation/limb/undo_cavity_implant
	name = "取出腔体植入物"
	desc = "从体腔中取出物品。"
	implements = list(
		IMPLEMENT_HAND = 1,
		TOOL_HEMOSTAT = 2,
		TOOL_CROWBAR = 2.5,
		/obj/item/kitchen/fork = 5,
	)

	time = 3.2 SECONDS
	preop_sound = 'sound/items/handling/surgery/organ1.ogg'
	success_sound = 'sound/items/handling/surgery/organ2.ogg'
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_CAVITY_WIDENED

/datum/surgery_operation/limb/undo_cavity_implant/all_required_strings()
	return list("对胸部施术（目标胸部）") + ..()

/datum/surgery_operation/limb/undo_cavity_implant/get_default_radial_image()
	return image('icons/hud/screen_gen.dmi', "arrow_large_still")

/datum/surgery_operation/limb/undo_cavity_implant/get_radial_options(obj/item/bodypart/chest/limb, obj/item/tool, operating_zone)
	// Not bothering to cache this as the chance of hitting the same cavity item in the same round is rather low
	var/datum/radial_menu_choice/option = new()
	option.name = "取出 [limb.cavity_item]"
	option.info = "取出嵌在病人胸腔里的 [limb.cavity_item]。"
	option.image = get_generic_limb_radial_image(BODY_ZONE_CHEST)
	option.image.overlays += add_radial_overlays(limb.cavity_item)
	return option

/datum/surgery_operation/limb/undo_cavity_implant/state_check(obj/item/bodypart/chest/limb)
	if(limb.body_zone != BODY_ZONE_CHEST)
		return FALSE
	// unlike implant removal, don't show the surgery as an option unless something is actually implanted
	// it would stand to reason standard implants would be hidden from view (requires a search)
	// while cavity implants would be blatantly visible (no search necessary)
	if(isnull(limb.cavity_item))
		return FALSE
	return TRUE

/datum/surgery_operation/limb/undo_cavity_implant/on_preop(obj/item/bodypart/chest/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你开始从[FORMAT_LIMB_OWNER(limb)]中取出 [limb.cavity_item]……"),
		span_notice("[surgeon] 开始从[FORMAT_LIMB_OWNER(limb)]中取出 [limb.cavity_item]。"),
		span_notice("[surgeon] 开始从[FORMAT_LIMB_OWNER(limb)]中取出某样东西。"),
	)
	display_pain(limb.owner, "你感到[chinese_body_zone_display(limb.plaintext_zone)]传来剧烈的疼痛！")

/datum/surgery_operation/limb/undo_cavity_implant/on_success(obj/item/bodypart/chest/limb, mob/living/surgeon, obj/item/tool, list/operation_args)
	if(isnull(limb.cavity_item)) // something else could have removed it mid surgery?
		display_results(
			surgeon,
			limb.owner,
			span_warning("你在[FORMAT_LIMB_OWNER(limb)]里找不到可以取出的东西。"),
			span_warning("[surgeon] 在[FORMAT_LIMB_OWNER(limb)]里找不到可以取出的东西。"),
			span_warning("[surgeon] 在[FORMAT_LIMB_OWNER(limb)]里找不到可以取出的东西。"),
		)
		return

	var/obj/item/implant = limb.cavity_item
	limb.cavity_item = null
	limb.remove_surgical_state(SURGERY_CAVITY_WIDENED)
	display_results(
		surgeon,
		limb.owner,
		span_notice("你把 [implant] 从[FORMAT_LIMB_OWNER(limb)]里拉了出来。"),
		span_notice("[surgeon] 把 [implant] 从[FORMAT_LIMB_OWNER(limb)]里拉了出来！"),
		span_notice("[surgeon] 从[FORMAT_LIMB_OWNER(limb)]里拉出了某样东西！"),
	)
	display_pain(limb.owner, "你能感觉到 [implant.name] 正从你体内被拉出！")
	surgeon.put_in_hands(implant)
