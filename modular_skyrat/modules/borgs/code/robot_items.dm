/// Use this file to add STANDARD ITEMS to borgs, the upgrade items will go in the modular robot_upgrade.dm

/*
*	CARGO BORGS
*/

#define CYBORG_FONT "Consolas"
#define MAX_PAPER_INTEGRATED_CLIPBOARD 10

/obj/item/pen/cyborg
	name = "集成笔"
	font = CYBORG_FONT
	desc = "用这支笔写字时，你几乎能听见齿轮彼此摩擦的声音。几乎。"


/obj/item/clipboard/cyborg
	name = "\improper 集成剪贴板"
	desc = "一块似乎内置了纸张合成器的剪贴板，合成器巧妙地藏在它的纸夹里。"
	integrated_pen = TRUE
	/// When was the last time the printer was used?
	COOLDOWN_DECLARE(printer_cooldown)
	/// How long is the integrated printer's cooldown?
	var/printer_cooldown_time = 10 SECONDS
	/// How much charge is required to print a piece of paper?
	var/paper_charge_cost = STANDARD_CELL_CHARGE * 0.05


/obj/item/clipboard/cyborg/Initialize(mapload)
	. = ..()
	pen = new /obj/item/pen/cyborg


/obj/item/clipboard/cyborg/examine()
	. = ..()
	. += "按 Alt 点击可合成一张纸。"
	if(!COOLDOWN_FINISHED(src, printer_cooldown))
		. += "它的内置纸张合成器似乎仍在冷却中。"


/obj/item/clipboard/cyborg/click_alt(mob/user)
	if(!iscyborg(user))
		to_chat(user, span_warning("你似乎不知道该怎么使用 [src]。"))
		return CLICK_ACTION_BLOCKING
	var/mob/living/silicon/robot/cyborg_user = user
	// Not enough charge? Tough luck.
	if(cyborg_user?.cell.charge < paper_charge_cost)
		to_chat(user, span_warning("你的内部电池电量不足以使用 [src] 的内置打印机。"))
		return CLICK_ACTION_BLOCKING
	// Check for cooldown to avoid paper spamming
	if(COOLDOWN_FINISHED(src, printer_cooldown))
		// If there's not too much paper already, let's go
		if(length(contents) < MAX_PAPER_INTEGRATED_CLIPBOARD)
			cyborg_user.cell.use(paper_charge_cost)
			COOLDOWN_START(src, printer_cooldown, printer_cooldown_time)
			var/obj/item/paper/new_paper = new /obj/item/paper
			new_paper.forceMove(src)
			if(top_paper)
				UnregisterSignal(top_paper, COMSIG_ATOM_UPDATED_ICON)
			RegisterSignal(new_paper, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_top_paper_change))
			top_paper = new_paper
			update_appearance()
			to_chat(user, span_notice("[src] 的内置打印机嗡鸣着启动，吐出一张崭新的纸并把它夹好。"))
			return CLICK_ACTION_SUCCESS
		else
			to_chat(user, span_warning("[src] 的内置打印机拒绝再打印纸张，因为 [src] 中已有足够的纸。"))
	else
		to_chat(user, span_warning("[src] 的内置打印机拒绝再打印纸张，它的蓝空间纸张合成器尚未从上次合成中恢复。"))
	return CLICK_ACTION_BLOCKING


/obj/item/hand_labeler/cyborg
	name = "集成手持贴标机"
	labels_left = 9000 // I don't want to bother forcing them to recharge, honestly, that's a lot of code for a very niche functionality


