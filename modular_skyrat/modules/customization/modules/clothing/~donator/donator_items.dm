//Donator reward for UltramariFox
/obj/item/cigarette/khi
	name = "\improper 基楚花奇点香烟"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "khioff"
	icon_on = "khion"
	icon_off = "khioff"
	type_butt = /obj/item/cigbutt/khi
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/toxin/mindbreaker = 5)

/obj/item/cigbutt/khi
	icon = 'modular_skyrat/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khibutt"

/obj/item/storage/fancy/cigarettes/khi
	name = "\improper 基楚花奇点烟包"
	icon = 'modular_skyrat/master_files/icons/obj/cigarettes_khi.dmi'
	icon_state = "khi_cig_packet"
	base_icon_state = "khi_cig_packet"
	spawn_type = /obj/item/cigarette/khi

//Donator reward for Stonetear
/obj/item/hairbrush/switchblade
	name = "弹簧梳"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	icon_state = "switchblade"
	base_icon_state = "switchblade"
	desc = "一把锋利、可藏在身上、带弹簧的梳子。"
	hitsound = 'sound/items/weapons/genhit.ogg'
	resistance_flags = FIRE_PROOF
	var/extended = FALSE

/obj/item/hairbrush/switchblade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

///This is called when you transform it
/obj/item/hairbrush/switchblade/attack_self(mob/user, modifiers)
	extended = !extended
	icon_state = "switchblade[extended ? "_on" : ""]"

	playsound(user || src, 'sound/items/weapons/batonextend.ogg', 30, TRUE)


/// This makes it so you have to extend it.
/obj/item/hairbrush/switchblade/attack(mob/target, mob/user)
	if(!extended)
		to_chat(user, span_warning("先把它弹出来啊，笨蛋！"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(target.stat == DEAD)
		to_chat(user, span_warning("给一个根本感受不到的人梳头可没什么意义！"))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	brush(target, user)

	return COMPONENT_CANCEL_ATTACK_CHAIN


#define TURN_DIAL 		0
#define TAP_SCREEN		1
#define PRESS_KEYS		2
#define EXTEND_ANTENNA	3
#define SLAP_SIDE		4

/obj/item/donator/transponder
	name = "损坏的赫利安应答信标"
	desc = "赫利安人用来与母舰联络的设备，屏幕已经裂了，边缘也磨损了。这一台显然风光不再。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	icon_state = "transponder"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	var/datum/effect_system/basic/spark_spread/sparks
	var/current_state = TURN_DIAL
	var/next_activate = 0

/obj/item/donator/transponder/Initialize(mapload)
	. = ..()
	sparks = new(src, 2, FALSE)
	sparks.attach(src)
	sparks.start()

/obj/item/donator/transponder/Destroy()
	if(sparks)
		QDEL_NULL(sparks)
	return ..()

/obj/item/donator/transponder/attack_self(mob/user)
	if(QDELETED(src) || (next_activate > world.time))
		return FALSE

	add_fingerprint(user)

	switch(current_state)
		if(TURN_DIAL)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] 当 [user] 转动 \the [src] 侧面的红色旋钮时，它吐出一段加密的静电噪音，呜咽几声后归于沉寂。",
				"[icon2html(src, user)] 当你转动装置侧面的红色旋钮时，它吐出一段加密的静电噪音，呜咽几声后归于沉寂。",
				vision_distance=2)
			playsound(user, 'modular_skyrat/master_files/sound/effects/bab1.ogg', 100, TRUE)
			sparks.start()
			current_state = TAP_SCREEN
			next_activate = world.time + 20
			return
		if(TAP_SCREEN)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] 轻点 \the [src] 的屏幕，屏幕亮起并开始启动程序。\the [src] 显示出一条错误信息，随即关机。",
				"[icon2html(src, user)] 你轻点装置的屏幕，屏幕亮起并开始启动程序。装置显示出一条错误信息，随即关机。",
				vision_distance=2)
			playsound(user, 'modular_skyrat/master_files/sound/effects/platform_call.ogg', 100, TRUE)
			current_state = PRESS_KEYS
			next_activate = world.time + 20
			return
		if(PRESS_KEYS)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] 按了几个键，发出几声充满希望的哔声，随后一声刺耳的嗡鸣让 [src] 重归沉寂。",
				"[icon2html(src, user)] 你按了几个键，发出几声充满希望的哔声，随后一声刺耳的嗡鸣让装置重归沉寂。",
				vision_distance=2)
			sparks.start()
			playsound(user, 'modular_skyrat/master_files/sound/effects/gmalfunction.ogg', 100, TRUE)
			current_state = EXTEND_ANTENNA
			next_activate = world.time + 20
			return
		if(EXTEND_ANTENNA)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] 拉出 \the [src] 的天线，屏幕上出现了一条进度条，但怎么调整都到不了 100%。[user] 只好把天线收了回去。",
				"[icon2html(src, user)] 你拉出天线，屏幕上出现了一条进度条，但怎么调整都到不了 100%。你只好把天线收了回去。",
				vision_distance=2)
			current_state = SLAP_SIDE
			next_activate = world.time + 20
			return
		if(SLAP_SIDE)
			user.visible_message(
				"[icon2html(src, oviewers(2, user))] [user] 拍了拍 \the [src] 的侧面，它嗡鸣着苏醒过来，接着“咚”的一声又没了动静。",
				"[icon2html(src, user)] 你拍了拍装置的侧面，它嗡鸣着苏醒过来，接着“咚”的一声又没了动静。",
				vision_distance=2)
			playsound(user, 'modular_skyrat/master_files/sound/effects/hacked.ogg', 100, TRUE)
			sparks.start()
			current_state = TURN_DIAL
			next_activate = world.time + 110
			return
		else
			current_state = TURN_DIAL
			next_activate = world.time + 20
			return

