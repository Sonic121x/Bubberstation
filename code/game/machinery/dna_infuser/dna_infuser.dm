/// how long it takes to infuse
#define INFUSING_TIME 4 SECONDS
/// we throw in a scream along the way.
#define SCREAM_TIME 3 SECONDS

/obj/machinery/dna_infuser
	name = "\improper DNA融合器"
	desc = "一种已被淘汰的遗传学设备，用于将外源DNA与受试者自身的DNA融合。"
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "infuser"
	base_icon_state = "infuser"
	density = TRUE
	obj_flags = BLOCKS_CONSTRUCTION // Becomes undense when the door is open
	interaction_flags_mouse_drop = NEED_HANDS | NEED_DEXTERITY
	circuit = /obj/item/circuitboard/machine/dna_infuser

	/// maximum tier this will infuse
	var/max_tier_allowed = DNA_MUTANT_TIER_ONE
	///currently infusing a vict- subject
	var/infusing = FALSE
	///what we're infusing with
	var/atom/movable/infusing_from
	///what we're turning into
	var/datum/infuser_entry/infusing_into
	///a message for relaying that the machine is locked if someone tries to leave while it's active
	COOLDOWN_DECLARE(message_cooldown)

/obj/machinery/dna_infuser/Initialize(mapload)
	. = ..()
	occupant_typecache = typecacheof(/mob/living/carbon/human)

/obj/machinery/dna_infuser/Destroy()
	. = ..()
	//dump_inventory_contents called by parent, emptying infusing_from
	infusing_into = null

/obj/machinery/dna_infuser/examine(mob/user)
	. = ..()
	if(!occupant)
		. += span_notice("需要[span_bold("一名受试者")]。")
	else
		. += span_notice("\"[span_bold(occupant.name)]\"位于融合舱内。")
	if(!infusing_from)
		. += span_notice("缺少[span_bold("融合源")]。")
	else
		. += span_notice("[span_bold(infusing_from.name)]位于融合槽内。")
	. += span_notice("操作方法：获取死亡生物，按其大小拖入或放入融合槽。")
	. += span_notice("受试者进入舱内，再由他人启动机器。瞧！你的一个器官……变了！")
	. += span_notice("Alt点击可弹出其中的融合源。")
	if(max_tier_allowed < DNA_INFUSER_MAX_TIER)
		. += span_boldnotice("DNA融合器目前最高只能融合[max_tier_allowed]级条目。")
	else
		. += span_boldnotice("已解锁最高等级，可融合所有DNA条目。")
	. += span_notice("进一步检查可获得更多信息。")

/obj/machinery/dna_infuser/examine_more(mob/user)
	. = ..()
	. += span_notice("持续融合[DNA_MUTANT_TIER_ONE]级条目直至解锁加成，即可提升最高等级，允许进行更复杂的融合。")
	. += span_notice("最高可提升至[DNA_INFUSER_MAX_TIER]级。")

/obj/machinery/dna_infuser/interact(mob/user)
	if(user == occupant)
		toggle_open(user)
		return
	if(infusing)
		balloon_alert(user, "运行时无法操作！")
		return
	if(occupant && infusing_from)
		if(!occupant.can_infuse(user))
			playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 35, vary = TRUE)
			return
		balloon_alert(user, "正在开始DNA融合……")
		start_infuse()
		return
	toggle_open(user)

/obj/machinery/dna_infuser/proc/start_infuse()
	var/mob/living/carbon/human/human_occupant = occupant
	infusing = TRUE
	visible_message(span_notice("[src]嗡鸣着启动，开始了融合过程！"))

	infusing_into = infusing_from.get_infusion_entry()
	var/fail_title = ""
	var/fail_explanation = ""
	if(istype(infusing_into, /datum/infuser_entry/fly))
		fail_title = "未知DNA"
		fail_explanation = "未知DNA。请查阅《DNA融合指南》。"
	if(infusing_into.tier > max_tier_allowed)
		infusing_into = GLOB.infuser_entries[/datum/infuser_entry/fly]
		fail_title = "过于复杂"
		fail_explanation = "DNA过于复杂，无法融合。机器需要先融合更简单的DNA。"
	playsound(src, 'sound/machines/blender.ogg', 50, vary = TRUE)
	to_chat(human_occupant, span_danger("细针反复刺入你的身体！"))
	human_occupant.take_overall_damage(10)
	human_occupant.add_mob_memory(/datum/memory/dna_infusion, protagonist = human_occupant, deuteragonist = infusing_from, mutantlike = infusing_into.infusion_desc)
	Shake(duration = INFUSING_TIME)
	addtimer(CALLBACK(human_occupant, TYPE_PROC_REF(/mob, emote), "scream"), INFUSING_TIME - 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(end_infuse), fail_explanation, fail_title), INFUSING_TIME)
	update_appearance()

