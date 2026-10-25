/obj/item/station_charter
	name = "空间站特许状"
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "charter"
	desc = "一份将空间站\
		及周边空间的管辖权授予舰长的正式文件。"
	var/used = FALSE
	var/name_type = "station"

	var/unlimited_uses = FALSE
	var/ignores_timeout = FALSE
	var/response_timer_id = null
	var/approval_time = 600

	var/static/regex/standard_station_regex

/obj/item/station_charter/Initialize(mapload)
	. = ..()
	if(!standard_station_regex)
		var/prefixes = jointext(GLOB.station_prefixes, "|")
		var/names = jointext(GLOB.station_names, "|")
		var/suffixes = jointext(GLOB.station_suffixes, "|")
		var/numerals = jointext(GLOB.station_numerals, "|")
		var/regexstr = "^(([prefixes]) )?(([names]) ?)([suffixes]) ([numerals])$"
		standard_station_regex = new(regexstr)

/obj/item/station_charter/attack_self(mob/living/user)
	if(used)
		to_chat(user, span_warning("这[name_type == "planet" ? "颗星球" : "座空间站"]已经命名了！"))
		return
	if(!ignores_timeout && (world.time-SSticker.round_start_time > STATION_RENAME_TIME_LIMIT)) //5 minutes
		to_chat(user, span_warning("船员们已经开始正常工作，现在给[name_type == "planet" ? "星球" : "空间站"]改名恐怕不太合适。"))
		return
	if(response_timer_id)
		to_chat(user, span_warning("雇主尚未批准你的改名提议，最好再等一等。"))
		return

	var/new_name = tgui_input_text(user, "你想把\
		[station_name()]改成什么名字？请记住，特别糟糕的名字可能会\
		遭到雇主拒绝，而符合标准格式的名字\
		会被自动接受。", "空间站名称", max_length = MAX_CHARTER_LEN)

	if(response_timer_id)
		to_chat(user, span_warning("雇主尚未批准你的改名提议，最好再等一等。"))
		return

	if(!new_name)
		return
	user.log_message("has proposed to name the station as \
		[new_name]", LOG_GAME)

	if(standard_station_regex.Find(new_name))
		to_chat(user, span_notice("你提交的名称已自动获批。"))
		rename_station(new_name, user.name, user.real_name, key_name(user))
		return

	to_chat(user, span_notice("你提交的名称已发送给雇主审批。"))
	// Autoapproves after a certain time
	response_timer_id = addtimer(CALLBACK(src, PROC_REF(rename_station), new_name, user.name, user.real_name, key_name(user)), approval_time, TIMER_STOPPABLE)
	to_chat(GLOB.admins,
		span_adminnotice("<b><font color=orange>自定义空间站名称：</font></b>[ADMIN_LOOKUPFLW(user)]提议将[name_type == "planet" ? "星球" : "空间站"]更名为[new_name]（将在[DisplayTimeText(approval_time)]后自动批准）。[ADMIN_SMITE(user)] (<A href='byond://?_src_=holder;[HrefToken(forceGlobal = TRUE)];reject_custom_name=[REF(src)]'>拒绝</A>) [ADMIN_CENTCOM_REPLY(user)]"),
		type = MESSAGE_TYPE_PRAYER)
	for(var/client/admin_client in GLOB.admins)
		if(admin_client.prefs.toggles & SOUND_ADMINHELP)
			window_flash(admin_client, ignorepref = TRUE)
			SEND_SOUND(admin_client, sound('sound/effects/gong.ogg'))

/obj/item/station_charter/proc/reject_proposed(user)
	if(!user)
		return
	if(!response_timer_id)
		return
	var/turf/T = get_turf(src)
	T.visible_message(span_warning("提议的修改从\
		[src]上消失了，看起来它们遭到了拒绝。"))
	var/m = "[key_name(user)]拒绝了提议的空间站名称。"

	message_admins(m)
	log_admin(m)

	deltimer(response_timer_id)
	response_timer_id = null

/obj/item/station_charter/proc/rename_station(designation, uname, ureal_name, ukey)
	set_station_name(designation)
	minor_announce("[ureal_name]已将你所在的空间站命名为[html_decode(station_name())]", "舰长特许状") //decode station_name to avoid minor_announce double encode
	log_game("[ukey] has renamed the station as [station_name()].")

	name = "[station_name()]空间站特许状"
	desc = "一份将\
		[station_name()]及周边空间的管辖权授予[uname]舰长的正式文件。"
	SSblackbox.record_feedback("text", "station_renames", 1, "[station_name()]")
	if(!unlimited_uses)
		used = TRUE

/obj/item/station_charter/admin
	unlimited_uses = TRUE
	ignores_timeout = TRUE


/obj/item/station_charter/banner
	name = "\improper 纳米传讯旗帜"
	icon = 'icons/obj/banner.dmi'
	name_type = "planet"
	icon_state = "banner"
	inhand_icon_state = "banner"
	lefthand_file = 'icons/mob/inhands/equipment/banners_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/banners_righthand.dmi'
	desc = "用于宣示天体所有权的巧妙装置。"
	w_class = WEIGHT_CLASS_HUGE
	force = 15

/obj/item/station_charter/banner/rename_station(designation, uname, ureal_name, ukey)
	set_station_name(designation)
	minor_announce("[ureal_name]已将[name_type == "planet" ? "星球" : "空间站"]命名为[html_decode(station_name())]", "舰长旗帜") //decode station_name to avoid minor_announce double encode
	log_game("[ukey] has renamed the [name_type] as [station_name()].")
	name = "[station_name()]旗帜"
	desc = "旗帜上绘有纳米传讯的官方徽章，表示[uname]舰长已代表公司宣示对[station_name()]的所有权。"
	SSblackbox.record_feedback("text", "station_renames", 1, "[station_name()]")
	if(!unlimited_uses)
		used = TRUE
