/*
 * The 'fancy' path is for objects like donut boxes that show how many items are in the storage item on the sprite itself
 * .. Sorry for the shitty path name, I couldnt think of a better one.
 *
 * Contains:
 * Donut Box
 * Egg Box
 * Candle Box
 * Cigarette Box
 * Rolling Paper Pack
 * Cigar Case
 * Heart Shaped Box w/ Chocolates
 * Coffee condiments display
 */

/obj/item/storage/fancy
	icon = 'icons/obj/food/containers.dmi'
	abstract_type = /obj/item/storage/fancy
	resistance_flags = FLAMMABLE
	custom_materials = list(/datum/material/cardboard = SHEET_MATERIAL_AMOUNT)
	/// Used by examine to report what this thing is holding.
	var/contents_tag = "errors"
	/// What type of thing to fill this storage with.
	var/spawn_type
	/// How many of the things to fill this storage with.
	var/spawn_count = 0
	/// Whether the container is open, always open, or closed
	var/open_status = FANCY_CONTAINER_CLOSED
	/// What material do we get when we fold this box?
	var/foldable_result = /obj/item/stack/sheet/cardboard
	/// Whether it supports open and closed state icons.
	var/has_open_closed_states = TRUE

/obj/item/storage/fancy/PopulateContents()
	if(!spawn_type)
		return
	for(var/i = 1 to spawn_count)
		var/thing_in_box = pick(spawn_type)
		new thing_in_box(src)

/obj/item/storage/fancy/update_icon_state()
	icon_state = "[base_icon_state][has_open_closed_states && open_status ? contents.len : null]"
	return ..()

/obj/item/storage/fancy/examine(mob/user)
	. = ..()
	if(!open_status)
		return
	if(length(contents) == 1)
		. += "还剩一个[contents_tag]。"
	else
		. += "[contents.len <= 0 ? "没有剩余的" : "还剩 [contents.len] 个"][contents_tag]。"

/obj/item/storage/fancy/attack_self(mob/user)
	if(open_status == FANCY_CONTAINER_CLOSED)
		open_status = FANCY_CONTAINER_OPEN
	else if(open_status == FANCY_CONTAINER_OPEN)
		open_status = FANCY_CONTAINER_CLOSED

	update_appearance()
	. = ..()
	if(contents.len)
		return
	if(!foldable_result || (flags_1 & HOLOGRAM_1))
		return
	var/obj/item/result = new foldable_result(user.drop_location())
	balloon_alert(user, "已折叠")
	// Gotta delete first, so then the cardboard appears in the same hand
	qdel(src)
	user.put_in_hands(result)

/obj/item/storage/fancy/Exited(atom/movable/gone, direction)
	. = ..()
	if(open_status == FANCY_CONTAINER_CLOSED)
		open_status = FANCY_CONTAINER_OPEN
	update_appearance()

/obj/item/storage/fancy/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(open_status == FANCY_CONTAINER_CLOSED)
		open_status = FANCY_CONTAINER_OPEN
	update_appearance()

#define DONUT_INBOX_SPRITE_WIDTH 4

/*
 * Donut Box
 */

/obj/item/storage/fancy/donut_box
	name = "甜甜圈盒"
	desc = "嗯……甜甜圈。"
	icon = 'icons/obj/food/donuts.dmi'
	icon_state = "donutbox_open" //composite image used for mapping
	base_icon_state = "donutbox"
	spawn_type = /obj/item/food/donut/plain
	spawn_count = 6
	open_status = TRUE
	appearance_flags = KEEP_TOGETHER|LONG_GLIDE
	custom_premium_price = PAYCHECK_COMMAND * 1.75
	contents_tag = "甜甜圈"
	storage_type = /datum/storage/donut_box

/obj/item/storage/fancy/donut_box/PopulateContents()
	. = ..()
	update_appearance()

/obj/item/storage/fancy/donut_box/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][open_status ? "_inner" : null]"

