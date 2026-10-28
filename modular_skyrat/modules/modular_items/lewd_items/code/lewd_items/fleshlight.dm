/obj/item/clothing/sextoy/fleshlight
	name = "飞机杯"
	desc = "真是支奇怪的手电筒。"
	icon_state = "fleshlight_pink"
	base_icon_state = "fleshlight"
	inhand_icon_state = "fleshlight_pink"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_SMALL
	/// Current color of the toy, can be changed, affects sprite
	var/current_color = "pink"
	/// If the color of the toy has been changed before
	var/color_changed = FALSE
	/// A list of toy designs for use in the radial color choice menu
	var/static/list/fleshlight_designs
	slot_flags = NONE

/// Generates a list of toy colors (or designs) for use in the radial color choice menu
/obj/item/clothing/sextoy/fleshlight/proc/populate_fleshlight_designs()
	fleshlight_designs = list(
		"green" = image(icon = src.icon, icon_state = "[base_icon_state]_green"),
		"pink" = image(icon = src.icon, icon_state = "[base_icon_state]_pink"),
		"teal" = image(icon = src.icon, icon_state = "[base_icon_state]_teal"),
		"red" = image(icon = src.icon, icon_state = "[base_icon_state]_red"),
		"yellow" = image(icon = src.icon, icon_state = "[base_icon_state]_yellow"),
	)

/obj/item/clothing/sextoy/fleshlight/examine(mob/user)
	. = ..()
	if(!color_changed)
		. += span_notice("按住 Alt 点击可更换颜色。")

/obj/item/clothing/sextoy/fleshlight/Initialize(mapload)
	. = ..()
	update_icon()
	update_icon_state()
	if(!length(fleshlight_designs))
		populate_fleshlight_designs()

/obj/item/clothing/sextoy/fleshlight/create_moth_snack()
	return null

/obj/item/clothing/sextoy/fleshlight/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"
	inhand_icon_state = "[base_icon_state]_[current_color]"

/obj/item/clothing/sextoy/fleshlight/click_alt(mob/user)
	if(color_changed)
		return CLICK_ACTION_BLOCKING
	var/choice = chinese_skyrat_item_radial(user, src, fleshlight_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 36, require_near = TRUE)
	if(!choice)
		return CLICK_ACTION_BLOCKING
	current_color = choice
	update_icon()
	color_changed = TRUE
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/sextoy/fleshlight/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return
	if(target.stat == DEAD)
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做！"))
		return

	var/obj/item/organ/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
	if(!penis?.is_exposed())
		to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
		return

	var/message = (user == target) ? pick("一边抽插 [src]，一边极乐地呻吟",
			"让 [src] 在自己的阴茎上缓缓上下移动，快感使自己弯下了腰",
			"让 [src] 在自己的阴茎上移动，在快感中颤抖") \
		: pick("用 [src] 套住 [target] 的阴茎",
			"用 [src] 抽弄 [target]",
			"用 [src] 为 [target] 手淫，使其极乐地呻吟")

	if(prob(70))
		target.try_lewd_autoemote(pick("twitch_s", "moan", "blush"))
	target.adjust_arousal(6)
	target.adjust_pleasure(9)
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 70, 1, -1)

/obj/item/toy/plush/fleshlight/screws
	name = "螺丝总工毛绒玩偶"
	desc = "一个穿着总工程师制服的可爱蓝色蜥蜴人玩偶……掀起的裙摆露出已经润滑过的紧致阴部。"
	icon = 'modular_zubbers/icons/obj/toys/plushes.dmi'
	icon_state = "cescrewsplush"
	base_icon_state = "cescrewsplush"

/obj/item/toy/plush/fleshlight/screws/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击可将她遮好。")

/obj/item/toy/plush/fleshlight/screws/click_alt(mob/user)
	user.visible_message(span_notice("[user] 翻转 [src]，遮住了下方的孔洞。"), span_notice("你翻转 [src]，用她的小裙子将其遮好。"))
	playsound(user, 'sound/effects/blob/blobattack.ogg', 50, TRUE)
	var/obj/item/toy/plush/cescrewsplush/plushie = new(null)
	qdel(src)
	user.put_in_hands(plushie)
	return TRUE

/obj/item/toy/plush/fleshlight/attack(mob/living/carbon/human/target, mob/living/carbon/human/user)
	. = ..()
	if(!istype(target))
		return
	if(target.stat == DEAD)
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做！"))
		return

	var/obj/item/organ/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
	if(!penis?.is_exposed())
		to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
		return

	var/message = (user == target) ? pick("一边抽插 [src]，一边极乐地呻吟",
			"让 [src] 在自己的阴茎上缓缓上下移动，快感使自己弯下了腰",
			"让 [src] 在自己的阴茎上移动，在快感中颤抖") \
		: pick("用 [src] 套住 [target] 的阴茎",
			"用 [src] 抽弄 [target]",
			"用 [src] 为 [target] 手淫，使其极乐地呻吟")

	if(prob(70))
		target.try_lewd_autoemote(pick("twitch_s", "moan", "blush"))
	target.adjust_arousal(6)
	target.adjust_pleasure(9)
	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang4.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang5.ogg',
						'modular_skyrat/modules/modular_items/lewd_items/sounds/bang6.ogg'), 70, 1, -1)


/obj/item/clothing/sextoy/fleshlight/bluespace
	name = "蓝空间飞机杯"
	color_changed = TRUE
	current_color = "teal"
	desc = "内部结构以舰长的母亲为原型。"
	custom_premium_price = PAYCHECK_COMMAND * 10

/obj/item/clothing/sextoy/fleshlight/bluespace/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/effect_remover, \
		tip_text = "捕获杆体", \
		on_clear_callback = CALLBACK(src, PROC_REF(rod_johnson)), \
		effects_we_clear = list(/obj/effect/immovablerod)\
	)

/obj/item/clothing/sextoy/fleshlight/bluespace/proc/rod_johnson(obj/effect/immovablerod/target, mob/living/user)
	user.throw_at(get_step(user,target.dir),12,4)
	playsound(target, 'sound/effects/cartoon_sfx/cartoon_pop.ogg', 75, TRUE)
	target.audible_message(span_danger("你听到一声啪响！"))