/// THE CLAMPS!!
/obj/item/borg/hydraulic_clamp
	name = "集成液压夹钳"
	desc = "一种利落的搬运方式，可抬起并移动少量小件包裹，实现快速无痛的投递！"
	icon = 'icons/obj/devices/mecha_equipment.dmi' // Just some temporary sprites because I don't have any unique one yet
	icon_state = "mecha_clamp"
	/// How much power does it draw per operation?
	var/charge_cost = STANDARD_CELL_CHARGE * 0.02
	/// How many items can it hold at once in its internal storage?
	var/storage_capacity = 5
	/// Does it require the items it takes in to be wrapped in paper wrap? Can have unforeseen consequences, change to FALSE at your own risks.
	var/whitelisted_contents = TRUE
	/// What kind of wrapped item can it hold, if `whitelisted_contents` is set to true?
	var/list/whitelisted_item_types = list(/obj/item/delivery/small, /obj/item/bounty_cube)
	/// A short description used when the check to pick up something has failed.
	var/whitelisted_item_description = "小件包裹"
	/// Weight limit on the items it can hold. Leave as NONE if there isn't.
	var/item_weight_limit = WEIGHT_CLASS_SMALL
	/// Can it hold mobs? (Dangerous, it is recommended to leave this to FALSE)
	var/can_hold_mobs = FALSE
	/// Audio for using the hydraulic clamp.
	var/clamp_sound = 'sound/vehicles/mecha/hydraulic.ogg'
	/// Volume of the clamp's loading and unloading noise.
	var/clamp_sound_volume = 25
	/// Cooldown for the clamp.
	COOLDOWN_DECLARE(clamp_cooldown)
	/// How long is the clamp on cooldown for after every usage?
	var/cooldown_duration = 0.5 SECONDS
	/// How long does it take to load in an item?
	var/loading_time = 2 SECONDS
	/// How long does it take to unload an item?
	var/unloading_time = 1 SECONDS
	/// Is it currently in use?
	var/in_use = FALSE
	/// Index of the item we want to take out of the clamp, 0 if nothing selected.
	var/selected_item_index = 0
	/// Weakref to the cyborg we're currently connected to.
	var/datum/weakref/cyborg_holding_me


/obj/item/borg/hydraulic_clamp/Initialize(mapload)
	. = ..()
	if(!istype(loc, /obj/item/robot_model))
		return

	var/obj/item/robot_model/holder_model = loc
	cyborg_holding_me = WEAKREF(holder_model.robot)

	RegisterSignal(holder_model.robot, COMSIG_LIVING_DEATH, PROC_REF(empty_contents))


/obj/item/borg/hydraulic_clamp/Destroy()
	var/mob/living/silicon/robot/robot_holder = cyborg_holding_me?.resolve()
	if(robot_holder)
		UnregisterSignal(robot_holder, COMSIG_LIVING_DEATH)
	return ..()


/obj/item/borg/hydraulic_clamp/examine(mob/user)
	. = ..()
	. += span_notice("它的货舱容量为 [storage_capacity]，目前装有 <b>[contents.len ? contents.len : 0]</b> 件物品！")
	if(storage_capacity > 1)
		. += span_notice("在手中使用，可选择你希望优先从储存中取出的物品。")


/// A simple proc to empty the contents of the hydraulic clamp, forcing them on the turf it's on. Also forces `selected_item_index` to 0, to avoid any possible issues resulting from it.
/obj/item/borg/hydraulic_clamp/proc/empty_contents()
	SIGNAL_HANDLER

	selected_item_index = 0
	var/spilled_amount = 0
	var/turf/turf_of_clamp = get_turf(src)
	for(var/atom/movable/item in contents)
		item.forceMove(turf_of_clamp)
		spilled_amount++

	if(spilled_amount)
		var/holder = cyborg_holding_me?.resolve()
		if(holder)
			visible_message(span_warning("[cyborg_holding_me?.resolve()] 把 [src] 货舱里的东西撒了一地！"))


/obj/item/borg/hydraulic_clamp/attack_self(mob/user, modifiers)
	if(storage_capacity <= 1) // No need for selection if there's one or less item at maximum in the clamp.
		return

	selected_item_index = 0

	if(contents.len <= 1)
		to_chat(user, span_warning("目前 [src] 的货舱里[contents.len ? "只有一件物品" : "什么都没有"]，不用挑！"))
		return

	. = ..()

	var/list/choices = list()
	var/index = 1
	for(var/item in contents)
		choices[item] = index
		index++

	var/selection = tgui_input_list(user, "你想优先取出哪件物品？", "选择优先取出的物品", choices)
	if(!selection)
		return

	var/new_index = choices[selection]
	if(!new_index)
		return

	selected_item_index = new_index
	to_chat(user, span_notice("[src] 现在会优先卸下 [selection]。"))


/obj/item/borg/hydraulic_clamp/emp_act(severity)
	. = ..()
	empty_contents()


