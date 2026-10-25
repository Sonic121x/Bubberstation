
/obj/item/storage/toolbox/syndicate
	name = "战术工具箱" // BUBBER EDIT CHANGE: Just a normal toolbox. Original: name = "suspicious looking toolbox"
	icon_state = "syndicate"
	inhand_icon_state = "toolbox_syndi"
	force = 15
	throwforce = 18
	material_flags = NONE
	storage_type = /datum/storage/toolbox/syndicate

	// BUBBER EDIT ADDITION BEGIN: Just a normal toolbox.
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "辛迪加制造的工具箱，内含额外的战术工具。用料比普通工具箱更坚固。"
	// BUBBER EDIT ADDITION END: Just a normal toolbox.

/obj/item/storage/toolbox/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar/red(src)
	new /obj/item/wirecutters(src, "red")
	new /obj/item/multitool(src)
	new /obj/item/clothing/gloves/combat(src)


/obj/item/storage/toolbox/ammobox
	name = "弹药罐"
	desc = "用于存放弹药的金属罐。"
	icon_state = "ammobox"
	inhand_icon_state = "ammobox"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	has_latches = FALSE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'
	var/ammo_to_spawn

/obj/item/storage/toolbox/ammobox/PopulateContents()
	if(!isnull(ammo_to_spawn))
		for(var/i in 1 to 6)
			new ammo_to_spawn(src)

/obj/item/storage/toolbox/ammobox/strilka310
	name = ".310 斯特里尔卡弹药箱（剩余物资？）"
	desc = "里面装着几个弹夹。天啊，这东西味道难闻得要命。\
		它该不会在仓库里放了好几百年吧？"
	ammo_to_spawn = /obj/item/ammo_box/speedloader/strilka310

/obj/item/storage/toolbox/ammobox/strilka310/surplus
	ammo_to_spawn = /obj/item/ammo_box/speedloader/strilka310/surplus

/obj/item/storage/toolbox/ammobox/wt550m9
	name = "4.6x30mm 弹药箱"
	ammo_to_spawn = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/toolbox/ammobox/wt550m9ap
	name = "4.6x30mm 穿甲弹药箱"
	ammo_to_spawn = /obj/item/ammo_box/magazine/wt550m9/wtap


/obj/item/storage/toolbox/guncase
	name = "枪械箱"
	desc = "一个武器箱，盖子上压印着血红色的“S”。"
	icon = 'icons/obj/storage/case.dmi'
	icon_state = "infiltrator_case"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	inhand_icon_state = "infiltrator_case"
	has_latches = FALSE
	storage_type = /datum/storage/toolbox/guncase
	/// What weapon do we spawn in our case?
	var/weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol
	/// What magazine do we spawn in our case?
	var/extra_to_spawn = /obj/item/ammo_box/magazine/m9mm

/obj/item/storage/toolbox/guncase/PopulateContents()
	if(weapon_to_spawn)
		new weapon_to_spawn (src)
	if(extra_to_spawn)
		for(var/iterate in 1 to 3)
			new extra_to_spawn (src)

/obj/item/storage/toolbox/guncase/traitor
	name = "马卡洛夫枪械箱"
	desc = "一个武器箱，盖子上压印着血红色的“S”。内侧的塑料翻盖下似乎藏着一个奇怪的开关。"
	icon_state = "pistol_case"
	base_icon_state = "pistol_case"
	// What ammo box do we spawn in our case?
	var/ammo_box_to_spawn = /obj/item/ammo_box/c9mm
	// Timer for the bomb in the case.
	var/explosion_timer
	// Whether or not our case is exploding. Used for determining sprite changes.
	var/currently_exploding = FALSE

/obj/item/storage/toolbox/guncase/traitor/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/storage/toolbox/guncase/traitor/examine(mob/user)
	. = ..()
	. += span_notice("使用 Alt + 右键激活证据销毁炸弹。")

