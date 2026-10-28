/obj/item/gun/ballistic/automatic/pistol
	name = "\improper 马卡洛夫手枪"
//	desc = "A small, easily concealable 9mm handgun. Has a threaded barrel for suppressors."	// SKYRAT EDIT: Original
	desc = "一款小巧、易于隐蔽携带的 9x25mm Mk.12 手枪。枪管带螺纹，可安装消音器。"	// SKYRAT EDIT: Calibre rename
	icon_state = "pistol"
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm
	can_suppress = TRUE
	burst_size = 1
	fire_delay = 0 SECONDS
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	dry_fire_sound = 'sound/items/weapons/gun/pistol/dry_fire.ogg'
	suppressed_sound = 'sound/items/weapons/gun/pistol/shot_suppressed.ogg'
	load_sound = 'sound/items/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/items/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/items/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/items/weapons/gun/pistol/mag_release.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/drop_small.ogg'
	drop_sound = 'sound/items/handling/gun/ballistics/pistol/pistol_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/pistol/pistol_pickup1.ogg'
	fire_sound_volume = 90
	bolt_wording = "套筒"
	suppressor_x_offset = 10
	suppressor_y_offset = -1
	recoil_backtime_multiplier = 1

/obj/item/gun/ballistic/automatic/pistol/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/fire_mag
	spawn_magazine_type = /obj/item/ammo_box/magazine/m9mm/fire

/obj/item/gun/ballistic/automatic/pistol/contraband

/obj/item/gun/ballistic/automatic/pistol/contraband/Initialize(mapload)
	if(prob(10))
		pin = pick(
		list(
			/obj/item/firing_pin/clown,
			/obj/item/firing_pin/clown/ultra,
			/obj/item/firing_pin/clown/ultra/selfdestruct,
		))
	. = ..()
	pin.pin_removable = FALSE


/obj/item/gun/ballistic/automatic/pistol/suppressed/Initialize(mapload)
	. = ..()
	var/obj/item/suppressor/S = new(src)
	install_suppressor(S)

/obj/item/gun/ballistic/automatic/pistol/clandestine
	name = "\improper 安瑟姆手枪"
	desc = "马卡洛夫的精神续作，也可能只是有人把枪掉进了一桶油漆里。该枪口径为 10mm。"
	icon_state = "pistol_evil"
	accepted_magazine_type = /obj/item/ammo_box/magazine/m10mm
	empty_indicator = TRUE
	suppressor_x_offset = 12

/obj/item/gun/ballistic/automatic/pistol/clandestine/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "安瑟姆由斯卡伯勒军火公司制造，被视为市面上最好的副武器之一。后坐力极小 \
		而停止作用强大，让它成为已知空间各地雇佣兵的钟爱之物。<br> \
		<br>\
		得益于流线型外形带来的隐蔽便利，它理所当然地赢得了“走私客首选之枪”的名号。尽管 \
		太空海盗团体往往更青睐纳米传讯制造的 HDS-1，因为维护成本低，但安瑟姆在 \
		雇佣兵、杀手与谍报人员中仍有大量使用。顺旋星区各地的证物柜里堆着几十支缴获的安瑟姆手枪。其中许多都有着 \
		漫长而血腥的经历，来自在地下犯罪圈子里服役的岁月。" \
	)

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher
	name = "\improper 安瑟姆/SC 手枪"
	desc = "安瑟姆的改装型号，也是马卡洛夫的精神续作，配有一体式消音器，握把上另有一个按钮式扳机， \
	用于击发下挂式干扰器，操作方式与独立的 SC/FISHER 类似。口径为 10mm。"
	desc_controls = "右键使用下挂干扰器。每次自行充能之间最多可射击两发。"
	icon_state = "pistol_evil_fisher"
	suppressed = SUPPRESSED_QUIET
	can_suppress = FALSE
	can_unsuppress = FALSE
	var/obj/item/gun/energy/recharge/fisher/underbarrel

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/energy/recharge/fisher(src)

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "安瑟姆/SC 是斯卡伯勒军火公司为自己出品的安瑟姆手枪打造的整套改装方案，专为那些“执行行动的”特勤人员设计， \
		尤其适合用来对付喜欢玩灯泡的人。<br>\
		<br>\
		套筒被截短，手枪前半部围绕枪管集成了一只整体式消音器， \
		枪管组件下方则装有一台紧凑型动能光干扰器。一体式消音器的设计既不影响 \
		弹道性能，也不影响手枪的隐蔽性，最终造就了一把出人意料地坚固可靠的枪械。<br>\
		<br>\
		斯卡伯勒军火公司从未真正回应过有关其参与改装和/或制造 \
		SC/FISHER 或类似干扰武器一事的指控。特此提醒有意向的行动人员：动能光干扰器并不会对目标造成实体伤害。<br>\
		<br>\
		买家自慎。" \
	)

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		underbarrel.try_fire_gun(target, user, params)
		return
	return ..()

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(QDELETED(target))
		return
	var/obj/projectile/energy/fisher/melee/simulated_hit = new
	simulated_hit.firer = user
	simulated_hit.on_hit(target)

