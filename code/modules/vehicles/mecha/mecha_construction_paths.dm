/// Mecha construction
/datum/component/construction/mecha
	var/base_icon

	// Component typepaths.
	// most must be defined unless
	// get_steps is overriden.

	// Circuit board typepaths.
	// circuit_control and circuit_periph must be defined
	// unless get_circuit_steps is overriden.
	var/circuit_control
	var/circuit_periph
	var/circuit_weapon

	// Armor plating typepaths. both must be defined
	// unless relevant step procs are overriden. amounts
	// must be defined if using /obj/item/stack/sheet types
	var/obj/inner_plating
	var/inner_plating_amount

	var/obj/outer_plating
	var/outer_plating_amount

/datum/component/construction/mecha/spawn_result()
	if(!result)
		return
	// Remove default mech power cell, as we replace it with a new one.
	var/obj/vehicle/sealed/mecha/mech = new result(drop_location(), /* built_manually = */ TRUE)
	var/obj/item/mecha_parts/chassis/parent_chassis = parent
	for(var/atom/movable/content in parent_chassis.contents)
		content.forceMove(mech)
	mech.locate_parts()
	SSblackbox.record_feedback("tally", "mechas_created", 1, mech.name)
	ADD_TRAIT(mech, TRAIT_MECHA_CREATED_NORMALLY, REF(mech))
	QDEL_NULL(parent)

// Default proc to generate mech steps.
// Override if the mech needs an entirely custom process (See HONK mech)
// Otherwise override specific steps as needed (Ripley, Clarke, Phazon)
/datum/component/construction/mecha/proc/get_steps()
	var/list/all_steps = \
		get_frame_steps() + \
		get_circuit_steps() + \
		get_circuit_weapon_steps() + \
		get_stockpart_steps() + \
		get_inner_plating_steps() + \
		get_outer_plating_steps()

	// If you don't set a construction icon state, one will automatically be assigned
	// based on the index of the step in the step list
	//
	// If you do set a custom icon state, it will not be overridden, but the state will still increment.
	//
	// You can use skip_state to prevent a step from increasing the index,
	// useful for steps which don't affect the mech's appearance at all
	// or for steps which have custom icon states that don't follow the normal pattern.
	var/state = 0
	for(var/list/step_data as anything in all_steps)
		if(step_data["skip_state"])
			continue

		step_data["icon_state"] ||= "[base_icon][state]"
		state += 1

	return all_steps

/datum/component/construction/mecha/Initialize()
	steps ||= get_steps()
	return ..()

/datum/component/construction/unordered/mecha_chassis/custom_action(obj/item/I, mob/living/user, typepath)
	. = user.transferItemToLoc(I, parent)
	if(.)
		var/atom/parent_atom = parent
		user.balloon_alert_to_viewers("已连接 [I]")
		parent_atom.add_overlay(I.icon_state+"+o")
		qdel(I)

/datum/component/construction/unordered/mecha_chassis/spawn_result()
	var/atom/parent_atom = parent
	parent_atom.icon = 'icons/mob/rideables/mech_construction.dmi'
	parent_atom.set_density(TRUE)
	parent_atom.cut_overlays()
	return ..()

// Default proc for the first steps of mech construction.
/datum/component/construction/mecha/proc/get_frame_steps()
	return list(
		list(
			"key" = TOOL_WRENCH,
			"desc" = "液压系统可以用<b>扳手</b>连接。",
			"forward_message" = "已连接液压系统",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WRENCH,
			"desc" = "液压系统已连接，可以用<b>螺丝刀</b>激活。",
			"forward_message" = "已激活液压系统",
			"backward_message" = "已断开液压系统",
		),
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "液压系统已激活，可以为框架<b>布线</b>。",
			"forward_message" = "已添加线路",
			"backward_message" = "已停用液压系统",
		),
		list(
			"key" = TOOL_WIRECUTTER,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "线路已添加，可以用<b>剪线钳</b>调整。",
			"forward_message" = "已调整线路",
			"backward_message" = "已移除线路",
		)
	)

