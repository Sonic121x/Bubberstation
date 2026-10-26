#define LIVER_DEFAULT_TOX_TOLERANCE 3 //amount of toxins the liver can filter out
#define LIVER_DEFAULT_TOX_RESISTANCE 1 //lower values lower how harmful toxins are to the liver
#define LIVER_FAILURE_STAGE_SECONDS 60 //amount of seconds before liver failure reaches a new stage

/obj/item/organ/liver
	name = "肝脏"
	desc = "搭配建议：基安蒂红酒配蚕豆。"
	icon_state = "liver"

	w_class = WEIGHT_CLASS_SMALL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LIVER

	maxHealth = STANDARD_ORGAN_THRESHOLD
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY // smack in the middle of decay times

	food_reagents = list(/datum/reagent/consumable/nutriment/organ_tissue = 5, /datum/reagent/iron = 5)

	cell_line = CELL_LINE_ORGAN_LIVER
	cells_minimum = 1
	cells_maximum = 2

	visual = FALSE

	/// Affects how much damage the liver takes from alcohol
	var/alcohol_tolerance = ALCOHOL_RATE
	/// The maximum volume of toxins the liver will ignore
	var/toxTolerance = LIVER_DEFAULT_TOX_TOLERANCE
	/// Modifies how much damage toxin deals to the liver
	var/liver_resistance = LIVER_DEFAULT_TOX_RESISTANCE
	var/filterToxins = TRUE //whether to filter toxins
	var/operated = FALSE //whether the liver's been repaired with surgery and can be fixed again or not

/obj/item/organ/liver/Initialize(mapload)
	. = ..()
	// If the liver handles foods like a clown, it honks like a bike horn
	// Don't think about it too much.
	RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_COMEDY_METABOLISM), PROC_REF(on_add_comedy_metabolism))
	RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_COMEDY_METABOLISM), PROC_REF(on_remove_comedy_metabolism))

/obj/item/organ/liver/grind_results()
	return list(/datum/reagent/consumable/nutriment/peptides = 5)

/* Signal handler for the liver gaining the TRAIT_COMEDY_METABOLISM trait
 *
 * Adds the "squeak" component, so clown livers will act just like their
 * bike horns, and honk when you hit them with things, or throw them
 * against things, or step on them.
 *
 * The removal of the component, if this liver loses that trait, is handled
 * by the component itself.
 */
/obj/item/organ/liver/proc/on_add_comedy_metabolism()
	SIGNAL_HANDLER

	// Are clown "bike" horns made from the livers of ex-clowns?
	// Would that make the clown more or less likely to honk it
	AddComponent(/datum/component/squeak, list('sound/items/bikehorn.ogg'=1), 50, falloff_exponent = 20)

/* Signal handler for the liver losing the TRAIT_COMEDY_METABOLISM trait
 *
 * Basically just removes squeak component
 */
/obj/item/organ/liver/proc/on_remove_comedy_metabolism()
	SIGNAL_HANDLER

	qdel(GetComponent(/datum/component/squeak))

/obj/item/organ/liver/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	RegisterSignal(organ_owner, COMSIG_MOB_REAGENT_TICK, PROC_REF(handle_chemical))
	RegisterSignal(organ_owner, COMSIG_ATOM_EXAMINE, PROC_REF(on_owner_examine))

/obj/item/organ/liver/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, list(COMSIG_MOB_REAGENT_TICK, COMSIG_ATOM_EXAMINE))

/**
 * This proc can be overriden by liver subtypes so they can handle certain chemicals in special ways.
 * Return null to continue running the normal on_mob_life() for that reagent.
 * Return COMSIG_MOB_STOP_REAGENT_TICK to not run the normal metabolism effects.
 *
 * NOTE: If you return COMSIG_MOB_STOP_REAGENT_TICK, that reagent will not be removed like normal! You must handle it manually.
 **/
/obj/item/organ/liver/proc/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick, metabolization_rate)
	SIGNAL_HANDLER

