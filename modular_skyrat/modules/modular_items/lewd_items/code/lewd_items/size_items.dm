/obj/item/clothing/neck/size_collar
	name = "体型调节项圈"
	desc = "一条亮黑色项圈，内置科技可让使用者改变自身体型。"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_black"
	kink_collar = TRUE
	/// Have we given the user the warning message yet?
	var/warning_given = FALSE
	/// The `temporary_size` component we have attached to the wearer.
	var/datum/component/temporary_size/size_component
	/// What size do we want to set the wearer to when they wear the collar?
	var/target_size = 1

/obj/item/clothing/neck/size_collar/attack_self(mob/user, modifiers)
	. = ..()
	if(!warning_given)
		if(tgui_alert(user, "此物品仅限在宿舍内用于情色角色扮演。违规使用将受到管理员处理。你要继续使用吗？", "使用警告", list("是", "否")) != "是")
			return FALSE

		warning_given = TRUE

	var/chosen_size = tgui_input_number(user, "要将项圈的体型百分比设为多少？", name, 100, CONFIG_GET(number/size_collar_maximum), CONFIG_GET(number/size_collar_minimum))
	if(!chosen_size)
		balloon_alert(user, "体型数值无效！")
		return FALSE

	log_message("[usr] 将 [src] 的目标体型改为 [chosen_size]%", LOG_ATTACK)
	balloon_alert(user, "已设为 [chosen_size]%")
	target_size = (chosen_size * 0.01)
	return TRUE

/obj/item/clothing/neck/size_collar/mob_can_equip(mob/living/user, slot, disable_warning, bypass_equip_delay_self, ignore_equipped, indirect_action)
	if(!warning_given)
		return FALSE

	return ..()

/obj/item/clothing/neck/size_collar/equipped(mob/living/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot & ITEM_SLOT_NECK))
		return FALSE

	size_component = user.AddComponent(/datum/component/temporary_size, target_size)
	size_component.target_size = target_size

	user.log_message("[user] 装备了 [src]。", LOG_ATTACK)

/obj/item/clothing/neck/size_collar/dropped(mob/living/user)
	. = ..()
	if(size_component)
		qdel(size_component)
		size_component = null

/obj/item/clothing/neck/size_collar/examine(mob/user)
	. = ..()
	var/list/area_names = list()
	for(var/area_index in SIZE_WHITELISTED_AREAS) //We can't do this typed.
		var/area/area_type = area_index //So we have to assign it to a typed variable after we get it from the loop.
		var/area_name = initial(area_type.name)
		if(!area_name)
			continue

		area_names += chinese_area_display(area_name)

	if(length(area_names))
		. += span_cyan("此项圈可在以下区域生效：[jointext(area_names, "、")]")

	return .

/// Component that temporarily applies a size to a human.
/datum/component/temporary_size
	/// List containing the areas that the size change works in. If this is empty, this will work everywhere.
	var/list/allowed_areas = SIZE_WHITELISTED_AREAS
	/// What is the stored size of the mob using this?
	var/original_size = 1
	/// What size are we changing the parent mob to?
	var/target_size = 1

/datum/component/temporary_size/Initialize(size_to_apply)
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/carbon/human/human_parent = parent
	original_size = human_parent.current_size

	if(!original_size) //If we aren't able to get the original size, we shouldn't exist.
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ENTER_AREA, PROC_REF(check_area))

	target_size = size_to_apply
	check_area()

/// Checks if we need to revert our size when entering a different area.
/datum/component/temporary_size/proc/check_area()
	var/area/current_area = get_area(parent)
	if(!length(allowed_areas) || is_type_in_list(current_area, allowed_areas))
		apply_size(target_size)
		return TRUE

	apply_size(original_size)
	return FALSE

/// Adjusts the sprite size of the parent mob based off `size_to_apply`.
/datum/component/temporary_size/proc/apply_size(size_to_apply)
	var/mob/living/carbon/human/human_parent = parent
	var/current_size = human_parent.current_size
	if(!human_parent || !size_to_apply || (current_size == size_to_apply))
		return FALSE

	human_parent.update_transform(size_to_apply / current_size)
	return TRUE

/datum/component/temporary_size/Destroy(force, silent)
	apply_size(original_size)

	UnregisterSignal(parent, COMSIG_ENTER_AREA)

	return ..()