// Default proc for the circuit board steps of a mech.
// Second set of steps by default.
/datum/component/construction/mecha/proc/get_circuit_steps()
	return list(
		list(
			"key" = circuit_control,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "线路已调整，<b>中央控制模块</b>插槽已打开。",
			"forward_message" = "已添加中央控制模块",
			"backward_message" = "已断开线路",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "中央控制模块已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定中央控制模块",
			"backward_message" = "已移除中央控制模块",
		),
		list(
			"key" = circuit_periph,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "中央控制模块已固定，<b>外围控制模块</b>插槽已打开。",
			"forward_message" = "已添加外围控制模块",
			"backward_message" = "已松开中央控制模块",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "外围控制模块已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定外围控制模块",
			"backward_message" = "已移除外围控制模块",
		)
	)

// Default proc for weapon circuitboard steps
// Used by combat mechs
/datum/component/construction/mecha/proc/get_circuit_weapon_steps()
	if(!circuit_weapon)
		return list()

	return list(
		list(
			"key" = circuit_weapon,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "外围控制模块已固定，<b>武器控制模块</b>插槽已打开。",
			"forward_message" = "已添加武器控制模块",
			"backward_message" = "已松开外围控制模块",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "武器控制模块已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定武器控制模块",
			"backward_message" = "已移除武器控制模块",
		)
	)


// Default proc for stock part installation
// Third set of steps by default
/datum/component/construction/mecha/proc/get_stockpart_steps()
	var/prevstep_text = circuit_weapon ? "武器控制模块已固定" : "外围控制模块已固定"
	prevstep_text += "，可以添加<b>扫描模块</b>。"
	var/backward_text = circuit_weapon ? "已松开武器控制模块" : "已松开外围模块"
	return list(
		list(
			"key" = /obj/item/stock_parts/scanning_module,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = prevstep_text,
			"forward_message" = "已添加扫描模块",
			"backward_message" = backward_text,
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "扫描模块已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定扫描模块",
			"backward_message" = "已移除扫描模块",
		),
		list(
			"key" = /obj/item/stock_parts/capacitor,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "扫描模块已固定，可以添加<b>电容</b>。",
			"forward_message" = "已添加电容",
			"backward_message" = "已松开扫描模块",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "电容已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定电容",
			"backward_message" = "已移除电容",
		),
		list(
			"key" = /obj/item/stock_parts/servo,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "扫描模块已固定，可以添加<b>伺服电机</b>。",
			"forward_message" = "已添加伺服电机",
			"backward_message" = "已松开电容",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "伺服电机已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定伺服电机",
			"backward_message" = "已移除伺服电机",
		),
		list(
			"key" = /obj/item/stock_parts/power_store/cell,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "伺服电机已固定，可以添加<b>电池</b>。",
			"forward_message" = "已添加电池",
			"backward_message" = "已松开伺服电机",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "电池已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定电池",
			"backward_message" = "已移除电池",
		)
	)

// Default proc for inner armor plating
// Fourth set of steps by default
/datum/component/construction/mecha/proc/get_inner_plating_steps()
	var/list/first_step
	if(ispath(inner_plating, /obj/item/stack/sheet))
		first_step = list(
			list(
				"key" = inner_plating,
				"amount" = inner_plating_amount,
				"back_key" = TOOL_SCREWDRIVER,
				"desc" = "电池已固定，可以用 [inner_plating_amount] 片[initial(inner_plating.name)]作为内层装甲。",
				"forward_message" = "已安装内部装甲层",
				"backward_message" = "已松开电池",
			)
		)
	else
		first_step = list(
			list(
				"key" = inner_plating,
				"action" = ITEM_DELETE,
				"back_key" = TOOL_SCREWDRIVER,
				"desc" = "电池已固定，可以用[initial(inner_plating.name)]作为内层装甲。",
				"forward_message" = "已安装内部装甲层",
				"backward_message" = "已松开电池",
			)
		)

	return first_step + list(
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "内层装甲已安装，可以用<b>扳手</b>固定。",
			"forward_message" = "已固定内部装甲层",
			"backward_message" = "已撬下内部装甲层",
		),
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "内层装甲已用扳手固定，可以进行<b>焊接</b>。",
			"forward_message" = "已焊接内部装甲层",
			"backward_message" = "已松开内部装甲层",
		)
	)

