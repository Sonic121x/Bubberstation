/obj/item/melee/fakebeesword
	name = "毒刺"
	desc = "一把“毒刺”的廉价仿制品。威力远远不及正品，难怪它的主人会死。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "beesword"
	inhand_icon_state = "stinger"
	worn_icon_state = "stinger"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	throwforce = 10
	attack_speed = CLICK_CD_RAPID
	block_chance = 20
	armour_penetration = 65
	attack_verb_continuous = list("劈砍", "蜇刺", "扎", "戳")
	attack_verb_simple = list("劈砍", "蜇刺", "扎", "戳")
	hitsound = 'sound/items/weapons/rapierhit.ogg'

/obj/item/melee/fakebeesword/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.reagents.add_reagent(/datum/reagent/toxin/bad_food, 1)
