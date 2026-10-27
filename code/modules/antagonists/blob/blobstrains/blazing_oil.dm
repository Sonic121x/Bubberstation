
//sets you on fire, does burn damage, explodes into flame when burnt, weak to water
/datum/blobstrain/reagent/blazing_oil
	name = "炽燃燃油"
	description = "会造成中高额烧伤伤害且无视护甲，并点燃目标。"
	effectdesc = "还会在燃烧时释放出阵阵烈焰，但会受到水造成的伤害。"
	analyzerdescdamage = "造成中高额烧伤伤害，并点燃目标。"
	analyzerdesceffect = "燃烧时释放火焰，但会受到水和其他灭火液体造成的伤害。"
	color = "#B68D00"
	complementary_color = "#BE5532"
	blobbernaut_message = "泼洒"
	message = "变形菌将炽热的燃油泼向你"
	message_living = "，你感觉自己的皮肤被烧焦、熔化"
	reagent = /datum/reagent/blob/blazing_oil

/datum/blobstrain/reagent/blazing_oil/extinguish_reaction(obj/structure/blob/B)
	B.take_damage(4.5, BURN, ENERGY)

/datum/blobstrain/reagent/blazing_oil/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_type == BURN && damage_flag != ENERGY)
		for(var/turf/open/T in range(1, B))
			var/obj/structure/blob/C = locate() in T
			if(!(C && C.overmind && C.overmind.blobstrain.type == B.overmind.blobstrain.type) && prob(80))
				new /obj/effect/hotspot(T)
	if(damage_flag == FIRE)
		return 0
	return ..()

/datum/reagent/blob/blazing_oil
	name = "炽燃燃油"
	taste_description = "燃烧的燃油"
	color = "#B68D00"

/datum/reagent/blob/blazing_oil/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.adjust_fire_stacks(round(reac_volume/10))
	exposed_mob.ignite_mob()
	if(exposed_mob)
		exposed_mob.apply_damage(0.8*reac_volume, BURN, wound_bonus=CANT_WOUND)
	if(iscarbon(exposed_mob))
		exposed_mob.emote("scream")