/obj/item/borg/hydraulic_clamp/pre_attack(atom/attacked_atom, mob/living/silicon/robot/user, params)
	if(!istype(user) || !user.Adjacent(attacked_atom) || !COOLDOWN_FINISHED(src, clamp_cooldown) || in_use)
		return

	// Not enough charge? Tough luck.
	if(user?.cell.charge < charge_cost)
		to_chat(user, span_warning("你的内部电池电量不足以使用 [src]。"))
		return

	user.cell.use(charge_cost)
	in_use = TRUE
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	// We're trying to unload something from the clamp, only possible on the floor, tables and conveyors.
	if(isturf(attacked_atom) || istype(attacked_atom, /obj/structure/table) || istype(attacked_atom, /obj/machinery/conveyor))
		if(!contents.len)
			in_use = FALSE
			return

		var/extraction_index = selected_item_index ? selected_item_index : contents.len
		var/atom/movable/extracted_item = contents[extraction_index]
		selected_item_index = 0

		if(unloading_time > 0.5 SECONDS) // We don't want too much chat spam if the clamp works fast.
			to_chat(user, span_notice("你开始从 [src] 中卸下东西……"))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)
		COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

		if(!do_after(user, unloading_time, attacked_atom))
			in_use = FALSE
			return

		var/turf/extraction_turf = get_turf(attacked_atom)
		extracted_item.forceMove(extraction_turf)
		visible_message(span_notice("[src.loc] 从 [src] 中卸下了 [extracted_item]。"))
		log_silicon("[user] 将 [extracted_item] 卸载到 [extraction_turf]（[AREACOORD(extraction_turf)]）。")
		in_use = FALSE
		return

	// We're trying to load something in the clamp
	else
		if(whitelisted_contents && !is_type_in_list(attacked_atom, whitelisted_item_types))
			to_chat(user, span_warning("[src] 只能夹取[whitelisted_item_description]！"))
			in_use = FALSE
			return

		if(contents.len >= storage_capacity)
			to_chat(user, span_warning("[src] 已达到最大容量！"))
			in_use = FALSE
			return

		if(item_weight_limit)
			var/obj/item/to_lift = attacked_atom
			if(!to_lift || to_lift.w_class > item_weight_limit)
				to_chat(user, span_warning("[to_lift] 太大了，[src] 装不下！"))
				in_use = FALSE
				return

		var/atom/movable/lifting_up = attacked_atom

		if(lifting_up.anchored)
			to_chat(user, span_warning("[lifting_up] 已被牢牢固定，目前无法把它移入 [src]！"))
			in_use = FALSE
			return

		var/contains_mobs = FALSE

		if(istype(lifting_up, /obj/item/delivery/big))
			var/obj/item/delivery/big/parcel = lifting_up
			if(parcel.contains_mobs)
				if(!can_hold_mobs)
					to_chat(user, span_warning("[src] 的警示灯闪起红光：[parcel] 里面可能装着活物！"))
					in_use = FALSE
					return
				contains_mobs = TRUE
			parcel.set_anchored(TRUE)

		lifting_up.add_fingerprint(user)

		if(loading_time > 0.5 SECONDS) // We don't want too much chat spam if the clamp works fast.
			to_chat(user, span_notice("你开始把 [lifting_up] 装进 [src] 的货舱……"))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)

		if(!do_after(user, loading_time, lifting_up)) // It takes two seconds to put stuff into the clamp's cargo hold
			lifting_up.set_anchored(initial(lifting_up.anchored))
			in_use = FALSE
			return

		lifting_up.set_anchored(FALSE)
		lifting_up.forceMove(src)
		var/turf/lifting_up_from = get_turf(lifting_up.loc)
		log_silicon("[user] 将 [lifting_up]（含生物：[contains_mobs]）装入 [src]，位置（[AREACOORD(lifting_up_from)]）。")
		visible_message(span_notice("[src.loc] 把 [lifting_up] 装进了 [src] 的货舱。"))
		in_use = FALSE

/// The fabled paper plane crossbow and its hardlight paper planes.
/obj/item/paperplane/syndicate/hardlight
	name = "硬光纸飞机"
	desc = "硬得足以伤人，也飘忽得根本无法捡起。"
	impact_eye_damage_lower = 10
	impact_eye_damage_higher = 10
	delete_on_impact = TRUE
	/// Which color is the paper plane?
	var/list/paper_colors = list(COLOR_CYAN, COLOR_BLUE_LIGHT, COLOR_BLUE)
	alpha = 150 // It's hardlight, it's gotta be see-through.


