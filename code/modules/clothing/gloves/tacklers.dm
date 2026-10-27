/obj/item/clothing/gloves/tackler
	name = "强化抓捕手套"
	desc = "特殊手套，能操控穿戴者手部的血管，使其可以一头撞进墙里，或一跃制服逃跑的罪犯。"
	icon_state = "tackle"
	inhand_icon_state = null
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	resistance_flags = NONE
	custom_premium_price = PAYCHECK_COMMAND * 3.5
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH,TRAIT_FAST_CUFFING)
	equip_sound = 'sound/items/equip/glove_equip.ogg'
	/// For storing our tackler datum so we can remove it after
	var/datum/component/tackler
	/// See: [/datum/component/tackler/var/stamina_cost]
	var/tackle_stam_cost = 25
	/// See: [/datum/component/tackler/var/base_knockdown]
	var/base_knockdown = 1 SECONDS
	/// See: [/datum/component/tackler/var/range]
	var/tackle_range = 4
	/// See: [/datum/component/tackler/var/min_distance]
	var/min_distance = 0
	/// See: [/datum/component/tackler/var/speed]
	var/tackle_speed = 1
	/// See: [/datum/component/tackler/var/skill_mod]
	var/skill_mod = 1
	///How much these gloves affect fishing difficulty
	var/fishing_modifier = -7

/obj/item/clothing/gloves/tackler/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, fishing_modifier) //fishing tackle equipment (ba dum tsh)

/obj/item/clothing/gloves/tackler/Destroy()
	tackler = null
	return ..()

/obj/item/clothing/gloves/tackler/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot & ITEM_SLOT_GLOVES)
		var/mob/living/carbon/human/H = user
		tackler = H.AddComponent(/datum/component/tackler, stamina_cost=tackle_stam_cost, base_knockdown = base_knockdown, range = tackle_range, speed = tackle_speed, skill_mod = skill_mod, min_distance = min_distance)

/obj/item/clothing/gloves/tackler/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_GLOVES) == src)
		QDEL_NULL(tackler)

/obj/item/clothing/gloves/tackler/dolphin
	name = "海豚手套"
	desc = "流线、符合空气动力学的抓握手套，实际制服效果较差，但更能让使用者飞过走廊并制造事故。"
	icon_state = "tackledolphin"
	inhand_icon_state = null
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.25)

	tackle_stam_cost = 15
	base_knockdown = 0.5 SECONDS
	tackle_range = 5
	tackle_speed = 2
	min_distance = 2
	skill_mod = -2
	fishing_modifier = -10

/obj/item/clothing/gloves/tackler/combat
	name = "大猩猩手套"
	desc = "优质格斗手套，经过重度加固，能让使用者在近身擒抱中占据优势，不过使用起来比普通抓握手套更费力。而且还防火！"
	icon_state = "gorilla"
	inhand_icon_state = null

	tackle_stam_cost = 30
	base_knockdown = 1.25 SECONDS
	tackle_range = 5
	skill_mod = 2

	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/tackler/combat/insulated
	name = "游击队手套"
	desc = "上等格斗手套，既适合擒抱制服目标，也能吸收电击。"
	icon_state = "guerrilla"
	siemens_coefficient = 0
	armor_type = /datum/armor/combat_insulated

/datum/armor/combat_insulated
	bio = 50

/obj/item/clothing/gloves/tackler/rocket
	name = "火箭手套"
	desc = "高风险、高回报的终极之选，当你需要从五十英尺外拦下罪犯，或者为此送命时最合适不过。在顺旋星区的大多数美式橄榄球和英式橄榄球联赛中被禁用。"
	icon_state = "tacklerocket"
	inhand_icon_state = null
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

	tackle_stam_cost = 50
	base_knockdown = 2 SECONDS
	tackle_range = 10
	min_distance = 7
	tackle_speed = 6
	skill_mod = 7

/obj/item/clothing/gloves/tackler/offbrand
	name = "简易抓握手套"
	desc = "破旧的无指手套，外面缠着粘胶带。要小心任何戴这种手套的人，因为他们显然既无羞耻也无所顾忌。"
	icon_state = "fingerless"
	inhand_icon_state = null
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)
	tackle_stam_cost = 30
	base_knockdown = 1.75 SECONDS
	min_distance = 2
	skill_mod = -1
	fishing_modifier = -5
	custom_materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT)

/obj/item/clothing/gloves/tackler/football
	name = "橄榄球手套"
	desc = "橄榄球运动员的手套！能教会他们像职业选手一样擒抱。"
	icon_state = "tackle_gloves"
	inhand_icon_state = null
	fishing_modifier = -4
