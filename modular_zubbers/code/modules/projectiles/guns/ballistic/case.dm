/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp
	name = "\improper NT22-HCS“执法者”箱"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntusp/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ntusp(src)
	new /obj/item/ammo_box/magazine/recharge/ntusp(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5
	name = "\improper NT22-HCS-MP“枪骑兵”箱"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield
	name = "\improper DAP NT22-HCS-MP“枪骑兵”箱"
	desc = "一只厚实的枪箱，内部衬有泡沫凹槽，可稳妥地放置武器、弹匣和装备。箱顶有一块银色铭牌，上面刻着一个盾牌标志，并用粗体字写着 D.A.P.。"

/obj/item/storage/toolbox/guncase/skyrat/pistol/ntmp5/blueshield/PopulateContents()
	new /obj/item/gun/ballistic/automatic/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5(src)
	new /obj/item/ammo_box/magazine/recharge/ntmp5/laser(src)
	new /obj/item/suppressor(src)
	new /obj/item/paper/fluff/ntmp5_message(src)

/obj/item/paper/fluff/ntmp5_message
	name = "来自朋友的消息"
	default_raw_text = {"特工：
<br>
这座空间站比报告里写的还要糟糕。如果你还没察觉，很快也会明白的。
总之，DAP 里有人觉得你最好带上合适的装备再去。就当这是一份好意吧。
这是一把“枪骑兵”，NT22-HCS-MP。.22HL，电池供弹。其中两个弹匣发射低致命弹丸。至于红色的那个，这么说吧，它们的致命性要高得多。
箱子里还附赠一个消音器。我想它的用处不言自明。
保持警惕。
<br>
-*资产保护部的一位朋友*"}

/// Odds that the Aniolek's second ammo box is armour piercing rather than plain lethal
#define ANIOLEK_ARMOR_PIERCING_CHANCE 15
/// How many spare magazines a magazine fed pick comes packed with
#define SZOT_CASE_SPARE_MAGAZINES 2
/// Extra mines beyond the one the radial already handed over, for four in total
#define SZOT_CASE_SPARE_MINES 3

/// A line apiece for the radial menu, so the quartermaster knows what they are choosing between
GLOBAL_LIST_INIT(szot_case_blurbs, list(
	/obj/item/gun/ballistic/automatic/lanca/jastrzab = "一把装有名为 \
		“智能漂移控制”功能的“骑枪”原型枪。你依然会为前妻黯然神伤，但你的准头正在变好！",
	/obj/item/gun/ballistic/revolver/aniolek = "一把发射 \
		.310 弹的怪物级五发警官左轮。失败不是选项；显然，低调也不是。警告：你必须至少重 \
		20 公斤才能安全地使用此武器",
	/obj/item/melee/energy/sword/opor = "一把近乎全新品相的 CIN 能量剑，来自还没人弄明白如何让它无限运转的年代。由可更换电池供电，\
		与它为之打造的那些人一样桀骜不驯，\
		毫不妥协。",
	/obj/item/minespawner/straznik = "四枚可重复使用的能量地雷，经过精心设计，可向未经授权的人员送去 \
		“电热劝退”……或者送给任何你忘了 \
		提醒的人。",
))

// The QM's mystery war trophy. Swipe vault access, pick one Szot gun, live with your choice.

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory
	name = "\improper 绍特动力公司枪箱"
	desc = "一只破旧的武器箱，军需官坚称它来自“那场战争”，却拒绝说明究竟是哪场战争。令人费解的是，安保部门并不追究他们持有这件武器。"
	icon = 'modular_zubbers/icons/obj/szot_case.dmi'
	icon_state = "case_szot"
	req_access = list(ACCESS_VAULT)
	weapon_to_spawn = null
	extra_to_spawn = null
	/// Is the case's lock still engaged
	var/case_locked = TRUE
	/// Has a weapon been picked from the case yet
	var/gun_chosen = FALSE
	/// Guns offered by the case, associated to the magazine that comes with them (null for the Bobr, it gets shell boxes instead)
	/// Whether the lock has been forced open
	var/lock_broken = FALSE
	/// Cosmetic damage tally. The case is genuinely indestructible, so nothing here is real integrity;
	/// it exists so the case can complain convincingly and so the lock has something to give way to.
	var/scuffing = 0

	var/static/list/weapon_choices = list(
		/obj/item/gun/ballistic/automatic/lanca/jastrzab = /obj/item/ammo_box/magazine/lanca/extended,
		/obj/item/gun/ballistic/revolver/aniolek = null,
		/obj/item/melee/energy/sword/opor = null,
		/obj/item/minespawner/straznik = null,
	)

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/PopulateContents()
	return

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/Initialize(mapload)
	. = ..()
	atom_storage.set_locked(STORAGE_FULLY_LOCKED)
	atom_storage.max_slots = 6 // a gun, its ammunition, and the beret, with room to shuffle
	max_integrity = 250
	integrity_failure = 0.4
	resistance_flags |= INDESTRUCTIBLE
	atom_storage.max_total_storage = 16
	atom_storage.set_holdable(list(
		/obj/item/ammo_box,
		/obj/item/gun/ballistic/automatic/lanca,
		/obj/item/gun/ballistic/automatic/miecz,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman,
		/obj/item/gun/ballistic/automatic/pistol/plasma_thrower,
		/obj/item/gun/ballistic/automatic/wylom,
		/obj/item/gun/ballistic/revolver/aniolek,
		/obj/item/gun/ballistic/revolver/shotgun_revolver,
		/obj/item/clothing/head/beret/szot_surplus,
		/obj/item/melee/energy/sword/opor,
		/obj/item/minespawner/straznik,
		/obj/item/stock_parts/capacitor,
		/obj/item/stock_parts/power_store/cell,
	))
	// set_holdable rebuilds this from initial(name), and the abstract ammo box's name is a placeholder
	atom_storage.can_hold_description = "绍特动力公司的武器、它们的弹药，以及一顶饱经风霜的贝雷帽"
	register_context()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(isnull(held_item) || lock_broken || isnull(held_item.GetID()))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = case_locked ? "用证件解锁" : "用证件上锁"
	return CONTEXTUAL_SCREENTIP_SET

/// The case never actually loses integrity. It keeps its own tally of the beating instead, reports
/// that as though it were real damage, and pops its lock when the tally gets high enough. Until a
/// weapon has been chosen there is nothing inside to spill, so it must never be destroyed outright.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()
	if(isnull(damage_amount) || damage_amount <= 0)
		return
	scuffing += damage_amount
	if(scuffing < max_integrity)
		return
	scuffing = 0
	break_lock()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/examine(mob/user)
	. = ..()
	if(lock_broken)
		. += span_notice("锁似乎已经坏了。")
	else if(!case_locked && !gun_chosen)
		. += span_notice("再次举起武器的时刻到了……你到底在这东西里藏了把什么枪？")
	var/wear = (scuffing / max_integrity) * 100
	switch(wear)
		if(1 to 25)
			. += "它看起来有点磨损。"
		if(25 to 60)
			. += "它看起来略有损坏。"
		if(60 to 90)
			. += "它看起来损坏严重。"
		if(90 to INFINITY)
			. += span_warning("它快散架了！")

/// Forces the lock and leaves the case intact
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/break_lock()
	if(lock_broken)
		return
	lock_broken = TRUE
	case_locked = FALSE
	playsound(src, 'sound/effects/structure_stress/pop3.ogg', 60, TRUE)
	atom_storage.set_locked(gun_chosen ? STORAGE_NOT_LOCKED : STORAGE_FULLY_LOCKED)
	update_appearance()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/update_icon()
	. = ..()
	if(opened)
		return
	if(lock_broken)
		icon_state = "[initial(icon_state)]-broken"
		return
	if(case_locked)
		return
	icon_state = "[initial(icon_state)]_unlocked"

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	var/obj/item/card/id/id_card = tool.GetID()
	if(isnull(id_card))
		return NONE
	if(!check_access(id_card))
		balloon_alert(user, "拒绝访问！")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 30, TRUE)
		return ITEM_INTERACT_BLOCKING
	if(!case_locked && opened)
		balloon_alert(user, "先合上盖子！")
		return ITEM_INTERACT_BLOCKING
	if(lock_broken)
		balloon_alert(user, "锁已损坏！")
		return ITEM_INTERACT_BLOCKING
	case_locked = !case_locked
	// the storage itself only opens up once something has actually been put in it
	atom_storage.set_locked(case_locked || !gun_chosen ? STORAGE_FULLY_LOCKED : STORAGE_NOT_LOCKED)
	if(case_locked)
		atom_storage.hide_contents(user)
	balloon_alert(user, case_locked ? "箱子已上锁" : "箱子已解锁")
	playsound(src, 'sound/machines/click.ogg', 40, TRUE)
	update_icon()
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/attack_hand_secondary(mob/user, list/modifiers)
	if(!gun_chosen)
		balloon_alert(user, "它纹丝不动！")
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	return ..()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/attack_self(mob/user)
	if(case_locked)
		balloon_alert(user, "它锁着呢！")
		return
	if(!gun_chosen)
		choose_weapon(user)
		return
	return ..()

/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/click_alt(mob/user)
	if(case_locked)
		balloon_alert(user, "它锁着呢！")
		return CLICK_ACTION_BLOCKING
	if(!gun_chosen)
		balloon_alert(user, "先选一件武器！")
		return CLICK_ACTION_BLOCKING
	return ..()

/// Offers the user a radial menu of the case's guns, then unpacks the case around their choice
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/choose_weapon(mob/user)
	var/list/radial_options = list()
	var/list/name_to_path = list()
	for(var/obj/item/gun_path as anything in weapon_choices)
		var/gun_name = initial(gun_path.name)
		if(ispath(gun_path, /obj/item/minespawner/straznik))
			gun_name = "守卫者能量地雷包"
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(gun_path.icon), icon_state = initial(gun_path.icon_state))
		option.info = span_boldnotice(GLOB.szot_case_blurbs[gun_path])
		radial_options[gun_name] = option
		name_to_path[gun_name] = gun_path

	var/choice = show_radial_menu(user, src, radial_options, require_near = TRUE, tooltips = TRUE)
	if(!choice || gun_chosen || QDELETED(src))
		return
	if(!user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return

	gun_chosen = TRUE
	atom_storage.set_locked(STORAGE_NOT_LOCKED)
	// it comes with the case, whatever you pick
	new /obj/item/clothing/head/beret/szot_surplus(src)
	// tallied so maintainers can see which option actually gets picked round to round
	SSblackbox.record_feedback("tally", "szot_case_choice", 1, "[choice]")
	user.log_message("从[src]中选择了[choice]", LOG_GAME)

	var/obj/item/picked_gun = name_to_path[choice]
	new picked_gun(src)

	var/magazine_path = weapon_choices[picked_gun]
	if(magazine_path)
		for(var/spare in 1 to SZOT_CASE_SPARE_MAGAZINES)
			new magazine_path(src)
	else if(ispath(picked_gun, /obj/item/gun/ballistic/revolver/aniolek))
		unpack_strilka()
	else if(ispath(picked_gun, /obj/item/melee/energy/sword/opor))
		return
	else if(ispath(picked_gun, /obj/item/minespawner/straznik))
		unpack_mines()
	else
		unpack_shells()

	balloon_alert(user, "箱子已拆开")
	atom_storage.show_contents(user)

/// A mine on its own is no use, so the case hands over a working set of four
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_mines()
	for(var/spare in 1 to SZOT_CASE_SPARE_MINES)
		new /obj/item/minespawner/straznik(src)

/// The Aniolek ships with two boxes of .310, one of which is occasionally the good stuff.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_strilka()
	new /obj/item/ammo_box/c310_cargo_box(src)
	if(prob(ANIOLEK_ARMOR_PIERCING_CHANCE))
		new /obj/item/ammo_box/c310_cargo_box/piercing(src)
	else
		new /obj/item/ammo_box/c310_cargo_box(src)

/// The Bobr feeds from shell boxes instead of magazines. One guaranteed beanbag box,
/// one box of workhorse lethals, and one surprise from the bottom of the crate.
/obj/item/storage/toolbox/guncase/skyrat/szot_warstory/proc/unpack_shells()
	new /obj/item/ammo_box/advanced/s12gauge/bean(src)

	var/workhorse_box = pick_weight(list(
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 5,
		/obj/item/ammo_box/advanced/s12gauge = 5,
		/obj/item/ammo_box/advanced/s12gauge/hunter = 2,
		/obj/item/ammo_box/advanced/s12gauge/frangible = 1,
		/obj/item/ammo_box/advanced/s12gauge/flechette = 1,
	))
	new workhorse_box(src)

	var/sleeper_box = pick_weight(list(
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 6,
		/obj/item/ammo_box/advanced/s12gauge = 4,
		/obj/item/ammo_box/advanced/s12gauge/flechette = 3,
		/obj/item/ammo_box/advanced/s12gauge/honkshot = 2,
		/obj/item/ammo_box/advanced/s12gauge/incendiary = 2,
		/obj/item/ammo_box/advanced/s12gauge/dragonsbreath = 2,
		/obj/item/ammo_box/advanced/s12gauge/laser = 2,
		/obj/item/ammo_box/advanced/s12gauge/pulse = 2,
	))
	new sleeper_box(src)

// Donk Co's contribution to the 12 gauge arms race, boxed for your convenience

/obj/item/ammo_box/advanced/s12gauge/donk
	name = "\improper 咚克尖刺弹药盒"
	desc = "一盒 7 发“咚克尖刺”霰弹。每发都装着一把别人不要的塑料飞镖弹。看起来就像个咚克口袋饼！ \
		食用和/或微波加热风险自负。咚克公司对牙齿或身体组织的损伤不承担任何责任。"
	icon = 'modular_zubbers/icons/obj/donk_shotbox.dmi'
	icon_state = "donk"
	ammo_type = /obj/item/ammo_casing/shotgun/flechette/donk
	// must match /datum/design/advancedgaugeboxes_donk exactly or the design_mats unit test fails
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 35, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 10)

#undef ANIOLEK_ARMOR_PIERCING_CHANCE
#undef SZOT_CASE_SPARE_MAGAZINES
#undef SZOT_CASE_SPARE_MINES
