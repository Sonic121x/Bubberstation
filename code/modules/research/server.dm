/// Default master server machine state. Use a special screwdriver to get to the next state.
#define HDD_PANEL_CLOSED 0
/// Front master server HDD panel has been removed. Use a special crowbar to get to the next state.
#define HDD_PANEL_OPEN 1
/// Master server HDD has been pried loose and is held in by only cables. Use a special set of wirecutters to finish stealing the objective.
#define HDD_PRIED 2
/// Master server HDD has been cut loose.
#define HDD_CUT_LOOSE 3
/// The ninja has blown the HDD up.
#define HDD_OVERLOADED 4

#define SERVER_NOMINAL_TEXT "正常"

/obj/machinery/rnd/server
	name = "\improper 研发服务器"
	desc = "一套运行深度神经网络的计算机系统，能处理任意信息并产出可用于开发新技术的可用数据。用通俗的话说，它能产出研究点。"
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "RD-server-on"
	base_icon_state = "RD-server"
	circuit = /obj/item/circuitboard/machine/rdserver
	req_access = list(ACCESS_RD)

	/// if TRUE, we are currently operational and giving out research points.
	var/working = TRUE
	/// if TRUE, someone manually disabled us via console.
	var/research_disabled = FALSE

/obj/machinery/rnd/server/Initialize(mapload)
	. = ..()
	//servers handle techwebs differently as we are expected to be there to connect
	//every other machinery on-station.
	if(!stored_research)
		if(CONFIG_GET(flag/no_default_techweb_link))
			stored_research = new /datum/techweb
		else
			var/datum/techweb/science_web = locate(/datum/techweb/science) in SSresearch.techwebs
			connect_techweb(science_web)
	stored_research.techweb_servers |= src
	name += " [num2hex(rand(1,65535), -1)]" //gives us a random four-digit hex number as part of the name. Y'know, for fluff.

/obj/machinery/rnd/server/Destroy()
	if(stored_research)
		stored_research.techweb_servers -= src
	if(CONFIG_GET(flag/no_default_techweb_link))
		QDEL_NULL(stored_research)
	return ..()

/obj/machinery/rnd/server/update_icon_state()
	. = ..()
	if(machine_stat & NOPOWER)
		icon_state = "[base_icon_state]-off"
	else if(panel_open)
		icon_state = "[base_icon_state]-on" + "_t"
	else
		// "working" will cover EMP'd, disabled, or just broken
		icon_state = "[base_icon_state]-[working ? "on" : "halt"]"

/obj/machinery/rnd/server/power_change()
	refresh_working()
	return ..()

/obj/machinery/rnd/server/on_set_machine_stat()
	refresh_working()
	return ..()

/// Checks if we should be working or not, and updates accordingly.
/obj/machinery/rnd/server/proc/refresh_working()
	if(machine_stat & (NOPOWER|EMPED) || research_disabled)
		working = FALSE
	else
		working = TRUE

	update_current_power_usage()
	update_appearance(UPDATE_ICON_STATE)

/obj/machinery/rnd/server/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	set_machine_stat(machine_stat | EMPED)
	addtimer(CALLBACK(src, PROC_REF(fix_emp)), 60 SECONDS)
	refresh_working()

/// Callback to un-emp the server afetr some time.
/obj/machinery/rnd/server/proc/fix_emp()
	set_machine_stat(machine_stat & ~EMPED)
	refresh_working()

/// Toggles whether or not researched_disabled is, yknow, disabled
/obj/machinery/rnd/server/proc/toggle_disable(mob/user)
	research_disabled = !research_disabled
	user.log_message("[research_disabled ? "关闭了" : "开启了"] [src]", LOG_GAME)
	refresh_working()

