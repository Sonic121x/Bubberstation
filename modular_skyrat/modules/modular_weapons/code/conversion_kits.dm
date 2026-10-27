/obj/item/crafting_conversion_kit
	name = "基础改装套件"
	desc = "一套不知作何用途的零件。这东西不应该出现在这里，你最好把它扔掉，因为它没什么用处。"
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "secbox"
	// the inhands are just what the box uses
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

/obj/item/crafting_conversion_kit/mosin_pro
	name = "\improper 希豪“联合”步枪改装套件"
	desc = "制造“联合”步枪所需的全套零件，但不包含让枪真正能开火的那些部件。\
		这些东西看起来能装在旧萨赫诺步枪上，要是你手边正好有一把就好了。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/cases.dmi'
	icon_state = "xhihao_conversion_kit"

/datum/crafting_recipe/mosin_pro
	name = "将萨赫诺改装为希豪“联合”"
	desc = "给萨赫诺更换枪托其实很简单，谁都能做。\
	只需要约三十秒和一把螺丝刀。"
	result = /obj/item/gun/ballistic/rifle/boltaction/sporterized/empty
	reqs = list(
		/obj/item/gun/ballistic/rifle/boltaction = 1,
		/obj/item/crafting_conversion_kit/mosin_pro = 1
	)
	steps = list(
		"清空步枪弹药",
		"保持枪机打开"
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 30 SECONDS
	category = CAT_WEAPON_RANGED
	crafting_flags = parent_type::crafting_flags | CRAFT_COLLECT_REQUIREMENTS

/datum/crafting_recipe/mosin_pro/New()
	. = ..()
	LAZYOR(blacklist, subtypesof(/obj/item/gun/ballistic/rifle/boltaction) - list(/obj/item/gun/ballistic/rifle/boltaction/surplus))

/datum/crafting_recipe/mosin_pro/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/rifle/boltaction/the_piece = collected_requirements[/obj/item/gun/ballistic/rifle/boltaction][1]
	if(!the_piece.bolt_locked)
		return FALSE
	if(LAZYLEN(the_piece.magazine.stored_ammo))
		return FALSE
	return ..()

/obj/item/crafting_conversion_kit/voskhod_refit
	name = "\improper 旭日无动力装甲MOD改装套件"
	desc = "一个金属箱，装有各种管线、传感器和备用材料，可将旭日装甲的部件重新用于制造下一代MOD模块化外骨骼版本。"
	force = 10
	icon = 'modular_zubbers/icons/misc/refitkit.dmi'
	icon_state = "refit_kit"