/obj/item/gun/ballistic/automatic/pistol/clandestine/fisher/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(.)
		return
	var/obj/projectile/energy/fisher/melee/simulated_hit = new
	simulated_hit.firer = throwingdatum?.get_thrower()
	simulated_hit.on_hit(hit_atom)

/obj/item/gun/ballistic/automatic/pistol/m1911 //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	name = "\improper M1911"
	desc = "一款经典的 .45 手枪，弹匣容量较小。"
	icon_state = "m1911"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m45
	can_suppress = FALSE
	fire_sound = 'sound/items/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/pistol/m1911/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "柯尔特 M1911 由约翰·摩西·勃朗宁在几个世纪前创造，是现代自动火器的鼻祖。 \
		不知为何，直到今天仍有军官拒绝使用任何非“上帝口径”的枪械。<br>\
		<br>\
		却没什么人愿意告诉这些人：.45 ACP 已经快五个世纪都无法击穿现代弹道防板了。<br>\
		<br>\
		你非常确信眼前这一把是本十年内车出来的。如今野外见到的大多数 M1911 都是用现代合金与制造工艺 \
		仿制、面向消费市场量产的产品。但这并不妨碍骗子们 \
		声称自己的枪是“传家宝”，曾让他们在各种他们坚称自己参加过的冲突中活下来。" \
	)

/**
 * Weak 1911 for syndicate chimps. It comes in a 4 TC kit.
 * 15 damage every.. second? 7 shots to kill. Not fast.
 */
/obj/item/gun/ballistic/automatic/pistol/m1911/chimpgun
	name = "\improper CH1M911"
	desc = "献给四处奔波的黑帮猴子。使用 .45 弹药，还带着一股明显的香蕉味。"
	projectile_damage_multiplier = 0.5
	projectile_wound_bonus = -12
	pin = /obj/item/firing_pin/monkey

/obj/item/gun/ballistic/automatic/pistol/m1911/chimpgun/add_deep_lore()
	return

/obj/item/gun/ballistic/automatic/pistol/m1911/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "\improper 沙漠之鹰"
	desc = "一款坚固耐用的 .50 AE 手枪。"
	icon_state = "deagle"
	force = 14
	accepted_magazine_type = /obj/item/ammo_box/magazine/m50
	can_suppress = FALSE
	mag_display = TRUE
	fire_sound = 'sound/items/weapons/gun/rifle/shot.ogg'
	rack_sound = 'sound/items/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/items/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/pistol/deagle/contraband

/obj/item/gun/ballistic/automatic/pistol/deagle/contraband/Initialize(mapload)
	if(prob(10))
		pin = pick(
		list(
			/obj/item/firing_pin/clown,
			/obj/item/firing_pin/clown/ultra,
			/obj/item/firing_pin/clown/ultra/selfdestruct,
		))
	. = ..()
	pin.pin_removable = FALSE

/obj/item/gun/ballistic/automatic/pistol/deagle/gold
	desc = "一支由火星高级枪匠反复折叠一百万次制成的镀金沙漠之鹰。使用 .50 AE 弹药。"
	icon_state = "deagleg"
	inhand_icon_state = "deagleg"

