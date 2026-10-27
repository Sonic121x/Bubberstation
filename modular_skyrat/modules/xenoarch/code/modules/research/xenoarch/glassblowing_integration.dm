/obj/item/glassblowing/magnifying_glass
	name = "放大镜"
	desc = "借助放大透镜观察细小事物的工具。"
	icon_state = "magnifying_glass"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT)

/obj/item/glassblowing/magnifying_glass/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_XENOARCH_QUALIFIED))
		. += span_notice("你可以用[src]检查无用遗物，发掘它们的全部潜力！")

/datum/crafting_recipe/magnifying_glass
	name = "放大镜"
	result = /obj/item/glassblowing/magnifying_glass
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/glassblowing/glass_lens = 1,
	)
	category = CAT_EQUIPMENT
