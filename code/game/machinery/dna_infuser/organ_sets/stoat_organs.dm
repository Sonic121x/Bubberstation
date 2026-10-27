// Organ color - Sclera color - Pupil color
#define STOAT_COLORS COLOR_BROWNER_BROWN + COLOR_BLACK + COLOR_BLACK

/datum/status_effect/organ_set_bonus/stoat
	id = "organ_set_bonus_stoat"
	tick_interval = 3 SECONDS
	organs_needed = 4
	bonus_activate_text = span_notice("白鼬的 DNA 已与你深度融合！\
		本能占据了上风——你现在无所畏惧，仿佛无论体型相差多大，都能迎战任何敌人。")
	bonus_deactivate_text = span_notice("你不再以白鼬成分为主，\
		这才意识到体型更大的敌人终究还是挺吓人的。")
	bonus_traits = list(TRAIT_FEARLESS, TRAIT_NOFEAR_HOLDUPS)
	COOLDOWN_DECLARE(big_attack_dodge_cd)

/datum/status_effect/organ_set_bonus/stoat/enable_bonus(obj/item/organ/inserted_organ)
	. = ..()
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(dodge_bigger_attack))

/datum/status_effect/organ_set_bonus/stoat/disable_bonus(obj/item/organ/removed_organ)
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK)
	owner.clear_mood_event("stoat_enemy")
	owner.clear_mood_event("stoat_friendly")

/datum/status_effect/organ_set_bonus/stoat/on_remove()
	. = ..()
	UnregisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK)
	owner.clear_mood_event("stoat_enemy")
	owner.clear_mood_event("stoat_friendly")

