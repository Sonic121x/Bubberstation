//Ninja modules for MODsuits

///Cloaking - Lowers the user's visibility, can be interrupted by being touched or attacked.
/obj/item/mod/module/stealth
	name = "\improper MOD 原型隐形模块"
	desc = "这是对套装的一次彻底改装，是一种视觉隐匿技术，借助深奥的\
		技术弯折使用者周围的光线，并用拟态材料让套装表面根据传感器数据\
		与周围环境相融。不知为何，这项技术很少见到。"
	icon_state = "cloak"
	module_type = MODULE_TOGGLE
	complexity = 4
	active_power_cost = DEFAULT_CHARGE_DRAIN * 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 10
	incompatible_modules = list(/obj/item/mod/module/stealth)
	cooldown_time = 5 SECONDS
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_MASK, ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_FEET)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 5)
	/// Whether or not the cloak turns off on bumping.
	var/bumpoff = TRUE
	/// The alpha applied when the cloak is on.
	var/stealth_alpha = 50

/obj/item/mod/module/stealth/on_activation(mob/activator)
	if(bumpoff)
		RegisterSignal(mod.wearer, COMSIG_LIVING_MOB_BUMP, PROC_REF(unstealth))
	RegisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(mod.wearer, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_bullet_act))
	RegisterSignals(mod.wearer, list(COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED), PROC_REF(unstealth))
	animate(mod.wearer, alpha = stealth_alpha, time = 1.5 SECONDS)
	drain_power(use_energy_cost)

/obj/item/mod/module/stealth/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	if(bumpoff)
		UnregisterSignal(mod.wearer, COMSIG_LIVING_MOB_BUMP)
	UnregisterSignal(mod.wearer, list(COMSIG_LIVING_UNARMED_ATTACK, COMSIG_MOB_ITEM_ATTACK, COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_ATTACK_HAND, COMSIG_ATOM_BULLET_ACT, COMSIG_ATOM_HITBY, COMSIG_ATOM_HULK_ATTACK, COMSIG_ATOM_ATTACK_PAW, COMSIG_CARBON_CUFF_ATTEMPTED))
	animate(mod.wearer, alpha = 255, time = 1.5 SECONDS)

/obj/item/mod/module/stealth/proc/unstealth(datum/source)
	SIGNAL_HANDLER

	to_chat(mod.wearer, span_warning("[src] 因接触而放电！"))
	do_sparks(2, TRUE, src)
	drain_power(use_energy_cost)
	deactivate()

/obj/item/mod/module/stealth/proc/on_unarmed_attack(datum/source, atom/target)
	SIGNAL_HANDLER

	if(!isliving(target))
		return
	unstealth(source)

/obj/item/mod/module/stealth/proc/on_bullet_act(datum/source, obj/projectile/projectile)
	SIGNAL_HANDLER

	if(!projectile.is_hostile_projectile())
		return
	unstealth(source)

//Advanced Cloaking - Doesn't turf off on bump, less power drain, more stealthy.
/obj/item/mod/module/stealth/ninja
	name = "\improper MOD 高级隐形模块"
	desc = "最新型的隐形技术，这个模块相较前代版本无疑是一次升级。\
		力场经过调校，反应更灵敏、起效更迅速，稳定性也足以\
		在使用者撞到他人时继续维持力场运作。\
		耗电量大幅降低，非常适合\
		在哨戒炮台附近长时间站岗之类的活动。"
	icon_state = "cloak_ninja"
	bumpoff = FALSE
	stealth_alpha = 20
	active_power_cost = DEFAULT_CHARGE_DRAIN
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	cooldown_time = 3 SECONDS


/obj/item/mod/module/stealth/ninja/on_activation(mob/activator)
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_SILENT_FOOTSTEPS, REF(src))

/obj/item/mod/module/stealth/ninja/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_SILENT_FOOTSTEPS, REF(src))

///Camera Vision - Prevents flashes, blocks tracking.
/obj/item/mod/module/welding/camera_vision
	name = "\improper MOD 摄像视觉模块"
	desc = "一种安装在套装头盔内的模块。这件专为隐蔽行动打造的特殊装备，\
		用一个纳米技术显示屏取代了标准面罩；它能在\
		恰到好处的频率上显示特殊影像，干扰所有已知的摄像追踪与面部识别，\
		还会自动调暗来袭的强光以保护使用者的眼睛。成为那个不被看见的人吧。"
	icon_state = "welding_camera"
	removable = FALSE
	complexity = 0
	overlay_state_inactive = null
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_EYES|ITEM_SLOT_MASK)

/obj/item/mod/module/welding/camera_vision/on_part_activation()
	RegisterSignal(mod.wearer, COMSIG_LIVING_CAN_TRACK, PROC_REF(can_track))
	var/obj/item/clothing/head_cover = mod.get_part_from_slot(ITEM_SLOT_HEAD) || mod.get_part_from_slot(ITEM_SLOT_MASK) || mod.get_part_from_slot(ITEM_SLOT_EYES)
	if(istype(head_cover))
		//this is a screen that displays an image, so flash sensitives can use this to protect against flashes.
		head_cover.flash_protect = FLASH_PROTECTION_WELDER_HYPER_SENSITIVE


/obj/item/mod/module/welding/camera_vision/on_part_deactivation(deleting = FALSE)
	if(deleting)
		return
	var/obj/item/clothing/head_cover = mod.get_part_from_slot(ITEM_SLOT_HEAD) || mod.get_part_from_slot(ITEM_SLOT_MASK) || mod.get_part_from_slot(ITEM_SLOT_EYES)
	if(istype(head_cover))
		head_cover.flash_protect = initial(head_cover.flash_protect)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_CAN_TRACK)

