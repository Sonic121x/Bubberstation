//Maint modules for MODsuits

///Springlock Mechanism - allows your modsuit to activate faster, but reagents are very dangerous.
/obj/item/mod/module/springlock
	name = "MOD 弹簧锁模块"
	desc = "一种覆盖整个 MOD 单元体积、位于外壳之下的模块。\
		这种机械外骨骼会在使用者进入时被推开，从而帮助完成启动，\
		但它被现代套装弃用，因为弹簧锁在受潮时有“回弹”归位的倾向。\
		你知道一整套外骨骼钻进你身体里是什么感觉吗？"
	icon_state = "springlock"
	complexity = 3 // it is inside every part of your suit, so
	incompatible_modules = list(/obj/item/mod/module/springlock)
	var/set_off = FALSE
	var/static/list/gas_connections = list(
		COMSIG_TURF_EXPOSE = PROC_REF(on_wearer_exposed_gas),
	)
	var/step_change = 0.5

/obj/item/mod/module/springlock/on_install()
	. = ..()
	mod.activation_step_time *= step_change

/obj/item/mod/module/springlock/on_uninstall(deleting = FALSE)
	. = ..()
	mod.activation_step_time /= step_change

/obj/item/mod/module/springlock/on_part_activation()
	RegisterSignal(mod.wearer, COMSIG_ATOM_EXPOSE_REAGENTS, PROC_REF(on_wearer_exposed))
	AddComponent(/datum/component/connect_loc_behalf, mod.wearer, gas_connections)

/obj/item/mod/module/springlock/on_part_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_ATOM_EXPOSE_REAGENTS)
	qdel(GetComponent(/datum/component/connect_loc_behalf))

///Registers the signal COMSIG_MOD_ACTIVATE and calls the proc snap_shut() after a timer
/obj/item/mod/module/springlock/proc/snap_signal()
	if (set_off || mod.wearer.stat == DEAD)
		return

	var/found_part = FALSE
	for (var/obj/item/part as anything in mod.get_parts())
		// Don't snap if no parts besides the MOD itself are active
		if (part.loc != mod && mod.get_part_datum(part)?.sealed)
			found_part = TRUE
			break

	if (!found_part)
		return

	to_chat(mod.wearer, span_danger("[src] 发出一声不祥的咔嗒声……"))
	playsound(src, 'sound/items/modsuit/springlock.ogg', 75, TRUE)
	addtimer(CALLBACK(src, PROC_REF(snap_shut)), rand(3 SECONDS, 5 SECONDS))
	RegisterSignals(mod, list(COMSIG_MOD_ACTIVATE, COMSIG_MOD_PART_RETRACTING), PROC_REF(on_activate_spring_block))
	set_off = TRUE

///Calls snap_signal() when exposed to a reagent via VAPOR, PATCH or TOUCH
/obj/item/mod/module/springlock/proc/on_wearer_exposed(atom/source, list/reagents, datum/reagents/source_reagents, methods, show_message)
	SIGNAL_HANDLER

	if(!(methods & (VAPOR|PATCH|TOUCH)))
		return //remove non-touch reagent exposure
	snap_signal()

///Calls snap_signal() when exposed to water vapor
/obj/item/mod/module/springlock/proc/on_wearer_exposed_gas()
	SIGNAL_HANDLER

	var/turf/wearer_turf = get_turf(src)
	var/datum/gas_mixture/air = wearer_turf.return_air()
	if(air.moles[/datum/gas/water_vapor] < 5)
		return //return if there aren't more than 5 Moles of Water Vapor in the air
	snap_signal()

///Signal fired when wearer attempts to activate/deactivate suits
/obj/item/mod/module/springlock/proc/on_activate_spring_block(datum/source, user)
	SIGNAL_HANDLER
	balloon_alert(user, "弹簧锁没有反应……？")
	return MOD_CANCEL_ACTIVATE

