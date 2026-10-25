/obj/machinery/dna_scannernew
	name = "\improper DNA 扫描仪"
	desc = "用于扫描 DNA 结构。"
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "scanner"
	base_icon_state = "scanner"
	density = TRUE
	obj_flags = BLOCKS_CONSTRUCTION // Becomes undense when the door is open
	interaction_flags_mouse_drop = NEED_DEXTERITY
	occupant_typecache = list(/mob/living, /obj/item/bodypart/head, /obj/item/organ/brain)
	circuit = /obj/item/circuitboard/machine/dnascanner

	var/locked = FALSE
	var/damage_coeff = 1
	var/scan_level
	var/precision_coeff = 1
	var/message_cooldown
	var/breakout_time = 120 SECONDS
	var/obj/machinery/computer/dna_console/linked_console = null

/obj/machinery/dna_scannernew/RefreshParts()
	. = ..()
	scan_level = 0
	damage_coeff = 0
	precision_coeff = 0
	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		scan_level += scanning_module.tier
	for(var/datum/stock_part/matter_bin/matter_bin in component_parts)
		precision_coeff = matter_bin.tier
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		damage_coeff = micro_laser.tier

/obj/machinery/dna_scannernew/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += span_notice("状态显示屏显示：辐射脉冲精度提高至 <b>[precision_coeff**2]</b> 倍。<br>辐射脉冲伤害降低至原来的 <b>1/[damage_coeff**2]</b>。")

/obj/machinery/dna_scannernew/update_icon_state()
	//no power or maintenance
	if(machine_stat & (NOPOWER|BROKEN))
		icon_state = "[base_icon_state][state_open ? "_open" : null]_unpowered"
		return ..()

	if((machine_stat & MAINT) || panel_open)
		icon_state = "[base_icon_state][state_open ? "_open" : null]_maintenance"
		return ..()

	//running and someone in there
	if(occupant)
		icon_state = "[base_icon_state]_occupied"
		return ..()

	//running
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/dna_scannernew/proc/toggle_open(mob/user)
	if(panel_open)
		to_chat(user, span_notice("请先关闭维护面板。"))
		return

	if(state_open)
		close_machine()
		return

	else if(locked)
		to_chat(user, span_notice("门闩已落下，将舱门牢牢锁住。"))
		return

	open_machine()

/obj/machinery/dna_scannernew/container_resist_act(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_PRIMITIVE) || user.ai_controller)
		if(locked)
			return //Your primitive brain cant escape a dna scanner noob
	else if(!locked) //Not locked and not primitive? escape immediately
		open_machine()

	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("你看见[user]正踢打[src]的舱门！"), \
		span_notice("你背靠[src]的后壁，开始用力推门……（大约需要[DisplayTimeText(breakout_time)]。）"), \
		span_hear("你听见[src]发出金属吱嘎声。"))
	if(do_after(user,(breakout_time), target = src))
		if(!user || IS_UNCONSCIOUS_OR_CRIT(user) || user.loc != src || state_open || !locked || HAS_TRAIT(user, TRAIT_PRIMITIVE) || user.ai_controller)
			return
		locked = FALSE
		user.visible_message(span_warning("[user]成功挣脱了[src]！"), \
			span_notice("你成功挣脱了[src]！"))
		open_machine()

/obj/machinery/dna_scannernew/proc/locate_computer(type_)
	for(var/direction in GLOB.cardinals)
		var/C = locate(type_, get_step(src, direction))
		if(C)
			return C
	return null

/obj/machinery/dna_scannernew/close_machine(mob/living/carbon/user, density_to_set = TRUE)
	if(!state_open)
		return FALSE

	..(user)

	// DNA manipulators cannot operate on severed heads or brains
	if(iscarbon(occupant))
		if(linked_console)
			linked_console.on_scanner_close()

	return TRUE

/obj/machinery/dna_scannernew/open_machine(drop = TRUE, density_to_set = FALSE)
	if(state_open)
		return FALSE
	if(locked) //haha bro u cant open it its locked xD
		return FALSE

	..()

	if(linked_console)
		linked_console.on_scanner_open()

	return TRUE


/obj/machinery/dna_scannernew/relaymove(mob/living/user, direction)
	if(IS_UNCONSCIOUS_OR_CRIT(user) || locked)
		if(message_cooldown <= world.time)
			message_cooldown = world.time + 50
			to_chat(user, span_warning("[src]的舱门纹丝不动！"))
		return
	open_machine()

/obj/machinery/dna_scannernew/screwdriver_act(mob/living/user, obj/item/tool)
	return occupant ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/dna_scannernew/crowbar_act(mob/living/user, obj/item/tool)
	return default_pry_open(user, tool, close_after_pry = FALSE, open_density = FALSE, closed_density = TRUE, deconstruct_on_fail = TRUE)

/obj/machinery/dna_scannernew/interact(mob/user)
	toggle_open(user)

/obj/machinery/dna_scannernew/mouse_drop_receive(atom/target, mob/user, params)
	if(!iscarbon(target))
		return
	close_machine(target)

//This is only called by the scanner. if you ever want to use this outside of that context you'll need to refactor things a bit
/obj/machinery/dna_scannernew/proc/set_linked_console(new_console)
	if(linked_console)
		UnregisterSignal(linked_console, COMSIG_QDELETING)
	linked_console = new_console
	if(linked_console)
		RegisterSignal(linked_console, COMSIG_QDELETING, PROC_REF(react_to_console_del))

/obj/machinery/dna_scannernew/proc/react_to_console_del(datum/source)
	SIGNAL_HANDLER
	set_linked_console(null)

//Just for transferring between genetics machines.
/obj/item/disk/data
	name = "\improper DNA 数据磁盘"
	icon_state = "datadisk0" //Gosh I hope syndies don't mistake them for the nuke disk.
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 0.5)
	var/list/genetic_makeup_buffer = list()
	var/list/mutations = list()
	var/max_mutations = 10
	read_only = FALSE //Well,it's still a floppy disk

/obj/item/disk/data/Initialize(mapload)
	. = ..()
	icon_state = "datadisk[rand(0,7)]"
	set_sticker_icon_state(pick("o_dna1", "o_dna2"))
	if(length(genetic_makeup_buffer))
		var/datum/blood_type = genetic_makeup_buffer["blood_type"]
		if(blood_type)
			blood_type = get_blood_type(blood_type) || random_human_blood_type()

/obj/item/disk/data/debug
	name = "\improper 中央指挥部 DNA 磁盘"
	desc = "用于遗传学的调试物品。"
	custom_materials = null

/obj/item/disk/data/debug/Initialize(mapload)
	. = ..()
	// Grabs all instances of mutations and adds them to the disk
	for(var/datum/mutation/mut as anything in subtypesof(/datum/mutation))
		var/datum/mutation/ref = GET_INITIALIZED_MUTATION(mut)
		mutations += ref