// Default proc for outer armor plating
// Fifth set of steps by default
/datum/component/construction/mecha/proc/get_outer_plating_steps()
	var/list/first_step
	if(ispath(outer_plating, /obj/item/stack/sheet))
		first_step = list(
			list(
				"key" = outer_plating,
				"amount" = outer_plating_amount,
				"back_key" = TOOL_WELDER,
				"desc" = "内层装甲已焊接，可以用 [outer_plating_amount] 片[initial(outer_plating.name)]作为外部装甲。",
				"forward_message" = "已安装外部装甲层",
				"backward_message" = "已切下内部装甲层",
			)
		)
	else
		first_step = list(
			list(
				"key" = outer_plating,
				"action" = ITEM_DELETE,
				"back_key" = TOOL_WELDER,
				"desc" = "内层装甲已焊接，可以用[initial(outer_plating.name)]作为外部装甲。",
				"forward_message" = "已安装外部装甲层",
				"backward_message" = "已切下内部装甲层",
			)
		)

	return first_step + list(
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "外部装甲已安装，可以用<b>扳手</b>固定。",
			"forward_message" = "已固定外部装甲层",
			"backward_message" = "已撬下外部装甲层",
		),
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "外部装甲已用扳手固定，可以进行<b>焊接</b>。",
			"forward_message" = "已焊接外部装甲层",
			"backward_message" = "已松开外部装甲层",
		)
	)

/// Generic mech construction messages
/datum/component/construction/mecha/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	if(diff == FORWARD && steps[index]["forward_message"])
		user.balloon_alert_to_viewers(steps[index]["forward_message"])
		var/list/next_step = index == steps.len ? null : steps[index + 1]
		if(next_step?["desc"])
			to_chat(user, span_smallnoticeital(next_step["desc"]))

	else if(steps[index]["backward_message"])
		user.balloon_alert_to_viewers(steps[index]["backward_message"])
		var/list/last_step = index <= 1 ? null : steps[index - 1]
		if(last_step?["desc"])
			to_chat(user, span_smallnoticeital(last_step["desc"]))

	return TRUE

//RIPLEY
/datum/component/construction/unordered/mecha_chassis/ripley
	result = /datum/component/construction/mecha/ripley
	steps = list(
		/obj/item/mecha_parts/part/ripley_torso,
		/obj/item/mecha_parts/part/ripley_left_arm,
		/obj/item/mecha_parts/part/ripley_right_arm,
		/obj/item/mecha_parts/part/ripley_left_leg,
		/obj/item/mecha_parts/part/ripley_right_leg
	)

/datum/component/construction/mecha/ripley
	result = /obj/vehicle/sealed/mecha/ripley
	base_icon = "ripley"

	circuit_control = /obj/item/circuitboard/mecha/ripley/main
	circuit_periph = /obj/item/circuitboard/mecha/ripley/peripherals

	inner_plating=/obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating=/obj/item/stack/rods
	outer_plating_amount = 10

/datum/component/construction/mecha/ripley/get_outer_plating_steps()
	// we yoink the first step of adding plating and modify the flavor a bit
	var/list/first_step = ..()[1]
	first_step["desc"] = "装甲已焊接，可以用 10 根<b>金属杆</b>安装驾驶舱。"
	first_step["forward_message"] = "已安装驾驶舱"
	first_step["backward_message"] = "已切下装甲"

	// then we add our own second step for welding the cockpit in place
	return list(
		first_step,
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "驾驶舱防撞网已安装，可以进行<b>焊接</b>。",
			"forward_message" = "已焊接驾驶舱",
			"backward_message" = "已切下驾驶舱",
		)
	)

//GYGAX
/datum/component/construction/unordered/mecha_chassis/gygax
	result = /datum/component/construction/mecha/gygax
	steps = list(
		/obj/item/mecha_parts/part/gygax_torso,
		/obj/item/mecha_parts/part/gygax_left_arm,
		/obj/item/mecha_parts/part/gygax_right_arm,
		/obj/item/mecha_parts/part/gygax_left_leg,
		/obj/item/mecha_parts/part/gygax_right_leg,
		/obj/item/mecha_parts/part/gygax_head
	)

/datum/component/construction/mecha/gygax
	result = /obj/vehicle/sealed/mecha/gygax
	base_icon = "gygax"

	circuit_control = /obj/item/circuitboard/mecha/gygax/main
	circuit_periph = /obj/item/circuitboard/mecha/gygax/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/gygax/targeting

	inner_plating = /obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating=/obj/item/mecha_parts/part/gygax_armor
	outer_plating_amount=1

/datum/component/construction/mecha/gygax/action(datum/source, atom/used_atom, mob/user)
	ASYNC //This proc will never actually sleep, it calls do_after with a time of 0.
		. = check_step(used_atom, user)
	return .

