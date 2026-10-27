/obj/item/clothing/under/plasmaman/captain
	name = "舰长的等离子环保服"
	desc = "这是一件蓝色环保服，上面有金色标记，代表“舰长”军衔。"
	icon_state = "captain_envirosuit"
	inhand_icon_state = null
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	armor_type = /datum/armor/clothing_under/rank_captain/plasmaman

/datum/armor/clothing_under/rank_captain/plasmaman
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/plasmaman/head_of_personnel
	name = "人事主管的等离子环保服"
	desc = "这是一件由担任“人事主管”职位的人穿着的环保服。"
	icon_state = "hop_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/security/head_of_security
	name = "安保主管的环保服"
	desc = "一件为少数有决心晋升至安保主管之位的等离子人特制的防护服。"
	icon_state = "hos_envirosuit"
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/security_head_of_security/plasmaman
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/datum/armor/clothing_under/security_head_of_security/plasmaman
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/plasmaman/chief_engineer
	name = "总工程师的等离子环保服"
	desc = "一件气密服装，专为那些疯狂到能晋升“总工程师”的等离子人设计。"
	icon_state = "ce_envirosuit"
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/engineering_chief_engineer/plasmaman

/datum/armor/clothing_under/engineering_chief_engineer/plasmaman
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/under/plasmaman/chief_medical_officer
	name = "首席医疗官的等离子环保服"
	desc = "这是一件由具备“首席医疗官”经验的人穿着的环保服。"
	icon_state = "cmo_envirosuit"
	inhand_icon_state = null

/obj/item/clothing/under/plasmaman/research_director
	name = "科研主管的等离子环保服"
	desc = "这是一件由具备晋升“科研主管”所需本领的人穿着的环保服。"
	icon_state = "rd_envirosuit"
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/rnd_research_director/plasmaman

/datum/armor/clothing_under/rnd_research_director/plasmaman
	bio = 100
	fire = 95
	acid = 95
