/datum/action/cooldown/bloodsucker/distress
	name = "求救"
	desc = "伤害自己，向主人发出绝望的求救。"
	button_icon_state = "power_distress"
	power_explanation = "求救：\n\
		无论身处何地，使用此能力都会立即将你的位置告知吸血鬼主人。"
	power_flags = NONE
	check_flags = NONE
	purchase_flags = NONE
	bloodcost = 10
	cooldown_time = 10 SECONDS
	level_current = -1

/datum/action/cooldown/bloodsucker/distress/ActivatePower(trigger_flags)
	. = ..()
	var/turf/open/floor/target_area = get_area(owner)
	var/datum/antagonist/ghoul/ghouldatum = owner.mind.has_antag_datum(/datum/antagonist/ghoul)

	owner.balloon_alert(owner, "你呼唤着主人！")
	to_chat(ghouldatum.master.owner, "<span class='userdanger'>你忠诚的血仆[owner]正在[chinese_area_display(target_area.name)]绝望地求救！</span>")

	var/mob/living/user = owner
	user.adjust_brute_loss(10)
	return TRUE