//CLARKE
/datum/component/construction/unordered/mecha_chassis/clarke
	result = /datum/component/construction/mecha/clarke
	steps = list(
		/obj/item/mecha_parts/part/clarke_torso,
		/obj/item/mecha_parts/part/clarke_left_arm,
		/obj/item/mecha_parts/part/clarke_right_arm,
		/obj/item/mecha_parts/part/clarke_head
	)

/datum/component/construction/mecha/clarke
	result = /obj/vehicle/sealed/mecha/clarke
	base_icon = "clarke"

	circuit_control = /obj/item/circuitboard/mecha/clarke/main
	circuit_periph = /obj/item/circuitboard/mecha/clarke/peripherals

	inner_plating = /obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating = /obj/item/stack/sheet/plasteel
	outer_plating_amount = 5

/datum/component/construction/mecha/clarke/get_frame_steps()
	return list(
		list(
			"key" = /obj/item/stack/conveyor,
			"amount" = 4,
			"desc" = "可以使用 4 片传送带添加履带。",
			"forward_message" = "已添加履带系统",
		),
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "履带已安装，液压系统可以用<b>扳手</b>连接。",
			"forward_message" = "已连接液压系统",
			"backward_message" = "已移除履带系统"
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WRENCH,
			"desc" = "液压系统已连接，可以用<b>螺丝刀</b>激活。",
			"forward_message" = "已激活液压系统",
			"backward_message" = "已断开液压系统"
		),
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "液压系统已激活，可以为框架<b>布线</b>。",
			"forward_message" = "已添加线路",
			"backward_message" = "已停用液压系统"
		),
		list(
			"key" = TOOL_WIRECUTTER,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "线路已添加，可以用<b>剪线钳</b>调整。",
			"forward_message" = "已调整线路",
			"backward_message" = "已移除线路"
		)
	)

//HONKER
/datum/component/construction/unordered/mecha_chassis/honker
	result = /datum/component/construction/mecha/honker
	steps = list(
		/obj/item/mecha_parts/part/honker_torso,
		/obj/item/mecha_parts/part/honker_left_arm,
		/obj/item/mecha_parts/part/honker_right_arm,
		/obj/item/mecha_parts/part/honker_left_leg,
		/obj/item/mecha_parts/part/honker_right_leg,
		/obj/item/mecha_parts/part/honker_head
	)

/datum/component/construction/mecha/honker
	result = /obj/vehicle/sealed/mecha/honker
	steps = list(
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!"
		),
		list(
			"key" = /obj/item/circuitboard/mecha/honker/main,
			"action" = ITEM_DELETE,
			"desc" = "可以添加滑稽<b>中央电路板</b>！",
			"forward_message" = "已添加滑稽"

		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!"
		),
		list(
			"key" = /obj/item/circuitboard/mecha/honker/peripherals,
			"action" = ITEM_DELETE,
			"desc" = "可以添加玩笑<b>外围电路板</b>！",
			"forward_message" = "已添加玩笑"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!"
		),
		list(
			"key" = /obj/item/circuitboard/mecha/honker/targeting,
			"action" = ITEM_DELETE,
			"desc" = "可以添加恶作剧<b>瞄准电路板</b>！",
			"forward_message" = "已添加恶作剧"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!"
		),
		list(
			"key" = /obj/item/stock_parts/scanning_module,
			"action" = ITEM_MOVE_INSIDE,
			"desc" = "可以添加傻气<b>扫描</b>模块！",
			"forward_message" = "已添加傻气"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!!"
		),
		list(
			"key" = /obj/item/stock_parts/capacitor,
			"action" = ITEM_MOVE_INSIDE,
			"desc" = "可以添加幽默<b>电容</b>！",
			"forward_message" = "已添加幽默"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!!!"
		),
		list(
			"key" = /obj/item/stock_parts/servo,
			"action" = ITEM_MOVE_INSIDE,
			"desc" = "可以添加幽默<b>伺服电机</b>！",
			"forward_message" = "已添加笑容"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!!!"
		),
		list(
			"key" = /obj/item/stock_parts/power_store/cell,
			"action" = ITEM_MOVE_INSIDE,
			"desc" = "可以添加欢笑<b>电池</b>！",
			"forward_message" = "已添加欢笑"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!!!!"
		),
		list(
			"key" = /obj/item/clothing/mask/gas/clown_hat,
			"action" = ITEM_DELETE,
			"desc" = "可以隆重地添加小丑面具！",
			"forward_message" = "已添加面具"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "HONK!!!!!!!!"
		),
		list(
			"key" = /obj/item/clothing/shoes/clown_shoes,
			"action" = ITEM_DELETE,
			"desc" = "可以虔诚地添加小丑鞋！",
			"forward_message" = "已添加鞋子"
		),
		list(
			"key" = /obj/item/bikehorn,
			"desc" = "如果你足够勇敢，就再按一次喇叭。"
		),
	)

