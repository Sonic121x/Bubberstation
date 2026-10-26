/obj/structure/water_source/puddle/healing
	name = "治疗水洼"
	desc = "在某种异界力量的作用下，这滩水似乎能缓慢地让万物再生！"
	color = "#71ffff"
	light_range = 3
	light_color = "#71ffff"
	/// How much do we heal the current person?
	var/heal_amount = 2

/obj/structure/water_source/puddle/healing/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/water_source/puddle/healing/process(seconds_per_tick)
	for(var/mob/living/iterating_mob in loc)
		iterating_mob.heal_overall_damage(heal_amount, heal_amount)
		playsound(src, 'modular_skyrat/modules/emotes/sound/emotes/jelly_scream.ogg', 100)

