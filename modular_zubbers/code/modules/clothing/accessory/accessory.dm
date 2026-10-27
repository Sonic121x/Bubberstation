/obj/item/clothing/accessory/pocketwatch
	name = "怀表"
	desc = "一只精致的金色怀表，灵感来自卡罗塔广受欢迎的 Uair 品牌。打开我吧，傻瓜。打开光芒，召唤我，领受我的威严。"
	icon = 'modular_skyrat/master_files/icons/donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/donator/mob/clothing/custom_w.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/donator/mob/inhands/donator_right.dmi'
	worn_icon_state = "pocketwatch"
	icon_state = "pocketwatch"
	inhand_icon_state = "pocketwatch"
	var/list/spans = list("velvet")
	actions_types = list(/datum/action/item_action/hypno_whisper)

//TODO: make a component for all that various hypno stuff instead of adding it to items individually
/obj/item/clothing/accessory/pocketwatch/ui_action_click(mob/living/user, action)
	if(!isliving(user) || !can_use(user))
		return
	var/message = input(user, "以催眠低语说话", "低语")
	if(QDELETED(src) || QDELETED(user) || !message || !user.can_speak())
		return
	user.whisper(message, spans = spans)


/obj/item/clothing/accessory/pocketwatch/examine(mob/user)
	. = ..()
	. += span_info("当前 CST（本地）时间为：[round_timestamp()]。")
	. += span_info("当前 TCT（银河）时间为：[time2text(world.realtime, "hh:mm:ss")]。")

/obj/item/storage/backpack/kanken //Donor item for LT3
	name = "kånken 双肩包"
	desc = "经典的瑞典设计，采用耐磨的维尼纶面料，拉链可打开整个主隔层。配有小前袋、简洁的肩带和顶部提手，经久耐用，可陪伴一生。"
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/storage.dmi'
	lefthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/deforest_medical_items/icons/inhands/cases_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/deforest_medical_items/icons/worn/worn_teshari.dmi'
	icon_state = "technician"
	inhand_icon_state = "technician"

/obj/item/clothing/accessory/fake/medal
	name = "塑料奖章"
	desc = "得了吧，想得美。他们不会记录这一枚的，尤其上面还写着“你是赢家!!”。Alt-点击可更换外观！"

/obj/item/clothing/accessory/fake/medal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/medal)

/datum/atom_skin/medal
	abstract_type = /datum/atom_skin/medal

/datum/atom_skin/medal/bronze
	preview_name = "青铜"
	new_icon_state = "bronze"

/datum/atom_skin/medal/bronze_heart
	preview_name = "青铜之心"
	new_icon_state = "bronze_heart"

/datum/atom_skin/medal/silver
	preview_name = "白银"
	new_icon_state = "silver"

/datum/atom_skin/medal/gold
	preview_name = "黄金"
	new_icon_state = "gold"

/datum/atom_skin/medal/plasma
	preview_name = "等离子"
	new_icon_state = "plasma"

/datum/atom_skin/medal/cargo
	preview_name = "货运"
	new_icon_state = "cargo"

/datum/atom_skin/medal/paperwork
	preview_name = "文书"
	new_icon_state = "medal_paperwork"

/datum/atom_skin/medal/medical_second_class
	preview_name = "二级医疗"
	new_icon_state = "med_medal"

/datum/atom_skin/medal/medical_first_class
	preview_name = "一级医疗"
	new_icon_state = "med_medal2"

/datum/atom_skin/medal/atmosian
	preview_name = "大气人"
	new_icon_state = "elderatmosian"

/datum/atom_skin/medal/emergency_general
	preview_name = "应急服务 - 通用"
	new_icon_state = "emergencyservices"

/datum/atom_skin/medal/emergency_engineering
	preview_name = "应急服务 - 工程"
	new_icon_state = "emergencyservices_engi"

/datum/atom_skin/medal/emergency_medical
	preview_name = "应急服务 - 医疗"
	new_icon_state = "emergencyservices_med"

// Pride Pin Over-ride
/obj/item/clothing/accessory/pride
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'

/obj/item/clothing/accessory/pride/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/pride)

