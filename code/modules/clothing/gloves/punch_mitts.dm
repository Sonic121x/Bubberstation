/obj/item/clothing/gloves/fingerless/punch_mitts
	name = "拳击手套"
	desc = "一副附有狰狞尖刺的无指手套。让佩戴者能够施展那套恶名昭彰的格斗技巧——猎人拳击。这种拳法 \
		能让使用者在极短时间内把野生动物揍成碎片。锻炼效果极佳。但极其不建议用它来保障自身存活。"
	icon_state = "punch_mitts"
	body_parts_covered = HANDS|ARMS
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	armor_type = /datum/armor/gloves_mitts

/obj/item/clothing/gloves/fingerless/punch_mitts/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -6)
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/boxing/hunter)

/datum/armor/gloves_mitts
	melee = 25
	bullet = 5
	laser = 5
	energy = 5
	bomb = 100
	fire = 100
	acid = 30