/datum/component/construction/mecha/honker/get_steps()
	return steps

// HONK doesn't have any construction step icons, so we just set an icon once.
/datum/component/construction/mecha/honker/update_parent(step_index)
	if(step_index == 1)
		var/atom/parent_atom = parent
		parent_atom.icon = 'icons/mob/rideables/mech_construct.dmi'
		parent_atom.icon_state = "honker_chassis"
	return ..()

/datum/component/construction/mecha/honker/custom_action(obj/item/I, mob/living/user, diff)
	if(istype(I, /obj/item/bikehorn))
		playsound(parent, 'sound/items/bikehorn.ogg', 50, TRUE)
		user.balloon_alert_to_hearers("*HONK*")
		return TRUE

	return ..()

//DURAND
/datum/component/construction/unordered/mecha_chassis/durand
	result = /datum/component/construction/mecha/durand
	steps = list(
		/obj/item/mecha_parts/part/durand_torso,
		/obj/item/mecha_parts/part/durand_left_arm,
		/obj/item/mecha_parts/part/durand_right_arm,
		/obj/item/mecha_parts/part/durand_left_leg,
		/obj/item/mecha_parts/part/durand_right_leg,
		/obj/item/mecha_parts/part/durand_head
	)

/datum/component/construction/mecha/durand
	result = /obj/vehicle/sealed/mecha/durand
	base_icon = "durand"

	circuit_control = /obj/item/circuitboard/mecha/durand/main
	circuit_periph = /obj/item/circuitboard/mecha/durand/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/durand/targeting

	inner_plating = /obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating = /obj/item/mecha_parts/part/durand_armor
	outer_plating_amount = 1

//PHAZON
/datum/component/construction/unordered/mecha_chassis/phazon
	result = /datum/component/construction/mecha/phazon
	steps = list(
		/obj/item/mecha_parts/part/phazon_torso,
		/obj/item/mecha_parts/part/phazon_left_arm,
		/obj/item/mecha_parts/part/phazon_right_arm,
		/obj/item/mecha_parts/part/phazon_left_leg,
		/obj/item/mecha_parts/part/phazon_right_leg,
		/obj/item/mecha_parts/part/phazon_head
	)

/datum/component/construction/mecha/phazon
	result = /obj/vehicle/sealed/mecha/phazon
	base_icon = "phazon"

	circuit_control = /obj/item/circuitboard/mecha/phazon/main
	circuit_periph = /obj/item/circuitboard/mecha/phazon/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/phazon/targeting

	inner_plating = /obj/item/stack/sheet/plasteel
	inner_plating_amount = 5

	outer_plating = /obj/item/mecha_parts/part/phazon_armor
	outer_plating_amount = 1

	var/obj/item/required_core = /obj/item/assembly/signaler/anomaly/ectoplasm

/datum/component/construction/mecha/phazon/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	if(istype(I, /obj/item/assembly/signaler/anomaly) && !istype(I, required_core))
		to_chat(user, span_warning("异常核心插槽只接受 [initial(required_core.name)]！"))
		return FALSE

	return TRUE

