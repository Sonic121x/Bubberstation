/mob/living/basic/skeleton
	name = "复生骷髅"
	desc = "一副货真价实的骷髅，看起来不太想和人打交道。"
	gender = NEUTER
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_UNDEAD|MOB_HUMANOID|MOB_SKELETAL
	speak_emote = list("发出咔嗒声")
	maxHealth = 40
	health = 40
	basic_mob_flags = DEL_ON_DEATH
	melee_damage_lower = 15
	melee_damage_upper = 15
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	attack_verb_continuous = "劈砍"
	attack_verb_simple = "劈砍"
	attack_sound = 'sound/items/weapons/slash.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW
	faction = list(FACTION_SKELETON)
	// Going for a sort of pale bluegreen here, shooting for boneish
	lighting_cutoff_red = 15
	lighting_cutoff_green = 25
	lighting_cutoff_blue = 35
	death_message = "坍成一堆白骨！"
	ai_controller = /datum/ai_controller/basic_controller/skeleton
	/// Loot this mob drops on death.
	var/list/loot = list(/obj/effect/decal/remains/human)
	/// Path of the outfit we give to the mob's visuals.
	var/outfit = null
	/// Path of the species we give to the mob's visuals.
	var/species = /datum/species/skeleton
	/// Path of the held item we give to the mob's visuals.
	var/held_item
	/// Types of milk skeletons like to drink
	var/static/list/good_drinks = list(
		/obj/item/reagent_containers/condiment/milk,
	)
	/// Bad milk that skeletons hate
	var/static/list/bad_drinks = list(
		/obj/item/reagent_containers/condiment/soymilk,
	)

/mob/living/basic/skeleton/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, outfit, species, r_hand = held_item)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE)
	if(LAZYLEN(loot))
		loot = string_list(loot)
		AddElement(/datum/element/death_drops, loot)
	AddElement(/datum/element/basic_eating, heal_amt = 50, drinking = TRUE, food_types = good_drinks)
	AddElement(/datum/element/basic_eating, heal_amt = 0, damage_amount = 25, damage_type = BURN, drinking = TRUE, food_types = bad_drinks)
	add_traits(list(TRAIT_SPOOKY_INSTRUMENT_PLAYER, TRAIT_SNOWSTORM_IMMUNE), INNATE_TRAIT)
	var/list/foods_list = good_drinks + bad_drinks
	ai_controller?.set_blackboard_key(BB_BASIC_FOODS, typecacheof(foods_list))

/mob/living/basic/skeleton/get_unconscious_appearance()
	return get_generic_humanoid_static_appearance()

/mob/living/basic/skeleton/settler
	name = "亡灵拓荒者"
	desc = "某个可怜拓荒者的复生遗骸。"
	maxHealth = 55
	health = 55
	melee_damage_lower = 17
	melee_damage_upper = 20
	attack_verb_continuous = "刺击"
	attack_verb_simple = "刺击"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	death_message = "坍成一堆白骨，身上的装备散落一地！"
	loot = list(
		/obj/effect/decal/remains/human,
		/obj/item/spear,
		/obj/item/clothing/shoes/winterboots,
		/obj/item/clothing/suit/hooded/wintercoat,
	)
	outfit = /datum/outfit/settler
	held_item = /obj/item/spear

/datum/outfit/settler
	name = "Settler"
	suit = /obj/item/clothing/suit/hooded/wintercoat
	shoes = /obj/item/clothing/shoes/winterboots

/mob/living/basic/skeleton/templar
	name = "亡灵圣殿骑士"
	desc = "一位神圣圣殿骑士的复生遗骸。"
	maxHealth = 150
	health = 150
	speed = 2
	physiology = list(BRUTE = 0.5, BURN = 0.5, TOX = 0, OXY = 0, STAMINA = 0) //trying to simulate actually having armor
	obj_damage = 50
	melee_damage_lower = 25
	melee_damage_upper = 30
	attack_verb_continuous = "劈砍"
	attack_verb_simple = "劈砍"
	attack_sound = 'sound/items/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	death_message = "坍成一堆白骨，装备哐当一声砸在地上！"
	loot = list(
		/obj/effect/decal/remains/human,
		/obj/item/clothing/suit/chaplainsuit/armor/templar,
		/obj/item/clothing/head/helmet/chaplain,
		/obj/item/claymore/weak{name = "圣剑"}
	)
	outfit = /datum/outfit/templar

/datum/outfit/templar
	name = "Templar"
	head = /obj/item/clothing/head/helmet/chaplain
	suit = /obj/item/clothing/suit/chaplainsuit/armor/templar
	r_hand = /obj/item/claymore/weak

/mob/living/basic/skeleton/ice
	name = "冰骷髅"
	desc = "一具复生骷髅，外层覆盖着厚厚的天然冰甲。不过看起来行动迟缓。"
	speed = 5
	maxHealth = 75
	health = 75
	color = rgb(114,228,250)
	loot = list(/obj/effect/decal/remains/human{color = rgb(114,228,250)})

/mob/living/basic/skeleton/plasmaminer
	name = "蹒跚矿工"
	desc = "一名浸透等离子体的矿工，裸露的肢体已化为仿佛由等离子体构成的炽亮白骨。"
	icon_state = "plasma_miner"
	icon_living = "plasma_miner"
	icon_dead = "plasma_miner"
	maxHealth = 150
	health = 150
	melee_damage_lower = 15
	melee_damage_upper = 20
	light_color = LIGHT_COLOR_PURPLE
	light_range = 2
	death_message = "坍成一堆白骨，防护服在等离子体中溶解殆尽！"
	loot = list(/obj/effect/decal/remains/plasma)
	outfit = /datum/outfit/plasma_miner
	species = /datum/species/plasmaman

/mob/living/basic/skeleton/plasmaminer/jackhammer
	desc = "一名浸透等离子体的矿工，裸露的肢体已化为仿佛由等离子体构成的炽亮白骨。他们手里似乎还紧紧握着采矿工具。"
	icon_state = "plasma_miner_tool"
	icon_living = "plasma_miner_tool"
	icon_dead = "plasma_miner_tool"
	maxHealth = 185
	health = 185
	melee_damage_lower = 20
	melee_damage_upper = 25
	attack_verb_continuous = "轰击"
	attack_verb_simple = "轰击"
	attack_sound = 'sound/items/weapons/sonic_jackhammer.ogg'
	attack_vis_effect = null
	loot = list(/obj/effect/decal/remains/plasma, /obj/item/pickaxe/drill/jackhammer)
	held_item = /obj/item/pickaxe/drill/jackhammer

/datum/outfit/plasma_miner
	name = "Plasma Miner"
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland
	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer

// Skeleton AI

/// Skeletons mostly just beat people to death, but they'll also find and drink milk.
/datum/ai_controller/basic_controller/skeleton
	behavior_tree_json = "code/modules/mob/living/basic/ruin_defender/skeleton.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_EMOTE_CHANCE = 20,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