/obj/item/storage/fancy/donut_box/update_overlays()
	. = ..()
	if(!open_status)
		return

	var/donuts = 0
	for(var/_donut in contents)
		var/obj/item/food/donut/donut = _donut
		if (!istype(donut))
			continue

		var/image/donut_image = image(icon = initial(icon), icon_state = donut.in_box_sprite())
		donut_image.pixel_w = donuts * DONUT_INBOX_SPRITE_WIDTH
		. += donut_image
		donuts += 1

	. += image(icon = initial(icon), icon_state = "[base_icon_state]_top")

#undef DONUT_INBOX_SPRITE_WIDTH

/*
 * Egg Box
 */

/obj/item/storage/fancy/egg_box
	icon = 'icons/obj/food/containers.dmi'
	inhand_icon_state = "eggbox"
	icon_state = "eggbox"
	base_icon_state = "eggbox"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	name = "蛋盒"
	desc = "用来装鸡蛋的纸盒。"
	spawn_type = /obj/item/food/egg
	spawn_count = 12
	contents_tag = "鸡蛋"
	storage_type = /datum/storage/egg_box

/*
 * Fertile Egg Box
 */

/obj/item/storage/fancy/egg_box/fertile
	name = "受精蛋盒"
	desc = "这盒子里只有一样东西能生育，反正不是这些蛋。"
	spawn_type = /obj/item/food/egg/fertile
	spawn_count = 6

/*
 * Candle Box
 */

/obj/item/storage/fancy/candle_box
	name = "蜡烛包"
	desc = "一包红色蜡烛。"
	icon = 'icons/obj/candle.dmi'
	icon_state = "candlebox5"
	base_icon_state = "candlebox"
	inhand_icon_state = null
	worn_icon_state = "cigpack"
	throwforce = 2
	slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/flashlight/flare/candle
	spawn_count = 5
	open_status = FANCY_CONTAINER_ALWAYS_OPEN
	contents_tag = "蜡烛"
	storage_type = /datum/storage/candle_box

////////////
//CIG PACK//
////////////
/obj/item/storage/fancy/cigarettes
	name = "\improper 太空牌香烟包"
	desc = "最受欢迎的香烟品牌，太空奥运会的赞助商。背面广告宣称，它是唯一能在太空真空中抽的品牌。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig"
	inhand_icon_state = "cigpacket"
	worn_icon_state = "cigpack"
	base_icon_state = "cig"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	slot_flags = ITEM_SLOT_BELT
	spawn_type = /obj/item/cigarette/space_cigarette
	spawn_count = 6
	custom_price = PAYCHECK_CREW
	age_restricted = TRUE
	contents_tag = "香烟"
	storage_type = /datum/storage/cigarette_box
	drop_sound = SFX_CIG_PACK_DROP
	pickup_sound = SFX_CIG_PACK_PICKUP
	throw_drop_sound = SFX_CIG_PACK_THROW_DROP
	sound_vary = TRUE

	///for cigarette overlay
	var/candy = FALSE
	/// Does this cigarette packet come with a coupon attached?
	var/spawn_coupon = TRUE
	/// For VV'ing, set this to true if you want to force the coupon to give an omen
	var/rigged_omen = FALSE
	///Do we not have our own handling for cig overlays?
	var/display_cigs = TRUE

/obj/item/storage/fancy/cigarettes/attack_self(mob/user)
	if(contents.len != 0 || !spawn_coupon)
		return ..()

	playsound(src, storage_type.rustle_sound, 50, TRUE)

	balloon_alert(user, "哦，免费优惠券")
	var/obj/item/coupon/attached_coupon = new
	user.put_in_hands(attached_coupon)
	attached_coupon.generate(rigged_omen ? COUPON_OMEN : null, null, user)
	attached_coupon = null
	spawn_coupon = FALSE
	name = "废弃的香烟包"
	desc = "一个背面被撕掉的旧香烟包，现在比一文不值还不值钱。"
	atom_storage.max_slots = 0

