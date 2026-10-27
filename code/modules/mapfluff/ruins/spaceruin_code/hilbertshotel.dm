GLOBAL_VAR_INIT(hhStorageTurf, null)
GLOBAL_VAR_INIT(hhMysteryRoomNumber, rand(1, 999999))

/obj/item/hilbertshotel
	name = "希尔伯特酒店"
	desc = "一个球体，似乎是错综复杂的蓝空间网络。当你试图理解其表面无穷多个无限细微的独立点时，细看它会让你头痛。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "hilbertshotel"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/datum/map_template/hilbertshotel/hotelRoomTemp
	var/datum/map_template/hilbertshotel/empty/hotelRoomTempEmpty
	var/datum/map_template/hilbertshotel/lore/hotelRoomTempLore
	var/list/activeRooms = list()
	var/list/storedRooms = list()
	var/storageTurf
	//Lore Stuff
	var/ruinSpawned = FALSE

/obj/item/hilbertshotel/Initialize(mapload)
	. = ..()
	//Load templates
	INVOKE_ASYNC(src, PROC_REF(prepare_rooms))

/obj/item/hilbertshotel/proc/prepare_rooms()
	hotelRoomTemp = new()
	hotelRoomTempEmpty = new()
	hotelRoomTempLore = new()
	var/area/currentArea = get_area(src)
	if(currentArea.type == /area/ruin/space/has_grav/powered/hilbertresearchfacility/secretroom)
		ruinSpawned = TRUE

/obj/item/hilbertshotel/Destroy()
	ejectRooms()
	return ..()

/obj/item/hilbertshotel/attack(mob/living/M, mob/living/user)
	if(M.mind)
		to_chat(user, span_notice("你邀请 [M] 进入酒店。"))
		promptAndCheckIn(user, M)
	else
		to_chat(user, span_warning("[M] 的智力不足以理解如何使用这个装置！"))

/obj/item/hilbertshotel/attack_self(mob/user)
	. = ..()
	promptAndCheckIn(user, user)

/obj/item/hilbertshotel/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] 主动排斥你的意识，环绕它的蓝空间能量扰乱了你的念力。"))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/hilbertshotel/proc/promptAndCheckIn(mob/user, mob/target)
	var/chosenRoomNumber

	// Input text changes depending on if you're using this in yourself or someone else.
	if(user == target)
		chosenRoomNumber = input(target, "你要入住几号房间？", "房间号") as null|num
	else
		chosenRoomNumber = input(target, "[user] 邀请你进入 \the [src]。你要入住几号房间？", "房间号") as null|num

	if(!chosenRoomNumber)
		return
	if(chosenRoomNumber > SHORT_REAL_LIMIT)
		to_chat(target, span_warning("你必须先探索完前 [SHORT_REAL_LIMIT] 个房间，才能前往编号更高的房间！"))
		return
	if((chosenRoomNumber < 1) || (chosenRoomNumber != round(chosenRoomNumber)))
		to_chat(target, span_warning("那不是有效的房间号！"))
		return

	// Orb is not adjacent to the target. No teleporties.
	if(!src.Adjacent(target))
		to_chat(target, span_warning("你离 \the [src] 太远，无法进入！"))

	// If the target is incapacitated after selecting a room, they're not allowed to teleport.
	if(target.incapacitated)
		to_chat(target, span_warning("你已经无法再激活 \the [src] 了！"))

	// Has the user thrown it away or otherwise disposed of it such that it's no longer in their hands or in some storage connected to them?
	if(get_atom_on_turf(src, /mob) != user)
		if(user == target)
			to_chat(user, span_warning("\The [src] 已经不在你手上了！"))
		else
			to_chat(target, span_warning("\The [src] 已经不在 [user] 手上了！"))
		return

	// If the player is using it on themselves, we've got some logic to deal with.
	// The user should drop the item before teleporting, but we're not going to force the item to be dropped if it can't be done normally...
	if(user == target)
		// The item should be on the user or in the user's inventory somewhere.
		// However, if they're not holding it, it may be in a pocket? In a backpack? Who knows! Still, they can't just drop it to the floor anymore...
		if(!user.get_held_index_of_item(src))
			to_chat(user, span_warning("你试着丢下 \the [src]，但已经太迟了！它已不在你手中！准备面对不可预见的后果……"))
		// Okay, so they HAVE to be holding it here, because it's in their hand from the above check. Try to drop the item and if it fails, oh dear...
		else if(!user.dropItemToGround(src))
			to_chat(user, span_warning("你似乎无法丢下 \the [src]！它一定以某种方式粘在了你手上！准备面对不可预见的后果……"))

	if(!storageTurf) //Blame subsystems for not allowing this to be in Initialize
		if(!GLOB.hhStorageTurf)
			var/datum/map_template/hilbertshotelstorage/storageTemp = new()
			var/datum/turf_reservation/storageReservation = SSmapping.request_turf_block_reservation(1, 1, 1)
			var/turf/storage_turf = storageReservation.bottom_left_turfs[1]
			storageTemp.load(storage_turf)
			GLOB.hhStorageTurf = storage_turf
		else
			storageTurf = GLOB.hhStorageTurf
	if(tryActiveRoom(chosenRoomNumber, target))
		return
	if(tryStoredRoom(chosenRoomNumber, target))
		return
	sendToNewRoom(chosenRoomNumber, target)