/datum/atom_skin/pride
	abstract_type = /datum/atom_skin/pride

/datum/atom_skin/pride/rainbow
	preview_name = "彩虹骄傲"
	new_icon_state = "pride"

/datum/atom_skin/pride/bisexual
	preview_name = "双性恋骄傲"
	new_icon_state = "pride_bi"

/datum/atom_skin/pride/pansexual
	preview_name = "泛性恋骄傲"
	new_icon_state = "pride_pan"

/datum/atom_skin/pride/asexual
	preview_name = "无性恋骄傲"
	new_icon_state = "pride_ace"

/datum/atom_skin/pride/nonbinary
	preview_name = "非二元骄傲"
	new_icon_state = "pride_enby"

/datum/atom_skin/pride/transgender
	preview_name = "跨性别骄傲"
	new_icon_state = "pride_trans"

/datum/atom_skin/pride/intersex
	preview_name = "间性骄傲"
	new_icon_state = "pride_intersex"

/datum/atom_skin/pride/lesbian
	preview_name = "女同性恋骄傲"
	new_icon_state = "pride_lesbian"

/datum/atom_skin/pride/mlm
	preview_name = "男同性恋 / 男同骄傲"
	new_icon_state = "pride_mlm"

/datum/atom_skin/pride/genderfluid
	preview_name = "性别流动骄傲"
	new_icon_state = "pride_genderfluid"

/datum/atom_skin/pride/genderqueer
	preview_name = "性别酷儿骄傲"
	new_icon_state = "pride_genderqueer"

/datum/atom_skin/pride/aromantic
	preview_name = "无浪漫倾向骄傲"
	new_icon_state = "pride_aromantic"

// Dogtags
/obj/item/clothing/accessory/dogtags
	name = "狗牌"
	desc = "两枚小金属牌，用一小段细链连接，上面记录着重要的健康信息。还有入土为安所需的一切……"
	icon = 'modular_zubbers/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/accessories.dmi'
	icon_state = "dogtags"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF // its metal, and funny to leave behind when you dust.
	attachment_slot = NONE
	above_suit = TRUE

/// This list is for Protean Match tags, and stores how many tags are waiting to be matched.
GLOBAL_LIST_EMPTY_TYPED(protean_match_tag_pool, /obj/item/clothing/accessory/dogtags/protean_match)
/// This list is for Protean Match tags, and stores every tag that's currently assigned to someone. Intended to be used to prevent one person having multiple tags.
GLOBAL_LIST_EMPTY_TYPED(all_assigned_protean_match_tags, /obj/item/clothing/accessory/dogtags/protean_match)

// The tag pool, contains either unmatched Wearers or unmatched Proteans, waiting for the opposite type to join and match them.
// It should never ever ever contain both, since if the second type tries to join the list it'll just get paired.
// So if we need to differentiate between if there's Proteans or Wearers in the pool, we just check the first entry.
#define POOL GLOB.protean_match_tag_pool
#define ASSIGNED_TAGS GLOB.all_assigned_protean_match_tags
#define UNASSIGNED "0"
#define IN_POOL "1"
#define MATCHED "2"

/obj/item/clothing/accessory/dogtags/protean_match
	name = "\improper 普罗蒂安配对牌"
	desc = "纳米传讯普罗蒂安配对项目的一枚小牌子，该项目将普罗蒂安船员与有兴趣的佩戴者配对。"
	worn_icon = null // People shouldn't have to abandon 5 pixels of swag and aura to wear this
	custom_premium_price = PAYCHECK_CREW * 0.4
	/// Name of the person assigned to the tag
	var/assignee_name
	/// the "true" name of the assignee, source.mind.name, used to keep one person from putting a bunch of their own tags in the pool.
	var/assignee_truename
	/// Is the person assigned to the tag a protean? TRUE if yes
	var/assignee_protean
	/// What step of the matching journey
	var/match_progress = UNASSIGNED
	var/datum/weakref/paired_tag_weakref