/obj/item/organ/liver/examine(mob/user)
	. = ..()

	if(HAS_MIND_TRAIT(user, TRAIT_ENTRAILS_READER) || isobserver(user))
		if(HAS_TRAIT(src, TRAIT_LAW_ENFORCEMENT_METABOLISM))
			. += span_info("脂肪沉积和糖粒残留说明这是<em>安保</em>部门某人的肝脏。")
		if(HAS_TRAIT(src, TRAIT_CULINARY_METABOLISM))
			. += span_info("高含铁量和淡淡的蒜味说明这是一名<em>厨师</em>的肝脏。")
		if (HAS_TRAIT(src, TRAIT_BARTENDER_METABOLISM))
			. += span_info("从长期接触各类酒精留下的明显使用痕迹来看，这是一名<em>酒保</em>的肝脏。")
		if(HAS_TRAIT(src, TRAIT_COMEDY_METABOLISM))
			. += span_info("香蕉的气味、滑腻的光泽，以及被按压时发出的[span_clown("喇叭声")]，说明这是一名<em>小丑</em>的肝脏。")
		if(HAS_TRAIT(src, TRAIT_MEDICAL_METABOLISM))
			. += span_info("压力留下的痕迹和淡淡的药用酒精气味，说明这是一名<em>医务工作者</em>的肝脏。")
		if(HAS_TRAIT(src, TRAIT_ENGINEER_METABOLISM))
			. += span_info("辐射暴露和太空适应的迹象，说明这是一名<em>工程师</em>的肝脏。")
		if(HAS_TRAIT(src, TRAIT_SCIENTIST_LIVER))
			. += span_info("奇怪的发光残留物、凝结的固态等离子体颗粒，以及看起来像肿瘤的东西，表明这是一名<em>科学家</em>受过辐射的肝脏。")
		if(HAS_TRAIT(src, TRAIT_MAINTENANCE_METABOLISM))
			. += span_info("（不知怎么做到的）半消化的老鼠尾巴、恶心的污泥，以及淡淡的灰牛能量饮料味，说明这是一名<em>助理</em>肝脏剩下的部分。")
		if(HAS_TRAIT(src, TRAIT_CORONER_METABOLISM))
			. += span_info("腌黄瓜和海水的气味，加上保存得异常完好，说明这是一名<em>验尸官</em>肝脏剩下的部分。")
		if(HAS_TRAIT(src, TRAIT_HUMAN_AI_METABOLISM))
			. += span_info("这颗肝脏看起来几乎不像人类，却又完全能自给自足，说明这是一名<em>人类 AI</em>肝脏剩下的部分。")

		// royal trumps pretender royal
		if(HAS_TRAIT(src, TRAIT_ROYAL_METABOLISM))
			. += span_info("奢侈饮食养出的丰腴、柔软床铺养出的细嫩，说明这是一名<em>部门主管</em>的肝脏。")
		else if(HAS_TRAIT(src, TRAIT_PRETENDER_ROYAL_METABOLISM))
			. += span_info("仿制鱼子酱的饮食和失眠的迹象，说明这是<em>某个想当部门主管的人</em>的肝脏。")

/obj/item/organ/liver/before_organ_replacement(obj/item/organ/replacement)
	. = ..()
	if(!istype(replacement, type))
		return

	var/datum/job/owner_job = owner.mind?.assigned_role
	if(!owner_job || !LAZYLEN(owner_job.liver_traits))
		return

	// Transfer over liver traits from jobs, if we should have them
	for(var/readded_trait in owner_job.liver_traits)
		if(!HAS_TRAIT_FROM(src, readded_trait, JOB_TRAIT))
			continue
		ADD_TRAIT(replacement, readded_trait, JOB_TRAIT)

/obj/item/organ/liver/on_life(seconds_per_tick)
	. = ..()
	//If your liver is failing, then we use the liverless version of metabolize
	if((organ_flags & ORGAN_FAILING) || HAS_TRAIT(owner, TRAIT_LIVERLESS_METABOLISM))
		owner.reagents.end_metabolization(keep_liverless = TRUE)
		owner.reagents.metabolize(owner, seconds_per_tick, can_overdose = TRUE, liverless = TRUE)
		return

	owner.reagents?.metabolize(owner, seconds_per_tick, can_overdose = TRUE)

/obj/item/organ/liver/handle_failing_organs(seconds_per_tick)
	if(HAS_TRAIT(owner, TRAIT_STABLELIVER) || HAS_TRAIT(owner, TRAIT_LIVERLESS_METABOLISM))
		return
	return ..()

