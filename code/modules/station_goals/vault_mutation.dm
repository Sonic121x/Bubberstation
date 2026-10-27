
/datum/mutation/breathless
	name = "无需呼吸"
	desc = "受试者的皮肤会过滤并吸收空气中的氧气，从而无需呼吸。"
	text_gain_indication = span_notice("你的肺感觉棒极了。")
	text_lose_indication = span_warning("你的肺又恢复了正常。")
	locked = TRUE

/datum/mutation/breathless/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	ADD_TRAIT(acquirer, TRAIT_NOBREATH, GENETIC_MUTATION)

/datum/mutation/breathless/on_losing(mob/living/carbon/human/owner)//this shouldnt happen under normal condition but just to be sure
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NOBREATH, GENETIC_MUTATION)

/datum/mutation/quick
	name = "迅捷"
	desc = "受试者的腿部肌肉增强，行动更为迅速。"
	text_gain_indication = span_notice("你的双腿感觉更快、更强壮。")
	text_lose_indication = span_warning("你的双腿感觉更弱、更迟缓。")
	locked = TRUE

/datum/mutation/quick/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.add_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)

/datum/mutation/quick/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/dna_vault_speedup)

/datum/mutation/tough
	name = "坚韧"
	desc = "受试者长出另一层表皮，更能抵抗淤伤、割伤或撕裂。"
	text_gain_indication = span_notice("你的皮肤感觉更坚韧了。")
	text_lose_indication = span_warning("你的皮肤感觉变弱了。")
	locked = TRUE

/datum/mutation/tough/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.brute_mod *= 0.7
	ADD_TRAIT(acquirer, TRAIT_PIERCEIMMUNE, GENETIC_MUTATION)

/datum/mutation/tough/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.brute_mod /= 0.7
	REMOVE_TRAIT(owner, TRAIT_PIERCEIMMUNE, GENETIC_MUTATION)

/datum/mutation/dextrous
	name = "灵巧"
	desc = "受试者的神经元运转更快，反应与行动更为敏捷。"
	text_gain_indication = span_notice("你的四肢感觉更灵巧、反应更敏捷。")
	text_lose_indication = span_warning("你的四肢感觉不那么灵巧敏捷了。")
	locked = TRUE

/datum/mutation/dextrous/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.next_move_modifier *= 0.5

/datum/mutation/dextrous/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.next_move_modifier /= 0.5

/datum/mutation/fire_immunity
	name = "火焰免疫"
	desc = "受试者变得完全不可燃，并能承受更高的温度。"
	text_gain_indication = span_notice("你的身体感觉能够抵御火焰。")
	text_lose_indication = span_warning("你的身体又感觉怕火了。")
	locked = TRUE

/datum/mutation/fire_immunity/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.burn_mod *= 0.5
	acquirer.add_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), GENETIC_MUTATION)

/datum/mutation/fire_immunity/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.burn_mod /= 0.5
	owner.remove_traits(list(TRAIT_RESISTHEAT, TRAIT_NOFIRE), GENETIC_MUTATION)

/datum/mutation/quick_recovery
	name = "快速恢复"
	desc = "受试者的神经末梢较少，因此能更快地从失去行动能力中恢复。"
	text_gain_indication = span_notice("你感觉自己更容易从摔倒中恢复。")
	text_lose_indication = span_warning("你又觉得从摔倒中恢复是件难事了。")
	locked = TRUE

/datum/mutation/quick_recovery/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	acquirer.physiology.stun_mod *= 0.5

/datum/mutation/quick_recovery/on_losing(mob/living/carbon/human/owner)
	. = ..()
	owner.physiology.stun_mod /= 0.5

/datum/mutation/plasmocile
	name = "等离子耐受"
	desc = "受试者的肺部发生突变，获得对病毒与等离子体毒性的免疫。"
	text_gain_indication = span_notice("你的肺部感觉能抵抗空气中的污染物。")
	text_lose_indication = span_warning("你的肺部又感觉容易受空气污染物侵害了。")
	locked = TRUE

/datum/mutation/plasmocile/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	var/obj/item/organ/lungs/improved_lungs = acquirer.get_organ_slot(ORGAN_SLOT_LUNGS)
	ADD_TRAIT(owner, TRAIT_VIRUSIMMUNE, GENETIC_MUTATION)
	if(improved_lungs)
		apply_buff(improved_lungs)
	RegisterSignal(acquirer, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(remove_modification))
	RegisterSignal(acquirer, COMSIG_CARBON_GAIN_ORGAN, PROC_REF(reapply_modification))

/datum/mutation/plasmocile/on_losing(mob/living/carbon/human/owner)
	. = ..()
	var/obj/item/organ/lungs/improved_lungs = owner.get_organ_slot(ORGAN_SLOT_LUNGS)
	REMOVE_TRAIT(owner, TRAIT_VIRUSIMMUNE, GENETIC_MUTATION)
	UnregisterSignal(owner, COMSIG_CARBON_LOSE_ORGAN)
	UnregisterSignal(owner, COMSIG_CARBON_GAIN_ORGAN)
	if(improved_lungs)
		remove_buff(improved_lungs)

/datum/mutation/plasmocile/proc/remove_modification(mob/source, obj/item/organ/old_organ)
	SIGNAL_HANDLER

	if(istype(old_organ, /obj/item/organ/lungs))
		remove_buff(old_organ)

/datum/mutation/plasmocile/proc/reapply_modification(mob/source, obj/item/organ/new_organ)
	SIGNAL_HANDLER

	if(istype(new_organ, /obj/item/organ/lungs))
		apply_buff(new_organ)

/datum/mutation/plasmocile/proc/apply_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min *= 0
	our_lungs.plas_breath_dam_max *= 0

/datum/mutation/plasmocile/proc/remove_buff(obj/item/organ/lungs/our_lungs)
	our_lungs.plas_breath_dam_min = initial(our_lungs.plas_breath_dam_min)
	our_lungs.plas_breath_dam_max = initial(our_lungs.plas_breath_dam_max)
