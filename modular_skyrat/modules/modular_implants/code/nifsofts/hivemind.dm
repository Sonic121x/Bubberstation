///A list containing users of the Hivemind NIFSoft
GLOBAL_LIST_EMPTY(hivemind_users)

/obj/item/disk/nifsoft_uploader/hivemind
	name = "蜂巢意识"
	loaded_nifsoft = /datum/nifsoft/hivemind

/datum/nifsoft/hivemind
	name = "蜂巢意识"
	program_desc = "蜂巢意识是一套程序，旨在更可靠地模拟某些史莱姆之间共享的神秘交流方式。它基于 NIF 的一种特定配置构建，能够生成局部化的亚空间网络；传递的内容正是使用者本人的思维，作为 NIF 使用者之间高科技的心灵感应交流手段。"
	activation_cost = 10
	active_mode = TRUE
	active_cost = 0.2
	purchase_price = 350
	buying_category = NIFSOFT_CATEGORY_UTILITY
	ui_icon = "users"

	///The network that the user is currently hosting
	var/datum/component/mind_linker/active_linking/nif/user_network
	///What networks are the user connected to?
	var/list/network_list = list()
	///What network is the user sending messages to? This is saved from the keyboard so the user doesn't have to change the channel every time.
	var/datum/component/mind_linker/active_linking/nif/active_network
	///The physical keyboard item being used to send messages
	var/obj/item/hivemind_keyboard/linked_keyboard
	///What action is being used to summon the Keyboard?
	var/datum/action/innate/hivemind_keyboard/keyboard_action

/datum/nifsoft/hivemind/New()
	. = ..()

	user_network = linked_mob.AddComponent(/datum/component/mind_linker/active_linking/nif, \
		network_name = "蜂巢意识链接", \
		linker_action_path = /datum/action/innate/hivemind_config, \
	)

	keyboard_action = new(linked_mob)
	keyboard_action.Grant(linked_mob)

	active_network = user_network
	network_list += user_network
	GLOB.hivemind_users += linked_mob

/datum/nifsoft/hivemind/Destroy()
	if(linked_mob in GLOB.hivemind_users)
		GLOB.hivemind_users -= linked_mob

	if(keyboard_action)
		keyboard_action.Remove()
		QDEL_NULL(keyboard_action)

	if(linked_keyboard)
		qdel(linked_keyboard)

	linked_keyboard = null

	for(var/datum/component/mind_linker/active_linking/nif/hivemind as anything in network_list)
		hivemind.linked_mobs -= linked_mob
		var/mob/living/hivemind_owner = hivemind.parent

		to_chat(hivemind_owner, span_abductor("[linked_mob] 已离开你的蜂巢意识。"))
		to_chat(linked_mob, span_abductor("你已离开 [hivemind_owner] 的蜂巢意识。"))

	qdel(user_network)
	return ..()

/datum/nifsoft/hivemind/activate()
	. = ..()
	if(!active)
		if(linked_keyboard)
			qdel(linked_keyboard)
			linked_keyboard = null

		return TRUE

	linked_keyboard = new
	linked_keyboard.connected_network = active_network
	linked_mob.put_in_hands(linked_keyboard)
	linked_keyboard.source_user = linked_mob

	linked_mob.visible_message(span_notice("[linked_keyboard] 在 [linked_mob] 手中成形。"), span_notice("[linked_keyboard] 出现在你手中。"))
	return TRUE

/datum/action/innate/hivemind_config
	name = "蜂巢意识配置设置"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "phone_settings"

/datum/action/innate/hivemind_config/Activate()
	. = ..()
	var/datum/component/mind_linker/active_linking/nif/link = target

	var/choice = tgui_input_list(owner, "选择你的操作", "蜂巢意识配置菜单", list("链接用户","移除用户","更改蜂巢意识颜色","切换活动蜂巢意识","离开蜂巢意识", "切换邀请"))
	if(!choice)
		return

	switch(choice)
		if("链接用户")
			link.invite_user()

		if("移除用户")
			link.remove_user()

		if("离开蜂巢意识")
			leave_hivemind()

		if("切换活动蜂巢意识")
			change_hivemind()

		if("更改蜂巢意识颜色")
			link.change_chat_color()

		if("切换邀请")
			toggle_invites()

