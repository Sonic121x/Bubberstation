//WEAPON CHOICE BEACONS FOR THE PERSISTENCE SHIP

//standard pistol
/obj/item/choice_beacon/syndicateoffstation
	name = "标准辛迪加随身武器信标"
	desc = "一次性信标，可投送你选择的武器套件。请尽快使用，或把它存进你的保险箱。"
	company_source = "戈尔莱克斯掠夺者"
	company_message = span_bold("补给舱即将抵达，请稍候。")

/obj/item/choice_beacon/syndicateoffstation/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"马卡洛夫" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov,
		"M1911" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911,
		"能量匕首" = /obj/item/pen/edagger,
		"安瑟姆手枪套件" = /obj/item/storage/toolbox/guncase/clandestine,
	)

	return selectable_gun_types

//engineers kit because the crossbow is funny and will probably end up with them dead
/obj/item/choice_beacon/syndicateoffstation/engineer
	name = "工程官的辛迪加随身武器信标"

/obj/item/choice_beacon/syndicateoffstation/engineer/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"马卡洛夫" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov,
		"M1911" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911,
		"能量匕首" = /obj/item/pen/edagger,
		"辛迪加弩" = /obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow,
		"安瑟姆手枪套件" = /obj/item/storage/toolbox/guncase/clandestine,
	)

	return selectable_gun_types


//MAA kit, they get an actual selection of weapons
/obj/item/choice_beacon/syndicateoffstation/maa
	name = "纠察长的辛迪加武器信标"

/obj/item/choice_beacon/syndicateoffstation/maa/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"M90-GL" = /obj/item/storage/toolbox/guncase/m90gl,
		"斗牛犬" = /obj/item/storage/toolbox/guncase/bulldog,
		"能量剑" = /obj/item/melee/energy/sword/saber,
	)

	return selectable_gun_types

/obj/item/choice_beacon/syndicateoffstation/command
	name = "辛迪加指挥人员武器信标"

/obj/item/choice_beacon/syndicateoffstation/command/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"斯捷奇金 APS" = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps,
		"安瑟姆手枪套件" = /obj/item/storage/toolbox/guncase/clandestine,
		"C-20r 冲锋枪" = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r,
		"能量剑" = /obj/item/melee/energy/sword/saber,

	)

	return selectable_gun_types

/obj/item/choice_beacon/syndicateoffstation/morale
	name = "辛迪加上将武器信标"

/obj/item/choice_beacon/syndicateoffstation/morale/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"斯捷奇金 APS" = /obj/item/storage/toolbox/guncase/skyrat/pistol/aps,
		"安瑟姆手枪套件" = /obj/item/storage/toolbox/guncase/clandestine,
		"能量剑" = /obj/item/melee/energy/sword/saber,
		"华夫公司左轮手枪" = /obj/item/storage/toolbox/guncase/revolver
	)

	return selectable_gun_types
