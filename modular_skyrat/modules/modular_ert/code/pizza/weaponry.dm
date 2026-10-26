/obj/item/knife/hotknife
	name = "千度刀"
	icon = 'modular_skyrat/modules/modular_ert/icons/pizza/hotknife.dmi'
	icon_state = "hotknife"
	inhand_icon_state = "hotknife"
	desc = "这把剑曾被称为“光明使者”，如今却被贬为一把普通的披萨切刀……它或许还留着火焰攻击的能力。"
	righthand_file = 'modular_skyrat/modules/modular_ert/icons/pizza/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_ert/icons/pizza/lefthand.dmi'

	/// How many fire stacks to apply on attack
	var/fire_stacks = 4

/obj/item/knife/hotknife/attack(mob/living/victim, mob/living/attacker, params)
	victim.adjust_fire_stacks(fire_stacks)
	victim.ignite_mob()
	return ..()
