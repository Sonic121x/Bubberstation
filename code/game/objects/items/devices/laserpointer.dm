/obj/item/laser_pointer
	name = "激光笔"
	desc = "不要照进眼睛里！"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "pointer"
	inhand_icon_state = "pen"
	worn_icon_state = "pen"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	w_class = WEIGHT_CLASS_SMALL
	///Currently stored blulespace crystal, if any. Required to use the pointer through walls
	var/obj/item/stack/ore/bluespace_crystal/crystal_lens
	///Currently stored micro-laser diode
	var/obj/item/stock_parts/micro_laser/diode
	///Chance that the pointer dot will trigger a reaction from a mob/object
	var/effectchance = 30
	///Currently available battery charge of the laser pointer
	var/energy = 10
	///Maximum possible battery charge of the laser. Draining the battery puts the pointer in a recharge state, preventing use, which ends upon full recharge
	var/max_energy = 10
	///Maximum use range
	var/max_range = 7
	///Icon for the laser, affects both the laser dot and the laser pointer itself, as it shines a laser on the item itself
	var/pointer_icon_state = null
	///Whether the pointer is currently in a full recharge state. Triggered upon fully draining the battery
	var/recharge_locked = FALSE
	///Whether the pointer is currently recharging or not
	var/recharging = FALSE

/obj/item/laser_pointer/red
	pointer_icon_state = "red_laser"

/obj/item/laser_pointer/green
	pointer_icon_state = "green_laser"

/obj/item/laser_pointer/blue
	pointer_icon_state = "blue_laser"

/obj/item/laser_pointer/purple
	pointer_icon_state = "purple_laser"

/obj/item/laser_pointer/Initialize(mapload)
	. = ..()
	diode = new(src)
	if(!pointer_icon_state)
		pointer_icon_state = pick("red_laser", "green_laser", "blue_laser", "purple_laser")

/obj/item/laser_pointer/Destroy(force)
	QDEL_NULL(crystal_lens)
	QDEL_NULL(diode)
	return ..()

/obj/item/laser_pointer/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == crystal_lens)
		crystal_lens = null
	if(gone == diode)
		diode = null

/obj/item/laser_pointer/upgraded/Initialize(mapload)
	. = ..()
	diode = new /obj/item/stock_parts/micro_laser/ultra

/obj/item/laser_pointer/infinite_range
	name = "无限激光笔"
	desc = "用来照一照需要督促的半机械人的眼睛，可以通过摄像头控制台使用。"
	max_range = INFINITY

/obj/item/laser_pointer/infinite_range/Initialize(mapload)
	. = ..()
	diode = new /obj/item/stock_parts/micro_laser/quadultra

/obj/item/laser_pointer/screwdriver_act(mob/living/user, obj/item/tool)
	if(diode)
		tool.play_tool_sound(src)
		balloon_alert(user, "已拆下二极管")
		diode.forceMove(drop_location())
		diode = null
		return TRUE

/obj/item/laser_pointer/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	if(isnull(crystal_lens))
		return ..()
	if(tool_behaviour != TOOL_WIRECUTTER && tool_behaviour != TOOL_HEMOSTAT)
		return ..()
	tool.play_tool_sound(src)
	balloon_alert(user, "已拆下水晶透镜")
	crystal_lens.forceMove(drop_location())
	crystal_lens = null
	return ITEM_INTERACT_SUCCESS

