/// Global list of areas which are considered to be inside the same department for our purposes
GLOBAL_LIST_INIT(battle_royale_regions, list(
	"医疗区" = list(
		/area/station/command/heads_quarters/cmo,
		/area/station/medical,
		/area/station/security/checkpoint/medical,
	),
	"科研区" = list(
		/area/station/command/heads_quarters/rd,
		/area/station/security/checkpoint/science,
		/area/station/science,
	),
	"工程区" = list(
		/area/station/command/heads_quarters/ce,
		/area/station/engineering,
		/area/station/maintenance/disposal/incinerator,
		/area/station/security/checkpoint/engineering,
	),
	"货运区" = list(
		/area/station/cargo,
		/area/station/command/heads_quarters/qm,
		/area/station/security/checkpoint/supply,
	),
))

/// Quietly implants people with battle royale implants
/obj/item/royale_implanter
	name = "大逃杀植入器"
	desc = "悄悄为人植入乱斗大逃杀植入体，\
		让他们为辛迪加付费观众的娱乐而挣扎求生。\
		植入体可能导致植入部位不适。"
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "nanite_hypo"
	w_class = WEIGHT_CLASS_SMALL
	/// Do we have a linked remote? Just to prevent headdesk moments
	var/linked = FALSE

/obj/item/royale_implanter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isliving(interacting_with))
		if (!istype(interacting_with, /obj/item/royale_remote))
			return NONE
		var/obj/item/royale_remote/remote = interacting_with
		remote.link_implanter(src, user)
		return ITEM_INTERACT_SUCCESS
	if (!linked)
		balloon_alert(user, "未关联遥控器！")
		return ITEM_INTERACT_BLOCKING
	if (DOING_INTERACTION_WITH_TARGET(user, interacting_with))
		balloon_alert(user, "正忙！")
		return ITEM_INTERACT_BLOCKING
	var/mob/living/potential_winner = interacting_with
	if (IS_UNCONSCIOUS_OR_CRIT(potential_winner))
		balloon_alert(user, "目标已失去意识！")
		return ITEM_INTERACT_BLOCKING
	if (!potential_winner.mind)
		balloon_alert(user, "目标太无趣了！")
		return ITEM_INTERACT_BLOCKING
	log_combat(user, potential_winner, "tried to implant a battle royale implant into")
	if (!do_after(user, 1.5 SECONDS, potential_winner))
		balloon_alert(user, "已中断！")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/implant/explosive/battle_royale/encouragement_implant = new
	if(!encouragement_implant.implant(potential_winner, user))
		qdel(encouragement_implant) // no balloon alert - feedback is usually provided by the implant
		return ITEM_INTERACT_BLOCKING

	potential_winner.balloon_alert(user, "已植入")
	SEND_SIGNAL(src, COMSIG_ROYALE_IMPLANTED, encouragement_implant)
	return ITEM_INTERACT_SUCCESS

/// Activates implants implanted by linked royale implanter
/obj/item/royale_remote
	name = "大逃杀遥控器"
	desc = "激活所有已关联的乱斗大逃杀植入体，让好戏开场的一次性装置。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "designator_syndicate"
	w_class = WEIGHT_CLASS_SMALL
	/// Minimum number of contestants we should have
	var/required_contestants = 6
	/// List of implanters we are linked to
	var/list/linked_implanters = list()
	/// List of implants of lucky contestants
	var/list/implanted_implants = list()

/obj/item/royale_remote/Destroy(force)
	linked_implanters = null
	implanted_implants = null
	return ..()

