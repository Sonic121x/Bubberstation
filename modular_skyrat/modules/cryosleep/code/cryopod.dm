// #define AHELP_FIRST_MESSAGE "Please adminhelp before leaving the round, even if there are no administrators online!"
// Uncomment the check comments if we decide to bring back a pointless system to spam ahelps with
/*
 * Cryogenic refrigeration unit. Basically a despawner.
 * Stealing a lot of concepts/code from sleepers due to massive laziness.
 * The despawn tick will only fire if it's been more than time_till_despawned ticks
 * since time_entered, which is world.time when the occupant moves in.
 * ~ Zuhayr
 */
GLOBAL_LIST_EMPTY(cryopod_computers)

GLOBAL_LIST_EMPTY(ghost_records)

/// A list of all cryopods that aren't quiet, to be used by the "Send to Cryogenic Storage" VV action.
GLOBAL_LIST_EMPTY(valid_cryopods)

//Main cryopod console.

/obj/machinery/computer/cryopod
	name = "低温休眠监控控制台"
	desc = "船员与低温休眠监控系统之间的交互界面。"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cellconsole_1"
	icon_keyboard = null
	icon_screen = null
	use_power = FALSE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	interaction_flags_machine = INTERACT_MACHINE_OFFLINE
	req_one_access = list(ACCESS_COMMAND, ACCESS_ARMORY) // Heads of staff or the warden can go here to claim recover items from their department that people went were cryodormed with.
	verb_say = "冷冷地说道"
	verb_ask = "询问道"
	verb_exclaim = "警报道"

	/// Used for logging people entering cryosleep and important items they are carrying.
	var/list/frozen_crew = list()
	/// The items currently stored in the cryopod control panel.
	var/list/frozen_item = list()

	/// This is what the announcement system uses to make announcements. Make sure to set a radio that has the channel you want to broadcast on.
	var/obj/item/radio/headset/radio = /obj/item/radio/headset/silicon/pai
	/// The channel to be broadcast on, valid values are the values of any of the "RADIO_CHANNEL_" defines.
	var/announcement_channel = null // RADIO_CHANNEL_COMMON doesn't work here.

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/computer/cryopod, 32)

/obj/machinery/computer/cryopod/Initialize(mapload)
	. = ..()
	GLOB.cryopod_computers += src
	radio = new radio(src)

/obj/machinery/computer/cryopod/Destroy()
	GLOB.cryopod_computers -= src
	QDEL_NULL(radio)
	return ..()

/obj/machinery/computer/cryopod/update_icon_state()
	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "cellconsole"
		return ..()
	icon_state = "cellconsole_1"
	return ..()

/obj/machinery/computer/cryopod/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return

	add_fingerprint(user)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CryopodConsole", name)
		ui.open()

/obj/machinery/computer/cryopod/ui_data(mob/user)
	var/list/data = list()
	data["frozen_crew"] = frozen_crew

	/// The list of references to the stored items.
	var/list/item_ref_list = list()
	/// The associative list of the reference to an item and its name.
	var/list/item_ref_name = list()

	for(var/obj/item/item in frozen_item)
		var/ref = REF(item)
		item_ref_list += ref
		item_ref_name[ref] = item.name

	data["item_ref_list"] = item_ref_list
	data["item_ref_name"] = item_ref_name

	// Check Access for item dropping.
	var/item_retrieval_allowed = allowed(user)
	data["item_retrieval_allowed"] = item_retrieval_allowed

	var/obj/item/card/id/id_card
	if(isliving(user))
		var/mob/living/person = user
		id_card = person.get_idcard()
	if(id_card?.registered_name)
		data["account_name"] = id_card.registered_name

	return data