/obj/item/organ/liver/organ_failure(seconds_per_tick)
	switch(failure_time/LIVER_FAILURE_STAGE_SECONDS)
		if(1)
			to_chat(owner, span_userdanger("你感到腹部传来刀刺般的疼痛！"))
		if(2)
			to_chat(owner, span_userdanger("你感到内脏有灼烧感！"))
			owner.vomit(VOMIT_CATEGORY_DEFAULT)
		if(3)
			to_chat(owner, span_userdanger("你感到喉咙里有灼痛的酸液！"))
			owner.vomit(VOMIT_CATEGORY_BLOOD)
		if(4)
			to_chat(owner, span_userdanger("难以忍受的剧痛让你昏了过去！"))
			owner.vomit(VOMIT_CATEGORY_BLOOD, distance = rand(1,2))
			owner.emote("Scream")
			owner.AdjustUnconscious(2.5 SECONDS)
		if(5)
			to_chat(owner, span_userdanger("你感觉自己的内脏快要融化了！"))
			owner.vomit(VOMIT_CATEGORY_BLOOD, distance = rand(1,3))
			owner.emote("Scream")
			owner.AdjustUnconscious(5 SECONDS)

	switch(failure_time)
		//After 60 seconds we begin to feel the effects
		if(1 * LIVER_FAILURE_STAGE_SECONDS to 2 * LIVER_FAILURE_STAGE_SECONDS - 1)
			owner.adjust_tox_loss(0.2 * seconds_per_tick,forced = TRUE)
			owner.adjust_disgust(0.1 * seconds_per_tick)

		if(2 * LIVER_FAILURE_STAGE_SECONDS to 3 * LIVER_FAILURE_STAGE_SECONDS - 1)
			owner.adjust_tox_loss(0.4 * seconds_per_tick,forced = TRUE)
			owner.adjust_drowsiness(0.5 SECONDS * seconds_per_tick)
			owner.adjust_disgust(0.3 * seconds_per_tick)

		if(3 * LIVER_FAILURE_STAGE_SECONDS to 4 * LIVER_FAILURE_STAGE_SECONDS - 1)
			owner.adjust_tox_loss(0.6 * seconds_per_tick,forced = TRUE)
			owner.adjust_organ_loss(pick(ORGAN_SLOT_HEART,ORGAN_SLOT_LUNGS,ORGAN_SLOT_STOMACH,ORGAN_SLOT_EYES,ORGAN_SLOT_EARS),0.2 * seconds_per_tick)
			owner.adjust_drowsiness(1 SECONDS * seconds_per_tick)
			owner.adjust_disgust(0.6 * seconds_per_tick)

			if(SPT_PROB(1.5, seconds_per_tick))
				owner.emote("drool")

		if(4 * LIVER_FAILURE_STAGE_SECONDS to INFINITY)
			owner.adjust_tox_loss(0.8 * seconds_per_tick,forced = TRUE)
			owner.adjust_organ_loss(pick(ORGAN_SLOT_HEART,ORGAN_SLOT_LUNGS,ORGAN_SLOT_STOMACH,ORGAN_SLOT_EYES,ORGAN_SLOT_EARS),0.5 * seconds_per_tick)
			owner.adjust_drowsiness(1.6 SECONDS * seconds_per_tick)
			owner.adjust_disgust(1.2 * seconds_per_tick)

			if(SPT_PROB(3, seconds_per_tick))
				owner.emote("drool")

/obj/item/organ/liver/proc/on_owner_examine(datum/source, mob/user, list/examine_list)
	if(!ishuman(owner) || !(organ_flags & ORGAN_FAILING))
		return

	var/mob/living/carbon/human/humie_owner = owner
	if(!humie_owner.get_organ_slot(ORGAN_SLOT_EYES) || humie_owner.is_eyes_covered())
		return
	switch(failure_time)
		if(0 to 3 * LIVER_FAILURE_STAGE_SECONDS - 1)
			examine_list += span_notice("[owner] 的眼睛微微发黄。")
		if(3 * LIVER_FAILURE_STAGE_SECONDS to 4 * LIVER_FAILURE_STAGE_SECONDS - 1)
			examine_list += span_notice("[owner] 的眼睛完全发黄，显然十分痛苦。")
		if(4 * LIVER_FAILURE_STAGE_SECONDS to INFINITY)
			examine_list += span_danger("[owner] 的眼睛完全发黄，还肿得流脓。看样子已经活不了多久了。")

/obj/item/organ/liver/get_availability(datum/species/owner_species, mob/living/owner_mob)
	return owner_species.mutantliver

/obj/item/organ/liver/feel_for_damage(self_aware)
	if(damage < low_threshold)
		return
	if(damage < high_threshold)
		return span_warning("你的[self_aware ? "肝脏" : "下腹部"]隐隐作痛。")
	return span_boldwarning("你的[self_aware ? "肝脏" : "下腹部"]像着了火一样！")

