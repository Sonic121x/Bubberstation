//does aoe brute damage when hitting targets, is immune to explosions
/datum/blobstrain/reagent/explosive_lattice
	name = "爆裂晶格"
	description = "会以小型爆炸进行攻击，对附近所有人造成中等程度的钝击与灼烧混合伤害。孢子会在死亡时爆炸。"
	effectdesc = "同时能抵抗爆炸，但受到火焰及其他能量来源的伤害会增加。"
	analyzerdescdamage = "在其目标周围引发小型爆炸，造成中等程度的钝击与灼烧混合伤害。孢子会在死亡时爆炸。"
	analyzerdesceffect = "对爆炸有很强的抗性，但受到火焰及其他能量来源的伤害会增加。"
	color = "#8B2500"
	complementary_color = "#00668B"
	blobbernaut_message = "轰击"
	message = "变形菌轰击了你"
	reagent = /datum/reagent/blob/explosive_lattice

/datum/blobstrain/reagent/explosive_lattice/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_flag == BOMB)
		return 0
	else if(damage_flag != MELEE && damage_flag != BULLET && damage_flag != LASER)
		return damage * 1.5
	return ..()

/datum/blobstrain/reagent/explosive_lattice/on_sporedeath(mob/living/dead_spore, death_cloud_size)
	var/obj/effect/temp_visual/explosion/fast/effect = new /obj/effect/temp_visual/explosion/fast(get_turf(dead_spore))
	effect.alpha = 150
	for(var/mob/living/actor in orange(get_turf(dead_spore), death_cloud_size))
		if(actor.has_faction(ROLE_BLOB)) // No friendly fire
			continue
		//increases damage to mobs if death_cloud_size is increased, but the damage falls off with distance.
		var/damage_total = (10 + 10 * death_cloud_size) / max(1, get_dist(get_turf(dead_spore), get_turf(actor)))
		//split damage between brute and burn
		actor.take_overall_damage(damage_total / 2, damage_total / 2)
		playsound(dead_spore , 'sound/effects/explosion/explosion2.ogg', 20 + 20 * death_cloud_size, TRUE)

/datum/reagent/blob/explosive_lattice
	name = "爆裂晶格"
	taste_description = "炸弹"
	color = "#8B2500"

/datum/reagent/blob/explosive_lattice/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	var/brute_loss = 0
	var/burn_loss = 0
	var/bomb_armor = 0
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)

	if(reac_volume > 10) // If it's not coming from a sporecloud, AOE 'explosion' damage
		var/epicenter_turf = get_turf(exposed_mob)
		var/obj/effect/temp_visual/explosion/fast/ex_effect = new /obj/effect/temp_visual/explosion/fast(get_turf(exposed_mob))
		ex_effect.alpha = 150

		// Total damage to epicenter mob of 0.7*reac_volume, like a mid-tier strain
		brute_loss = reac_volume*0.35

		bomb_armor = exposed_mob.getarmor(null, BOMB)
		if(bomb_armor) // Same calculation and proc that ex_act uses on mobs
			brute_loss = brute_loss*(2 - round(bomb_armor*0.01, 0.05))

		burn_loss = brute_loss

		exposed_mob.take_overall_damage(brute_loss, burn_loss)

		for(var/mob/living/nearby_mob in orange(epicenter_turf, 1))
			if(nearby_mob.has_faction(ROLE_BLOB)) // No friendly fire.
				continue
			if(nearby_mob == exposed_mob) // We've already hit the epicenter mob
				continue
			// AoE damage of 0.5*reac_volume to everyone in a 1 tile range
			brute_loss = reac_volume*0.25
			burn_loss = brute_loss

			bomb_armor = nearby_mob.getarmor(null, BOMB)
			if(bomb_armor) // Same calculation and prod that ex_act uses on mobs
				brute_loss = brute_loss*(2 - round(bomb_armor*0.01, 0.05))
				burn_loss = brute_loss

			nearby_mob.take_overall_damage(brute_loss, burn_loss)

	else
		exposed_mob.apply_damage(0.6*reac_volume, BRUTE, wound_bonus=CANT_WOUND)
