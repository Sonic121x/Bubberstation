/// Animated beings of stone. They have increased defenses, and do not need to breathe. They must eat minerals to live, which give additional buffs.
/datum/species/golem
	name = "魔像"
	id = SPECIES_GOLEM
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_LAVA_IMMUNE,
		TRAIT_NEVER_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_NODISMEMBER,
		TRAIT_NOFAT,
		TRAIT_NOFIRE,
		TRAIT_NOSOFTCRIT,
		TRAIT_NO_AUGMENTS,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_NO_UNDERWEAR,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RADIMMUNE,
		TRAIT_SNOWSTORM_IMMUNE, // Shared with plasma river... but I guess if you can survive a plasma river a blizzard isn't a big deal
		TRAIT_UNHUSKABLE,
	)
	mutantheart = null
	mutantlungs = null
	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL
	payday_modifier = 1.0
	siemens_coeff = 0
	no_equip_flags = ITEM_SLOT_MASK | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_ICLOTHING | ITEM_SLOT_SUITSTORE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC
	sexes = FALSE
	meat = /obj/item/food/meat/slab/human/mutant/golem
	species_language_holder = /datum/language_holder/golem

	bodytemp_heat_damage_limit = BODYTEMP_HEAT_LAVALAND_SAFE
	bodytemp_cold_damage_limit = BODYTEMP_COLD_ICEBOX_SAFE

	mutant_organs = list(/obj/item/organ/adamantine_resonator)
	mutanteyes = /obj/item/organ/eyes/golem
	mutantbrain = /obj/item/organ/brain/golem
	mutanttongue = /obj/item/organ/tongue/golem
	mutantstomach = /obj/item/organ/stomach/golem
	mutantliver = /obj/item/organ/liver/golem
	mutantappendix = /obj/item/organ/appendix/golem
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/golem,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/golem,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/golem,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/golem,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/golem,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/golem,
	)

	/// Have we warned the mob about low nutrition?
	VAR_FINAL/early_warning = FALSE
	/// Have we given the final warning about starvation?
	VAR_FINAL/final_warning = FALSE
	/// Cooldown of warning message so we don't spam it if we flick around the threshold
	COOLDOWN_DECLARE(warning_cd)

/datum/species/golem/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons, replace_missing)
	. = ..()
	RegisterSignal(human_who_gained_species, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(drain_nutrition))
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_UPDATE_NUTRITION, PROC_REF(check_nutrition))
	RegisterSignal(human_who_gained_species, COMSIG_CARBON_DEFIB_HEART_CHECK, PROC_REF(defib_check))
	RegisterSignal(human_who_gained_species, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(rebuild_check))
	RegisterSignal(human_who_gained_species, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_LIFE, PROC_REF(on_life))
	// nutrition = health, so give people a head start
	human_who_gained_species.set_nutrition(NUTRITION_LEVEL_WELL_FED)

	human_who_gained_species.physiology.stamina_mod *= 0.6
	human_who_gained_species.physiology.stun_mod *= 0.6
	human_who_gained_species.physiology.knockdown_mod *= 1.2