/obj/item/mod/module/welding/camera_vision/proc/can_track(datum/source, mob/user)
	SIGNAL_HANDLER

	return COMPONENT_CANT_TRACK

//Ninja Star Dispenser - Dispenses ninja stars.
/obj/item/mod/module/dispenser/ninja
	name = "\improper MOD 忍者镖配发模块"
	desc = "这件蜘蛛氏族的技术能够利用已知的能量-物质等价原理，\
		使用已经寄宿在佩戴者套装里的纳米机器人转化出单分子手里剑。\
		虽然它们没有传统投掷星那种极致的锋利感，\
		但它们被设定为能让逃跑的目标触电；并带有蜘蛛氏族的标志。"
	dispense_type = /obj/item/throwing_star/stamina/ninja
	cooldown_time = 0.5 SECONDS

/obj/item/throwing_star/stamina/ninja
	name = "能量投掷星"
	desc = "传统钢制手里剑的进化版，常被蜘蛛氏族的入门者使用。\
		投掷或嵌入时，其内部能量发射器会释放一次电磁脉冲。"
	icon_state = "eshuriken"
	force = 8
	throwforce = 12
	armour_penetration = 75
	item_flags = DROPDEL
	embed_type = /datum/embedding/throwing_star/stamina/energy
	custom_materials = null
	resistance_flags = FIRE_PROOF | ACID_PROOF | UNACIDABLE

/obj/item/throwing_star/stamina/ninja/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_UNCATCHABLE, INNATE_TRAIT)

/obj/item/throwing_star/stamina/ninja/on_thrown(mob/living/carbon/user, atom/target)
	item_flags &= ~DROPDEL // Throwing = dropping = dropdel, not ideal. Remove it before that happens
	return ..()

/obj/item/throwing_star/stamina/ninja/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	item_flags |= DROPDEL // Just in case, re-apply drop del now
	hit_atom.emp_act(EMP_HEAVY)
	new /obj/effect/temp_visual/emp/pulse(get_turf(src))
	new /obj/effect/temp_visual/emp(get_turf(hit_atom))
	playsound(src, 'sound/effects/empulse.ogg', 60, TRUE, MEDIUM_RANGE_SOUND_EXTRARANGE)
	visible_message("[src] 在撞击时释放出电磁脉冲！")
	if(isturf(loc)) // if we didn't embed in anything, go away
		qdel(src)

/datum/embedding/throwing_star/stamina/energy
	COOLDOWN_DECLARE(emp_cd)

/datum/embedding/throwing_star/stamina/energy/on_successful_embed(mob/living/carbon/victim, obj/item/bodypart/target_limb)
	COOLDOWN_START(src, emp_cd, 6 SECONDS)
	parent.item_flags |= DROPDEL // Just in case again, re-apply drop del now

/datum/embedding/throwing_star/stamina/energy/process_effect(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, emp_cd))
		return

	owner.emp_act(EMP_LIGHT)
	COOLDOWN_START(src, emp_cd, 6 SECONDS)
	playsound(owner, 'sound/effects/empulse.ogg', 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	owner.show_message("[parent] 骤然闪耀，释放出电磁脉冲！", MSG_VISUAL)
	new /obj/effect/temp_visual/emp(get_turf(owner))

///Hacker - This module hooks onto your right-clicks with empty hands and causes ninja actions.
/obj/item/mod/module/hacker
	name = "\improper MOD 黑客模块"
	desc = "为单一目的——电子战——而打造，这个模块被植入双手之中。\
		它通过近场通信以及对机器线路进行精确的电刺激，\
		这件骇客梦寐以求的装备通常被用来像幽灵一样穿门而过。\
		它也能在卸武攻击时对刺客破坏者的对手进行不精确的电刺激。"
	icon_state = "hacker"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/hacker)
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Whether or not the communication console hack was used to summon another antagonist.
	var/communication_console_hack_success = FALSE
	/// How many times the module has been used to force open doors.
	var/door_hack_counter = 0

/// Minimum amount of energy we can drain in a single drain action
#define NINJA_MIN_DRAIN (0.2 * STANDARD_CELL_CHARGE)
/// Maximum amount of energy we can drain in a single drain action
#define NINJA_MAX_DRAIN (0.4 * STANDARD_CELL_CHARGE)

/atom/proc/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	return NONE

/obj/item/mod/module/hacker/on_part_activation()
	RegisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(hack))

/obj/item/mod/module/hacker/on_part_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_UNARMED_ATTACK)

/obj/item/mod/module/hacker/proc/hack(mob/living/carbon/human/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	if(!LAZYACCESS(modifiers, RIGHT_CLICK) || !proximity)
		return NONE
	target.add_fingerprint(mod.wearer)
	return target.ninjadrain_act(mod.wearer, src)

/obj/item/mod/module/hacker/proc/charge_message(atom/drained_atom, drain_amount)
	if(drain_amount)
		to_chat(mod.wearer, span_notice("从 [drained_atom] 获得了 <B>[drain_amount]</B> 单位能量。"))
	else
		to_chat(mod.wearer, span_warning("[drained_atom] 的能量已被抽干，你必须另寻来源！"))

//Security Records, Ninja objective This notifies the AI and sets everyone on arrest.
/obj/machinery/computer/records/security/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	if(!can_hack(ninja, feedback = TRUE))
		return NONE

	AI_notify_hack()
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/computer/records/security/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!do_after(ninja, 20 SECONDS, src, extra_checks = CALLBACK(src, PROC_REF(can_hack), ninja), cog_icon = null))
		return
	for(var/datum/record/crew/target in GLOB.manifest.general)
		target.wanted_status = WANTED_ARREST
	update_all_security_huds()

	var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
	if(!ninja_antag)
		return
	var/datum/objective/security_scramble/objective = locate() in ninja_antag.objectives
	if(objective)
		objective.completed = TRUE