/obj/machinery/computer/cryopod/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("item_get")
			// This is using references, kinda clever, not gonna lie. Good work Zephyr
			var/item_get = params["item_get"]
			var/obj/item/item = locate(item_get)
			if(item in frozen_item)
				item.forceMove(drop_location())
				frozen_item.Remove(item_get, item)
				visible_message("[src] 弹出了 \the [item]。")
				message_admins("[item] 已从低温休眠库中被取出，位置：[ADMIN_COORDJMP(src)]")
			else
				CRASH("Invalid REF# for ui_act. Not inside internal list!")
			return TRUE

		else
			CRASH("Illegal action for ui_act: '[action]'")

/obj/machinery/computer/cryopod/proc/announce(message_type, mob/living/user, rank)
	switch(message_type)
		if("CRYO_JOIN")
			radio.talk_into(src, "[user][rank ? ", [rank]" : ""] 已从低温休眠中苏醒。", announcement_channel) //Leave as user here, if not it passes the variable incorrectly and causes a runtime
		if("CRYO_LEAVE")
			radio.talk_into(src, "[user.real_name][rank ? ", [rank]" : ""] 已被移入低温休眠。", announcement_channel)
			var/is_command = user?.mind?.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND
			var/last_of_command = length(SSjob.get_all_heads())
			if(is_command && last_of_command <= 1)
				minor_announce(message = "空间站最后一名指挥人员已进入低温休眠。 \
				请确保空间站的关键运行物资已妥善保管。")
// Cryopods themselves.
/obj/machinery/cryopod
	name = "低温冷冻舱"
	desc = "这种休眠舱适合半机械人与类人生物使用，是受太空睡眠障碍困扰的人员休息的安全场所。"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"
	base_icon_state = "cryopod"
	use_power = FALSE
	density = TRUE
	anchored = TRUE
	state_open = TRUE

	var/open_icon_state = "cryopod-open"
	/// Whether the cryopod respects the minimum time someone has to be disconnected before they can be put into cryo by another player
	var/allow_timer_override = FALSE
	/// Minimum time for someone to be SSD before another player can cryo them.
	var/ssd_time = 30 MINUTES //Replace with "cryo_min_ssd_time" CONFIG

	/// Time until despawn when a mob enters a cryopod. You cannot other people in pods unless they're catatonic.
	var/time_till_despawn = 30 SECONDS
	/// Cooldown for when it's now safe to try an despawn the player.
	COOLDOWN_DECLARE(despawn_world_time)

	///Weakref to our controller
	var/datum/weakref/control_computer_weakref
	COOLDOWN_DECLARE(last_no_computer_message)
	/// if false, plays announcement on cryo
	var/quiet = FALSE

	/// Has the occupant been tucked in?
	var/tucked = FALSE

	/// What was the ckey of the client that entered the cryopod?
	var/stored_ckey = null
	/// The name of the mob that entered the cryopod.
	var/stored_name = null
	/// The rank (job title) of the mob that entered the cryopod, if it was a human. "N/A" by default.
	var/stored_rank = "N/A"


/obj/machinery/cryopod/quiet
	quiet = TRUE

/obj/machinery/cryopod/Initialize(mapload)
	..()
	if(!quiet)
		GLOB.valid_cryopods += src
	return INITIALIZE_HINT_LATELOAD //Gotta populate the cryopod computer GLOB first

/obj/machinery/cryopod/post_machine_initialize()
	. = ..()
	update_icon()
	find_control_computer()

// This is not a good situation
/obj/machinery/cryopod/Destroy()
	GLOB.valid_cryopods -= src
	control_computer_weakref = null
	return ..()

/obj/machinery/cryopod/proc/find_control_computer(urgent = FALSE)
	for(var/cryo_console in GLOB.cryopod_computers)
		var/obj/machinery/computer/cryopod/console = cryo_console
		if(get_area(console) == get_area(src))
			control_computer_weakref = WEAKREF(console)
			break

	// Don't send messages unless we *need* the computer, and less than five minutes have passed since last time we messaged
	if(!control_computer_weakref && urgent && COOLDOWN_FINISHED(src, last_no_computer_message))
		COOLDOWN_START(src, last_no_computer_message, 5 MINUTES)
		log_admin("位于 [get_area(src)] 的低温休眠舱无法找到控制计算机！")
		message_admins("位于 [get_area(src)] 的低温休眠舱无法找到控制计算机！")
		last_no_computer_message = world.time

	return control_computer_weakref != null

