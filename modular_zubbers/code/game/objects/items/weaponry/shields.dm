/obj/item/shield/big_bertha
	name = "大贝莎"
	desc = "一面极其厚重的盾牌，只要你的体力撑得住，它应该什么都挡得下来。"
	icon = 'modular_zubbers/icons/obj/big_bertha_shield.dmi'
	lefthand_file = 'modular_zubbers/icons/mob/inhands/big_bertha_both.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/big_bertha_both.dmi'
	icon_state = "big_bertha"
	block_chance = 100
	slot_flags = null
	force = 12
	throwforce = 3
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("推撞", "猛砸","用大贝莎重击")
	attack_verb_simple = list("推撞", "猛砸","用大贝莎重击")
	armor_type = /datum/armor/big_bertha
	block_sound = 'sound/items/weapons/block_shield.ogg'
	breakable_by_damage = FALSE
	item_flags = IMMUTABLE_SLOW | SLOWS_WHILE_IN_HAND
	slowdown = 2
	transparent = FALSE

/obj/item/shield/big_bertha/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)
	RemoveElement(/datum/element/disarm_attack)

/obj/item/shield/big_bertha/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)

	. = ..()

	if(damage < 10) //Most things that deal 10 or more damage are heavy, like toolboxes.
		return

	if(prob(owner.get_stamina_loss()))
		owner.visible_message(
			span_warning("[hitby]的[attack_text]将[owner]击倒！"),
			span_userdanger("[hitby]的[attack_text]将你击倒！"),
			span_notice("你听见一声沉重的撞击声！"),
			COMBAT_MESSAGE_RANGE
		)
		owner.Knockdown(2 SECONDS) //The shield saved you, but at what cost?

	owner.adjust_stamina_loss(damage*0.5)
	owner.set_jitter_if_lower(1 SECONDS)
	owner.Immobilize(1 SECONDS)


/datum/armor/big_bertha
	melee = 100
	bullet = 100
	laser = 75
	bomb = 50
	fire = 80
	acid = 70