/obj/machinery/computer/records/security/proc/can_hack(mob/living/hacker, feedback = FALSE)
	if(machine_stat & (NOPOWER|BROKEN))
		if(feedback && hacker)
			balloon_alert(hacker, "无法入侵！")
		return FALSE
	var/area/console_area = get_area(src)
	if(!console_area || !(console_area.area_flags & VALID_TERRITORY))
		if(feedback && hacker)
			balloon_alert(hacker, "信号太弱！")
		return FALSE
	return TRUE

//APC, this drains emaggs the apc and drains power to supply your modsuit
/obj/machinery/power/apc/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/power/apc/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/maxcapacity = FALSE //Safety check for batteries
	var/drain = 0 //Drain amount from batteries
	var/drain_total = 0
	if(!cell?.charge)
		hacking_module.charge_message(src, drain_total)
		return
	var/datum/effect_system/basic/spark_spread/spark_system = new(loc, 5, FALSE)
	while(cell.charge> 0 && !maxcapacity)
		drain = rand(NINJA_MIN_DRAIN, NINJA_MAX_DRAIN)
		if(cell.charge < drain)
			drain = cell.charge
		if(hacking_module.mod.get_charge() + drain > hacking_module.mod.get_max_charge())
			drain = hacking_module.mod.get_max_charge() - hacking_module.mod.get_charge()
			maxcapacity = TRUE//Reached maximum battery capacity.
		if (do_after(ninja, 1 SECONDS, target = src, cog_icon = null))
			spark_system.start()
			playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
			cell.use(drain)
			hacking_module.mod.add_charge(drain)
			drain_total += drain
		else
			break
	if(!(obj_flags & EMAGGED))
		flick("apc-spark", hacking_module)
		playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		obj_flags |= EMAGGED
		locked = FALSE
		update_appearance()
	hacking_module.charge_message(src, drain_total)

//SMES, Drains power to supply your modsuit
/obj/machinery/power/smes/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/power/smes/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/maxcapacity = FALSE //Safety check for batteries
	var/drain = 0 //Drain amount from batteries
	var/drain_total = 0
	var/datum/effect_system/basic/spark_spread/spark_system = new(loc, 5, FALSE)
	while(charge > 0 && !maxcapacity)
		drain = rand(NINJA_MIN_DRAIN, NINJA_MAX_DRAIN)
		if(charge < drain)
			drain = charge
		if(hacking_module.mod.get_charge() + drain > hacking_module.mod.get_max_charge())
			drain = hacking_module.mod.get_max_charge() - hacking_module.mod.get_charge()
			maxcapacity = TRUE
		if (do_after(ninja, 1 SECONDS, target = src, cog_icon = null))
			spark_system.start()
			playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
			charge -= drain
			hacking_module.mod.add_charge(drain)
			drain_total += drain
			maxcapacity = TRUE//Reached maximum battery capacity.
		else
			break
	hacking_module.charge_message(src, drain_total)

//CELL, Drains power, to supply your modsuit
/obj/item/stock_parts/power_store/cell/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/stock_parts/power_store/cell/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/drain_total = 0
	if(charge && !do_after(ninja, 3 SECONDS, target = src, cog_icon = null))
		drain_total = charge
		if(hacking_module.mod.get_charge() + charge > hacking_module.mod.get_max_charge())
			drain_total = hacking_module.mod.get_max_charge() - hacking_module.mod.get_charge()
		hacking_module.mod.add_charge(drain_total)
		use(drain_total)
		corrupt()
		update_appearance()
	hacking_module.charge_message(src, drain_total)

//RD SERVER, Ninja objective will download the RnD files and destroy source code hard drive.
/obj/machinery/rnd/server/master/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	// If the traitor theft objective is still present, this will destroy it...
	if(!source_code_hdd)
		return ..()
	to_chat(ninja, span_notice("正在入侵 \the [src]……"))
	AI_notify_hack()
	to_chat(ninja, span_notice("检测到加密源代码。正在使存储设备过载……"))
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/rnd/server/master/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!do_after(ninja, 30 SECONDS, target = src, cog_icon = null))
		return
	overload_source_code_hdd()
	to_chat(ninja, span_notice("破坏完成。存储设备已过载。"))
	var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
	if(!ninja_antag)
		return
	var/datum/objective/research_secrets/objective = locate() in ninja_antag.objectives
	if(objective)
		objective.completed = TRUE

/obj/machinery/rnd/server/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	to_chat(ninja, span_notice("检测到研究笔记。正在破坏数据……"))
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/rnd/server/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!do_after(ninja, 30 SECONDS, target = src, cog_icon = null))
		return
	stored_research.adjust_all_points(-INFINITY)
	to_chat(ninja, span_notice("破坏完成。研究笔记已损坏。"))
	var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
	if(!ninja_antag)
		return
	var/datum/objective/research_secrets/objective = locate() in ninja_antag.objectives
	if(objective)
		objective.completed = TRUE


