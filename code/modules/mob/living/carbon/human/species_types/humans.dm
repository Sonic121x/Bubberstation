/datum/species/human
	name = "\improper 人类"
	id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
	)
	skinned_type = /obj/item/stack/sheet/animalhide/carbon/human
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
//	payday_modifier = 1 // BUBBER DUMB SHIT REMOVAL

/datum/species/human/prepare_human_for_preview(mob/living/carbon/human/human)
	human.set_haircolor("#bb9966", update = FALSE) // brown
	human.set_hairstyle("Business Hair", update = TRUE)

/datum/species/human/get_species_description()
	return "人类是已知银河中的优势物种。\
		他们的足迹从古老的地球一直延伸到已知宇宙的边缘。"

/datum/species/human/get_species_lore()
	return list(
		"这些源自灵长类的生物来自大体无害的地球，\
		早已超越了他们的家园与半无害的定位。\
		太空时代将人类带出了太阳系，进入广阔的银河。",

		"以人类一贯的作风，这段从陆地走向最终边疆、近乎创纪录的进程，\
		冒犯了与他们同台的其他种族。\
		其中就包括蜥蜴人——若有人被这些暴发户激怒，那一定是蜥蜴人。",

		"人类始终未能像其他物种那样找到足以团结在同一面旗帜下的和平。\
		联合国官僚推纸公文的作风，延续在地球政府这幅拼图之中；\
		它由至今仍存在于人类社会的诸多民族国家组成。",

		"人类的机会与进取精神以其巅峰形态延续至今：\
		超级企业。无论字面还是比喻意义上，超级企业都在地球政府的影响之外行动，\
		它们买下所需的参议院选票，并在地球政府鞭长莫及之处建立领地。 \
		在超级企业的领地上，公司政策就是法律，为“员工终止”赋予了新的含义。",
	)

/datum/species/human/create_pref_unique_perks()
	var/list/to_add = list()

	if(CONFIG_GET(number/default_laws) == 0 || CONFIG_GET(flag/silicon_asimov_superiority_override)) // Default lawset is set to Asimov
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "robot",
			SPECIES_PERK_NAME = "阿西莫夫优先",
			SPECIES_PERK_DESC = "默认情况下，AI 及其半机械人只服从 \
				人类。作为人类，硅基单位必须保护你并服从你。",
		))

	var/human_authority_setting = CONFIG_GET(string/human_authority)

	if(human_authority_setting == HUMAN_AUTHORITY_NON_HUMAN_WHITELIST || human_authority_setting == HUMAN_AUTHORITY_ENFORCED)
		to_add += list(list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "bullhorn",
			SPECIES_PERK_NAME = "指挥链",
			SPECIES_PERK_DESC = "纳米传讯只承认人类担任指挥职务，例如舰长。",
		))

	return to_add
