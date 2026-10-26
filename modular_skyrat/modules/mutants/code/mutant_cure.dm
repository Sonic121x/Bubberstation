/obj/item/rna_extractor
	name = "高级病毒RNA提取器"
	desc = "用于提取病毒RNA的工具。对皮肤使用。"
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "extractor"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	/// Our loaded vial.
	var/obj/item/rna_vial/loaded_vial

/obj/item/rna_extractor/attackby(obj/item/O, mob/living/user)
	if((istype(O, /obj/item/rna_vial) && loaded_vial != null))
		to_chat(user, span_warning("[src]只能容纳一支样本瓶！"))
		return FALSE
	if(istype(O, /obj/item/rna_vial))
		if(!user.transferItemToLoc(O, src))
			return FALSE
		to_chat(user, span_notice("你将[O]插入[src]！"))
		loaded_vial = O
		playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)
		update_appearance()

/obj/item/rna_extractor/attack_self(mob/living/user)
	if(user.incapacitated)
		return
	unload_vial(user)

/obj/item/rna_extractor/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!ishuman(interacting_with))
		return
	var/mob/living/carbon/human/target = interacting_with
	if(!loaded_vial)
		to_chat(user, span_danger("[src]是空的！"))
		return
	if(loaded_vial.contains_rna)
		to_chat(user, span_danger("[src]中已有RNA数据，请先将其上传至重组机！"))
		return
	if(!ismutant(target))
		to_chat(user, span_danger("未检测到[target]受到感染！"))
		return
	var/datum/component/mutant_infection/target_infection = target.GetComponent(/datum/component/mutant_infection)
	if(!target_infection)
		to_chat(user, span_danger("未检测到[target]受到感染！"))
		return
	if(target_infection.extract_rna())
		loaded_vial.load_rna(target)
		to_chat(user, span_notice("[src]成功扫描了[target]，现已存有一份病毒RNA样本数据。"))
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
		update_appearance()
	else
		to_chat(user, span_warning("[target]没有可用的RNA！"))

/obj/item/rna_extractor/proc/unload_vial(mob/living/user)
	if(loaded_vial)
		loaded_vial.forceMove(user.loc)
		user.put_in_hands(loaded_vial)
		to_chat(user, span_notice("你从[src]中取出了[loaded_vial]。"))
		loaded_vial = null
		update_appearance()
		playsound(loc, 'sound/items/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("[src]尚未装载！"))
		return

/obj/item/rna_extractor/update_overlays()
	. = ..()
	if(loaded_vial)
		. += "extractor_load"

/obj/item/rna_extractor/examine(mob/user)
	. = ..()
	if(loaded_vial)
		. += "里面装有已提取的RNA样本。"

/obj/item/rna_extractor/Destroy()
	if(loaded_vial)
		loaded_vial.forceMove(loc)
		loaded_vial = null
	. = ..()

/obj/item/rna_vial
	name = "原始RNA样本瓶"
	desc = "一支装有原始病毒RNA的玻璃样本瓶。将其插入重组机即可上传样本。"
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "rnavial"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	var/contains_rna = FALSE

/obj/item/rna_vial/proc/load_rna(mob/living/carbon/human/H)
	contains_rna = TRUE
	update_appearance()

/obj/item/rna_vial/update_overlays(updates)
	. = ..()
	if(contains_rna)
		. += "rnavial_load"

/obj/item/rna_vial/examine(mob/user)
	. = ..()
	if(contains_rna)
		. += "里面装有RNA样本。"

/obj/item/hnz_cure
	name = "HNZ-1解药瓶"
	desc = "HNZ-1病毒的解药，用于迅速逆转病毒的影响。"
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "tvirus_cure"
	var/used = FALSE

/obj/item/hnz_cure/attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(used)
		to_chat(user, span_danger("[src]已经用过，无法再使用！"))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.GetComponent(/datum/component/mutant_infection))
			to_chat(user, span_danger("未检测到[H]受到感染！"))
			return
		if(do_after(user, 4 SECONDS))
			cure_target(H)
			playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
			to_chat(user, span_notice("你用[src]为[H]注射了解药！"))
			used = TRUE
			update_appearance()

/obj/item/hnz_cure/update_icon_state()
	. = ..()
	if(used)
		icon_state = "tvirus_used"