//COMMUNICATIONS CONSOLE, Ninja objective hacking it summons random threat.
/obj/machinery/computer/communications/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	if(hacking_module.communication_console_hack_success)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/computer/communications/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!try_hack_console(ninja))
		return

	hacking_module.communication_console_hack_success = TRUE
	var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
	if(!ninja_antag)
		return
	var/datum/objective/terror_message/objective = locate() in ninja_antag.objectives
	if(objective)
		objective.completed = TRUE

//AIRLOCK, Ninja objective. Hacking it forces the airlock open and emaggs it
/obj/machinery/door/airlock/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	if(!operating && density && hasPower() && !(obj_flags & EMAGGED) && hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN * 5))
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom, emag_act))
		hacking_module.door_hack_counter++
		var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
		if(!ninja_antag)
			return NONE
		var/datum/objective/door_jack/objective = locate() in ninja_antag.objectives
		if(objective && objective.doors_required == hacking_module.door_hack_counter)
			ninja.balloon_alert(ninja, "所有门都已入侵")
		if(objective && objective.doors_required <= hacking_module.door_hack_counter)
			objective.completed = TRUE
	return COMPONENT_CANCEL_ATTACK_CHAIN

//WIRE, Drains power from powernet and supplies your modsuit
/obj/structure/cable/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/structure/cable/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/maxcapacity = FALSE //Safety check
	var/drain = 0 //Drain amount
	var/drain_total = 0
	var/datum/powernet/wire_powernet = powernet
	while(!maxcapacity && src)
		drain = (round((rand(NINJA_MIN_DRAIN, NINJA_MAX_DRAIN))/2))
		var/drained = 0
		if(wire_powernet && do_after(ninja, 1 SECONDS, target = src, cog_icon = null))
			drained = min(drain, delayed_surplus())
			add_delayedload(drained)
			if(drained < drain)//if no power on net, drain apcs
				for(var/obj/machinery/power/terminal/affected_terminal in wire_powernet.nodes)
					if(istype(affected_terminal.master, /obj/machinery/power/apc))
						var/obj/machinery/power/apc/AP = affected_terminal.master
						if(AP.operating && AP.cell && AP.cell.charge > 0)
							AP.cell.charge = max(0, AP.cell.charge - 5)
							drained += 5
		else
			break
		if(hacking_module.mod.get_charge() + drain > hacking_module.mod.get_max_charge())
			drain = hacking_module.mod.get_max_charge() - hacking_module.mod.get_charge()
			maxcapacity = TRUE
		drain_total += drain
		hacking_module.mod.add_charge(drain)
		do_sparks(5, cardinal_only = FALSE, source = hacking_module.mod)
	hacking_module.charge_message(src, drain_total)

//MECH, Drains power from the mech to supply your modsuit.
/obj/vehicle/sealed/mecha/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	to_chat(occupants, "[icon2html(src, occupants)][span_danger("警告：检测到经由子路由 4、区块 H 的未授权访问。")]")
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/vehicle/sealed/mecha/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/maxcapacity = FALSE //Safety check
	var/drain = 0 //Drain amount
	var/drain_total = 0
	if(get_charge())
		while(cell.charge > 0 && !maxcapacity)
			drain = rand(NINJA_MIN_DRAIN, NINJA_MAX_DRAIN)
			if(cell.charge < drain)
				drain = cell.charge
			if(hacking_module.mod.get_charge() + drain > hacking_module.mod.get_max_charge())
				drain = hacking_module.mod.get_max_charge() - hacking_module.mod.get_charge()
				maxcapacity = TRUE
			if (do_after(ninja, 1 SECONDS, target = src, cog_icon = null))
				spark_system.start()
				playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
				cell.use(drain)
				hacking_module.mod.add_charge(drain)
				drain_total += drain
			else
				break
	hacking_module.charge_message(src, drain_total)

//BORG, Ninja objective converts a borg to a syndicate version
/mob/living/silicon/robot/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module || (has_faction(ROLE_NINJA)))
		return NONE

	to_chat(src, span_danger("警——***BZZZZZZZZZRT*** 正在上传 SPYDERPATCHER 9.5.2 版本……"))
	INVOKE_ASYNC(src, PROC_REF(ninjadrain_charge), ninja, hacking_module)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/mob/living/silicon/robot/proc/ninjadrain_charge(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!do_after(ninja, 6 SECONDS, target = src, cog_icon = null))
		return
	spark_system.start()
	playsound(loc, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	to_chat(src, span_danger("上传完成。检测到新的半机械人型号。正在安装……"))
	faction = list(ROLE_NINJA)
	bubble_icon = "syndibot"
	UnlinkSelf()
	ionpulse = TRUE
	replace_law_set(/datum/ai_laws/ninja_override)
	model.transform_to(pick(/obj/item/robot_model/syndicate, /obj/item/robot_model/syndicate_medical, /obj/item/robot_model/saboteur))

	var/datum/antagonist/ninja/ninja_antag = ninja.mind.has_antag_datum(/datum/antagonist/ninja)
	if(!ninja_antag)
		return
	var/datum/objective/cyborg_hijack/objective = locate() in ninja_antag.objectives
	if(objective)
		objective.completed = TRUE

//CARBON MOBS, shoving causes 3 second knockdown
/mob/living/carbon/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!ninja || !hacking_module)
		return NONE
	//20 uses for a standard cell. 200 for high capacity cells.
	if(hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN*10))
		//Got that electric touch
		do_sparks(5, FALSE, loc)
		visible_message(span_danger("[ninja] 伸手电击了 [src]！"), span_userdanger("[ninja] 伸手电击了你！"))
		addtimer(CALLBACK(src, PROC_REF(ninja_knockdown)), 0.3 SECONDS)
	return NONE

