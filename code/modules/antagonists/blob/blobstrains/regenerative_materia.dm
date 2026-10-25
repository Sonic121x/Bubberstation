//does toxin damage, hallucination, targets think they're not hurt at all
/datum/blobstrain/reagent/regenerative_materia
	name = "再生物质"
	description = "会造成中等的初始毒素伤害，并注入一种毒素，造成更多毒素伤害并让目标以为自己已经完全痊愈。核心的再生速度大幅提升。"
	analyzerdescdamage = "造成中等的初始毒素伤害，并注入一种毒素，造成更多毒素伤害并让目标以为自己已经完全痊愈。核心的再生速度大幅提升。"
	color = "#A88FB7"
	complementary_color = "#AF7B8D"
	message_living = "，你感觉自己<i>充满生机</i>"
	reagent = /datum/reagent/blob/regenerative_materia
	core_regen_bonus = 18
	point_rate_bonus = 1

/datum/reagent/blob/regenerative_materia
	name = "再生物质"
	description = "一种造成毒素伤害并让目标以为自己已经完全痊愈的化学物质。再生物质变形菌会将其注入受害者体内。"
	taste_description = "天堂"
	color = "#A88FB7"

/datum/reagent/blob/regenerative_materia/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	if(iscarbon(exposed_mob))
		exposed_mob.adjust_drugginess(reac_volume * 2 SECONDS)
	if(exposed_mob.reagents)
		exposed_mob.reagents.add_reagent(/datum/reagent/blob/regenerative_materia, 0.2*reac_volume)
		exposed_mob.reagents.add_reagent(/datum/reagent/toxin/spore, 0.2*reac_volume)
	exposed_mob.apply_damage(0.7*reac_volume, TOX)

/datum/reagent/blob/regenerative_materia/on_mob_life(mob/living/carbon/metabolizer, seconds_per_tick, metabolization_ratio)
	. = ..()
	if(metabolizer.adjust_tox_loss(0.5 * metabolization_ratio * seconds_per_tick, updating_health = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/blob/regenerative_materia/on_mob_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)

/datum/reagent/blob/regenerative_materia/on_mob_end_metabolize(mob/living/metabolizer)
	. = ..()
	metabolizer.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, type)
