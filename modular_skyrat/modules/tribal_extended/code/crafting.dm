/obj/item/weaponcrafting/silkstring
	name = "绳线"
	desc = "一长段绳线，看起来像一卷电缆。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/crafting.dmi'
	icon_state = "silkstring"

/obj/item/dice/d6/bone
	name = "骨骰"
	desc = "用生物骨头雕成的骰子，点数凹坑中留有干涸血迹。"
	icon = 'modular_skyrat/modules/tribal_extended/icons/dice.dmi'
	icon_state = "db6"
	microwave_riggable = FALSE // You can't melt bone in the microwave
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT)