/datum/species/golem/on_species_loss(mob/living/carbon/human/human_who_lost_species, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(human_who_lost_species, list(
		COMSIG_MOB_AFTER_APPLY_DAMAGE,
		COMSIG_LIVING_UPDATE_NUTRITION,
		COMSIG_CARBON_DEFIB_HEART_CHECK,
		COMSIG_ATOM_ITEM_INTERACTION,
		COMSIG_ATOM_EXAMINE,
		COMSIG_LIVING_LIFE,
	))

	human_who_lost_species.physiology.stamina_mod /= 0.6
	human_who_lost_species.physiology.stun_mod /= 0.6
	human_who_lost_species.physiology.knockdown_mod /= 1.2

/datum/species/golem/proc/on_life(mob/living/carbon/human/source, seconds_per_tick)
	SIGNAL_HANDLER

	if(source.nutrition <= 20)
		// this is "hard crit" for golems
		source.Unconscious(1.5 SECONDS * seconds_per_tick)
	if(source.nutrition <= 100 || source.health < source.crit_threshold)
		// and this is "crit damage" for golems
		var/drain = 1
		if(source.nutrition <= 50)
			drain *= 2
		if(source.health < source.crit_threshold)
			drain *= 2
		source.adjust_nutrition(-1 * drain * seconds_per_tick, forced = TRUE)
	if(source.nutrition > NUTRITION_LEVEL_FAT)
		// nutrition is health so let's keep this sane
		source.set_nutrition(NUTRITION_LEVEL_FAT)

/datum/species/golem/proc/on_examine(mob/living/carbon/human/source, mob/living/examiner, list/examine_text)
	SIGNAL_HANDLER

	if(!IS_DEAD_OR_FAKING(source))
		return

	examine_text += span_warning("这个魔像看上去已经破败不堪。\
		或许可以通过向其躯体中加入矿物来重建它。")

/datum/species/golem/proc/rebuild_check(mob/living/carbon/human/source, mob/living/user, obj/item/tool, ...)
	SIGNAL_HANDLER

	if(!IS_DEAD_OR_FAKING(source))
		return NONE

	if(!isstack(tool) || !is_type_in_list(tool, GLOB.golem_stack_food_directory))
		return NONE

	INVOKE_ASYNC(src, PROC_REF(rebuild), source, user, tool)
	return ITEM_INTERACT_SUCCESS

/datum/species/golem/proc/rebuild(mob/living/carbon/human/source, mob/living/user, obj/item/stack/mats)
	source.notify_revival("你正被 [user.real_name] 重建！")
	var/brute_ready = source.get_brute_loss() < 50
	var/burn_ready = source.get_fire_loss() < 50
	var/nutrition_ready = source.nutrition > NUTRITION_LEVEL_VERY_HUNGRY

	while(check_rebuild(source, user, mats))
		user.visible_message(
			span_notice("[user] 用了一些 [mats] 来重建 [source] 的身躯。"),
			span_notice("你用了一些 [mats] 来重建 [source] 的身躯。"),
		)

		var/do_after_time = 2 SECONDS
		if(brute_ready && burn_ready && nutrition_ready && source.can_be_revived())
			do_after_time *= 4
			user.show_message(span_notice("[source] 看起来已几乎重建完成，这需要再花一点时间……"), MSG_VISUAL)
		if(HAS_TRAIT(user, TRAIT_QUICK_BUILD))
			do_after_time *= 0.75

		if(!do_after(user, do_after_time, source, extra_checks = CALLBACK(src, PROC_REF(check_rebuild), source, user, mats) ) )
			return

		// calculated "effective sheet power" based on mats
		// ex. iron sheets will have a power of 1, reinforced glass a power of 1.5
		var/mat_power = 0
		for(var/mat, mat_amt in mats.custom_materials)
			mat_power += mat_amt
		mat_power /= mats.amount // mats per sheet
		mat_power /= SHEET_MATERIAL_AMOUNT // normalize

		mats.use(1)
		source.heal_ordered_damage(mat_power * 5, list(BRUTE, BURN))
		source.adjust_nutrition(mat_power * 20)
		if(!brute_ready)
			if(source.get_brute_loss() < 50)
				user.show_message(span_notice("[source] 看起来比以往更加坚固了！就快好了……"), MSG_VISUAL)
				brute_ready = TRUE
			continue
		if(!burn_ready)
			if(source.get_fire_loss() < 50)
				user.show_message(span_notice("[source] 似乎在恢复完整！再加把劲……"), MSG_VISUAL)
				burn_ready = TRUE
			continue
		if(!nutrition_ready)
			if(source.nutrition > NUTRITION_LEVEL_HUNGRY)
				user.show_message(span_notice("[source] 的形态似乎在稳定下来！就快完成了……"), MSG_VISUAL)
				nutrition_ready = TRUE
			continue

		if(source.revive(excess_healing = 10)) // give a bit of organ/tox/oxy healing for free
			source.visible_message(
				span_notice("[source] 稳定下来并重组成可用的状态！"),
				span_boldnotice("你稳定下来并重组成可用的状态！"),
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
			source.set_resting(FALSE, silent = TRUE, instant = TRUE)
		return

/datum/species/golem/proc/check_rebuild(mob/living/carbon/human/source, mob/living/user, obj/item/stack/mats)
	if(source.stat != DEAD)
		return FALSE
	if(QDELETED(user))
		return FALSE
	if(QDELETED(mats) || mats.amount < 1)
		return FALSE
	if(!user.is_holding(mats))
		return FALSE
	return TRUE

/datum/species/golem/proc/defib_check(mob/living/carbon/human/source, mob/living/carbon/human/defib_user)
	SIGNAL_HANDLER

	// golems can't be defibrillated, they have no heart and aren't even alive in the traditional sense
	// you gotta rebuild them with materials if they fall apart
	return DEFIB_FAIL_GOLEM

/datum/species/golem/proc/drain_nutrition(mob/living/carbon/human/source, damage_amt, damage_type, ...)
	SIGNAL_HANDLER

	// our brute and burn damage is more than halved by our limbs
	// the other "half" of the damage is converted into nutrition loss (representing loss of rock material)
	if(damage_type != BURN && damage_type != BRUTE)
		return

	source.adjust_nutrition(round(-3 * damage_amt, 0.01), forced = TRUE)

/datum/species/golem/proc/check_nutrition(mob/living/carbon/human/source)
	SIGNAL_HANDLER

	if(source.nutrition < NUTRITION_LEVEL_STARVING)
		if(!early_warning && COOLDOWN_FINISHED(src, warning_cd) && !IS_UNCONSCIOUS(source))
			source.visible_message(
				span_warning("[source] 虚弱地颤抖着，其形态开始失去稳定！"),
				span_bolddanger("你感到自己的形态正因维持自身的物质不足而失稳！ \
					快去找些矿物吃吧，否则你可能会崩碎！"),
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
			early_warning = TRUE
			COOLDOWN_START(src, warning_cd, 1 MINUTES)

	else
		early_warning = FALSE

	if(source.nutrition < 50)
		if(!final_warning && COOLDOWN_FINISHED(src, warning_cd) && !IS_UNCONSCIOUS(source))
			source.visible_message(
				span_warning("[source] 看上去已经濒临解体！"),
				span_userdanger("你的形态剧烈颤抖，已接近完全失稳！ \
					快吃些矿物，否则你可能会崩碎！"),
				visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
			)
			final_warning = TRUE
			COOLDOWN_START(src, warning_cd, 1 MINUTES)

	else
		final_warning = FALSE

	if(source.nutrition < 2 && source.stat != DEAD)
		source.visible_message(
			span_warning("[source] 一阵颤抖后崩碎成一堆毫无生气的岩石！"),
			span_userdanger("你耗尽了维持活化形态的物质，崩碎成一堆毫无生气的岩石！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		source.investigate_log("作为魔像饿死", INVESTIGATE_DEATHS)
		source.death()

/datum/species/golem/get_physical_attributes()
	return "魔像是石头制成的坚韧生物，因此天生能抵抗许多危险，包括窒息、火焰、辐射、电击与病毒。\
		它们会因所食用的材料类型而获得特殊能力，但必须不断消耗材料才能维持身体的活性。"

/datum/species/golem/get_species_description()
	return "魔像是靠食用岩石与矿物来生存并适应环境的石质生物。"

/datum/species/golem/get_species_lore()
	return list(
		"虽然魔像长期以来常见于边疆世界，平静地采矿并与环境和谐共处，\
		但据信它们最初是在纳米传讯的实验室中作为廉价劳动力被制造出来的。这期间发生了什么已无从知晓，\
		但它们此后获得了自由，如今在银河中已十分罕见。",
	)

/datum/species/golem/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "user-shield",
		SPECIES_PERK_NAME = "石质生物",
		SPECIES_PERK_DESC = "石质生物是由矿物而非血肉构成的生物。\
			它们强壮，并免疫许多环境与自身的危险，\
			例如火焰、辐射、缺氧、熔岩、病毒与断肢。",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "gem",
		SPECIES_PERK_NAME = "变质岩",
		SPECIES_PERK_DESC = "食用矿物会根据所食用的类型为石质生物提供暂时的增益。",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
		SPECIES_PERK_ICON = "tools",
		SPECIES_PERK_NAME = "天生矿工",
		SPECIES_PERK_DESC = "魔像能在黑暗中模糊视物、感应矿物、击碎巨石，还能徒手开采石头。\
			只要周围环境足够炎热，它们甚至能用体内的熔炉冶炼矿石。",
	))

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
		SPECIES_PERK_ICON = "bolt",
		SPECIES_PERK_NAME = "赋活之力",
		SPECIES_PERK_DESC = "维持驱动石头的力量十分费力。石质生物必须频繁进食 \
			以免变回无生命的雕像，且只能从食用矿物中获取营养。",
	))

	return to_add
