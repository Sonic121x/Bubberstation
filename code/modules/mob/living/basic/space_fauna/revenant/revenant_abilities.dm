#define REVENANT_DEFILE_MIN_DAMAGE 30
#define REVENANT_DEFILE_MAX_DAMAGE 50

//Transmit: the revenant's only direct way to communicate. Sends a single message silently to a single mob
/datum/action/cooldown/spell/list_target/telepathy/revenant
	name = "亡魂传讯"
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"

	telepathy_span = "revennotice"
	bold_telepathy_span = "revenboldnotice"

	antimagic_flags = MAGIC_RESISTANCE_HOLY|MAGIC_RESISTANCE_MIND

/datum/action/cooldown/spell/list_target/telepathy/revenant/get_list_targets(atom/center, target_radius = 7)
	if(!istype(center, /mob/living/basic/revenant))
		return ..()
	var/mob/living/basic/revenant/revenant = center
	if(!revenant.dormant)
		return ..()
	return ..(get_turf(revenant), 2)

/datum/action/mirror_talk
	name = "Mirror Talk"
	desc = "Communicate with the living world through your prison."
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon = 'icons/mob/actions/actions_revenant.dmi'
	button_icon_state = "mirror_talk"

/datum/action/mirror_talk/IsAvailable(feedback = FALSE)
	return ..() && istype(owner.loc, /obj/structure/mirror)


/datum/action/mirror_talk/Trigger(mob/clicker, trigger_flags)
	if(!..())
		return FALSE
	var/obj/structure/mirror/mirror = astype(clicker.loc)
	if(!mirror)
		return FALSE
	var/message = tgui_input_text(clicker, "What do you wish to say?", "Mirror Talk", max_length = MAX_MESSAGE_LEN)
	if(!message || QDELETED(src) || QDELETED(clicker) || !IsAvailable())
		return FALSE
	clicker.log_message("\"[message]\"", LOG_SAY)
	mirror.say(message, spans = list(SPAN_REVENWARNING), sanitize = FALSE)
	return TRUE

/datum/action/cooldown/spell/aoe/revenant
	background_icon_state = "bg_revenant"
	overlay_icon_state = "bg_revenant_border"
	button_icon = 'icons/mob/actions/actions_revenant.dmi'

	antimagic_flags = MAGIC_RESISTANCE_HOLY
	spell_requirements = NONE

	/// How much essence it costs to unlock
	var/unlock_amount = 100
	/// How much essence it costs to use
	var/cast_amount = 50
	/// How long it reveals the revenant
	var/reveal_duration = 8 SECONDS
	// How long it stuns the revenant
	var/stun_duration = 2 SECONDS

/datum/action/cooldown/spell/aoe/revenant/New(Target)
	. = ..()
	AddComponent(/datum/component/revenant_ability, \
		unlock_amount = unlock_amount, \
		cast_amount = cast_amount, \
		reveal_duration = reveal_duration, \
		stun_duration = stun_duration, \
	)

/datum/action/cooldown/spell/aoe/revenant/get_things_to_cast_on(atom/center)
	return RANGE_TURFS(aoe_radius, center)

/datum/action/cooldown/spell/aoe/revenant/vv_edit_var(var_name, var_value)
	. = ..()
	// gross getcomp, but this is solely to make life easier for badmins/debug. sue me
	var/datum/component/revenant_ability/rev_comp = GetComponent(/datum/component/revenant_ability)
	switch(var_name)
		if(NAMEOF(src, unlock_amount))
			rev_comp.set_unlock_amount(var_value)
		if(NAMEOF(src, cast_amount))
			rev_comp.set_cast_amount(var_value)
		if(NAMEOF(src, reveal_duration), NAMEOF(src, stun_duration))
			rev_comp.set_durations(reveal_duration, stun_duration)

//Overload Light: Breaks a light that's online and sends out lightning bolts to all nearby people.
/datum/action/cooldown/spell/aoe/revenant/overload
	name = "过载灯光"
	desc = "将大量精华注入附近的电灯，使灯光电击附近的人。"
	button_icon_state = "overload_lights"
	cooldown_time = 20 SECONDS

	aoe_radius = 5
	unlock_amount = 25
	cast_amount = 40
	stun_duration = 3 SECONDS

	/// The range the shocks from the lights go
	var/shock_range = 2
	/// The damage the shocks from the lights do
	var/shock_damage = 15