/obj/item/paperplane/syndicate/hardlight/Initialize(mapload)
	. = ..()
	color = color_hex2color_matrix(pick(paper_colors))
	alpha = initial(alpha) // It's hardlight, it's gotta be see-through.


/obj/item/borg/paperplane_crossbow
	name = "纸飞机弩"
	desc = "小心点，别瞄准眼睛——开什么玩笑，<i>当然</i>要瞄准眼睛！"
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "crossbow"
	/// How many planes does the crossbow currently have in its internal magazine?
	var/planes = 4
	/// Maximum of planes the crossbow can hold.
	var/max_planes = 4
	/// Time it takes to regenerate one plane
	var/charge_delay = 1 SECONDS
	/// Is the crossbow currently charging a new paper plane?
	var/charging = FALSE
	/// How long is the cooldown between shots?
	var/shooting_delay = 0.5 SECONDS
	/// Are we ready to fire again?
	COOLDOWN_DECLARE(shooting_cooldown)


/obj/item/borg/paperplane_crossbow/examine(mob/user)
	. = ..()
	. += span_notice("它的内置弹匣中还剩 <b>[planes]</b> 架，上限为 [max_planes]。")
	var/charging_speed = 10 / charge_delay
	. += span_notice("它以每秒 <b>[charging_speed]</b> 架的速度充能。")


/obj/item/borg/paperplane_crossbow/equipped()
	. = ..()
	check_amount()


/obj/item/borg/paperplane_crossbow/dropped()
	. = ..()
	check_amount()


/// A simple proc to check if we're at the max amount of planes, if not, we keep on charging. Called by [/obj/item/borg/paperplane_crossbow/proc/charge_paper_planes()].
/obj/item/borg/paperplane_crossbow/proc/check_amount()
	if(!charging && planes < max_planes)
		addtimer(CALLBACK(src, PROC_REF(charge_paper_planes)), charge_delay)
		charging = TRUE


/// A simple proc to charge paper planes, that then calls [/obj/item/borg/paperplane_crossbow/proc/check_amount()] to see if it should charge another one, over and over.
/obj/item/borg/paperplane_crossbow/proc/charge_paper_planes()
	planes++
	charging = FALSE
	check_amount()


/// A proc for shooting a projectile at the target, it's just that simple, really.
/obj/item/borg/paperplane_crossbow/proc/shoot(atom/target, mob/living/user)
	if(!COOLDOWN_FINISHED(src, shooting_cooldown))
		return ITEM_INTERACT_BLOCKING
	if(planes <= 0)
		to_chat(user, span_warning("纸飞机不够了！"))
		return ITEM_INTERACT_BLOCKING
	planes--

	var/obj/item/paperplane/syndicate/hardlight/plane_to_fire = new /obj/item/paperplane/syndicate/hardlight(get_turf(src.loc))

	playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	plane_to_fire.throw_at(target, plane_to_fire.throw_range, plane_to_fire.throw_speed, user)
	COOLDOWN_START(src, shooting_cooldown, shooting_delay)
	user.visible_message(span_warning("[user] 朝 [target] 射出一架纸飞机！"))
	check_amount()
	return ITEM_INTERACT_SUCCESS


/obj/item/borg/paperplane_crossbow/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	check_amount()
	if(!iscyborg(user))
		return ITEM_INTERACT_BLOCKING

	var/mob/living/silicon/robot/robot_user = user
	if(!robot_user.cell.use(STANDARD_CELL_CHARGE * 0.1))
		to_chat(user, span_warning("电量不足。"))
		return ITEM_INTERACT_BLOCKING
	return shoot(interacting_with, user)

/// Holders for the package wrap and the wrapping paper synthetizers.

/datum/robot_energy_storage/package_wrap
	name ="打包纸合成器"
	max_energy = 25
	recharge_rate = 2


/datum/robot_energy_storage/wrapping_paper
	name ="包装纸合成器"
	max_energy = 25
	recharge_rate = 2


/obj/item/stack/package_wrap/cyborg
	name = "集成打包纸"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/package_wrap