///This is how a person can assign a tag to themself, or switch if they're in the candidate pool
/obj/item/clothing/accessory/dogtags/protean_match/attack_self(mob/user)
	switch(match_progress)
		if(UNASSIGNED)
			assign(user)
			// match_progress and sounds are set within assign()
		if(IN_POOL)
			to_chat(user, "你按下牌子上的按钮，将它从普罗蒂安配对候选池中移除并解除认领。")
			playsound(src, "modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg", 20, FALSE)
			balloon_alert(user, "牌子已解除认领")

			unassign()
			return
		if(MATCHED)
			var/obj/item/clothing/accessory/dogtags/protean_match/paired_tag = paired_tag_weakref?.resolve()
			var/safety = (tgui_alert(user, "你目前与[paired_tag?.assignee_name]配对。确定要解除认领你的牌子吗？这将同时解除两枚牌子的认领。", "解除牌子认领？", list("Unclaim", "Cancel")))
			if(safety == "Cancel" || !in_range(src, user))
				return
			to_chat(user, "你按下牌子上的按钮，与[paired_tag?.assignee_name]解除配对，并退出普罗蒂安配对候选池。")
			playsound(src, "modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg", 20, FALSE)
			balloon_alert(user, "牌子已解除配对")

			paired_tag.unassign("配对牌子已停用")
			unassign()
			return

/obj/item/clothing/accessory/dogtags/protean_match/click_alt(mob/user)
	if(length(POOL) ? (assignee_protean == POOL[1].assignee_protean) : TRUE)
		playsound(src, "sound/machines/buzz/buzz-sigh.ogg", 20, FALSE)
		balloon_alert(user, "池中没有其他有效配对")
		return
	if(match_progress == MATCHED)
		var/obj/item/clothing/accessory/dogtags/protean_match/paired_tag = paired_tag_weakref?.resolve()
		var/safety = (tgui_alert(user, "你目前与[paired_tag?.assignee_name]配对。确定要尝试与池中的其他人配对吗？这将解除对方牌子的认领。", "重新配对牌子？", list("Re-match", "Cancel")))
		if(safety == "Cancel" || !in_range(src, user))
			return
		unassign()
		assign(user) //This comes before the paired tag is unassigned so that it doesn't consider the existing pairing as a valid candidate
		paired_tag.unassign("配对牌子已停用")

/obj/item/clothing/accessory/dogtags/protean_match/Destroy()
	POOL -= src
	ASSIGNED_TAGS -= src
	if(match_progress == MATCHED)
		var/obj/item/clothing/accessory/dogtags/protean_match/paired_tag = paired_tag_weakref?.resolve()
		paired_tag.unassign("配对牌子已销毁")
	return ..()

///Filters out crew that can't wear Proteans or shouldn't have them.
/obj/item/clothing/accessory/dogtags/protean_match/proc/assign(mob/source)
	. = TRUE
	/// If this ends up not being null, the assignment fails and returns the reason
	var/ineligibility_reason = null
	var/mob/living/user
	var/obj/item/card/id/user_id
	var/user_id_name

	///Runs through a bunch of reasons why you shouldn't get to be in the pool. If it finds one it sets the ineligibility_reason to a string, which makes the assignment fail
	if(isliving(source))
		user = source
		user_id = user.get_idcard(TRUE)
		user_id_name = user_id?.get_displayed_name()
		var/turf/station_check = get_turf(user)

		for(var/obj/item/clothing/accessory/dogtags/protean_match/tag as anything in ASSIGNED_TAGS)
			if(user_id_name == tag.assignee_name)
				ineligibility_reason = "已有牌子使用了该名字"
				break
			if(source.mind.name == tag.assignee_truename) //Checks the user's "true name" to prevent trolling with multiple cardboard IDs
				ineligibility_reason = "每人仅限一枚"
				break
		if(isnull(user_id))
			ineligibility_reason = "未找到身份卡"
		else if(!station_check || !is_station_level(station_check.z))
			ineligibility_reason = "不在空间站 Z 层"
		else if(user.has_quirk(/datum/quirk/equipping/entombed))
			ineligibility_reason = "处于 MOD 外骨骼封闭状态"
		else if(iscarbon(user))
			var/mob/living/carbon/carbon_user = user
			if(carbon_user.dna.species.id == SPECIES_SNAIL)
				ineligibility_reason = "蜗牛人"
	else
		ineligibility_reason = "无效生物"

	if(ineligibility_reason)
		playsound(src, "sound/machines/buzz/buzz-sigh.ogg", 20, FALSE)
		balloon_alert(source, "不符合条件：[ineligibility_reason]")
		return