/obj/item/hilbertshotel/proc/tryActiveRoom(roomNumber, mob/user)
	if(activeRooms["[roomNumber]"])
		var/datum/turf_reservation/roomReservation = activeRooms["[roomNumber]"]
		do_sparks(3, FALSE, get_turf(user))
		var/turf/room_bottom_left = roomReservation.bottom_left_turfs[1]
		user.forceMove(locate(
			room_bottom_left.x + hotelRoomTemp.landingZoneRelativeX,
			room_bottom_left.y + hotelRoomTemp.landingZoneRelativeY,
			room_bottom_left.z,
		))
		return TRUE
	return FALSE

/obj/item/hilbertshotel/proc/tryStoredRoom(roomNumber, mob/user)
	if(storedRooms["[roomNumber]"])
		var/datum/turf_reservation/roomReservation = SSmapping.request_turf_block_reservation(hotelRoomTemp.width, hotelRoomTemp.height, 1)
		var/turf/room_turf = roomReservation.bottom_left_turfs[1]
		hotelRoomTempEmpty.load(room_turf)
		var/obj/item/abstracthotelstorage/storage_obj
		for(var/obj/item/abstracthotelstorage/hotel_storage in storageTurf)
			if((hotel_storage.roomNumber == roomNumber) && (hotel_storage.parentSphere == src))
				storage_obj = hotel_storage
				break
		var/turfNumber = 1
		for(var/x in 0 to hotelRoomTemp.width-1)
			for(var/y in 0 to hotelRoomTemp.height-1)
				for(var/atom/movable/atom in storedRooms["[roomNumber]"][turfNumber])
					if(istype(atom.loc, /obj/item/abstracthotelstorage))//Don't want to recall something thats been moved
						atom.forceMove(locate(
							room_turf.x + x,
							room_turf.y + y,
							room_turf.z,
						))
						if(storage_obj && (atom in storage_obj.wallmounted_contents))
							var/obj/stored_in = atom
							if(istype(stored_in))
								stored_in.find_and_mount_on_atom()
				turfNumber++
		qdel(storage_obj)
		storedRooms -= "[roomNumber]"
		activeRooms["[roomNumber]"] = roomReservation
		linkTurfs(roomReservation, roomNumber)
		do_sparks(3, FALSE, get_turf(user))
		user.forceMove(locate(
			room_turf.x + hotelRoomTemp.landingZoneRelativeX,
			room_turf.y + hotelRoomTemp.landingZoneRelativeY,
			room_turf.z,
		))
		return TRUE
	return FALSE

/obj/item/hilbertshotel/proc/sendToNewRoom(roomNumber, mob/user)
	var/datum/turf_reservation/roomReservation = SSmapping.request_turf_block_reservation(hotelRoomTemp.width, hotelRoomTemp.height, 1)
	var/turf/bottom_left = roomReservation.bottom_left_turfs[1]
	var/datum/map_template/load_from = hotelRoomTemp

	if(ruinSpawned && roomNumber == GLOB.hhMysteryRoomNumber)
		load_from = hotelRoomTempLore

	load_from.load(bottom_left)
	activeRooms["[roomNumber]"] = roomReservation
	linkTurfs(roomReservation, roomNumber)
	do_sparks(3, FALSE, get_turf(user))
	user.forceMove(locate(
		bottom_left.x + hotelRoomTemp.landingZoneRelativeX,
		bottom_left.y + hotelRoomTemp.landingZoneRelativeY,
		bottom_left.z,
	))

/obj/item/hilbertshotel/proc/linkTurfs(datum/turf_reservation/currentReservation, currentRoomnumber)
	var/turf/room_bottom_left = currentReservation.bottom_left_turfs[1]
	var/area/misc/hilbertshotel/currentArea = get_area(room_bottom_left)
	currentArea.name = "希尔伯特酒店 [currentRoomnumber] 号房"
	currentArea.parentSphere = src
	currentArea.storageTurf = storageTurf
	currentArea.roomnumber = currentRoomnumber
	currentArea.reservation = currentReservation

	for(var/turf/closed/indestructible/hoteldoor/door in currentReservation.reserved_turfs)
		door.parentSphere = src
		door.desc = "通往这间酒店房间的门。 \
			门牌上写着“第 [currentRoomnumber] 号房”。 \
			奇怪的是，这扇门似乎根本打不开。 \
			不过，门把手似乎嗡鸣着不寻常的能量……<br/>\
			[span_info("按住 Alt 点击以从窥视孔向外看。")]"
	for(var/turf/open/space/bluespace/BSturf in currentReservation.reserved_turfs)
		BSturf.parentSphere = src

