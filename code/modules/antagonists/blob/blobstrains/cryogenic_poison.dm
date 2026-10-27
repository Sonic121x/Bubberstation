//does brute, burn, and toxin damage, and cools targets down
/datum/blobstrain/reagent/cryogenic_poison
	name = "低温毒剂"
	description = "会向目标注入冻寒毒剂，造成的直接冲击伤害较低，但会持续造成高额伤害。"
	analyzerdescdamage = "向目标注入冻寒毒剂，会逐渐使目标的内脏凝固。"
	color = "#8BA6E9"
	complementary_color = "#7D6EB4"
	blobbernaut_message = "注入"
	message = "变形菌刺向你"
	message_living = "，你感觉自己的内脏正在凝固"
	reagent = /datum/reagent/blob/cryogenic_poison

/datum/reagent/blob/cryogenic_poison
	name = "低温毒剂"
	description = "一种冻寒毒剂，会持续造成高额伤害。低温毒剂变形菌会将其注入受害者体内。"
	color = "#8BA6E9"
	taste_description = "脑仁冻僵"

/datum/reagent/blob/cryogenic_poison/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	if(exposed_mob.reagents)
		exposed_mob.reagents.add_reagent(/datum/reagent/consumable/frostoil, 0.3*reac_volume)
		exposed_mob.reagents.add_reagent(/datum/reagent/consumable/ice, 0.3*reac_volume)
		exposed_mob.reagents.add_reagent(/datum/reagent/blob/cryogenic_poison, 0.3*reac_volume)
	exposed_mob.apply_damage(0.2*reac_volume, BRUTE, wound_bonus=CANT_WOUND)

/datum/reagent/blob/cryogenic_poison/on_mob_life(mob/living/carbon/exposed_mob, seconds_per_tick, metabolization_ratio)
	. = ..()
	var/need_mob_update
	need_mob_update = exposed_mob.adjust_brute_loss(0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	need_mob_update += exposed_mob.adjust_fire_loss(0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	need_mob_update += exposed_mob.adjust_tox_loss(0.25 * metabolization_ratio * seconds_per_tick, updating_health = FALSE)
	if(need_mob_update)
		. = UPDATE_MOB_HEALTH