/datum/status_effect/organ_set_bonus/stoat/proc/dodge_bigger_attack(datum/source, atom/movable/hit_by, damage, the_attack, attack_type, ...)
	SIGNAL_HANDLER

	if(attack_type != UNARMED_ATTACK && attack_type != OVERWHELMING_ATTACK && attack_type != LEAP_ATTACK)
		return NONE
	if(!COOLDOWN_FINISHED(src, big_attack_dodge_cd))
		return NONE
	if(isliving(hit_by))
		var/mob/living/attacker = hit_by
		if(attacker.mob_size <= owner.mob_size)
			return NONE
	else if(!ismecha(hit_by))
		return NONE

	if(owner.incapacitated || owner.is_blind())
		return FAILED_BLOCK

	INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "spin")
	owner.visible_message(
		span_warning("[owner]本能地躲开了[hit_by]的[the_attack]！"),
		span_warning("你本能地躲开了[hit_by]的[the_attack]！"),
		vision_distance = COMBAT_MESSAGE_RANGE,
	)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/stoat_dodge)
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/stoat_dodge), 1 SECONDS)
	COOLDOWN_START(src, big_attack_dodge_cd, 5 SECONDS)
	playsound(owner, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
	return SUCCESSFUL_BLOCK

/datum/status_effect/organ_set_bonus/stoat/proc/is_dangerous_mob(mob/living/target)
	if(IS_UNCONSCIOUS(target))
		return FALSE
	if(istype(target, /mob/living/basic/stoat))
		return owner.gender == MALE && target.gender == MALE // other stoats are ENEMIES if we are both males
	for(var/obj/item/weapon in target.held_items)
		if(weapon.force > 15 || isgun(weapon))
			return TRUE
	if(target.mob_size > owner.mob_size)
		return TRUE
	if(target.mob_size == owner.mob_size)
		return !ishuman(target) // assuming same-sized animals are enemies, same-sized humans are friends
	return FALSE

/datum/status_effect/organ_set_bonus/stoat/proc/is_friendly_mob(mob/living/target)
	if(IS_UNCONSCIOUS(target))
		return FALSE
	if(istype(target, /mob/living/basic/stoat))
		return owner.gender != MALE || target.gender != MALE
	if(ishuman(target))
		return TRUE
	return FALSE

/datum/status_effect/organ_set_bonus/stoat/tick(seconds_between_ticks)
	. = ..()
	if(!bonus_active)
		return
	var/nearby_friends = 0
	var/nearby_enemies = 0
	for(var/obj/vehicle/sealed/mecha/mech in oview(owner, 5))
		nearby_enemies++
	for(var/mob/living/nearby in oview(owner, 5))
		if(is_dangerous_mob(nearby))
			nearby_enemies++
		else if(is_friendly_mob(nearby))
			nearby_friends++

	if(nearby_enemies)
		switch(nearby_enemies)
			if(1)
				owner.add_mood_event("stoat_enemy", /datum/mood_event/stoat/enemies_nearby/one)
			if(2 to 4)
				owner.add_mood_event("stoat_enemy", /datum/mood_event/stoat/enemies_nearby/multiple)
			if(4 to INFINITY)
				owner.add_mood_event("stoat_enemy", /datum/mood_event/stoat/enemies_nearby/crowd)
		owner.clear_mood_event("stoat_friendly")

	else
		switch(nearby_friends)
			if(0)
				owner.add_mood_event("stoat_friendly", /datum/mood_event/stoat/friendlies_nearby/one)
			if(2 to 4)
				owner.add_mood_event("stoat_friendly", /datum/mood_event/stoat/friendlies_nearby/multiple)
			if(4 to INFINITY)
				owner.add_mood_event("stoat_friendly", /datum/mood_event/stoat/friendlies_nearby/crowd)
		owner.clear_mood_event("stoat_enemy")


/obj/item/organ/heart/stoat
	name = "突变白鼬心脏"
	desc = "一颗原本正常的心脏，融合了白鼬的 DNA。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/heart/stoat"
	post_init_icon_state = "heart"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = STOAT_COLORS
	beat_noise = "急促而尖细的扑通声"
	maxHealth = parent_type::maxHealth * 0.8 // weaker heart
	organ_traits = list(TRAIT_TOO_TALL) //noodly boy

/obj/item/organ/heart/stoat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/stoat)
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/tongue/stoat
	name = "突变白鼬舌头"
	desc = "一条原本正常的舌头，融合了白鼬的 DNA。"
	say_mod = "啾啾说道"
	modifies_speech = TRUE
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/tongue/rat"
	post_init_icon_state = "tongue"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = STOAT_COLORS
	liked_foodtypes = MEAT | RAW | GORE | BUGS
	disliked_foodtypes = FRUIT | VEGETABLES
	taste_sensitivity = 12
	organ_traits = list(TRAIT_FERAL_BITER)

/obj/item/organ/tongue/stoat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/stoat)

/obj/item/organ/tongue/stoat/on_life(seconds_per_tick)
	. = ..()
	if(prob(1))
		playsound(owner, 'sound/mobs/non-humanoids/stoat/stoat_sounds.ogg', 100)

/obj/item/organ/tongue/stoat/on_mob_insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignals(receiver, COMSIG_LIVING_GET_PERCEIVED_FOOD_QUALITY, PROC_REF(get_perceived_food_quality))
	if(ishuman(receiver))
		var/mob/living/carbon/human/human_receiver = receiver
		human_receiver.physiology.hunger_mod *= 2

/obj/item/organ/tongue/stoat/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_LIVING_GET_PERCEIVED_FOOD_QUALITY)
	if(ishuman(organ_owner))
		var/mob/living/carbon/human/human_remover = organ_owner
		human_remover.physiology.hunger_mod /= 2

/obj/item/organ/tongue/stoat/on_bodypart_insert(obj/item/bodypart/limb)
	. = ..()
	limb.unarmed_damage_low += 7
	limb.unarmed_damage_high += 7
	limb.unarmed_effectiveness += 20
	limb.unarmed_pummeling_bonus += 0.75
	limb.unarmed_attack_effect = ATTACK_EFFECT_BITE
	limb.unarmed_sharpness = SHARP_POINTY

