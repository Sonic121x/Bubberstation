#define CHOICE_SUPERMATTER "超物质晶体"
#define CHOICE_RBMK "RB-MK2反应堆"

/obj/machinery/power/supermatter_crystal/Initialize(mapload)

	. = ..()

	if(mapload && is_main_engine && isturf(src.loc))
		new/obj/machinery/engine_choice(src.loc)
		return INITIALIZE_HINT_QDEL

/obj/machinery/engine_choice

	name = "引擎选择信标"
	desc = "一堆乱七八糟的线缆和零件，不知怎么就能让你为本班次选择想要的引擎。\
	选择是永久性的，部署后无法撤销。可以用多功能工具将其销毁，但需要相当长的时间。"

	icon = 'modular_zubbers/icons/obj/structures/engine_choice.dmi'
	icon_state = "choice"

	anchored = TRUE
	density = FALSE

	move_resist = INFINITY //some really fucking strong duct tape

	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW

	use_power = NO_POWER_USE
	idle_power_usage = 0
	active_power_usage = 0
	static_power_usage = 0

	obj_flags = DANGEROUS_POSSESSION | IGNORE_DENSITY | NO_DEBRIS_AFTER_DECONSTRUCTION

	var/obj/item/radio/radio
	var/radio_key = /obj/item/encryptionkey/headset_eng
	var/channel_to_use = RADIO_CHANNEL_ENGINEERING
	var/deployment_time = 8 SECONDS

	var/deployment_timer_id

/obj/machinery/engine_choice/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()

/obj/machinery/engine_choice/Destroy()
	. = ..()
	QDEL_NULL(radio)

//Helper interaction for if we can interact with this (called before and after menu selection).
/obj/machinery/engine_choice/proc/can_use(mob/user)
	if(QDELETED(src) || QDESTROYING(src))
		return FALSE
	return user.can_perform_action(src, FORBID_TELEKINESIS_REACH)

/obj/machinery/engine_choice/interact(mob/user)
	display_options(user)

/obj/machinery/engine_choice/multitool_act(mob/living/user, obj/item/multitool/tool)

	if(!can_use(user))
		return TRUE

	if(deployment_timer_id)
		return TRUE

	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, FALSE)

	radio.talk_into(
		src,
		"[user]正在移除[src]。若此举未经授权，请联系安保部。",
		RADIO_CHANNEL_ENGINEERING
	)

	if(!do_after(user, 15 SECONDS, target=src))
		return TRUE

	if(!can_use(user))
		return TRUE

	if(deployment_timer_id)
		return TRUE

	var/turf/center_turf = get_turf(src)

	message_admins("[user]删除了[src][ADMIN_VERBOSEJMP(center_turf)]")
	log_game("[user]删除了[src] [AREACOORD(center_turf)]")
	user.investigate_log("删除了[src] [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)

	playsound(src, SFX_SPARKS, 50, FALSE)

	qdel(src)

	return TRUE

/obj/machinery/engine_choice/proc/display_options(mob/user)

	if(!can_use(user))
		return FALSE

	var/turf/center_turf = get_turf(src)

	if(deployment_timer_id) //Timer already exists to deploy.
		playsound(src, 'sound/machines/terminal_alert_short.ogg', 50, FALSE)
		radio.talk_into(
			src,
			"[user]取消了部署操作。",
			RADIO_CHANNEL_ENGINEERING
		)
		deltimer(deployment_timer_id)
		deployment_timer_id = null
		message_admins("[user]取消了本班次的引擎部署 [ADMIN_VERBOSEJMP(center_turf)]")
		log_game("[user]取消了本班次的引擎部署 [AREACOORD(center_turf)]")
		user.investigate_log("取消了本班次的引擎部署 [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)
		return FALSE

	playsound(src, 'sound/machines/terminal/terminal_prompt_confirm.ogg', 50, FALSE)

	radio.talk_into(
		src,
		"[user]正在选择本班次使用的引擎类型。",
		RADIO_CHANNEL_ENGINEERING
	)

	var/choice = tgui_input_list(user, "你想订购哪种引擎？", "选择引擎！", list(CHOICE_SUPERMATTER,CHOICE_RBMK))

	if(!choice || !can_use(user) || deployment_timer_id)
		return FALSE

	//Deployment time!

	message_admins("[user]选择了本班次使用的引擎类型：\"[choice]\" [ADMIN_VERBOSEJMP(center_turf)]")
	log_game("[user]选择了本班次使用的引擎类型：\"[choice]\" [AREACOORD(center_turf)]")
	user.investigate_log("选择了本班次使用的引擎类型：\"[choice]\" [AREACOORD(center_turf)]", INVESTIGATE_ENGINE)

	radio.talk_into(
		src,
		"[user]选择了\"[choice]\"供本班次使用！请远离部署区域！预计部署时间：[deployment_time/10]秒！",
		RADIO_CHANNEL_ENGINEERING
	)

	playsound(src, SFX_SPARKS, 50, FALSE)

	new /obj/effect/temp_visual/telegraphing/big(center_turf, deployment_time)

	deployment_timer_id = addtimer(CALLBACK(src, PROC_REF(do_deploy), center_turf, choice), deployment_time,  TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE |  TIMER_DELETE_ME)

/obj/machinery/engine_choice/proc/do_deploy(turf/center_turf,choice)

	qdel(src)

	playsound(center_turf,'sound/effects/magic/summonitems_generic.ogg',50,FALSE)

	switch(choice)
		if(CHOICE_SUPERMATTER)
			deploy_supermatter(center_turf)
		if(CHOICE_RBMK)
			deploy_rbmk(center_turf)

//RB-MK2
/obj/machinery/engine_choice/proc/deploy_rbmk(turf/center_turf)

	var/obj/machinery/rbmk2_sniffer/spawned_sniffer = new(center_turf)
	for(var/turf/side_turf in orange(1,center_turf))
		var/obj/machinery/power/rbmk2/preloaded/spawned_rbmk = new(side_turf)
		spawned_sniffer.link_reactor(null,spawned_rbmk)

	new /obj/item/paper/guides/jobs/engi/rbmk2(center_turf)
	new /obj/item/stack/cable_coil/thirty(center_turf)
	new /obj/item/paper/crumpled/rbmk2(center_turf)

//Supermatter
/obj/machinery/engine_choice/proc/deploy_supermatter(turf/center_turf)
	new /obj/machinery/power/supermatter_crystal/engine(center_turf)


#undef CHOICE_SUPERMATTER
#undef CHOICE_RBMK