/obj/item/hilbertshotel/proc/ejectRooms()
	if(length(activeRooms))
		for(var/active_room, turf_reservation in activeRooms)
			var/datum/turf_reservation/room = turf_reservation
			var/turf/room_bottom_left = room.bottom_left_turfs[1]
			for(var/i in 0 to hotelRoomTemp.width-1)
				for(var/j in 0 to hotelRoomTemp.height-1)
					for(var/atom/movable/atom in locate(room_bottom_left.x + i, room_bottom_left.y + j, room_bottom_left.z))
						if(ismob(atom))
							var/mob/mob_atom = atom
							if(mob_atom.mind)
								to_chat(mob_atom, span_warning("随着球体崩解，你突然被弹射到太空深处！"))
						var/max = world.maxx-TRANSITIONEDGE
						var/min = 1+TRANSITIONEDGE
						var/list/possible_transtitons = list()
						for(var/z_level in SSmapping.z_list)
							var/datum/space_level/space_level = z_level
							if (space_level.linkage == CROSSLINKED)
								possible_transtitons += space_level.z_value
						var/_z = pick(possible_transtitons)
						var/_x = rand(min,max)
						var/_y = rand(min,max)
						var/turf/turf_to_place_at = locate(_x, _y, _z)
						atom.forceMove(turf_to_place_at)
			qdel(room)

	if(length(storedRooms))
		for(var/room in storedRooms)
			var/list/atom_list = storedRooms[room]
			for(var/atom/movable/atom in atom_list)
				var/max = world.maxx-TRANSITIONEDGE
				var/min = 1+TRANSITIONEDGE
				var/list/possible_transtitons = list()
				for(var/z_level in SSmapping.z_list)
					var/datum/space_level/space_level = z_level
					if (space_level.linkage == CROSSLINKED)
						possible_transtitons += space_level.z_value
				var/_z = pick(possible_transtitons)
				var/_x = rand(min,max)
				var/_y = rand(min,max)
				var/turf/turf_to_place_at = locate(_x, _y, _z)
				atom.forceMove(turf_to_place_at)

//Template Stuff
/datum/map_template/hilbertshotel
	name = "希尔伯特酒店房间"
	mappath = "_maps/templates/hilbertshotel.dmm"
	var/landingZoneRelativeX = 2
	var/landingZoneRelativeY = 8

/datum/map_template/hilbertshotel/empty
	name = "空置的希尔伯特酒店房间"
	mappath = "_maps/templates/hilbertshotelempty.dmm"

/datum/map_template/hilbertshotel/lore
	name = "希尔伯特博士的临终之床"
	mappath = "_maps/templates/hilbertshotellore.dmm"

/datum/map_template/hilbertshotelstorage
	name = "希尔伯特酒店储藏区"
	mappath = "_maps/templates/hilbertshotelstorage.dmm"


//Turfs and Areas
/turf/closed/indestructible/hotelwall
	name = "酒店墙壁"
	desc = "一堵旨在保护酒店客人安全的墙。"
	icon_state = "hotelwall"
	smoothing_groups = SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_HOTEL_WALLS
	canSmoothWith = SMOOTH_GROUP_HOTEL_WALLS
	explosive_resistance = INFINITY

/turf/open/indestructible/hotelwood
	desc = "带额外加固的时尚深色木地板。牢牢固定在地面上，以防篡改。"
	icon_state = "wood"
	footstep = FOOTSTEP_WOOD
	tiled_turf = FALSE

/turf/open/indestructible/hoteltile
	desc = "带额外加固的光滑瓷砖。牢牢固定在地面上，以防篡改。"
	icon_state = "showroomfloor"
	footstep = FOOTSTEP_FLOOR
	tiled_turf = FALSE

/turf/open/space/bluespace
	name = "\proper 蓝空间超域"
	icon_state = "bluespace"
	base_icon_state = "bluespace"
	baseturfs = /turf/open/space/bluespace
	turf_flags = NOJAUNT
	explosive_resistance = INFINITY
	var/obj/item/hilbertshotel/parentSphere

/turf/open/space/bluespace/Initialize(mapload)
	. = ..()
	update_icon_state()

/turf/open/space/bluespace/update_icon_state()
	icon_state = base_icon_state
	return ..()

/turf/open/space/bluespace/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(parentSphere && arrived.forceMove(get_turf(parentSphere)))
		do_sparks(3, FALSE, get_turf(arrived))

/turf/closed/indestructible/hoteldoor
	name = "酒店门"
	icon_state = "hoteldoor"
	explosive_resistance = INFINITY
	var/obj/item/hilbertshotel/parentSphere
	// BUBBER EDIT ADDITION START - Condos
	var/leave_message = "希尔伯特酒店提醒您：尽管我们会尽一切努力保护您留下的物品， \
		但我们无法保证您离开期间它们的安全，尤其是任何生物的健康。 \
		考虑到这一点，您准备好离开了吗？"
	// BUBBER EDIT ADDITION END
	/// Mobs currently peeking through this door - needs cleanup if this turf changes type while they're still registered to it.
	var/list/mob/peeking_users