/datum/component/construction/mecha/phazon/get_stockpart_steps()
	return list(
		list(
			"key" = /obj/item/stock_parts/scanning_module,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "武器控制模块已固定，可以添加<b>扫描模块</b>。",
			"forward_message" = "已添加扫描模块",
			"backward_message" = "已松开武器控制模块",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "扫描模块已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定扫描模块",
			"backward_message" = "已移除扫描模块",
		),
		list(
			"key" = /obj/item/stock_parts/capacitor,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "扫描模块已固定，可以添加<b>电容</b>。",
			"forward_message" = "已添加电容",
			"backward_message" = "已松开扫描模块",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" =  "电容已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定电容",
			"backward_message" = "已移除电容",
		),
		list(
			"key" = /obj/item/stock_parts/servo,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "电容已固定，可以添加<b>伺服电机</b>。",
			"forward_message" = "已添加伺服电机",
			"backward_message" = "已松开电容",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "伺服电机已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定伺服电机",
			"backward_message" = "已移除伺服电机",
		),
		list(
			"key" = /obj/item/stack/ore/bluespace_crystal,
			"amount" = 1,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "伺服电机已固定，可以添加<b>蓝空间水晶</b>。",
			"forward_message" = "已添加蓝空间水晶",
			"backward_message" = "已松开伺服电机",
		),
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"back_key" = TOOL_CROWBAR,
			"desc" = "蓝空间水晶已安装，可以<b>接线</b>到机甲系统。",
			"forward_message" = "已连接蓝空间水晶",
			"backward_message" = "已移除蓝空间水晶",
			"icon_state" = "phazon19",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "蓝空间水晶已连接，可以用<b>螺丝刀</b>启动系统。",
			"forward_message" = "已启动蓝空间水晶",
			"backward_message" = "已断开蓝空间水晶",
			"icon_state" = "phazon20",
		),
		list(
			"key" = /obj/item/stock_parts/power_store/cell,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "蓝空间水晶已启动，可以添加<b>电池</b>。",
			"forward_message" = "已添加电池",
			"backward_message" = "已停用蓝空间水晶",
			"icon_state" = "phazon21",
		),
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_CROWBAR,
			"desc" = "电池已安装，可以用<b>螺丝刀</b>固定。",
			"forward_message" = "已固定电池",
			"backward_message" = "已移除电池",
			"icon_state" = "phazon21",
		)
	)

/datum/component/construction/mecha/phazon/get_outer_plating_steps()
	return ..() + list(
		list(
			"key" = required_core,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_WELDER,
			"desc" = "外部装甲已焊接，<b>[initial(required_core.name)]</b>插槽已打开。",
			"forward_message" = "已插入[initial(required_core.name)]",
			"backward_message" = "已切下外部装甲",
			"skip_state" = TRUE,
		)
	)

//SAVANNAH-IVANOV
/datum/component/construction/unordered/mecha_chassis/savannah_ivanov
	result = /datum/component/construction/mecha/savannah_ivanov
	steps = list(
		/obj/item/mecha_parts/part/savannah_ivanov_torso,
		/obj/item/mecha_parts/part/savannah_ivanov_head,
		/obj/item/mecha_parts/part/savannah_ivanov_left_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_right_arm,
		/obj/item/mecha_parts/part/savannah_ivanov_left_leg,
		/obj/item/mecha_parts/part/savannah_ivanov_right_leg
	)

/datum/component/construction/mecha/savannah_ivanov
	result = /obj/vehicle/sealed/mecha/savannah_ivanov
	base_icon = "savannah_ivanov"

	circuit_control = /obj/item/circuitboard/mecha/savannah_ivanov/main
	circuit_periph = /obj/item/circuitboard/mecha/savannah_ivanov/peripherals
	circuit_weapon = /obj/item/circuitboard/mecha/savannah_ivanov/targeting

	inner_plating = /obj/item/stack/sheet/plasteel
	inner_plating_amount = 10

	outer_plating = /obj/item/mecha_parts/part/savannah_ivanov_armor
	outer_plating_amount = 1

//ODYSSEUS
/datum/component/construction/unordered/mecha_chassis/odysseus
	result = /datum/component/construction/mecha/odysseus
	steps = list(
		/obj/item/mecha_parts/part/odysseus_torso,
		/obj/item/mecha_parts/part/odysseus_head,
		/obj/item/mecha_parts/part/odysseus_left_arm,
		/obj/item/mecha_parts/part/odysseus_right_arm,
		/obj/item/mecha_parts/part/odysseus_left_leg,
		/obj/item/mecha_parts/part/odysseus_right_leg
	)

/datum/component/construction/mecha/odysseus
	result = /obj/vehicle/sealed/mecha/odysseus
	base_icon = "odysseus"

	circuit_control = /obj/item/circuitboard/mecha/odysseus/main
	circuit_periph = /obj/item/circuitboard/mecha/odysseus/peripherals

	inner_plating = /obj/item/stack/sheet/iron
	inner_plating_amount = 5

	outer_plating = /obj/item/stack/sheet/plasteel
	outer_plating_amount = 5