///Delayed death proc of the suit after the wearer is exposed to reagents
/obj/item/mod/module/springlock/proc/snap_shut()
	UnregisterSignal(mod, list(COMSIG_MOD_ACTIVATE, COMSIG_MOD_PART_RETRACTING))
	if(!mod.wearer) //while there is a guaranteed user when on_wearer_exposed() fires, that isn't the same case for this proc
		return
	mod.wearer.visible_message("[src] 在 [mod.wearer] 的 [mod.name] 内突然扣合，把里面的使用者撕得血肉模糊！", span_userdanger("*啪嗒*"))
	mod.wearer.emote("scream")
	playsound(mod.wearer, 'sound/effects/snap.ogg', 75, TRUE, frequency = 0.5)
	playsound(mod.wearer, 'sound/effects/splat.ogg', 50, TRUE, frequency = 0.5)
	mod.wearer.client?.give_award(/datum/award/achievement/misc/springlock, mod.wearer)

	mod.wearer.get_bodypart(BODY_ZONE_CHEST)?.receive_damage(200, forced = TRUE, sharpness = SHARP_POINTY) // Chest always gets hit, from the back piece you're wearing
	for (var/obj/item/part as anything in mod.get_parts())
		if (part.loc == mod || !mod.get_part_datum(part)?.sealed)
			continue

		for (var/obj/item/bodypart/bodypart as anything in mod.wearer.get_damageable_bodyparts())
			if (part.body_parts_covered & bodypart.body_part) // can hit chest again
				bodypart.receive_damage(100, forced = TRUE, sharpness = SHARP_POINTY) //boggers, bogchamp, etc

	if(!HAS_TRAIT(mod.wearer, TRAIT_NODEATH))
		mod.wearer.investigate_log("被 [src] 杀死了。", INVESTIGATE_DEATHS)
		mod.wearer.death() //just in case, for some reason, they're still alive
	flash_color(mod.wearer, flash_color = "#FF0000", flash_time = 10 SECONDS)
	set_off = FALSE

///Rave Visor - Gives you a rainbow visor and plays jukebox music to you.
/obj/item/mod/module/visor/rave
	name = "MOD 狂欢面罩模块"
	desc = "一款超酷炫面罩（SCAV），专为模块化套装设计。"
	icon_state = "rave_visor"
	complexity = 1
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_MASK)
	/// The client colors applied to the wearer.
	var/datum/client_colour/rave_screen
	/// The current element in the rainbow_order list we are on.
	var/rave_number = 1
	/// A list of the colors the module can take.
	var/static/list/rainbow_order = list(
		list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,0.5,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,1,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(0,0,0,0, 0,1,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(0,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0),
	)
	/// What actually plays music to us
	var/datum/jukebox/single_mob/music_player

/obj/item/mod/module/visor/rave/Initialize(mapload)
	. = ..()
	music_player = new(src)
	music_player.sound_loops = TRUE

/obj/item/mod/module/visor/rave/Destroy()
	QDEL_NULL(music_player)
	QDEL_NULL(rave_screen)
	return ..()

/obj/item/mod/module/visor/rave/on_activation(mob/activator)
	rave_screen = mod.wearer.add_client_colour(/datum/client_colour/rave, REF(src))
	rave_screen.update_color(rainbow_order[rave_number])
	music_player.start_music(mod.wearer)

/obj/item/mod/module/visor/rave/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	QDEL_NULL(rave_screen)
	if(isnull(music_player.active_song_sound))
		return

	music_player.unlisten_all()
	if(deleting)
		return
	SEND_SOUND(mod.wearer, sound('sound/machines/terminal/terminal_off.ogg', volume = 50, channel = CHANNEL_JUKEBOX))

/obj/item/mod/module/visor/rave/generate_worn_overlay(obj/item/source, mutable_appearance/standing)
	. = ..()
	if (!.)
		return

	var/mutable_appearance/visor_overlay = mod.get_visor_overlay(standing)
	visor_overlay.appearance_flags |= RESET_COLOR
	if (!isnull(music_player.active_song_sound))
		visor_overlay.color = rainbow_order[rave_number]
	. += visor_overlay

/obj/item/mod/module/visor/rave/on_active_process(seconds_per_tick)
	rave_number++
	if(rave_number > length(rainbow_order))
		rave_number = 1
	update_clothing_slots()
	rave_screen.update_color(rainbow_order[rave_number])

/obj/item/mod/module/visor/rave/get_configuration()
	. = ..()
	if(length(music_player.songs))
		.["selection"] = add_ui_configuration("歌曲", "list", music_player.selection.song_name, music_player.songs)

/obj/item/mod/module/visor/rave/configure_edit(key, value)
	switch(key)
		if("selection")
			if(!isnull(music_player.active_song_sound))
				return

			var/datum/track/new_song = music_player.songs[value]
			if(QDELETED(src) || !istype(new_song, /datum/track))
				return

			music_player.selection = new_song

///Tanner - Tans you with spraytan.
/obj/item/mod/module/tanner
	name = "MOD 美黑模块"
	desc = "一种用于模块化套装的美黑模块。皮肤癌功能从未得到证实，\
		不过谣言这种东西谁说得准呢……"
	icon_state = "tanning"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/tanner)
	cooldown_time = 30 SECONDS
	required_slots = list(ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING)