/datum/action/innate/hivemind_config/proc/change_hivemind()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind = user.find_nifsoft(/datum/nifsoft/hivemind)

	var/datum/component/mind_linker/active_linking/nif/new_active_hivemind = tgui_input_list(user, "选择要设为活动的蜂巢意识。", "切换蜂巢意识", hivemind.network_list)
	if(!new_active_hivemind)
		return FALSE

	hivemind.active_network = new_active_hivemind
	to_chat(user, span_abductor("你现在正向 [new_active_hivemind.name] 发送消息。"))

	if(hivemind.active)
		hivemind.activate()
		hivemind.activate()

/datum/action/innate/hivemind_config/proc/leave_hivemind()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind = user.find_nifsoft(/datum/nifsoft/hivemind)

	var/list/network_list = hivemind.network_list
	network_list -= hivemind.user_network

	var/datum/component/mind_linker/active_linking/nif/hivemind_to_leave = tgui_input_list(user, "选择要断开的蜂巢意识。", "移除蜂巢意识", network_list)
	if(!hivemind_to_leave)
		return FALSE

	to_chat(hivemind_to_leave.parent, span_abductor("[user] 已被移出你的蜂巢意识。"))
	to_chat(user, span_abductor("你已离开 [hivemind_to_leave.parent] 的蜂巢意识。"))

	hivemind.network_list -= hivemind_to_leave
	hivemind_to_leave.linked_mobs -= user


/datum/action/innate/hivemind_config/proc/toggle_invites()
	var/mob/living/carbon/human/user = owner
	if(user in GLOB.hivemind_users)
		GLOB.hivemind_users -= user
		to_chat(user, span_abductor("你现在无法接收邀请。"))
		return

	GLOB.hivemind_users += user
	to_chat(user, span_abductor("你现在可以接收邀请。"))

/datum/action/innate/hivemind_keyboard
	name = "蜂巢意识键盘"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "phone"

/datum/action/innate/hivemind_keyboard/Activate()
	. = ..()
	var/mob/living/carbon/human/user = owner
	var/datum/nifsoft/hivemind/hivemind_nifsoft = user.find_nifsoft(/datum/nifsoft/hivemind)

	if(!hivemind_nifsoft)
		return FALSE

	hivemind_nifsoft.activate()

/datum/component/mind_linker
	///Is does the component give an action to speak? By default, yes
	var/speech_action = TRUE
	///Does the component check to see if the person being linked has a mindshield or anti-magic?
	var/linking_protection = TRUE

/datum/component/mind_linker/active_linking/nif
	speech_action = FALSE
	linking_protection = FALSE

	///What is the name of the hivemind? This is mostly here for the TGUI selection menus.
	var/name = ""

/datum/component/mind_linker/active_linking/nif/New()
	. = ..()

	var/mob/living/owner = parent
	name = owner.name + " 的" + network_name

///Lets the user add someone to their Hivemind through a choice menu that shows everyone that has the Hivemind NIFSoft.
/datum/component/mind_linker/active_linking/nif/proc/invite_user()
	var/list/hivemind_users = GLOB.hivemind_users.Copy()
	var/mob/living/carbon/human/owner = parent

	//This way people already linked don't show up in the selection menu
	for(var/mob/living/user as anything in linked_mobs)
		if(user in hivemind_users)
			hivemind_users -= user

	hivemind_users -= owner

	var/mob/living/carbon/human/person_to_add = tgui_input_list(owner, "选择要邀请加入你的蜂巢意识的人。", "邀请用户", hivemind_users)
	if(!person_to_add)
		return

	if(tgui_alert(person_to_add, "[owner] 想将你加入其蜂巢意识，你接受吗？", "收到蜂巢意识邀请", list("接受", "拒绝")) != "接受")
		to_chat(owner, span_warning("[person_to_add] 拒绝了加入你的蜂巢意识的请求。"))
		return

	linked_mobs += person_to_add

	var/datum/nifsoft/hivemind/target_hivemind = person_to_add.find_nifsoft(/datum/nifsoft/hivemind)

	if(!target_hivemind)
		return FALSE

	target_hivemind.network_list += src
	to_chat(person_to_add, span_abductor("你已被加入 [owner] 的蜂巢意识"))
	to_chat(owner, span_abductor("[person_to_add] 已被加入你的蜂巢意识"))