/obj/item/storage/fancy/cigarettes/Initialize(mapload)
	. = ..()

	register_context()
	if(!spawn_count)
		update_appearance()

/obj/item/storage/fancy/cigarettes/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(interacting_with != user) // you can quickly put a cigarette in your mouth only
		return ..()
	quick_remove_item(/obj/item/cigarette, user, equip_to_mouth = TRUE)

/obj/item/storage/fancy/cigarettes/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	quick_remove_item(/obj/item/cigarette, user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/storage/fancy/cigarettes/click_alt(mob/user)
	var/obj/item/lighter = locate(/obj/item/lighter) in contents
	if(lighter)
		quick_remove_item(lighter, user)
	else
		quick_remove_item(/obj/item/cigarette, user)
	return CLICK_ACTION_SUCCESS

/obj/item/storage/fancy/cigarettes/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(locate(/obj/item/lighter) in contents)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "取出打火机"
	context[SCREENTIP_CONTEXT_RMB] = "取出[contents_tag]"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/storage/fancy/cigarettes/examine(mob/user)
	. = ..()

	if(spawn_coupon)
		. += span_notice("烟包背面有一张优惠券！抽完后就可以把它撕下来。")

/obj/item/storage/fancy/cigarettes/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][contents.len ? null : "_empty"]"

/obj/item/storage/fancy/cigarettes/proc/open_icon_state()
	return "[icon_state]_open"

/obj/item/storage/fancy/cigarettes/update_overlays()
	. = ..()
	if(!open_status || !contents.len)
		return

	. += open_icon_state()

	if(!display_cigs)
		return

	var/cig_position = 1
	for(var/C in contents)
		var/use_icon_state = ""

		if(istype(C, /obj/item/lighter/greyscale))
			use_icon_state = "lighter_in"
		else if(istype(C, /obj/item/lighter))
			use_icon_state = "zippo_in"
		else if(candy)
			use_icon_state = "candy"
		else
			use_icon_state = "cigarette"

		. += "[use_icon_state]_[cig_position]"
		cig_position++

/obj/item/storage/fancy/cigarettes/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/dromedaryco
	name = "\improper 单峰驼公司香烟包"
	desc = "一包六支装进口单峰驼公司香烟。包装上贴着标签：“换一种慢一点的死法怎么样？”"
	icon_state = "dromedary"
	base_icon_state = "dromedary"
	spawn_type = /obj/item/cigarette/dromedary

/obj/item/storage/fancy/cigarettes/dromedaryco/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_uplift
	name = "\improper 提神柔顺香烟包"
	desc = "你最爱的品牌，现在推出薄荷口味。"
	icon_state = "uplift"
	base_icon_state = "uplift"
	spawn_type = /obj/item/cigarette/uplift

/obj/item/storage/fancy/cigarettes/cigpack_uplift/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_robust
	name = "\improper 强劲香烟包"
	desc = "强者之选。"
	icon_state = "robust"
	base_icon_state = "robust"
	spawn_type = /obj/item/cigarette/robust

/obj/item/storage/fancy/cigarettes/cigpack_robust/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_robustgold
	name = "\improper 强劲金牌香烟包"
	desc = "真正强者之选。"
	icon_state = "robustg"
	base_icon_state = "robustg"
	spawn_type = /obj/item/cigarette/robustgold

/obj/item/storage/fancy/cigarettes/cigpack_robustgold/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_greytide
	name = "\improper 维修素灰香烟包"
	desc = "那道细细的灰线。"
	icon_state = "greytide"
	base_icon_state = "greytide"
	spawn_type = /obj/item/cigarette/greytide

/obj/item/storage/fancy/cigarettes/cigpack_greytide/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_carp
	name = "\improper 经典鲤鱼香烟包"
	desc = "始于 2313 年。"
	icon_state = "carp"
	base_icon_state = "carp"
	spawn_type = /obj/item/cigarette/carp

