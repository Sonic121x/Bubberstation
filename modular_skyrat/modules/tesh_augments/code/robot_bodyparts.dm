#define ROBOTIC_LIGHT_BRUTE_MSG "有刮痕"
#define ROBOTIC_MEDIUM_BRUTE_MSG "有凹陷"
#define ROBOTIC_HEAVY_BRUTE_MSG "濒临散架"

#define ROBOTIC_LIGHT_BURN_MSG "有焦痕"
#define ROBOTIC_MEDIUM_BURN_MSG "烧焦"
#define ROBOTIC_HEAVY_BURN_MSG "冒着余烟"

/*
 * The damage modifiers here are modified to stay in line with teshari
 * Although I'm not sure if it's redundant, better safe than sorry.
 * Addendum: the limbs lack "limb_id = SPECIES_TESHARI". if this becomes a problem, just put those in xoxo -aKhro
 */

#define TESHARI_PUNCH_LOW 2
#define TESHARI_PUNCH_HIGH 6

//Teshari normal

/obj/item/bodypart/arm/left/robot/teshari
	name = "猛禽型机械左前肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/arm/right/robot/teshari
	name = "猛禽型机械右前肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/left/robot/teshari
	name = "猛禽型机械左后肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/right/robot/teshari
	name = "猛禽型机械右后肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static =  'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 1.5)

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/chest/robot/teshari
	name = "猛禽型机械躯干"
	desc = "经过重度加固的外壳，内置半机械人逻辑板，并留有标准电池的空间，表面覆盖一层膜状羽毛。"
	icon_static =  'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 6)

	brute_modifier = 1
	burn_modifier = 0.9

	robotic_emp_paralyze_damage_percent_threshold = 0.5

/obj/item/bodypart/head/robot/teshari
	name = "猛禽型机械头部"
	desc = "标准强化脑壳，配有连接脊柱的神经插座和传感器万向架，裸露金属外覆盖着一层膜状羽毛。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 0.75)

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

	head_flags = HEAD_EYESPRITES



//Teshari greyscale

/obj/item/bodypart/arm/left/robot/teshari_greyscale
	name = "猛禽型机械左前肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_static = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/arm/right/robot/teshari_greyscale
	name = "猛禽型机械右前肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/left/robot/teshari_greyscale
	name = "猛禽型机械左后肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/right/robot/teshari_greyscale
	name = "猛禽型机械右后肢"
	desc = "包覆仿生肌肉与膜状羽毛的骨架式肢体，配有低导电性外壳。"
	icon_static =  'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/chest/robot/teshari_greyscale
	name = "猛禽型机械躯干"
	desc = "经过重度加固的外壳，内置半机械人逻辑板，并留有标准电池的空间，表面覆盖一层膜状羽毛。"
	icon_static =  'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	brute_modifier = 1
	burn_modifier = 0.9

	robotic_emp_paralyze_damage_percent_threshold = 0.5

/obj/item/bodypart/head/robot/teshari_greyscale
	name = "猛禽型机械头部"
	desc = "标准强化脑壳，配有连接脊柱的神经插座和传感器万向架，裸露金属外覆盖着一层膜状羽毛。"
	icon_static = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/modules/bodyparts/icons/teshari_robotic_greyscale.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	should_draw_greyscale = TRUE

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

	head_flags = HEAD_EYESPRITES


// teshari_ surplus

/obj/item/bodypart/arm/left/robot/teshari_surplus
	name = "猛禽型左前肢义肢"
	desc = "骨架式机械翼，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM


	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_surplus
	name = "猛禽型右前肢义肢"
	desc = "骨架式机械翼，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_surplus
	name = "猛禽型左后肢义肢"
	desc = "骨架式机械后肢，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_surplus
	name = "猛禽型右后肢义肢"
	desc = "骨架式机械后肢，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/left/robot/teshari_surplus
	name = "猛禽型左前肢义肢"
	desc = "骨架式机械翼，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_surplus
	name = "猛禽型右前肢义肢"
	desc = "骨架式机械翼，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS


	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_surplus
	name = "猛禽型左后肢义肢"
	desc = "骨架式机械后肢，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_surplus
	name = "猛禽型右后肢义肢"
	desc = "骨架式机械后肢，过时而脆弱，但总比没有强。一层膜状羽毛遮住了廉价的组件。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

// teshari_ advanced

/obj/item/bodypart/arm/left/robot/teshari_advanced
	name = "高级猛禽型左前肢"
	desc = "先进的机械肢体。这类设计通常专供仍在寻找阿瓦隆的人使用。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_advanced
	name = "高级猛禽型右前肢"
	desc = "先进的机械肢体。这类设计通常专供仍在寻找阿瓦隆的人使用。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_advanced
	name = "高级猛禽型左后肢"
	desc = "先进的机械后肢。这类设计通常专供仍在寻找阿瓦隆的人使用。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_advanced
	name = "高级猛禽型右后肢"
	desc = "先进的机械后肢。这类设计通常专供仍在寻找阿瓦隆的人使用。"
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

#undef ROBOTIC_LIGHT_BRUTE_MSG
#undef ROBOTIC_MEDIUM_BRUTE_MSG
#undef ROBOTIC_HEAVY_BRUTE_MSG

#undef ROBOTIC_LIGHT_BURN_MSG
#undef ROBOTIC_MEDIUM_BURN_MSG
#undef ROBOTIC_HEAVY_BURN_MSG

#undef TESHARI_PUNCH_LOW
#undef TESHARI_PUNCH_HIGH