// alien livers can ignore up to 15u of toxins, but they take x3 liver damage
/obj/item/organ/liver/alien
	name = "异形肝脏" // doesnt matter for actual aliens because they dont take toxin damage
	desc = "一颗曾经属于某个杀手异形的肝脏，天知道它以前都吃些什么。"
	icon_state = "liver-x" // Same sprite as fly-person liver.
	liver_resistance = 0.333 * LIVER_DEFAULT_TOX_RESISTANCE // -66%
	toxTolerance = 15 // complete toxin immunity like xenos have would be too powerful

/obj/item/organ/liver/ghost
	name = "幽灵肝脏"
	desc = "仍在处理他们生前喝下的最后一批酒精。"
	icon_state = "liver-ghost"
	movement_type = PHASING
	organ_flags = parent_type::organ_flags | ORGAN_GHOST

/obj/item/organ/liver/cybernetic
	name = "基础义体肝脏"
	desc = "一种非常基础的装置，用于模拟人类肝脏的功能。处理毒素的能力比有机肝脏稍差。"
	failing_desc = "似乎已经损坏。"
	icon_state = "liver-c"
	organ_flags = ORGAN_ROBOTIC
	maxHealth = STANDARD_ORGAN_THRESHOLD*0.5
	toxTolerance = 2
	liver_resistance = 0.9 * LIVER_DEFAULT_TOX_RESISTANCE // -10%
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	var/emp_vulnerability = 80 //Chance of permanent effects if emp-ed.

/obj/item/organ/liver/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		owner.adjust_tox_loss(10 / severity)
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)
	if(prob(emp_vulnerability/severity)) //Chance of permanent effects
		organ_flags |= ORGAN_EMP //Starts organ faliure - gonna need replacing soon.

/obj/item/organ/liver/cybernetic/tier2
	name = "义体肝脏"
	desc = "一种电子装置，用于模拟人类肝脏的功能。处理毒素的能力比有机肝脏稍好。"
	icon_state = "liver-c-u"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	toxTolerance = 5 //can shrug off up to 5u of toxins
	liver_resistance = 1.2 * LIVER_DEFAULT_TOX_RESISTANCE // +20%
	emp_vulnerability = 40

/obj/item/organ/liver/cybernetic/tier3
	name = "升级版义体肝脏"
	desc = "义体肝脏的升级版本，旨在进一步超越有机肝脏。它能抵抗酒精中毒，过滤毒素的能力也非常强悍。"
	icon_state = "liver-c-u2"
	alcohol_tolerance = ALCOHOL_RATE * 0.2
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD
	toxTolerance = 10 //can shrug off up to 10u of toxins
	liver_resistance = 1.5 * LIVER_DEFAULT_TOX_RESISTANCE // +50%
	emp_vulnerability = 20
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/liver/cybernetic/surplus
	name = "廉价义体肝脏"
	desc = "一种非常廉价的义体肝脏，为低功能的酗酒者批量生产……它看起来更像一个滤水器，而不是\
		真正的肝脏。\
		极其脆弱，过滤毒素的能力糟糕透顶，对酒精也格外敏感。\
		完全没有任何电磁脉冲防护能力。"
	icon_state = "liver-c-s"
	maxHealth = STANDARD_ORGAN_THRESHOLD * 0.35
	alcohol_tolerance = ALCOHOL_RATE * 2 // can barely handle alcohol
	toxTolerance = 1 //basically can't shrug off any toxins
	liver_resistance = 0.75 * LIVER_DEFAULT_TOX_RESISTANCE // -25%
	emp_vulnerability = 100

//surplus organs are so awful that they explode when removed, unless failing
/obj/item/organ/liver/cybernetic/surplus/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dangerous_organ_removal, /*surgical = */ TRUE)

/obj/item/organ/liver/pod
	name = "豆荚过氧化物酶体"
	desc = "豆荚人体内一种类似植物的小型器官，负责过滤毒素，同时协助光合作用。"
	foodtype_flags = PODPERSON_ORGAN_FOODTYPES
	color = COLOR_LIME

/obj/item/organ/liver/pod/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick)
	. = ..()
	if((. & COMSIG_MOB_STOP_REAGENT_TICK) || (organ_flags & ORGAN_FAILING))
		return
	if(!(organ_owner.mob_biotypes & MOB_PLANT))
		return
	if(chem.type == /datum/reagent/toxin/plantbgone)
		organ_owner.adjust_tox_loss(1.5 * seconds_per_tick)