/obj/item/storage/toolbox/guncase/traitor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_RMB] = "激活证据销毁炸弹"
	return CONTEXTUAL_SCREENTIP_SET

/obj/item/storage/toolbox/guncase/traitor/PopulateContents()
	new weapon_to_spawn (src)
	for(var/i in 1 to 2)
		new extra_to_spawn (src)
	new ammo_box_to_spawn(src)

/obj/item/storage/toolbox/guncase/traitor/update_icon_state()
	. = ..()
	if(currently_exploding)
		icon_state = "[base_icon_state]_exploding"
	else
		icon_state = "[base_icon_state]"

/obj/item/storage/toolbox/guncase/traitor/click_alt_secondary(mob/user)
	. = ..()
	if(currently_exploding)
		user.balloon_alert(user, "已经在爆炸了！")
		return

	var/i_dont_even_think_once_about_blowing_stuff_up = tgui_alert(user, "你现在要激活证据销毁炸弹吗？", "掰掰", list("Yes","No"))

	if(i_dont_even_think_once_about_blowing_stuff_up != "Yes" || currently_exploding || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, NEED_DEXTERITY|NEED_HANDS|ALLOW_RESTING))
		return

	explosion_timer = addtimer(CALLBACK(src, PROC_REF(think_fast_chucklenuts)), 5 SECONDS, (TIMER_UNIQUE|TIMER_OVERRIDE))
	to_chat(user, span_warning("你启动了 [src] 的证据销毁炸弹！"))
	log_bomber(user, "已激活", src, "并准备引爆")
	playsound(src, 'sound/items/weapons/armbomb.ogg', 50, TRUE)
	currently_exploding = TRUE
	update_appearance()

/// proc to handle our detonation
/obj/item/storage/toolbox/guncase/traitor/proc/think_fast_chucklenuts()
	explosion(src, devastation_range = 0, heavy_impact_range = 0, light_impact_range = 2, explosion_cause = src)
	qdel(src)

/obj/item/storage/toolbox/guncase/traitor/ammunition
	name = "马卡洛夫 9mm 弹匣箱"
	weapon_to_spawn = /obj/item/ammo_box/magazine/m9mm

/obj/item/storage/toolbox/guncase/traitor/donksoft
	name = "\improper 咚克软防暴手枪箱"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/toy/riot/clandestine
	extra_to_spawn = /obj/item/ammo_box/magazine/toy/pistol/riot
	ammo_box_to_spawn = /obj/item/ammo_box/foambox/riot

/obj/item/storage/toolbox/guncase/traitor/ammunition/donksoft
	name = "\improper 咚克软防暴手枪弹匣箱"
	weapon_to_spawn = /obj/item/ammo_box/magazine/toy/pistol/riot
	extra_to_spawn = /obj/item/ammo_box/magazine/toy/pistol/riot
	ammo_box_to_spawn = /obj/item/ammo_box/foambox/riot

/obj/item/storage/toolbox/guncase/bulldog
	name = "斗牛犬枪械箱"
	weapon_to_spawn = /obj/item/gun/ballistic/shotgun/bulldog
	extra_to_spawn = /obj/item/ammo_box/magazine/m12g

/obj/item/storage/toolbox/guncase/c20r
	name = "C-20r 枪械箱"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/c20r
	extra_to_spawn = /obj/item/ammo_box/magazine/smgm45

/obj/item/storage/toolbox/guncase/smartgun
	name = "阿迪尔智能枪械箱"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/smartgun
	extra_to_spawn = /obj/item/ammo_box/magazine/smartgun

/obj/item/storage/toolbox/guncase/clandestine
	name = "隐秘手枪箱"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/clandestine
	extra_to_spawn = /obj/item/ammo_box/magazine/m10mm

