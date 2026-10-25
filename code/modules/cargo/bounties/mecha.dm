/datum/bounty/item/mech
	wanted_types = list(/obj/item/mecha_diagnostic = TRUE)
	/// What mech do we need data of inside this mecha diagnostic?
	var/required_data = null

/datum/bounty/item/mech/New()
	..()
	description = "高层管理要求尽快提交 [name] 机甲的机身诊断全息扫描。<b>诊断全息扫描</b>可以在全新的机甲内部生成。将其寄出即可获得丰厚报酬。"

/datum/bounty/item/mech/applies_to(obj/shipped)
	. = ..()
	if(!.)
		return

	if(istype(shipped, /obj/vehicle/sealed/mecha))
		shipped.balloon_alert_to_viewers("从机甲内部生成诊断！")

	var/obj/item/mecha_diagnostic/diagnostic_sheet = shipped
	if(!diagnostic_sheet.mech_data)
		CRASH("Diagnostic sheet submitted with no mech data contained!")
	if(istype(diagnostic_sheet.mech_data, required_data))
		return TRUE
	return FALSE

/datum/bounty/item/mech/ripleymk2
	name = "APLU MK-II“雷普利”"
	reward = CARGO_CRATE_VALUE * 6.5
	required_data = /obj/vehicle/sealed/mecha/ripley/mk2

/datum/bounty/item/mech/clarke
	name = "克拉克"
	reward = CARGO_CRATE_VALUE * 12
	required_data = /obj/vehicle/sealed/mecha/clarke

/datum/bounty/item/mech/odysseus
	name = "奥德修斯"
	reward = CARGO_CRATE_VALUE * 5.5
	required_data = /obj/vehicle/sealed/mecha/odysseus

/datum/bounty/item/mech/gygax
	name = "吉盖克斯"
	reward = CARGO_CRATE_VALUE * 28
	required_data = /obj/vehicle/sealed/mecha/gygax

/datum/bounty/item/mech/durand
	name = "杜兰德"
	reward = CARGO_CRATE_VALUE * 20
	required_data = /obj/vehicle/sealed/mecha/durand