/obj/item/hnz_cure/proc/cure_target(mob/target)
	SIGNAL_HANDLER

	SEND_SIGNAL(target, COMSIG_MUTANT_CURED)


#define STATUS_IDLE "System Idle"
#define STATUS_RECOMBINATING_VIRUS "System Synthesising Virus"
#define STATUS_RECOMBINATING_CURE "System Synthesising Cure"
#define RECOMBINATION_STEP_TIME (15 SECONDS)
#define RECOMBINATION_STEP_AMOUNT 25

/obj/machinery/rnd/rna_recombinator
	name = "RNA重组机"
	desc = "这台机器用于重组从原始病毒样本瓶中提取的RNA序列。"
	icon = 'modular_skyrat/modules/mutants/icons/cure_machine.dmi'
	icon_state = "h_lathe"
	base_icon_state = "h_lathe"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/rna_recombinator
	var/status = STATUS_IDLE
	var/recombination_step_amount = RECOMBINATION_STEP_AMOUNT
	var/recombination_step_time = RECOMBINATION_STEP_TIME
	var/cure_progress = 0
	var/timer_id

/obj/machinery/rnd/rna_recombinator/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	. = ..()

/obj/machinery/rnd/rna_recombinator/attackby(obj/item/weapon, mob/living/user, params)
	if(user.combat_mode)
		return FALSE
	if(!is_insertion_ready(user))
		return FALSE
	if(!istype(weapon, /obj/item/rna_vial))
		return FALSE
	if(!user.transferItemToLoc(weapon, src))
		return FALSE
	loaded_item = weapon
	to_chat(user, span_notice("你将[weapon]插入[src]的容纳槽。"))
	flick("h_lathe_load", src)
	update_appearance()
	playsound(loc, 'sound/items/weapons/autoguninsert.ogg', 35, 1)


/obj/machinery/rnd/rna_recombinator/ui_interact(mob/user)
	var/obj/item/rna_vial/vial = loaded_item
	var/list/dat = list("<center>")
	dat += "<b>系统状态：[chinese_skyrat_item_label(status)]</b>"
	dat += "系统效率——单步耗时：[recombination_step_time / 10]秒 | 单步进度：[recombination_step_amount]%"
	if(status != STATUS_IDLE)
		dat += "<b>当前RNA重组进度：[cure_progress]%</b>"
	if(vial)
		dat += "<b>已装载RNA样本瓶：</b>[vial]"
		if(vial.contains_rna)
			dat += "<b>RNA结构：HNZ-1</b>"
			dat += "<b><a href='byond://?src=[REF(src)];item=[REF(loaded_item)];function=cure'>合成解药</A></b>"
			dat += "<b><a href='byond://?src=[REF(src)];item=[REF(loaded_item)];function=virus'>合成病毒</A></b>"
		else
			dat += "RNA结构：<b>错误，无RNA</b>"
		dat += "<b><a href='byond://?src=[REF(src)];function=eject'>弹出</A></b>"
	else
		dat += "<b>未装载任何物品。</b>"
	dat += "<a href='byond://?src=[REF(src)];function=refresh'>刷新</A>"
	dat += "<a href='byond://?src=[REF(src)];close=1'>关闭</A></center>"
	var/datum/browser/popup = new(user, "rna_recombinator","RNA重组机", 700, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "rna_recombinator")

/obj/machinery/rnd/rna_recombinator/Topic(href, href_list)
	if(..())
		return
	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	var/operation = href_list["function"]
	var/obj/item/process = locate(href_list["item"]) in src

	if(href_list["close"])
		usr << browse(null, "window=rna_recombinator")
		return
	else if(operation == "eject")
		ejectItem()
	else if(operation == "refresh")
		SStgui.update_uis(src)
	else
		if(status != STATUS_IDLE)
			to_chat(usr, span_warning("[src]正在进行重组！"))
		else if(!loaded_item)
			to_chat(usr, span_warning("[src]尚未装载！"))
		else if(!process || process != loaded_item) //Interface exploit protection (such as hrefs or swapping items with interface set to old item)
			to_chat(usr, span_danger("检测到[src]界面故障，请重试。"))
		else
			if(operation == "virus")
				status = STATUS_RECOMBINATING_VIRUS
			else
				status = STATUS_RECOMBINATING_CURE
			recombinate_start()
			use_energy(3000 JOULES)

	SStgui.update_uis(src)