/obj/machinery/dna_infuser/proc/end_infuse(fail_explanation, fail_title)
	var/mob/living/carbon/human/human_occupant = occupant
	if(human_occupant.infuse_organ(infusing_into, infusing_from))
		check_tier_progression(human_occupant)
		to_chat(occupant, span_danger("你感觉自己变得更加……[infusing_into.infusion_desc]？"))
	infusing = FALSE
	infusing_into = null
	QDEL_NULL(infusing_from)
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, vary = FALSE)
	if(fail_explanation)
		playsound(src, 'sound/machines/printer.ogg', 100, TRUE)
		visible_message(span_notice("[src]打印出一份错误报告。"))
		var/obj/item/paper/printed_paper = new /obj/item/paper(loc)
		printed_paper.name = "错误报告——'[fail_title]'"
		printed_paper.add_raw_text(fail_explanation)
		printed_paper.update_appearance()
	toggle_open()
	update_appearance()

/// checks to see if the machine should progress a new tier.
/obj/machinery/dna_infuser/proc/check_tier_progression(mob/living/carbon/human/target)
	if(
		max_tier_allowed != DNA_INFUSER_MAX_TIER \
		&& infusing_into.tier == max_tier_allowed \
		&& target.has_status_effect(infusing_into.status_effect_type) \
	)
		max_tier_allowed++
		playsound(src, 'sound/machines/ding.ogg', 50, TRUE)
		visible_message(span_notice("[src]叮的一声，记录下完整融合的结果。"))

/obj/machinery/dna_infuser/update_icon_state()
	//out of order
	if(machine_stat & (NOPOWER | BROKEN))
		icon_state = base_icon_state
		return ..()
	//maintenance
	if((machine_stat & MAINT) || panel_open)
		icon_state = "[base_icon_state]_panel"
		return ..()
	//actively running
	if(infusing)
		icon_state = "[base_icon_state]_on"
		return ..()
	//open or not
	icon_state = "[base_icon_state][state_open ? "_open" : null]"
	return ..()

/obj/machinery/dna_infuser/proc/toggle_open(mob/user)
	if(panel_open)
		if(user)
			balloon_alert(user, "先关闭面板！")
		return
	if(state_open)
		close_machine()
		return
	else if(infusing)
		if(user)
			balloon_alert(user, "运行时无法操作！")
		return
	open_machine(drop = FALSE)
	//we set drop to false to manually call it with an allowlist
	dump_inventory_contents(list(occupant))

/obj/machinery/dna_infuser/screwdriver_act(mob/living/user, obj/item/tool)
	return infusing ? NONE : default_deconstruction_screwdriver(user, tool)

/obj/machinery/dna_infuser/crowbar_act(mob/living/user, obj/item/tool)
	return infusing ? NONE : default_pry_open(user, tool, deconstruct_on_fail = TRUE)

/obj/machinery/dna_infuser/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.combat_mode)
		return NONE
	// if the machine already has a infusion target, or the target is not valid then no adding.
	if(!is_valid_infusion(tool, user))
		return ..() //research scanning is so back
	if(!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[tool]黏在你的手上了！"))
		return ITEM_INTERACT_BLOCKING
	infusing_from = tool
	return ITEM_INTERACT_SUCCESS

/obj/machinery/dna_infuser/relaymove(mob/living/user, direction)
	if(IS_UNCONSCIOUS_OR_CRIT(user))
		if(COOLDOWN_FINISHED(src, message_cooldown))
			COOLDOWN_START(src, message_cooldown, 4 SECONDS)
			to_chat(user, span_warning("[src]的舱门纹丝不动！"))
		return
	if(infusing)
		if(COOLDOWN_FINISHED(src, message_cooldown))
			COOLDOWN_START(src, message_cooldown, 4 SECONDS)
			to_chat(user, span_danger("针头正在为你进行融合时，[src]的舱门无法打开！"))
		return
	open_machine(drop = FALSE)
	//we set drop to false to manually call it with an allowlist
	dump_inventory_contents(list(occupant))

// mostly good for dead mobs like corpses (drag to add).
/obj/machinery/dna_infuser/mouse_drop_receive(atom/target, mob/user, params)
	// if the machine is closed, already has a infusion target, or the target is not valid then no mouse drop.
	if(!is_valid_infusion(target, user))
		return
	infusing_from = target
	infusing_from.forceMove(src)

/// Verify that the given infusion source/mob is a dead creature.
/obj/machinery/dna_infuser/proc/is_valid_infusion(atom/movable/target, mob/user)
	if(infusing_from)
		balloon_alert(user, "先清空机器！")
		return FALSE
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.stat != DEAD)
			balloon_alert(user, "只能放入死亡生物！")
			return FALSE
	else if(!HAS_TRAIT(target, TRAIT_VALID_DNA_INFUSION))
		balloon_alert(user, "只能放入生物！")
		return FALSE
	return TRUE

/obj/machinery/dna_infuser/click_alt(mob/user)
	if(infusing)
		balloon_alert(user, "运行时无法操作！")
		return CLICK_ACTION_BLOCKING
	if(!infusing_from)
		balloon_alert(user, "没有可弹出的样本！")
		return CLICK_ACTION_BLOCKING
	balloon_alert(user, "样本已弹出")
	infusing_from.forceMove(get_turf(src))
	infusing_from = null
	return CLICK_ACTION_SUCCESS

#undef INFUSING_TIME
#undef SCREAM_TIME
