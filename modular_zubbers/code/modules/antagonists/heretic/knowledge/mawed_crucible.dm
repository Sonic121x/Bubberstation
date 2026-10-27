/datum/heretic_knowledge/crucible
	desc = "让你能将一个便携水箱和一张桌子转化为巨口坩埚。\
		巨口坩埚能酿制强效战斗及实用药剂，但每次使用之间必须喂给它肢体和器官。\
		非异教徒也能饮用这些药剂，但会感到强烈恶心。"
	drafting_tier = 2 // its honestly kinda strong asf

/obj/item/eldritch_potion/potion_effect(mob/user)
	. = ..()
	if (!isnull(source_heretic))
		SEND_SIGNAL(source_heretic, COMSIG_HERETIC_POTION_CONSUMED, src, user)

/obj/item/eldritch_potion/crucible_soul
	crucible_tip = "让你能穿过墙壁以外的一切障碍。效果结束后，你会被传送回原位，\
	并短暂倒地。邪异粒子留下的轨迹会暴露你的位置，做好移动的准备。持续20秒。"

/datum/status_effect/crucible_soul
	duration = 20 SECONDS // enough to get in and grab some shit but not enough to do much fighting

/datum/status_effect/crucible_soul/on_remove()
	var/turf/curr_turf = get_turf(owner)
	curr_turf.Beam(location, icon_state = "lichbeam", time = 5 SECONDS)

	owner.AdjustKnockdown(1 SECONDS)

	return ..()

/obj/item/eldritch_potion
	/// If this is TRUE, nonheretics can dirnk this.
	var/is_from_crucible = FALSE
	var/datum/antagonist/heretic/source_heretic