///From here, we assign a name and species to the tag, and try to match it. If it fails, adds it to the pool.
	assignee_name = user_id_name
	assignee_truename = source.mind.name
	assignee_protean = isprotean(source)
	ASSIGNED_TAGS += src
	name += " - [assignee_name]（[assignee_protean ? "普罗蒂安" : "佩戴者"]）"
	update_static_data_for_all_viewers()
//If you aren't the same as the other people in the pool, you get matched with one of them
	if(length(POOL))
		if(assignee_protean != POOL[1].assignee_protean)
			var/obj/item/clothing/accessory/dogtags/protean_match/matched_wearer_tag = pick(POOL)
			matched_wearer_tag.handle_match(src) //Makes the match's tag ping
			handle_match(matched_wearer_tag) //Makes our tag ping
			return
	// This should only run if the code block above fails
	POOL += src
	match_progress = IN_POOL
	say("未找到匹配，已加入候选池！池中还有 [(length(POOL) - 1) ? "[length(POOL) - 1]" : "没有其他" ] 位[assignee_protean ? "普罗蒂安" : "佩戴者"]。")

///Handles the logistics of matching tags. Done by both sets of tags.
/obj/item/clothing/accessory/dogtags/protean_match/proc/handle_match(obj/item/clothing/accessory/dogtags/protean_match/other_tag)
	match_progress = MATCHED
	POOL -= src
	playsound(src, "modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg", 20, FALSE)
	say("已与[(other_tag.assignee_protean == TRUE) ? "普罗蒂安" : "佩戴者"]配对：[other_tag.assignee_name]！")
	paired_tag_weakref = other_tag.create_weakref()

/// Used both when unmatching with a person and when leaving the match pool.
/obj/item/clothing/accessory/dogtags/protean_match/proc/unassign(unmatch_reason)
	match_progress = UNASSIGNED
	POOL -= src
	ASSIGNED_TAGS -= src
	assignee_name = null
	assignee_truename = null
	assignee_protean = null
	name = initial(name)
	paired_tag_weakref = null
	update_static_data_for_all_viewers()
	if(unmatch_reason)
		say("你已被解除配对。原因：[unmatch_reason]。")

/obj/item/clothing/accessory/dogtags/protean_match/examine(mob/user)
	. = ..()
	if(!(in_range(user, src)))
		return
	if(assignee_name)
		. += span_notice("这组牌子已分配给[assignee_name]，一位[assignee_protean ? "普罗蒂安" : "佩戴者"]。")
	switch(match_progress)
		if(UNASSIGNED)
			. += span_notice("你可以在手持时使用它来加入该项目。")
		if(IN_POOL)
			. += span_notice("它目前位于候选池中，与另外 [length(POOL) - 1] 位一同等待。手持使用即可离开候选池。")
		if(MATCHED)
			var/obj/item/clothing/accessory/dogtags/protean_match/paired_tag = paired_tag_weakref?.resolve()
			. += span_notice("它目前与[paired_tag.assignee_name]配对，手持使用即可解除配对。要与队列中的其他人配对，请 Alt-点击。")

#undef POOL
#undef ASSIGNED_TAGS
#undef UNASSIGNED
#undef IN_POOL
#undef MATCHED

/*
Greyscaled Medals

Highly modular and customizable spriteset.
Just a note - the .jsons will NOT agree with having different amounts of components per icon.
Use the 'blank' icon to keep the medals all sorted in their correct file,
even if they have different numbers of components.

Potential future ideas:
- Tie to job hours
- Unlock in Loadout when a requirement is met (i.e. job hours, as above)
- Department medals (adding to TG's existing medal lockboxes)
*/