/obj/machinery/cryopod/close_machine(atom/movable/target, density_to_set = TRUE)
	if(!control_computer_weakref)
		find_control_computer(TRUE)
	if((isnull(target) || isliving(target)) && state_open && !panel_open)
		state_open = FALSE
		set_density(density_to_set)

		if(!target)
			for(var/atom in loc)
				if (!(can_be_occupant(atom)))
					continue
				var/atom/movable/current_atom = atom
				if(current_atom.has_buckled_mobs())
					continue
				if(isliving(current_atom))
					var/mob/living/current_mob = atom
					if(current_mob.buckled || current_mob.mob_size >= MOB_SIZE_LARGE)
						continue
				target = atom

	var/mob/living/mobtarget = target
	if(target && !target.has_buckled_mobs() && (!isliving(target) || !mobtarget.buckled))
		set_occupant(target)
		target.forceMove(src)
	update_appearance()

	var/mob/living/mob_occupant = occupant
	if(mob_occupant && mob_occupant.stat != DEAD)
		to_chat(occupant, span_notice("<b>你感到凉爽的空气环绕四周。随着感官向内收拢，身体渐渐麻木。</b>"))
		stored_ckey = mob_occupant.ckey
		stored_name = mob_occupant.name

		if(mob_occupant.mind)
			stored_rank = mob_occupant.mind.assigned_role.title
			if(isnull(stored_ckey))
				stored_ckey = mob_occupant.mind.key // if mob does not have a ckey and was placed in cryo by someone else, we can get the key this way

	var/mob/living/carbon/human/human_occupant = occupant
	if(istype(human_occupant) && human_occupant.mind)
		human_occupant.save_individual_persistence(stored_ckey)

	COOLDOWN_START(src, despawn_world_time, time_till_despawn)

/obj/machinery/cryopod/open_machine(drop = TRUE, density_to_set = FALSE)
	..()
	set_density(TRUE)
	name = initial(name)
	tucked = FALSE
	stored_ckey = null
	stored_name = null
	stored_rank = "N/A"

/obj/machinery/cryopod/container_resist_act(mob/living/user)
	visible_message(span_notice("[occupant] 从 [src] 中钻了出来！"),
		span_notice("你从 [src] 中爬了出来！"))
	open_machine()

/obj/machinery/cryopod/relaymove(mob/user)
	container_resist_act(user)

/obj/machinery/cryopod/process()
	if(!occupant)
		return

	var/mob/living/mob_occupant = occupant
	if(mob_occupant.stat == DEAD)
		open_machine()

	if(!mob_occupant.client && COOLDOWN_FINISHED(src, despawn_world_time))
		if(!control_computer_weakref)
			find_control_computer(urgent = TRUE)

		despawn_occupant()