/obj/item/gun/ballistic/automatic/pistol/deagle/camo
	desc = "为“执行行动的”行动人员打造的沙鹰牌沙鹰。使用 .50 AE 弹药。"
	icon_state = "deaglecamo"
	inhand_icon_state = "deagleg"
	// SKYRAT EDIT - We don't actually have the right icons for this. When you add the icons you can remove this line!
	show_bolt_icon = FALSE
	// SKYRAT EDIT END

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	name = "\improper 皇家秃鹫"
	desc = "与沙漠之鹰不同，这把武器似乎采用了某种先进的内部稳定系统，能显著 \
		降低后坐感并提升整体精度，代价是使用更小的口径。 \
		这让它能打出非常迅速的两发点射。口径为 .45。"
	icon_state = "reagle"
	inhand_icon_state = "deagleg"
	burst_size = 2
	burst_delay = 1
	projectile_damage_multiplier = 1.25
	accepted_magazine_type = /obj/item/ammo_box/magazine/r45
	actions_types = list(/datum/action/item_action/toggle_firemode)
	obj_flags = UNIQUE_RENAME // if you did the sidequest, you get the customization
	custom_materials = list(/datum/material/gold = SHEET_MATERIAL_AMOUNT * 20, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 15, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/telecrystal = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/gun/ballistic/automatic/pistol/deagle/regal/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/deagle/regal/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "虎爪会是猛虎合作社的“屠戮武装”之一，据说这批遗物武器是在一场狂乱的异象中由 \
		上帝交予马丁森的，用以对信仰的敌人施以神圣报应。这些枪几乎全是原始样式的复制品。这一把也不 \
		例外。然而，它仍带着原版火器的一部分庄重气息。还有人说，也带着它当年屠戮邪教敌人时所施的神圣威能。<br>\
		<br>\
		你正看着这件遗物武器，这意味着两种情况之一。<br>\
		<br>\
		A) 一位猛虎合作社的传道者已经死了，死在他们以上帝之名发动血腥屠杀之前或之中。或者 <br>\
		<br>\
		B) 你就是那位传道者，而且很快就要给这把枪的黑暗历史再添一章。" \
	)

/obj/item/gun/ballistic/automatic/pistol/aps
	name = "\improper 斯捷奇金 APS 全自动手枪"
	desc = "一款老式苏联全自动手枪的现代化复刻品。射速很快，但后坐力大得像被骡子踢。使用 9mm 弹药。枪管带螺纹，可安装消音器。" //SKYRAT EDIT
	icon_state = "aps"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m9mm_aps
	can_suppress = TRUE
	burst_size = 3
	burst_delay = 3 //SKYRAT EDIT - Original: 1
	spread = 10
	actions_types = list(/datum/action/item_action/toggle_firemode)
	suppressor_x_offset = 6

/obj/item/gun/ballistic/automatic/pistol/stickman
	name = "平面枪"
	desc = "一把二维的枪……什么？"
	icon_state = "flatgun"
	mag_display = FALSE
	show_bolt_icon = FALSE

/obj/item/gun/ballistic/automatic/pistol/stickman/equipped(mob/user, slot)
	..()
	to_chat(user, span_notice("你正想摆弄 [src]，它却从你手中滑了出去……"))
	if(prob(50))
		to_chat(user, span_notice("……然后从你视野中消失了！它到底跑哪去了？"))
		qdel(src)
		user.update_icons()
	else
		to_chat(user, span_notice("……然后掉回视野里。呼，好险。"))
		user.dropItemToGround(src)

#define DOORHICKEY_GUN_MIN_DAMAGE 70
#define DOORHICKEY_GUN_MAX_DAMAGE 140

/obj/item/gun/ballistic/automatic/pistol/doohickey
	name = "\improper 解放者"
	desc = "一把粗制滥造的 3D 打印“枪”，只能发射一发。"
	icon_state = "doorhickey"
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5)
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	casing_ejector = FALSE
	force = 10
	max_integrity = 100
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/doorhickey
	can_suppress = FALSE
	semi_auto = FALSE
	show_bolt_icon = FALSE
	projectile_damage_multiplier = 0.5
	spread = 10

/obj/item/gun/ballistic/automatic/pistol/doohickey/unload_ammo(mob/living/user, forced = FALSE)
	if (forced)
		return ..()

	balloon_alert(user, "正在拧下枪管……")
	playsound(user, 'sound/items/tools/screwdriver_operating.ogg', 75, FALSE, MEDIUM_RANGE_SOUND_EXTRARANGE)
	if (!do_after(user, 2 SECONDS, src))
		balloon_alert(user, "被打断了！")
		return
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/doohickey/load_gun(obj/item/ammo, mob/living/user)
	. = ..()
	if (!.)
		return

	balloon_alert(user, "正在拧上枪管……")
	playsound(user, 'sound/items/tools/screwdriver_operating.ogg', 75, FALSE, MEDIUM_RANGE_SOUND_EXTRARANGE)
	if (do_after(user, 2 SECONDS, src))
		return TRUE

	balloon_alert(user, "被打断了！")
	unload_ammo(user, forced = TRUE)
	return FALSE

