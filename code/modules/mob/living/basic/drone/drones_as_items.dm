/** Drone Shell: Ghost role item for drones
 *
 * A simple mob spawner item that transforms into a maintenance drone
 * Respects drone minimum age
 */

/obj/effect/mob_spawn/ghost_role/drone
	name = "无人机外壳"
	desc = "一台维护无人机的外壳，这是一种为执行空间站维修而制造的一次性机器人。"
	icon = 'icons/mob/silicon/drone.dmi'
	icon_state = "drone_maint_hat" //yes reuse the _hat state.
	layer = BELOW_MOB_LAYER
	density = FALSE
	mob_name = "无人机"
	///Type of drone that will be spawned
	mob_type = /mob/living/basic/drone
	role_ban = ROLE_DRONE
	show_flavor = FALSE
	prompt_name = "维护无人机"
	you_are_text = "你是一台维护无人机。"
	flavour_text = "你诞生于科学，你的使命是维护空间站 13。维护无人机可以成为一座健康空间站的支柱。"
	important_text = "你必须仔细阅读并遵守你的法律。"
	spawner_job_path = /datum/job/maintenance_drone

/obj/effect/mob_spawn/ghost_role/drone/Initialize(mapload)
	. = ..()
	var/area/area = get_area(src)
	if(area)
		notify_ghosts(
			"\the [area.name] 中出现了一个无人机外壳。",
			source = src,
			header = "无人机外壳已生成",
			click_interact = TRUE,
			ignore_key = POLL_IGNORE_DRONE,
			notify_flags = (GHOST_NOTIFY_IGNORE_MAPLOAD),
		)

/obj/effect/mob_spawn/ghost_role/drone/allow_spawn(mob/user, silent = FALSE)
	var/client/user_client = user.client
	var/mob/living/basic/drone/drone_type = mob_type
	if(!initial(drone_type.shy) || isnull(user_client) || !CONFIG_GET(flag/use_exp_restrictions_other))
		return ..()
	var/required_role = CONFIG_GET(string/drone_required_role)
	var/required_playtime = CONFIG_GET(number/drone_role_playtime) * 60
	if(CONFIG_GET(flag/use_exp_restrictions_admin_bypass) && check_rights_for(user.client, R_ADMIN))
		return ..()
	if(user?.client?.prefs.db_flags & DB_FLAG_EXEMPT)
		return ..()
	if(required_playtime <= 0)
		return ..()
	var/current_playtime = user_client?.calc_exp_type(required_role)
	if (current_playtime < required_playtime)
		var/minutes_left = required_playtime - current_playtime
		var/playtime_left = DisplayTimeText(minutes_left * (1 MINUTES))
		if(!silent)
			to_chat(user, span_danger("你还需要以 [required_role] 身份游玩 [playtime_left] 才能作为维护无人机出生！"))
		return FALSE
	return ..()