#undef TURN_DIAL
#undef TAP_SCREEN
#undef PRESS_KEYS
#undef EXTEND_ANTENNA
#undef SLAP_SIDE

// Donation reward for SQNZTB
/obj/vehicle/ridden/wheelchair/hardlight
	name = "硬光轮椅"
	desc = "一台由硬光构成的轮椅，靠微型化的蓝空间技术推动。"
	alpha = 150 // Just to help differentiate it from a real wheelchair, and to show that it's a bit squishier.
	max_integrity = 10 //standard wheelchairs have 100, motorized 150
	/// The projector associated with this wheelchair.
	/// Only used so that we can remove this wheelchair from it when it gets destroyed.
	var/obj/item/holosign_creator/projector = null
	foldabletype = null


/obj/vehicle/ridden/wheelchair/hardlight/Initialize(mapload, source_projector)
	. = ..()
	if(source_projector)
		projector = source_projector
		LAZYADD(projector.signs, src)


/obj/vehicle/ridden/wheelchair/hardlight/Destroy()
	if(projector)
		LAZYREMOVE(projector.signs, src)
		projector = null

	return ..()

/obj/vehicle/ridden/wheelchair/hardlight/atom_destruction(damage_flag)
	visible_message(span_notice("[src] 随着硬光发射器被中断而闪烁、消失了"))
	qdel(src)
	return ..()

/obj/vehicle/ridden/wheelchair/hardlight/wrench_act(mob/living/user, obj/item/tool)
	return

/obj/vehicle/ridden/wheelchair/hardlight/post_unbuckle_mob()
	. = ..()

	visible_message(span_notice("[src] 随着硬光发射器断开而闪烁、消失了。"))
	qdel(src)


/obj/vehicle/ridden/wheelchair/hardlight/make_ridable()
	AddElement(/datum/element/ridable, /datum/component/riding/vehicle/wheelchair/hardlight)


// Custom riding component for this wheelchair, so that it behaves properly.
/datum/component/riding/vehicle/wheelchair/hardlight/driver_move(obj/vehicle/vehicle_parent, mob/living/user, direction)
	var/delay_multiplier = 6.7 // magic number from wheelchair code
	//setting speed divisor to 3. original formula from the motorized chair code is:
	//vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / speed
	//this makes it slightly slower than a motorized wheelchair with t1 parts.
	vehicle_move_delay = round(CONFIG_GET(number/movedelay/run_delay) * delay_multiplier) / 3
	return ..()


// The actual item they will be using.
/obj/item/holosign_creator/hardlight_wheelchair
	name = "硬光轮椅发射器"
	desc = "一台能投射出可乘坐但很脆弱的硬光轮椅的发射器。"
	icon_state = "signmaker_med"
	holosign_type = /obj/vehicle/ridden/wheelchair/hardlight
	max_signs = 1


/obj/item/holosign_creator/hardlight_wheelchair/examine(mob/user)
	. = ..()
	. += span_tinynoticeital("\n<i>手柄下面刻着些东西，你可以再查看一次凑近看看……</i>")


/obj/item/holosign_creator/hardlight_wheelchair/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>手柄下方刻着这样一段话：</i>\n")
	. += span_smallnoticeital("“我说过我会找到办法让这一切都轻松些。”——A.H.")

/obj/item/instrument/piano_synth/headphones/catear_headphone
	name = "猫耳耳机"
	desc = "奇点撕裂者乐队电吉他手黛米·加尔甘的周边。它高度可定制，甚至还带一条全息尾巴！"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/instrument/piano_synth/headphones/catear_headphone"
	post_init_icon_state = "catear_headphone"
	worn_icon = 'modular_skyrat/modules/GAGS/icons/head/catear_headphone.dmi'
	lefthand_file = 'modular_skyrat/modules/GAGS/icons/head/catear_headphone_inhand.dmi'
	righthand_file = 'modular_skyrat/modules/GAGS/icons/head/catear_headphone_inhand.dmi'
	inhand_icon_state = "catear_headphone"
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK
	var/catTailToggled = FALSE
	instrument_range = 1
	greyscale_colors = "#FFFFFF#FFFFFF"
	greyscale_config = /datum/greyscale_config/catear_headphone
	greyscale_config_worn = /datum/greyscale_config/catear_headphone/worn
	greyscale_config_inhand_left = /datum/greyscale_config/catear_headphone_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/catear_headphone_inhand_right
	flags_1 = IS_PLAYER_COLORABLE_1


/obj/item/instrument/piano_synth/headphones/catear_headphone/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/instrument/piano_synth/headphones/catear_headphone/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance('modular_skyrat/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_[song?.playing ? "on" : "off"]_emissive", src, alpha = src.alpha)
		if(catTailToggled)
			. += emissive_appearance('modular_skyrat/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_tail_on_emissive", src, alpha = src.alpha)
			icon_state = "catear_headphone_tail[song?.playing ? "_on" : null]"
		else
			icon_state = "catear_headphone[song?.playing ? "_on" : null]"

/obj/item/instrument/piano_synth/headphones/catear_headphone/click_alt(mob/user)
	catTailToggled = !catTailToggled
	user.update_worn_head()
	update_icon(UPDATE_OVERLAYS)
	return CLICK_ACTION_SUCCESS

/obj/item/instrument/piano_synth/headphones/catear_headphone/update_overlays()
	. = ..()
	. += emissive_appearance('modular_skyrat/modules/GAGS/icons/head/catear_headphone.dmi', "catearphones_obj_lights_emissive", src, alpha = src.alpha)