/obj/item/stack/wrapping_paper/xmas/cyborg
	name = "集成包装纸"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/wrapping_paper


/obj/item/stack/wrapping_paper/xmas/cyborg/use(used, transfer, check = FALSE) // Check is set to FALSE here, so the stack istn't deleted.
	. = ..()


/// Some override that didn't belong anywhere else.

/obj/item/delivery/big
	/// Does this wrapped package contain at least one mob?
	var/contains_mobs = FALSE

// I did this out of sanity, I didn't want to make the clamp code more complex than necessary, and honestly I'm considering taking this upstream, it just feels awkward to PR just that.
/obj/item/bounty_cube
	w_class = WEIGHT_CLASS_SMALL

#define BASE_NINJA_REAGENTS list(\
		/datum/reagent/medicine/inacusiate,\
		/datum/reagent/medicine/morphine,\
		/datum/reagent/medicine/potass_iodide,\
		/datum/reagent/medicine/syndicate_nanites,\
		/datum/reagent/consumable/nutriment\
	)


/obj/item/katana/ninja_blade
	name = "能量武士刀"
	desc = "一把注入了强大能量的武士刀。"
	force = 30
	icon_state = "energy_katana"
	inhand_icon_state = "energy_katana"
	worn_icon_state = "energy_katana"

/obj/item/shockpaddles/syndicate/cyborg/ninja
	name = "改装除颤器电极板"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "ninjapaddles0"
	base_icon_state = "ninjapaddles"

/obj/item/reagent_containers/borghypo/syndicate/ninja
	name = "改装半机械人无针注射器"
	desc = "一种实验性技术装置，可生成强效修复纳米机器人，用于极快地治疗各类损伤。它会代谢碘化钾以应对辐射中毒、代谢复聪素以治疗耳部损伤、代谢吗啡以供战斗之需，并为外勤特工提供营养。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "borghypo_n"
	charge_cost = 20
	recharge_time = 2
	default_reagent_types = BASE_NINJA_REAGENTS //That is for Ninja
	bypass_protection = TRUE //They still wearing suits, don't they?

/// Engineering Modules ///
/obj/item/crowbar/cyborg/power
	name = "模块化撬棍"
	desc = "一种半机械人装配的模块，外形类似生命之钳。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "jaws_pry_cyborg"
	usesound = 'sound/items/tools/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/power/examine()
	. = ..()
	. += " 它装配的是[tool_behaviour == TOOL_CROWBAR ? "撬动" : "剪切"]钳头。"

/obj/item/crowbar/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/tools/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("你把剪切钳头装到 [src] 上。"))
		icon_state = "jaws_cutter_cyborg"
		usesound = 'sound/items/tools/jaws_cut.ogg'
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, span_notice("你把撬动钳头装到 [src] 上。"))
		icon_state = "jaws_pry_cyborg"
		usesound = 'sound/items/tools/jaws_pry.ogg'

/obj/item/screwdriver/cyborg/power
	name =	"自动钻头"
	desc = "一种半机械人装配的模块，外形类似手钻。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "drill_screw_cyborg"
	hitsound = 'sound/items/tools/drill_hit.ogg'
	usesound = 'sound/items/tools/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE

/obj/item/screwdriver/cyborg/power/examine()
	. = ..()
	. += " 它装配的是[tool_behaviour == TOOL_SCREWDRIVER ? "螺丝" : "螺栓"]钻头。"

/obj/item/screwdriver/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/tools/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, span_notice("你把螺栓钻头装到 [src] 上。"))
		icon_state = "drill_bolt_cyborg"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("你把螺丝钻头装到 [src] 上。"))
		icon_state = "drill_screw_cyborg"

/// Shapeshifter
/obj/item/borg_shapeshifter
	name = "半机械人变色龙投影器"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "shield0"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/saved_icon
	var/saved_bubble_icon
	var/saved_icon_override
	var/saved_name
	var/saved_model_features
	var/saved_special_light_key
	var/saved_hat_offset
	var/active = FALSE
	var/activationCost = STANDARD_CELL_CHARGE * 0.1
	var/activationUpkeep = STANDARD_CELL_CHARGE * 0.005
	var/disguise_model_name
	var/disguise
	var/disguise_icon_override
	var/disguise_pixel_offset = 0
	var/disguise_hat_offset = 0
	/// Traits unique to this model (deadsprite, wide/dogborginess, etc.). Mirrors the definition in modular_skyrat\modules\borgs\code\modules\mob\living\silicon\robot\robot_model.dm
	var/list/disguise_model_features = list()
	var/disguise_special_light_key
	var/mob/listeningTo
	var/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_ATOM_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE

