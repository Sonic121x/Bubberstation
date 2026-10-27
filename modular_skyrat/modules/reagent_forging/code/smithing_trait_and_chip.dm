/obj/item/skillchip/job/blacksmith
	name = "锻造 F0RG-3M4573-R 技能芯片"
	desc = "提供锻造和金属加工相关技能。"
	auto_traits = list(TRAIT_KNOW_ADVANCED_SMITHING, TRAIT_KNOW_GUNSMITHING, TRAIT_KNOW_CIRCUIT_SMITHING)
	skill_name = "高级锻造"
	skill_description = "包含更先进装备的锻造图纸及其最佳应用方法。"
	skill_icon = "gavel"
	activate_message = span_notice("你突然掌握了用原材料制作高级金属零件的方法。")
	deactivate_message = span_notice("制作高级金属零件的知识从你脑海中逐渐消失。")

/obj/item/storage/box/skillchips/supply
	name = "补给岗位技能芯片盒"
	desc = "内含各类补给岗位技能芯片的备品。"

/obj/item/storage/box/skillchips/supply/PopulateContents()
	new /obj/item/skillchip/job/blacksmith(src)
	new /obj/item/skillchip/job/blacksmith(src)

/obj/structure/closet/secure_closet/quartermaster/PopulateContents()
	. = ..()
	new /obj/item/storage/box/skillchips/supply(src)
