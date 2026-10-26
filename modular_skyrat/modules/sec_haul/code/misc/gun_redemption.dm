//Choice Beacon for blueshield, old.

/obj/item/choice_beacon/blueshield
	name = "蓝盾武器信标"
	desc = "可运送一件自选武器的一次性信标。请仅在自己的办公室内使用。"
	company_source = "太阳安保方案公司"
	company_message = span_bold("补给舱即将抵达，请稍候。")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"能量左轮手枪" = /obj/item/gun/energy/e_gun/blueshield,
		"能量卡宾枪" = /obj/item/gun/energy/e_gun/stun/blueshield
	)

	return selectable_gun_types


//Both of these are defunk but still exist for archival purpose incase someone want to re-visit them later, or as references


/obj/item/choice_beacon/ntc
	name = "枪械套装信标"
	desc = "可运送一套自选枪械的一次性信标。请仅在自己的办公室内使用。"
	company_source = "特拉比斯特工厂"
	company_message = span_bold("补给舱即将抵达，请稍候。")

/obj/item/choice_beacon/ntc/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"黇鹿" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/takbok,
		"盾牌" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild
	)

	return selectable_gun_types

//Station Central Command Staff

/obj/item/choice_beacon/station_magistrate
	name = "纳米传讯要员武器信标"
	desc = "可运送一件自选武器的一次性信标。请仅在自己的办公室内使用。"
	company_source = "罗穆卢斯军械库"
	company_message = span_bold("补给舱即将抵达，请稍候。")

/obj/item/choice_beacon/station_magistrate/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"能量左轮手枪" = /obj/item/gun/energy/e_gun/blueshield,
		".38战斗步枪" = /obj/item/gun/ballistic/automatic/battle_rifle,
	)

	return selectable_gun_types
