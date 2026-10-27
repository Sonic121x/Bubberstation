/// This deathrattle group does not care about the area someone dies in.
#define DEATHRATTLE_AREA_NOLIST		0
/// This deathrattle group uses its `area_list` as a blacklist: if someone dies in these areas, they DO NOT cause an alert.
#define DEATHRATTLE_AREA_BLACKLIST	1
/// This deathrattle group uses its `area_list` as a whitelist: if someone dies in these areas, they DO cause an alert.
#define DEATHRATTLE_AREA_WHITELIST	2

/datum/deathrattle_group
	/// The name of our deathrattle group.
	var/name
	/// The associated implants in this deathrattle group.
	var/list/implants = list()
	/// The area list mode.
	var/area_list_mode = DEATHRATTLE_AREA_NOLIST
	/// The area list. See `area_list_mode` for how this gets used.
	var/list/area/area_list = list()
	/// The prefix for this deathrattle group.
	var/prefix

/datum/deathrattle_group/New(name)
	if(name)
		src.name = name
	else
		// Give the group a unique name for debugging, and possible future
		// use for making custom linked groups.
		src.name = "[prefix ? "[prefix]-" : ""][rand(100,999)] [pick(GLOB.phonetic_alphabet)]"

/datum/deathrattle_group/standard
	prefix = "STD"

/// A deathrattle group subtype specifically for alerting people who die in the Lavaland or Icemoon Wastes.
/// As per maintainer request, excludes... basically everything that isn't raw wasteland.
/datum/deathrattle_group/lavaland
	area_list_mode = DEATHRATTLE_AREA_WHITELIST
	area_list = list(
		/area/lavaland,
		/area/icemoon,
	)
	prefix = "MIN"

/*
 * Proc called by new implant being added to the group. Listens for the
 * implant being implanted, removed and destroyed.
 *
 * If implant is already implanted in a person, then trigger the implantation
 * code.
 */
/datum/deathrattle_group/proc/register(obj/item/implant/deathrattle/implant)
	if(implant in implants)
		return
	RegisterSignal(implant, COMSIG_IMPLANT_IMPLANTED, PROC_REF(on_implant_implantation))
	RegisterSignal(implant, COMSIG_IMPLANT_REMOVED, PROC_REF(on_implant_removal))
	RegisterSignal(implant, COMSIG_QDELETING, PROC_REF(on_implant_destruction))

	implants += implant
	implant.current_group = src

	if(implant.imp_in)
		on_implant_implantation(implant.imp_in)

/datum/deathrattle_group/proc/on_implant_implantation(obj/item/implant/implant, mob/living/target, mob/user, silent = FALSE, force = FALSE)
	SIGNAL_HANDLER

	RegisterSignal(target, COMSIG_MOB_STATCHANGE, PROC_REF(on_user_statchange))

/datum/deathrattle_group/proc/on_implant_removal(obj/item/implant/implant, mob/living/source, silent = FALSE, special = 0)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_MOB_STATCHANGE)

/datum/deathrattle_group/proc/on_implant_destruction(obj/item/implant/implant)
	SIGNAL_HANDLER

	implants -= implant

/datum/deathrattle_group/proc/on_user_statchange(mob/living/owner, new_stat)
	SIGNAL_HANDLER

	if(new_stat != DEAD)
		return

	var/name = owner.mind ? owner.mind.name : owner.real_name
	var/area/death_area = get_area(owner)
	// don't alert for a death if it's in in the area list AND we're on blacklist mode
	if(is_type_in_list(death_area, area_list) && area_list_mode == DEATHRATTLE_AREA_BLACKLIST)
		return
	// don't alert a death if it's not in the area list AND we're on whitelist mode
	if(!is_type_in_list(death_area, area_list) && area_list_mode == DEATHRATTLE_AREA_WHITELIST)
		return
	var/area_name = get_area_name(get_turf(owner))
	// All "hearers" hear the same sound.
	var/sound = pick(
		'sound/items/knell/knell1.ogg',
		'sound/items/knell/knell2.ogg',
		'sound/items/knell/knell3.ogg',
		'sound/items/knell/knell4.ogg',
	)


	for(var/_implant in implants)
		var/obj/item/implant/deathrattle/implant = _implant

		// Skip the unfortunate soul, and any unimplanted implants
		if(implant.imp_in == owner || !implant.imp_in)
			continue

		// Deliberately the same message framing as ghost deathrattle
		var/mob/living/recipient = implant.imp_in
		to_chat(recipient, "<i>你脑海中响起一个奇异的机械声音……</i> \"[span_robot("<b>[name]</b> 已死于 <b>[area_name]</b>。")]\"")
		recipient.playsound_local(get_turf(recipient), sound, vol = 75, vary = FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/obj/item/implant/deathrattle
	name = "亡语植入体"
	desc = "但愿不会再有人死去，但也要为那一刻做好准备。"

	actions_types = null
	allow_multiple = TRUE

	implant_info = "植入前需要进行配置。植入后自动激活。\
		当与同一亡语组相连的其他亡语植入体宿主死亡时，会通知本宿主。"

	implant_lore = "强劲公司死亡通知系统，俗称“亡语”植入体，\
		是一种皮下混合式生命体征追踪器与加密发射器，\
		用于与其他植入在宿主体内的死亡通知系统单元通信。一旦检测到生命体征消失，\
		该系统就会将死亡事件及其大致位置转发给其他宿主。它究竟如何实现如此远距离的通信，\
		是一项商业机密，纳米传讯与辛迪加都对此颇感兴趣。"

	/// What deathrattle group type do we create? Group types dictate area whitelisting/blacklisting.
	var/deathrattle_group_type = /datum/deathrattle_group/standard

	/// Associated deathrattle group, for future configuration.
	var/datum/deathrattle_group/current_group

/obj/item/implant/deathrattle/can_be_implanted_in(mob/living/target)
	if(!current_group)
		balloon_alert(target, "亡语植入体尚未配置！")
		return FALSE
	// Can be implanted in anything that's a mob. Syndicate cyborgs, talking fish, humans...
	return TRUE

/obj/item/implant/deathrattle/lavaland
	name = "远征亡语植入体"

	deathrattle_group_type = /datum/deathrattle_group/lavaland

	implant_info = "仅对站外死亡触发。\
		植入前需要进行配置。植入后自动激活。\
		当与同一亡语组相连的其他亡语植入体宿主死亡时，会通知本宿主。"

/obj/item/implantcase/deathrattle
	name = "植入体盒 - “亡语”"
	desc = "一个装有亡语植入体的玻璃盒。"
	imp_type = /obj/item/implant/deathrattle

/obj/item/implantcase/deathrattle/lavaland
	name = "植入体盒 - “远征亡语”"
	desc = "一个装有远征亡语植入体的玻璃盒。只会在熔岩地带发生死亡时发出警报。"
	imp_type = /obj/item/implant/deathrattle/lavaland

#undef DEATHRATTLE_AREA_NOLIST
#undef DEATHRATTLE_AREA_BLACKLIST
#undef DEATHRATTLE_AREA_WHITELIST
