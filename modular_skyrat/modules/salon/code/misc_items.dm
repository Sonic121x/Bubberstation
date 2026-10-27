
/obj/item/storage/box/lipsticks
	name = "口红盒"

/obj/item/storage/box/lipsticks/PopulateContents()
	..()
	new /obj/item/lipstick(src)
	new /obj/item/lipstick/purple(src)
	new /obj/item/lipstick/jade(src)
	new /obj/item/lipstick/black(src)

/obj/item/lipstick/quantum
	name = "量子口红"

/obj/item/lipstick/quantum/display_radial_menu(mob/living/carbon/human/user)
	lipstick_color = tgui_color_picker(
		user,
		"选择口红颜色",
		null,
		COLOR_WHITE,
	)
	update_appearance()
	. = ..()

/obj/item/hairbrush/comb
	name = "梳子"
	desc = "用于梳理头发、解开打结发丝的简单工具。"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "blackcomb"

/obj/item/hairstyle_preview_magazine
	name = "潮流发型杂志"
	desc = "介绍各式各样发型的杂志！"

/obj/item/hairstyle_preview_magazine/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	// A simple GUI with a list of hairstyles and a view, so people can choose a hairstyle!

/obj/effect/decal/cleanable/hair
	name = "碎发"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "cut_hair"

/obj/item/razor
	name = "电动剃刀"
	desc = "剃须科学孕育出的最新、最棒的电动剃刀。"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "razor"
	inhand_icon_state = null
	obj_flags = CONDUCTS_ELECTRICITY
	w_class = WEIGHT_CLASS_TINY
	sound_vary = FALSE
	// How long do we take to shave someone's (facial) hair?
	var/shaving_time = 5 SECONDS

/obj/item/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user]卸下剃刀护罩，开始给自己剃毛！看起来是在自杀！"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/razor/proc/shave(mob/living/carbon/human/target_human, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		target_human.set_facial_hairstyle("Shaved", update = TRUE)
	else
		target_human.set_hairstyle("Bald", update = TRUE)

	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)


/obj/item/razor/attack(mob/attacked_mob, mob/living/user)
	if(!ishuman(attacked_mob))
		return ..()

	var/mob/living/carbon/human/target_human = attacked_mob
	var/location = user.zone_selected
	var/obj/item/bodypart/head/noggin = target_human.get_bodypart(BODY_ZONE_HEAD)
	var/static/list/head_zones = list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)

	if(!noggin && (location in head_zones))
		to_chat(user, span_warning("[target_human]没有头！"))
		return

	if(!(location in head_zones) && !user.combat_mode)
		to_chat(user, span_warning("你停下来，低头看看手里的东西，心想：“这东西大概应该用在头发或胡须上。”"))
		return

	if(location == BODY_ZONE_PRECISE_MOUTH)
		if(!(noggin.head_flags & HEAD_FACIAL_HAIR))
			to_chat(user, span_warning("没有胡须可剃！"))
			return

		var/covering = target_human.is_mouth_covered()
		if(covering)
			to_chat(user, span_warning("[covering]挡住了！"))
			return

		if(HAS_TRAIT(target_human, TRAIT_SHAVED))
			to_chat(user, span_warning("[target_human]已经被剃得太干净了。真的是一根毛都不剩了。"))
			return

		if(target_human.facial_hairstyle == "Shaved")
			to_chat(user, span_warning("已经剃干净了！"))
			return

		var/self_shaving = target_human == user // Shaving yourself?
		user.visible_message(span_notice("[user]开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃毛。"), \
			span_notice("你开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃毛……"))

		if(do_after(user, shaving_time, target = target_human))
			user.visible_message(span_notice("[user]用[src]给[self_shaving ? "自己" : "[target_human]"]剃干净了毛发。"), \
				span_notice("你用[src]给[self_shaving ? "自己" : "[target_human]"]剃完了毛发。又快又干净！"))

			shave(target_human, location)

	else if(location == BODY_ZONE_HEAD)
		if(!(noggin.head_flags & HEAD_HAIR))
			to_chat(user, span_warning("没有头发可剃！"))
			return

		if(!target_human.is_location_accessible(location))
			to_chat(user, span_warning("头部装备挡住了！"))
			return

		if(target_human.hairstyle == "Bald" || target_human.hairstyle == "Balding Hair" || target_human.hairstyle == "Skinhead")
			to_chat(user, span_warning("剩下的头发太少，没法剃了！"))
			return

		if(HAS_TRAIT(target_human, TRAIT_SHAVED))
			to_chat(user, span_warning("[target_human]已经被剃得太干净了。真的是一根毛都不剩了。"))
			return

		var/self_shaving = target_human == user // Shaving yourself?
		user.visible_message(span_notice("[user]开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃毛。"), \
			span_notice("你开始用[src]给[self_shaving ? "自己" : "[target_human]"]剃毛……"))

		if(do_after(user, shaving_time, target = target_human))
			user.visible_message(span_notice("[user]用[src]给[self_shaving ? "自己" : "[target_human]"]剃干净了毛发。"), \
				span_notice("你用[src]给[self_shaving ? "自己" : "[target_human]"]剃完了毛发。又快又干净！"))

			shave(target_human, location)

		return

	return ..()

/obj/structure/sign/barber
	name = "理发店招牌"
	desc = "发光的红、蓝、白条纹，一眼就能认出来！"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "barber"
	buildable_sign = FALSE // Don't want them removed, they look too jank.

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/barber, 13)

/obj/structure/sign/barber/Initialize(mapload)
	. = ..()
	if(mapload)
		find_and_mount_on_atom()

/obj/structure/sign/barber/get_turfs_to_mount_on()
	return list(get_step(src, dir))