/obj/item/organ/liver/snail
	name = "蜗牛肝脏"
	desc = "一颗黏糊糊的肝脏，不断分泌出惊人分量的润滑液。通常配橄榄油和香菜烹调，传统上要在白旗下食用。"
	icon_state = "liver-bone" // Its greyscale, so works perfectly for coloring
	color = "#96DB00"
	/// Speed modifier for snails who have this organ. Positive numbers make them move slower, negative numbers make them move faster.
	var/snail_speed_mod = 6

/obj/item/organ/liver/snail/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.AddElement(/datum/element/lube_walking, require_resting = TRUE)
	organ_owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/snail, multiplicative_slowdown = snail_speed_mod)

/obj/item/organ/liver/snail/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.remove_movespeed_modifier(/datum/movespeed_modifier/snail)
	organ_owner.RemoveElement(/datum/element/lube_walking, require_resting = TRUE)

/obj/item/organ/liver/snail/handle_chemical(mob/living/carbon/organ_owner, datum/reagent/chem, seconds_per_tick)
	. = ..()
	if((. & COMSIG_MOB_STOP_REAGENT_TICK) || (organ_flags & ORGAN_FAILING))
		return
	if(istype(chem, /datum/reagent/consumable/salt))
		playsound(organ_owner, SFX_SEAR, 30, TRUE)
		organ_owner.adjust_fire_loss(1 * seconds_per_tick)
		organ_owner.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * seconds_per_tick)
		return COMSIG_MOB_STOP_REAGENT_TICK

/obj/item/organ/liver/evolved
	name = "进化肝脏"
	desc = "一颗更强健的肝脏，各方面都更出色。"

	icon_state = "evolved-liver"

	alcohol_tolerance = ALCOHOL_RATE * 0.5
	maxHealth = 1.2 * STANDARD_ORGAN_THRESHOLD
	toxTolerance = 6 //can shrug off up to 6u of toxins
	liver_resistance = 1.5 * LIVER_DEFAULT_TOX_RESISTANCE

/obj/item/organ/liver/bloody
	name = "渗漏肝脏"
	desc = "一颗格外多孔的肝脏，只比普通肝脏稍好一点，但补充血液的能力更强。"

	icon_state = "leaky-liver"

	maxHealth = 1.1 * STANDARD_ORGAN_THRESHOLD
	alcohol_tolerance = ALCOHOL_RATE * 0.8
	toxTolerance = LIVER_DEFAULT_TOX_TOLERANCE + 1
	liver_resistance = 1.1 * LIVER_DEFAULT_TOX_RESISTANCE

/obj/item/organ/liver/bloody/on_life(seconds_per_tick)
	. = ..()

	owner.adjust_blood_volume(4 * seconds_per_tick, maximum = BLOOD_VOLUME_NORMAL)

/// Convert all non-alcoholic drinks into alcohol
/obj/item/organ/liver/distillery
	name = "酒鬼之乐"
	desc = "完美的肝脏，只要有可能，就会把不含酒精的试剂蒸馏成酒精。"

	icon_state = "liver-distillery"

	organ_traits = list(TRAIT_ALCOHOL_TOLERANCE)

	alcohol_tolerance = ALCOHOL_RATE * 0.1

	/// Volume that is converted per second
	var/ethanol_conversion = 0.2
	/// What to convert stuff into
	var/convert_into = /datum/reagent/consumable/ethanol

/obj/item/organ/liver/distillery/on_life(seconds_per_tick)
	. = ..()

	for(var/datum/reagent/reagent as anything in owner.reagents.reagent_list)
		// Already alcohol
		if(istype(reagent, convert_into))
			continue

		owner.reagents.convert_reagent(reagent.type, convert_into, ethanol_conversion)

/obj/item/organ/liver/lizard
	name = "蜥蜴人肝脏"
	desc = "一颗在远古某处发生突变，使这种准肉食的原生蜥蜴人能代谢提兹拉异星植物中植物营养的肝脏。\
		研究人员认为，正是这一点最终让蜥蜴人作为一个物种繁荣兴旺。"
	organ_traits = list(TRAIT_LIZARD_METABOLISM)

#undef LIVER_DEFAULT_TOX_TOLERANCE
//#undef LIVER_DEFAULT_TOX_RESISTANCE // SKYRAT EDIT REMOVAL - Needed in modular
#undef LIVER_FAILURE_STAGE_SECONDS
