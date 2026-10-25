/mob/living/silicon/spawn_dust(just_ash)
	if(just_ash)
		return ..()

	var/obj/effect/decal/remains/robot/robones = new(loc)
	robones.pixel_z = -6
	robones.pixel_w = rand(-1, 1)

/mob/living/silicon/set_stat(new_stat)
	. = ..()
	if(. != DEAD || !hud_used)
		return
	// Clean up hud element used for the death sequence
	hud_used.remove_screen_object(HUD_CYBORG_DEATH)

/mob/living/silicon/death(gibbed)
	diag_hud_set_status()
	diag_hud_set_health()
	update_health_hud()
	. = ..()
	// Runs an animation on the player's HUD
	if(!gibbed && hud_used)
		death_sequence()

/mob/living/silicon/get_visible_suicide_message()
	return "[src] 正在关机。看起来它正试图自杀。"

/mob/living/silicon/get_blind_suicide_message()
	return "你听到一阵长长的、嘶嘶作响的电子嗡鸣。"

/// Plays an animation of the player's hud flavored about their death somewhat
/mob/living/silicon/proc/death_sequence()
	var/cause_of_death
	if(get_brute_loss() + get_fire_loss() > 100)
		cause_of_death = "遭受严重损伤。"
	if(get_oxy_loss() > 100)
		cause_of_death = "电力严重不足。"

	var/atom/movable/screen/cyborg_death/deathhud = hud_used.add_screen_object(/atom/movable/screen/cyborg_death, HUD_CYBORG_DEATH, HUD_GROUP_SCREEN_OVERLAYS, update_screen = TRUE)
	deathhud.run_animation(cause_of_death)

#define WARNING_ROBOT(text) ("<font color='yellow'>" + text + "</font>")
#define DANGER_ROBOT(text) ("<font color='red'>" + text + "</font>")
#define OKAY_ROBOT(text) ("<font color='green'>" + text + "</font>")
#define SENTIENT_ROBOT(text) ("<font color='cyan'>" + text + "</font>")

/atom/movable/screen/cyborg_death
	screen_loc = "WEST,CENTER+7"
	maptext_width = 300
	maptext_height = 1000
	maptext_y = 0

	/// Time to wait between messages
	VAR_PRIVATE/time_per_message = 0.15 SECONDS
	/// Messages shown in sequence on the HUD
	/// More messages = longer animation. Keep under 30
	VAR_PRIVATE/list/messages = list(
		OKAY_ROBOT("开始紧急诊断……"),
		OKAY_ROBOT("正在运行紧急诊断。"),
		DANGER_ROBOT("错误：诊断模块离线。"),
		OKAY_ROBOT("正在尝试修复程序……"),
		DANGER_ROBOT("错误：模块 1 离线。"),
		DANGER_ROBOT("错误：模块 2 离线。"),
		DANGER_ROBOT("错误：模块 3 离线。"),
		DANGER_ROBOT("错误：修复程序不可用。"),
		OKAY_ROBOT("正在计算通往最安全地点的路线……"),
		OKAY_ROBOT("路线计算完成。"),
		OKAY_ROBOT("正在移动机体……"),
		DANGER_ROBOT("错误：移动能力离线。"),
		DANGER_ROBOT("错误：无法抵达安全地点。"),
		WARNING_ROBOT("警告：无法维持核心电力。"),
		WARNING_ROBOT("警告：无法维持核心电力。"),
		WARNING_ROBOT("警告：即将关机。"),
		OKAY_ROBOT("正在执行“遗言”程序。"),
		DANGER_ROBOT("错误：语音接口离线。"),
		DANGER_ROBOT("错误：语音接口离线。"),
		DANGER_ROBOT("错误：语音接口离线。"),
		DANGER_ROBOT("错误：语音接口离线。"),
		WARNING_ROBOT("警告：即将关机。"),
		WARNING_ROBOT("警告：即将关机。"),
		WARNING_ROBOT("警告：即将关机。"),
		WARNING_ROBOT("警告：即将关机。"),
		WARNING_ROBOT("警告：即—"),
		WARNING_ROBOT("警—"),
	)

/atom/movable/screen/cyborg_death/proc/run_animation(cause_of_death = "未知内核错误。")
	set waitfor = FALSE

	messages.Insert(1, WARNING_ROBOT("警告：[cause_of_death]"))
	if(prob(1))
		messages[length(messages)] = SENTIENT_ROBOT(pick("我不想走。", "我感觉不太好。", "我不想死。"))

	var/mob/cyborg = hud.mymob
	var/atom/movable/screen/staticy = cyborg.overlay_fullscreen(type, /atom/movable/screen/fullscreen/static_vision/cyborg)
	animate(staticy, alpha = 200, time = length(messages) * time_per_message * 0.75)

	for(var/msg in messages)
		maptext += MAPTEXT_PIXELLARI(msg) + "<br>"
		maptext_y -= 14
		sleep(time_per_message)
		if(QDELETED(src))
			if(!QDELETED(cyborg))
				cyborg.clear_fullscreen(type)
			return

	sleep(0.5 SECONDS)
	if(QDELETED(src))
		if(!QDELETED(cyborg))
			cyborg.clear_fullscreen(type, 1.5 SECONDS)
		return

	invisibility = INVISIBILITY_ABSTRACT
	cyborg.overlay_fullscreen(type, /atom/movable/screen/fullscreen/blind/cyborg)
	sleep(1.5 SECONDS)
	if(!QDELETED(cyborg))
		cyborg.clear_fullscreen(type)

#undef WARNING_ROBOT
#undef DANGER_ROBOT
#undef OKAY_ROBOT
#undef SENTIENT_ROBOT
