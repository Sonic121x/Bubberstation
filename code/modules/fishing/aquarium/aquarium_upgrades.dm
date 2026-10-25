
/// Aquarium upgrades, can be applied to a basic aquarium to upgrade it into an advanced subtype.
/obj/item/aquarium_upgrade
	name = "水族箱升级套件"
	desc = "一件升级件。"

	icon = 'icons/obj/aquarium/supplies.dmi'
	icon_state = "construction_kit"
	/// What kind of aquarium can accept this upgrade. Strict type check, no subtypes.
	var/upgrade_from_type = /obj/structure/aquarium
	/// typepath of the new aquarium subtype created.
	var/upgrade_to_type = /obj/structure/aquarium

/obj/item/aquarium_upgrade/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(interacting_with, TRAIT_IS_AQUARIUM))
		return NONE
	if(upgrade_from_type != interacting_with.type)
		interacting_with.balloon_alert(user, "类型不匹配的水族箱！")
		return ITEM_INTERACT_BLOCKING
	interacting_with.balloon_alert(user, "升级中……")
	if(!PERFORM_ALL_TESTS(aquarium_upgrade) && !do_after(user, 5 SECONDS, interacting_with))
		return ITEM_INTERACT_BLOCKING
	var/atom/movable/upgraded_aquarium = new upgrade_to_type(interacting_with.drop_location())
	//This should transfer all the fish, reagents and settings from the aquarium component
	interacting_with.TransferComponents(upgraded_aquarium)
	upgraded_aquarium.balloon_alert(user, "已升级")
	qdel(src)
	qdel(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/aquarium_upgrade/bioelec_gen
	name = "水族箱生物电套件"
	desc = "让水族箱利用生物电鱼能量所需的全部组件。"
	icon_state = "bioelec_kit"
	upgrade_to_type = /obj/structure/aquarium/bioelec_gen
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT)

/obj/structure/aquarium/bioelec_gen
	name = "生物电发电机"
	desc = "一种非传统的发电机，可以增强并收集生物电鱼产生的能量。"

	icon_state = "bioelec_map"
	base_icon_state = "bioelec"

	default_beauty = 0

/obj/structure/aquarium/bioelec_gen/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_BIOELECTRIC_GENERATOR, INNATE_TRAIT)

/obj/structure/aquarium/bioelec_gen/zap_act(power, zap_flags)
	var/explosive = zap_flags & ZAP_MACHINE_EXPLOSIVE
	if(!explosive)
		return //immune to all other shocks to make sure power can be generated without breaking the generator itself
	return ..()

/obj/structure/aquarium/bioelec_gen/examine(mob/user)
	. = ..()
	. += span_boldwarning("警告！警告！警告！")
	. += span_warning("发电机把里面鱼类的生物电势放大到了危险的程度。")
	. += span_notice("需要特斯拉线圈来收集这些被放大的能量……而且你还会想要一根接地棒来保护自己。")

/obj/item/aquarium_upgrade/bluespace_tank
	name = "蓝空间鱼缸套件"
	desc = "把你的便携鱼缸升级成无底的手持式水族箱所需的组件。"
	icon_state = "bluespace_kit"
	upgrade_from_type = /obj/item/fish_tank
	upgrade_to_type = /obj/item/fish_tank/bluespace
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT)

/obj/item/fish_tank/bluespace
	name = "蓝空间鱼缸"
	desc = "把笨重的房间式水族箱的全部容量，塞进了一个背包大小的长方体里。"
	icon_state = "fish_tank_bluespace_map"
	base_icon_state = "fish_tank_bluespace"
	w_class = WEIGHT_CLASS_NORMAL
	maximum_relative_size = INFINITY
	max_total_size = 2000
	slowdown_coeff = 0.15
	min_fluid_temp = MIN_AQUARIUM_TEMP
	max_fluid_temp = MAX_AQUARIUM_TEMP
	reagent_size = 6
