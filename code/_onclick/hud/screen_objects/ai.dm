/atom/movable/screen/ai
	icon = 'icons/hud/screen_ai.dmi'
	mouse_over_pointer = MOUSE_HAND_POINTER

/atom/movable/screen/ai/Click()
	if(isobserver(usr) || usr.incapacitated)
		return TRUE

/atom/movable/screen/ai/aicore
	name = "AI 核心"
	icon_state = "ai_core"
	screen_loc = ui_ai_core

/atom/movable/screen/ai/aicore/Click()
	if(!isAI(usr))
		return

	var/mob/living/silicon/ai/AI = usr
	AI.view_core()

/atom/movable/screen/ai/camera_list
	name = "显示摄像头列表"
	icon_state = "camera"
	screen_loc = ui_ai_camera_list

/atom/movable/screen/ai/camera_list/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.show_camera_list()

/atom/movable/screen/ai/camera_track
	name = "使用摄像头追踪"
	icon_state = "track"
	screen_loc = ui_ai_track_with_camera

/atom/movable/screen/ai/camera_track/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.ai_camera_track()

/atom/movable/screen/ai/camera_light
	name = "切换摄像头照明"
	icon_state = "camera_light"
	screen_loc = ui_ai_camera_light

/atom/movable/screen/ai/camera_light/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.toggle_camera_light()

/atom/movable/screen/ai/modpc
	name = "即时通讯"
	icon_state = "pda_send"
	screen_loc = ui_ai_mod_int

/atom/movable/screen/ai/modpc/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.modularInterface?.interact(AI)

/atom/movable/screen/ai/crew_monitor
	name = "船员监控控制台"
	icon_state = "crew_monitor"
	screen_loc = ui_ai_crew_monitor

/atom/movable/screen/ai/crew_monitor/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	GLOB.crewmonitor.show(AI,AI)

/atom/movable/screen/ai/crew_manifest
	name = "船员名册"
	icon_state = "manifest"
	screen_loc = ui_ai_crew_manifest

/atom/movable/screen/ai/crew_manifest/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.ai_roster()

/atom/movable/screen/ai/alerts
	name = "显示警报"
	icon_state = "alerts"
	screen_loc = ui_ai_alerts

/atom/movable/screen/ai/alerts/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.alert_control.ui_interact(AI)

/atom/movable/screen/ai/announcement
	name = "发布 VOX 语音公告"
	icon_state = "announcement"
	screen_loc = ui_ai_announcement

/atom/movable/screen/ai/announcement/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.announcement()

/atom/movable/screen/ai/call_shuttle
	name = "呼叫紧急穿梭机"
	icon_state = "call_shuttle"
	screen_loc = ui_ai_shuttle

/atom/movable/screen/ai/call_shuttle/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.ai_call_shuttle()

/atom/movable/screen/ai/state_laws
	name = "宣读法则"
	icon_state = "state_laws"
	screen_loc = ui_ai_state_laws

/atom/movable/screen/ai/state_laws/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.checklaws()

/atom/movable/screen/ai/image_take
	name = "拍照"
	icon_state = "take_picture"
	screen_loc = ui_ai_take_picture

/atom/movable/screen/ai/image_take/Click()
	if(..())
		return
	if(isAI(usr))
		var/mob/living/silicon/ai/AI = usr
		AI.aicamera.toggle_camera_mode(usr)
	else if(iscyborg(usr))
		var/mob/living/silicon/robot/R = usr
		R.aicamera.toggle_camera_mode(usr)

/atom/movable/screen/ai/image_view
	name = "查看照片"
	icon_state = "view_images"
	screen_loc = ui_ai_view_images

/atom/movable/screen/ai/image_view/Click()
	if(..())
		return
	if(isAI(usr))
		var/mob/living/silicon/ai/AI = usr
		AI.aicamera.viewpictures(usr)

/atom/movable/screen/ai/sensors
	name = "传感器增强"
	icon_state = "ai_sensor"
	screen_loc = ui_ai_sensor

/atom/movable/screen/ai/sensors/Click()
	if(..())
		return
	var/mob/living/silicon/S = usr
	S.toggle_sensors()

/atom/movable/screen/ai/multicam
	name = "多摄像头模式"
	icon_state = "multicam"
	screen_loc = ui_ai_multicam

/atom/movable/screen/ai/multicam/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.toggle_multicam()

/atom/movable/screen/ai/add_multicam
	name = "新建摄像头视图"
	icon_state = "new_cam"
	screen_loc = ui_ai_add_multicam

/atom/movable/screen/ai/add_multicam/Click()
	if(..())
		return
	var/mob/living/silicon/ai/AI = usr
	AI.drop_new_multicam()

/atom/movable/screen/ai/floor_indicator
	icon_state = "zindicator"
	screen_loc = ui_ai_floor_indicator

/atom/movable/screen/ai/floor_indicator/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	if(istype(hud_owner))
		RegisterSignal(hud_owner, COMSIG_HUD_OFFSET_CHANGED, PROC_REF(update_z))
		update_z()

/atom/movable/screen/ai/floor_indicator/proc/update_z(datum/hud/source)
	SIGNAL_HANDLER
	var/mob/living/silicon/ai/ai = get_mob() //if you use this for anyone else i will find you
	if(isnull(ai))
		return
	var/turf/locturf = isturf(ai.loc) ? get_turf(ai.eyeobj) : get_turf(ai) //must be a var cuz error
	var/ai_z = locturf.z
	var/text = "层级<br/>[ai_z]"
	if(SSmapping.level_trait(ai_z, ZTRAIT_STATION))
		text = "楼层<br/>[ai_z - 1]"
	else if (SSmapping.level_trait(ai_z, ZTRAIT_NOPHASE))
		text = "错误"
	maptext = MAPTEXT_TINY_UNICODE("<div align='center' valign='middle' style='position:relative; top:0px; left:0px'>[text]</div>")

/atom/movable/screen/ai/go_up
	name = "向上"
	icon_state = "up"
	screen_loc = ui_ai_godownup

/atom/movable/screen/ai/go_up/Initialize(mapload)
	. = ..()
	register_context()

/atom/movable/screen/ai/go_up/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_LMB] = "上移一层"
	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/ai/go_up/Click(location,control,params)
	var/mob/ai = get_mob() //the core
	flick("uppressed",src)
	if(!isturf(ai.loc) || usr != ai) //aicard and stuff
		return
	ai.up()

/atom/movable/screen/ai/go_up/down
	name = "向下"
	icon_state = "down"

/atom/movable/screen/ai/go_up/down/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	context[SCREENTIP_CONTEXT_LMB] = "下移一层"
	return CONTEXTUAL_SCREENTIP_SET

/atom/movable/screen/ai/go_up/down/Click(location,control,params)
	var/mob/ai = get_mob() //the core
	flick("downpressed",src)
	if(!isturf(ai.loc) || usr != ai) //aicard and stuff
		return
	ai.down()
