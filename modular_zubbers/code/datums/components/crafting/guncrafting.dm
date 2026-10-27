/obj/item/weaponcrafting/gunkit/wt550_burst
	name = "WT-550 点射改装零件套件"
	desc = "一个手提箱，装有将 WT-550 改装成点射突击武器所需的枪械零件。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
	)

/obj/item/weaponcrafting/gunkit/wt550_long
	name = "WT-550 远程作战零件套件"
	desc = "一个手提箱，装有组装远程 WT-550 所需的枪械零件，包括长枪管、瞄准镜和改装机匣。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7.5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
	)

/obj/item/weaponcrafting/gunkit/simple_battle_rifle
	name = "NT-38 战斗步枪简化套件"
	desc = "一个手提箱，装有移除 NT-38 战斗步枪先进电子设备与加速技术所需的枪械零件。性能有所下降，但可靠性最大化。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
	)

/obj/item/weaponcrafting/gunkit/regal_condor
	name = "无名武器零件箱（极度致命）"
	desc = "一个手提箱，装有组装一把威力惊人的手枪所需的枪械零件。箱子本身散发着不祥的气息。"
	icon = 'modular_zubbers/icons/obj/weapons/improvised.dmi'
	icon_state = "syndikitsuitcase"

/obj/item/weaponcrafting/juggernaut_suit
	name = "高级安保防护服装甲板"
	desc = "一组密度极高的装甲板，用于制作高级安保防护服。"
	icon = 'modular_zubbers/icons/obj/weapons/improvised.dmi'
	icon_state = "jugg_plates"
	w_class = WEIGHT_CLASS_HUGE
	item_flags = SLOWS_WHILE_IN_HAND
	slowdown = 3
	custom_materials = list(
	/datum/material/iron = SHEET_MATERIAL_AMOUNT * 40,
	/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 40,
	/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 40)