///Removes a user from the list of connected people within a hivemind
/datum/component/mind_linker/active_linking/nif/proc/remove_user()
	var/mob/living/carbon/human/owner = parent
	var/mob/living/carbon/human/person_to_remove = tgui_input_list(owner, "选择要从你的蜂巢意识中移除的人。", "移除用户", linked_mobs)

	if(!person_to_remove)
		return

	var/datum/nifsoft/hivemind/target_hivemind
	target_hivemind = person_to_remove.find_nifsoft(/datum/nifsoft/hivemind)

	if(!target_hivemind)
		return FALSE

	linked_mobs -= person_to_remove
	target_hivemind.network_list -= src
	to_chat(person_to_remove, span_abductor("你已被移出 [owner] 的蜂巢意识。"))
	to_chat(owner, span_abductor("[person_to_remove] 已被移出你的蜂巢意识。"))

/datum/component/mind_linker/active_linking/nif/proc/change_chat_color()
	var/mob/living/carbon/human/owner = parent
	var/new_chat_color = tgui_color_picker(owner, "选择新颜色", COLOR_ASSEMBLY_GREEN) // BUBBERSTATION EDIT: TGUI COLOR PICKER

	if(!new_chat_color)
		return FALSE

	chat_color = new_chat_color

/obj/item/hivemind_keyboard
	name = "蜂巢意识接口装置"
	desc = "一种全息手势控制器，可绑定使用者自选的手部与手指动作。它与蜂巢意识程序本身配对使用，用于过滤掉不想要的想法，确保只有刻意发送的交流思绪才能进入网络。"
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "designator_mining"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"
	///What Hivemind are messages being sent to?
	var/datum/component/mind_linker/active_linking/nif/connected_network
	//Who owns the controller?
	var/datum/weakref/source_user

/obj/item/hivemind_keyboard/Destroy(force)
	. = ..()
	connected_network = null

/obj/item/hivemind_keyboard/attack_self(mob/user, modifiers)
	. = ..()
	send_message(user)

/obj/item/hivemind_keyboard/proc/send_message(mob/living/carbon/human/user)
	var/mob/living/carbon/human/kebyoard_owner = source_user
	var/mob/living/carbon/human/network_owner = connected_network.parent
	var/message = tgui_input_text(user, "输入要发送的消息。", "[connected_network.network_name] 心灵感应")
	if(!message || QDELETED(src) || QDELETED(user) || user.stat == DEAD)
		return

	if(QDELETED(connected_network))
		to_chat(user, span_warning("链接似乎已被切断。"))
		return

	var/datum/asset/spritesheet_batched/sheet = get_asset_datum(/datum/asset/spritesheet_batched/chat)
	var/tag = sheet.icon_tag("nif-phone")
	var/hivemind_icon = ""

	if(tag)
		hivemind_icon = tag

	var/formatted_message = "<i><font color=[connected_network.chat_color]>\ [hivemind_icon][network_owner.real_name] 的[connected_network.network_name]\] <b>[kebyoard_owner]：</b> [message]</font></i>"
	log_directed_talk(user, network_owner, message, LOG_SAY, "心灵链接（[connected_network.network_name]）")

	var/list/all_who_can_hear = assoc_to_keys(connected_network.linked_mobs) + network_owner

	for(var/mob/living/recipient as anything in all_who_can_hear)
		to_chat(recipient, formatted_message)

	for(var/mob/recipient as anything in GLOB.dead_mob_list)
		to_chat(recipient, "[FOLLOW_LINK(recipient, user)] [formatted_message]")

