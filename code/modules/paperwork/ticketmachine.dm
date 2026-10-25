//Bureaucracy machine!
//Simply set this up in the hopline and you can serve people based on ticket numbers

/obj/machinery/ticket_machine
	name = "叫号机"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "ticketmachine"
	base_icon_state = "ticketmachine"
	desc = "官僚工程学的一大杰作，外壳采用高效的塑料材质。可用手持标签机补充卷补充票纸，并用多功能工具与按钮联动。"
	density = FALSE
	maptext_height = 26
	maptext_width = 32
	maptext_x = 7
	maptext_y = 10
	layer = HIGH_OBJ_LAYER
	///Increment the ticket number whenever the HOP presses his button
	var/ticket_number = 0
	///What ticket number are we currently serving?
	var/current_number = 0
	///At this point, you need to refill it.
	var/max_number = 100
	var/cooldown = 5 SECONDS
	var/ready = TRUE
	var/id = "ticket_machine_default" //For buttons
	var/list/ticket_holders = list()
	///List of tickets that exist currently
	var/list/obj/item/ticket_machine_ticket/tickets = list()
	///Current ticket to be served, essentially the head of the tickets queue
	var/obj/item/ticket_machine_ticket/current_ticket

/obj/machinery/ticket_machine/Initialize(mapload)
	. = ..()
	update_appearance()
	if(mapload)
		find_and_mount_on_atom()

/obj/machinery/ticket_machine/Destroy()
	for(var/obj/item/ticket_machine_ticket/ticket in tickets)
		ticket.source = null
	tickets.Cut()
	return ..()

/obj/machinery/ticket_machine/on_deconstruction(disassembled = TRUE)
	new /obj/item/wallframe/ticket_machine(loc)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/ticket_machine, 32)

/obj/machinery/ticket_machine/examine(mob/user)
	. = ..()
	. += span_notice("叫号机显示当前正在办理第 [current_number] 号。")
	. += span_notice("用<b>左键点击</b>可以取一张票，你将排在第 [ticket_number + 1] 位。")

/obj/machinery/ticket_machine/multitool_act(mob/living/user, obj/item/multitool/M)
	M.set_buffer(src)
	balloon_alert(user, "已存入多功能工具缓冲区")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/ticket_machine/emag_act(mob/user, obj/item/card/emag/emag_card) //Emag the ticket machine to dispense burning tickets, as well as randomize its number to destroy the HoP's mind.
	if(obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "官僚噩梦已启动")
	ticket_number = rand(0,max_number)
	current_number = ticket_number
	obj_flags |= EMAGGED
	if(tickets.len)
		for(var/obj/item/ticket_machine_ticket/ticket in tickets)
			ticket.audible_message(span_notice("\the [ticket] 消散了！"), hearing_distance = SAMETILE_MESSAGE_RANGE)
			qdel(ticket)
		tickets.Cut()
	update_appearance()
	return TRUE

/obj/item/wallframe/ticket_machine
	name = "叫号机框架"
	desc = "一台尚未安装的叫号机。把它装到墙上即可使用。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "ticketmachine_off"
	result_path = /obj/machinery/ticket_machine
	pixel_shift = 32
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 4)

///Increments the counter by one, if there is a ticket after the current one we are serving.
///If we have a current ticket, remove it from the top of our tickets list and replace it with the next one if applicable
/obj/machinery/ticket_machine/proc/increment()
	if(!(obj_flags & EMAGGED) && current_ticket)
		current_ticket.audible_message(span_notice("\the [current_ticket] 消散了！"), hearing_distance = SAMETILE_MESSAGE_RANGE)
		tickets.Cut(1,2)
		QDEL_NULL(current_ticket)
	if(LAZYLEN(tickets))
		current_ticket = tickets[1]
		current_number = current_ticket.number //Destroyed tickets are removed from the queue, so the next ticket's number may have skipped ahead.
		playsound(src, 'sound/announcer/announcement/announce_dig.ogg', 50, FALSE)
		say("现在叫号：[current_ticket]！")
		if(!(obj_flags & EMAGGED))
			current_ticket.audible_message(span_notice("\the [current_ticket] 震动了！"), hearing_distance = SAMETILE_MESSAGE_RANGE)
		update_appearance() //Update our icon here rather than when they take a ticket to show the current ticket number being served

/obj/machinery/button/ticket_machine
	name = "叫号机计数器按钮"
	desc = "接待完一个人后按下这个按钮，通知下一位上前。"
	device_type = /obj/item/assembly/control/ticket_machine
	req_access = list()
	id = "ticket_machine_default"

/obj/machinery/button/ticket_machine/Initialize(mapload)
	. = ..()
	if(device)
		var/obj/item/assembly/control/ticket_machine/ours = device
		ours.id = id

/obj/machinery/button/ticket_machine/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(I.tool_behaviour == TOOL_MULTITOOL)
		var/obj/item/multitool/M = I
		if(M.buffer && !istype(M.buffer, /obj/machinery/ticket_machine))
			return
		var/obj/item/assembly/control/ticket_machine/controller = device
		controller.ticket_machine_ref = WEAKREF(M.buffer)
		id = null
		controller.id = null
		to_chat(user, span_warning("你把 [src] 连接到了 [M.buffer]。"))

/obj/item/assembly/control/ticket_machine
	name = "叫号机控制器"
	desc = "用于遥控人事主管叫号机的装置。"
	///Weakref to our ticket machine
	var/datum/weakref/ticket_machine_ref

/obj/item/assembly/control/ticket_machine/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/item/assembly/control/ticket_machine/LateInitialize()
	find_machine()

