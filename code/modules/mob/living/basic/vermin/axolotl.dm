/mob/living/basic/axolotl
	name = "美西螈"
	desc = "相当色彩斑斓的两栖动物！"
	icon_state = "axolotl"
	icon_living = "axolotl"
	icon_dead = "axolotl_dead"
	maxHealth = 10
	health = 10
	attack_verb_continuous = "轻咬" //their teeth are just for gripping food, not used for self defense nor even chewing
	attack_verb_simple = "轻咬"
	butcher_results = list(/obj/item/food/nugget = 1)
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_AQUATIC
	gold_core_spawnable = FRIENDLY_SPAWN

	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻轻推开"
	response_disarm_simple = "轻轻推开"
	response_harm_continuous = "压扁"
	response_harm_simple = "压扁"

	held_w_class = WEIGHT_CLASS_TINY
	held_lh = 'icons/mob/inhands/animal_item_lefthand.dmi'
	held_rh = 'icons/mob/inhands/animal_item_righthand.dmi'
	worn_slot_flags = ITEM_SLOT_HEAD
	head_icon = 'icons/mob/clothing/head/pets_head.dmi'

	ai_controller = /datum/ai_controller/basic_controller/axolotl

/mob/living/basic/axolotl/Initialize(mapload)
	. = ..()
	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_VENTCRAWLER_ALWAYS), INNATE_TRAIT)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_AXOLOTL, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)
	AddElement(/datum/element/can_be_held)

/datum/ai_controller/basic_controller/axolotl
	behavior_tree_json = "code/modules/mob/living/basic/vermin/axolotl.bt.json"
	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