/turf/closed/indestructible/hoteldoor/Initialize(mapload)
	. = ..()
	register_context()

/turf/closed/indestructible/hoteldoor/Destroy(force)
	LAZYNULL(peeking_users)
	return ..()

/turf/closed/indestructible/hoteldoor/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_ALT_LMB] = "窥视"
	return CONTEXTUAL_SCREENTIP_SET

// Cancel the peeking of anyone peeking out of this door when the turf changes
/turf/closed/indestructible/hoteldoor/ChangeTurf(path, list/new_baseturfs, flags)
	for(var/mob/user in peeking_users)
		cancel_peek(user)
	return ..()

/// Cancel the peeking of anyone peeking out of this door while they are deleted
/turf/closed/indestructible/hoteldoor/proc/on_peeker_qdeleted(datum/source, force)
	SIGNAL_HANDLER
	LAZYREMOVE(peeking_users, source)

/// Cancels a user's peeking
/turf/closed/indestructible/hoteldoor/proc/cancel_peek(mob/user)
	for(var/datum/action/peephole_cancel/cancel_action in user.actions)
		INVOKE_ASYNC(cancel_action, TYPE_PROC_REF(/datum/action/peephole_cancel, Trigger))

/turf/closed/indestructible/hoteldoor/proc/promptExit(mob/living/user)
	if(!isliving(user))
		return
	if(!user.mind)
		return
	if(!parentSphere)
		to_chat(user, span_warning("这扇门似乎出了故障，拒绝运作！"))
		return
	/// BUBBER EDIT CHANGE START - Condos
	/* Original:
	if(tgui_alert(user, "Hilbert's Hotel would like to remind you that while we will do everything we can to protect the belongings you leave behind, we make no guarantees of their safety while you're gone, especially that of the health of any living creatures. With that in mind, are you ready to leave?", "Exit", list("Leave", "Stay")) == "Leave")
	*/
	if(tgui_alert(user, leave_message, "退出", list("离开", "留下")) == "离开") // BUBBER EDIT CHANGE - Moved blurb to leave_message variable
	/// BUBBER EDIT CHANGE END
		if(HAS_TRAIT(user, TRAIT_IMMOBILIZED) || (get_dist(get_turf(src), get_turf(user)) > 1)) //no teleporting around if they're dead or moved away during the prompt.
			return
		user.forceMove(get_turf(parentSphere))
		do_sparks(3, FALSE, get_turf(user))

/turf/closed/indestructible/hoteldoor/attack_ghost(mob/dead/observer/user)
	if(!isobserver(user) || !parentSphere)
		return ..()
	user.forceMove(get_turf(parentSphere))

//If only this could be simplified...
/turf/closed/indestructible/hoteldoor/attack_tk(mob/user)
	return //need to be close.

