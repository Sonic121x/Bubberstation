/obj/item/assembly/control/polarizer
	name = "窗户偏振遥控器"
	desc = "一种小型电子设备，可遥控已连接窗户的偏振状态。"
	custom_materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)
	/// Whether the connected windows are meant to be polarized or not.
	var/polarizing = FALSE


/obj/item/assembly/control/polarizer/examine(mob/user)
	. = ..()

	. += span_notice("将其<b>拿在手中使用</b>，或对其使用<b>多功能工具</b>，即可修改频道编号。")


/obj/item/assembly/control/polarizer/multitool_act(mob/living/user)
	attack_self(user)


/obj/item/assembly/control/polarizer/attack_self(mob/living/user)
	var/change_id = tgui_input_number(user, "设置[src]的编号", "偏振编号", text2num(id), 1000)
	if(!change_id || QDELETED(user) || QDELETED(src) || !usr.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return

	id = "[change_id]"
	balloon_alert(user, "编号已更改")
	to_chat(user, span_notice("你将编号改为[id]。"))


/obj/item/assembly/control/polarizer/activate()
	if(cooldown)
		return

	cooldown = TRUE

	if(!GLOB.polarization_controllers[id])
		addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS) // Just so they can't spam the button.
		return

	polarizing = !polarizing

	for(var/datum/component/polarization_controller/controller as anything in GLOB.polarization_controllers[id])
		controller.toggle(polarizing)

	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 1 SECONDS)


/obj/machinery/button/polarizer
	device_type = /obj/item/assembly/control/polarizer


/datum/design/polarizer
	name = "窗户偏振遥控器"
	id = "polarizer"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/assembly/control/polarizer
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_ELECTRONICS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING
