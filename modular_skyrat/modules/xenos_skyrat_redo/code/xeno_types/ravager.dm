/// SKYRAT MODULE SKYRAT_XENO_REDO

#define RAVAGER_OUTLINE_EFFECT "ravager_endure_outline"

/mob/living/carbon/alien/adult/skyrat/ravager
	name = "异形蹂躏者"
	desc = "披着怒焰般红色甲壳的异形，双手被同样骇人的刀刃状利爪取代。那条尖锐尾巴看起来也很要命。"
	caste = "ravager"
	maxHealth = 350
	health = 350
	icon_state = "alienravager"
	melee_damage_lower = 30
	melee_damage_upper = 35
	default_organ_types_by_slot = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain/alien,
		ORGAN_SLOT_XENO_HIVENODE = /obj/item/organ/alien/hivenode,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue/alien,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/alien,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver/alien,
		ORGAN_SLOT_EARS = /obj/item/organ/ears,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach/alien,
		ORGAN_SLOT_XENO_PLASMAVESSEL = /obj/item/organ/alien/plasmavessel,
	)

/mob/living/carbon/alien/adult/skyrat/ravager/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/spell/aoe/repulse/xeno/skyrat_tailsweep/slicing,
		/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die,
		/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager,
	)
	grant_actions_by_list(innate_actions)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager
	name = "三连冲锋"
	desc = "向指定位置连续冲锋三次，践踏沿途的一切。"
	cooldown_time = 30 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 7
	charge_past = 3
	destroy_objects = FALSE
	charge_damage = 25
	button_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "ravager_charge"
	unset_after_click = TRUE

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/do_charge_indicator(atom/charger, atom/charge_target)
	playsound(charger, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar2.ogg', 100, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/Activate(atom/target_atom)
	. = ..()
	return TRUE

/datum/action/cooldown/spell/aoe/repulse/xeno/skyrat_tailsweep/slicing
	name = "利刃扫尾"
	desc = "挥尾击退攻击者，并用尖锐的尾尖将其割伤。"

	aoe_radius = 2

	button_icon_state = "slice_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/ravager

	sound = 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_tail_swipe.ogg' //The defender's tail sound isn't changed because its big and heavy, this isn't

	impact_sound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	impact_damage = 40
	impact_sharpness = SHARP_EDGED

/obj/effect/temp_visual/dir_setting/tailsweep/ravager
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	icon_state = "slice_tail_anim"

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die
	name = "坚忍"
	desc = "让难以想象的怒火（以及等离子体）充满全身，短时间内无视一切痛苦。"
	button_icon_state = "literally_too_angry"
	plasma_cost = 250 //This requires full plasma to do, so there can be some time between armstrong moments
	/// If the endure ability is currently active or not
	var/endure_active = FALSE
	/// How long the endure ability should last when activated
	var/endure_duration = 20 SECONDS

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die/Activate()
	. = ..()
	if(endure_active)
		owner.balloon_alert(owner, "已处于坚忍状态")
		return FALSE
	owner.balloon_alert(owner, "坚忍已生效")
	playsound(owner, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar1.ogg', 100, TRUE, 8, 0.9)
	to_chat(owner, span_danger("我们麻痹痛觉，在接下来的 [endure_duration/10] 秒内战至最后一刻。"))
	addtimer(CALLBACK(src, PROC_REF(endure_deactivate)), endure_duration)
	owner.add_filter(RAVAGER_OUTLINE_EFFECT, 4, outline_filter(1, COLOR_RED_LIGHT))
	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)
	endure_active = TRUE
	return TRUE

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die/proc/endure_deactivate()
	endure_active = FALSE
	owner.balloon_alert(owner, "坚忍已结束")
	owner.remove_filter(RAVAGER_OUTLINE_EFFECT)
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)

#undef RAVAGER_OUTLINE_EFFECT