/obj/item/gun/ballistic/automatic/pistol/doohickey/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	var/dmg_multiplier = 1

	if (get_dist(target, user) <= 1)
		dmg_multiplier *= 2

	if (isliving(target))
		var/mob/living/victim = target
		var/datum/status_effect/grouped/heldup/gunpoint = victim.has_status_effect(/datum/status_effect/grouped/heldup)
		if (gunpoint)
			for (var/datum/weakref/pointer_ref as anything in gunpoint.sources)
				if (pointer_ref.resolve() == user)
					dmg_multiplier *= 1.5 // Caps at 60 damage
					break

	projectile_damage_multiplier *= dmg_multiplier
	. = ..()
	projectile_damage_multiplier /= dmg_multiplier

/obj/item/gun/ballistic/automatic/pistol/doohickey/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
	. = ..()
	if (!.)
		return

	var/damage_to_take = rand(DOORHICKEY_GUN_MIN_DAMAGE, DOORHICKEY_GUN_MAX_DAMAGE)
	if (atom_integrity > damage_to_take)
		take_damage(damage_to_take)
		return

	playsound(loc, SFX_SHATTER, 75, TRUE)
	if (loc != user)
		take_damage(damage_to_take)
		return

	var/shrapnel_bomb = FALSE
	var/obj/item/bodypart/arm/poor_sod = user.get_active_hand()
	if (prob(damage_to_take - atom_integrity) && poor_sod)
		shrapnel_bomb = TRUE

	user.visible_message(span_danger("[src] 炸成了碎片[shrapnel_bomb ? "，其中一块扎进了 [user] 的[user.parse_zone_with_bodypart(poor_sod.body_zone)]" : ""]！"),
		span_userdanger("[src] 炸成了碎片[shrapnel_bomb ? "，其中一块扎进了你的[poor_sod]！" : ""]！"),
		span_hear("你能听到塑料碎裂的声音。"))

	if (poor_sod)
		poor_sod.receive_damage((damage_to_take - atom_integrity) * 0.5, wound_bonus = -10, exposed_wound_bonus = 20, sharpness = SHARP_EDGED, damage_source = src)
	else
		user.take_bodypart_damage((damage_to_take - atom_integrity) * 0.5, wound_bonus = -10, exposed_wound_bonus = 20, sharpness = SHARP_EDGED)

	if (shrapnel_bomb)
		var/obj/item/shrapnel/plastic/shrapnel = new(user.loc)
		if (!shrapnel.force_embed(user, poor_sod))
			qdel(shrapnel)
		else if(!HAS_TRAIT(user, TRAIT_ANALGESIA))
			user.emote("scream")

	new /obj/effect/decal/cleanable/plastic(get_turf(src))
	take_damage(damage_to_take)

/obj/item/gun/ballistic/automatic/pistol/doohickey/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "据数字史学家称，“解放者”图纸最早被发到 NTNet 上一个边缘图像论坛上。帖子里附着一个如今已失效的 \
		托管服务链接，发帖者鼓动论坛成员去下载并“欣赏”这个设计。线程作者在帖中 \
		首先描述了自己对纳米传讯“精英”中所谓“月人”的刻骨仇恨，并称借助“那酱料”，他们 \
		看到了一个“终结露娜折磨者压迫”的办法。于是他们把它称作“解放者”。<br>\
		<br>\
		起初，帖子里的回应多是坛友对这种 3D 图纸的怀疑。许多人指出，这样一把枪用廉价塑料和 \
		极少的机加工零件、经无膛线枪管发射高压弹药，功能本身就存疑，更别提安全操作。但紧接着， \
		一篇由《顺旋鸽报》——顺旋星区一家颇受尊敬的评论刊物——发表的文章让这个帖子突然 \
		热度飙升。文章作者回忆说，在新莫斯科一个格外清冷的日子里，他们看到三名下班的纳米传讯助手 \
		正试图用作者形容为“古怪塑料小玩意儿”的东西近距离射一只老鼠。那骇人的后果，以及那只受惊却安然 \
		无恙的老鼠的照片，让许多人试图查明这几名如今落下残疾的助手是从哪儿弄到这种荒唐玩意儿的。帖子由此传开，作者 \
		在论坛其他版块对自己痛恨之敌的持续荒诞咆哮也随之传开。<br>\
		<br>\
		消息传开后，线程作者立刻回归，声称常逛这个图像论坛的人“偷走”了他们的“自由之梦”， \
		并称月人显然是想借这场公关闹剧来抹黑他们的发明。这番声明之后，作者又发表了一通满是污言秽语的谩骂， \
		最终导致论坛管理员介入，永久关闭了该线程。" \
	)

/obj/item/disk/design_disk/liberator
	name = "非法 3D 打印机设计磁盘"
	blueprints = list(/datum/design/liberator_gun)

#undef DOORHICKEY_GUN_MIN_DAMAGE
#undef DOORHICKEY_GUN_MAX_DAMAGE
