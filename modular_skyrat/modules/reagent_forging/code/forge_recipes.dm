/datum/crafting_recipe/primitive_billow
	name = "原始锻造风箱"
	result = /obj/item/forging/billow/primitive
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5)
	category = CAT_TOOLS

/datum/crafting_recipe/primitive_tong
	name = "原始锻造钳"
	result = /obj/item/forging/tongs/primitive
	reqs = list(/obj/item/stack/sheet/iron = 5)
	category = CAT_TOOLS

/datum/crafting_recipe/primitive_hammer
	name = "原始锻造锤"
	result = /obj/item/forging/hammer/primitive
	reqs = list(/obj/item/stack/sheet/iron = 5)
	category = CAT_TOOLS

//cargo supply pack for items
/datum/supply_pack/service/forging_items
	name = "锻造入门工具包"
	desc = "主打项目：锻造。本包包含开启锻造生涯所需的三种工具：钳子、锤子和风箱。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/obj/item/forging/tongs, /obj/item/forging/hammer, /obj/item/forging/billow)
	crate_name = "锻造入门工具"
	crate_type = /obj/structure/closet/crate/forging_items

/obj/structure/closet/crate/forging_items
	name = "锻造入门工具"
	desc = "一箱开始锻造所需的工具（风箱、锤子和钳子）。"
