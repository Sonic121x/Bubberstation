//does brute damage through armor and bio resistance
/datum/blobstrain/reagent/reactive_spines
	name = "反应棘刺"
	description = "会穿过护甲和生物抗性造成高额钝击伤害。"
	effectdesc = "在受到灼烧或钝击伤害时也会产生反应，攻击近战范围内的所有目标。"
	analyzerdescdamage = "造成高额钝击伤害，无视护甲和生物抗性。"
	analyzerdesceffect = "受到灼烧或钝击伤害时会猛烈反击，攻击附近的所有目标。"
	color = "#9ACD32"
	complementary_color = "#FFA500"
	blobbernaut_message = "刺击"
	message = "变形菌刺向你"
	reagent = /datum/reagent/blob/reactive_spines
	COOLDOWN_DECLARE(retaliate_cooldown)

/datum/blobstrain/reagent/reactive_spines/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage && ((damage_type == BRUTE) || (damage_type == BURN)) && B.get_integrity() - damage > 0 && COOLDOWN_FINISHED(src, retaliate_cooldown)) // Is there any damage, is it burn or brute, will we be alive, and has the cooldown finished?
		COOLDOWN_START(src, retaliate_cooldown, 2.5 SECONDS) // 2.5 seconds before auto-retaliate can whack everything within 1 tile again
		B.visible_message(span_boldwarning("变形菌展开反击，猛烈抽打！"))
		for(var/atom/thing in range(1, B))
			if(!thing.can_blob_attack())
				continue
			var/attacked_turf = get_turf(thing)
			if(isliving(thing) && !HAS_TRAIT(thing, TRAIT_BLOB_ALLY)) // Make sure to inject strain-reagents with automatic attacks when needed.
				B.blob_attack_animation(attacked_turf, overmind)
				attack_living(thing)

			else if(thing.blob_act(B)) // After checking for mobs, whack everything else with the standard attack
				B.blob_attack_animation(attacked_turf, overmind) // Only play the animation if the attack did something meaningful

	return ..()

/datum/reagent/blob/reactive_spines
	name = "反应棘刺"
	taste_description = "岩石"
	color = "#9ACD32"

/datum/reagent/blob/reactive_spines/return_mob_expose_reac_volume(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	if(exposed_mob.stat == DEAD || HAS_TRAIT(exposed_mob, TRAIT_BLOB_ALLY))
		return 0 //the dead, and blob mobs, don't cause reactions
	return reac_volume

/datum/reagent/blob/reactive_spines/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.adjust_brute_loss(reac_volume)
