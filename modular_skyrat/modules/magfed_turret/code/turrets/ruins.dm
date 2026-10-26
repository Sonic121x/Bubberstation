////// Outpost Turret, Will be used for space ruins.
/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	name = "前哨防御炮塔套件"
	desc = "一款用于前哨近程防御和驱除游荡动物的可部署炮塔。"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "outpost_turretkit"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	mag_slots = 2
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost
	name = "\improper 前哨近程防御炮塔"
	desc = "一种用于保护前哨与民用建筑的可部署炮塔。"
	max_integrity = 120
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "outpost_off"
	base_icon_state = "outpost"
	shot_delay = 1.5 SECONDS
	faction = list(FACTION_TURRET)
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/outpost/malf
	name = "\improper 故障前哨炮塔"
	faction = list(FACTION_MALF_TURRET)
	shot_delay = 1 SECONDS

////// Colonist Turret. Kinda just made to be a ghost-role friendly version of the outpost turret

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist
	name = "殖民者防御炮塔套件"
	desc = "一款为殖民地建设与殖民者远征营地的安全而设计的可部署炮塔。它使用 .460 口径弹药"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "colonist_turretkit"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	mag_slots = 2
	easy_deploy = TRUE
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/m45, // Most similar to sol40
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist
	name = "\improper 殖民者近程防御炮塔"
	desc = "一种在建设或远征途中保护殖民者的可部署炮塔。它使用 .460 口径弹药"
	max_integrity = 150 //bit more health since it's meant for mobs only. Malf version is one of a kind to use.
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "colonist_off"
	base_icon_state = "colonist"
	shot_delay = 1.5 SECONDS
	quick_retract = TRUE
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/colonist/malf
	name = "\improper 故障殖民者近程防御炮塔"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/colonist/pre_filled

////// Spider turret. Throw-deployable turret with actual ammunition.

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider
	name = "蜘蛛攻势炮塔舱"
	desc = "一种投掷部署式炮塔舱，用于确保敌对动物盘踞区域内的安全。它使用 4.6x30mm 口径弹药。"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_toolbox"
	inhand_icon_state = "smoke" //I dont want to squash-make something. This should cover until i work something.
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	throw_speed = 2
	w_class = WEIGHT_CLASS_NORMAL // This isn't going to spawn outside of ruins/ghost roles, so it being small shouldn't be too big of a concern?
	quick_deployable = TRUE
	quick_deploy_timer = 1 SECONDS
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	mag_slots = 1
	turret_safety = TRUE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9, //same damage value as 35 sol, since it's unprintable
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider
	name = "\improper 刺针蜘蛛炮塔"
	desc = "一种用于激进扩张与区域防御的可部署炮塔。它使用 4.6x30mm 口径弹药。"
	max_integrity = 80
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "35_spider_off"
	base_icon_state = "35_spider"
	shot_delay = 1.5 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/malf // for ruins from here on
	name = "\improper 故障双牙炮塔"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf/pre_filled

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf
	name = "古怪蜘蛛炮塔套件"
	desc = "一种用于激进扩张与区域防御的可部署炮塔套件。它使用 4.6x30mm 口径弹药。这一套上似乎有些奇怪的灯光在闪烁。"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/malf

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/malf/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

////// Twin-Fang turret. Spider Turret's nastier cousin. Slightly less durable but more vitriol. Chambered in 4.6x30mm

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang
	name = "双牙攻势炮塔舱"
	desc = "一种投掷部署式炮塔舱，用于确保敌对动物盘踞区域内的安全。它使用 4.6x30mm 口径弹药。"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "twin_spider_toolbox"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang
	mag_slots = 1
	turret_safety = FALSE
	mag_types_allowed = list(
		/obj/item/ammo_box/magazine/wt550m9,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang
	name = "\improper 双牙蜘蛛炮塔"
	desc = "一种用于激进扩张与区域防御的可部署炮塔。它使用 4.6x30mm 口径弹药。"
	max_integrity = 50 // more aggressive but obviously easier to deal with.
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "twin_spider_off"
	base_icon_state = "twin_spider"
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly/twin_fang
	quick_retract = TRUE
	shot_delay = 0.1 SECONDS
	burst_fire = TRUE
	burst_delay = 2 SECONDS // Keeping the DPS exactly the same with sol35 removal
	burst_volley = 2
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang/malf
	name = "\improper 故障双牙炮塔"
	faction = list(FACTION_MALF_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf/pre_filled

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf
	name = "古怪双牙炮塔套件"
	desc = "一种投掷部署式炮塔舱，用于确保敌对动物盘踞区域内的安全。它使用 .4.6x30mm 口径弹药。这一套上似乎有些奇怪的灯光在闪烁。"
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/spider/twin_fang/malf

/obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang/malf/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/wt550m9(src)

////// Shotgun Turret. Surprisingly nothing new added as the firing proc will handle pellet clouds. Note however that shotgun rounds CANT smart-gun around allies.
/obj/item/storage/toolbox/emergency/turret/mag_fed/duster
	name = "除尘者涌现炮塔套件"
	desc = "一种可快速部署的炮塔套件，专为在紧急情况下迅速展开而设计，上面写着警告：“不要站在枪口前。友军火力可不会手软”。它可使用散装霰弹或 M12g 弹匣。"
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "duster_toolbox"
	righthand_file = 'modular_skyrat/modules/magfed_turret/icons/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/magfed_turret/icons//inhands/lefthand.dmi'
	inhand_icon_state = "duster_turretkit"
	easy_deploy = TRUE
	turret_type = /obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster
	mag_slots = 3 // Most mags dont have more than 8 rounds, and you're going to have hell getting a shotgun mag to re-fill. 24 round total.
	turret_safety = FALSE
	mag_types_allowed = list( //Easy to get actually. Quite Nice
		/obj/item/ammo_box/magazine/m12g,
	)

/obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled/PopulateContents()
	new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g(src)

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster
	name = "\improper 除尘者涌现炮塔"
	desc = "一种可快速部署的炮塔，用于紧急情况或撤退时部署，无法使用智能弹药瞄准功能。它可使用散装霰弹或 M12g 弹匣。"
	max_integrity = 100
	icon = 'modular_skyrat/modules/magfed_turret/icons/turrets/ruins.dmi'
	icon_state = "duster_off"
	base_icon_state = "duster"
	fragile = TRUE
	turret_frame = /obj/item/turret_assembly/duster
	ignore_faction = FALSE // Pellet cloud wont work with it anyways.
	quick_retract = TRUE
	shot_delay = 2 SECONDS
	faction = list(FACTION_TURRET)
	mag_box_type = /obj/item/storage/toolbox/emergency/turret/mag_fed/duster/pre_filled

/obj/machinery/porta_turret/syndicate/toolbox/mag_fed/duster/malf
	name = "\improper 故障除尘者炮塔"
	faction = list(FACTION_MALF_TURRET)