/datum/action/cooldown/spell/aoe/revenant/overload/cast_on_thing_in_aoe(turf/victim, mob/living/basic/revenant/caster)
	for(var/obj/machinery/light/light in victim)
		if(!light.on)
			continue

		light.visible_message(span_boldwarning("[light] 骤然爆亮，开始迸出火花！"))
		do_sparks(4, FALSE, light)
		new /obj/effect/temp_visual/revenant(get_turf(light))
		addtimer(CALLBACK(src, PROC_REF(overload_shock), light, caster), 2 SECONDS)

/datum/action/cooldown/spell/aoe/revenant/overload/proc/overload_shock(obj/machinery/light/to_shock, mob/living/basic/revenant/caster)
	flick("[to_shock.base_state]2", to_shock)
	for(var/mob/living/carbon/human/human_mob in view(shock_range, to_shock))
		if(human_mob == caster)
			continue
		to_shock.Beam(human_mob, icon_state = "purple_lightning", time = 0.5 SECONDS)
		if(!human_mob.can_block_magic(antimagic_flags))
			human_mob.electrocute_act(shock_damage, to_shock, flags = SHOCK_NOGLOVES)

		do_sparks(4, FALSE, human_mob)
		playsound(human_mob, 'sound/machines/defib/defib_zap.ogg', 50, TRUE, -1)

//Defile: Corrupts nearby stuff, unblesses floor tiles.
/datum/action/cooldown/spell/aoe/revenant/defile
	name = "亵渎"
	desc = "扭曲并腐化附近的区域，同时驱散地面上的神圣光环。"
	button_icon_state = "defile"
	cooldown_time = 15 SECONDS
	aoe_radius = 4
	unlock_amount = 10
	cast_amount = 30
	reveal_duration = 4 SECONDS
	stun_duration = 2 SECONDS