/// Gets status text based on this server's status for the computer.
/obj/machinery/rnd/server/proc/get_status_text()
	if(machine_stat & EMPED)
		return "O&F@I*$ - R3*&O$T R@U!R%D"
	else if(machine_stat & NOPOWER)
		return "离线——服务器断电"
	else if(research_disabled)
		return "离线——服务器控制已禁用"
	else if(!working)
		// If, for some reason, working is FALSE even though we're not emp'd or powerless,
		// We need something to update our working state - such as rebooting the server
		return "离线——需要重启"

	return SERVER_NOMINAL_TEXT

/obj/machinery/rnd/server/multitool_act(mob/living/user, obj/item/multitool/tool)
	if(!stored_research)
		return
	tool.set_buffer(stored_research)
	balloon_alert(user, "已保存至多功能工具缓冲区")
	return TRUE

/// Master R&D server. As long as this still exists and still holds the HDD for the theft objective, research points generate at normal speed. Destroy it or an antag steals the HDD? Half research speed.
/obj/machinery/rnd/server/master
	max_integrity = 1800 //takes roughly ~15s longer to break then full deconstruction.
	circuit = null
	var/obj/item/disk/computer/hdd_theft/source_code_hdd
	var/deconstruction_state = HDD_PANEL_CLOSED
	var/front_panel_screws = 4
	var/hdd_wires = 6

/obj/machinery/rnd/server/master/Initialize(mapload)
	. = ..()
	name = "\improper 主控 " + name
	desc += "\n它看起来极其坚固，难以损坏！"
	source_code_hdd = new(src)

	add_overlay("RD-server-objective-stripes")

/obj/machinery/rnd/server/master/Destroy()
	QDEL_NULL(source_code_hdd)
	return ..()

/obj/machinery/rnd/server/master/get_status_text()
	. = ..()
	// Give us a special message if we're nominal, but our hard drive is gone
	if(. == SERVER_NOMINAL_TEXT && !source_code_hdd)
		return "<font color=orange>正常——硬盘缺失</font>"

/obj/machinery/rnd/server/master/examine(mob/user)
	. = ..()

	switch(deconstruction_state)
		if(HDD_PANEL_CLOSED)
			. += "前面板已关闭。你能看到一些凹槽，里面可能有<b>螺丝</b>。"
		if(HDD_PANEL_OPEN)
			. += "前面板悬开着。硬盘装在一个牢固的外壳里。看来你得把它<b>撬</b>下来。"
		if(HDD_PRIED)
			. += "前面板悬开着。硬盘已被从外壳中撬出。它仍通过<b>线缆</b>连接着。"
		if(HDD_CUT_LOOSE)
			. += "前面板悬开着。里面只能看到被剪断的线缆和扭曲的金属。"
		if(HDD_OVERLOADED)
			. += "前面板悬开着。里面的硬盘已被摧毁，线缆也全部烧毁。"

/obj/machinery/rnd/server/master/tool_act(mob/living/user, obj/item/tool, list/modifiers)
	if(!tool.tool_behaviour)
		return ..()
	// Only antags are given the training and knowledge to disassemble this thing.
	if(!user.is_antag())
		if(user.combat_mode)
			return ITEM_INTERACT_SKIP_TO_ATTACK
		balloon_alert(user, "你找不到明显的维护舱口！")
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/machinery/rnd/server/master/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/disk/computer/hdd_theft))
		return NONE
	switch(deconstruction_state)
		if(HDD_PANEL_CLOSED)
			balloon_alert(user, "你找不到插入它的地方！")
		if(HDD_PANEL_OPEN)
			balloon_alert(user, "你没有接受过安装这个的训练！")
		if(HDD_PRIED)
			balloon_alert(user, "硬盘外壳已完全损坏，装不进去！")
		if(HDD_CUT_LOOSE)
			balloon_alert(user, "硬盘外壳已完全损坏，所有线缆都被剪断了！")
		if(HDD_OVERLOADED)
			balloon_alert(user, "内部已烧焦，所有线缆都已烧毁！")
	return ITEM_INTERACT_BLOCKING