/obj/machinery/cryopod/proc/handle_objectives()
	var/mob/living/mob_occupant = occupant
	// Update any existing objectives involving this mob.
	for(var/datum/objective/objective in GLOB.objectives)
		// We don't want revs to get objectives that aren't for heads of staff. Letting
		// them win or lose based on cryo is silly so we remove the objective.
		if(istype(objective,/datum/objective/mutiny) && objective.target == mob_occupant.mind)
			objective.team.objectives -= objective
			qdel(objective)
			for(var/datum/mind/mind in objective.team.members)
				to_chat(mind.current, "<BR>[span_userdanger("你的目标已不在触及范围内。目标已移除！")]")
				mind.announce_objectives()
		else if(istype(objective.target) && objective.target == mob_occupant.mind)
			if(!istype(objective, /datum/objective/contract))
				return
			var/datum/opposing_force/affected_contractor = objective.owner.opposing_force
			var/datum/contractor_hub/affected_contractor_hub = affected_contractor.contractor_hub
			for(var/datum/syndicate_contract/affected_contract as anything in affected_contractor_hub.assigned_contracts)
				if(!(affected_contract.contract == objective))
					continue
				var/contract_id = affected_contract.id
				affected_contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED
				if (affected_contractor_hub.current_contract == objective)
					affected_contractor_hub.current_contract = null
				to_chat(objective.owner.current, "<BR>[span_userdanger("合同目标已不在触及范围内。合同已中止。")]")
				break
		else if(istype(objective.target) && objective.target == mob_occupant.mind)
			var/old_target = objective.target
			objective.target = null
			if(!objective)
				return
			objective.find_target()
			if(!objective.target && objective.owner)
				to_chat(objective.owner.current, "<BR>[span_userdanger("你的目标已不在触及范围内。目标已移除！")]")
				for(var/datum/antagonist/antag in objective.owner.antag_datums)
					antag.objectives -= objective
			if (!objective.team)
				objective.update_explanation_text()
				objective.owner.announce_objectives()
				to_chat(objective.owner.current, "<BR>[span_userdanger("你隐约感觉到目标已不在触及范围内。是时候执行 [pick("A","B","C","D","X","Y","Z")] 计划了。目标已更新！")]")
			else
				var/list/objectivestoupdate
				for(var/datum/mind/objective_owner in objective.get_owners())
					to_chat(objective_owner.current, "<BR>[span_userdanger("你隐约感觉到目标已不在触及范围内。是时候执行 [pick("A","B","C","D","X","Y","Z")] 计划了。目标已更新！")]")
					for(var/datum/objective/update_target_objective in objective_owner.get_all_objectives())
						LAZYADD(objectivestoupdate, update_target_objective)
				objectivestoupdate += objective.team.objectives
				for(var/datum/objective/update_objective in objectivestoupdate)
					if(update_objective.target != old_target || !istype(update_objective,objective.type))
						continue
					update_objective.target = objective.target
					update_objective.update_explanation_text()
					to_chat(objective.owner.current, "<BR>[span_userdanger("你隐约感觉到目标已不在触及范围内。是时候执行 [pick("A","B","C","D","X","Y","Z")] 计划了。目标已更新！")]")
					update_objective.owner.announce_objectives()
			qdel(objective)

/**
 * Attempt to store a given item in either the control computer or on the ground.
 * * holder - mob holding the item being stored
 * * target_item - the item to store
 * * control_computer - the cryo console connected to this pod, can be null
 */
/obj/machinery/cryopod/proc/try_store_item(mob/living/holder, obj/item/target_item, obj/machinery/computer/cryopod/control_computer)
	if(!istype(target_item) || HAS_TRAIT(target_item, TRAIT_NODROP))
		return FALSE
	if (issilicon(holder) && istype(target_item, /obj/item/mmi))
		return FALSE
	if(istype(target_item, /obj/item/implant/storage)) // store the contents of the storage implant
		for(var/obj/item/nested_item as anything in target_item)
			try_store_item(holder, nested_item, control_computer)
		return FALSE
	if(target_item.item_flags & (ABSTRACT|DROPDEL))
		return FALSE

	if(control_computer)
		if(istype(target_item, /obj/item/modular_computer))
			var/obj/item/modular_computer/computer = target_item
			for(var/datum/computer_file/program/messenger/message_app in computer.stored_files)
				message_app.invisible = TRUE
		holder.transferItemToLoc(target_item, control_computer, force = TRUE, silent = TRUE)
		target_item.dropped(holder)
		control_computer.frozen_item += target_item
	else
		holder.transferItemToLoc(target_item, drop_location(), force = TRUE, silent = TRUE)
	return TRUE

