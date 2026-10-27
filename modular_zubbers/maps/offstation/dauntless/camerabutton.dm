/obj/item/assembly/control/camkillswitch
	name = "摄像头网络关断器"
	desc = "一个能切断整个网络摄像头信号的小型电子装置。"
	verb_say = "哔哔响"
	COOLDOWN_DECLARE(use_cooldown)
	/// Camera network to kill
	var/camera_network = "dauntless"
	/// Current state the cameras are in, toggled after activating the button
	var/cameras_active = TRUE

/obj/item/assembly/control/camkillswitch/activate()
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		say("摄像头网络正在重载！请稍等片刻。")
		return

	var/list/cameras = SScameras.get_available_camera_by_tag_list(camera_network)
	var/obj/machinery/camera/camera
	for(var/camera_name in cameras)
		camera = cameras[camera_name]
		if(camera.camera_enabled == cameras_active)
			camera.toggle_cam(null, FALSE)

	cameras_active = !cameras_active
	say(cameras_active ? "摄像头网络已上线。" : "摄像头网络正在关断。")
	COOLDOWN_START(src, use_cooldown, 5 SECONDS)

/obj/machinery/button/camkillswitch
	name = "摄像头关断开关"
	device_type = /obj/item/assembly/control/camkillswitch
