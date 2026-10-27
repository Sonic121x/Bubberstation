//guard bowman headsets, issued to department guards instead of a plain dept headset
//can send one-way reports on the security channel through the announcement network, but carry no security key so they never hear it back

/datum/aas_config_entry/guard_report
	name = "安保：部门警卫报告"
	announcement_lines_map = list(
		"Message" = "来自 %PERSON（%DEPARTMENT）的报告，内容如下：%MESSAGE")
	vars_and_tooltips_map = list(
		"MESSAGE" = "警卫的报告。",
		"PERSON" = "将被替换为报告警卫的姓名。",
		"DEPARTMENT" = "警卫所属部门。",
	)

/datum/aas_config_entry/guard_report/act_up()
	. = ..()
	if(.)
		return
	announcement_lines_map["Message"] = pick(
		"来#自 \[空\] 的报*告：文%@本 已#检 测",
		"收到报告……收到报告……收到报-",
		"AAS.exe 遇到警卫报告，必须关闭。")

/obj/item/radio/headset/guard_bowman
	name = "警卫弓形耳机"
	desc = "配发给各部门警卫的弓形耳机。它的设计目的是向安保部转达报告，不过你短期内别指望收到回复。"
	icon = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	icon_state = "guard_bowman"
	worn_icon_state = "guard_bowman"
	post_init_icon_state = "guard_bowman"
	greyscale_config = /datum/greyscale_config/guard_bowman
	greyscale_config_worn = /datum/greyscale_config/guard_bowman/worn
	greyscale_colors = COLOR_WHITE + COLOR_GRAY
	flags_1 = IS_PLAYER_COLORABLE_1
	//time between reports, tunable
	var/report_cooldown_time = 1 MINUTES
	//click played only on a successful sec report, kept separate from radiosound so normal dept chatter is unaffected
	var/report_sound = 'modular_skyrat/modules/kahraman_equipment/sound/morse_signal.wav'
	COOLDOWN_DECLARE(report_cooldown)

