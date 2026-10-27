/obj/item/stack/medical/suture/bloody
	name = "止血缝合线"
	desc = "浸有凝血剂的无菌缝合线，用于封闭割伤与撕裂伤并逆转严重出血。"
	icon = 'modular_skyrat/modules/food_replicator/icons/medicine.dmi'
	icon_state = "hemo_suture"
	heal_brute = 7
	stop_bleeding = 1
	merge_type = /obj/item/stack/medical/suture/bloody

/obj/item/stack/medical/suture/bloody/grind_results()
	return list(/datum/reagent/medicine/coagulant = 2)


/obj/item/stack/medical/suture/bloody/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	if(healed_mob.blood_volume <= BLOOD_VOLUME_SAFE)
		healed_mob.reagents.add_reagent(/datum/reagent/medicine/salglu_solution, 2)
		healed_mob.adjust_oxy_loss(-amount_healed)

/obj/item/stack/medical/mesh/bloody
	name = "止血网"
	desc = "一种用于处理烧伤并促进造血的止血网。由于其与血液相关的用途，消毒抗感染效果较差。"
	icon = 'modular_skyrat/modules/food_replicator/icons/medicine.dmi'
	icon_state = "hemo_mesh"
	heal_burn = 7
	sanitization = 0.5
	flesh_regeneration = 1.75
	stop_bleeding = 0.25
	merge_type = /obj/item/stack/medical/mesh/bloody

/obj/item/stack/medical/mesh/bloody/grind_results()
	return list(/datum/reagent/medicine/coagulant = 2)

/obj/item/stack/medical/mesh/bloody/update_icon_state()
	if(is_open)
		return ..()

	icon_state = "hemo_mesh_closed"

/obj/item/stack/medical/mesh/bloody/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	if(healed_mob.blood_volume <= BLOOD_VOLUME_SAFE)
		healed_mob.reagents.add_reagent(/datum/reagent/medicine/salglu_solution, 2)
		healed_mob.adjust_oxy_loss(-amount_healed)

/obj/item/reagent_containers/hypospray/medipen/glucose
	name = "葡萄糖注射笔"
	desc = "一支装有合成葡萄糖的注射笔，适合在长时间的舱外活动值班中维持体力，或在医疗环境中作为应急营养。"
	icon = 'modular_skyrat/modules/food_replicator/icons/medicine.dmi'
	icon_state = "glupen"
	inhand_icon_state = "stimpen"
	base_icon_state = "glupen"
	volume = 15
	amount_per_transfer_from_this = 15
	list_reagents = list(/datum/reagent/consumable/nutriment/glucose = 15)
