/datum/wires/robot
	holder_type = /mob/living/silicon/robot
	proper_name = "半机械人"
	randomize = TRUE

/datum/wires/robot/New(atom/holder)
	wires = list(
		WIRE_AI, WIRE_CAMERA,
		WIRE_LAWSYNC, WIRE_LOCKDOWN,
		WIRE_RESET_MODEL
	)
	add_duds(2)
	..()

/datum/wires/robot/interactable(mob/user)
	if(!..())
		return FALSE
	var/mob/living/silicon/robot/R = holder
	if(R.wiresexposed)
		return TRUE

/datum/wires/robot/get_status()
	var/mob/living/silicon/robot/R = holder
	var/list/status = list()
	status += "法则同步模块[R.lawupdate ? "已开启" : "已关闭"]。"
	status += "智能连接显示屏显示[R.connected_ai ? R.connected_ai.name : "空值"]。"
	status += "摄像头指示灯[!isnull(R.builtInCamera) && R.builtInCamera.camera_enabled ? "亮起" : "熄灭"]。"
	status += "锁定指示灯[R.lockcharge ? "亮起" : "熄灭"]。"
	status += "[chinese_color_display(get_color_of_wire(WIRE_RESET_MODEL))]导线上方有一个星形符号。"
	return status

/datum/wires/robot/on_pulse(wire, user)
	var/mob/living/silicon/robot/R = holder
	switch(wire)
		if(WIRE_AI) // Pulse to pick a new AI.
			if(!R.emagged)
				var/new_ai
				var/is_a_syndi_borg = R.has_faction(ROLE_SYNDICATE)
				if(user)
					new_ai = select_active_ai(user, R.z, !is_a_syndi_borg, is_a_syndi_borg)
				else
					new_ai = select_active_ai(R, R.z, !is_a_syndi_borg, is_a_syndi_borg)
				R.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
				if(new_ai && (new_ai != R.connected_ai))
					R.set_connected_ai(new_ai)
					log_silicon("[key_name(usr)] synced [key_name(R)] [R.connected_ai ? "from [key_name(R.connected_ai)]": ""] to [key_name(new_ai)]")
					if(R.shell)
						R.undeploy() //If this borg is an AI shell, disconnect the controlling AI and assign ti to a new AI
						R.notify_ai(AI_NOTIFICATION_AI_SHELL)
					else
						R.notify_ai(TRUE)
		if(WIRE_CAMERA) // Pulse to disable the camera.
			if(!QDELETED(R.builtInCamera) && !R.scrambledcodes)
				R.builtInCamera.toggle_cam(usr, FALSE)
				R.visible_message(span_notice("[R]的摄像头镜头在对焦时发出响声。"), span_notice("你的摄像头镜头在对焦时发出响声。"))
				log_silicon("[key_name(usr)] toggled [key_name(R)]'s camera to [R.builtInCamera.camera_enabled ? "on" : "off"] via pulse")
		if(WIRE_LAWSYNC) // Forces a law update if possible.
			if(R.lawupdate)
				R.visible_message(span_notice("[R]发出轻柔的提示音。"), span_notice("法则同步协议已启用。"))
				log_silicon("[key_name(usr)] forcibly synced [key_name(R)]'s laws via pulse")
				// TODO, log the laws they gained here
				R.lawsync()
				R.show_laws()
		if(WIRE_LOCKDOWN)
			R.SetLockdown(!R.lockcharge) // Toggle
			log_silicon("[key_name(usr)] [!R.lockcharge ? "locked down" : "released"] [key_name(R)] via pulse")

		if(WIRE_RESET_MODEL)
			if(R.has_model())
				R.visible_message(span_notice("[R]的型号伺服机构抽动了一下。"), span_notice("你的型号显示屏闪烁了一下。"))

/datum/wires/robot/on_cut(wire, mend, source)
	var/mob/living/silicon/robot/R = holder
	switch(wire)
		if(WIRE_AI) // Cut the AI wire to reset AI control.
			if(!mend)
				R.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
				log_silicon("[key_name(usr)] cut AI wire on [key_name(R)][R.connected_ai ? " and disconnected from [key_name(R.connected_ai)]": ""]")
				if(R.shell)
					R.undeploy()
				R.set_connected_ai(null)
			R.logevent("AI连接故障[mend ? "已清除" : "已检测到"]")
		if(WIRE_LAWSYNC) // Cut the law wire, and the borg will no longer receive law updates from its AI. Repair and it will re-sync.
			if(mend)
				if(!R.emagged)
					R.lawupdate = TRUE
					log_silicon("[key_name(usr)] enabled [key_name(R)]'s lawsync via wire")
			else if(!R.deployed) //AI shells must always have the same laws as the AI
				R.lawupdate = FALSE
				log_silicon("[key_name(usr)] disabled [key_name(R)]'s lawsync via wire")
			R.logevent("法则同步模块故障[mend ? "已清除" : "已检测到"]")
		if (WIRE_CAMERA) // Disable the camera.
			if(!QDELETED(R.builtInCamera) && !R.scrambledcodes)
				var/fixing_camera = !mend
				R.builtInCamera.camera_enabled = fixing_camera
				R.builtInCamera.toggle_cam(usr, 0)
				R.visible_message(span_notice("[R]的摄像头镜头在对焦时发出响声。"), span_notice("你的摄像头镜头在对焦时发出响声。"))
				R.logevent("摄像头模块故障[fixing_camera ? "已清除" : "已检测到"]")
				log_silicon("[key_name(usr)] [fixing_camera ? "enabled" : "disabled"] [key_name(R)]'s camera via wire")
		if(WIRE_LOCKDOWN) // Simple lockdown.
			R.SetLockdown(!mend)
			R.logevent("电机控制器故障[mend?"已清除":"已检测到"]")
			log_silicon("[key_name(usr)] [!R.lockcharge ? "locked down" : "released"] [key_name(R)] via wire")
		if(WIRE_RESET_MODEL)
			if(R.has_model() && !mend)
				R.ResetModel()
				log_silicon("[key_name(usr)] reset [key_name(R)]'s module via wire")

/datum/wires/robot/can_reveal_wires(mob/user)
	if(HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		return TRUE

	return ..()

/datum/wires/robot/always_reveal_wire(color)
	// Always reveal the reset model wire.
	if(color == get_color_of_wire(WIRE_RESET_MODEL))
		return TRUE

	return ..()