/// This function can not be undone; do not call this unless you are sure.
/// Handles despawning the player.
/obj/machinery/cryopod/proc/despawn_occupant()
	var/mob/living/mob_occupant = occupant

	SSjob.FreeRole(stored_rank)

	// Handle holy successor removal
	var/list/holy_successors = list_holy_successors()
	if(mob_occupant in holy_successors) // if this mob was a holy successor then remove them from the pool
		GLOB.holy_successors -= WEAKREF(mob_occupant)

	if(mob_occupant.mind)
		// Handle tater cleanup.
		if(LAZYLEN(mob_occupant.mind.objectives))
			mob_occupant.mind.objectives.Cut()
			LAZYNULL(mob_occupant.mind.special_roles)
		// Handle freeing the high priest role for the next chaplain in line
		if(mob_occupant.mind.holy_role == HOLY_ROLE_HIGHPRIEST)
			reset_religion()
	else
		// handle the case of the high priest no longer having a mind
		var/datum/weakref/current_highpriest = GLOB.current_highpriest
		if(current_highpriest?.resolve() == mob_occupant)
			reset_religion()

	// Delete them from datacore and ghost records.
	var/announce_rank = null

	for(var/list/record in GLOB.ghost_records)
		if(record["name"] == stored_name)
			announce_rank = record["rank"]
			GLOB.ghost_records.Remove(list(record))
			break

	if(!announce_rank) // No need to loop over all of those if we already found it beforehand.
		for(var/datum/record/crew/possible_target_record as anything in GLOB.manifest.general)
			if(possible_target_record.name == stored_name && (stored_rank == "N/A" || possible_target_record.trim == stored_rank))
				announce_rank = possible_target_record.rank
				qdel(possible_target_record)
				break

	var/obj/machinery/computer/cryopod/control_computer = control_computer_weakref?.resolve()
	if(!control_computer)
		control_computer_weakref = null
	else
		control_computer.frozen_crew += list(list("name" = stored_name, "job" = stored_rank))

	// Make an announcement and log the person entering storage. If set to quiet, does not make an announcement.
	if(!quiet)
		control_computer.announce("CRYO_LEAVE", mob_occupant, announce_rank)

	visible_message(span_notice("[src] 发出嗡鸣与嘶响，将 [mob_occupant.real_name] 送入了存储舱。"))

	var/list/nuke_disks = mob_occupant.get_all_contents_type(/obj/item/disk/nuclear) // No
	for(var/obj/item/disk/nuclear/the_disk as anything in nuke_disks)
		var/turf/launch_target = get_edge_target_turf(src, pick(GLOB.alldirs))
		mob_occupant.transferItemToLoc(the_disk, drop_location(), force = TRUE, silent = TRUE)
		the_disk.throw_at(launch_target, 8, 14)
		visible_message(span_warning("[src] 猛地弹出了 [the_disk]！"))

	// get_equipped_items() prevents moving bodyparts, since those are in mob contents now
	for(var/obj/item/item_content in mob_occupant.get_equipped_items(INCLUDE_POCKETS | INCLUDE_HELD | INCLUDE_ACCESSORIES))
		try_store_item(mob_occupant, item_content, control_computer)

	if(iscarbon(mob_occupant))
		var/mob/living/carbon/carbon_occupant = mob_occupant
		for(var/obj/item/organ/surplus_organ in carbon_occupant.organs)
			if(istype(surplus_organ, /obj/item/organ/heart/cybernetic/surplus) || istype(surplus_organ, /obj/item/organ/lungs/cybernetic/surplus) || istype(surplus_organ, /obj/item/organ/liver/cybernetic/surplus) || istype(surplus_organ, /obj/item/organ/stomach/cybernetic/surplus) || istype(surplus_organ, /obj/item/organ/brain/cybernetic/surplus))
				qdel(surplus_organ)

	GLOB.joined_player_list -= stored_ckey

	handle_objectives()
	mob_occupant.ghostize(FALSE)
	QDEL_NULL(occupant)
	open_machine()
	name = initial(name)

