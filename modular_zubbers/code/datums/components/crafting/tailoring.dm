/datum/crafting_recipe/drakecloak_bleached
	name = "漂白灰烬龙护甲"
	result = /obj/item/clothing/suit/hooded/cloak/drake/bleached
	reqs = list(/obj/item/clothing/suit/hooded/cloak/drake = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/bonesuit_bleached
	name = "漂白骨甲"
	result = /obj/item/clothing/suit/armor/bone/bleached
	reqs = list(/obj/item/clothing/suit/armor/bone = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/skullhelm_bleached
	name = "漂白头骨"
	result = /obj/item/clothing/head/helmet/skull/bleached
	reqs = list(/obj/item/clothing/head/helmet/skull = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/drakecloak_ochre
	name = "赭色灰烬龙护甲"
	result = /obj/item/clothing/suit/hooded/cloak/drake
	reqs = list(/obj/item/clothing/suit/hooded/cloak/drake/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/bonesuit_ochre
	name = "赭色骨甲"
	result = /obj/item/clothing/suit/armor/bone
	reqs = list(/obj/item/clothing/suit/armor/bone/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/skullhelm_ochre
	name = "赭色头骨"
	result = /obj/item/clothing/head/helmet/skull
	reqs = list(/obj/item/clothing/head/helmet/skull/bleached = 1,
				/obj/item/stack/ore/glass/basalt = 5)
	time = 5 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/datum/crafting_recipe/modulator_gasmask
	name = "变声防毒面具"
	result = /obj/item/clothing/mask/gas/modulator
	reqs = list(/obj/item/clothing/mask/gas = 1,
				/obj/item/assembly/voice = 1,
				/obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_MULTITOOL)
	time = 5 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/modulator_gasmask/New()
	..()
	blacklist += subtypesof(/obj/item/clothing/mask/gas)

/datum/crafting_recipe/muzzle_medical_mask
	name = "外科口罩"
	result = /obj/item/clothing/mask/breath/muzzle
	reqs = list(/obj/item/clothing/mask/breath = 1,
				/obj/item/clothing/mask/muzzle = 1)
	time = 3 SECONDS
	category = CAT_CLOTHING

/datum/crafting_recipe/muzzle_medical_mask/New()
	..()
	blacklist += typesof(/obj/item/clothing/mask/breath/muzzle)
	blacklist += subtypesof(/obj/item/clothing/mask/muzzle)

/datum/crafting_recipe/hudsunciv
	name = "民用 HUD 太阳镜"
	result = /obj/item/clothing/glasses/hud/civilian/sunglasses
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/civilian = 1,
				/obj/item/clothing/glasses/sunglasses = 1,
				/obj/item/stack/cable_coil = 5)
	category = CAT_EQUIPMENT

/datum/crafting_recipe/hudsuncivremoval
	name = "拆除民用 HUD"
	result = /obj/item/clothing/glasses/sunglasses
	time = 2 SECONDS
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/civilian/sunglasses = 1)
	category = CAT_EQUIPMENT
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

// Metal H2 Rework by Xiska

/datum/crafting_recipe/atmos_armor_crafting
	name = "古老大气之神护甲"
	result = /obj/item/clothing/suit/armor/elder_atmosian
	time = 40 SECONDS
	reqs = list(/obj/item/stack/sheet/mineral/metal_hydrogen = 5,
	/obj/item/clothing/suit/utility/fire/atmos = 1)
	category = CAT_CLOTHING


/datum/crafting_recipe/atmos_helmet_crafting
	name = "古老大气之神头盔"
	result = /obj/item/clothing/head/helmet/elder_atmosian
	time = 40 SECONDS
	reqs = list(/obj/item/stack/sheet/mineral/metal_hydrogen = 3,
	/obj/item/clothing/head/utility/hardhat/welding/atmos = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/security_juggernaut
	name = "安保重装防护服"
	result = /obj/item/clothing/suit/hooded/secjuggernaut
	time = 60
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER, TOOL_WRENCH, TOOL_CROWBAR, TOOL_MULTITOOL)
	reqs = list(
		/obj/item/weaponcrafting/juggernaut_suit = 1,
		/obj/item/clothing/shoes/magboots = 1,
		/obj/item/flashlight/seclite = 2,
		/obj/item/clothing/suit/armor/swat = 1,
		/obj/item/clothing/head/helmet/swat = 1,
		/obj/item/stack/cable_coil = 30,
	)
	blacklist = list(
		/obj/item/clothing/shoes/magboots/advance
	)
	category = CAT_CLOTHING
