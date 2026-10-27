//Nearsightedness restricts your vision by several tiles.
/datum/mutation/nearsight
	name = "近视"
	desc = "受试者视力不佳，无法看清远处的物体。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你看不太清楚了。")

/datum/mutation/nearsight/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	owner.become_nearsighted(GENETIC_MUTATION)

/datum/mutation/nearsight/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.cure_nearsighted(GENETIC_MUTATION)

///Blind makes you blind. Who knew?
/datum/mutation/blind
	name = "失明"
	desc = "受试者完全失明，看不到任何东西。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你似乎什么也看不见了。")

/datum/mutation/blind/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	owner.become_blind(GENETIC_MUTATION)

/datum/mutation/blind/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.cure_blind(GENETIC_MUTATION)

///Thermal Vision lets you see mobs through walls
/datum/mutation/thermal
	name = "热成像视觉"
	desc = "受试者能够短暂集中目力，感知人体的热信号。\
		然而，反复使用会对眼睛造成损伤。"
	quality = POSITIVE
	difficulty = 18
	text_gain_indication = span_notice("你能看见从皮肤上散发的热量……")
	text_lose_indication = span_notice("你再也看不见从皮肤上散发的热量了……")
	instability = POSITIVE_INSTABILITY_MAJOR // thermals aren't station equipment
	synchronizer_coeff = 1
	power_coeff = 1
	energy_coeff = 1
	power_path = /datum/action/cooldown/spell/thermal_vision

/datum/mutation/thermal/on_losing(mob/living/carbon/human/owner)
	if(..())
		return

	// Something went wront and we still have the thermal vision from our power, no cheating.
	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, GENETIC_MUTATION)

/datum/mutation/thermal/setup()
	. = ..()
	var/datum/action/cooldown/spell/thermal_vision/to_modify = .
	if(!istype(to_modify)) // null or invalid
		return

	to_modify.eye_damage = /datum/action/cooldown/spell/thermal_vision::eye_damage * GET_MUTATION_SYNCHRONIZER(src) * GET_MUTATION_POWER(src)
	to_modify.thermal_duration = /datum/action/cooldown/spell/thermal_vision::thermal_duration * GET_MUTATION_POWER(src)

/datum/action/cooldown/spell/thermal_vision
	name = "启用热成像视觉"
	desc = "以损伤视力为代价，观察热信号。"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "augmented_eyesight"

	cooldown_time = 60 SECONDS
	spell_requirements = NONE

	/// How much eye damage is given on cast
	var/eye_damage = 7.5
	/// The duration of the thermal vision
	var/thermal_duration = 30 SECONDS

/datum/action/cooldown/spell/thermal_vision/Remove(mob/living/remove_from)
	REMOVE_TRAIT(remove_from, TRAIT_THERMAL_VISION, GENETIC_MUTATION)
	return ..()

/datum/action/cooldown/spell/thermal_vision/is_valid_target(atom/cast_on)
	return isliving(cast_on) && !HAS_TRAIT(cast_on, TRAIT_THERMAL_VISION)

/datum/action/cooldown/spell/thermal_vision/cast(mob/living/cast_on)
	. = ..()
	ADD_TRAIT(cast_on, TRAIT_THERMAL_VISION, GENETIC_MUTATION)
	to_chat(cast_on, span_info("你极力集中目力，视野中浮现出热信号。"))
	addtimer(CALLBACK(src, PROC_REF(deactivate), cast_on), thermal_duration)

/datum/action/cooldown/spell/thermal_vision/proc/deactivate(mob/living/cast_on)
	if(QDELETED(cast_on) || !HAS_TRAIT_FROM(cast_on, TRAIT_THERMAL_VISION, GENETIC_MUTATION))
		return

	REMOVE_TRAIT(cast_on, TRAIT_THERMAL_VISION, GENETIC_MUTATION)
	to_chat(cast_on, span_info("你眨了几下眼，视野恢复正常，双眼却开始隐隐作痛。"))

	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_cast_on = cast_on
		carbon_cast_on.adjust_organ_loss(ORGAN_SLOT_EYES, eye_damage)

///X-ray Vision lets you see through walls.
/datum/mutation/xray
	name = "透视"
	desc = "受试者能够透过墙壁看见后面的空间。" //actual x-ray would mean you'd constantly be blasting rads, which might be fun for later //hmb
	text_gain_indication = span_notice("墙壁突然消失了！")
	instability = POSITIVE_INSTABILITY_MAJOR
	locked = TRUE

/datum/mutation/xray/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_XRAY_VISION, GENETIC_MUTATION)

/datum/mutation/xray/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_XRAY_VISION, GENETIC_MUTATION)


///Laser Eyes lets you shoot lasers from your eyes!
/datum/mutation/laser_eyes
	name = "激光眼"
	desc = "受试者能够从眼中反射出集中的光束。"
	quality = POSITIVE
	locked = TRUE
	difficulty = 16
	text_gain_indication = span_notice("你感到眼球后方的压力不断增加。")
	layer_used = FRONT_MUTATIONS_LAYER
	limb_req = BODY_ZONE_HEAD
	mutation_icon_state = "lasereyes"

/datum/mutation/laser_eyes/on_acquiring(mob/living/carbon/human/H)
	. = ..()
	if(!.)
		return
	RegisterSignal(H, COMSIG_MOB_ATTACK_RANGED, PROC_REF(on_ranged_attack))

/datum/mutation/laser_eyes/on_losing(mob/living/carbon/human/H)
	. = ..()
	if(.)
		return
	UnregisterSignal(H, COMSIG_MOB_ATTACK_RANGED)

///Triggers on COMSIG_MOB_ATTACK_RANGED. Does the projectile shooting.
/datum/mutation/laser_eyes/proc/on_ranged_attack(mob/living/carbon/human/source, atom/target, modifiers)
	SIGNAL_HANDLER

	if(!source.combat_mode)
		return
	to_chat(source, span_warning("你从双眼中射出激光！"))
	source.changeNext_move(CLICK_CD_RANGE)
	source.newtonian_move(get_angle(source, target))
	var/obj/projectile/beam/laser/laser_eyes/LE = new(source.loc)
	LE.firer = source
	LE.def_zone = ran_zone(source.zone_selected)
	LE.aim_projectile(target, source, modifiers)
	INVOKE_ASYNC(LE, TYPE_PROC_REF(/obj/projectile, fire))
	playsound(source, 'sound/items/weapons/taser2.ogg', 75, TRUE)

///Projectile type used by laser eyes
/obj/projectile/beam/laser/laser_eyes
	name = "光束"
	icon = 'icons/mob/effects/genetics.dmi'
	icon_state = "eyelasers"

/datum/mutation/illiterate
	name = "文盲"
	desc = "受试者失去阅读与书写能力。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你感觉自己无法阅读或书写了。")
	text_lose_indication = span_danger("你感觉自己又能阅读和书写了。")

/datum/mutation/illiterate/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_ILLITERATE, GENETIC_MUTATION)

/datum/mutation/illiterate/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_ILLITERATE, GENETIC_MUTATION)

/datum/mutation/night_vision
	name = "夜视"
	desc = "受试者能够在黑暗中看清事物。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	text_gain_indication = span_notice("房间角落的黑暗消退了。")
	text_lose_indication = span_notice("房间角落重新陷入黑暗。")

/datum/mutation/night_vision/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, GENETIC_MUTATION)

/datum/mutation/night_vision/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, GENETIC_MUTATION)