/obj/item/mod/module/tanner/on_use(mob/activator)
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, TRUE)
	var/datum/reagents/holder = new()
	holder.add_reagent(/datum/reagent/spraytan, 10)
	holder.trans_to(mod.wearer, 10, methods = VAPOR)
	if(prob(5))
		SSradiation.irradiate(mod.wearer)
	drain_power(use_energy_cost)

///Balloon Blower - Blows a balloon.
/obj/item/mod/module/balloon
	name = "MOD 吹气球模块"
	desc = "一种多年前由几位巧手默剧演员发明的古怪模块。它能吹气球。"
	icon_state = "bloon"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(/obj/item/mod/module/balloon)
	cooldown_time = 15 SECONDS
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_MASK)
	var/balloon_path = /obj/item/toy/balloon
	var/blowing_time = 10 SECONDS
	var/oxygen_damage = 20

/obj/item/mod/module/balloon/on_use(mob/activator)
	if(!do_after(mod.wearer, blowing_time, target = mod))
		return FALSE
	mod.wearer.adjust_oxy_loss(oxygen_damage)
	playsound(src, 'sound/items/modsuit/inflate_bloon.ogg', 50, TRUE)
	var/obj/item/balloon = new balloon_path(get_turf(src))
	mod.wearer.put_in_hands(balloon)
	drain_power(use_energy_cost)

///Paper Dispenser - Dispenses (sometimes burning) paper sheets.
/obj/item/mod/module/paper_dispenser
	name = "MOD 纸张配发模块"
	desc = "一种由火炬湾的官僚们设计的简单模块。\
		它会把‘温暖、洁净、挺括的纸张’配发到附近的桌子上。通常情况下如此。"
	icon_state = "paper_maker"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 0.5
	incompatible_modules = list(/obj/item/mod/module/paper_dispenser)
	cooldown_time = 5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES|ITEM_SLOT_NECK)
	/// The total number of sheets created by this MOD. The more sheets, them more likely they set on fire.
	var/num_sheets_dispensed = 0

/obj/item/mod/module/paper_dispenser/on_use(mob/activator)
	if(!do_after(mod.wearer, 1 SECONDS, target = mod))
		return FALSE

	var/obj/item/paper/crisp_paper = new(get_turf(src))
	crisp_paper.desc = "摸起来挺括又温暖。一定是新出的。"

	var/obj/structure/table/nearby_table = locate() in range(1, mod.wearer)
	playsound(get_turf(src), 'sound/machines/click.ogg', 50, TRUE)
	balloon_alert(mod.wearer, "已配发纸张[nearby_table ? "到桌上":""]")

	mod.wearer.put_in_hands(crisp_paper)
	if(nearby_table)
		mod.wearer.transferItemToLoc(crisp_paper, nearby_table.drop_location(), silent = FALSE)

	// Up to a 30% chance to set the sheet on fire, +2% per sheet made
	if(prob(min(num_sheets_dispensed * 2, 30)))
		if(crisp_paper in mod.wearer.held_items)
			mod.wearer.dropItemToGround(crisp_paper, force = TRUE)
		crisp_paper.balloon_alert(mod.wearer, UNLINT("请装入纸张！"))
		crisp_paper.visible_message(span_warning("[crisp_paper] 猛然燃起火焰，它太脆了！"))
		crisp_paper.fire_act(1000, 100)

	drain_power(use_energy_cost)
	num_sheets_dispensed++