/obj/machinery/cryopod/mouse_drop_receive(mob/living/target, mob/living/user, params)
	if(!istype(target) || !can_interact(user) || !target.Adjacent(user) || !ismob(target) || isanimal(target) || !istype(user.loc, /turf) || target.buckled)
		return

	if(occupant)
		to_chat(user, span_notice("[src] 已被占用！"))
		return

	if(target.stat == DEAD)
		to_chat(user, span_notice("死者不能被放入低温休眠舱。"))
		return

// Allows admins to enable players to override SSD Time check.
	if(allow_timer_override)
		if(tgui_alert(user, "你要把 [target] 放进 [src] 吗？", "放入低温休眠舱？", list("Yes", "No")) != "No")
			to_chat(user, span_danger("你把 [target] 放进了 [src]，对方已在低温休眠舱中。"))
			log_admin("[key_name(user)] 将 [key_name(target)] 放入了跳过计时检查的休眠舱。")
			message_admins("[key_name(user)] 将 [key_name(target)] 放入了跳过计时检查的休眠舱。[ADMIN_JMP(src)]")

			add_fingerprint(target)

			close_machine(target)
			name = "[name] ([target.name])"

// Allows players to cryo others. Checks if they have been AFK for 30 minutes.
	if(target.key && user != target)
		if (target.get_organ_by_type(/obj/item/organ/brain) ) //Target the Brain
			if(!target.mind || target.ssd_indicator ) // Is the character empty / AI Controlled
				if(target.lastclienttime + ssd_time >= world.time)
					to_chat(user, span_notice("你还需要等待 [round(((ssd_time - (world.time - target.lastclienttime)) / (1 MINUTES)), 1)] 分钟才能把 [target] 放进 [src]。"))
					log_admin("[key_name(user)] 试图将 [key_name(target)] 放入休眠舱，但对方只断线了 [round(((world.time - target.lastclienttime) / (1 MINUTES)), 1)] 分钟。")
					message_admins("[key_name(user)] 试图将 [key_name(target)] 放入休眠舱。[ADMIN_JMP(src)]")
					return
				else if(tgui_alert(user, "你要把 [target] 放进 [src] 吗？", "放入低温休眠舱？", list("Yes", "No")) == "Yes")
					// if(target.mind.assigned_role.req_admin_notify)
					// tgui_alert(user, "They are an important role! [AHELP_FIRST_MESSAGE]")
					to_chat(user, span_danger("你把 [target] 放进了 [src]，对方已在低温休眠舱中。"))
					log_admin("[key_name(user)] 将 [key_name(target)] 放入了休眠舱。")
					message_admins("[key_name(user)] 将 [key_name(target)] 放入了休眠舱。[ADMIN_JMP(src)]")

					add_fingerprint(target)

					close_machine(target)
					name = "[name] ([target.name])"

		else if(iscyborg(target))
			to_chat(user, span_danger("你不能把 [target] 放进 [src]，对方仍在线。"))
		else
			to_chat(user, span_danger("你不能把 [target] 放进 [src]，对方仍有意识。"))
		return

	if(target == user && (tgui_alert(target, "你要进入低温休眠吗？", "进入低温休眠舱？", list("Yes", "No")) != "Yes"))
		return

	if(target == user)
		if(target.mind.assigned_role.req_admin_notify)
			tgui_alert(target, "你担任的是重要职位！离开前请务必归还所有与岗位相关的装备。")
		/*
		var/datum/antagonist/antag = target.mind.has_antag_datum(/datum/antagonist)
		if(antag)
			tgui_alert(target, "You're \a [antag.name]! [AHELP_FIRST_MESSAGE]")
	*/

	if(LAZYLEN(target.buckled_mobs) > 0)
		if(target == user)
			to_chat(user, span_danger("有人系在你身上时，你无法钻进低温休眠舱。"))
		else
			to_chat(user, span_danger("有人系在 [target] 身上时，你无法把对方塞进低温休眠舱。"))
		return

	if(!istype(target) || !can_interact(user) || !target.Adjacent(user) || !ismob(target) || isanimal(target) || !istype(user.loc, /turf) || target.buckled)
		return
		// rerun the checks in case of shenanigans

	if(occupant)
		to_chat(user, span_notice("[src] 已被占用！"))
		return

	if(target == user)
		visible_message(span_infoplain("[user] 开始爬进低温休眠舱。"))
	else
		visible_message(span_infoplain("[user] 开始把 [target] 放进低温休眠舱。"))

	to_chat(target, span_warning("<b>如果你现在变成幽灵、登出或关闭客户端，你的角色很快就会从本回合中被永久移除。</b>"))

	log_admin("[key_name(target)] 进入了休眠舱。")
	message_admins("[key_name_admin(target)] 进入了休眠舱。[ADMIN_JMP(src)]")
	add_fingerprint(target)

	close_machine(target)
	name = "[name] ([target.name])"