/obj/item/storage/toolbox/guncase/m90gl
	name = "M-90GL 枪械箱"
	weapon_to_spawn = /obj/item/gun/ballistic/automatic/m90
	extra_to_spawn = /obj/item/ammo_box/magazine/m223

/obj/item/storage/toolbox/guncase/m90gl/PopulateContents()
	new weapon_to_spawn (src)
	for(var/i in 1 to 2)
		new extra_to_spawn (src)
	new /obj/item/ammo_box/a40mm/rubber (src)

/obj/item/storage/toolbox/guncase/rocketlauncher
	name = "火箭发射器箱"
	weapon_to_spawn = /obj/item/gun/ballistic/rocketlauncher
	extra_to_spawn = /obj/item/ammo_box/rocket

/obj/item/storage/toolbox/guncase/rocketlauncher/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)

/obj/item/storage/toolbox/guncase/revolver
	name = "左轮手枪箱"
	weapon_to_spawn = /obj/item/gun/ballistic/revolver/badass/nuclear
	extra_to_spawn = /obj/item/ammo_box/speedloader/c357

/obj/item/storage/toolbox/guncase/sword_and_board
	name = "能量剑与盾武器箱"
	weapon_to_spawn = /obj/item/melee/energy/sword
	extra_to_spawn = /obj/item/shield/energy

/obj/item/storage/toolbox/guncase/sword_and_board/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)
	new /obj/item/clothing/head/costume/knight (src)

/obj/item/storage/toolbox/guncase/cqc
	name = "\improper 近身格斗术装备箱"
	weapon_to_spawn = /obj/item/book/granter/martial/cqc
	extra_to_spawn = /obj/item/storage/box/syndie_kit/imp_stealth

/obj/item/storage/toolbox/guncase/cqc/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)
	new /obj/item/clothing/head/costume/snakeeater (src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate (src)

/obj/item/storage/toolbox/guncase/doublesword
	name = "双刃能量剑武器箱"
	weapon_to_spawn = /obj/item/dualsaber
	extra_to_spawn = /obj/item/soap/syndie
	storage_type = /datum/storage/toolbox/guncase/doublesword

/obj/item/storage/toolbox/guncase/doublesword/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)
	new /obj/item/mod/module/noslip (src)
	new /obj/item/reagent_containers/hypospray/medipen/methamphetamine (src)
	new /obj/item/clothing/under/rank/prisoner/nosensor (src)

/obj/item/storage/toolbox/guncase/china_lake
	name = "泵动式榴弹发射器武器箱"
	weapon_to_spawn = /obj/item/gun/ballistic/shotgun/china_lake
	extra_to_spawn = /obj/item/storage/belt/bandolier/china_lake_extra