/mob/living/carbon/proc/ninja_knockdown()
	Knockdown(3 SECONDS)
	set_jitter_if_lower(3 SECONDS)

//CAMERAS, emps cameras disabling AI vision
/obj/machinery/camera/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(isEmpProof(TRUE))
		balloon_alert(ninja, "摄像头有屏蔽！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN * 5))
		return

	emp_act(EMP_HEAVY)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//BOTS, overloads them and causes a explosion
/mob/living/basic/bot/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	to_chat(src, span_boldwarning("你的电路突然开始发热！"))
	if(!do_after(ninja, 1.5 SECONDS, target = src, cog_icon = null))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN * 7))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	do_sparks(number = 3, cardinal_only = FALSE, source = src)
	playsound(get_turf(src), 'sound/machines/warning-buzzer.ogg', 35, TRUE)
	balloon_alert(ninja, "退后！")
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(explosion), src, 0, 1, 2, 3), 2.5 SECONDS)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/mob/living/basic/bot/medbot/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/static/list/death_cry = list(
		MEDIBOT_VOICED_NO_SAD,
		MEDIBOT_VOICED_OH_FUCK,
	)
	speak(pick(death_cry))
	return ..()

//ENERGY WEAPONS, drains power from the weapon to supply your modsuit
/obj/item/gun/energy/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(cell.charge == 0)
		balloon_alert(ninja, "没有能量！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!do_after(ninja, 1.5 SECONDS, target = src, cog_icon = null))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	hacking_module.mod.add_charge(cell.charge)
	hacking_module.charge_message(src, cell.charge)
	cell.charge = 0
	update_appearance()
	visible_message(span_warning("[ninja] 抽干了 [src] 的能量！"))
	do_sparks(number = 3, cardinal_only = FALSE, source = src)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//VENDING MACHINES, overload vending machines to throw its suppy at people
/obj/machinery/vending/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(shoot_inventory)
		balloon_alert(ninja, "已经被入侵了！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!do_after(ninja, 2 SECONDS, target = src, cog_icon = null))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN * 5))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	do_sparks(number = 3, cardinal_only = FALSE, source = src)
	balloon_alert(ninja, "系统已过载！")
	wires.on_pulse(WIRE_THROW)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//RECYCLER, emaggs the recycler disabling its safety
/obj/machinery/recycler/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(obj_flags & EMAGGED)
		balloon_alert(ninja, "已经被入侵了！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	AI_notify_hack()
	if(!do_after(ninja, 30 SECONDS, target = src, cog_icon = null))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	do_sparks(3, cardinal_only = FALSE, source = src)
	emag_act(ninja)

	return COMPONENT_CANCEL_ATTACK_CHAIN

//ELEVATOR CONTROLS//
/obj/machinery/elevator_control_panel/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(obj_flags & EMAGGED)
		balloon_alert(ninja, "已经被入侵了！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(!do_after(ninja, 2 SECONDS, target = src, cog_icon = null))
		return COMPONENT_CANCEL_ATTACK_CHAIN

	do_sparks(3, cardinal_only = FALSE, source = src)
	emag_act(ninja)

	return COMPONENT_CANCEL_ATTACK_CHAIN

//TRAM CONTROLS, overloads the tram causing tram malfunction event only once per round
/obj/machinery/computer/tram_controls/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	var/datum/round_event/tram_malfunction/malfunction_event = locate(/datum/round_event/tram_malfunction) in SSevents.running
	if(malfunction_event)
		balloon_alert(ninja, "电车已经故障了！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(specific_transport_id != TRAMSTATION_LINE_1)
		balloon_alert(ninja, "无法入侵这列电车！")
		return COMPONENT_CANCEL_ATTACK_CHAIN

	AI_notify_hack()

	if(!do_after(ninja, 20 SECONDS, target = src, cog_icon = null)) //Shorter due to how incredibly easy it is for someone to (even accidentally) interrupt.
		return COMPONENT_CANCEL_ATTACK_CHAIN

	force_event(/datum/round_event_control/tram_malfunction, "忍者干扰")
	malfunction_event = locate(/datum/round_event/tram_malfunction) in SSevents.running
	malfunction_event.end_when *= 2
	for(var/obj/machinery/transport/guideway_sensor/sensor as anything in SStransport.sensors)
		// Since faults are now used instead of straight event end_when var, we make a few of them malfunction
		if(prob(rand(15, 30)))
			sensor.local_fault()

	return COMPONENT_CANCEL_ATTACK_CHAIN

//WINDOOR, emaggs the door open
/obj/machinery/door/window/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(!operating && density && hasPower() && !(obj_flags & EMAGGED) && hacking_module.mod.subtract_charge(DEFAULT_CHARGE_DRAIN * 5))
		INVOKE_ASYNC(src, TYPE_PROC_REF(/atom, emag_act))
	return COMPONENT_CANCEL_ATTACK_CHAIN

//BUTTONS, emaggs the button removing access requirements
/obj/machinery/button/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	if(is_operational && !(obj_flags & EMAGGED))
		emag_act(ninja)
	return COMPONENT_CANCEL_ATTACK_CHAIN

//FIRELOCKS, forces the firelock open.
/obj/machinery/door/firedoor/ninjadrain_act(mob/living/carbon/human/ninja, obj/item/mod/module/hacker/hacking_module)
	crack_open()

#undef NINJA_MIN_DRAIN
#undef NINJA_MAX_DRAIN
///Weapon Recall - Teleports your katana to you, prevents gun use.
/obj/item/mod/module/weapon_recall
	name = "\improper MOD 武器召回模块"
	desc = "这是氏族成员作为刀术大师的人生基石，也是象征他们与武器永恒羁绊的模块。\
		它接入能量武士刀刀柄内的微型蓝空间驱动器，能将刀召回使用者\
		熟练的手中，无论他们在哪里。然而，与武器结下此种羁绊的人注定\
		要将自身的存在与战斗行为融为一体，怀着唯一的目的；斩杀对手。\
		其手为斩击之手，其身为斩击之身，其心为斩击之心。\
		远程武器被禁止使用。"
	icon_state = "recall"
	removable = FALSE
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/weapon_recall)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES, ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	/// The item linked to the module that will get recalled.
	var/obj/item/linked_weapon
	/// The accepted typepath we can link to.
	var/accepted_type = /obj/item/energy_katana

/obj/item/mod/module/weapon_recall/on_part_activation()
	mod.wearer.add_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), REF(src))

/obj/item/mod/module/weapon_recall/on_part_deactivation(deleting = FALSE)
	mod.wearer.remove_traits(list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD), REF(src))

/obj/item/mod/module/weapon_recall/on_use()
	if(!linked_weapon)
		var/obj/item/weapon_to_link = mod.wearer.is_holding_item_of_type(accepted_type)
		if(!weapon_to_link)
			balloon_alert(mod.wearer, "没有已链接的武器！")
			return
		set_weapon(weapon_to_link)
		balloon_alert(mod.wearer, "已链接 [linked_weapon.name]")
		return
	if(linked_weapon in mod.wearer.get_all_contents())
		balloon_alert(mod.wearer, "已经在自己身上了！")
		return
	var/distance = get_dist(mod.wearer, linked_weapon)
	var/in_view = (linked_weapon in view(mod.wearer)) && !(linked_weapon in get_turf(mod.wearer))
	if(!in_view && !drain_power(use_energy_cost * distance))
		balloon_alert(mod.wearer, "电量不足！")
		return
	linked_weapon.forceMove(linked_weapon.drop_location())
	if(in_view)
		do_sparks(5, FALSE, linked_weapon)
		mod.wearer.visible_message(span_danger("[linked_weapon] 朝 [mod.wearer] 飞来！"),span_warning("你伸出手，[linked_weapon] 朝你飞来！"))
		linked_weapon.throw_at(mod.wearer, distance+1, linked_weapon.throw_speed, mod.wearer)
	else
		recall_weapon()

/obj/item/mod/module/weapon_recall/proc/set_weapon(obj/item/weapon)
	linked_weapon = weapon
	RegisterSignal(linked_weapon, COMSIG_MOVABLE_PRE_IMPACT, PROC_REF(catch_weapon))
	RegisterSignal(linked_weapon, COMSIG_QDELETING, PROC_REF(deleted_weapon))

/obj/item/mod/module/weapon_recall/proc/recall_weapon(caught = FALSE)
	linked_weapon.forceMove(get_turf(src))
	var/alert = ""
	if(mod.wearer.put_in_hands(linked_weapon))
		alert = "[linked_weapon.name] 传送到你手中"
	else if(mod.wearer.equip_to_slot_if_possible(linked_weapon, ITEM_SLOT_BELT, disable_warning = TRUE))
		alert = "[linked_weapon.name] 自行收入你的腰带"
	else
		alert = "[linked_weapon.name] 传送到你脚下"
	if(caught)
		if(mod.wearer.is_holding(linked_weapon))
			alert = "你接住了 [linked_weapon.name]"
		else
			alert = "[linked_weapon.name] 落在你脚下"
	else
		do_sparks(5, FALSE, linked_weapon)
	if(alert)
		balloon_alert(mod.wearer, alert)

/obj/item/mod/module/weapon_recall/proc/catch_weapon(obj/item/source, atom/hit_atom, datum/thrownthing/thrownthing)
	SIGNAL_HANDLER

	if(!mod)
		return
	if(hit_atom != mod.wearer)
		return
	INVOKE_ASYNC(src, PROC_REF(recall_weapon), TRUE)
	return COMPONENT_MOVABLE_IMPACT_NEVERMIND

/obj/item/mod/module/weapon_recall/proc/deleted_weapon(obj/item/source)
	SIGNAL_HANDLER

	linked_weapon = null

//Reinforced DNA Lock - Gibs if wrong DNA, emp-proof.
/obj/item/mod/module/dna_lock/reinforced
	name = "\improper MOD 强化 DNA 锁模块"
	desc = "一种与套装系统上的各种锁具和密封装置联动的模块，\
		使套装只能被与使用者 DNA 完全相符的人穿戴。\
		由于采用了一层贴身阻尼护盾，这个模块完全密封，可抵御电磁干扰；\
		它也会尽职地保护蜘蛛氏族的秘密不被不知情的外人窥探。"
	icon_state = "dnalock_ninja"
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 0.5

/obj/item/mod/module/dna_lock/reinforced/on_mod_activation(datum/source, mob/user)
	. = ..()
	if(. != MOD_CANCEL_ACTIVATE || !isliving(user) || user != mod.wearer)
		return
	if(istype(mod, /obj/item/mod/control/pre_equipped/protean)) // BUBBER EDIT START
		return													// BUBBER EDIT END
	if(mod.ai_assistant == user)
		to_chat(mod.ai_assistant, span_danger("<B>fATaL EERRoR</B>: 381200-*#00CODE <B>BLUE</B>\n检 测 到 AI 干 预\n已 忽 略 操 作"))
		return
	var/mob/living/living_user = user
	to_chat(living_user, span_danger("<B>fATaL EERRoR</B>: 382200-*#00CODE <B>RED</B>\n检 测 到 未 授 权 使 用\n正 在 执 行 子 程 序 13……\n正 在 终 止 用 户……"))
	living_user.investigate_log("使用装有 [src] 的 MOD 套装时被肢解成肉块。", INVESTIGATE_DEATHS)
	living_user.gib(DROP_ALL_REMAINS)

/obj/item/mod/module/dna_lock/reinforced/on_emp(datum/source, severity)
	return

//EMP Pulse - In addition to normal shielding, can also launch an EMP itself.
/obj/item/mod/module/emp_shield/pulse
	name = "\improper MOD EMP 脉冲模块"
	desc = "这个模块通常被设定为在夸张的手势下激活，将套装的\
		EMP 阻尼护盾反转并扩张，从而自行产生一次电磁脉冲。虽然这不会影响佩戴者，\
		但会激怒周围所有人。"
	icon_state = "emp_pulse"
	module_type = MODULE_USABLE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 10
	cooldown_time = 8 SECONDS

/obj/item/mod/module/emp_shield/pulse/on_use(mob/activator)
	playsound(src, 'sound/effects/empulse.ogg', 60, TRUE)
	empulse(src, heavy_range = 4, light_range = 6, emp_source = src)
	drain_power(use_energy_cost)

/// Ninja Status Readout - Like the normal status display (see the base type), but with a clock.
/obj/item/mod/module/status_readout/ninja
	name = "\improper MOD 蜘蛛氏族状态读取模块"
	desc = "一种曾经很常见的模块，可惜这项技术在太空较安全的地区已经不再流行；\
		而且，根据这个特定单元外壳上的额外标记来看，它径直落入了蜘蛛氏族的蛛爪之中。\
		与其他类似单元一样，这一个会接入套装的脊柱，能够采集并显示\
		佩戴者所有可获取的生物特征数据；睡眠、营养、体能、指纹，\
		甚至还有整体健康状况之类的有用信息。这一台配有一个会与本地系统时间\
		校准的时钟，以及一个运行 ID 编号显示。生命体征监测器的扬声器已被拆除。"
	display_time = TRUE
	sensor_boost = FALSE
	death_sound = null
	death_sound_volume = null

///Energy Net - Ensnares enemies in a net that prevents movement.
/obj/item/mod/module/energy_net
	name = "\improper MOD 能量网模块"
	desc = "一种定制的掷网器。这种捕获装置的常规实现方案\
		使用单分子纤维或锋利的剃刀铁丝，而这个则使用硬光技术，部署一片\
		连最强壮的对手也能束缚住的陷阱力场。"
	icon_state = "energy_net"
	removable = FALSE
	module_type = MODULE_ACTIVE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 6
	incompatible_modules = list(/obj/item/mod/module/energy_net)
	cooldown_time = 5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	/// List of all energy nets this module made.
	var/list/energy_nets = list()

/obj/item/mod/module/energy_net/on_part_deactivation(deleting)
	for(var/obj/structure/energy_net/net as anything in energy_nets)
		net.atom_destruction(ENERGY)

/obj/item/mod/module/energy_net/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(IS_SPACE_NINJA(mod.wearer) && isliving(target))
		mod.wearer.say("给我过来！", forced = type)
	var/obj/projectile/net = new /obj/projectile/energy_net(mod.wearer.loc, src)
	net.aim_projectile(target, mod.wearer)
	net.firer = mod.wearer
	playsound(src, 'sound/items/weapons/punchmiss.ogg', 25, TRUE)
	INVOKE_ASYNC(net, TYPE_PROC_REF(/obj/projectile, fire))
	drain_power(use_energy_cost)

/obj/item/mod/module/energy_net/proc/add_net(obj/structure/energy_net/net)
	energy_nets += net
	RegisterSignal(net, COMSIG_QDELETING, PROC_REF(remove_net))

/obj/item/mod/module/energy_net/proc/remove_net(obj/structure/energy_net/net)
	SIGNAL_HANDLER
	energy_nets -= net

/obj/projectile/energy_net
	name = "能量网"
	icon_state = "net_projectile"
	icon = 'icons/obj/clothing/modsuit/mod_modules.dmi'
	damage = 0
	range = 9
	hitsound = 'sound/items/fulton/fultext_deploy.ogg'
	hitsound_wall = 'sound/items/fulton/fultext_deploy.ogg'
	/// Reference to the beam following the projectile.
	var/line
	/// Reference to the energy net module.
	var/datum/weakref/net_module

/obj/projectile/energy_net/Initialize(mapload, net_module)
	. = ..()
	src.net_module = WEAKREF(net_module)

/obj/projectile/energy_net/fire(setAngle)
	if(firer)
		line = firer.Beam(src, "net_beam", 'icons/obj/clothing/modsuit/mod_modules.dmi')
	return ..()

/obj/projectile/energy_net/on_hit(mob/living/target, blocked = 0, pierce_hit)
	. = ..()
	if(!istype(target))
		return
	if(locate(/obj/structure/energy_net) in get_turf(target))
		return
	var/obj/structure/energy_net/net = new /obj/structure/energy_net(target.drop_location())
	var/obj/item/mod/module/energy_net/module = net_module?.resolve()
	if(module)
		module.add_net(net)
	firer?.visible_message(span_danger("[firer] 用能量网抓住了 [target]！"), span_notice("你用能量网抓住了 [target]！"))
	if(target.buckled)
		target.buckled.unbuckle_mob(target, force = TRUE)
	net.buckle_mob(target, force = TRUE)

/obj/projectile/energy_net/Destroy()
	QDEL_NULL(line)
	return ..()

/obj/structure/energy_net
	name = "能量网"
	desc = "这是一张由绿色能量构成的网。"
	icon = 'icons/effects/effects.dmi'
	icon_state = "energynet"
	density = TRUE //Can't pass through.
	anchored = TRUE //Can't drag/grab the net.
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	max_integrity = 60 //How much health it has.
	can_buckle = TRUE
	buckle_lying = 0
	buckle_prevents_pull = TRUE

/obj/structure/energy_net/Initialize(mapload)
	. = ..()
	var/image/underlay = image(icon, "energynet_underlay")
	underlay.layer = BELOW_MOB_LAYER
	SET_PLANE_EXPLICIT(underlay, GAME_PLANE, src)
	add_overlay(underlay)
	ADD_TRAIT(src, TRAIT_DANGEROUS_BUCKLE, INNATE_TRAIT)

/obj/structure/energy_net/play_attack_sound(damage, damage_type = BRUTE, damage_flag = 0)
	if(damage_type == BRUTE || damage_type == BURN)
		playsound(src, 'sound/items/weapons/slash.ogg', 80, TRUE)

/obj/structure/energy_net/atom_destruction(damage_flag)
	for(var/mob/recovered_mob as anything in buckled_mobs)
		recovered_mob.visible_message(span_notice("[recovered_mob] 从能量网中被解救出来！"), span_notice("你从能量网中被解救出来！"), span_hear("你听到一声闷哼。"))
	return ..()

/obj/structure/energy_net/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/energy_net/user_buckle_mob(mob/living/buckled_mob, mob/user, check_loc = TRUE)
	return//We only want our target to be buckled

/obj/structure/energy_net/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	return//The net must be destroyed to free the target

///Adrenaline Boost - Stops all stuns the ninja is affected with, increases his speed.
/obj/item/mod/module/adrenaline_boost
	name = "\improper MOD 肾上腺素注射模块"
	desc = "蜘蛛氏族的秘密数不胜数。他们套装的精确规格，\
		他们让每一刀都令敌人钦佩落泪的技法，\
		但他们最大的谜团之一，是刺客破坏者在危急时刻使用的化合物。\
		它能清除使用者身上的一切疲乏、任何定身效果，甚至可以\
		治愈完全的瘫痪。目前所知的只有：这种液体需要辐射才能充分‘烹制’，\
		所以这个模块需要用镭来补充。"
	icon_state = "adrenaline_boost"
	removable = FALSE
	module_type = MODULE_USABLE
	allow_flags = MODULE_ALLOW_INCAPACITATED
	incompatible_modules = list(/obj/item/mod/module/adrenaline_boost)
	cooldown_time = 12 SECONDS
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	/// What reagent we need to refill?
	var/reagent_required = /datum/reagent/uranium/radium
	/// How much of a reagent we need to refill the boost.
	var/reagent_required_amount = 20

/obj/item/mod/module/adrenaline_boost/Initialize(mapload)
	. = ..()
	create_reagents(reagent_required_amount)
	reagents.add_reagent(reagent_required, reagent_required_amount)

/obj/item/mod/module/adrenaline_boost/used()
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "没有充能！")
		return FALSE
	return ..()