// Attacks/effects.
/obj/machinery/cryopod/blob_act()
	return // Sorta gamey, but we don't really want these to be destroyed.

/obj/machinery/cryopod/attackby(obj/item/weapon, mob/living/carbon/human/user, params)
	. = ..()
	if(istype(weapon, /obj/item/bedsheet))
		if(!occupant || !istype(occupant, /mob/living))
			return
		if(tucked)
			to_chat(user, span_warning("[occupant.name] 看起来已经很舒服了！"))
			return
		to_chat(user, span_notice("你帮 [occupant.name] 在休眠舱里掖好了被子！"))
		qdel(weapon)
		user.add_mood_event("tucked", /datum/mood_event/tucked_in, occupant)
		tucked = TRUE

/obj/machinery/cryopod/update_icon_state()
	icon_state = state_open ? open_icon_state : base_icon_state
	return ..()

/// Special wall mounted cryopod for the prison, making it easier to autospawn.
/obj/machinery/cryopod/prison
	icon_state = "prisonpod"
	base_icon_state = "prisonpod"
	open_icon_state = "prisonpod"
	density = FALSE

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/cryopod/prison, 18)

/obj/machinery/cryopod/prison/set_density(new_value)
	// Simple way to make it always non-dense.
	return ..(FALSE)

/obj/machinery/cryopod/prison/close_machine(atom/movable/target, density_to_set = TRUE)
	. = ..()
	// Flick the pod for a second when user enters
	flick("prisonpod-open", src)

// Wake-up notifications

/obj/effect/mob_spawn/ghost_role
	/// For figuring out where the local cryopod computer is. Must be set for cryo computer announcements.
	var/area/computer_area


/obj/effect/mob_spawn/ghost_role/proc/find_control_computer()
	if(!computer_area)
		return
	for(var/cryo_console in GLOB.cryopod_computers)
		var/obj/machinery/computer/cryopod/console = cryo_console
		var/area/area = get_area(cryo_console) // Define moment
		if(area.type == computer_area)
			return console

	return

/**
 * Returns the the alt name for this spawner, which is 'outfit.name'.
 *
 * For when you might want to use that for things instead of the name var.
 * example: the DS2 spawners, which have a number of different types of spawner with the same name.
 */
/obj/effect/mob_spawn/ghost_role/proc/get_spawner_outfit_name()
	if(use_outfit_name)
		return initial(outfit.name)

/obj/effect/mob_spawn/ghost_role/human/lavaland_syndicate
	computer_area = /area/ruin/syndicate_lava_base/dormitories

//#undef AHELP_FIRST_MESSAGE
