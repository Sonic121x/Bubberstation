/datum/crafting_recipe/pn_jaws
	name = "原硝气液压救援钳"
	result = /obj/item/crowbar/power/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/crowbar/power = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_jaws/science
	name = "原硝气复合剪切器"
	result = /obj/item/crowbar/power/protonitrate/science
	time = 3 SECONDS
	reqs = list(/obj/item/crowbar/power/science = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_drill
	name = "原硝气手钻"
	result = /obj/item/screwdriver/power/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/screwdriver/power = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_drill/science
	name = "原硝气手钻"
	result = /obj/item/screwdriver/power/protonitrate/science
	time = 3 SECONDS
	reqs = list(/obj/item/screwdriver/power/science = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/pn_welder
	name = "原硝气焊接工具"
	result = /obj/item/weldingtool/experimental/protonitrate
	time = 3 SECONDS
	reqs = list(/obj/item/weldingtool/experimental = 1,
	/obj/item/grenade/gas_crystal/proto_nitrate_crystal = 1)
	category = CAT_TOOLS

/datum/crafting_recipe/jaws_of_recovery
	category = null
	crafting_flags = CRAFT_MUST_BE_LEARNED