/obj/item/borg_shapeshifter/Initialize(mapload)
	. = ..()

/obj/item/borg_shapeshifter/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_shapeshifter/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/equipped(mob/user)
	. = ..()
	disrupt(user)

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 */
/obj/item/borg_shapeshifter/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/borg_shapeshifter/attack_self(mob/living/silicon/robot/user)
	if (user && use_power(user, activationCost))
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, span_warning("你在某个东西里面时无法使用 [src]！"))
	else
		to_chat(user, span_warning("你的电池至少需要 [activationCost] 电量才能使用 [src]！"))

/obj/item/borg_shapeshifter/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, span_notice("你关闭了 \the [src]。"))
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, span_notice("\the [src] 正在充能。"))
			return
		var/static/list/model_icons = sort_list(list(
			"标准" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "robot"),
			"医疗" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "medical"),
			"货运" = image(icon = CYBORG_ICON_CARGO, icon_state = "cargoborg"),
			"工程" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "engineer"),
			"安保" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "sec"),
			"服务" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "service_f"),
			"清洁" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "janitor"),
			"采矿" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "miner"),
			"维和" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "peace"),
			"小丑" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "clown"),
			"辛迪加" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "synd_sec"),
			"蜘蛛氏族" = image(icon = CYBORG_ICON_NINJA, icon_state = "ninja_engi"),
			"科研" = image(icon = 'modular_zubbers/code/modules/silicons/borgs/sprites/robot_sci.dmi', icon_state = "research"),
		))
		var/model_selection = show_radial_menu(user, user, model_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 42, require_near = TRUE)
		if(!model_selection)
			return FALSE

		var/obj/item/robot_model/model
		switch(model_selection)
			if("标准")
				model = new /obj/item/robot_model/standard
			if("医疗")
				model = new /obj/item/robot_model/medical
			if("货运")
				model = new /obj/item/robot_model/cargo
			if("工程")
				model = new /obj/item/robot_model/engineering
			if("安保")
				model = new /obj/item/robot_model/security
			if("服务")
				model = new /obj/item/robot_model/service
			if("清洁")
				model = new /obj/item/robot_model/janitor
			if("采矿")
				model = new /obj/item/robot_model/miner
			if("维和")
				model = new /obj/item/robot_model/peacekeeper
			if("小丑")
				model = new /obj/item/robot_model/clown
			if("辛迪加")
				model = new /obj/item/robot_model/syndicatejack
			if("蜘蛛氏族")
				model = new /obj/item/robot_model/ninja
			if("科研")
				model = new /obj/item/robot_model/sci
			else
				return FALSE
		if (!set_disguise_vars(model, user))
			qdel(model)
			return FALSE
		qdel(model)
		animation_playing = TRUE
		to_chat(user, span_notice("你启动 \the [src]。"))
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		var/start = user.filters.len
		var/X,Y,rsq,i,f
		for(i=1, i<=7, ++i)
			do
				X = 60*rand() - 30
				Y = 60*rand() - 30
				rsq = X*X + Y*Y
			while(rsq<100 || rsq>900)
			user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
		for(i=1, i<=7, ++i)
			f = user.filters[start+i]
			animate(f, offset=f:offset, time=0, loop=3, flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1, time=rand()*20+10)
		if (do_after(user, 5 SECONDS, target=user) && use_power(user, activationCost))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, span_notice("你现在已伪装完毕。"))
			activate(user)
		else
			to_chat(user, span_warning("变色龙力场嘶嘶作响，随即消散。"))
			do_sparks(3, FALSE, user)
			for(i=1, i<=min(7, user.filters.len), ++i) // removing filters that are animating does nothing, we gotta stop the animations first
				f = user.filters[start+i]
				animate(f)
		user.filters = null
		animation_playing = FALSE

