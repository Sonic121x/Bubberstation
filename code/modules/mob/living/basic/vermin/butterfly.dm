/mob/living/basic/butterfly
	name = "蝴蝶"
	desc = "一只色彩斑斓的蝴蝶，它是怎么飞到这儿来的？"
	icon_state = "butterfly"
	icon_living = "butterfly"
	icon_dead = "butterfly_dead"

	response_help_continuous = "驱赶"
	response_help_simple = "驱赶"
	response_disarm_continuous = "拨开"
	response_disarm_simple = "拨开"
	response_harm_continuous = "压扁"
	response_harm_simple = "压扁"
	speak_emote = list("扑扇翅膀")
	friendly_verb_continuous = "轻碰"
	friendly_verb_simple = "轻碰"

	maxHealth = 2
	health = 2

	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC | MOB_BUG
	gold_core_spawnable = FRIENDLY_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/butterfly

/mob/living/basic/butterfly/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/simple_flying)

	var/newcolor = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
	add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BUTTERFLY, CELL_VIRUS_TABLE_GENERIC_MOB, cell_line_amount = 1, virus_chance = 5)

/mob/living/basic/butterfly/bee_friendly()
	return TRUE //treaty signed at the Beeneeva convention

/datum/ai_controller/basic_controller/butterfly
	behavior_tree_json = "code/modules/mob/living/basic/vermin/butterfly.bt.json"

/mob/living/basic/butterfly/lavaland
	unsuitable_atmos_damage = 0

/mob/living/basic/butterfly/lavaland/temporary
	name = "奇怪的蝴蝶"
	basic_mob_flags = DEL_ON_DEATH
	/// The atom that's spawning the butterflies
	var/atom/source = null
	/// Max distance in tiles before the butterfly despawns
	var/max_distance = 5
	/// Whether the butterfly will be destroyed at the end of its despawn timer
	var/will_be_destroyed = FALSE
	/// Despawn timer of the butterfly
	var/despawn_timer = 0

/mob/living/basic/butterfly/lavaland/temporary/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/mob/living/basic/butterfly/lavaland/temporary/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/mob/living/basic/butterfly/lavaland/temporary/process()
	if(should_despawn())
		if(will_be_destroyed)
			return
		will_be_destroyed = TRUE
		despawn_timer = addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/basic/butterfly/lavaland/temporary, fadeout)), 5 SECONDS, TIMER_STOPPABLE)
		return

	if(will_be_destroyed)
		// Cancels the butterfly being destroyed
		will_be_destroyed = FALSE
		deltimer(despawn_timer)

/// Checks whether the butterfly should be despawned after the next check, based on distance from source
/mob/living/basic/butterfly/lavaland/temporary/proc/should_despawn()
	if(QDELETED(source))
		return TRUE
	if(get_dist(source, src) > max_distance)
		return TRUE
	return FALSE

/// Fade the butterfly out before deleting it.
/// Looks much better than it just blipping out of existence
/mob/living/basic/butterfly/lavaland/temporary/proc/fadeout()
	animate(src, alpha = 0, 1 SECONDS)
	QDEL_IN(src, 1 SECONDS)

/mob/living/basic/butterfly/lavaland/temporary/examine(mob/user)
	. = ..()
	. += span_notice("它看上去有些不太真实……")