/*
// AWARDABLE MEDALS
// These can be pinned onto others to 'award' them, appearing in the round-end screen
*/
/obj/item/clothing/accessory/medal/bubber
	name = "强韧奖章"
	desc = "授予在诸多领域展现出强韧品质者的奖章。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/medal/bubber"
	post_init_icon_state = "medal_robust"
	greyscale_config = /datum/greyscale_config/medals/syndicate
	greyscale_config_worn = /datum/greyscale_config/medals/syndicate/worn
	greyscale_colors = "#ffff66#990000#ffff66#990000#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

// DS-2/Syndicate Medals
/obj/item/clothing/accessory/medal/bubber/syndicate
	name = "辛迪加强韧奖章"
	desc = "授予在诸多领域展现出强韧品质的真正辛迪加特工的奖章。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate"
	post_init_icon_state = "medal_robust"

/obj/item/clothing/accessory/medal/bubber/syndicate/espionage
	name = "辛迪加间谍奖章"
	desc = "授予已证明自己精通秘密行动者的奖章。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/espionage"
	post_init_icon_state = "medal_espi"

/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation
	name = "辛迪加审讯奖章"
	desc = "授予已证明自己能审讯敌方公司中最顽固成员者的奖章。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/interrogation"
	post_init_icon_state = "medal_inter"

/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence
	name = "辛迪加情报奖章"
	desc = "授予在收集竞争对手情报（无论手段隐蔽还是公开）以及保护 \
	己方雇主机密方面都颇具天赋的特工的奖章。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/intelligence"
	post_init_icon_state = "medal_intel"

/obj/item/clothing/accessory/medal/bubber/syndicate/diligence
	name = "辛迪加勤勉奖章"
	desc = "授予较为罕见的特工——那种不会贸然冲入的特工；这是给那些通过耐心观察与谋划，抓住 \
	完美行动时机者的奖章。就像我们标志性的蛇一样，他们等待敌人露出咽喉才出击，送出完美的致命一击。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/diligence"
	post_init_icon_state = "medal_dili"

/obj/item/clothing/accessory/medal/bubber/syndicate/communications
	name = "辛迪加通信奖章"
	desc = "授予已证明自己是出色反通信专家的特工的奖章。"
	icon_state = "/obj/item/clothing/accessory/medal/bubber/syndicate/communications"
	post_init_icon_state = "medal_comms"

/*
// ACCESSORY MEDALS
// These ones are purely cosmetic attachments
*/

/obj/item/clothing/accessory/bubber/acc_medal
	name = "圆形奖章"
	desc = "你不该拥有这个，请提交错误报告！"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal"
	post_init_icon_state = "medal_alt"
	greyscale_config = /datum/greyscale_config/medals/circle
	greyscale_config_worn = /datum/greyscale_config/medals/circle/worn
	greyscale_colors = "#9900cc#ffffff#9900cc#ff99ff#ffffff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/*
// Circle Medals
// The default acc_medal is already the 'alt_circle' and defines our configs
*/
/obj/item/clothing/accessory/bubber/acc_medal/circle
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle"
	post_init_icon_state = "medal"

/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/circle/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Shield Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/shield
	name = "盾形奖章"
	desc = "一枚普通的日常奖章。"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/shield
	greyscale_config_worn = /datum/greyscale_config/medals/shield/worn

/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/shield/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Bar Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/bar
	name = "条形奖章"
	desc = "一枚普通的日常奖章。"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/bar
	greyscale_config_worn = /datum/greyscale_config/medals/bar/worn

/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/bar/hollow"
	post_init_icon_state = "medal_hollow"

