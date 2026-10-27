
/**
 * Bitrunning gimmick loadouts themed around dungeon crawling.
 * Mostly for fun, have niche but not insignificant advantages.
 */
/obj/item/disk/bitrunning/gimmick/dungeon
	name = "比特潜行特色套装：地城探索"
	selectable_loadouts = list(
		/datum/bitrunning_gimmick/alchemist,
		/datum/bitrunning_gimmick/rogue,
		/datum/bitrunning_gimmick/healer,
		/datum/bitrunning_gimmick/wizard,
	)


/datum/bitrunning_gimmick/alchemist
	name = "炼金术士"

	granted_items = list(
		/obj/item/clothing/suit/bio_suit/plaguedoctorsuit,
		/obj/item/clothing/mask/gas/plaguedoctor,
		/obj/item/clothing/head/bio_hood/plague,
		/obj/item/storage/box/alchemist_basic_chems,
		/obj/item/storage/box/alchemist_basic_chems,
		/obj/item/storage/box/alchemist_random_chems,
		/obj/item/storage/box/alchemist_chemistry_kit,
	)

/obj/item/reagent_containers/cup/bottle/alchemist_basic
	name = "无标签瓶子"
	desc = "一个小瓶子。你不记得自己往里面装了什么。"

/obj/item/reagent_containers/cup/bottle/alchemist_basic/add_initial_reagents()
	/// List of possible reagents we may pick from
	var/list/possible_reagents = list(
		/datum/reagent/aluminium, // Basic chems
		/datum/reagent/bromine,
		/datum/reagent/carbon,
		/datum/reagent/chlorine,
		/datum/reagent/copper,
		/datum/reagent/consumable/ethanol,
		/datum/reagent/fluorine,
		/datum/reagent/hydrogen,
		/datum/reagent/iodine,
		/datum/reagent/iron,
		/datum/reagent/lithium,
		/datum/reagent/mercury,
		/datum/reagent/nitrogen,
		/datum/reagent/oxygen,
		/datum/reagent/phosphorus,
		/datum/reagent/potassium,
		/datum/reagent/uranium/radium,
		/datum/reagent/silicon,
		/datum/reagent/sodium,
		/datum/reagent/stable_plasma,
		/datum/reagent/consumable/sugar,
		/datum/reagent/sulfur,
		/datum/reagent/toxin/acid,
		/datum/reagent/water,
		/datum/reagent/fuel,
		/datum/reagent/toxin/leadacetate, // Funny chems
		/datum/reagent/consumable/liquidgibs,
		/datum/reagent/consumable/nutriment,
		/datum/reagent/consumable/coffee,
	)

	var/our_reagent = pick(possible_reagents)
	reagents.add_reagent(our_reagent, 50)

/obj/item/reagent_containers/cup/bottle/alchemist_random
	name = "骷髅标签瓶子"
	desc = "一个小瓶子。你不记得自己往里面装了什么。"

	/// List of random adjectives this bottle may have
	var/static/list/possible_adjectives = list(
		"无标签的",
		"骷髅标签的", // Labels
		"心形标签的",
		"爆炸标签的",
		"鱼形标签的",
		"笑脸标签的",
		"哭脸标签的",
		"叹问号标签的",
		"加号标签的",
		"d20 标签的",
		"字迹模糊的",
		"黑色标签的",
		"空标签的",
		"岁月泛黄的", // Qualities
		"血迹斑斑的",
		"灰烬斑驳的",
		"爪痕遍布的",
		"记号笔标记的",
		"有裂纹的",
		"不祥的", // Abstract
	)

/obj/item/reagent_containers/cup/bottle/alchemist_random/Initialize(mapload)
	. = ..()
	name = "[pick(possible_adjectives)]瓶子"

/obj/item/reagent_containers/cup/bottle/alchemist_random/add_initial_reagents()
	var/our_reagent = get_random_reagent_id()
	var/our_amount = rand(20, 50)
	reagents.add_reagent(our_reagent, our_amount)

/datum/bitrunning_gimmick/rogue
	name = "盗贼"

	granted_items = list(
		/obj/item/clothing/under/color/black,
		/obj/item/clothing/shoes/sneakers/black/rogue,
		/obj/item/clothing/mask/facescarf/rogue,
		/obj/item/clothing/glasses/eyepatch/rogue,
		/obj/item/bedsheet/black/rogue_cape,
		/obj/item/storage/belt/fannypack/black/rogue,
		/obj/item/knife/combat/survival,
	)

/obj/item/clothing/shoes/sneakers/black/rogue
	name = "潜行运动鞋"

/obj/item/clothing/mask/facescarf/rogue
	name = "厄运面巾"
	icon_state = "/obj/item/clothing/mask/facescarf/rogue"
	greyscale_colors = "#292929"

/obj/item/clothing/glasses/eyepatch/rogue
	name = "封印眼罩"

/obj/item/bedsheet/black/rogue_cape
	name = "黑暗披风"

/datum/bitrunning_gimmick/healer
	name = "治疗师"

	granted_items = list(
		/obj/item/clothing/under/costume/singer/yellow,
		/obj/item/clothing/shoes/singery,
		/obj/item/rod_of_asclepius,
		/obj/item/storage/medkit/surgery,
		/obj/item/emergency_bed,
		/obj/item/food/canned/larvae,
		/obj/item/reagent_containers/dropper,
	)


/datum/bitrunning_gimmick/wizard
	name = "法师"

	granted_items = list(
		/obj/item/clothing/head/wizard/fake,
		/obj/item/clothing/suit/wizrobe/fake,
		/obj/item/clothing/glasses/eyepatch/medical/chuuni,
		/obj/item/staff,
		/obj/item/toy/eightball,
		/obj/item/storage/fancy/cigarettes/cigpack_cannabis,
		/obj/item/storage/box/matches,
	)

	granted_actions = list(
		/datum/action/cooldown/spell/pointed/untie_shoes/digital,
		/datum/action/cooldown/spell/smoke/digital,
	)

/datum/action/cooldown/spell/pointed/untie_shoes/digital
	name = "解开数码鞋带"
	spell_requirements = SPELL_REQUIRES_WIZARD_GARB

/datum/action/cooldown/spell/smoke/digital
	name = "数码烟雾"
	desc = "该法术会在你所在的位置生成一小团烟雾。"

	school = SCHOOL_CONJURATION
	cooldown_time = 36 SECONDS
	spell_requirements = SPELL_REQUIRES_WIZARD_GARB

	smoke_type = /datum/effect_system/fluid_spread/smoke
	smoke_amt = 2