/obj/item/storage/fancy/cigarettes/cigpack_carp/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_syndicate
	name = "香烟包"
	desc = "一个不知名的香烟品牌。"
	icon_state = "syndie"
	base_icon_state = "syndie"
	spawn_type = /obj/item/cigarette/syndicate

/obj/item/storage/fancy/cigarettes/cigpack_syndicate/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_midori
	name = "\improper 绿烟草香烟包"
	desc = "你看不懂上面的符文，但这包烟闻起来怪怪的。"
	icon_state = "midori"
	base_icon_state = "midori"
	spawn_type = /obj/item/cigarette/rollie/nicotine

/obj/item/storage/fancy/cigarettes/cigpack_midori/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_candy
	name = "\improper 小蒂米的第一包糖果烟"
	desc = "对吸烟犹豫不决？想安全地让孩子继承家族传统？看看这款特别包装！内含 100%* 无尼古丁糖果香烟。"
	icon_state = "candy"
	base_icon_state = "candy"
	contents_tag = "糖果香烟"
	spawn_type = /obj/item/cigarette/candy
	candy = TRUE
	age_restricted = FALSE

/obj/item/storage/fancy/cigarettes/cigpack_candy/Initialize(mapload)
	. = ..()
	if(prob(7))
		spawn_type = /obj/item/cigarette/candy/nicotine //uh oh!

/obj/item/storage/fancy/cigarettes/cigpack_candy/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_shadyjims
	name = "\improper 可疑吉姆超细香烟包"
	desc = "体重拖累了你吗？跑不过引力奇点？嘴停不下来？抽可疑吉姆超细，看着那些脂肪统统燃烧掉。保证有效！"
	icon_state = "shadyjim"
	base_icon_state = "shadyjim"
	spawn_type = /obj/item/cigarette/shadyjims

/obj/item/storage/fancy/cigarettes/cigpack_shadyjims/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_xeno
	name = "\improper 异形过滤香烟包"
	desc = "含有 100% 纯史莱姆，还有尼古丁。"
	icon_state = "slime"
	base_icon_state = "slime"
	spawn_type = /obj/item/cigarette/xeno

/obj/item/storage/fancy/cigarettes/cigpack_xeno/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_cannabis
	name = "\improper 怪胎兄弟特制香烟包"
	desc = "包装上的标签写着：“由菲尼亚斯、弗雷迪和富兰克林代言。”"
	icon_state = "midori"
	base_icon_state = "midori"
	spawn_type = /obj/item/cigarette/rollie/cannabis

/obj/item/storage/fancy/cigarettes/cigpack_cannabis/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker
	name = "\improper 利里之悦香烟包"
	desc = "在超过 36 个星系被禁。"
	icon_state = "shadyjim"
	base_icon_state = "shadyjim"
	spawn_type = /obj/item/cigarette/rollie/mindbreaker

/obj/item/storage/fancy/cigarettes/cigpack_mindbreaker/empty
	spawn_count = 0
	spawn_coupon = FALSE
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/flash_powder
	spawn_type = /obj/item/cigarette/flash_powder

/obj/item/storage/fancy/rollingpapers
	name = "卷烟纸包"
	desc = "一包纳米传讯牌卷烟纸。"
	w_class = WEIGHT_CLASS_TINY
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig_paper_pack"
	base_icon_state = "cig_paper_pack"
	contents_tag = "卷烟纸"
	spawn_type = /obj/item/rollingpaper
	spawn_count = 10
	custom_price = PAYCHECK_LOWER
	has_open_closed_states = FALSE
	storage_type = /datum/storage/rolling_paper_pack

/obj/item/storage/fancy/rollingpapers/Initialize(mapload)
	. = ..()

	if(!spawn_count)
		update_appearance()

/obj/item/storage/fancy/rollingpapers/update_overlays()
	. = ..()
	if(!contents.len)
		. += "[base_icon_state]_empty"

