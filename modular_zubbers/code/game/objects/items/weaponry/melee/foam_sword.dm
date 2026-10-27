/obj/item/foam_baton
	name = "泡沫威力警棍"
	desc = "用于殴打犯罪渣滓的泡沫警棍。"
	icon = 'modular_zubbers/icons/obj/weapons/foam_melee.dmi'
	icon_state = "foam_baton"
	worn_icon = 'modular_zubbers/icons/mob/clothing/belt.dmi'
	worn_icon_state = "foam_baton"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("攻击", "警棍敲打", "警棍猛敲", "警棍殴打", "警棍暴打", "痛揍")
	attack_verb_simple = list("攻击", "警棍敲打", "警棍猛敲", "警棍殴打", "警棍暴打", "痛揍")
	slot_flags = ITEM_SLOT_BELT
	inhand_icon_state = "foam_baton"
	force = 0 //basically harmless
	throwforce = 0
	force_string = "有点能打"
	w_class = WEIGHT_CLASS_NORMAL
	damtype = STAMINA

/obj/item/foam_baton/sword
	name = "泡沫威力双手剑"
	desc = "你还站在这盯着它干什么？快去敲人！"
	icon_state = "foam_sword"
	inhand_icon_state = "foam_sword"
	attack_verb_continuous = list("攻击", "刺", "斩", "开膛", "殴打")
	attack_verb_simple = list("攻击", "刺", "斩", "开膛", "殴打")
	worn_icon_state = "foam_sword"
	force_string = "不太能打"

/obj/item/foam_baton/sword/traitor
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "这把泡沫威力剑的泡沫剑刃内装入了一根轻型铅芯，让打击更有分量。\
					此外还能提供少许格挡能力。不过不能用作钝器。"
	force = 30 //stamcrit in 3-4 hits but does not knock down or stun or hurt
	throwforce = 20
	force_string = "能打吗？"
	block_chance = 20

/obj/item/foam_baton/sword/traitor/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()