/datum/action/cooldown/spell/aoe/revenant/defile/cast_on_thing_in_aoe(turf/target_turf, mob/living/basic/revenant/caster)
	/// causes the purple sparks defile animation on the turf
	var/turf_was_defiled = FALSE

	// dispel
	if (HAS_TRAIT(target_turf, TRAIT_TURF_BLESSED))
		turf_was_defiled = TRUE
		target_turf.RemoveElement(/datum/element/blessed_turf)

	for(var/obj/effect/decal/cleanable/food/salt/salt in target_turf)
		turf_was_defiled = TRUE
		qdel(salt)

	// damage
	if(!isplatingturf(target_turf) && !istype(target_turf, /turf/open/floor/engine/cult) && isfloorturf(target_turf) && prob(15))
		var/turf/open/floor/floor = target_turf
		if(floor.overfloor_placed && floor.floor_tile)
			new floor.floor_tile(floor)
		floor.broken = 0
		floor.burnt = 0
		floor.make_plating(TRUE)
	for(var/obj/structure/window/window in target_turf)
		if(window.get_integrity() > REVENANT_DEFILE_MAX_DAMAGE)
			window.take_damage(rand(REVENANT_DEFILE_MIN_DAMAGE, REVENANT_DEFILE_MAX_DAMAGE))
		if(window.fulltile)
			new /obj/effect/temp_visual/revenant/cracks(window.loc)

	// rust
	if(target_turf.type == /turf/closed/wall && prob(15) && !HAS_TRAIT(target_turf, TRAIT_RUSTY))
		turf_was_defiled = TRUE
		target_turf.AddElement(/datum/element/rust)
	if(target_turf.type == /turf/closed/wall/r_wall && prob(10) && !HAS_TRAIT(target_turf, TRAIT_RUSTY))
		turf_was_defiled = TRUE
		target_turf.AddElement(/datum/element/rust)

	// alchemy
	for(var/obj/machinery/shower/cursed_shower in target_turf)
		turf_was_defiled = TRUE
		cursed_shower.has_water_reclaimer = FALSE
		cursed_shower.reagents.remove_all(1, relative=TRUE)
		cursed_shower.reagents.add_reagent(/datum/reagent/blood, initial(cursed_shower.reagent_capacity))
		if(prob(50))
			cursed_shower.intended_on = TRUE
			cursed_shower.update_actually_on(TRUE)
	for(var/obj/item/reagent_containers/cursed_container in target_turf)
		if(!cursed_container.is_open_container())
			continue
		if(!cursed_container.reagents.has_reagent(/datum/reagent/consumable/ethanol, check_subtypes=TRUE))
			continue

		turf_was_defiled = TRUE
		var/booze_amount = cursed_container.reagents.get_reagent_amount(/datum/reagent/consumable/ethanol, type_check=REAGENT_PARENT_TYPE)
		cursed_container.reagents.remove_reagent(/datum/reagent/consumable/ethanol, booze_amount, include_subtypes=TRUE)
		cursed_container.reagents.add_reagent(/datum/reagent/blood, booze_amount)
		cursed_container.update_appearance()
	for(var/obj/item/food/cursed_food in target_turf)
		if(cursed_food.trash_type)
			continue // the package protects it
		var/datum/component/germ_sensitive/germs = cursed_food.GetComponent(/datum/component/germ_sensitive)
		germs?.expose_to_germs()

	// opening
	for(var/obj/structure/closet/closet in target_turf.contents)
		if(closet.locked)
			continue

		turf_was_defiled = TRUE
		closet.open()
	for(var/obj/structure/bodycontainer/corpseholder in target_turf)
		turf_was_defiled = TRUE
		if(corpseholder.connected.loc == corpseholder)
			corpseholder.open()
	for(var/obj/machinery/dna_scannernew/dna in target_turf)
		turf_was_defiled = TRUE
		dna.open_machine()
	for(var/obj/machinery/cryo_cell/cursed_cryo_cell in target_turf)
		turf_was_defiled = TRUE
		cursed_cryo_cell.open_machine()
	for(var/obj/machinery/stasis/cursed_stasis in target_turf)
		turf_was_defiled = TRUE
		cursed_stasis.unbuckle_all_mobs()

	// obscure
	for(var/obj/item/reagent_containers/applicator/patch/cursed_patch in target_turf)
		turf_was_defiled = TRUE
		cursed_patch.name = /obj/item/reagent_containers/applicator/patch::name
		cursed_patch.desc = /obj/item/reagent_containers/applicator/patch::desc
		cursed_patch.icon_state = /obj/item/reagent_containers/applicator/patch::icon_state
		cursed_patch.update_appearance()
	for(var/obj/item/storage/pill_bottle/cursed_pill_bottle in target_turf)
		turf_was_defiled = TRUE
		cursed_pill_bottle.name = /obj/item/storage/pill_bottle::name
		cursed_pill_bottle.desc = /obj/item/storage/pill_bottle::desc
	for(var/obj/item/reagent_containers/applicator/pill/cursed_pill in target_turf)
		turf_was_defiled = TRUE
		cursed_pill.name = /obj/item/reagent_containers/applicator/pill::name
		cursed_pill.desc = /obj/item/reagent_containers/applicator/pill::desc
	for(var/obj/item/reagent_containers/cup/bottle/cursed_bottle in target_turf)
		turf_was_defiled = TRUE
		cursed_bottle.name = /obj/item/reagent_containers/cup/bottle::name
		cursed_bottle.desc = /obj/item/reagent_containers/cup/bottle::desc
	for(var/obj/item/reagent_containers/syringe/cursed_syringe in target_turf)
		turf_was_defiled = TRUE
		cursed_syringe.name = /obj/item/reagent_containers/syringe::name
		cursed_syringe.desc = /obj/item/reagent_containers/syringe::desc
	for(var/obj/item/reagent_containers/hypospray/medipen/cursed_medipen in target_turf)
		turf_was_defiled = TRUE
		// the default medipen subtype is epinephrine so we need to use generic hardcoded name/desc
		cursed_medipen.name = "医疗注射笔"
		cursed_medipen.desc = "一种快速而安全的试剂注射方式，供没有高级医学知识的人员为病人注射使用。"
	for(var/obj/item/reagent_containers/medigel/cursed_medigel in target_turf)
		turf_was_defiled = TRUE
		cursed_medigel.name = /obj/item/reagent_containers/medigel::name
		cursed_medigel.desc = /obj/item/reagent_containers/medigel::desc
		cursed_medigel.icon_state = /obj/item/reagent_containers/medigel::icon_state
		cursed_medigel.update_appearance()
	for(var/obj/item/reagent_containers/spray/cursed_spray in target_turf)
		turf_was_defiled = TRUE
		cursed_spray.name = /obj/item/reagent_containers/spray::name
		cursed_spray.desc = /obj/item/reagent_containers/spray::desc
		cursed_spray.icon_state = /obj/item/reagent_containers/spray::icon_state
		cursed_spray.update_appearance()
	for(var/obj/item/dnainjector/cursed_dnainjector in target_turf)
		turf_was_defiled = TRUE
		cursed_dnainjector.name = /obj/item/dnainjector::name
		cursed_dnainjector.desc = /obj/item/dnainjector::desc
	for(var/obj/item/reagent_containers/blood/cursed_blood in target_turf)
		turf_was_defiled = TRUE
		cursed_blood.name = /obj/item/reagent_containers/blood::name
		cursed_blood.desc = /obj/item/reagent_containers/blood::desc
	for(var/obj/machinery/portable_atmospherics/canister/cursed_canister in target_turf)
		turf_was_defiled = TRUE
		cursed_canister.name = /obj/machinery/portable_atmospherics/canister::name
		cursed_canister.desc = /obj/machinery/portable_atmospherics/canister::desc
		cursed_canister.icon_state = /obj/machinery/portable_atmospherics/canister::icon_state
		cursed_canister.base_icon_state = /obj/machinery/portable_atmospherics/canister::icon_state
		cursed_canister.set_greyscale(/obj/machinery/portable_atmospherics/canister::greyscale_colors, /obj/machinery/portable_atmospherics/canister::greyscale_config)
		//cursed_canister.update_appearance()

	for(var/obj/item/storage/lockbox/order/cursed_order in target_turf)
		turf_was_defiled = TRUE
		cursed_order.name = initial(cursed_order.name) // initial() is fine since we just want to remove the cargo info
	for(var/obj/structure/closet/crate/cursed_crate in target_turf)
		turf_was_defiled = TRUE
		cursed_crate.name = initial(cursed_crate.name)

	// spooky
	for(var/obj/machinery/light/light in target_turf)
		light.flicker(rand(3, 5))
	for(var/obj/structure/mirror/mirror in target_turf)
		if(istype(mirror, /obj/structure/mirror/magic))
			continue
		turf_was_defiled = TRUE
		mirror.atom_break("magic")

	if(turf_was_defiled)
		new /obj/effect/temp_visual/revenant(target_turf)