/turf/closed/indestructible/hoteldoor/attack_hand(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_animal(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_paw(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_hulk(mob/living/carbon/human/user)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_larva(mob/user, list/modifiers)
	promptExit(user)

/turf/closed/indestructible/hoteldoor/attack_robot(mob/user)
	if(get_dist(get_turf(src), get_turf(user)) <= 1)
		promptExit(user)

/turf/closed/indestructible/hoteldoor/click_alt(mob/user)
	if(user.is_blind())
		to_chat(user, span_warning("该死！你的视力太差，用不了这个！"))
		return CLICK_ACTION_BLOCKING

	to_chat(user, span_notice("你透过门的蓝空间窥视孔向外张望……"))
	user.reset_perspective(parentSphere)
	var/datum/action/peephole_cancel/peephole_cancel_action = new
	peephole_cancel_action.door = src
	user.overlay_fullscreen("remote_view", /atom/movable/screen/fullscreen/impaired, 1)
	peephole_cancel_action.Grant(user)
	LAZYADD(peeking_users, user)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_eye))
	RegisterSignal(user, COMSIG_QDELETING, PROC_REF(on_peeker_qdeleted))
	return CLICK_ACTION_SUCCESS

/turf/closed/indestructible/hoteldoor/proc/check_eye(mob/user, atom/oldloc, direction)
	SIGNAL_HANDLER
	if(get_dist(get_turf(src), get_turf(user)) < 2)
		return
	cancel_peek(user)
	UnregisterSignal(user, COMSIG_QDELETING)

/datum/action/peephole_cancel
	name = "取消观察"
	desc = "停止透过蓝空间窥视孔观察。"
	button_icon_state = "cancel_peephole"
	/// The door this peephole view is looking through
	var/turf/closed/indestructible/hoteldoor/door

/datum/action/peephole_cancel/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	to_chat(owner, span_warning("你从窥视孔前移开。"))
	owner.reset_perspective()
	owner.clear_fullscreen("remote_view", 0)
	door?.UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	LAZYREMOVE(door?.peeking_users, owner)
	qdel(src)

/datum/action/peephole_cancel/Destroy(force)
	door = null
	return ..()

// Despite using the ruins.dmi, hilbertshotel is not a ruin
/area/misc/hilbertshotel
	name = "希尔伯特酒店房间"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	default_gravity = STANDARD_GRAVITY
	area_flags = NOTELEPORT | HIDDEN_AREA
	area_flags_mapping = NONE
	static_lighting = TRUE
	// ambientsounds = list('sound/ambience/ruin/servicebell.ogg') // BUBBER EDIT REMOVAL
	var/roomnumber = 0
	var/obj/item/hilbertshotel/parentSphere
	var/datum/turf_reservation/reservation
	var/turf/storageTurf

/area/misc/hilbertshotel/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(istype(arrived, /obj/item/hilbertshotel))
		relocate(arrived)
	var/list/obj/item/hilbertshotel/hotels = arrived.get_all_contents_type(/obj/item/hilbertshotel)
	for(var/obj/item/hilbertshotel/hotel_item in hotels)
		if(parentSphere == hotel_item)
			relocate(hotel_item)

/area/misc/hilbertshotel/proc/relocate(obj/item/hilbertshotel/hotel_item)
	if(prob(0.135685)) //Because screw you
		qdel(hotel_item)
		return

	// Prepare for...
	var/mob/living/unforeseen_consequences = get_atom_on_turf(hotel_item, /mob/living)

	// Turns out giving anyone who grabs a Hilbert's Hotel a free, complementary warp whistle is probably bad.
	// Let's gib the last person to have selected a room number in it.
	if(unforeseen_consequences)
		to_chat(unforeseen_consequences, span_warning("\The [hotel_item] 开始共振。迫使它进入自身会引发蓝空间悖论，把你的身体猛烈撕碎。"))
		unforeseen_consequences.investigate_log("因在 [hotel_item] 内部使用它而被绞成碎块。", INVESTIGATE_DEATHS)
		unforeseen_consequences.gib(DROP_ALL_REMAINS)

	var/turf/targetturf = find_safe_turf()
	if(!targetturf)
		if(length(GLOB.blobstart) > 0)
			targetturf = get_turf(pick(GLOB.blobstart))
		else
			CRASH("Unable to find a blobstart landmark")

	log_game("[hotel_item] 进入了自身。正在将其移动到 [loc_name(targetturf)]。")
	message_admins("[hotel_item] 进入了自身。正在将其移动到 [ADMIN_VERBOSEJMP(targetturf)]。")
	hotel_item.visible_message(span_danger("[hotel_item] 几乎要向自身内部坍缩，但很快反弹，飞向太空中的随机一点！"))
	hotel_item.forceMove(targetturf)

/area/misc/hilbertshotel/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/mob/gone_mob = gone
		if(gone_mob.mind)
			var/still_populated = FALSE
			var/list/current_living_mobs = get_all_contents_type(/mob/living) //Got to catch anyone hiding in anything
			for(var/mob/living/living_mob as anything in current_living_mobs) //Check to see if theres any sentient mobs left.
				if(living_mob.mind)
					still_populated = TRUE
					break
			if(!still_populated)
				storeRoom()

/area/misc/hilbertshotel/proc/storeRoom()
	var/turf/room_bottom_left = reservation.bottom_left_turfs[1]
	var/turf/room_top_right = reservation.top_right_turfs[1]
	var/roomSize = \
		((room_top_right.x - room_bottom_left.x) + 1) * \
		((room_top_right.y - room_bottom_left.y) + 1)
	var/storage[roomSize]
	var/turfNumber = 1
	var/obj/item/abstracthotelstorage/storageObj = new(storageTurf)
	storageObj.roomNumber = roomnumber
	storageObj.parentSphere = parentSphere
	storageObj.name = "第 [roomnumber] 号房储藏"
	for(var/x in 0 to parentSphere.hotelRoomTemp.width-1)
		for(var/y in 0 to parentSphere.hotelRoomTemp.height-1)
			var/list/turfContents = list()
			for(var/atom/movable/atom in locate(room_bottom_left.x + x, room_bottom_left.y + y, room_bottom_left.z))
				if(ismob(atom) && !isliving(atom))
					continue //Don't want to store ghosts
				turfContents += atom
				if(HAS_TRAIT(atom, TRAIT_WALLMOUNTED))
					LAZYADD(storageObj.wallmounted_contents, atom)
					qdel(atom.GetComponent(/datum/component/atom_mounted))
				atom.forceMove(storageObj)
			storage[turfNumber] = turfContents
			turfNumber++
	parentSphere.storedRooms["[roomnumber]"] = storage
	parentSphere.activeRooms -= "[roomnumber]"
	QDEL_NULL(reservation)

/area/misc/hilbertshotelstorage
	name = "希尔伯特酒店储藏室"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	area_flags = HIDDEN_AREA | NOTELEPORT
	area_flags_mapping = UNIQUE_AREA
	default_gravity = STANDARD_GRAVITY

/obj/item/abstracthotelstorage
	anchored = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	item_flags = ABSTRACT
	var/roomNumber
	var/obj/item/hilbertshotel/parentSphere
	/// Movables that had their atom_mounted component stripped so they wouldn't deconstruct while stored - remounted when the room is restored.
	var/list/wallmounted_contents

/obj/item/abstracthotelstorage/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/machinery/light))
		var/obj/machinery/light/entered_light = arrived
		entered_light.end_processing()
	. = ..()
	if(ismob(arrived))
		var/mob/target = arrived
		ADD_TRAIT(target, TRAIT_NO_TRANSFORM, REF(src))

