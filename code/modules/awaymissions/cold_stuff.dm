/// stuff left over from the snowdin gateway that was too much of a pain to remove from the places where they are used.
/obj/structure/barricade/wooden/snowed
	name = "粗糙木板路障"
	desc = "这片区域被木板路障挡住了。上面似乎覆盖着一层雪。"
	icon_state = "woodenbarricade_snow"
	max_integrity = 125

/obj/item/clothing/under/syndicate/coldres
	name = "绝缘战术高领衫"
	desc = "一件不起眼、略显可疑的高领衫，搭配数码迷彩工装裤。内衬经过特殊隔热处理，既保暖又能提供防护。"
	armor_type = /datum/armor/clothing_under/syndicate/coldres
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/datum/armor/clothing_under/syndicate/coldres
	melee = 20
	bullet = 10
	energy = 5
	fire = 25
	acid = 25

/obj/item/clothing/shoes/combat/coldres
	name = "绝缘战斗靴"
	desc = "高速轻便的战斗靴，如今又额外加了一层隔热层。"
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/gun/magic/wand/fireball/inert
	name = "弱化的火球魔杖"
	desc = "这根魔杖能射出灼热的火球，爆炸后化作毁灭性的火焰。长年的寒冷已经削弱了魔杖内部的魔力。"
	max_charges = 4

/obj/item/gun/magic/wand/resurrection/inert
	name = "弱化的治疗魔杖"
	desc = "这根魔杖使用治疗魔法来治愈和复活。长年的寒冷已经削弱了魔杖内部的魔力。"
	max_charges = 5

/mob/living/basic/pet/penguin/emperor/snowdin
	minimum_survivable_temperature = ICEBOX_MIN_TEMPERATURE
	gold_core_spawnable = NO_SPAWN

/mob/living/basic/pet/penguin/baby/permanent/snowdin
	minimum_survivable_temperature = ICEBOX_MIN_TEMPERATURE
	gold_core_spawnable = NO_SPAWN

/turf/open/floor/iron/dark/snowdin
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = TRUE
	temperature = ICEBOX_MIN_TEMPERATURE