///Stamper - Extends a stamp that can switch between accept/deny modes.
/obj/item/mod/module/stamp
	name = "MOD 印章模块"
	desc = "一种安装在套装手腕处的模块，可作为一台高功率印章使用，\
		能在批准、拒绝和作废模式之间切换。"
	icon_state = "stamp"
	module_type = MODULE_ACTIVE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/stamp/mod
	incompatible_modules = list(/obj/item/mod/module/stamp)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES|ITEM_SLOT_NECK)

/obj/item/stamp/mod
	name = "MOD 电子印章"
	desc = "一台高功率印章，使用时能在批准、拒绝和作废模式之间切换。"
	icon_state = "stamp-ok"

/obj/item/stamp/mod/attack_self(mob/user, modifiers)

	var/choices = list()
	var/icon_states = list()
	icon_states["批准"] = "stamp-ok"
	icon_states["拒绝"] = "stamp-deny"
	icon_states["作废"] = "stamp-void"
	for(var/possible_icon_state in icon_states)
		if(!(src.icon_state == icon_states[possible_icon_state]))
			choices[possible_icon_state] = image(src.icon, icon_states[possible_icon_state])
	var/chosen_icon_state = show_radial_menu(user, user, choices, custom_check = CALLBACK(src, PROC_REF(check_menu), src, user), require_near = TRUE)
	if(chosen_icon_state)
		playsound(src, 'sound/machines/click.ogg', 30, TRUE, -3)
		src.icon_state = icon_states[chosen_icon_state]

/obj/item/stamp/mod/proc/check_menu(datum/target, mob/user)
	if(user.incapacitated || !user.is_holding(target))
		return FALSE
	return TRUE

///Atrocinator - Flips your gravity.
/obj/item/mod/module/atrocinator
	name = "MOD 阿特罗西纳模块"
	desc = "一颗神秘的球体，装入 MOD 套装后会产生神秘的效果。"
	icon_state = "atrocinator"
	module_type = MODULE_TOGGLE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/atrocinator, /obj/item/mod/module/magboot, /obj/item/mod/module/anomaly_locked/antigrav)
	overlay_state_inactive = "module_atrocinator"
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	/// How many steps the user has taken since turning the suit on, used for footsteps.
	var/step_count = 0
	/// If you use the module on a planetary turf, you fly up. To the sky.
	var/you_fucked_up = FALSE

/obj/item/mod/module/atrocinator/on_activation(mob/activator)
	// Auto-unbuckle anyone being carried to avoid lag issues
	if(length(mod.wearer.buckled_mobs))
		mod.wearer.visible_message("随着 [mod.wearer] 翻转，[mod.wearer.buckled_mobs[1]] 从其背上飞了出去！")
		mod.wearer.unbuckle_all_mobs()

	playsound(src, 'sound/effects/curse/curseattack.ogg', 50)
	mod.wearer.AddElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY)
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(check_upstairs))
	RegisterSignal(mod.wearer, COMSIG_MOB_SAY, PROC_REF(on_talk))
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_PREBUCKLE, PROC_REF(on_someone_buckled))
	ADD_TRAIT(mod.wearer, TRAIT_SILENT_FOOTSTEPS, REF(src))
	ADD_TRAIT(mod.wearer, TRAIT_PASSTABLE, REF(src))
	check_upstairs() //todo at some point flip your screen around

/obj/item/mod/module/atrocinator/deactivate(mob/activator, display_message = TRUE, deleting = FALSE)
	if(you_fucked_up && !deleting)
		to_chat(activator, span_danger("太迟了。"))
		return FALSE
	return ..()