/obj/item/abstracthotelstorage/Destroy(force)
	LAZYNULL(wallmounted_contents)
	return ..()

/obj/item/abstracthotelstorage/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/mob/target = gone
		REMOVE_TRAIT(target, TRAIT_NO_TRANSFORM, REF(src))
	if(istype(gone, /obj/machinery/light))
		var/obj/machinery/light/exited_light = gone
		exited_light.begin_processing()

//Space Ruin stuff
/area/ruin/space/has_grav/powered/hilbertresearchfacility
	name = "希尔伯特研究设施"

/area/ruin/space/has_grav/powered/hilbertresearchfacility/secretroom
	area_flags = NOTELEPORT | HIDDEN_AREA

/obj/item/analyzer/hilbertsanalyzer
	name = "改装分析仪"
	desc = "一台手持环境扫描仪，可报告当前气体水平。这一台似乎经过改装，还能分析某种蓝空间装置。"
	icon_state = "hilbertsanalyzer"
	worn_icon_state = "analyzer"

/obj/item/analyzer/hilbertsanalyzer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/hilbertshotel))
		return ..()
	if(!interacting_with.IsReachableBy(user))
		to_chat(user, span_warning("太远了，扫描不到！"))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/hilbertshotel/sphere = interacting_with
	if(length(sphere.activeRooms))
		to_chat(user, "当前已入住房间：")
		for(var/roomnumber in sphere.activeRooms)
			to_chat(user, roomnumber)
	else
		to_chat(user, "当前没有已入住的房间。")
	if(sphere.storedRooms.len)
		to_chat(user, "已腾空房间：")
		for(var/roomnumber in sphere.storedRooms)
			to_chat(user, roomnumber)
	else
		to_chat(user, "没有已腾空的房间。")
	return ITEM_INTERACT_SUCCESS

/obj/effect/landmark/transport/transport_id/hilbert
	specific_transport_id = HILBERT_LINE_1

/obj/effect/landmark/transport/nav_beacon/tram/nav/hilbert
	name = HILBERT_LINE_1
	specific_transport_id = TRAM_NAV_BEACONS

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/left
	name = "左舷"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_PORT
	tgui_icons = list("接待处" = "briefcase", "植物学" = "leaf", "化学" = "flask")

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/middle
	name = "中央"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_CENTRAL
	tgui_icons = list("处理" = "cogs", "异种生物学" = "paw")

/obj/effect/landmark/transport/nav_beacon/tram/platform/hilbert/right
	name = "右舷"
	specific_transport_id = HILBERT_LINE_1
	platform_code = HILBERT_STARBOARD
	tgui_icons = list("军械" = "bullseye", "办公室" = "user", "宿舍" = "bed")

/obj/item/keycard/hilbert
	name = "希尔伯特办公室钥匙卡"
	desc = "一张刻有铭文的钥匙卡。铭文写着：“希尔伯特”。"
	color = "#aa00cc"
	puzzle_id = "hilbert_office"

/obj/machinery/door/puzzle/keycard/hilbert
	name = "安全气闸"
	puzzle_id = "hilbert_office"

/datum/outfit/doctorhilbert
	name = "Doctor Hilbert"
	id = /obj/item/card/id/advanced/silver
	uniform = /obj/item/clothing/under/rank/rnd/research_director/doctor_hilbert
	shoes = /obj/item/clothing/shoes/sneakers/brown
	back = /obj/item/storage/backpack/satchel/leather
	suit = /obj/item/clothing/suit/toggle/labcoat
	id_trim = /datum/id_trim/away/hilbert

/datum/outfit/doctorhilbert/pre_equip(mob/living/carbon/human/hilbert, visuals_only)
	. = ..()
	if(!visuals_only)
		hilbert.gender = MALE
		hilbert.update_body()

/obj/item/paper/crumpled/ruins/note_institute
	name = "致研究所的便条"