/obj/item/borg_shapeshifter/proc/set_disguise_vars(obj/item/robot_model/disguise_model, mob/living/silicon/robot/cyborg)
	if (!disguise_model || !cyborg)
		return FALSE
	var/list/reskin_icons = list()
	for(var/skin in disguise_model.borg_skins)
		var/list/details = disguise_model.borg_skins[skin]
		var/image/reskin = image(icon = details[SKIN_ICON] || 'icons/mob/silicon/robots.dmi', icon_state = details[SKIN_ICON_STATE])
		if (!isnull(details[SKIN_FEATURES]))
			if ((TRAIT_R_WIDE in details[SKIN_FEATURES]) || (TRAIT_R_BIG in details[SKIN_FEATURES]))
				reskin.pixel_x -= 16
		reskin_icons[skin] = reskin
	var/borg_skin = show_radial_menu(cyborg, cyborg, reskin_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), cyborg), radius = 38, require_near = TRUE)
	if(!borg_skin)
		return FALSE
	disguise_model_name = disguise_model.name
	var/list/details = disguise_model.borg_skins[borg_skin]
	disguise = details[SKIN_ICON_STATE]
	disguise_icon_override = details[SKIN_ICON]
	disguise_special_light_key = details[SKIN_LIGHT_KEY]
	disguise_hat_offset = 0 || details[SKIN_HAT_OFFSET]
	disguise_model_features = details[SKIN_FEATURES]
	return TRUE

/obj/item/borg_shapeshifter/process()
	if (user && !use_power(user, activationUpkeep))
		disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_shapeshifter/proc/use_power(mob/living/silicon/robot/user, amount)
	if(!istype(user))
		return 0
	if(!amount)
		return 1
	return user.cell?.use(amount)

/obj/item/borg_shapeshifter/proc/activate(mob/living/silicon/robot/user)
	src.user = user
	START_PROCESSING(SSobj, src)
	saved_icon = user.model.cyborg_base_icon
	saved_bubble_icon = user.bubble_icon
	saved_icon_override = user.model.cyborg_icon_override
	saved_name = user.model.name
	saved_model_features = user.model.model_features
	saved_special_light_key = user.model.special_light_key
	saved_hat_offset = user.model.hat_offset
	user.model.name = disguise_model_name
	user.model.cyborg_base_icon = disguise
	user.model.cyborg_icon_override = disguise_icon_override
	user.model.model_features = disguise_model_features
	user.model.special_light_key = disguise_special_light_key
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()
	user.model.update_tallborg()
	user.model.update_quadruped()
	user.model.update_robot_rest()
	user.model.update_footsteps()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignals(user, signalCache, PROC_REF(disrupt))
	listeningTo = user

/obj/item/borg_shapeshifter/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.model.name = saved_name
	user.model.cyborg_base_icon = saved_icon
	user.model.cyborg_icon_override = saved_icon_override
	user.icon = saved_icon_override
	user.model.model_features = saved_model_features
	user.model.special_light_key = saved_special_light_key
	user.bubble_icon = saved_bubble_icon
	active = FALSE
	user.update_icons()
	user.model.update_tallborg()
	user.model.update_quadruped()
	user.model.update_robot_rest()
	user.model.update_footsteps()

/obj/item/borg_shapeshifter/proc/disrupt(mob/living/silicon/robot/user)
	SIGNAL_HANDLER
	if(active)
		to_chat(user, span_danger("你的变色龙力场失效了。"))
		deactivate(user)

// Quadruped tongue - lick lick
/obj/item/quadborg_tongue
	name = "合成舌头"
	desc = "在亲昵地舔船员的脸之前，用来把地板上的污物吸干净很有用。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/blob/attackblob.ogg'
	desc = "用来献上亲昵的吻。"
	item_flags = NOBLUDGEON

/obj/item/quadborg_tongue/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!isliving(target))
		return NONE

	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		if(check_zone(borg.zone_selected) == "head")
			borg.visible_message(span_warning("\the [borg] 亲昵地舔了舔 \the [mob] 的脸！"), span_notice("你亲昵地舔了舔 \the [mob] 的脸！"))
			playsound(borg, 'sound/effects/blob/attackblob.ogg', 50, 1)
		else
			borg.visible_message(span_warning("\the [borg] 亲昵地舔了舔 \the [mob]！"), span_notice("你亲昵地舔了舔 \the [mob]！"))
			playsound(borg, 'sound/effects/blob/attackblob.ogg', 50, 1)
		return ITEM_INTERACT_SUCCESS
	else
		to_chat(user, span_warning("错误：[target] 在禁止舔舐名单上！"))
		return ITEM_INTERACT_BLOCKING

