/**
 * Echoes drone laws to the user
 *
 * See [/mob/living/basic/drone/var/laws]
 */
GAME_VERB(/mob/living/basic/drone, check_laws, "查看法则", "无人机")

	to_chat(src, "<b>无人机法则</b>")
	to_chat(src, laws)

/**
 * Creates an alert to drones in the same network
 *
 * Prompts user for alert level of:
 * * Low
 * * Medium
 * * High
 * * Critical
 *
 * Attaches area name to message
 */
GAME_VERB(/mob/living/basic/drone, drone_ping, "无人机警报", "无人机")

	var/alert_s = input(src,"警报严重等级","无人机警报",null) as null|anything in list("低","中","高","危急")

	var/area/A = get_area(loc)

	if(alert_s && A && stat != DEAD)
		var/msg = span_big("无人机警报：[name]：[alert_s] 优先级警报，位于 [A.name]！")
		alert_drones(msg)
