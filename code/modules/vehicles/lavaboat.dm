// Boat
/obj/vehicle/ridden/lavaboat
	name = "熔岩船"
	desc = "一艘用于穿越熔岩的船。"
	icon = 'icons/obj/mining_zones/dragonboat.dmi'
	icon_state = "goliath_boat"
	icon_preview = 'icons/obj/fluff/previews.dmi'
	icon_state_preview = "boat"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	can_buckle = TRUE
	key_type = /obj/item/oar

/obj/vehicle/ridden/lavaboat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/lavaboat)

/obj/vehicle/ridden/lavaboat/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!key_type || is_key(inserted_key) || !is_key(tool))
		return NONE
	if(!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[tool] 似乎粘在你手上了！"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你把 [tool] 装到了 [src] 上。"))
	if(inserted_key) //just in case there's an invalid key
		inserted_key.forceMove(drop_location())
	inserted_key = tool
	return ITEM_INTERACT_SUCCESS

/obj/vehicle/ridden/lavaboat/examine_key_message()
	if(!key_type)
		return
	if(!inserted_key)
		return span_notice("手持船桨点击 [src] 即可将其装上。")
	else
		return span_notice("按住 Alt 点击 [src] 可卸下 [inserted_key]。")

/obj/item/oar
	name = "船桨"
	desc = "可别和研究部门追着你要的那种“矿”搞混了。"
	icon = 'icons/mob/rideables/vehicles.dmi'
	icon_state = "oar"
	inhand_icon_state = "oar"
	icon_angle = 45
	lefthand_file = 'icons/mob/inhands/items/lavaland_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/lavaland_righthand.dmi'
	force = 12
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/datum/crafting_recipe/oar
	name = "歌利亚骨船桨"
	result = /obj/item/oar
	reqs = list(/obj/item/stack/sheet/bone = 2)
	time = 1.5 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/boat
	name = "歌利亚皮船"
	result = /obj/vehicle/ridden/lavaboat
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	time = 5 SECONDS
	category = CAT_TOOLS

/obj/vehicle/ridden/lavaboat/plasma
	name = "等离子船"
	desc = "一艘用于穿越等离子流的船，不会让你冻成冰坨。"
	icon = 'icons/obj/mining_zones/dragonboat.dmi'
	icon_state = "goliath_boat"
	resistance_flags = FREEZE_PROOF
	can_buckle = TRUE

/datum/crafting_recipe/boat/plasma
	name = "北极熊皮船"
	result = /obj/vehicle/ridden/lavaboat/plasma
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3)

// Dragon Boat
/obj/item/ship_in_a_bottle
	name = "瓶中船"
	desc = "一艘装在瓶子里的小船。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "ship_bottle"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ship_in_a_bottle/attack_self(mob/user)
	to_chat(user, span_notice("你不确定他们是怎么把船装进这种瓶子里的，但你很确定该怎么把它弄出来。"))
	create_boat(get_turf(src))

/obj/item/ship_in_a_bottle/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if (!.) // Shatter when not caught
		create_boat(get_turf(src))

/obj/item/ship_in_a_bottle/proc/create_boat(drop_loc)
	playsound(drop_loc, 'sound/effects/glass/glassbr1.ogg', 100, TRUE)
	new /obj/vehicle/ridden/lavaboat/dragon(drop_loc)
	qdel(src)

/obj/vehicle/ridden/lavaboat/dragon
	name = "神秘之船"
	desc = "这艘船随你的意志移动，无需船桨。"
	icon_state = "dragon_boat"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	key_type = null

/obj/vehicle/ridden/lavaboat/dragon/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/lavaboat/dragonboat)

/obj/vehicle/ridden/lavaboat/dragon/examine(mob/user)
	. = ..()
	. += span_notice("用[EXAMINE_HINT("Alt点击")]摩擦龙鼻，即可将 [src] 变回瓶中之形。")

/obj/vehicle/ridden/lavaboat/dragon/click_alt(mob/user)
	balloon_alert(user, "正在把船装瓶……")
	if (!do_after(user, 2 SECONDS, src))
		return CLICK_ACTION_BLOCKING
	balloon_alert(user, "已把船装瓶！")
	var/obj/item/ship_in_a_bottle/bottled_ship = new(user.drop_location())
	user.put_in_hands(bottled_ship)
	qdel(src)
	return CLICK_ACTION_SUCCESS
