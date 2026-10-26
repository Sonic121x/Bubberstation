/obj/item/organ/cyberimp/arm/toolkit/toolset/alien
	name = "外星集成工具组植入体"
	desc = "精简版的工程工具组，设计用于安装在使用者手臂上。内含绑架者工具。"
	actions_types = list(/datum/action/item_action/organ_action/toggle/toolkit)
	items_to_create = list(
		/obj/item/screwdriver/abductor,
		/obj/item/wrench/abductor,
		/obj/item/weldingtool/abductor,
		/obj/item/crowbar/abductor,
		/obj/item/wirecutters/abductor,
		/obj/item/multitool/abductor,
	)
	custom_materials = list (/datum/material/iron =SHEET_MATERIAL_AMOUNT * 15.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT*8.25, /datum/material/plasma =SHEET_MATERIAL_AMOUNT * 8.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 3, /datum/material/diamond =SHEET_MATERIAL_AMOUNT * 3)

/obj/item/organ/cyberimp/arm/toolkit/surgery/alien
	name = "外星手术工具组植入体"
	desc = "一套隐藏在手臂暗格中的外星手术工具。"
	actions_types = list(/datum/action/item_action/organ_action/toggle/toolkit)
	items_to_create = list(
		/obj/item/retractor/alien,
		/obj/item/hemostat/alien,
		/obj/item/cautery/alien,
		/obj/item/surgicaldrill/alien,
		/obj/item/scalpel/alien,
		/obj/item/circular_saw/alien,
		/obj/item/surgical_processor,
		/obj/item/bonesetter/alien,
		/obj/item/blood_filter/alien,
	)
	custom_materials = list (/datum/material/iron = SHEET_MATERIAL_AMOUNT*10.25, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 10.5, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 10.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT * 10, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 4.5)

/obj/item/organ/cyberimp/arm/toolkit/surgery
	items_to_create = list(
		/obj/item/retractor/augment,
		/obj/item/hemostat/augment,
		/obj/item/cautery/augment,
		/obj/item/surgicaldrill/augment,
		/obj/item/scalpel/augment,
		/obj/item/circular_saw/augment,
		/obj/item/surgical_drapes,
		/obj/item/bonesetter,
		/obj/item/blood_filter,
	)