/obj/item/organ/tongue/stoat/on_bodypart_remove(obj/item/bodypart/limb)
	. = ..()
	limb.unarmed_damage_low -= 7
	limb.unarmed_damage_high -= 7
	limb.unarmed_effectiveness -= 20
	limb.unarmed_pummeling_bonus -= 0.75
	limb.unarmed_attack_effect = initial(limb.unarmed_attack_effect)
	limb.unarmed_sharpness = initial(limb.unarmed_sharpness)

/obj/item/organ/tongue/stoat/proc/get_perceived_food_quality(mob/living/carbon/consumer, obj/item/food/consumed_food, list/extra_quality)
	SIGNAL_HANDLER

	if(organ_flags & ORGAN_FAILING)
		return
	if(istype(consumed_food, /obj/item/food/deadmouse) || istype(consumed_food, /obj/item/food/egg))
		extra_quality += LIKED_FOOD_QUALITY_CHANGE

/obj/item/organ/eyes/stoat
	name = "突变白鼬眼睛"
	desc = "一对原本正常的眼睛，融合了白鼬的 DNA。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/eyes/stoat"
	post_init_icon_state = "eyes"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = STOAT_COLORS
	eye_color_left = COLOR_BLACK
	eye_color_right = COLOR_BLACK
	lighting_cutoff = LIGHTING_CUTOFF_LOW
	maxHealth = parent_type::maxHealth * 0.8 // weaker eyes
	penlight_message = "泛着绿光"

/obj/item/organ/eyes/stoat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/stoat)
	AddElement(/datum/element/noticable_organ, "眼睛是乌黑的圆球。", zone)

/obj/item/organ/ears/stoat
	name = "突变白鼬耳朵"
	desc = "一对原本正常的耳朵，融合了白鼬的 DNA。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/ears/stoat"
	post_init_icon_state = "ears"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = STOAT_COLORS
	damage_multiplier = 1.2
	maxHealth = parent_type::maxHealth * 0.8 // weaker ears

/obj/item/organ/ears/stoat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/stoat)
	AddElement(/datum/element/noticable_organ, "耳朵覆着绒毛，偶尔抽动。", zone)

/obj/item/organ/ears/stoat/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.eavesdrop_range += 2

/obj/item/organ/ears/stoat/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	organ_owner.eavesdrop_range -= 2

/obj/item/organ/snout/stoat
	name = "白鼬吻部"

/obj/item/organ/snout/stoat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/stoat)

/datum/mood_event/stoat

/datum/mood_event/stoat/enemies_nearby
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/stoat/enemies_nearby/one
	description = "本能告诉我附近有危险的东西，最好小心点。"
	mood_change = -1

/datum/mood_event/stoat/enemies_nearby/multiple
	description = "本能告诉我附近可能有危险，最好保持警惕。"
	mood_change = -3

/datum/mood_event/stoat/enemies_nearby/crowd
	description = "本能告诉我附近到处都是危险，我得离开这里！"
	mood_change = -5

/datum/mood_event/stoat/alone
	description = "附近没有别人，我的本能放松了下来。我感到平静。"
	mood_change = 1

/datum/mood_event/stoat/friendlies_nearby
	event_flags = MOOD_EVENT_FEAR

/datum/mood_event/stoat/friendlies_nearby/one
	description = "附近只有一个朋友，我的本能放松了下来。"

/datum/mood_event/stoat/friendlies_nearby/multiple
	description = "本能告诉我附近人太多了，我有些紧张。"
	mood_change = -1

/datum/mood_event/stoat/friendlies_nearby/crowd
	description = "本能告诉我附近人太多了，我得离开这里！"
	mood_change = -3

/datum/movespeed_modifier/stoat_dodge
	multiplicative_slowdown = 1

#undef STOAT_COLORS