/obj/machinery/rnd/server/master/screwdriver_act(mob/living/user, obj/item/tool)
	if(deconstruction_state != HDD_PANEL_CLOSED || user.combat_mode)
		return NONE

	to_chat(user, span_notice("你能看到 [front_panel_screws] 颗螺丝。你开始拧下[front_panel_screws == 1 ? "它" : "它们"]……"))
	while(tool.use_tool(src, user, 7.5 SECONDS, volume=100))
		front_panel_screws--
		if(front_panel_screws > 0)
			to_chat(user, span_notice("你拧下螺丝时它断裂了。还剩 [front_panel_screws] 颗……"))
			continue
		deconstruction_state = HDD_PANEL_OPEN
		to_chat(user, span_notice("你拧下了 [src] 前面板上的最后一颗螺丝。"))
		add_overlay("RD-server-hdd-panel-open")
		break
	return ITEM_INTERACT_SUCCESS

/obj/machinery/rnd/server/master/crowbar_act(mob/living/user, obj/item/tool)
	if(deconstruction_state != HDD_PANEL_OPEN || user.combat_mode)
		return FALSE

	to_chat(user, span_notice("你能看到 [source_code_hdd] 装在前面板后的牢固外壳中。你开始把它撬松……"))
	if(tool.use_tool(src, user, 15 SECONDS, volume=100))
		to_chat(user, span_notice("你破坏了外壳，把 [source_code_hdd] 撬了出来。"))
		deconstruction_state = HDD_PRIED
	return TRUE

/obj/machinery/rnd/server/master/wirecutter_act(mob/living/user, obj/item/tool)
	if(deconstruction_state != HDD_PRIED || user.combat_mode)
		return FALSE

	to_chat(user, span_notice("有 [hdd_wires] 根线缆连接着 [source_code_hdd]。你开始剪断[hdd_wires == 1 ? "它" : "它们"]……"))
	while(tool.use_tool(src, user, 7.5 SECONDS, volume=100))
		hdd_wires--

		if(hdd_wires <= 0)
			deconstruction_state = HDD_CUT_LOOSE
			to_chat(user, span_notice("你剪断了最后一根线，并取下了 [source_code_hdd]。"))
			try_put_in_hand(source_code_hdd, user)
			source_code_hdd = null
			stored_research.income_modifier *= 0.5
			return TRUE
		to_chat(user, span_notice("你小心翼翼地剪断了一根线。还剩 [hdd_wires] 根……"))
	return TRUE

/obj/machinery/rnd/server/master/on_deconstruction(disassembled)
	// If the machine contains a source code HDD, destroying it will negatively impact research speed. Safest to log this.
	if(source_code_hdd)
		// Destroyed with a hard drive inside = harm income
		stored_research.income_modifier *= 0.5
		// If there's a usr, this was likely a direct deconstruction of some sort. Extra logging info!
		if(usr)
			var/mob/user = usr

			message_admins("[ADMIN_LOOKUPFLW(user)] 拆解了 [ADMIN_JMP(src)]。")
			user.log_message("拆解了 [src]。", LOG_GAME)
			return ..()

		message_admins("[ADMIN_JMP(src)] 被未知用户拆解了。")
		log_game("[src] 被未知用户拆解了。")

	return ..()

/// Destroys the source_code_hdd if present and sets the machine state to overloaded, adding the panel open overlay if necessary.
/obj/machinery/rnd/server/master/proc/overload_source_code_hdd()
	if(source_code_hdd)
		QDEL_NULL(source_code_hdd)
		// Overloaded = harm income
		stored_research.income_modifier *= 0.5

	if(deconstruction_state == HDD_PANEL_CLOSED)
		add_overlay("RD-server-hdd-panel-open")

	front_panel_screws = 0
	hdd_wires = 0
	deconstruction_state = HDD_OVERLOADED

#undef HDD_CUT_LOOSE
#undef HDD_OVERLOADED
#undef HDD_PANEL_CLOSED
#undef HDD_PANEL_OPEN
#undef HDD_PRIED
#undef SERVER_NOMINAL_TEXT