// Quadruped nose - Boop
/obj/item/quadborg_nose
	name = "顶鼻模块"
	desc = "专门用来“啵”人的模块。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "nose"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	force = 0

/obj/item/quadborg_nose/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		do_attack_animation(target, null, src)
		user.visible_message(span_notice("[user] 用鼻子[pick("蹭了蹭", "顶了顶", "碰了碰")] \the [target.name]！"))
		return ITEM_INTERACT_SUCCESS
	else
		to_chat(user, span_warning("错误：[target] 在禁止蹭鼻名单上！"))
		return ITEM_INTERACT_BLOCKING

/// Better Clamp
/obj/item/borg/hydraulic_clamp/better
	name = "改进型集成液压夹钳"
	desc = "一种利落的搬运方式，可抬起并移动货箱，实现快速无痛的投递！"
	storage_capacity = 4
	whitelisted_item_types = list(/obj/structure/closet/crate, /obj/item/delivery/big, /obj/item/delivery, /obj/item/bounty_cube) // If they want to carry a small package or a bounty cube instead, so be it, honestly.
	whitelisted_item_description = "已打包的包裹"
	item_weight_limit = NONE
	clamp_sound_volume = 50

/obj/item/borg/hydraulic_clamp/better/examine(mob/user)
	. = ..()
	var/crate_count = contents.len
	. += "夹钳的内部储存中目前存有 <b>[crate_count > 0 ? crate_count : "零"]</b> 个货箱。"

/obj/item/borg/hydraulic_clamp/mail
	name = "集成快速邮件投递装置"
	desc = "让你能随身携带大量邮件，像一只乖巧的小邮差机器人那样在空间站里分发它们！"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "bookbag"
	storage_capacity = 100
	loading_time = 0.25 SECONDS
	unloading_time = 0.25 SECONDS
	cooldown_duration = 0.25 SECONDS
	whitelisted_item_types = list(/obj/item/mail)
	whitelisted_item_description = "信封"
	item_weight_limit = WEIGHT_CLASS_NORMAL
	clamp_sound_volume = 25
	clamp_sound = 'sound/items/pshoom/pshoom.ogg'

/obj/item/borg/forging_setup
	name = "集成锻造分配器"
	desc = "让半机械人消耗电力生成锻造所需的结构。"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "forge_dispense"
	/// how much charge the item will use per use
	var/charge_cost = 1000

/obj/item/borg/forging_setup/attack_self(mob/user, modifiers)
	var/mob/living/silicon/robot/robot_user = user
	if(!istype(robot_user)) //you have to be a borg to use this item
		to_chat(user, span_warning("必须由半机械人使用 [src]！"))
		return

	if(robot_user.cell.charge < charge_cost)
		to_chat(user, span_warning("电量不足！"))
		return

	var/turf/src_turf = get_turf(src)
	if(!isopenturf(src_turf) || isspaceturf(src_turf))
		to_chat(user, span_warning("必须建造在坚固的地面上！"))
		return

	for(var/obj/structure/locate_structure in src_turf)
		if(locate_structure.density)
			to_chat(user, span_warning("必须建造在空地上！"))
			return

	robot_user.cell.use(charge_cost)

	var/choice = tgui_input_list(user, "你想生成哪种结构？", "结构选择", list("锻造炉", "铁砧", "锻造淬火槽", "锻造工作台"))
	if(isnull(choice))
		return
	switch(choice)
		if("锻造炉")
			new /obj/structure/reagent_forge(src_turf)
		if("铁砧")
			new /obj/structure/reagent_anvil(src_turf)
		if("锻造淬火槽")
			new /obj/structure/reagent_dispensers/reagent_smithing_basin(src_turf)
		if("锻造工作台")
			new /obj/structure/reagent_crafting_bench(src_turf)

#undef CYBORG_FONT
#undef MAX_PAPER_INTEGRATED_CLIPBOARD
#undef BASE_NINJA_REAGENTS