/obj/item/storage/fancy/rollingpapers/empty
	spawn_count = 0

/////////////
//CIGAR BOX//
/////////////

/obj/item/storage/fancy/cigarettes/cigars
	name = "\improper 高级雪茄盒"
	desc = "一盒高级雪茄。非常昂贵。"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cigarcase"
	base_icon_state = "cigarcase"
	w_class = WEIGHT_CLASS_NORMAL
	contents_tag = "高级雪茄"
	storage_type = /datum/storage/cigar_box
	spawn_type = /obj/item/cigarette/cigar/premium
	spawn_count = 5
	spawn_coupon = FALSE
	display_cigs = FALSE

/obj/item/storage/fancy/cigarettes/cigars/update_icon_state()
	. = ..()
	//reset any changes the parent call may have made
	icon_state = base_icon_state

/obj/item/storage/fancy/cigarettes/cigars/empty
	spawn_count = 0
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigars/update_overlays()
	. = ..()
	if(!open_status)
		return
	var/cigar_position = 1 //generate sprites for cigars in the box
	for(var/obj/item/cigarette/cigar/smokes in contents)
		. += "[smokes.icon_off]_[cigar_position]"
		cigar_position++

/obj/item/storage/fancy/cigarettes/cigars/cohiba
	name = "\improper 高希霸罗布图雪茄盒"
	desc = "一盒进口高希霸雪茄，以浓烈风味闻名。"
	icon_state = "cohibacase"
	base_icon_state = "cohibacase"
	spawn_type = /obj/item/cigarette/cigar/cohiba

/obj/item/storage/fancy/cigarettes/cigars/cohiba/empty
	spawn_count = 0
	open_status = FANCY_CONTAINER_OPEN

/obj/item/storage/fancy/cigarettes/cigars/havana
	name = "\improper 高级哈瓦那雪茄盒"
	desc = "一盒优雅的哈瓦那雪茄。"
	icon_state = "havanacase"
	base_icon_state = "havanacase"
	spawn_type = /obj/item/cigarette/cigar/havana


/obj/item/storage/fancy/cigarettes/cigars/havana/open_icon_state()
	return "cohibacase_open"

/obj/item/storage/fancy/cigarettes/cigars/havana/empty
	spawn_count = 0
	open_status = FANCY_CONTAINER_OPEN

/*
 * Heart Shaped Box w/ Chocolates
 */

/obj/item/storage/fancy/heart_box
	name = "心形盒"
	desc = "用来装小巧巧克力的心形盒子。"
	icon = 'icons/obj/food/containers.dmi'
	inhand_icon_state = "chocolatebox"
	icon_state = "chocolatebox"
	base_icon_state = "chocolatebox"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	contents_tag = "巧克力"
	spawn_type = list(
		/obj/item/food/bonbon,
		/obj/item/food/bonbon/chocolate_truffle,
		/obj/item/food/bonbon/caramel_truffle,
		/obj/item/food/bonbon/peanut_truffle,
		/obj/item/food/bonbon/peanut_butter_cup,
	)
	spawn_count = 8
	storage_type = /datum/storage/heart_box

/obj/item/storage/fancy/nugget_box
	name = "鸡块盒"
	desc = "用来装小鸡块的纸板盒。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "nuggetbox"
	base_icon_state = "nuggetbox"
	inhand_icon_state = "nuggetbox"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	contents_tag = "鸡块"
	w_class = WEIGHT_CLASS_SMALL
	spawn_type = /obj/item/food/nugget
	spawn_count = 7
	storage_type = /datum/storage/nugget_box

/obj/item/storage/fancy/nugget_box/Initialize(mapload)
	. = ..()
	// It's a safe place for the Fryish/Fritterish
	AddElement(/datum/element/fish_safe_storage)

