/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper 蜥蜴人"
	plural_form = "蜥蜴人"
	id = SPECIES_LIZARD
	inherent_traits = list(
		TRAIT_COLD_BLOODED,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	mutant_bodyparts = list("body_markings" = "None", "legs" = "Normal Legs") // SKYRAT EDIT CHANGE - ORIGINAL: body_markings = list(/datum/bodypart_overlay/simple/body_marking/lizard = "None")
	mutant_organs = list(
		/obj/item/organ/horns = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/frills = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/snout = "Round",
		/obj/item/organ/spines = SPRITE_ACCESSORY_NONE,
		/obj/item/organ/tail/lizard = "Smooth",
	)
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanteyes = /obj/item/organ/eyes/lizard
	mutantbrain = /obj/item/organ/brain/lizard
	mutantliver = /obj/item/organ/liver/lizard
	coldmod = 1.5
	heatmod = 0.67
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_cookie = /obj/item/food/meat/slab
	meat = /obj/item/food/meat/slab/human/mutant/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/lizard
	exotic_bloodtype = BLOOD_TYPE_LIZARD
	inert_mutation = /datum/mutation/firebreath
	species_language_holder = /datum/language_holder/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	// Lizards are coldblooded and can stand a greater temperature range than humans
	bodytemp_heat_damage_limit = BODYTEMP_HEAT_LAVALAND_SAFE
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 10)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

//SKYRAT EDIT REMOVAL BEGIN
/*
/datum/species/lizard/randomize_features()
	var/list/features = ..()
	features[FEATURE_LIZARD_MARKINGS] = pick(SSaccessories.feature_list[FEATURE_LIZARD_MARKINGS])
	return features

*/
//SKYRAT EDIT REMOVAL END

/datum/species/lizard/get_physical_attributes()
	return "蜥蜴人比大多数物种更能耐受略高的温度，但他们非常怕冷，\
		且无法在体内调节体温，因此太空真空对他们极为致命。"

/datum/species/lizard/get_species_description()
	return "崇尚军事的蜥蜴人原本来自提兹拉，但在星际间度过的数个世纪中 \
		不断壮大，建立起庞大的太空 \
		帝国；不过如今他们必须应付更年轻、科技更先进的 \
		人类邻居。"

/datum/species/lizard/get_species_lore()
	return list(
		"人类与蜥蜴人相遇的那一天，阴谋论的面貌被永远改变了。",

		"蜥蜴人来自干旱的提兹拉世界，当人类才刚刚发现火车有多棒时，他们已在星际间航行。\
		然而，就像太空龟与太空兔的太空寓言那样，蜥蜴人抛弃了同族“稳扎稳打”的格言，\
		转而躺在荣誉上吃老本，最终被“秃毛猿猴”彻底超越，这在很大程度上要归因于他们无法获得等离子体。",

		"蜥蜴人与人类的历史造就了许多冲突，而蜥蜴人总是以失败的一方收场，\
		最终的结局是他们的卫星被炸得面目全非。如今蜥蜴人与人类的关系正处于持续创纪录的和平时期。",

		"蜥蜴人的文化本质上崇尚军事，不过殖民地离母星越远，\
		军方对蜥蜴人文化的影响就越弱——\
		一些偏远的殖民地甚至被附近其他物种的文化习俗所同化。",

		"在母星上，蜥蜴人庆祝 16 岁生日的方式是加入为期 5 年的强制性兵役。\
		职务从战斗到民政服务，涵盖其间的一切。正如那句老话所说：“总会找到你的位置！”",
	)

// Override for the default temperature perks, so we can give our specific "cold blooded" perk.
/datum/species/lizard/create_pref_temperature_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "thermometer-empty",
		SPECIES_PERK_NAME = "冷血",
		SPECIES_PERK_DESC = "蜥蜴人对高温的耐受度更高，但对低温的 \
			耐受度更低。此外，他们无法自行调节体温——\
			周围环境多冷，他们就有多冷。注意保暖！",
	))

	return to_add

/*
Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "灰行者"
	id = SPECIES_LIZARD_ASH
	examine_limb_id = SPECIES_LIZARD
	mutantlungs = /obj/item/organ/lungs/lavaland
	mutantbrain = /obj/item/organ/brain/primitive
	inherent_traits = list(
		TRAIT_COLD_BLOODED,
		TRAIT_MUTANT_COLORS,
		TRAIT_VIRUSIMMUNE,
		TRAIT_KNOW_ADVANCED_SMITHING, //BUBBER EDIT
	)
	inherent_factions = list(FACTION_ASHWALKER)
	species_language_holder = /datum/language_holder/lizard/ash
	digitigrade_customization = DIGITIGRADE_FORCED
	examine_limb_id = SPECIES_LIZARD
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard/ashwalker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard/ashwalker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard,
	)

/datum/species/lizard/ashwalker/get_physical_attributes()
	return "灰行者在几乎所有方面都与蜥蜴人相同。\
		与他们不同的是，灰行者始终是趾行步态，能呼吸熔岩地带常有毒性的大气，并免疫病毒。他们通常不识字。"

/*
Lizard subspecies: SILVER SCALED
*/
/datum/species/lizard/silverscale
	name = "银鳞者"
	id = SPECIES_LIZARD_SILVER
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_REPTILE
	inherent_traits = list(
		TRAIT_COLD_BLOODED,
		TRAIT_HOLY,
		TRAIT_NOBREATH,
		TRAIT_PIERCEIMMUNE,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_WINE_TASTER,
	)
	mutantlungs = null
	damage_modifier = 10 //very light silvery scales soften blows
	species_language_holder = /datum/language_holder/lizard/silver
	mutanttongue = /obj/item/organ/tongue/lizard/silver
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN
	examine_limb_id = SPECIES_LIZARD
	///stored mutcolor for when we turn back off of a silverscale.
	var/old_mutcolor

/datum/species/lizard/silverscale/get_physical_attributes()
	return "银鳞者对蜥蜴人而言，就如同天使对人类。\
		他们大体相同，但银鳞者是神圣的，不需呼吸，不会感染病毒，皮肤无法被刺穿，喜爱葡萄酒的味道，\
		而且不知为何，他们的舌头能让他们变成雕像。"

/datum/species/lizard/silverscale/on_species_gain(mob/living/carbon/human/new_silverscale, datum/species/old_species, pref_load, regenerate_icons)
	old_mutcolor = new_silverscale.dna.features[FEATURE_MUTANT_COLOR]
	new_silverscale.dna.features[FEATURE_MUTANT_COLOR] = "#eeeeee"
	new_silverscale.add_eye_color("#0000a0", EYE_COLOR_SPECIES_PRIORITY)
	. = ..()
	new_silverscale.add_filter("silver_glint", 2, list("type" = "outline", "color" = "#ffffff63", "size" = 2))

/datum/species/lizard/silverscale/on_species_loss(mob/living/carbon/human/was_silverscale, datum/species/new_species, pref_load)
	was_silverscale.dna.features[FEATURE_MUTANT_COLOR] = old_mutcolor
	was_silverscale.remove_eye_color(EYE_COLOR_SPECIES_PRIORITY)
	was_silverscale.remove_filter("silver_glint")
	return ..()
