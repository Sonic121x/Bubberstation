#define TURRET_ASSEMBLY_START "start"
#define TURRET_ASSEMBLY_RECEIVER "receiver"
#define TURRET_ASSEMBLY_SEC_1 "secured_receiver"
#define TURRET_ASSEMBLY_SERVO "servo"
#define TURRET_ASSEMBLY_SEC_2 "secured_servo"
#define TURRET_ASSEMBLY_SENSOR "sensor"
#define TURRET_ASSEMBLY_SEC_3 "secured_sensor"
#define TURRET_ASSEMBLY_WRAPUP "finished_assembly"

/obj/item/turret_assembly
	name = "炮塔板组装件"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "turret_assembly"
	desc = "一套弹匣供弹炮塔的组装部件，需要接收器、伺服电机和传感器以及施工步骤。这一套似乎是用于基础前哨防御炮塔的。"
	/// modular receiver
	var/obj/item/receiver
	/// proximity sensor
	var/obj/item/sensor
	/// any stockpart servo
	var/obj/item/servo
	/// The turret being produced. Why so elaborate while everything else simple? iunno.
	var/obj/item/storage/toolbox/emergency/turret/mag_fed/design = /obj/item/storage/toolbox/emergency/turret/mag_fed/outpost
	/// step tracking
	var/step = TURRET_ASSEMBLY_START

/obj/item/turret_assembly/examine(mob/user)
	. = ..()
	var/display_text
	switch(step)
		if(TURRET_ASSEMBLY_START)
			display_text = "炮塔头部缺少一个<b>模块化接收器</b>……"
		if(TURRET_ASSEMBLY_RECEIVER)
			display_text = "炮塔头部的连接螺栓<b>松动了</b>……"
		if(TURRET_ASSEMBLY_SEC_1)
			display_text = "看起来缺少一个<b>伺服电机</b>……"
		if(TURRET_ASSEMBLY_SERVO)
			display_text = "看起来它的主框架还<b>未固定</b>……"
		if(TURRET_ASSEMBLY_SEC_2)
			display_text = "看起来缺少一个<b>接近传感器</b>……"
		if(TURRET_ASSEMBLY_SENSOR)
			display_text = "传感器似乎<b>未固定</b>……"
		if(TURRET_ASSEMBLY_SEC_3)
			display_text = "支架的螺栓似乎<b>松动了</b>……"
		if(TURRET_ASSEMBLY_WRAPUP)
			display_text = "电路板的 CPU 需要被<b>激活</b>……"
	. += span_notice(display_text)

/obj/item/turret_assembly/attackby(obj/item/part, mob/user, params)
	. = ..()
	switch(step)
		if(TURRET_ASSEMBLY_START)
			if(!istype(part, /obj/item/weaponcrafting/receiver))
				return
			if(!user.transferItemToLoc(part, src))
				balloon_alert(user, "核心粘在你手上了！")
				return
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			balloon_alert(user, "接收器已装入")
			receiver = part
			step = TURRET_ASSEMBLY_RECEIVER

		if(TURRET_ASSEMBLY_SEC_1)
			if(istype(part, /obj/item/stock_parts/servo)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "伺服电机粘在你手上了！")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "伺服电机已装上")
				servo = part
				step = TURRET_ASSEMBLY_SERVO

		if(TURRET_ASSEMBLY_SEC_2)
			if(istype(part, /obj/item/assembly/prox_sensor)) //Construct
				if(!user.transferItemToLoc(part, src))
					balloon_alert(user, "传感器粘在你手上了！")
					return
				playsound(src, 'sound/machines/click.ogg', 30, TRUE)
				balloon_alert(user, "传感器已装上")
				sensor = part
				step = TURRET_ASSEMBLY_SENSOR

/obj/item/turret_assembly/multitool_act(mob/living/user, obj/item/tool)
	if(step == TURRET_ASSEMBLY_WRAPUP)
		if(tool.use_tool(src, user, 0, volume=30))
			playsound(src, 'sound/machines/click.ogg', 30, TRUE)
			var/obj/item/turretling = new design(drop_location())
			qdel(src)
			user.put_in_hands(turretling)
			turretling.balloon_alert(user, "组装完成")