/obj/item/storage/fancy/nugget_box/red
	name = "红色鸡块盒"
	icon_state = "rednuggetbox"
	base_icon_state = "rednuggetbox"
	inhand_icon_state = "rednuggetbox"

/obj/item/storage/fancy/wing_box
	name = "红色鸡翅盒"
	desc = "用来装鸡翅的纸板盒。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "redwingbox5"
	base_icon_state = "redwingbox"
	inhand_icon_state = "redwingbox"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	contents_tag = "鸡翅"
	w_class = WEIGHT_CLASS_SMALL
	spawn_type = /obj/item/food/fried_chicken
	spawn_count = 5
	storage_type = /datum/storage/wing_box
	open_status = FANCY_CONTAINER_ALWAYS_OPEN

/obj/item/storage/fancy/fry_box
	name = "红色薯条盒"
	desc = "用来装薯条的纸板盒。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "redfrybox2"
	base_icon_state = "redfrybox"
	inhand_icon_state = "redfrybox"
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	contents_tag = "薯条"
	w_class = WEIGHT_CLASS_SMALL
	spawn_type = /obj/item/food/fries
	spawn_count = 2
	storage_type = /datum/storage/fry_box
	open_status = FANCY_CONTAINER_ALWAYS_OPEN

/*
 * Jar of pickles
 */

/obj/item/storage/fancy/pickles_jar
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "pickles"
	base_icon_state = "pickles"
	name = "腌黄瓜"
	desc = "用来装腌黄瓜的罐子。"
	spawn_type = /obj/item/food/pickle
	spawn_count = 10
	contents_tag = "腌黄瓜"
	foldable_result = /obj/item/reagent_containers/cup/beaker/large
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.25)
	open_status = FANCY_CONTAINER_ALWAYS_OPEN
	has_open_closed_states = FALSE
	storage_type = /datum/storage/pickles_jar

/obj/item/storage/fancy/pickles_jar/update_icon_state()
	. = ..()
	if(!contents.len)
		icon_state = "[base_icon_state]_empty"
	else
		if(contents.len < 5)
			icon_state = "[base_icon_state]_[contents.len]"
		else
			icon_state = base_icon_state

/*
 * Coffee condiments display
 */

/obj/item/storage/fancy/coffee_condi_display
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "coffee_condi_display"
	base_icon_state = "coffee_condi_display"
	name = "咖啡调料展示盒"
	desc = "一个整洁的小木盒，装着你最爱的各种咖啡调料。"
	contents_tag = "咖啡调料"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT/2)
	resistance_flags = FLAMMABLE
	foldable_result = /obj/item/stack/sheet/mineral/wood
	open_status = FANCY_CONTAINER_ALWAYS_OPEN
	has_open_closed_states = FALSE
	storage_type = /datum/storage/coffee_condi_display

/obj/item/storage/fancy/coffee_condi_display/update_overlays()
	. = ..()
	var/has_sugar = FALSE
	var/has_sweetener = FALSE
	var/has_creamer = FALSE
	var/has_chocolate = FALSE

	for(var/thing in contents)
		if(istype(thing, /obj/item/reagent_containers/condiment/pack/sugar))
			has_sugar = TRUE
		else if(istype(thing, /obj/item/reagent_containers/condiment/pack/astrotame))
			has_sweetener = TRUE
		else if(istype(thing, /obj/item/reagent_containers/condiment/creamer))
			has_creamer = TRUE
		else if(istype(thing, /obj/item/reagent_containers/condiment/chocolate))
			has_chocolate = TRUE

	if (has_sugar)
		. += "condi_display_sugar"
	if (has_sweetener)
		. += "condi_display_sweetener"
	if (has_creamer)
		. += "condi_display_creamer"
	if (has_chocolate)
		. += "condi_display_chocolate"

/obj/item/storage/fancy/coffee_condi_display/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/condiment/pack/sugar(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/condiment/pack/astrotame(src)
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/condiment/creamer(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/condiment/chocolate(src)
	update_appearance()