/*
// Heart Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/heart
	name = "心形奖章"
	desc = "一枚普通的日常奖章。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/heart
	greyscale_config_worn = /datum/greyscale_config/medals/heart/worn

/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special"
	post_init_icon_state = "medal_special"

/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/heart/special/bar_ribbon"
	post_init_icon_state = "medal_special_bar_ribbon"

/*
// Crown Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/crown
	name = "冠形奖章"
	desc = "一枚普通的日常奖章。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown"
	post_init_icon_state = "medal"
	greyscale_config = /datum/greyscale_config/medals/crown
	greyscale_config_worn = /datum/greyscale_config/medals/crown/worn

/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/bar_ribbon"
	post_init_icon_state = "medal_bar_ribbon"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow"
	post_init_icon_state = "medal_hollow"

/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/crown/hollow/bar_ribbon"
	post_init_icon_state = "medal_hollow_bar_ribbon"

/*
// Special Medals
*/
/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal
	name = "发光水晶项链"
	desc = "一块串在项链上的发光石头，一份类似奖章的感谢信物。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal"
	post_init_icon_state = "necklace_crystal"
	greyscale_config = /datum/greyscale_config/medals/glow
	greyscale_config_worn = /datum/greyscale_config/medals/glow/worn
	greyscale_colors = "#7effff"

/obj/item/clothing/accessory/bubber/acc_medal/glowcrystal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/glowcrystal)

/datum/atom_skin/glowcrystal
	abstract_type = /datum/atom_skin/glowcrystal

/datum/atom_skin/glowcrystal/crystal
	preview_name = "水晶"
	new_icon_state = "necklace_crystal"

/datum/atom_skin/glowcrystal/bar
	preview_name = "条形"
	new_icon_state = "necklace_bar"

/datum/atom_skin/glowcrystal/bar_hollow
	preview_name = "空心条形"
	new_icon_state = "necklace_bar_hollow"

/datum/atom_skin/glowcrystal/diamond
	preview_name = "钻石"
	new_icon_state = "necklace_diamond"

/datum/atom_skin/glowcrystal/diamond_hollow
	preview_name = "空心钻石"
	new_icon_state = "necklace_diamond_hollow"

/datum/atom_skin/glowcrystal/shard
	preview_name = "碎片"
	new_icon_state = "necklace_shard"

/datum/atom_skin/glowcrystal/shard_hollow
	preview_name = "空心碎片"
	new_icon_state = "necklace_shard_hollow"

/datum/atom_skin/glowcrystal/triangle
	preview_name = "三角形"
	new_icon_state = "necklace_triangle"

/datum/atom_skin/glowcrystal/triangle_hollow
	preview_name = "空心三角形"
	new_icon_state = "necklace_triangle_hollow"

/datum/atom_skin/glowcrystal/circle
	preview_name = "圆形"
	new_icon_state = "necklace_circle"

/*
// Rank pins
*/
/obj/item/clothing/accessory/bubber/acc_medal/rankpin
	name = "军衔别针"
	desc = "一枚用于展示成就、晋升或其他应得认可的别针。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin"
	post_init_icon_state = "star"
	greyscale_config = /datum/greyscale_config/medals/rank_pins
	greyscale_config_worn = /datum/greyscale_config/medals/rank_pins/worn
	greyscale_colors = "#FFFFFF"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/bar"
	post_init_icon_state = "bar"

/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/rankpin/two_bar"
	post_init_icon_state = "two_bar"

/*
// Neckpins
*/
/obj/item/clothing/accessory/bubber/acc_medal/neckpin
	name = "\improper 纳米传讯公司领针"
	desc = "一枚专门用来表达对公司忠诚的别针！"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin"
	post_init_icon_state = "ntpin"
	greyscale_config = /datum/greyscale_config/medals/neckpins
	greyscale_config_worn = /datum/greyscale_config/medals/neckpins/worn
	greyscale_colors = "#FFFFFF#CCCED1"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom
	name = "\improper 中央指挥部领针"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/centcom"
	post_init_icon_state = "ccpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed
	name = "\improper 银河联邦领针"
	desc = "一枚专门用来表达对联邦忠诚的别针！"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed"
	post_init_icon_state = "sfpin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed911
	name = "\improper 银河联邦 911 领针"
	desc = "一枚专门用来表达对联邦忠诚的别针！"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed911"
	post_init_icon_state = "911pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed811
	name = "\improper 银河联邦 811 领针"
	desc = "一枚专门用来表达对联邦忠诚的别针！"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/galfed811"
	post_init_icon_state = "811pin"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate
	name = "\improper 辛迪加领针"
	desc = "一枚专门用来表达对辛迪加忠诚的别针！"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/syndicate"
	post_init_icon_state = "syndipin"
	greyscale_colors = "#262626#9c0000"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne
	name = "\improper 英特戴恩领针"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/interdyne"
	post_init_icon_state = "ippin"
	greyscale_colors = "#FFFFFF#3aba1e"

