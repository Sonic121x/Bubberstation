/datum/crafting_recipe/trickblindfold
	name = "假眼罩布"
	result = /obj/item/clothing/glasses/trickblindfold
	time = 20
	tool_behaviors = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/blindfold = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/paper_mask
	name = "纸面具"
	result = /obj/item/clothing/mask/paper
	time = 30
	tool_behaviors = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/paper = 5)
	category = CAT_CLOTHING

/datum/crafting_recipe/crusader_satchel
	name = "十字军挎包"
	result = /obj/item/storage/backpack/satchel/crusader
	reqs = list(/obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/leather = 1)	//Cheap because its really just a re-texture of the satchel
	tool_behaviors = list(TOOL_WIRECUTTER)
	time = 15
	category = CAT_CLOTHING

//Eyepatches//
/datum/crafting_recipe/secpatch
	name = "安保眼罩 HUD"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/security = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER) //Tools needed and requirements are kept the same as craftable HUD sunglasses//
	category = CAT_CLOTHING
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY
	requirements_mats_blacklist = list(/obj/item/stack/cable_coil)

/datum/crafting_recipe/secpatchremoval
	name = "安保眼罩 HUD 拆除"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY
	requirements_mats_blacklist = list(/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch)

/datum/crafting_recipe/medpatch
	name = "医疗眼罩 HUD"
	result = /obj/item/clothing/glasses/hud/eyepatch/med
	reqs = list(/obj/item/clothing/glasses/hud/health = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/stack/cable_coil)

/datum/crafting_recipe/medpatchremoval
	name = "医疗眼罩 HUD 拆除"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/eyepatch/med = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/clothing/glasses/hud/eyepatch/med)

/datum/crafting_recipe/mesonpatch
	name = "介子眼罩 HUD"
	result = /obj/item/clothing/glasses/hud/eyepatch/meson
	reqs = list(/obj/item/clothing/glasses/meson = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/stack/cable_coil)

/datum/crafting_recipe/mesonpatchremoval
	name = "介子眼罩 HUD 拆除"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/eyepatch/meson = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/clothing/glasses/hud/eyepatch/meson)

/datum/crafting_recipe/robopatch
	name = "诊断眼罩 HUD"
	result = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/stack/cable_coil)

/datum/crafting_recipe/robopatchremoval
	name = "诊断眼罩 HUD 拆除"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/eyepatch/diagnostic = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/clothing/glasses/hud/eyepatch/diagnostic)

/datum/crafting_recipe/scipatch
	name = "科学眼罩 HUD"
	result = /obj/item/clothing/glasses/hud/eyepatch/sci
	reqs = list(/obj/item/clothing/glasses/science = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/stack/cable_coil)

/datum/crafting_recipe/scipatchremoval
	name = "科学眼罩 HUD 拆除"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/eyepatch/sci = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
	requirements_mats_blacklist = list(/obj/item/clothing/glasses/hud/eyepatch/sci)
//eyepatches end//
