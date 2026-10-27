/obj/item/clothing/head/helmet/space/freedom
	name = "雄鹰头盔"
	desc = "一顶先进的真空防护头盔。它的外形似乎是仿照旧世界的雄鹰设计的。"
	icon = 'icons/obj/clothing/head/costume.dmi'
	worn_icon = 'icons/mob/clothing/head/costume.dmi'
	icon_state = "griffinhat"
	inhand_icon_state = null
	armor_type = /datum/armor/space_freedom
	strip_delay = 13 SECONDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = ACID_PROOF | FIRE_PROOF
	fishing_modifier = 0
	visor_dirt = null

/datum/armor/space_freedom
	melee = 20
	bullet = 40
	laser = 30
	energy = 40
	bomb = 100
	bio = 100
	fire = 80
	acid = 80

/obj/item/clothing/suit/space/freedom
	name = "雄鹰服"
	desc = "一套先进而轻便的宇航服，由合成羽毛与抗太空材料混合制成。服内似乎集成有枪套，而翅膀则像是被卡在了“自由”模式。"
	icon_state = "freedom"
	inhand_icon_state = null
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor_type = /datum/armor/space_freedom
	strip_delay = 13 SECONDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = ACID_PROOF | FIRE_PROOF
	slowdown = 0
	fishing_modifier = 0