/obj/item/turret_assembly/wrench_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_SEC_3)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "组件已固定")
				step = TURRET_ASSEMBLY_WRAPUP
				return // Last step leads to the next step
		if(TURRET_ASSEMBLY_WRAPUP)
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "组件已松开")
				step = TURRET_ASSEMBLY_SEC_3
				return

/obj/item/turret_assembly/screwdriver_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "接收器已固定")
				step = TURRET_ASSEMBLY_SEC_1
				return //same as wrench
		if(TURRET_ASSEMBLY_SEC_1) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "接收器已松开")
				step = TURRET_ASSEMBLY_RECEIVER
				return
		if(TURRET_ASSEMBLY_SERVO) //Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "伺服电机已固定")
				step = TURRET_ASSEMBLY_SEC_2
				return
		if(TURRET_ASSEMBLY_SEC_2) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "传感器已松开")
				step = TURRET_ASSEMBLY_SERVO
				return
		if(TURRET_ASSEMBLY_SENSOR)//Construct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "传感器已固定")
				step = TURRET_ASSEMBLY_SEC_3
				return
		if(TURRET_ASSEMBLY_SEC_3) //Deconstruct
			if(tool.use_tool(src, user, 0, volume=30))
				balloon_alert(user, "传感器已松开")
				step = TURRET_ASSEMBLY_SENSOR
				return

/obj/item/turret_assembly/crowbar_act(mob/living/user, obj/item/tool)
	switch(step)
		if(TURRET_ASSEMBLY_RECEIVER)
			if(tool.use_tool(src, user, 0, volume=30))
				receiver.forceMove(drop_location())
				balloon_alert(user, "接收器已取出")
				receiver = null
				step = TURRET_ASSEMBLY_START
				return
		if(TURRET_ASSEMBLY_SERVO)
			if(tool.use_tool(src, user, 0, volume=30))
				servo.forceMove(drop_location())
				balloon_alert(user, "伺服电机已取下")
				servo = null
				step = TURRET_ASSEMBLY_SEC_1
				return
		if(TURRET_ASSEMBLY_SENSOR)
			if(tool.use_tool(src, user, 0, volume=30))
				sensor.forceMove(drop_location())
				balloon_alert(user, "传感器已取下")
				sensor = null
				step = TURRET_ASSEMBLY_SEC_2
				return

/obj/item/turret_assembly/Destroy()
	QDEL_NULL(receiver)
	QDEL_NULL(servo)
	QDEL_NULL(sensor)
	return ..()

/obj/item/turret_assembly/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == receiver)
		receiver = null
	if(gone == servo)
		servo = null
	if(gone == sensor)
		sensor = null

/obj/item/turret_assembly/twin_fang
	name = "双牙板组装件"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "twinfang_assembly"
	desc = "一套弹匣供弹炮塔的组装部件，需要接收器、伺服电机和传感器以及施工步骤。这一套用于“蜘蛛”型炮塔的“双牙”型号。"
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/spider/twin_fang

/obj/item/turret_assembly/duster
	name = "除尘者板组装件"
	icon = 'modular_skyrat/modules/magfed_turret/icons/assembly.dmi'
	icon_state = "duster_assembly"
	desc = "一套弹匣供弹炮塔的组装部件，需要接收器、伺服电机和传感器以及施工步骤。这一套用于“涌现”型炮塔的“除尘者”型号。"
	design = /obj/item/storage/toolbox/emergency/turret/mag_fed/duster

#undef TURRET_ASSEMBLY_START
#undef TURRET_ASSEMBLY_RECEIVER
#undef TURRET_ASSEMBLY_SEC_1
#undef TURRET_ASSEMBLY_SERVO
#undef TURRET_ASSEMBLY_SEC_2
#undef TURRET_ASSEMBLY_SENSOR
#undef TURRET_ASSEMBLY_SEC_3
#undef TURRET_ASSEMBLY_WRAPUP
