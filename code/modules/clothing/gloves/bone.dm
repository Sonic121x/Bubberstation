/obj/item/clothing/gloves/bracer
	name = "骨质护腕"
	desc = "适合你预料自己会被人打手腕的时候。为你的双臂提供适度的防护。"
	icon_state = "bracers"
	inhand_icon_state = null
	strip_delay = 4 SECONDS
	equip_delay_other = 2 SECONDS
	body_parts_covered = ARMS
	cold_protection = ARMS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	armor_type = /datum/armor/gloves_bracer
	custom_materials = list(/datum/material/bone = SHEET_MATERIAL_AMOUNT * 2)

/obj/item/clothing/gloves/bracer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, 2)

/datum/armor/gloves_bracer
	melee = 15
	bullet = 25
	laser = 15
	energy = 15
	bomb = 20
	bio = 10
