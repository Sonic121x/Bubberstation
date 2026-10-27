/datum/buildmode_mode/offercontrol
	key = "offercontrol"
	button_icon = 'modular_skyrat/master_files/icons/misc/buildmode.dmi' // if you are making a modular build mode, use this icon path.

/datum/buildmode_mode/offercontrol/show_help(client/target_client)
	to_chat(target_client, span_notice("***********************************************************\n\
		左键点击生物或活体 = 向幽灵开放控制权。\n\
		***********************************************************"))

/datum/buildmode_mode/offercontrol/handle_click(client/target_client, params, object)
	if(!ismob(object))
		return

	var/mob/living/mob_to_offer = object

	if(mob_to_offer.key)
		var/response = tgui_alert(target_client, "该生物已有玩家（ckey）接入，是否继续？", "该生物已被占据！", list("继续", "取消"))
		if(response != "继续")
			return

	offer_control(mob_to_offer)
