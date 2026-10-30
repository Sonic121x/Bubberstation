///Special neckwear that kills its wearer if triggered, by either its specific remote or assemblies.
/obj/item/clothing/neck/collar_bomb
	name = "项圈炸弹"
	desc = "某种笨重的项圈，里面装的炸药刚好够炸掉一个人的脑袋……至少标签正面是这么写的。"
	icon_state = "collar_bomb"
	icon = 'icons/obj/clothing/neck.dmi'
	inhand_icon_state = "reverse_bear_trap"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	armor_type = /datum/armor/collar_bomb
	equip_delay_self = 6 SECONDS
	equip_delay_other = 8 SECONDS
	///The button it's associated with
	var/obj/item/collar_bomb_button/button
	///Whether the collar countdown has been triggered.
	var/active = FALSE

/datum/armor/collar_bomb
	fire = 97
	bomb = 97
	acid = 97

/obj/item/clothing/neck/collar_bomb/Initialize(mapload, obj/item/collar_bomb_button/button)
	. = ..()
	src.button = button
	button?.collar = src
	set_wires(new /datum/wires/collar_bomb(src))
	AddElement(/datum/element/cuffable_item)

/obj/item/clothing/neck/collar_bomb/Destroy()
	button?.collar = null
	button = null
	return ..()

/obj/item/clothing/neck/collar_bomb/create_moth_snack()
	return null

/obj/item/clothing/neck/collar_bomb/examine(mob/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_NECK) == src)
		return
	. += span_tinynotice("它有一个可以互动的 [EXAMINE_HINT("线路")] 面板……")

/obj/item/clothing/neck/collar_bomb/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!is_wire_tool(tool))
		return ..()

	wires.interact(user)
	return ITEM_INTERACT_SUCCESS

/obj/item/clothing/neck/collar_bomb/equipped(mob/user, slot, initial = FALSE)
	. = ..()
	if(slot == ITEM_SLOT_NECK)
		ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/clothing/neck/collar_bomb/dropped(mob/user, silent = FALSE)
	. = ..()
	REMOVE_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)

/obj/item/clothing/neck/collar_bomb/proc/explosive_countdown(ticks_left)
	active = TRUE
	if(ticks_left > 0)
		playsound(src, 'sound/items/timer.ogg', 30, FALSE)
		balloon_alert_to_viewers("[ticks_left]")
		ticks_left--
		addtimer(CALLBACK(src, PROC_REF(explosive_countdown), ticks_left), 1 SECONDS)
		return

	playsound(src, 'sound/effects/snap.ogg', 75, TRUE)
	if(!ishuman(loc))
		balloon_alert_to_viewers("哑弹……")
		active = FALSE
		return
	var/mob/living/carbon/human/brian = loc
	if(brian.get_item_by_slot(ITEM_SLOT_NECK) != src)
		balloon_alert_to_viewers("哑弹……")
		active = FALSE
		return
	visible_message(span_warning("[src] 起爆了，直接把 [brian] 的头炸飞了！"), span_hear("你听到一声肉体炸裂的闷响！"))
	playsound(src, SFX_EXPLOSION, 30, TRUE)
	brian.apply_damage(200, BRUTE, BODY_ZONE_HEAD)
	var/obj/item/bodypart/head/myhead = brian.get_bodypart(BODY_ZONE_HEAD)
	myhead?.dismember()
	brian.investigate_log("已被 [src] 斩首。", INVESTIGATE_DEATHS)
	flash_color(brian, flash_color = COLOR_RED, flash_time = 1 SECONDS)
	qdel(src)

///The button that detonates the collar.
/obj/item/collar_bomb_button
	name = "黄色大按钮"
	desc = "它看起来像一个大红色按钮，只不过是黄色的。它配有沉重的扳机，以防误触。"
	icon = 'icons/obj/devices/assemblies.dmi'
	icon_state = "bigyellow"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	///The collar bomb it's associated with.
	var/obj/item/clothing/neck/collar_bomb/collar

/obj/item/collar_bomb_button/attack_self(mob/user)
	. = ..()
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return
	balloon_alert_to_viewers("正在按下按钮……")
	if(!do_after(user, 1.2 SECONDS, target = src))
		return
	playsound(user, 'sound/machines/click.ogg', 25, TRUE)
	if(!collar|| collar.active)
		return
	collar.explosive_countdown(ticks_left = 5)
	if(!ishuman(collar.loc))
		return
	var/mob/living/carbon/human/brian = collar.loc
	if(brian.get_item_by_slot(ITEM_SLOT_NECK) == collar)
		brian.investigate_log("的 [collar] 被 [user] 通过黄色按钮触发了。", INVESTIGATE_DEATHS)


/obj/item/collar_bomb_button/Destroy()
	collar?.button = null
	collar = null
	return ..()