/obj/item/radio/headset/guard_bowman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection)
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/radio/headset/guard_bowman/talk_into(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	if(channel != RADIO_CHANNEL_SECURITY)
		return ..()
	if(RADIO_CHANNEL_SECURITY in channels)
		//for if you get a real key
		return ..()

	if(!COOLDOWN_FINISHED(src, report_cooldown))
		balloon_alert_to_viewers("仍在充能")
		return

	var/spoken_language = language || talking_movable.get_selected_language()
	if(spoken_language && !ispath(spoken_language, /datum/language/common) && !(obj_flags & EMAGGED))
		send_report(talking_movable, "\[无法辨识\]")
		return

	send_report(talking_movable, message)

/obj/item/radio/headset/guard_bowman/proc/send_report(atom/movable/talking_movable, message)
	var/reporter = talking_movable.name
	var/department_name = get_reporting_department()
	var/body = message
	if(obj_flags & EMAGGED)
		reporter = scrambled_reporter()
		department_name = scrambled_department()
		body = scrambled_message()

	var/obj/machinery/announcement_system/announcer = get_announcement_system(/datum/aas_config_entry/guard_report, src, list(RADIO_CHANNEL_SECURITY))
	if(!announcer)
		balloon_alert_to_viewers("无响应")
		return

	announcer.announce(/datum/aas_config_entry/guard_report, list(
		"PERSON" = reporter,
		"DEPARTMENT" = department_name,
		"MESSAGE" = body,
	), list(RADIO_CHANNEL_SECURITY))
	COOLDOWN_START(src, report_cooldown, report_cooldown_time)
	if(report_sound)
		playsound(talking_movable, report_sound, radio_sound_volume, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT)
	var/security_span = get_radio_span(GLOB.default_radio_channels[RADIO_CHANNEL_SECURITY])
	to_chat(talking_movable, "<span class='[security_span]'><span class='name'>\[安保\] 自动播报系统</span>冷冷地说道，<span class='message robot'>“您的消息已收到。”</span></span>")

//lets the bogus report through even with a real key installed
/obj/item/radio/headset/guard_bowman/click_alt(mob/user)
	if(!(obj_flags & EMAGGED))
		return NONE
	if(!COOLDOWN_FINISHED(src, report_cooldown))
		balloon_alert_to_viewers("仍在充能")
		return CLICK_ACTION_BLOCKING
	send_report(user, "")
	return CLICK_ACTION_SUCCESS

/obj/item/radio/headset/guard_bowman/examine(mob/user)
	. = ..()
	if(!(item_flags & IN_INVENTORY) || loc != user)
		return
	if(obj_flags & EMAGGED)
		. += span_info("<b>Alt 点击</b>发送一份“完全合法”的报告。")
	if(RADIO_CHANNEL_SECURITY in channels)
		return
	var/security_span = get_radio_span(GLOB.default_radio_channels[RADIO_CHANNEL_SECURITY])
	. += span_notice("<ul style='display:inline-block; margin: 0; list-style: square;'><li><b>[span_class(security_span, RADIO_TOKEN_SECURITY)]</b> 在安保频道报告事件</li></ul>")
	if(!get_announcement_system(/datum/aas_config_entry/guard_report, src, list(RADIO_CHANNEL_SECURITY)))
		. += span_warning("其状态显示屏显示：错误")
	else if(!COOLDOWN_FINISHED(src, report_cooldown))
		. += span_notice("其状态显示屏显示：可在 [DisplayTimeText(COOLDOWN_TIMELEFT(src, report_cooldown))] 后再发送一条消息！")
	else
		. += span_notice("其状态显示屏显示：现在即可发送消息。")

/obj/item/radio/headset/guard_bowman/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(obj_flags & EMAGGED)
		return .
	balloon_alert(user, "报告过滤器已禁用")
	playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	obj_flags |= EMAGGED
	return TRUE

//overridden per subtype
/obj/item/radio/headset/guard_bowman/proc/get_reporting_department()
	return "未知部门"

//biased toward the clown, but can pick any real crew member
/obj/item/radio/headset/guard_bowman/proc/scrambled_reporter()
	if(prob(50))
		var/manifest_pick = pick_manifest_reporter()
		if(manifest_pick)
			return manifest_pick
	return pick(
		"小丑宾格斯",
		"\[已删节\]",
		"售货机",
		"毕普斯基警官",
		"没有人",
		"一个奇怪的声音",
		"空间站 AI",
		"匿名消息源",
		"还留在站上的人",
		"一个非常困惑的默剧演员",
		"又是那个小丑",
		"身份不明者",
		"通风口附近的影子",
		"上一个问这个的人",
		"某人的鬼魂",
		"一条匿名线报",
		"实习生",
		"一只可疑的浣熊",
		"不特指某个人",
		"最后一个碰过这副耳机的人",
		"未知",
		"一盆盆栽",
		"静电杂音",
		"一个戴面具的人影",
		"那只仓鼠",
		"一个非常疲惫的鬼魂",
		"当班的人",
		"一个没有标签的箱子",
		"一道掠过的影子",
		"通风口里的那个人",
		"某人",
	)

/obj/item/radio/headset/guard_bowman/proc/pick_manifest_reporter()
	if(!length(GLOB.manifest.general))
		return null
	var/list/clowns = list()
	for(var/datum/record/crew/target as anything in GLOB.manifest.general)
		if(target.rank == "Clown")
			clowns += target
	var/datum/record/crew/picked
	if(length(clowns))
		picked = prob(40) ? pick(clowns) : pick(GLOB.manifest.general)
		return picked.name
	if(prob(10))
		return pick("小丑宾格斯", "又是那个小丑")
	picked = pick(GLOB.manifest.general)
	return picked.name

/obj/item/radio/headset/guard_bowman/proc/scrambled_department()
	return pick(
		"维护部",
		"\[无数据\]",
		"深空",
		"中央指挥部餐饮部",
		"休息室",
		"礼拜堂地下室",
		"抵达站",
		"未公开地点",
		"哪个都不是的地方",
		"通风口",
		"一个储物柜",
		"天花板",
		"那股气味传来的地方",
		"一个不存在的部门",
		"某个寒冷的地方",
		"酒吧",
		"你身后",
	)

/obj/item/radio/headset/guard_bowman/proc/scrambled_message()
	var/list/lines = list(
		"救命 AI 正在吸收我 维护部",
		"墙壁又在说话了",
		"再送些甜甜圈来，情况危急",
		"我能看穿时间",
		"有一只椅子那么大的蜘蛛",
		"舰长是三个小丑套在一件西装里",
		"一切都好 一切都好 一切都",
		"谁批准了第二个太阳",
		"售货机知道我的名字",
		"我的徽章不再是我的徽章了",
		"我数过灯了，数量太多了",
		"替我向我部门问好",
		"蛾族人成立工会了",
		"我想我已经报告过这件事了",
		"还有第二个空间站，它比看上去更近",
		"我的倒影迟到了",
		"咖啡机有意识了，它正在评判我",
		"总有人在吃掉证据",
		"我不记得请求过支援，但支援来了",
		"这份报告是小丑提交的，不是我",
		"请求立即支援",
		"入侵者警报，重复，入侵者警报",
		"船体正在破裂",
		"有人开枪，警员倒下",
		"忽略我上一份报告",
		"也忽略我下一份报告",
		"我的徽章一直在响",
		"船员名册上多了一个名字",
		"我宣过誓，我打算遵守",
		"没有情况要报告，只是确认这玩意能用",
		"天花板比昨天更近了",
		"有人复印了我的徽章",
		"我在这频率上听到过一次数字电台",
		"灯光拼出一个词，然后就停了",
		"救命 维护部",
	)
	var/list/place_lines = list(
		"派支援到 %PLACE",
		"所有单位前往 %PLACE",
		"%PLACE 有东西在移动",
		"在 %PLACE 发现了小丑",
		"%PLACE 传来巨响",
		"我被困在 %PLACE",
		"%PLACE 报告有可疑活动",
		"%PLACE 有人在哭泣",
		"%PLACE 有人开枪",
		"不要去 %PLACE",
		"%PLACE 附近报告结构破损",
		"%PLACE 报告未经授权的闯入",
		"%PLACE 可能发生人质事件",
		"%PLACE 附近报告火情",
		"%PLACE 传来尖叫声",
	)
	var/list/incident_lines = list(
		"%WHO 从货运部偷东西",
		"%PLACE 报告有炸弹",
		"%WHO 正在威胁船员",
		"%WHO 袭击了一名警员",
		"%WHO 闯入了 %PLACE",
		"%WHO 正在拒捕",
		"在 %WHO 身上发现违禁品",
		"%WHO 正试图从 %PLACE 逃跑",
		"%WHO 正在 %PLACE 闹事",
		"%WHO 持有武器",
		"请求支援，%WHO 不配合",
		"%WHO 被看到匆忙离开 %PLACE",
		"%WHO 试图贿赂我",
		"%WHO 冒充警员",
		"%WHO 不停谈论 %PLACE",
	)
	var/list/culprits = list(
		"小丑",
		"一个没有标记的箱子",
		"一个漂浮的头骨",
		"一个戴面具的人",
		"戴帽子的那个人",
		"一只浣熊",
		"新来的",
		"身份不明者",
		"售货机",
		"一个非常可疑的默剧演员",
		"一个下班的助手",
		"一个自称舰长的人",
	)
	var/list/places = list(
		"小丑的肛门",
		"舰长的肛门",
		"一个平行维度",
		"古拉格",
		"大气部",
		"地狱",
		"一个储物柜",
		"通风口",
		"我自己的头骨",
		"楼层之间的夹层",
		"一个不该存在的壁橱",
		"酒吧后面",
		"垃圾管道底部",
		"一条永远循环的维护隧道",
		"厨师的步入式冷冻库",
		"一个昨天还不存在的洞",
		"镜子的另一侧",
		"撤离穿梭机底部",
		"一个已经结束的班次",
		"工程部",
		"舰桥",
		"医疗部",
		"抵达站",
		"货运舱",
		"禁闭室",
		"礼拜堂",
		"科学部",
	)
	var/roll = rand(1, 100)
	if(roll <= 35)
		var/who = prob(10) ? (pick_manifest_reporter() || pick(culprits)) : pick(culprits)
		var/incident = replacetext(pick(incident_lines), "%WHO", who)
		incident = replacetext(incident, "%PLACE", pick(places))
		return uppertext(incident)
	if(roll <= 65)
		return uppertext(replacetext(pick(place_lines), "%PLACE", pick(places)))
	return uppertext(pick(lines))

/obj/item/radio/headset/guard_bowman/science
	greyscale_colors = COLOR_WHITE + COLOR_SCIENCE_PINK
	keyslot = /obj/item/encryptionkey/headset_sci

/obj/item/radio/headset/guard_bowman/science/get_reporting_department()
	return "科学部"

/obj/item/radio/headset/guard_bowman/medical
	greyscale_colors = COLOR_WHITE + COLOR_MEDICAL_BLUE
	keyslot = /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/guard_bowman/medical/get_reporting_department()
	return "医疗部"

/obj/item/radio/headset/guard_bowman/engineering
	greyscale_colors = COLOR_WHITE + COLOR_ENGINEERING_ORANGE
	keyslot = /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/guard_bowman/engineering/get_reporting_department()
	return "工程部"

/obj/item/radio/headset/guard_bowman/cargo
	greyscale_colors = COLOR_WHITE + COLOR_CARGO_BROWN
	keyslot = /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/guard_bowman/cargo/get_reporting_department()
	return "货运部"

/obj/item/radio/headset/guard_bowman/service
	greyscale_colors = COLOR_WHITE + COLOR_SERVICE_LIME
	keyslot = /obj/item/encryptionkey/headset_service

/obj/item/radio/headset/guard_bowman/service/get_reporting_department()
	return "服务部"

/datum/greyscale_config/guard_bowman
	name = "警卫弓形耳机"
	icon_file = 'modular_zubbers/icons/obj/devices/guard_bowman.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/guard_bowman.json'

/datum/greyscale_config/guard_bowman/worn
	name = "警卫弓形耳机（佩戴）"
	icon_file = 'modular_zubbers/icons/mob/clothing/guard_bowman_worn.dmi'
	json_config = 'modular_zubbers/code/datums/greyscale/json_configs/guard_bowman_worn.json'