//Malfunction: Makes bad stuff happen to robots and machines.
/datum/action/cooldown/spell/aoe/revenant/malfunction
	name = "故障"
	desc = "腐化并损坏附近的机器与机械装置。"
	button_icon_state = "malfunction"
	cooldown_time = 20 SECONDS

	aoe_radius = 4
	cast_amount = 60
	unlock_amount = 125

	/// Typecache of stuff we generally don't want emaggable
	var/static/list/no_emag_typecache = typecacheof(list(
		/obj/machinery/power/apc,
		/obj/machinery/power/smes,
		/obj/machinery/computer/emergency_shuttle,
	))

// A note to future coders: do not replace this with an EMP because it will wreck malf AIs and everyone will hate you.
/datum/action/cooldown/spell/aoe/revenant/malfunction/cast_on_thing_in_aoe(turf/victim, mob/living/basic/revenant/caster)
	for(var/mob/living/basic/bot/bot in victim)
		if(!(bot.bot_access_flags & BOT_COVER_EMAGGED))
			new /obj/effect/temp_visual/revenant(bot.loc)
			bot.bot_access_flags &= ~BOT_COVER_LOCKED
			bot.bot_access_flags |= BOT_COVER_MAINTS_OPEN
			bot.emag_act(caster)
	for(var/mob/living/carbon/human/human in victim)
		if(human == caster)
			continue
		if(human.can_block_magic(antimagic_flags))
			continue
		to_chat(human, span_revenwarning("你感觉[pick("方向感忽明忽暗", "头部像被刺了一刀", "脑中充满了静电噪声")]。"))
		new /obj/effect/temp_visual/revenant(human.loc)
		human.emp_act(EMP_HEAVY)
	for(var/obj/thing in victim)
		if(is_type_in_typecache(thing, no_emag_typecache))
			continue
		if(!prob(20))
			continue
		if(prob(50))
			new /obj/effect/temp_visual/revenant(thing.loc)
		thing.emag_act(caster)
	// Only works on cyborgs, not AI!
	for(var/mob/living/silicon/robot/cyborg in victim)
		playsound(cyborg, 'sound/machines/warning-buzzer.ogg', 50, TRUE)
		new /obj/effect/temp_visual/revenant(cyborg.loc)
		cyborg.spark_system.start()
		cyborg.emp_act(EMP_HEAVY)