/obj/item/mod/module/adrenaline_boost/on_use(mob/activator)
	if(IS_SPACE_NINJA(mod.wearer))
		mod.wearer.say(pick_list_replacements(NINJA_FILE, "lines"), forced = type)
	to_chat(mod.wearer, span_notice("你已使用肾上腺素注射。"))
	mod.wearer.SetAllImmobility(0)
	mod.wearer.adjust_stamina_loss(-200)
	mod.wearer.remove_status_effect(/datum/status_effect/speech/stutter)
	mod.wearer.reagents.add_reagent(/datum/reagent/medicine/stimulants, 5)
	reagents.remove_reagent(reagent_required, reagents.total_volume * 0.75)
	addtimer(CALLBACK(src, PROC_REF(boost_aftereffects), mod.wearer), 7 SECONDS)

/obj/item/mod/module/adrenaline_boost/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_boost))

/obj/item/mod/module/adrenaline_boost/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION)

/obj/item/mod/module/adrenaline_boost/proc/try_boost(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/obj/item/mod/module/adrenaline_boost/proc/charge_boost(obj/item/attacking_item)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "已经充满了！")
		return FALSE
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(mod.wearer, "充能已[reagents.has_reagent(reagent_required, reagent_required_amount) ? "完全" : "部分"]补充")
	return TRUE

/obj/item/mod/module/adrenaline_boost/proc/boost_aftereffects(mob/affected_mob)
	if(!affected_mob)
		return
	reagents.trans_to(affected_mob, reagents.total_volume)
	to_chat(affected_mob, span_danger("你开始感受到注射的后劲。"))
