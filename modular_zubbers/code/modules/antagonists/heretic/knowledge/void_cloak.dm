/datum/heretic_knowledge/void_cloak
	desc = "让你能将一块玻璃碎片、一条床单和任意外套（如护甲或西装外套）\
		转化为虚空斗篷。放下兜帽时，斗篷能保护你抵御太空环境。\
		戴起兜帽时，斗篷会伪装成装备背带。它还提供不错的护甲，\
		口袋可以装下一把你的刀刃、各种仪式材料（如器官）和小型异教饰品。"

/obj/item/clothing/suit/hooded/cultrobes/void
	hood_up_affix = ""

/obj/item/clothing/suit/hooded/cultrobes/void/make_invisible(datum/source, obj/item/item, slot)
	if(isliving(loc))
		loc.remove_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), REF(src))
		REMOVE_TRAIT(loc, TRAIT_RESISTLOWPRESSURE, REF(src))
		loc.balloon_alert(loc, "斗篷已隐藏")
		loc.visible_message(span_notice("光线在[loc]周围变幻，将其斗篷化作别的东西……"))

	name = /obj/item/clothing/suit/misc/suit_harness::name
	desc = /obj/item/clothing/suit/misc/suit_harness::desc
	icon = /obj/item/clothing/suit/misc/suit_harness::icon
	icon_state = /obj/item/clothing/suit/misc/suit_harness::icon_state
	worn_icon = /obj/item/clothing/suit/misc/suit_harness::worn_icon
	worn_icon_state = /obj/item/clothing/suit/misc/suit_harness::worn_icon_state

	update_appearance()
	update_slot_icon()

/obj/item/clothing/suit/hooded/cultrobes/void/make_visible(datum/source, obj/item/item, slot)
	if(isliving(loc))
		loc.add_traits(list(TRAIT_RESISTLOWPRESSURE, TRAIT_RESISTCOLD), REF(src))
		loc.balloon_alert(loc, "斗篷已显现")
		loc.visible_message(span_notice("万花筒般的色彩在[loc]周围收拢，一件斗篷突然出现在其身上！"))

	name = initial(src.name)
	desc = initial(src.desc)
	icon = initial(src.icon)
	icon_state = initial(src.icon_state)
	worn_icon = initial(src.worn_icon)
	worn_icon_state = initial(src.worn_icon_state)

	update_appearance()
	update_slot_icon()

/obj/item/clothing/suit/hooded/cultrobes/void/examine(mob/user)
	. = ..()

	if (hood_up && IS_HERETIC(user))
		. += span_notice("这是一件目前处于隐藏状态的[EXAMINE_HINT("虚空斗篷")]。")
