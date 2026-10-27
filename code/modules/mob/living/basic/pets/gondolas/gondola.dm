#define GONDOLA_HEIGHT pick(list("gondola_body_long", "gondola_body_medium", "gondola_body_short"))
#define GONDOLA_COLOR pick(list("A87855", "915E48", "683E2C"))
#define GONDOLA_MOUSTACHE pick(list("gondola_moustache_large", "gondola_moustache_small"))
#define GONDOLA_EYES pick(list("gondola_eyes_close", "gondola_eyes_far"))

/mob/living/basic/pet/gondola
	name = "贡多拉"
	real_name = "贡多拉"
	desc = "贡多拉是沉默的行者。 \
		他没有双手，因此体现了道家“无为”的原则；而那始终微笑的 \
		神情，则显露出他对世界本然的彻底接纳。 \
		它的皮毛极为贵重。"
	icon = 'icons/mob/simple/gondolas.dmi'
	icon_state = "gondola"
	icon_living = "gondola"

	maxHealth = 200
	health = 200
	faction = list(FACTION_GONDOLA)
	response_help_continuous = "抚摸"
	response_help_simple = "抚摸"
	response_disarm_continuous = "轻拍"
	response_disarm_simple = "轻拍"
	response_harm_continuous = "踢"
	response_harm_simple = "踢"
	ai_controller = /datum/ai_controller/basic_controller/gondola

	//Gondolas aren't affected by cold.
	unsuitable_atmos_damage = 0
	basic_mob_flags = SENDS_DEATH_MOODLETS|DEL_ON_DEATH

	///List of loot drops on death, since it deletes itself on death (like trooper).
	var/list/loot = list(
		/obj/effect/decal/cleanable/blood/gibs = 1,
		/obj/item/stack/sheet/animalhide/gondola = 1,
		/obj/item/food/meat/slab/gondola = 1,
	)

/mob/living/basic/pet/gondola/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_MUTE, INNATE_TRAIT)
	AddElement(/datum/element/pet_bonus, "smile")
	if(LAZYLEN(loot))
		loot = string_list(loot)
		AddElement(/datum/element/death_drops, loot)
	create_gondola()

/mob/living/basic/pet/gondola/proc/create_gondola()
	icon_state = null
	icon_living = null
	var/height = GONDOLA_HEIGHT
	var/mutable_appearance/body_overlay = mutable_appearance(icon, height)
	var/mutable_appearance/eyes_overlay = mutable_appearance(icon, GONDOLA_EYES)
	var/mutable_appearance/moustache_overlay = mutable_appearance(icon, GONDOLA_MOUSTACHE)
	body_overlay.color = ("#[GONDOLA_COLOR]")

	//Offset the face to match the Gondola's height.
	switch(height)
		if("gondola_body_medium")
			eyes_overlay.pixel_z = -4
			moustache_overlay.pixel_z = -4
		if("gondola_body_short")
			eyes_overlay.pixel_z = -8
			moustache_overlay.pixel_z = -8

	cut_overlays(TRUE)
	add_overlay(body_overlay)
	add_overlay(eyes_overlay)
	add_overlay(moustache_overlay)

/datum/ai_controller/basic_controller/gondola
	behavior_tree_json = "code/modules/mob/living/basic/pets/gondolas/gondola.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance

#undef GONDOLA_HEIGHT
#undef GONDOLA_COLOR
#undef GONDOLA_MOUSTACHE
#undef GONDOLA_EYES
