/obj/item/virgin_mary
	name = "\proper 圣母玛利亚画像"
	desc = "一幅廉价的小圣像，描绘着圣母。"
	icon = 'icons/obj/devices/blackmarket.dmi'
	icon_state = "madonna"
	resistance_flags = FLAMMABLE
	///Has this item been used already.
	var/used_up = FALSE

/obj/item/virgin_mary/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/burn_on_item_ignition, bypass_clumsy = TRUE)
	RegisterSignal(src, COMSIG_ATOM_IGNITED_BY_ITEM, PROC_REF(induct_new_initiate))

#define NICKNAME_CAP (MAX_NAME_LEN/2)

/obj/item/virgin_mary/proc/induct_new_initiate(datum/source, mob/living/user, obj/item/burning_tool)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(induct_new_initiate_async), user, burning_tool)

/obj/item/virgin_mary/proc/induct_new_initiate_async(mob/living/user, obj/item/burning_tool)
	if(isnull(user.mind))
		return
	if(HAS_TRAIT(user, TRAIT_MAFIAINITIATE)) //Only one nickname fuckhead
		to_chat(user, span_warning("你已经接受过黑手党入会仪式了。"))
		return
	if(used_up)
		return

	ADD_TRAIT(user, TRAIT_MAFIAINITIATE, TRAIT_GENERIC) // Adding the trait early because you could burn multiple at once for a very long name
	to_chat(user, span_notice("当你焚烧这幅画像时，一个绰号浮现在脑海中……"))
	var/nickname = tgui_input_text(user, "选一个绰号", "黑手党绰号", max_length = NICKNAME_CAP)
	nickname = reject_bad_name(nickname, allow_numbers = FALSE, max_length = NICKNAME_CAP, ascii_only = TRUE)
	if(!nickname)
		REMOVE_TRAIT(user, TRAIT_MAFIAINITIATE, TRAIT_GENERIC)
		return
	var/new_name
	var/space_position = findtext(user.real_name, " ")
	if(space_position)//Can we find a space?
		new_name = "[copytext(user.real_name, 1, space_position)] \"[nickname]\" [copytext(user.real_name, space_position)]"
	else //Append otherwise
		new_name = "[user.real_name] \"[nickname]\""
	user.real_name = new_name
	used_up = TRUE
	user.say("若我背叛家族，我的灵魂将如这位圣徒一般焚尽。我活着进来，必将死了出去。", forced = /obj/item/virgin_mary)
	to_chat(user, span_userdanger("被引入黑手党并不会赋予反派身份。"))

#undef NICKNAME_CAP

/obj/item/virgin_mary/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始以骇人的速度念诵《圣母经》！看起来是想进入来世！"))
	user.say("万福玛利亚，满圣宠者，主与尔偕焉。女中尔为赞美，尔胎子耶稣并为赞美。天主圣母玛利亚，为我等罪人，今祈天主，及我等死候。阿们。", forced = /obj/item/virgin_mary)
	addtimer(CALLBACK(src, PROC_REF(manual_suicide), user), 7.5 SECONDS)
	addtimer(CALLBACK(user, TYPE_PROC_REF(/atom/movable, say), "哦，我的母亲，请护佑我今日不犯大罪……"), 5 SECONDS)
	return MANUAL_SUICIDE

/obj/item/virgin_mary/proc/manual_suicide(mob/living/user)
	user.adjust_oxy_loss(200)
	user.death(FALSE)
