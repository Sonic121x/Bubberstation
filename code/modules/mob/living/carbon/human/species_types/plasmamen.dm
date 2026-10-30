/datum/species/plasmaman
	name = "\improper 等离子人"
	plural_form = "等离子人"
	id = SPECIES_PLASMAMAN
	sexes = FALSE
	meat = /obj/item/stack/sheet/mineral/plasma
	// plasmemes get hard to wound since they only need a severe bone wound to dismember, but unlike skellies, they can't pop their bones back into place
	inherent_traits = list(
		TRAIT_GENELESS,
		TRAIT_HARDLY_WOUNDED,
		TRAIT_NOBLOOD,
		TRAIT_NO_DNA_COPY,
		TRAIT_NO_PLASMA_TRANSFORM,
		TRAIT_RADIMMUNE,
		TRAIT_RESISTCOLD,
		TRAIT_UNHUSKABLE,
	)

	inherent_biotypes = MOB_HUMANOID|MOB_MINERAL|MOB_SKELETAL
	mutantlungs = /obj/item/organ/lungs/plasmaman
	smoker_lungs = /obj/item/organ/lungs/plasmaman/plasmaman_smoker
	mutanttongue = /obj/item/organ/tongue/bone/plasmaman
	mutantliver = /obj/item/organ/liver/bone/plasmaman
	mutantstomach = /obj/item/organ/stomach/bone/plasmaman
	mutantappendix = null
	mutantheart = null
	heatmod = 1.5
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	species_cookie = /obj/item/reagent_containers/condiment/milk
	outfit_important_for_life = /datum/outfit/plasmaman
	species_language_holder = /datum/language_holder/skeleton

	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/plasmaman,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/plasmaman,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/plasmaman,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/plasmaman,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/plasmaman,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/plasmaman,
	)
	survival_box_overrides = list(
		SURVIVAL_INTERNALS_TYPE = /obj/item/tank/internals/plasmaman/belt,
		SURVIVAL_MEDIPEN_TYPE = /obj/item/reagent_containers/hypospray/medipen,
	)

	// Body temperature for Plasmen is much lower human as they can handle colder environments
	bodytemp_normal = (BODYTEMP_NORMAL - 40)
	// The minimum amount they stabilize per tick is reduced making hot areas harder to deal with
	bodytemp_autorecovery_min = 2
	// They are hurt at hot temps faster as it is harder to hold their form
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 20) // about 40C
	// This effects how fast body temp stabilizes, also if cold resit is lost on the mob
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 50) // about -50c

	outfit_override_registry = list(
		/datum/outfit/ninja = /datum/outfit/ninja/plasmaman,
		/datum/outfit/syndicate = /datum/outfit/syndicate/plasmaman,
		/datum/outfit/syndicate/full = /datum/outfit/syndicate/full/plasmaman,
		/datum/outfit/syndicate/leader = /datum/outfit/syndicate/leader/plasmaman,
		/datum/outfit/syndicate/reinforcement = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/cybersun = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/donk = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/gorlex = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/interdyne = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/mi13 = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/reinforcement/waffle = /datum/outfit/syndicate/reinforcement/plasmaman,
		/datum/outfit/syndicate/support = /datum/outfit/syndicate/support/plasmaman,
		/datum/outfit/syndicate/full/loneop = /datum/outfit/syndicate/full/plasmaman/loneop,
	)

/datum/species/plasmaman/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.plasmaman_outfit)
		equipping.equipOutfit(job.plasmaman_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/plasmaman/get_physical_attributes()
	return "等离子人确实以等离子体呼吸和生存。他们一接触氧气就会自燃，除了随之而来的种种怪癖之外，\
		由于身体结构脆硬，他们还极易受到各种物理伤害。"

/datum/species/plasmaman/get_species_description()
	return "等离子人发现于弗蕾亚的冰月，由群落的 \
		真菌生物共同构成一个有知觉的个体。在人类星域，\
		他们通常附着在骨架上，以增添几分人味。"

/datum/species/plasmaman/get_species_lore()
	return list(
		"这是个令人困惑的物种，等离子人确实是“我们之中的真菌”。\
		看似单一的个体，实际上是由数百万生物组成的群落，\
		包裹着一具捡来（或他人提供）的骨骼结构。",

		"最初，一名研究员掉进了敞口的液态等离子体储罐，纳米传讯由此发现了他们；\
		此前无人注意的真菌群落占据了那具身体，创造出了第一个“真正的”等离子人。此后该流程通过 \
		慷慨捐赠的罪犯尸体得以简化，等离子人 \
		也被成批部署到纳米传讯各处，以补充劳动力。",

		"作为银河舞台上的新面孔，等离子人是一张白纸。\
		他们的外表通常被认为“阴森可怖”，令船员们颇为不安。\
		也许是因为那副“易燃的紫色骨架”吧。",

		"构成等离子人的群落生物需要其演化所在的富等离子体大气。\
		他们的伪神经系统以外部化的电脉冲运作，一旦存在氧气，便会立即点燃他们以等离子体为基础的身体。",
	)

/datum/species/plasmaman/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "user-shield",
			SPECIES_PERK_NAME = "受保护",
			SPECIES_PERK_DESC = "等离子人免疫辐射、毒素与大多数疾病。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bone",
			SPECIES_PERK_NAME = "抗伤性",
			SPECIES_PERK_DESC = "等离子人对会使他人受伤的伤害有更高的耐受度。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "wind",
			SPECIES_PERK_NAME = "等离子治疗",
			SPECIES_PERK_DESC = "等离子人可以通过食用等离子体来治疗伤口。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "hard-hat",
			SPECIES_PERK_NAME = "防护头盔",
			SPECIES_PERK_DESC = "等离子人的头盔能为其抵挡焊接的闪光，并内置手电筒。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "活体火炬",
			SPECIES_PERK_DESC = "等离子人的身体接触氧气时会立即点燃。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "briefcase-medical",
			SPECIES_PERK_NAME = "复杂生物学",
			SPECIES_PERK_DESC = "治疗等离子人需要专门的医学知识。\
				别指望能迅速复活，能不能复活 \
				还得看你运气。",
		),
	)

	return to_add
