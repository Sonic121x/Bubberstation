
/**
 * ## faction granter component!
 *
 * component attached to items, lets them be used in hand once to add yourself to a certain faction
 * one good example is the chaplain plushie that grants you the carp faction, making you friendly with them.
 */
/datum/component/faction_granter
	dupe_mode = COMPONENT_DUPE_ALLOWED
	///whichever faction the parent adds upon using in hand
	var/faction_to_grant
	///whether you need to be holy to get the faction.
	var/holy_role_required
	///message given when granting the faction.
	var/grant_message
	///boolean on whether it has been used
	var/used = FALSE

/datum/component/faction_granter/Initialize(faction_to_grant, holy_role_required = NONE, grant_message)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	if(!grant_message) //Yes we could do this in the init call with default args, but it scares people
		grant_message = "你已与[chinese_faction_display(faction_to_grant)]成为朋友"
	src.faction_to_grant = faction_to_grant
	src.holy_role_required = holy_role_required
	src.grant_message = grant_message

/datum/component/faction_granter/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_self_attack))
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/faction_granter/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_ATTACK_SELF, COMSIG_ATOM_EXAMINE))

///signal called on parent being examined
/datum/component/faction_granter/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(used)
		examine_list += span_notice("[parent]赋予好感的力量已经耗尽。")
	else
		examine_list += span_notice("手持使用[parent]可获得[chinese_faction_display(faction_to_grant)]的好感")

///signal called on parent being interacted with in hand
/datum/component/faction_granter/proc/on_self_attack(atom/source, mob/user)
	SIGNAL_HANDLER
	if(used)
		to_chat(user, span_warning("[parent]的力量已经耗尽！"))
		return
	if(user.mind?.holy_role < holy_role_required)
		to_chat(user, span_warning("你还不够神圣，无法唤起[parent]的力量！"))
		return

	to_chat(user, grant_message)
	user.add_faction(faction_to_grant)
	used = TRUE