/obj/item/laser_pointer/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/stock_parts/micro_laser))
		if(diode)
			balloon_alert(user, "已经装有二极管！")
			return ITEM_INTERACT_BLOCKING
		var/obj/item/stock_parts/attack_diode = tool
		if(crystal_lens && attack_diode.rating < 3) //only tier 3 and up are small enough to fit
			to_chat(user, span_warning("你试图把[tool.name]塞进去，但[crystal_lens.name]挡住了位置！"))
			playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 20)
			if(!do_after(user, 2 SECONDS, src))
				return ITEM_INTERACT_BLOCKING
			var/atom/atom_to_teleport = pick(user, tool)
			if(atom_to_teleport == user)
				to_chat(user, span_warning("你塞[tool.name]时用力过猛，弄碎了里面的[crystal_lens.name]，将自己传送走了！"))
				user.drop_all_held_items()
			else if(atom_to_teleport == tool)
				tool.forceMove(drop_location())
				to_chat(user, span_warning("你塞[tool.name]时用力过猛，弄碎了里面的[crystal_lens.name]，将[tool.name]传送走了！"))
			do_teleport(atom_to_teleport, get_turf(src), crystal_lens.blink_range, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
			qdel(crystal_lens)
			return ITEM_INTERACT_SUCCESS
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		playsound(src, 'sound/items/tools/screwdriver.ogg', 30)
		diode = tool
		balloon_alert(user, "已安装[diode.name]")
		//we have a diode now, try starting a charge sequence in case the pointer was charging when we took out the diode
		recharging = TRUE
		START_PROCESSING(SSobj, src)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/ore/bluespace_crystal))
		if(crystal_lens)
			balloon_alert(user, "已经装有透镜！")
			return ITEM_INTERACT_BLOCKING
		//the crystal stack we're trying to install a crystal from
		var/obj/item/stack/ore/bluespace_crystal/crystal_stack = tool
		if(diode && diode.rating < 3) //only lasers of tier 3 and up can house a lens
			to_chat(user, span_warning("你试图把[crystal_stack.name]塞到二极管前，但尺寸不合适！"))
			playsound(src, 'sound/machines/airlock/airlock_alien_prying.ogg', 20)
			if(!do_after(user, 2 SECONDS, src))
				return ITEM_INTERACT_BLOCKING
			var/atom/atom_to_teleport = pick(user, src)
			if(atom_to_teleport == user)
				to_chat(user, span_warning("你按压[crystal_stack.name]时用力过猛，把自己传送走了！"))
				user.drop_all_held_items()
			else if(atom_to_teleport == src)
				forceMove(drop_location())
				to_chat(user, span_warning("你按压[crystal_stack.name]时用力过猛，把[src]传送走了！"))
			do_teleport(atom_to_teleport, get_turf(src), crystal_stack.blink_range, asoundin = 'sound/effects/phasein.ogg', channel = TELEPORT_CHANNEL_BLUESPACE)
			crystal_stack.use_tool(src, user, amount = 1) //use only one if we were installing from a stack of crystals
			return ITEM_INTERACT_SUCCESS
		//the single crystal that we actually install
		var/obj/item/stack/ore/bluespace_crystal/single_crystal = crystal_stack.split_stack(1)
		if(isnull(single_crystal))
			return ITEM_INTERACT_BLOCKING
		single_crystal.forceMove(src)
		crystal_lens = single_crystal
		playsound(src, 'sound/items/tools/screwdriver2.ogg', 30)
		balloon_alert(user, "已安装[crystal_lens.name]")
		to_chat(user, span_notice("你在[src]中装入了[crystal_lens.name]。\
			现在它可以穿透障碍物照射，但耗能加倍。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/laser_pointer/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		if(isnull(diode))
			. += span_notice("缺少二极管。")
		else
			. += span_notice("装有一枚<b>[diode.rating]</b>级激光二极管，以<i>螺丝</i>固定。")
		. += span_notice("小显示屏显示：[recharge_locked ? "正在充能至满，" : ""]总能量剩余<b>[energy * 10]%</b>。")
		if(crystal_lens)
			. += span_notice("聚焦透镜前整齐地装着一块<b>[crystal_lens.name]</b>。可以用<i>剪线钳</i>将其<i>夹出</i>。")
		else if(diode) //hint at the ability to modify the pointer with a crystal only if we have a diode
			. += span_notice("<i>你可以再仔细检查一下……</i>")

/obj/item/laser_pointer/examine_more(mob/user)
	. = ..()
	if(!isnull(crystal_lens) || isnull(diode))
		return
	switch(diode.rating)
		if(1)
			. += "<i>[diode.name]整齐地装在外壳中。</i>"
		if(2)
			. += "<i>[diode.name]已固定就位，它与聚焦透镜之间还留有一点空间。</i>"
		if(3 to 4)
			. += "<i>[diode.name]比上一代激光器小得多，\
			它与聚焦透镜之间的大块空隙应该可以装入某种<b>水晶</b>。</i>"

/obj/item/laser_pointer/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	laser_act(interacting_with, user, modifiers)
	return ITEM_INTERACT_BLOCKING

/obj/item/laser_pointer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(HAS_TRAIT(interacting_with, TRAIT_COMBAT_MODE_SKIP_INTERACTION))
		return NONE
	return ranged_interact_with_atom(interacting_with, user, modifiers)

///Handles shining the clicked atom,
/obj/item/laser_pointer/proc/laser_act(atom/target, mob/living/user, list/modifiers)
	if(isnull(diode))
		to_chat(user, span_notice("你把[src]对准[target]，但什么也没发生！"))
		return
	if(!ISADVANCEDTOOLUSER(user))
		to_chat(user, span_warning("你的动作不够灵巧，做不到！"))
		return
	if(HAS_TRAIT(user, TRAIT_CHUNKYFINGERS))
		to_chat(user, span_warning("你的手指按不了按钮！"))
		return

	if(max_range != INFINITY)
		if(!IN_GIVEN_RANGE(target, user, max_range))
			to_chat(user, span_warning("[target]太远了！"))
			return
		if(!(user in (view(max_range, target)))) //check if we are visible from the target's PoV
			if(isnull(crystal_lens))
				to_chat(user, span_warning("你不能用[src]穿墙照射！"))
				return
			if(!((user.sight & SEE_OBJS) || (user.sight & SEE_MOBS))) //only let it work if we have xray or thermals. mesons don't count because they are easier to get.
				to_chat(user, span_notice("你看不清目标，没能照到它。"))
				return

	add_fingerprint(user)

	//nothing happens if the battery has been drained and has not fully recharged yet
	if(recharge_locked)
		to_chat(user, span_notice("你把[src]对准[target]，但它仍在充能。"))
		return

	//The message we send to the user upon using the pointer
	var/outmsg
	//The turf of the target we clicked on
	var/turf/targloc = get_turf(target)

	//human/alien mobs: if we aim for the eyes, chance to flash the target
	if(iscarbon(target))
		var/mob/living/carbon/target_humanoid = target
		if(target_humanoid.stat == DEAD)
			outmsg = span_notice("你把[src]对准[target_humanoid]，但[target_humanoid.p_they()]似乎已经死了！")
		else if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			//Intensity of the laser dot to pass to flash_act
			var/severity = pick(0, 1, 2)
			var/always_fail = FALSE
			if(istype(target_humanoid.get_item_by_slot(ITEM_SLOT_EYES), /obj/item/clothing/glasses/eyepatch) && prob(50))
				always_fail = TRUE

			//chance to actually hit the eyes depends on internal component
			if(prob(effectchance * diode.rating) && !always_fail && target_humanoid.flash_act(severity))
				outmsg = span_notice("你用[src]照射[target_humanoid]的眼睛，使其暂时失明。")
				log_combat(user, target_humanoid, "blinded with a laser pointer", src)
			else
				outmsg = span_warning("你用[src]照射[target_humanoid]的眼睛，但没能使其失明！")
				log_combat(user, target_humanoid, "attempted to blind with a laser pointer", src)

	//borgs: chance to flash and paralyse the target
	else if(iscyborg(target))
		var/mob/living/silicon/target_sillycone = target
		//chance to actually hit the eyes depends on internal component
		if(target_sillycone.stat == DEAD)
			outmsg = span_notice("你把[src]对准[target_sillycone]，但[target_sillycone.p_they()]似乎已经停止运作。")
		if(prob(effectchance * diode.rating) && target_sillycone.flash_act(affect_silicon = TRUE))
			target_sillycone.set_temp_blindness_if_lower(5 SECONDS)
			to_chat(target_sillycone, span_danger("你的传感器被激光照得过载了！"))
			outmsg = span_notice("你用[src]照射[target_sillycone]的传感器，使其过载。")
			log_combat(user, target_sillycone, "shone in the sensors", src)
		else
			outmsg = span_warning("你用[src]照射[target_sillycone]的传感器，但没能使其过载！")
			log_combat(user, target_sillycone, "attempted to shine in the sensors", src)

	//cameras: chance to EMP the camera
	else if(istype(target, /obj/machinery/camera))
		var/obj/machinery/camera/target_camera = target
		if(!target_camera.camera_enabled && !target_camera.emped)
			outmsg = span_notice("你把[src]对准[target_camera]，但它似乎已经停用了。")
		else if(prob(effectchance * diode.rating))
			target_camera.emp_act(EMP_HEAVY)
			outmsg = span_notice("你用[src]照中了[target_camera]的镜头，使摄像头暂时失效！")
			log_combat(user, target_camera, "EMPed", src)
		else
			outmsg = span_warning("你的[src]没照中[target_camera]的镜头！")

	//Make any mob with catlike instincts near the target face the target, with a chance of pouncing (moving) toward it.
	for(var/mob/living/target_cat in view(1, targloc))
		if(!HAS_TRAIT(target_cat, TRAIT_CATLIKE_INSTINCT) || target_cat.is_blind() || target_cat.incapacitated)
			continue
		target_cat.setDir(get_dir(target_cat, targloc)) // kitty always looks at the light
		if(target_cat.body_position == STANDING_UP)
			if(prob(effectchance * diode.rating))
				target_cat.visible_message(span_warning("[target_cat]扑向了光点！"), span_userdanger("光！"))
				target_cat.Move(targloc, get_dir(target_cat, targloc))
				log_combat(user, target_cat, "moved with a laser pointer", src)
			else
				target_cat.visible_message(span_notice("[target_cat]似乎被光点吸引，短暂分了神。"), span_warning("你一时被闪亮的光点吸引了……"))
		else
			target_cat.visible_message(span_notice("[target_cat]盯着光点。"), span_warning("你盯着光点……"))
	//The pointer is shining, change its sprite to show
	icon_state = "pointer_[pointer_icon_state]"

	//setup pointer blip
	var/mutable_appearance/laser = mutable_appearance('icons/obj/weapons/guns/projectiles.dmi', pointer_icon_state)
	if(modifiers)
		if(LAZYACCESS(modifiers, ICON_X))
			laser.pixel_w = (text2num(LAZYACCESS(modifiers, ICON_X)) - 16)
		if(LAZYACCESS(modifiers, ICON_Y))
			laser.pixel_z = (text2num(LAZYACCESS(modifiers, ICON_Y)) - 16)
	else
		laser.pixel_w = target.pixel_w + rand(-5,5)
		laser.pixel_z = target.pixel_z + rand(-5,5)

	if(outmsg)
		user.visible_message(span_danger("[user]把[src]对准了[target]！"), outmsg) //SKYRAT EDIT CHANGE - ORIGINAL: to_chat(user, outmsg)
	else
		to_chat(user, span_info("你把[src]对准了[target]。"))

	//we have successfully shone our pointer, reduce our battery depending on whether we have an extra lens or not
	energy -= crystal_lens ? 2 : 1
	if(energy <= max_energy) //normal recharge, does not stop us from using the pointer
		if(!recharging)
			recharging = TRUE
			START_PROCESSING(SSobj, src)
		if(energy <= 0) //battery is completely dry, recharge the pointer to full then let us use it again
			to_chat(user, span_warning("[src]的电池使用过度，需要时间充电！"))
			recharge_locked = TRUE

	//flash a pointer blip at the target
	target.flick_overlay_view(laser, 1 SECONDS)
	//reset pointer sprite
	icon_state = "pointer"

/obj/item/laser_pointer/process(seconds_per_tick)
	if(isnull(diode))
		recharging = FALSE
		return PROCESS_KILL
	if(SPT_PROB(10 + diode.rating * 10, seconds_per_tick)) //+10% chance per diode tier to recharge one use per process
		energy += 1
		if(energy >= max_energy)
			energy = max_energy
			recharging = FALSE
			recharge_locked = FALSE
			return ..()
