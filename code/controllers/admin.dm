// Clickable stat() button.
/obj/effect/statclick
	name = "正在初始化……"
	blocks_emissive = EMISSIVE_BLOCK_NONE
	var/target

INITIALIZE_IMMEDIATE(/obj/effect/statclick)

/obj/effect/statclick/Initialize(mapload, text, target)
	. = ..()
	name = text
	src.target = target
	if(isdatum(target)) //Harddel man bad
		RegisterSignal(target, COMSIG_QDELETING, PROC_REF(cleanup))

/obj/effect/statclick/Destroy()
	target = null
	return ..()

/obj/effect/statclick/proc/cleanup()
	SIGNAL_HANDLER
	qdel(src)

/obj/effect/statclick/proc/update(text)
	name = text
	return src

/obj/effect/statclick/debug
	var/class

/obj/effect/statclick/debug/Click()
	if(!usr.client.holder || !target)
		return
	if(!class)
		if(istype(target, /datum/controller/subsystem))
			class = "子系统"
		else if(istype(target, /datum/controller))
			class = "控制器"
		else if(isdatum(target))
			class = "datum"
		else
			class = "未知类型"

	usr.client.debug_variables(target)
	message_admins("管理员[key_name_admin(usr)]正在调试[target]（[class]）。")

ADMIN_VERB(restart_controller, R_DEBUG, "重启控制器", "重启游戏的某个周期循环控制器（请谨慎操作！）", ADMIN_CATEGORY_DEBUG)
	VERB_ARG_LIST(controller, list("Master", "Failsafe"))
	switch(controller)
		if("Master")
			Recreate_MC()
			BLACKBOX_LOG_ADMIN_VERB("Restart Master Controller")
		if("Failsafe")
			new /datum/controller/failsafe()
			BLACKBOX_LOG_ADMIN_VERB("Restart Failsafe Controller")

	message_admins("管理员[key_name_admin(user)]已重启[controller]控制器。")

ADMIN_VERB(debug_controller, R_DEBUG, "调试控制器", "调试游戏的各种周期循环控制器（请谨慎操作！）", ADMIN_CATEGORY_DEBUG)
	var/list/controllers = list()
	var/list/controller_choices = list()

	for (var/var_key in global.vars)
		var/datum/controller/controller = global.vars[var_key]
		if(!istype(controller) || istype(controller, /datum/controller/subsystem))
			continue
		controllers[controller.name] = controller //we use an associated list to ensure clients can't hold references to controllers
		controller_choices += controller.name

	var/datum/controller/controller_string = input("选择要调试的控制器", "调试控制器") as null|anything in controller_choices
	var/datum/controller/controller = controllers[controller_string]

	if (!istype(controller))
		return

	user.debug_variables(controller)

	BLACKBOX_LOG_ADMIN_VERB("Debug Controller")
	message_admins("管理员[key_name_admin(user)]正在调试[controller]控制器。")