/obj/item/storage/toolbox/guncase/china_lake/PopulateContents()
	new weapon_to_spawn (src)
	new extra_to_spawn (src)
	new /obj/item/clothing/under/rank/prisoner/nosensor (src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate (src)

/obj/item/storage/toolbox/guncase/soviet
	name = "古老枪械箱"
	desc = "一个武器箱，侧面压印着第三苏联的徽记。"
	icon_state = "sakhno_case"
	inhand_icon_state = "sakhno_case"
	weapon_to_spawn = /obj/effect/spawner/random/sakhno
	extra_to_spawn = /obj/effect/spawner/random/sakhno/ammo

/obj/item/storage/toolbox/guncase/monkeycase
	name = "猴子枪械箱"
	desc = "一只猴子要彻底发狂所需的一切。箱子正面有一个爪形的掌纹扫描锁。"
	storage_type = /datum/storage/toolbox/guncase/monkey

/obj/item/storage/toolbox/guncase/monkeycase/attack_self(mob/user, modifiers)
	if(!monkey_check(user))
		return
	return ..()

/obj/item/storage/toolbox/guncase/monkeycase/attack_self_secondary(mob/user, modifiers)
	attack_self(user, modifiers)
	return

/obj/item/storage/toolbox/guncase/monkeycase/attack_hand(mob/user, list/modifiers)
	if(!monkey_check(user))
		return
	return ..()

/obj/item/storage/toolbox/guncase/monkeycase/proc/monkey_check(mob/user)
	if(atom_storage.locked == STORAGE_NOT_LOCKED)
		return TRUE

	if(is_simian(user))
		atom_storage.locked = STORAGE_NOT_LOCKED
		to_chat(user, span_notice("你把爪子按在爪纹扫描器上，听见 [src] 发出轻轻一声咔哒，解锁了！"))
		playsound(src, 'sound/items/click.ogg', 25, TRUE)
		return TRUE
	to_chat(user, span_warning("你把手按在掌纹扫描器上，它愤怒地尖叫一声，拒绝了你的手！"))
	playsound(src, SFX_SCREECH, 75, TRUE)
	return FALSE

/obj/item/storage/toolbox/guncase/monkeycase/PopulateContents()
	switch(rand(1, 3))
		if(1)
			// Uzi with a boxcutter.
			new /obj/item/gun/ballistic/automatic/mini_uzi/chimpgun(src)
			new /obj/item/ammo_box/magazine/uzim9mm(src)
			new /obj/item/ammo_box/magazine/uzim9mm(src)
			new /obj/item/boxcutter/extended(src)
		if(2)
			// Thompson with a boxcutter.
			new /obj/item/gun/ballistic/automatic/tommygun/chimpgun(src)
			new /obj/item/ammo_box/magazine/tommygunm45(src)
			new /obj/item/ammo_box/magazine/tommygunm45(src)
			new /obj/item/boxcutter/extended(src)
		if(3)
			// M1911 with a switchblade and an extra banana bomb.
			new /obj/item/gun/ballistic/automatic/pistol/m1911/chimpgun(src)
			new /obj/item/ammo_box/magazine/m45(src)
			new /obj/item/ammo_box/magazine/m45(src)
			new /obj/item/switchblade/extended(src)
			new /obj/item/food/grown/banana/bunch/monkeybomb(src)

	// Banana bomb! Basically a tiny flashbang for monkeys.
	new /obj/item/food/grown/banana/bunch/monkeybomb(src)
	// Somewhere to store it all.
	new /obj/item/storage/backpack/messenger(src)

/obj/item/storage/toolbox/emergency/turret
	desc = "你莫名有种想用扳手敲它一下的冲动。"

/obj/item/storage/toolbox/emergency/turret/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/analyzer(src)
	new /obj/item/wirecutters(src)

/obj/item/storage/toolbox/emergency/turret/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/wrench/combat))
		return NONE
	if(!user.combat_mode)
		return NONE
	if(!tool.toolspeed)
		return ITEM_INTERACT_BLOCKING
	balloon_alert(user, "建造中……")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 20))
		return ITEM_INTERACT_BLOCKING

	balloon_alert(user, "建造完成！")
	user.visible_message(
		span_danger("[user] 用 [tool] 猛敲 [src]！"),
		span_danger("你用 [tool] 猛敲 [src]！"),
		null,
		COMBAT_MESSAGE_RANGE,
	)

	playsound(src, 'sound/items/tools/drill_use.ogg', 80, TRUE, -1)
	var/obj/machinery/porta_turret/syndicate/toolbox/turret = new(get_turf(loc))
	set_toolbox_faction(turret, user)
	turret.toolbox = src
	forceMove(turret)
	return ITEM_INTERACT_SUCCESS

/obj/item/storage/toolbox/emergency/turret/proc/set_toolbox_faction(obj/machinery/porta_turret/turret, mob/user)
	turret.set_allies(list("[REF(user)]"))
	turret.set_faction(null)

/obj/item/storage/toolbox/emergency/turret/nukie/set_toolbox_faction(obj/machinery/porta_turret/turret, mob/user)
	turret.set_faction(list(ROLE_SYNDICATE))
