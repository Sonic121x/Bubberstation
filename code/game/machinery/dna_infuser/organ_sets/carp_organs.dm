#define CARP_ORGAN_COLOR "#4caee7"
#define CARP_SCLERA_COLOR "#ffffff"
#define CARP_PUPIL_COLOR "#00b1b1"
#define CARP_COLORS CARP_ORGAN_COLOR + CARP_SCLERA_COLOR + CARP_PUPIL_COLOR

///bonus of the carp: you can swim through space!
/datum/status_effect/organ_set_bonus/carp
	id = "organ_set_bonus_carp"
	organs_needed = 4
	bonus_activate_text = span_notice("太空鲤鱼的 DNA 已与你深度融合！你学会了在太空中游动！")
	bonus_deactivate_text = span_notice("你的 DNA 再次以自身为主，在太空中游动的能力也随之消失了……")
	bonus_traits = list(TRAIT_SPACEWALK)
	bonus_biotype = MOB_AQUATIC
	limb_texture = /datum/bodypart_texture/carpskin
	color_overlay_priority = LIMB_COLOR_CARP_INFUSION

///Carp lungs! You can breathe in space! Oh... you can't breathe on the station, you need low oxygen environments.
/// Inverts behavior of lungs. Bypasses suffocation due to space / lack of gas, but also allows Oxygen to suffocate.
/obj/item/organ/lungs/carp
	name = "突变鲤鱼肺"
	desc = "一对原本正常的肺，融合了太空鲤鱼的 DNA。"
	// Oxygen causes suffocation.
	safe_oxygen_min = 0
	safe_oxygen_max = 15

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/lungs/carp"
	post_init_icon_state = "lungs"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = CARP_COLORS
	organ_traits = list(TRAIT_NODROWN, TRAIT_NO_BREATHLESS_DAMAGE)

/obj/item/organ/lungs/carp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noticable_organ, "颈部长着奇怪的鳃。", BODY_ZONE_HEAD)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)

///occasionally sheds carp teeth, stronger melee (bite) attacks, but you can't cover your mouth anymore.
/obj/item/organ/tongue/carp
	name = "突变鲤鱼颚"
	desc = "一副原本正常的牙齿，融合了太空鲤鱼的 DNA。"

	say_mod = "咬牙说道"

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/tongue/carp"
	post_init_icon_state = "tongue"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = CARP_COLORS

/obj/item/organ/tongue/carp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noticable_organ, "牙齿硕大而尖锐。", BODY_ZONE_PRECISE_MOUTH)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)

/obj/item/organ/tongue/carp/on_mob_insert(mob/living/carbon/tongue_owner, special, movement_flags)
	. = ..()
	if(!ishuman(tongue_owner))
		return
	var/mob/living/carbon/human/human_receiver = tongue_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(tongue_owner, rec_species.no_equip_flags | ITEM_SLOT_MASK)

/obj/item/organ/tongue/carp/on_bodypart_insert(obj/item/bodypart/head)
	. = ..()
	head.unarmed_damage_low = 10
	head.unarmed_damage_high = 15
	head.unarmed_effectiveness = 15
	head.unarmed_attack_effect = ATTACK_EFFECT_BITE
	head.unarmed_sharpness = SHARP_POINTY

/obj/item/organ/tongue/carp/on_mob_remove(mob/living/carbon/tongue_owner)
	. = ..()
	if(!ishuman(tongue_owner))
		return
	var/mob/living/carbon/human/human_receiver = tongue_owner
	if(!human_receiver.can_mutate())
		return
	var/datum/species/rec_species = human_receiver.dna.species
	rec_species.update_no_equip_flags(tongue_owner, initial(rec_species.no_equip_flags))

/obj/item/organ/tongue/carp/on_bodypart_remove(obj/item/bodypart/head)
	. = ..()
	head.unarmed_damage_low = initial(head.unarmed_damage_low)
	head.unarmed_damage_high = initial(head.unarmed_damage_high)
	head.unarmed_effectiveness = initial(head.unarmed_effectiveness)
	head.unarmed_attack_effect = initial(head.unarmed_attack_effect)
	head.unarmed_sharpness = initial(head.unarmed_sharpness)

