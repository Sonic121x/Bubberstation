/obj/item/organ/wings/moth
	name = "蛾翼"
	desc = "一对毛茸茸的蛾翼。"
	flight_for_species = list(SPECIES_MOTH)
	///Our associated shadow jaunt spell, for all nightmares
	var/datum/action/cooldown/spell/touch/moth_climb/our_climb
	///Our associated terrorize spell, for antagonist nightmares
	var/datum/action/cooldown/spell/moth_and_dash/our_dash

/obj/item/organ/wings/moth/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()

	if(ismoth(organ_owner))
		our_climb = new(organ_owner)
		our_climb.Grant(organ_owner)

		our_dash = new(organ_owner)
		our_dash.Grant(organ_owner)

/obj/item/organ/wings/moth/on_mob_remove(mob/living/carbon/organ_owner)
	. = ..()
	QDEL_NULL(our_climb)
	QDEL_NULL(our_dash)

/datum/action/cooldown/spell/moth_and_dash
	name = "振翅"
	desc = "强行用翅膀推动自己向前，但十分消耗体力。"
	button_icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	button_icon_state = "m_moth_wings_gothic_BEHIND"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE
	var/jumpdistance = 5 //-1 from to see the actual distance, e.g 4 goes over 3 tiles
	var/jumpspeed = 3
	var/datum/weakref/dash_action_ref
	COOLDOWN_DECLARE(dash_cooldown)

/datum/action/cooldown/spell/moth_and_dash/Trigger(trigger_flags, action, atom/target)
	if(!..())
		return FALSE
	if (!isliving(owner))
		return

	var/turf/our_turf = get_turf(owner)
	var/datum/gas_mixture/environment = our_turf.return_air()

	if(environment.return_pressure() < (HAZARD_LOW_PRESSURE))
		to_chat(owner, span_warning("空气太稀薄了，你的翅膀根本使不上力！"))
		return

	if(owner.incapacitated)
		return

	if(!COOLDOWN_FINISHED(src, dash_cooldown))
		to_chat(owner, span_warning("你的翅膀累得不行了，让它们休息一下吧！"))
		return

	var/atom/dash_target = get_edge_target_turf(owner, owner.dir) //gets the user's direction

	ADD_TRAIT(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)
	if (owner.throw_at(dash_target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(owner, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		playsound(owner, 'sound/mobs/humanoids/moth/moth_flutter.ogg', 50, TRUE, TRUE)
		owner.visible_message(span_warning("[usr] 猛地一振翅，向前冲去！"))
		COOLDOWN_START(src, dash_cooldown, 6 SECONDS)
		var/mob/living/dash_user = owner
		if(istype(dash_user))
			dash_user.adjust_stamina_loss(40) //Given the risk of flying into things and crashing quite violently, you get four of these. Every one slows you down anyway.
	else
		to_chat(owner, span_warning("有什么东西阻止了你向前冲刺！"))

/datum/emote/living/mothic_dash
	key = "mdash"
	key_third_person = "mothdash"
	cooldown = 6 SECONDS

/datum/emote/living/mothic_dash/run_emote(mob/living/user, params, type_override, intentional)
	if (ishuman(user) && intentional)
		var/datum/action/cooldown/spell/moth_and_dash/dash_action = locate() in user.actions
		if(dash_action)
			dash_action.Trigger()

	return ..()

/datum/action/cooldown/spell/touch/moth_climb
	name = "展翅"
	desc = "展开翅膀以便攀爬，但这会极其消耗体力。"
	button_icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	button_icon_state = "m_moth_wings_monarch_BEHIND"
	check_flags = AB_CHECK_CONSCIOUS|AB_CHECK_HANDS_BLOCKED|AB_CHECK_INCAPACITATED
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
	antimagic_flags = NONE

	hand_path = /obj/item/climbing_hook/climbing_moth_wings
	draw_message = span_notice("你展开翅膀，准备向上攀爬。")
	drop_message = span_notice("你的翅膀收回到背后。")

/obj/item/climbing_hook/climbing_moth_wings
	name = "展开的翅膀"
	desc = "可用于攀爬到高处，但很累人。"
	icon = 'icons/mob/human/species/moth/moth_wings.dmi'
	icon_state = "m_moth_wings_monarch_BEHIND"
	climb_time = 2.5 SECONDS
	force = 0
	throwforce = 0
	climbsound = 'sound/mobs/humanoids/moth/moth_flutter.ogg'

/obj/item/climbing_hook/climbing_moth_wings/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/turf/check_turf = get_turf(user)
	var/datum/gas_mixture/environment = check_turf.return_air()
	if(environment.return_pressure() < (HAZARD_LOW_PRESSURE))
		to_chat(user, span_warning("空气太稀薄了，你的翅膀根本使不上力！"))
		return ITEM_INTERACT_BLOCKING
	. = ..()
	qdel(src)
