/datum/species/moth
	name = "\improper 蛾族人"
	plural_form = "蛾族人"
	id = SPECIES_MOTH
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list("moth_markings" = "None") // SKYRAT EDIT CHANGE - ORIGINAL: body_markings = list(/datum/bodypart_overlay/simple/body_marking/moth = "None")
	/* mutant_organs = list( // BUBBER EDIT REMOVAL
		/obj/item/organ/wings/moth = "Plain",
		/obj/item/organ/antennae = "Plain",
	)
	inherent_traits = list(
		TRAIT_CLOTH_EATER, //So that moths can still eat cloth even if their stomach is augmented
	)*/
	meat = /obj/item/food/meat/slab/human/mutant/moth
	mutanttongue = /obj/item/organ/tongue/moth
	mutanteyes = /obj/item/organ/eyes/moth
	mutantstomach = /obj/item/organ/stomach/moth
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	species_cookie = /obj/item/food/muffin/moffin
	species_language_holder = /datum/language_holder/moth
	payday_modifier = 1.0
	family_heirlooms = list(/obj/item/flashlight/lantern/heirloom_moth)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/moth,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/moth,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/moth,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/moth,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/moth,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/moth,
	)

/datum/species/moth/randomize_features()
	var/list/features = ..()
	features[FEATURE_MOTH_MARKINGS] = pick(SSaccessories.feature_list[FEATURE_MOTH_MARKINGS])
	return features

/datum/species/moth/get_physical_attributes()
	return "蛾族人有一对宽大而蓬松的翅膀，在重力失效时能推动周围的空气，帮助他们在站内移动。\
		也正因如此，这对翅膀在太空中没什么用处。他们的眼睛非常敏感。"

/datum/species/moth/get_species_description()
	return "蛾族人的母星早已失落，他们作为一个游牧民族，\
		乘坐庞大的舰队在银河中漂泊，寻找新的家园。"

/datum/species/moth/get_species_lore()
	return list(
		"他们的母星已随岁月湮没，蛾族人居住在大游牧舰队上。\
		这支舰队由能找到、以物易物换来、修复或偷来的一切拼凑而成，是一支庞大的拼装舰队，\
		其历史建立在礼貌地拦下旅人、然后拿走他们东西的基础上。偶尔会有蛾族人 \
		决定离开舰队，通常是为了闯荡发财并将财富寄回家乡。",

		"游牧生活造就了紧密团结的文化，蛾族人极为珍视朋友、家人与飞船。\
		蛾族人生性合群，最适合在公共空间中生活。这一点在银河舞台上对他们大有裨益，\
		即便面对敌对遭遇，他们也能保持友善可亲的声誉。\
		看来银河已经接纳了这些昔日的海盗。",

		"令人意外的是，在庞大舰队中共同生活并没有抹平方言与文化的差异。\
		舰队内部欢迎并鼓励这些差异，因为它们带来了多样性。",
	)

/datum/species/moth/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "feather-alt",
			SPECIES_PERK_NAME = "珍贵的翅膀",
			SPECIES_PERK_DESC = "蛾族人能在有压的零重力环境中飞行，并借助翅膀安全缓冲短距离坠落。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "tshirt",
			SPECIES_PERK_NAME = "餐饮计划",
			SPECIES_PERK_DESC = "蛾族人可以吃衣服来获得暂时的营养。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "fire",
			SPECIES_PERK_NAME = "燃烧的翅膀",
			SPECIES_PERK_DESC = "蛾族人的翅膀很脆弱，很容易被烧掉。",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "sun",
			SPECIES_PERK_NAME = "强光",
			SPECIES_PERK_DESC = "蛾族人需要额外的防闪光保护来保护 \
				自己，例如防范安保人员或在焊接时。焊接 \
				面罩即可奏效。",
		),
	)

	return to_add