//Blight: Infects nearby humans and in general messes living stuff up.
/datum/action/cooldown/spell/aoe/revenant/blight
	name = "枯萎"
	desc = "使附近的活物逐渐衰败。"
	button_icon_state = "blight"
	cooldown_time = 20 SECONDS

	aoe_radius = 3
	cast_amount = 50
	unlock_amount = 75

/datum/action/cooldown/spell/aoe/revenant/blight/cast_on_thing_in_aoe(turf/victim, mob/living/basic/revenant/caster)
	for(var/mob/living/mob in victim)
		if(mob == caster)
			continue
		if(mob.can_block_magic(antimagic_flags))
			to_chat(caster, span_warning("法术对 [mob] 没有效果！"))
			continue
		new /obj/effect/temp_visual/revenant(mob.loc)
		if(iscarbon(mob))
			if(ishuman(mob))
				var/mob/living/carbon/human/H = mob
				if(H.dna && H.dna.species && !HAS_TRAIT(H, TRAIT_VIRUSIMMUNE)) // SKYRAT EDIT - No more funny purple hair
					H.set_haircolor("#1d2953", override = TRUE) //will be reset when blight is cured
				var/blightfound = FALSE
				for(var/datum/disease/revblight/blight in H.diseases)
					blightfound = TRUE
					if(blight.stage < 5)
						blight.stage++
				if(!blightfound)
					H.ForceContractDisease(new /datum/disease/revblight(), FALSE, TRUE)
					to_chat(H, span_revenminor("你感觉[pick("突然很不舒服", "一阵猛烈的恶心", "自己的皮肤<i>不对劲</i>")]。"))
			else
				if(mob.reagents)
					mob.reagents.add_reagent(/datum/reagent/toxin/plasma, 5)
		else
			mob.adjust_tox_loss(5)
	for(var/obj/structure/spacevine/vine in victim) //Fucking with botanists, the ability.
		vine.add_atom_colour("#823abb", TEMPORARY_COLOUR_PRIORITY)
		new /obj/effect/temp_visual/revenant(vine.loc)
		QDEL_IN(vine, 10)
	for(var/obj/structure/glowshroom/shroom in victim)
		shroom.add_atom_colour("#823abb", TEMPORARY_COLOUR_PRIORITY)
		new /obj/effect/temp_visual/revenant(shroom.loc)
		QDEL_IN(shroom, 10)
	for(var/obj/machinery/hydroponics/tray in victim)
		new /obj/effect/temp_visual/revenant(tray.loc)
		tray.set_pestlevel(rand(8, 10))
		tray.set_weedlevel(rand(8, 10))
		tray.set_toxic(rand(45, 55))

/datum/action/cooldown/spell/aoe/revenant/haunt_object
	name = "物品作祟"
	desc = "以幽灵能量灌注附近的物品，驱使它们攻击附近的活人。\
		离你越近的物品越容易被作祟。"
	button_icon_state = "r_haunt"
	max_targets = 7
	aoe_radius = 5

	unlock_amount = 30 // Similar to overload lights
	cast_amount = 50 // but has a longer lasting effect
	stun_duration = 3 SECONDS
	reveal_duration = 6 SECONDS