/obj/item/organ/tongue/carp/on_life(seconds_per_tick)
	. = ..()
	if(IS_UNCONSCIOUS_OR_CRIT(owner) || !prob(0.1))
		return
	owner.emote("cough")
	var/turf/tooth_fairy = get_turf(owner)
	if(tooth_fairy)
		new /obj/item/knife/carp(tooth_fairy)

/obj/item/organ/tongue/carp/get_possible_languages()
	. = ..()
	. += /datum/language/carptongue

/obj/item/knife/carp
	name = "鲤鱼牙齿"
	desc = "看起来很尖。尖到能戳瞎人的眼睛。妈的，这牙可真大。"
	icon_state = "carptooth"
	icon_angle = -45

///carp brain. you need to occasionally go to a new zlevel. think of it as... walking your dog!
/obj/item/organ/brain/carp
	name = "突变鲤鱼脑"
	desc = "一颗原本正常的大脑，融合了太空鲤鱼的 DNA。"

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/brain/carp"
	post_init_icon_state = "brain"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = CARP_COLORS
	can_smoothen_out = FALSE
	shade_color = "blue"
	organ_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LITERATE, TRAIT_CAN_STRIP, TRAIT_FERAL_BITER)

	///Timer counting down. When finished, the owner gets a bad moodlet.
	var/cooldown_timer
	///how much time the timer is given
	var/cooldown_time = 10 MINUTES

/obj/item/organ/brain/carp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/noticable_organ, "看起来一刻也闲不住。")

/obj/item/organ/brain/carp/on_mob_insert(mob/living/carbon/brain_owner)
	. = ..()
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(unsatisfied_nomad)), cooldown_time, TIMER_STOPPABLE|TIMER_OVERRIDE|TIMER_UNIQUE)
	RegisterSignal(brain_owner, COMSIG_MOVABLE_Z_CHANGED, PROC_REF(satisfied_nomad))

//technically you could get around the mood issue by extracting and reimplanting the brain but it will be far easier to just go one z there and back
/obj/item/organ/brain/carp/on_mob_remove(mob/living/carbon/brain_owner)
	. = ..()
	UnregisterSignal(brain_owner, COMSIG_MOVABLE_Z_CHANGED)
	deltimer(cooldown_timer)

/obj/item/organ/brain/carp/get_attacking_limb(mob/living/carbon/human/target)
	return owner.get_bodypart(BODY_ZONE_HEAD)

/obj/item/organ/brain/carp/proc/unsatisfied_nomad()
	owner.add_mood_event("nomad", /datum/mood_event/unsatisfied_nomad)

/obj/item/organ/brain/carp/proc/satisfied_nomad()
	SIGNAL_HANDLER
	owner.clear_mood_event("nomad")
	cooldown_timer = addtimer(CALLBACK(src, PROC_REF(unsatisfied_nomad)), cooldown_time, TIMER_STOPPABLE|TIMER_OVERRIDE|TIMER_UNIQUE)

/// makes you cold resistant, but heat-weak.
/obj/item/organ/heart/carp
	name = "突变鲤鱼心脏"
	desc = "一颗原本正常的心脏，融合了太空鲤鱼的 DNA。"

	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/organ/heart/carp"
	post_init_icon_state = "heart"
	greyscale_config = /datum/greyscale_config/mutant_organ
	greyscale_colors = CARP_COLORS

	organ_traits = list(TRAIT_RESISTCOLD, TRAIT_RESISTLOWPRESSURE)

/obj/item/organ/heart/carp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/noticable_organ, "皮肤上长着小片鳞片。", BODY_ZONE_CHEST)
	AddElement(/datum/element/organ_set_bonus, /datum/status_effect/organ_set_bonus/carp)
	AddElement(/datum/element/update_icon_blocker)

#undef CARP_ORGAN_COLOR
#undef CARP_SCLERA_COLOR
#undef CARP_PUPIL_COLOR
#undef CARP_COLORS