/obj/item/royale_remote/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!istype(interacting_with, /obj/item/royale_implanter))
		return NONE
	link_implanter(interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/royale_remote/attack_self(mob/user, modifiers)
	. = ..()
	if (.)
		return
	var/contestant_count = length(implanted_implants)
	if (contestant_count < required_contestants)
		balloon_alert(user, "还需要[required_contestants - contestant_count]名选手！")
		return

	GLOB.battle_royale_master.start_battle(implanted_implants)

	for (var/obj/implanter as anything in linked_implanters)
		do_sparks(3, cardinal_only = FALSE, source = implanter)
		qdel(implanter)
	do_sparks(3, cardinal_only = FALSE, source = src)
	qdel(src)

/// Link to an implanter
/obj/item/royale_remote/proc/link_implanter(obj/item/royale_implanter/implanter, mob/user)
	if (implanter in linked_implanters)
		if (user)
			balloon_alert(user, "已经关联了！")
		return

	if (user)
		balloon_alert(user, "已建立关联")

	implanter.linked = TRUE
	linked_implanters += implanter
	RegisterSignal(implanter, COMSIG_ROYALE_IMPLANTED, PROC_REF(record_contestant))
	RegisterSignal(implanter, COMSIG_QDELETING, PROC_REF(implanter_destroyed))

/// Record that someone just got implanted
/obj/item/royale_remote/proc/record_contestant(obj/item/implanter, obj/item/implant)
	SIGNAL_HANDLER
	implanted_implants |= implant
	RegisterSignal(implant, COMSIG_QDELETING, PROC_REF(implant_destroyed))

/// A linked implanter was destroyed
/obj/item/royale_remote/proc/implanter_destroyed(obj/item/implanter)
	SIGNAL_HANDLER
	linked_implanters -= implanter

/obj/item/royale_remote/proc/implant_destroyed(obj/item/implant)
	SIGNAL_HANDLER
	implanted_implants -= implant

GLOBAL_DATUM_INIT(battle_royale_master, /datum/battle_royale_master, new)

/// Basically just exists to hold references to datums so that they don't GC
/datum/battle_royale_master
	/// List of battle royale datums currently running
	var/list/active_battles

/// Start a new battle royale using a passed list of implants
/datum/battle_royale_master/proc/start_battle(list/competitors)
	var/datum/battle_royale_controller/controller = new()
	if (!controller.start(competitors))
		return FALSE
	LAZYADD(active_battles, controller)
	if (LAZYLEN(active_battles) == 1)
		start_broadcasting_network(BATTLE_ROYALE_CAMERA_NET)
	RegisterSignal(controller, COMSIG_QDELETING, PROC_REF(battle_ended))
	return TRUE

/// Drop reference when it kills itself
/datum/battle_royale_master/proc/battle_ended(datum/source)
	SIGNAL_HANDLER
	LAZYREMOVE(active_battles, source)
	if (!LAZYLEN(active_battles))
		stop_broadcasting_network(BATTLE_ROYALE_CAMERA_NET)

/// Datum which controls the conflict
/datum/battle_royale_controller
	/// Where is our battle taking place?
	var/chosen_area
	/// Is the battle currently in progress?
	var/battle_running = TRUE
	/// Should we let everyone know that someone has died?
	var/announce_deaths = TRUE
	/// List of implants involved
	var/list/contestant_implants = list()
	/// Ways to describe that someone has died
	var/static/list/euphemisms = list(
		"领完了最后一笔工资。",
		"没能挺过去……",
		"被淘汰了。",
		"脑袋被炸飞了！",
		"已被杀死！",
		"挑战失败了！",
		"已经离世。",
		"已经死亡。",
		"如今去了更美好的地方。",
		"明天不用打卡上班了！",
		"刚刚心跳归零。",
		"不是今天的赢家。",
		"似乎爆炸了！",
		"刚在电视直播中遭到谋杀！",
		"等不到退休那天了。",
		"这下再也站不起来了。",
	)
	/// Ways to tell people not to salt in deadchat, surely effective
	var/static/list/condolences = list(
		"祝下次好运！",
		"但请继续收看，胜负仍未可知！",
		"你看清是谁干的了吗？",
		"那一下看起来可真疼……",
		"让我们回放一下精彩瞬间！",
		"请大家默哀片刻。",
		"希望下一位表现更好。",
		"请谁去通知一下死者家属。",
		"这一路也算精彩。",
		"太遗憾了！",
		"真可惜！",
		"真是大冷门！",
		"接下来会发生什么？",
		"谁能想到会这样？",
		"下一个会是谁？",
	)

/datum/battle_royale_controller/Destroy(force)
	contestant_implants = null
	return ..()

/// Start a battle royale with the list of provided implants
/datum/battle_royale_controller/proc/start(list/implants, battle_time = 10 MINUTES)
	chosen_area = pick(GLOB.battle_royale_regions)
	for (var/obj/item/implant/explosive/battle_royale/contestant_implant in implants)
		contestant_implant.start_battle(chosen_area, GLOB.battle_royale_regions[chosen_area])
		if (isnull(contestant_implant))
			continue // Might have exploded if it was removed from a person
		RegisterSignal(contestant_implant, COMSIG_QDELETING, PROC_REF(implant_destroyed))
		contestant_implants |= contestant_implant

	if (length(contestant_implants) <= 1)
		return FALSE // Well there's not much point is there

	priority_announce(
		text = "恭喜[station_name()]，你们被选为下一场乱斗大逃杀的举办地！\n\
			全星区的观众将看着我们[length(contestant_implants)]名幸运选手杀入你们的[chosen_area]，战至只剩一人站立！\n\
			五分钟内未能抵达者将被取消资格。如果你看到选手难以入场，不妨帮一把……当然也可以不帮，只要你能接受后果！\n\
			为表谢意，我们将免费向你们的娱乐显示器提供付费直播，让你们尽情欣赏精彩场面。\n\
			建议旁观者不要干预……但要是你非要掺和，记得在镜头前表现得精彩些！",
		title = "乱斗大逃杀开始",
		sound = 'sound/announcer/alarm/nuke_alarm.ogg',
		has_important_message = TRUE,
		sender_override = "乱斗大逃杀盗播电台",
		color_override = "red",
	)

	for (var/obj/item/implant/explosive/battle_royale/contestant_implant as anything in contestant_implants)
		contestant_implant.announce()
	addtimer(CALLBACK(src, PROC_REF(limit_area)), battle_time / 2, TIMER_DELETE_ME)
	addtimer(CALLBACK(src, PROC_REF(finish)), battle_time, TIMER_DELETE_ME)
	return TRUE

/// An implant was destroyed, hopefully because it exploded. Count how many competitors remain.
/datum/battle_royale_controller/proc/implant_destroyed(obj/item/implant/implant)
	SIGNAL_HANDLER
	contestant_implants -= implant
	if (!battle_running)
		return

	if (length(contestant_implants) <= 1)
		announce_winner(implant)
	else if (announce_deaths)
		var/message = ""
		if (isnull(implant.imp_in))
			message = "看来有人取出并摧毁了自己的植入体，这是作弊！"
		else
			message = "[implant.imp_in.real_name] [pick(euphemisms)] [pick(condolences)]"
		priority_announce(
			text = message,
			title = "乱斗大逃杀伤亡报告",
			sound = 'sound/announcer/notice/notice1.ogg',
			has_important_message = TRUE,
			sender_override = "乱斗大逃杀盗播电台",
			color_override = "red",
		)

/// There's only one person left, we have a winner!
/datum/battle_royale_controller/proc/announce_winner(obj/item/implant/losing_implant)
	battle_running = FALSE
	if (length(contestant_implants) > 1)
		return

	var/message = ""
	var/mob/living/loser = losing_implant.imp_in
	var/obj/item/implant/winning_implant = pop(contestant_implants)
	var/mob/living/winner = winning_implant?.imp_in

	if (isnull(winner) && isnull(loser))
		message = "不知怎么的，今晚似乎没有赢家。真令人失望！"
	else
		var/loser_text = isnull(loser) ? "随着另一位剩余选手被取消资格" : "随着[loser.real_name]死亡"
		var/winner_text = isnull(winner) ? "我们很遗憾地宣布，本应获胜的选手也被取消了资格。太不会表演了！" : "现在只剩[winner.real_name]了。恭喜，我们有赢家了！"
		message = "[loser_text], [winner_text]"

	if (!isnull(winner))
		podspawn(list(
			"target" = get_turf(winner),
			"style" = /datum/pod_style/syndicate,
			"spawn" = /obj/item/food/roast_dinner,
		))

	priority_announce(
		text = message,
		title = "乱斗大逃杀赢家",
		sound = 'sound/announcer/notice/notice1.ogg',
		has_important_message = TRUE,
		sender_override = "乱斗大逃杀盗播电台",
		color_override = "red",
	)

	qdel(winning_implant) // You get to live!
	winner?.mind?.remove_antag_datum(/datum/antagonist/survivalist/battle_royale)
	qdel(src)

/// Called halfway through the battle, if you've not made it to the designated battle zone we kill you
/datum/battle_royale_controller/proc/limit_area()
	priority_announce(
		text = "各位，赛程已过半！还没赶到[chosen_area]的人可要听坏消息了……你们出局了！",
		title = "乱斗大逃杀最新消息",
		sound = 'sound/announcer/notice/notice1.ogg',
		has_important_message = TRUE,
		sender_override = "乱斗大逃杀盗播电台",
		color_override = "red",
	)

	for (var/obj/item/implant/explosive/battle_royale/contestant_implant as anything in contestant_implants)
		contestant_implant.limit_areas()

/// Well you're out of time, bad luck
/datum/battle_royale_controller/proc/finish()
	battle_running = FALSE

	priority_announce(
		text = "抱歉，各位幸存选手，你们的时间到了。\
			很遗憾地宣布，本届乱斗大逃杀没有赢家。\n\
			祝下次好运！",
		title = "乱斗大逃杀结束",
		sound = 'sound/announcer/notice/notice1.ogg',
		has_important_message = TRUE,
		sender_override = "乱斗大逃杀盗播电台",
		color_override = "red",
	)

	for (var/obj/item/implant/explosive/battle_royale/contestant_implant as anything in contestant_implants)
		contestant_implant.explode()

	qdel(src)
