//does brute damage, bonus damage for each nearby blob, and spreads damage out
/datum/blobstrain/reagent/synchronous_mesh
	name = "同步网格"
	description = "会造成较低的钝击伤害，但附近每个变形菌都会一同攻击目标，伤害可叠加。"
	effectdesc = "还会在受击变形菌附近的各个变形菌之间分摊伤害。"
	analyzerdescdamage = "造成较低的钝击伤害，目标附近每有一个变形菌，伤害便会提高。"
	analyzerdesceffect = "受到攻击时，在受击变形菌附近的所有变形菌之间分摊伤害。"
	color = "#65ADA2"
	complementary_color = "#AD6570"
	blobbernaut_message = "同步打击"
	message = "变形菌群打击了你"
	reagent = /datum/reagent/blob/synchronous_mesh

/datum/blobstrain/reagent/synchronous_mesh/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER) //the cause isn't fire or bombs, so split the damage
		var/damagesplit = 1 //maximum split is 9, reducing the damage each blob takes to 11% but doing that damage to 9 blobs
		var/list/blob_structures = orange(1, B)
		for(var/obj/structure/blob/C in blob_structures)
			if(!C.ignore_syncmesh_share && C.overmind && C.overmind.blobstrain.type == B.overmind.blobstrain.type) //if it doesn't have the same chemical or is a core or node, don't split damage to it
				damagesplit += 1
		for(var/obj/structure/blob/C in blob_structures)
			if(!C.ignore_syncmesh_share && C.overmind && C.overmind.blobstrain.type == B.overmind.blobstrain.type) //only hurt blobs that have the same overmind chemical and aren't cores or nodes
				C.take_damage(damage/damagesplit, damage_type, 0, 0)
		return damage / damagesplit
	else
		return damage * 1.25

/datum/reagent/blob/synchronous_mesh
	name = "同步网格"
	taste_description = "有毒霉菌"
	color = "#65ADA2"

/datum/reagent/blob/synchronous_mesh/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/eye/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.apply_damage(0.2*reac_volume, BRUTE, wound_bonus=CANT_WOUND)
	if(exposed_mob && reac_volume)
		for(var/obj/structure/blob/nearby_blob in range(1, exposed_mob)) //if the target is completely surrounded, this is 2.4*reac_volume bonus damage, total of 2.6*reac_volume
			if(exposed_mob)
				nearby_blob.blob_attack_animation(exposed_mob) //show them they're getting a bad time
				exposed_mob.apply_damage(0.3*reac_volume, BRUTE, wound_bonus=CANT_WOUND)