/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon
	name = "\improper 塔肯港领针"
	icon_state = "/obj/item/clothing/accessory/bubber/acc_medal/neckpin/porttarkon"
	post_init_icon_state = "ptpin"

/*
// Military Bar Ribbons
*/
/obj/item/clothing/accessory/bubber/military_ribbon
	name = "军用绶带"
	desc = "一条普通的军用绶带"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/military_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/military_ribbon/worn
	greyscale_colors = "#ff0000#04ff00#0008ff"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/military_ribbon/two
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/two"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/military_ribbon/three
	icon_state = "/obj/item/clothing/accessory/bubber/military_ribbon/three"
	post_init_icon_state = "ribbon3"

/*
// Ribbons
*/
/obj/item/clothing/accessory/bubber/ribbon
	name = "绶带"
	desc = "一条普通的日常绶带。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon"
	post_init_icon_state = "ribbon1"
	greyscale_config = /datum/greyscale_config/medals/color_ribbon
	greyscale_config_worn = /datum/greyscale_config/medals/color_ribbon/worn
	greyscale_colors = "#ffffff#664200#fff700"
	minimize_when_attached = TRUE
	attachment_slot = NONE
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_slash"
	post_init_icon_state = "ribbon2"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_arrup"
	post_init_icon_state = "ribbon3"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_line
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_line"
	post_init_icon_state = "ribbon4"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_dual"
	post_init_icon_state = "ribbon5"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_flat"
	post_init_icon_state = "ribbon6"

/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone
	icon_state = "/obj/item/clothing/accessory/bubber/ribbon/ribbon_twotone"
	post_init_icon_state = "ribbon7"

/// GalFed Accessories
/obj/item/clothing/accessory/bubber/galfedribbon
	name = "\improper 银河联邦军衔绶带"
	desc = "一条普通的军用绶带。"
	icon = 'icons/map_icons/clothing/accessory.dmi'
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon"
	post_init_icon_state = "star_arr_ribbon_1"
	greyscale_colors = "#FFD700"
	greyscale_config = /datum/greyscale_config/galfedribbons
	greyscale_config_worn = /datum/greyscale_config/galfedribbons/worn
	minimize_when_attached = TRUE

/obj/item/clothing/accessory/bubber/galfedribbon/rank2
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank2"
	post_init_icon_state = "star_arr_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank3
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank3"
	post_init_icon_state = "star_sw_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank4
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank4"
	post_init_icon_state = "star_sw_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank5
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank5"
	post_init_icon_state = "star_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank6
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank6"
	post_init_icon_state = "star_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank7
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank7"
	post_init_icon_state = "star_ribbon_3"

/obj/item/clothing/accessory/bubber/galfedribbon/rank8
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank9
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank8"
	post_init_icon_state = "arr_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank10
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank9"
	post_init_icon_state = "arr_ribbon_3"

/obj/item/clothing/accessory/bubber/galfedribbon/rank11
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank10"
	post_init_icon_state = "sw_ribbon_1"

/obj/item/clothing/accessory/bubber/galfedribbon/rank12
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank11"
	post_init_icon_state = "sw_ribbon_2"

/obj/item/clothing/accessory/bubber/galfedribbon/rank13
	icon_state = "/obj/item/clothing/accessory/bubber/galfedribbon/rank12"
	post_init_icon_state = "sw_ribbon_3"

/obj/item/clothing/accessory/nova/acc_medal/neckpin/galfed/official
	name = "\improper 银河联邦正式领针"
	desc = "一枚特殊的金色领针，用以表达对联邦的真正忠诚。"
	greyscale_colors = "#ffff66#0099ff"