/datum/action/cooldown/spell/aoe/revenant/haunt_object/get_things_to_cast_on(atom/center)
	var/list/things = list()
	for(var/obj/item/nearby_item in range(aoe_radius, center))
		// Don't throw around anchored things or dense things
		// (Or things not on a turf but I am not sure if range can catch that)
		if(nearby_item.anchored || nearby_item.density || !isturf(nearby_item.loc))
			continue
		// Don't throw abstract things
		if(nearby_item.item_flags & ABSTRACT)
			continue
		// Don't throw things we can't see
		if(nearby_item.invisibility >= INVISIBILITY_REVENANT)
			continue
		// Don't throw things that are already throwing themself
		if(istype(nearby_item.ai_controller, /datum/ai_controller/haunted))
			continue

		things += nearby_item

	return things

/datum/action/cooldown/spell/aoe/revenant/haunt_object/cast_on_thing_in_aoe(obj/item/victim, mob/living/basic/revenant/caster)
	var/distance_from_caster = get_dist(get_turf(victim), get_turf(caster))
	var/chance_of_haunting = 150 * (1 / distance_from_caster)
	if(!prob(chance_of_haunting))
		return

	new /obj/effect/temp_visual/revenant(get_turf(victim))

	victim.AddComponent(/datum/component/haunted_item, \
		haunt_color = "#823abb", \
		haunt_duration = rand(1 MINUTES, 3 MINUTES), \
		aggro_radius = aoe_radius - 1, \
		spawn_message = span_revenwarning("[victim] 散发出惨紫色的光芒，开始漂浮旋转着升上空中！"), \
		despawn_message = span_revenwarning("[victim] 落回地面，重新静止下来。"), \
	)

//Vortex: Causes storage objects to dump their contents and nearby objects to get sucked into the center
/datum/action/cooldown/spell/aoe/revenant/vortex
	name = "漩涡"
	desc = "使附近的物品倒出内容物，并将它们吸向你所在的位置。"
	button_icon_state = "r_vortex"
	cooldown_time = 15 SECONDS
	aoe_radius = 1 // only dump contents close by
	unlock_amount = 45
	cast_amount = 30
	stun_duration = 2 SECONDS
	reveal_duration = 5 SECONDS

/datum/action/cooldown/spell/aoe/revenant/vortex/cast_on_thing_in_aoe(turf/target_turf, mob/living/basic/revenant/caster)
	for(var/obj/item/storage/cursed_storage in target_turf)
		if(cursed_storage.atom_storage?.locked)
			continue

		cursed_storage.emptyStorage()
		new /obj/effect/temp_visual/revenant(target_turf)

/datum/action/cooldown/spell/aoe/revenant/vortex/cast(atom/cast_on)
	movement_effect(cast_on)
	. = ..()

/datum/action/cooldown/spell/aoe/revenant/vortex/proc/movement_effect(atom/cast_on)
	goonchem_vortex(get_turf(cast_on), FALSE, 3)
	playsound(cast_on, 'sound/machines/woosh.ogg', 50, TRUE)

//Vortex: Throws nearby objects away with a large force
/datum/action/cooldown/spell/aoe/revenant/vortex/scatter
	name = "四散"
	desc = "使附近的物品倒出内容物，并将它们从你所在的位置抛飞出去。"
	button_icon_state = "r_scatter"
	cooldown_time = 25 SECONDS
	unlock_amount = 60
	cast_amount = 55
	stun_duration = 3 SECONDS
	reveal_duration = 5 SECONDS

/datum/action/cooldown/spell/aoe/revenant/vortex/scatter/movement_effect(atom/cast_on)
	goonchem_vortex(get_turf(cast_on), TRUE, 5) // pushing is much stronger than pulling
	playsound(cast_on, 'sound/machines/hiss.ogg', 50, TRUE)

#undef REVENANT_DEFILE_MIN_DAMAGE
#undef REVENANT_DEFILE_MAX_DAMAGE
