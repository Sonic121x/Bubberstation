/datum/uplink_item/species_restricted/lycan_booster
	name = "狼人化增幅剂"
	desc = "一种由纳米机器人与一般意义上的“坏情绪”调配而成的高级混合物，能大幅提升你的 \
	狼人形态的战斗能力，赋予可观的抗伤害、抗警棍能力与再生能力，并进一步磨利你的爪子。此外还能让你精通体能。"
	cost = 15
	item = /obj/item/lycan_booster
	restricted_species = list(SPECIES_CURSEKIN)
	surplus = 0

/obj/item/lycan_booster
	name = "狼人化增幅剂"
	desc = "一种由纳米机器人与一般意义上的“坏情绪”调配而成的高级混合物，能大幅提升你的 \
	狼人形态的战斗能力，赋予可观的抗伤害、抗警棍能力与再生能力，进一步磨利你的爪子，还有其他种种提升。 \
	此外还能让你精通体能。"
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "dnainjector"
	inhand_icon_state = "dnainjector"
	worn_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

/obj/item/lycan_booster/attack_self(mob/user, modifiers)
	. = ..()

	if (!ishuman(user))
		return

	var/mob/living/carbon/human/human_user = user

	if (!istype(human_user.dna?.species, /datum/species/human/cursekin))
		to_chat(human_user, span_warning("你感觉你目前的生理结构撑不住这种增幅剂。"))
		return

	to_chat(human_user, span_bolddanger("血清注入体内，你开始感到自己与身上的狼人诅咒从未如此契合。你的爪子变得锋利，牙齿也变长了……"))
	human_user.add_gaian_physique()

	qdel(src)

/mob/living/carbon/human/proc/add_gaian_physique()
	ADD_TRAIT(src, TRAIT_GAIAN_PHYSIQUE, SPECIES_TRAIT)

	balloon_alert(src, "狼人形态已强化")
	to_chat(src, span_boldnotice("你的狼人形态现在能抵抗伤害与警棍，并且不受伤害减速影响。此外，你的徒手攻击致命得多，对被抓住的对手更是强得离谱。可以考虑去弄一副抓握手套。"))
	emote("growl")

	mind?.adjust_experience(/datum/skill/athletics, SKILL_EXP_MASTER, FALSE)