/obj/machinery/rnd/rna_recombinator/proc/ejectItem()
	if(loaded_item)
		var/turf/dropturf = get_turf(pick(view(1,src)))
		if(!dropturf) //Failsafe to prevent the object being lost in the void forever.
			dropturf = drop_location()
		loaded_item.forceMove(dropturf)
		loaded_item = null

/obj/machinery/rnd/rna_recombinator/proc/recombinate_start()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	var/obj/item/rna_vial/vial = loaded_item
	vial.contains_rna = FALSE
	vial.update_appearance()
	ejectItem()
	playsound(loc, 'sound/items/tools/rped.ogg', 60, 1)
	flick("h_lathe_wloop", src)
	use_energy(3000 JOULES)
	timer_id = addtimer(CALLBACK(src, PROC_REF(recombinate_step)), recombination_step_time, TIMER_STOPPABLE)

/obj/machinery/rnd/rna_recombinator/proc/recombinate_step()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	cure_progress += recombination_step_amount
	if(cure_progress >= 100)
		recombinate_finish()
		return
	flick("h_lathe_wloop", src)
	use_energy(3000 JOULES)
	playsound(loc, 'sound/items/tools/rped.ogg', 60, 1)
	timer_id = addtimer(CALLBACK(src, PROC_REF(recombinate_step)), recombination_step_time, TIMER_STOPPABLE)

/obj/machinery/rnd/rna_recombinator/proc/recombinate_finish()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	cure_progress = 0
	if(status == STATUS_RECOMBINATING_CURE)
		new /obj/item/hnz_cure(get_turf(src))
		new /obj/item/hnz_cure(get_turf(src))
		new /obj/item/hnz_cure(get_turf(src))
	else
		new /obj/item/reagent_containers/cup/bottle/hnz/one(get_turf(src))
	flick("h_lathe_leave", src)
	use_energy(3000 JOULES)
	playsound(loc, 'sound/machines/ding.ogg', 60, 1)
	status = STATUS_IDLE

/obj/machinery/rnd/rna_recombinator/RefreshParts()
	. = ..()
	for(var/datum/stock_part/servo/servo in component_parts)
		if(recombination_step_time > 0 && (recombination_step_time - servo.tier) >= 1)
			recombination_step_time -= servo.tier
	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		recombination_step_amount += scanning_module.tier * 2
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		recombination_step_amount += micro_laser.tier

/obj/machinery/rnd/rna_recombinator/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN|MAINT) || !loaded_item)
		. += "lathe_empty"

#undef STATUS_IDLE
#undef STATUS_RECOMBINATING_CURE
#undef STATUS_RECOMBINATING_VIRUS
#undef RECOMBINATION_STEP_TIME
#undef RECOMBINATION_STEP_AMOUNT

/*
*	Infection stuff
*	You didn't think I wouldn't include this did you?
*/

/datum/reagent/hnz
	name = "HNZ-1"
	description = "HNZ-1是一种处于高度试验阶段的病毒性生物恐怖制剂，\
		会在受试者的大脑灰质中\
		形成休眠结节。这些结节仅在宿主\
		死亡后才会激活，随后次生结构启动并夺取\
		宿主身体的控制权。"
	color = "#191dff"
	metabolization_rate = INFINITY
	taste_description = "脑髓"
	ph = 0.5

/datum/reagent/hnz/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	try_to_mutant_infect(exposed_mob, TRUE)

/obj/item/reagent_containers/cup/bottle/hnz
	name = "HNZ-1瓶"
	desc = "一小瓶HNZ-1病原体。纳米传讯生物武器公司出品。"
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "tvirus_infector"
	list_reagents = list(/datum/reagent/hnz = 30)
	custom_materials = list(
		/datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/reagent_containers/cup/bottle/hnz/one
	list_reagents = list(/datum/reagent/hnz = 1)


/obj/item/storage/briefcase/virology/hnz
	name = "\improper HNZ-1生物容器"
	desc = "一个密封的生物安全箱，内装高度活跃的物质HNZ-1。仅限授权人员使用。"
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 500

/obj/item/storage/briefcase/virology/hnz/PopulateContents()
	new /obj/item/reagent_containers/cup/bottle/hnz/one(src)
	new /obj/item/reagent_containers/cup/bottle/hnz/one(src)
	new /obj/item/circuitboard/machine/rna_recombinator(src)
	new /obj/item/rna_extractor(src)
	new /obj/item/rna_vial(src)