/// Locate the ticket machine to which we're linked by our ID
/obj/item/assembly/control/ticket_machine/proc/find_machine()
	for(var/obj/machinery/ticket_machine/ticketsplease as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/ticket_machine))
		if(ticketsplease.id == id)
			ticket_machine_ref = WEAKREF(ticketsplease)
	if(ticket_machine_ref)
		return TRUE
	else
		return FALSE

/obj/item/assembly/control/ticket_machine/activate(mob/activator)
	if(cooldown)
		return
	if(!ticket_machine_ref)
		return
	var/obj/machinery/ticket_machine/machine = ticket_machine_ref.resolve()
	if(!machine)
		return
	cooldown = TRUE
	machine.increment()
	if(isnull(machine.current_ticket))
		to_chat(activator, span_notice("按钮指示灯表明已经没有待处理的号码了。"))
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS)

/obj/machinery/ticket_machine/update_icon()
	. = ..()
	handle_maptext()

/obj/machinery/ticket_machine/update_icon_state()
	switch(ticket_number) //Gives you an idea of how many tickets are left
		if(0 to 99)
			icon_state = "[base_icon_state]"
		if(100)
			icon_state = "[base_icon_state]_empty"
	return ..()

/obj/machinery/ticket_machine/proc/handle_maptext()
	switch(current_number) //This is here to handle maptext offsets so that the numbers align.
		if(0 to 9)
			maptext_x = 9
		if(10 to 99)
			maptext_x = 6
		if(100)
			maptext_x = 4
	maptext = MAPTEXT(current_number) //Finally, apply the maptext

/obj/machinery/ticket_machine/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/hand_labeler_refill))
		return NONE

	if(!(ticket_number >= max_number))
		to_chat(user, span_notice("[src] 拒绝了 [tool]！里面还剩 [max_number - ticket_number] 张号码票！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你开始为 [src] 补充票纸（这样做会重置票号计数！）。"))
	if(!do_after(user, 3 SECONDS, target = src))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把 [tool] 塞进 [src]，机器含糊不清地嗡嗡作响。"))
	qdel(tool)
	ticket_number = 0
	current_number = 0
	if(tickets.len)
		for(var/obj/item/ticket_machine_ticket/ticket in tickets)
			ticket.audible_message(span_notice("\the [ticket] 消散了！"), hearing_distance = SAMETILE_MESSAGE_RANGE)
			qdel(ticket)
		tickets.Cut()
	max_number = initial(max_number)
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/ticket_machine/proc/reset_cooldown()
	ready = TRUE

/obj/machinery/ticket_machine/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	if(!ready)
		to_chat(user,span_warning("你按下按钮，但什么也没发生……"))
		return
	if(ticket_number >= max_number)
		to_chat(user,span_warning("票纸已用尽，请用标签机补充卷补充本机！"))
		return
	var/user_ref = REF(user)
	if((user_ref in ticket_holders) && !(obj_flags & EMAGGED))
		to_chat(user, span_warning("你已经有一张号码票了！"))
		return
	playsound(src, 'sound/machines/terminal/terminal_insert_disc.ogg', 100, FALSE)
	ticket_number++
	to_chat(user, span_notice("你从 [src] 取了一张号码票，看来你排在第 [ticket_number] 位……"))
	var/obj/item/ticket_machine_ticket/theirticket = new (get_turf(src), ticket_number)
	theirticket.source = src
	theirticket.owner_ref = user_ref
	user.put_in_hands(theirticket)
	ticket_holders += user_ref
	tickets += theirticket
	if(obj_flags & EMAGGED) //Emag the machine to destroy the HOP's life.
		ready = FALSE
		addtimer(CALLBACK(src, PROC_REF(reset_cooldown)), cooldown)//Small cooldown to prevent piles of flaming tickets
		theirticket.fire_act()
		user.dropItemToGround(theirticket)
		user.adjust_fire_stacks(1)
		user.ignite_mob()
	update_appearance()

/obj/item/ticket_machine_ticket
	name = "\improper 号码票"
	desc = "一张显示你在人事主管队伍中排位的号码票。采用纳米传讯专利的 NanoPaper® 材质制成。虽然是实体，它的外形却似乎微微闪烁。手感和燃烧表现都与真品别无二致。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "ticket"
	maptext_x = 7
	maptext_y = 10
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	max_integrity = 50
	var/number
	var/saved_maptext = null
	var/owner_ref // A ref to our owner. Doesn't need to be weak because mobs have unique refs
	var/obj/machinery/ticket_machine/source

/obj/item/ticket_machine_ticket/Initialize(mapload, num)
	. = ..()
	number = num
	if(!isnull(num))
		name += " #[num]"
		saved_maptext = MAPTEXT(num)
		maptext = saved_maptext
	AddElement(/datum/element/burn_on_item_ignition)

/obj/item/ticket_machine_ticket/examine(mob/user)
	. = ..()
	if(!isnull(number))
		. += span_notice("号码票上闪烁着文字，告诉你排在第 [number] 位。")
		if(source)
			. += span_notice("再往下还能看到，你距离被叫到还差 [number - source.current_number] 个号。")

/obj/item/ticket_machine_ticket/attack_hand(mob/user, list/modifiers)
	. = ..()
	maptext = saved_maptext //For some reason, storage code removes all maptext off objs, this stops its number from being wiped off when taken out of storage.

/obj/item/ticket_machine_ticket/Destroy()
	if(source)
		source.ticket_holders -= owner_ref
		source.tickets -= src
		if(source.current_ticket == src)
			source.current_ticket = null
		source = null
	return ..()