/obj/item/mod/module/atrocinator/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	if(!deleting)
		playsound(src, 'sound/effects/curse/curseattack.ogg', 50)
	qdel(mod.wearer.RemoveElement(/datum/element/forced_gravity, NEGATIVE_GRAVITY))
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(mod.wearer, COMSIG_MOB_SAY)
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_PREBUCKLE)
	step_count = 0
	REMOVE_TRAIT(mod.wearer, TRAIT_SILENT_FOOTSTEPS, REF(src))
	REMOVE_TRAIT(mod.wearer, TRAIT_PASSTABLE, REF(src))
	var/turf/open/openspace/current_turf = get_turf(mod.wearer)
	if(istype(current_turf))
		current_turf.zFall(mod.wearer, falling_from_move = TRUE)

/obj/item/mod/module/atrocinator/proc/check_upstairs(atom/movable/source, atom/oldloc, direction, forced, list/old_locs, momentum_change)
	SIGNAL_HANDLER

	if(you_fucked_up || mod.wearer.has_gravity() > NEGATIVE_GRAVITY)
		return

	// Prevent infinite loops when being fireman carried - Stack trace if it does
	if(mod.wearer.buckled)
		stack_trace("Atrocinator user is buckled despite protections - this shouldn't happen!")
		return

	// Prevent infinite loops when carrying someone - Stack trace if it does
	if(length(mod.wearer.buckled_mobs))
		stack_trace("Atrocinator user is carrying someone despite protections - this shouldn't happen!")
		return

	var/turf/open/current_turf = get_turf(mod.wearer)
	var/turf/open/openspace/turf_above = get_step_multiz(mod.wearer, UP)
	if(current_turf && istype(turf_above))
		current_turf.zFall(mod.wearer)
		return

	else if(!turf_above && istype(current_turf) && current_turf.planetary_atmos) //nothing holding you down
		INVOKE_ASYNC(src, PROC_REF(fly_away))
		return

	if (forced || (SSlag_switch.measures[DISABLE_FOOTSTEPS] && !(HAS_TRAIT(source, TRAIT_BYPASS_MEASURES))))
		return

	if(!(step_count % 2))
		playsound(current_turf, 'sound/items/modsuit/atrocinator_step.ogg', 50)
	step_count++

#define FLY_TIME (5 SECONDS)

/obj/item/mod/module/atrocinator/proc/fly_away()
	you_fucked_up = TRUE
	playsound(src, 'sound/effects/whirthunk.ogg', 75)
	to_chat(mod.wearer, span_userdanger("这真是太蠢了。"))
	investigate_log("因 [src] 而飞入太空。", INVESTIGATE_DEATHS)
	mod.wearer.Stun(FLY_TIME, ignore_canstun = TRUE)
	animate(mod.wearer, FLY_TIME, pixel_z = 256, alpha = 0)
	QDEL_IN(mod.wearer, FLY_TIME)

#undef FLY_TIME

/obj/item/mod/module/atrocinator/proc/on_talk(datum/source, list/speech_args)
	SIGNAL_HANDLER
	speech_args[SPEECH_SPANS] |= "upside_down"

/// Prevent someone from being buckled to the wearer while atrocinator is active
/obj/item/mod/module/atrocinator/proc/on_someone_buckled(datum/source, mob/living/buckled_mob, mob/living/buckler)
	SIGNAL_HANDLER
	balloon_alert(buckler, "[buckler == mod.wearer ? "你" : "对方"]正倒挂着！")
	return COMPONENT_BLOCK_BUCKLE



/obj/item/mod/module/recycler/donk/safe
	name = "MOD 泡沫弹回收模块"
	desc = "一种 MOD 模块，能把发射过的泡沫弹收集起来重新包装成半尺寸的弹药箱。\
		对附近的地面或储物容器使用可卸载已存储的弹药箱。"
	icon_state = "donk_safe_recycler"
	overlay_state_inactive = "module_donk_safe_recycler"
	overlay_state_active = "module_donk_safe_recycler"
	complexity = 1
	efficiency = 1
	allowed_item_types = list(/obj/item/ammo_casing/foam_dart)
	ammobox_type = /obj/item/ammo_box/foambox/mini
	required_amount = SMALL_MATERIAL_AMOUNT*2.5