/obj/item/paper/crumpled/ruins/note_institute/Initialize(mapload)
	default_raw_text = {"致研究所的便条<br>
	如果你正在读这个，我希望你来自研究所。首先，我必须道歉。新学期我不会回来教书了。<br>
	我们树了一些强大的敌人。非常强大。强大到超出你们任何人的想象，所以我们回不去了。<br>
	因此，我们决定消失。也许比你想的更字面意义上。不要试图找我们——为了你们自己的安全。<br>
	我把我们的一些物品留在了酒店里。<u>[uppertext(num2hex(GLOB.hhMysteryRoomNumber, 0))]</u> 号房。对任何该知道的人来说，这会说得通。<br>
	祝研究顺利。我们希尔伯特小组全体成员都很荣幸与你们共事。<br>
	——大卫、菲尔、菲奥娜和珍"}
	return ..()

/obj/item/paper/crumpled/ruins/postdocs_memo
	name = "致博士后们的备忘录"
	default_raw_text = {"致博士后们的备忘录
	记住，如果你无论如何都要进去取回原型（按理说没有我的监督你不该去），要注意安保系统始终处于开启状态——它们没有关闭开关。<br>
	所以，记住：你看不见的东西伤不到你。<br>
	我休假期间照看好实验室。六月见。<br>
	——大卫"}

/obj/item/paper/crumpled/ruins/hotel_note
	name = "酒店便条"
	default_raw_text = {"酒店便条<br>
	好吧，你解开了谜题。看来有人对我的研究下过功夫。<br>
	我想你应该有权多了解一些我们的处境。我们的研究引来了一些不该有的注意，所以，为了我们自身的安全，我们投身进入了蓝空间。<br>
	是的，你没看错。我肯定那些物理和数学会让你觉得无聊，但用外行的话说，这些晶体所提供的、与蓝空间之间的显现联系是可以被利用的。有了正确的技术，人就能在蓝空间上“冲浪”，就像珍喜欢说的那样。<br>
	更重要的是，时空连续体在这里完全生效。通过正确地操纵蓝空间，人可以去<i>任何地方</i>：无论是时间还是空间。我承认我自己还没搞明白这一点。去查看壁橱吧——就当是解开谜题的奖励。使用时务必小心——你可能会发现自己也要面对我们招来的那些追踪者。<br>
	他们处理的是“时间犯罪”，不管他们对这个词的定义是什么。<br>
	总之，我开始唠叨了。我们得走了。记得把任何追授的诺贝尔奖都写在我们部门名下。<br>
	——大卫"}

/obj/item/paper/fluff/ruins/docslabnotes
	name = "实验室笔记本页"
	default_raw_text = {"实验室笔记本<br>
	D. 希尔伯特博士的财产<br>
	2555 年 5 月 10 日<br>
	终于，我的新设施完工了，而且来得正是时候！<br>
	我和格雷汉姆之间的分歧已经大到无法忍受，所以离开校园一段时间对我有好处。反正我的学生也从来不懂我的工作。教书从来不是我的热情所在。<br>
	总之，我跑题了。几百万的科研经费能买到什么，真是令人惊叹。这座空间站是最先进的，非常适合我的研究。<br>
	自 2459 年的张氏事件以来，我们对蓝空间晶体的特性已相当了解。它们扭曲空间的特性有详尽记录，却鲜有人真正理解。不过，我推测或许能以新的方式驾驭它们。<br>
	为此，我从研究所找来了一小批博士后学生协助我的研究。有些行政上的帮手也不错——也许我该雇个秘书……<br>
	*其后是一长串页面，详述失败经历、对研究所的不满，以及多到没人能消化完的科学公式。*<br>
	<h4>突破<h4>
	2557 年 1 月 8 日<br>
	我的理论基本站得住脚。今天，我们首次成功测试了“希尔伯特口袋”，我们习惯这么叫它。利用蓝空间晶体在空间中制造局部膨胀的能力，再依照几何微积分精确施力，我们成功地把空间“折叠”成了一个口袋。我们让菲尔从房间另一头把他的一个分析仪扔了进去，我们看到的一切令人难以置信。<br>
	一个有限区域内的无限空间口袋。简直是革命性的！<br>
	我让博士后们去写论文，自己则研究具体细节。技术是成功的，但我们还没有办法驾驭它。除非……<br>
	*其后还有更多页面，满是公式、工程图纸和漫谈。希尔伯特显然很喜欢看自己写的字。*<br>
	<h4>一种新装置<h4>
	2557 年 9 月 21 日<br>
	我们已把关于希尔伯特口袋的论文初稿投给了期刊。现在，我想，只能等了。<br>
	与此同时，我开始组装该装置的第一台原型。利用口袋在有限区域内创造无限空间区域的能力，我造出了……好吧，我想它可以被称为“口袋维度”。在其中，我造了一套巧妙的系统，能递归地产生子空间房间，并在空间上将它们与口袋表面无穷多个点中的任意一点相连。菲奥娜说这就像一家酒店，我倾向于同意。<br>
	希尔伯特酒店。我喜欢这个名字。<br>"}

/obj/machinery/computer/terminal/hilbert
	upperinfo = "邮件读数——14/05/2558"
	content = list(
		"<b>新工作</b><br> \
		<i>收件人：natalya_petroyenko@kosmokomm.net</i><br> \
		姐！我想该跟你更新一下转行后的情况。<br> \
		新工作第一天。这岗位挺无聊的，但嘿——反正我在新弗拉基米尔也没找到什么机会。能有份付账单的活儿我就知足了。<br> \
		还是说说具体干什么吧：我基本上是在给某个科学家和他那帮学生助手当管家。他们干的事远超我的薪资级别，我是看不懂的，不过他们看起来挺兴奋。老是说什么“口袋”，也不知道为什么。也许他们在设计下一款服装创新？<br> \
		总之，差不多就这样。我基本上会一直住在他们的空间站上，所以不确定能不能赶回妈妈生日。抱歉——等我休假时，一定尽力补偿她（还有你）。<br> \
		希望能尽快见到你，<br> \
		弟弟 罗曼",
		"<b>访客</b><br> \
		<i>收件人：david_hilbert@physics.mit.edu</i><br> \
		早上好，博士。抱歉在你休假时发邮件，但你说过任何可疑的事都要向你汇报。<br> \
		这几天一直有一艘船在设施附近转悠。考虑到我们离任何重要的地方都那么远，这已经够奇怪了，但更奇怪的是他们其中一人终于过来搭话了。<br> \
		我知道我不是母语者，但我听不出他的口音。反正和我以前听过的都不一样。<br> \
		他一直问你在哪儿，能不能进来跟你谈谈。我当然把他打发走了——就算你在，我也会犹豫要不要让他进来。<br> \
		另外，博士后们让我转达一个消息。看来他们取得了突破，听起来是好事。<br> \
		此致，<br> \
		罗曼<br>",
		"<b>古怪的日子</b><br> \
		<i>收件人：natalya_petroyenko@kosmokomm.net</i><br> \
		姐！圣诞节过得怎么样？爸爸妈妈都好吗？真的很抱歉我没能到场，但我一直在工作里拼死拼活。<br> \
		我想我该稍微跟你说说这边的情况。我知道，我知道，你老说我是工作狂，但这里真的……很古怪，我想。<br> \
		我时不时能瞥见一点正在进行的研究。他们在摆弄蓝空间——你知道的，就是让超光速引擎运作的技术？我不确定他们到底在拿它做什么，但如今他们越来越频繁地谈起“口袋”。<br> \
		不只如此，我开始听到那些不许我进的实验室里传来奇怪的声响。不是什么超级恐怖的东西，你知道，我们说的可不是异形，而是更像工业噪音。碰撞声、敲击声，偶尔还有尖锐的嗡鸣，你懂那种声音。就像坏掉的吸尘器。<br> \
		我知道那不是仪器发出的，否则我以前就听过了，所以一定是他们在弄什么新东西。想来挺刺激，但我开始怀疑自己在这儿工作是不是力不从心了。也许我该开始找份新工作，找个离家近点的地方。<br> \
		希望在爸爸生日那天见到你。我已经为此申请了休假，就等博士回复了。<br> \
		很快见，<br> \
		弟弟 罗曼<br>",
		"<b>休假结束</b><br> \
		<i>收件人：david_hilbert@physics.mit.edu</i><br> \
		早上好，博士。大家都去哪儿了？我休假回来，空间站却空了。你们全都去度假了也不告诉我一声？<br> \
		还有军械实验室到底出了什么事？我连门都打不开，它被熔死了！<br> \
		听着，这地方都成这样了，我待在这儿不安全，所以我要叫个工程师来，然后回家，直到收到你的回复。<br> \
		此致，<br> \
		罗曼<br>",
		"<b>寻找新工作</b><br> \
		<i>收件人：natalya_petroyenko@kosmokomm.net</i><br> \
		姐。先说最重要的，抱歉错过了你的订婚派对。工作上出了……状况。<br> \
		其实，这也是我写这封信的主要原因。我完全不知道发生了什么，但博士和学生们都不见了。就这么走了。设施被废弃了。<br> \
		可是，很明显他们走得很匆忙。见鬼，杯子里还剩着咖啡。我本想再追究下去，但他们一向就挺……古怪的，我想？整件事让我毛骨悚然，我觉得我不想再深挖了。<br> \
		我给他的大学发了邮件，也叫来了当局。现在剩下的，我想，就是找份新工作了。你老板碰巧在招人吗？<br> \
		很快见，<br> \
		弟弟 罗曼",
	)

/obj/structure/showcase/machinery/tv/broken
	name = "损坏的电视"
	desc = "什么都放不出来。"

/obj/structure/showcase/machinery/tv/broken/Initialize(mapload)
	. = ..()
	add_overlay("television_broken")

/obj/machinery/porta_turret/syndicate/teleport
	name = "位移炮塔"
	desc = "一台发射蓝空间子弹的弹道机枪自动炮塔。"
	lethal_projectile = /obj/projectile/magic/teleport/bluespace
	stun_projectile = /obj/projectile/magic/teleport/bluespace
	faction = list(FACTION_TURRET)

/obj/projectile/magic/teleport/bluespace
	antimagic_flags = NONE
