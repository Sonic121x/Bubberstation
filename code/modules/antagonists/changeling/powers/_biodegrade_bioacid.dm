/datum/reagent/toxin/acid/bio_acid
	name = "适应性生物酸"
	description = "一种看似源自生物的极强酸性物质。其中密布着微观生物，它们似乎会改变其成分，\
	以最具适应性的方式溶解接触到的任何东西。"
	color = "#9455ff"
	creation_purity = 100
	toxpwr = 0
	acidpwr = 0
	ph = 0.0
	penetrates_skin = TOUCH

/datum/reagent/toxin/acid/bio_acid/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection)
	if(IS_CHANGELING(exposed_mob))
		to_chat(exposed_mob, span_changeling("我们分泌一种生物制剂来中和生物酸。这是例行且条件反射般的行为。"))
		volume = min(0.1, volume)
		holder.update_total()
		return
	. = ..()
	exposed_mob.adjust_fire_loss(round(reac_volume * min(1 - touch_protection), 0.1) * 3, required_bodytype = BODYTYPE_ORGANIC) // full bio protection = 100% damage reduction
	exposed_mob.acid_act(10, 50)

/datum/reagent/toxin/acid/bio_acid/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(SPT_PROB(50, seconds_per_tick))
		affected_mob.emote(pick("screech", "cry"))
