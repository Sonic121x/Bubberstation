#define POSTER_MOOD_CAT "poster_mood"

/obj/item/poster/quirk
	name = "特质海报占位物"
	desc = "糟了！你不应该拿到这个！"
	icon_state = "rolled_poster_legit"
	/// People from the selected department will gain a mood buff. If no department is specified applies to the entire crew.
	var/quirk_poster_department = NONE

/obj/item/poster/quirk/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()

	register_context()

	if(poster_structure)
		var/obj/structure/sign/poster/quirk/department_grab = poster_structure
		department_grab.quirk_poster_department = quirk_poster_department

/// You can use any spraypaint can on a quirk poster to turn it into a contraband poster from the traitor objective
/obj/item/poster/quirk/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!user.is_antag() || !HAS_TRAIT(user, TRAIT_POSTERBOY) || !istype(tool, /obj/item/toy/crayon))
		return NONE
	balloon_alert(user, "正在改造海报……")
	if(!do_after(user, 5 SECONDS, user))
		balloon_alert(user, "已中断！")
		return ITEM_INTERACT_BLOCKING
	var/obj/item/poster/traitor/quirkspawn = new(get_turf(src))
	user.put_in_hands(quirkspawn)
	to_chat(user, span_notice("你改造了一张自己的海报！"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/// Screentip for the above

/obj/item/poster/quirk/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!user.is_antag() || !HAS_TRAIT(user, TRAIT_POSTERBOY) || !istype(held_item, /obj/item/toy/crayon))
		return NONE
	context[SCREENTIP_CONTEXT_LMB] = "改造成打击士气的海报"
	return CONTEXTUAL_SCREENTIP_SET

/obj/structure/sign/poster/quirk
	name = "特质海报"
	desc = "一大张自制的耐太空环境印刷纸。"
	poster_item_name = "自制海报"
	poster_item_desc = "用心制作的海报，有些人看了会很高兴。"
	poster_item_icon_state = "rolled_legit"
	var/quirk_poster_department = NONE
	var/datum/proximity_monitor/advanced/quirk_posters/mood_buff

/obj/structure/sign/poster/quirk/on_placed_poster(mob/user)
	mood_buff = new(_host = src, range = 7, _ignore_if_not_on_turf = TRUE, department = quirk_poster_department)
	return ..()

/obj/structure/sign/poster/quirk/wirecutter_act(mob/living/user, obj/item/tool)
	QDEL_NULL(mood_buff)
	return ..()

/obj/structure/sign/poster/quirk/Destroy()
	QDEL_NULL(mood_buff)
	return ..()

/obj/structure/sign/poster/quirk/apply_holiday()
	var/obj/structure/sign/poster/traitor/holiday_data = /obj/structure/sign/poster/quirk/festive
	name = initial(holiday_data.name)
	desc = initial(holiday_data.desc)
	icon_state = initial(holiday_data.icon_state)

/*
 * Applies a department-based mood if you can see the parent.
 *
 * - Applies a mood buff to people who are in visible range of the item.
 */
/datum/proximity_monitor/advanced/quirk_posters
	/// Defines the specific department that the poster will apply its mood buff to, if the poster has a quirk_poster_department.
	var/department

/datum/proximity_monitor/advanced/quirk_posters/New(atom/_host, range, _ignore_if_not_on_turf = TRUE, department)
	. = ..()
	src.department = department
	RegisterSignal(host, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/proximity_monitor/advanced/quirk_posters/field_turf_crossed(atom/movable/crossed, turf/old_location, turf/new_location)
	if (!isliving(crossed) || !can_see(crossed, host, current_range))
		return
	on_seen(crossed)

/datum/proximity_monitor/advanced/quirk_posters/proc/on_examine(datum/source, mob/examiner)
	SIGNAL_HANDLER
	if (isliving(examiner))
		on_seen(examiner)

/datum/proximity_monitor/advanced/quirk_posters/proc/on_seen(mob/living/viewer)
	if (!viewer.mind || !viewer.mob_mood || (IS_UNCONSCIOUS_OR_CRIT(viewer)) || viewer.is_blind())
		return
	if(!viewer.can_read(host, READING_CHECK_LIGHT, TRUE))
		return
	if (viewer.mob_mood.has_mood_of_category(POSTER_MOOD_CAT))
		return
	var/viewer_department = viewer.mind.assigned_role.paycheck_department
	if(department != NONE && viewer_department != department)
		return
	to_chat(viewer, span_notice("哇，真棒的海报！"))
	viewer.add_mood_event(POSTER_MOOD_CAT, /datum/mood_event/poster_mood)

/datum/mood_event/poster_mood
	description = "那张海报真让我备受鼓舞！"
	mood_change = 2

// random posters

/obj/item/poster/quirk/random
	poster_type = /obj/structure/sign/poster/quirk/random

/obj/structure/sign/poster/quirk/random
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/quirk

/obj/item/poster/quirk/crew/random
	poster_type = /obj/structure/sign/poster/quirk/crew/random

/obj/structure/sign/poster/quirk/crew/random
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/quirk/crew

// actual poster items

/obj/structure/sign/poster/quirk/festive
	name = "共度佳节。"
	desc = "一张描绘牵手场景的海报，让我们想起共同度过的节日。\
	人们阅读这张海报后会心情更好！"
	icon_state = "quirk_festive"
	never_random = TRUE

/obj/structure/sign/poster/quirk/crew
	poster_item_desc = "用心制作的海报，所有人看了都会很高兴。"

/obj/structure/sign/poster/quirk/crew/hang
	name = "坚持住"
	desc = "一张画着猫吊在树枝上的海报。一定要坚持住。\
	人们阅读这张海报后会心情更好！"
	icon_state = "hang_in_there"

/obj/structure/sign/poster/quirk/crew/renault
	name = "舰长的宠物"
	desc = "一张画着舰长心爱的雷诺的海报。它挺不错。\
	人们阅读这张海报后会心情更好！"
	icon_state = "renault"

/obj/structure/sign/poster/quirk/crew/bike
	name = "总有一天……"
	desc = "一张画着自行车的海报。总有一天它一定会属于你！\
	人们阅读这张海报后会心情更好！"
	icon_state = "bike"

// Departmental posters

/obj/item/poster/quirk/cargo_logo
	poster_type = /obj/structure/sign/poster/quirk/cargo_logo
	quirk_poster_department = ACCOUNT_CAR

/obj/structure/sign/poster/quirk/cargo_logo
	name = "货运标志"
	desc = "一张用心绘制箱子的海报，是货运共和国的旗帜。\
	货运部成员阅读这张海报后会心情更好！"
	icon_state = "cargo_logo"

/obj/item/poster/quirk/cargo_slogan
	poster_type = /obj/structure/sign/poster/quirk/cargo_slogan
	quirk_poster_department = ACCOUNT_CAR

/obj/structure/sign/poster/quirk/cargo_slogan
	name = "货运强盛"
	desc = "团结让货运更强大！货运工人联合起来！\
	货运部成员阅读这张海报后会心情更好！"
	icon_state = "cargo_slogan"

/obj/item/poster/quirk/engineering_logo
	poster_type = /obj/structure/sign/poster/quirk/engineering_logo
	quirk_poster_department = ACCOUNT_ENG

/obj/structure/sign/poster/quirk/engineering_logo
	name = "工程标志"
	desc = "一张用心绘制扳手的海报。\
	工程部成员阅读这张海报后会心情更好！"
	icon_state = "engineering_logo"

/obj/item/poster/quirk/engineering_slogan
	poster_type = /obj/structure/sign/poster/quirk/engineering_slogan
	quirk_poster_department = ACCOUNT_ENG

/obj/structure/sign/poster/quirk/engineering_slogan
	name = "杜绝崩解"
	desc = "今天引擎不会崩解！\
	工程部成员阅读这张海报后会心情更好！"
	icon_state = "engineering_slogan"

/obj/item/poster/quirk/medical_logo
	poster_type = /obj/structure/sign/poster/quirk/medical_logo
	quirk_poster_department = ACCOUNT_MED

/obj/structure/sign/poster/quirk/medical_logo
	name = "蓝十字"
	desc = "一张用心绘制蓝十字的海报。\
	医疗部成员阅读这张海报后会心情更好！"
	icon_state = "medical_logo"

/obj/item/poster/quirk/medical_slogan
	poster_type = /obj/structure/sign/poster/quirk/medical_slogan
	quirk_poster_department = ACCOUNT_MED

/obj/structure/sign/poster/quirk/medical_slogan
	name = "治病救人"
	desc = "治疗所有求助者，救助所有需要帮助的人。\
	医疗部成员阅读这张海报后会心情更好！"
	icon_state = "medical_slogan"

/obj/item/poster/quirk/science_logo
	poster_type = /obj/structure/sign/poster/quirk/science_logo
	quirk_poster_department = ACCOUNT_SCI

/obj/structure/sign/poster/quirk/science_logo
	name = "科研标志"
	desc = "一张用心绘制原子的海报。\
	科研部成员阅读这张海报后会心情更好！"
	icon_state = "science_logo"

/obj/item/poster/quirk/science_slogan
	poster_type = /obj/structure/sign/poster/quirk/science_slogan
	quirk_poster_department = ACCOUNT_SCI

/obj/structure/sign/poster/quirk/science_slogan
	name = "研究与开发"
	desc = "研究未知，开发不可能！\
	科研部成员阅读这张海报后会心情更好！"
	icon_state = "science_slogan"

/obj/item/poster/quirk/security_logo
	poster_type = /obj/structure/sign/poster/quirk/security_logo
	quirk_poster_department = ACCOUNT_SEC

/obj/structure/sign/poster/quirk/security_logo
	name = "安保标志"
	desc = "一张用心绘制盾牌的海报。\
	安保部成员阅读这张海报后会心情更好！"
	icon_state = "security_logo"

/obj/item/poster/quirk/security_logo
	poster_type = /obj/structure/sign/poster/quirk/security_slogan
	quirk_poster_department = ACCOUNT_SEC

/obj/structure/sign/poster/quirk/security_slogan
	name = "守护与服务"
	desc = "保护无辜船员，伸张正义！\
	安保部成员阅读这张海报后会心情更好！"
	icon_state = "security_slogan"

/obj/item/poster/quirk/service_logo
	poster_type = /obj/structure/sign/poster/quirk/service_logo
	quirk_poster_department = ACCOUNT_SRV

/obj/structure/sign/poster/quirk/service_logo
	name = "服务部柯基"
	desc = "一张用心绘制某只柯基犬的海报。\
	服务部成员阅读这张海报后会心情更好！"
	icon_state = "service_logo"

/obj/item/poster/quirk/service_slogan
	poster_type = /obj/structure/sign/poster/quirk/service_slogan
	quirk_poster_department = ACCOUNT_SRV

/obj/structure/sign/poster/quirk/service_slogan
	name = "分享喜悦"
	desc = "用每个行动分享喜悦，用创造带来幸福。\
	服务部成员阅读这张海报后会心情更好！"
	icon_state = "service_slogan"

#undef POSTER_MOOD_CAT
