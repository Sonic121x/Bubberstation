/mob/eye/camera/remote/holo/setLoc(turf/destination, force_update = FALSE)
	// If we're moving outside the space of our projector, then just... don't
	var/obj/machinery/holopad/H = origin_ref?.resolve()
	if(!H?.move_hologram(user_ref?.resolve(), destination))
		sprint = initial(sprint) // Reset sprint so it doesn't balloon in our calling proc
		return
	return ..()

/obj/machinery/holopad/remove_eye_control(mob/living/user)
	var/mob/eye/camera/remote/eye = user.remote_control
	if(!istype(eye))
		CRASH("Attempted to remove eye control from non-camera eye. Something has gone horribly wrong.")
	eye.assign_user(null)

//this datum manages its own references

/datum/holocall
	///the one that called
	var/mob/living/user
	///the holopad that sent the call to another holopad
	var/obj/machinery/holopad/calling_holopad
	///the one that answered the call (may be null)
	var/obj/machinery/holopad/connected_holopad
	///populated with all holopads that are either being dialed or have that have answered us, will be cleared out to just connected_holopad once answered
	var/list/dialed_holopads

	///user's eye, once connected
	var/mob/eye/camera/remote/holo/eye
	///user's hologram, once connected
	var/obj/effect/overlay/holo_pad_hologram/hologram
	///hangup action
	var/datum/action/innate/end_holocall/hangup

	var/call_start_time
	///calls from a head of staff autoconnect, if the receiving pad is not secure.
	var/head_call = FALSE

//creates a holocall made by `call_source` from `calling_pad` to `callees`
/datum/holocall/New(mob/living/call_source, obj/machinery/holopad/calling_pad, list/callees, elevated_access = FALSE)
	call_start_time = world.time
	user = call_source
	calling_pad.outgoing_call = src
	calling_holopad = calling_pad
	head_call = elevated_access
	dialed_holopads = list()

	for(var/obj/machinery/holopad/connected_holopad as anything in callees)
		if(!QDELETED(connected_holopad) && connected_holopad.is_operational)
			dialed_holopads += connected_holopad
			if(head_call)
				if(connected_holopad.secure)
					calling_pad.say("自动连接遭拒，已切换至呼叫模式。")
					connected_holopad.say("收到呼叫。")
				else
					connected_holopad.say("收到连接请求。")
			else
				connected_holopad.say("收到呼叫。")
			connected_holopad.set_holocall(src)

	if(!dialed_holopads.len)
		calling_pad.say("连接失败。")
		qdel(src)
		return

	testing("Holocall started")

//cleans up ALL references :)
/datum/holocall/Destroy()
	QDEL_NULL(hangup)
	QDEL_NULL(eye)

	if(connected_holopad && !QDELETED(hologram))
		hologram = null
		connected_holopad.clear_holo(user)

	user = null

	//Hologram survived holopad destro
	if(!QDELETED(hologram))
		hologram.HC = null
		QDEL_NULL(hologram)
	hologram = null

	for(var/obj/machinery/holopad/dialed_holopad as anything in dialed_holopads)
		dialed_holopad.set_holocall(src, FALSE)

	dialed_holopads.Cut()

	if(calling_holopad)//if the call is answered, then calling_holopad wont be in dialed_holopads and thus wont have set_holocall(src, FALSE) called
		calling_holopad.callee_hung_up()
		calling_holopad = null
	if(connected_holopad)
		connected_holopad.SetLightsAndPower()
		connected_holopad = null

	testing("Holocall destroyed")

	return ..()

//Gracefully disconnects a holopad `H` from a call. Pads not in the call are ignored. Notifies participants of the disconnection
/datum/holocall/proc/Disconnect(obj/machinery/holopad/H)
	testing("Holocall disconnect")
	if(H == connected_holopad)
		var/area/A = get_area(connected_holopad)
		calling_holopad.say("[A]的全息投影台已断开连接。")
	else if(H == calling_holopad && connected_holopad)
		connected_holopad.say("[user]已断开连接。")

	ConnectionFailure(H, TRUE)

//Forcefully disconnects disconnected_holopad from a call. Pads not in the call are ignored.
/datum/holocall/proc/ConnectionFailure(obj/machinery/holopad/disconnected_holopad, graceful = FALSE)
	testing("Holocall connection failure: graceful [graceful]")
	if(disconnected_holopad == connected_holopad || disconnected_holopad == calling_holopad)
		if(!graceful && disconnected_holopad != calling_holopad)
			calling_holopad.say("连接失败。")
		qdel(src)
		return

	disconnected_holopad.set_holocall(src, FALSE)

	dialed_holopads -= disconnected_holopad
	if(!dialed_holopads.len)
		if(graceful)
			calling_holopad.say("呼叫遭拒。")
		testing("No recipients, terminating")
		qdel(src)

///Answers a call made to answering_holopad which cannot be the calling holopad. Pads not in the call are ignored
/datum/holocall/proc/Answer(obj/machinery/holopad/answering_holopad)
	testing("Holocall answer")
	if(answering_holopad == calling_holopad)
		CRASH("How cute, a holopad tried to answer itself.")

	if(!(answering_holopad in dialed_holopads))
		return

	if(connected_holopad)
		CRASH("Multi-connection holocall")

	for(var/obj/machinery/holopad/other_dialed_holopad as anything in dialed_holopads)
		if(other_dialed_holopad == answering_holopad)
			continue
		Disconnect(other_dialed_holopad)

	for(var/datum/holocall/previously_answered_holocall as anything in answering_holopad.holo_calls)//disconnect the other holocalls answering_holopad is occupied with
		if(previously_answered_holocall != src)
			previously_answered_holocall.Disconnect(answering_holopad)

	connected_holopad = answering_holopad

	if(!Check())
		return

	calling_holopad.callee_picked_up()
	hologram = answering_holopad.activate_holo(user)
	hologram.HC = src

	eye = new(get_turf(answering_holopad), answering_holopad)
	eye.assign_user(user)

	hangup = new(eye, src)
	hangup.Grant(user)
	playsound(answering_holopad, 'sound/machines/ping.ogg', 100)
	answering_holopad.say("连接已建立。")

//Checks the validity of a holocall and qdels itself if it's not. Returns TRUE if valid, FALSE otherwise
/datum/holocall/proc/Check()
	for(var/obj/machinery/holopad/dialed_holopad as anything in dialed_holopads)
		if(!dialed_holopad.is_operational)
			ConnectionFailure(dialed_holopad)

	if(QDELETED(src))
		return FALSE

	. = !QDELETED(user) && !user.incapacitated && !QDELETED(calling_holopad) && calling_holopad.is_operational && user.loc == calling_holopad.loc

	if(.)
		if(!connected_holopad)
			. = world.time < (call_start_time + HOLOPAD_MAX_DIAL_TIME)
			if(!.)
				calling_holopad.say("无人接听。")

	if(!.)
		testing("Holocall Check fail")
		qdel(src)

/datum/action/innate/end_holocall
	name = "结束全息通话"
	button_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "camera_off"
	var/datum/holocall/hcall

/datum/action/innate/end_holocall/New(Target, datum/holocall/HC)
	..()
	hcall = HC

/datum/action/innate/end_holocall/Activate()
	hcall.Disconnect(hcall.calling_holopad)


//RECORDS
/datum/holorecord
	var/caller_name = "Unknown" //Caller name
	var/image/caller_image
	var/list/entries = list()
	var/language = /datum/language/common //Initial language, can be changed by HOLORECORD_LANGUAGE entries

/datum/holorecord/proc/set_caller_image(mob/user)
	var/olddir = user.dir
	user.setDir(SOUTH)
	caller_image = image(user)
	user.setDir(olddir)

/obj/item/disk/holodisk
	name = "全息录像盘"
	desc = "用于存储录制的全息通话。"
	sticker_icon_state = "o_holo"
	obj_flags = UNIQUE_RENAME
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	var/datum/holorecord/record
	//Preset variables
	var/preset_image_type
	var/preset_record_text

/obj/item/disk/holodisk/Initialize(mapload)
	. = ..()
	if(preset_record_text)
		INVOKE_ASYNC(src, PROC_REF(build_record))

/obj/item/disk/holodisk/Destroy()
	QDEL_NULL(record)
	return ..()

/obj/item/disk/holodisk/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/disk/holodisk))
		return NONE

	var/obj/item/disk/holodisk/holodisk_original = tool

	if (!holodisk_original.record)
		to_chat(user, span_warning("[holodisk_original]里没有录像！"))
		return ITEM_INTERACT_BLOCKING

	if (!record)
		record = new

	record.caller_name = holodisk_original.record.caller_name
	record.caller_image = holodisk_original.record.caller_image
	record.entries = holodisk_original.record.entries.Copy()
	record.language = holodisk_original.record.language
	to_chat(user, span_notice("你连接接口，将[holodisk_original]中的录像复制到了[src]！"))
	name = holodisk_original.name

	return ITEM_INTERACT_SUCCESS

/obj/item/disk/holodisk/proc/build_record()
	record = new
	var/list/lines = splittext(preset_record_text,"\n")
	for(var/line in lines)
		var/prepared_line = trim(line)
		if(!length(prepared_line))
			continue
		var/splitpoint = findtext(prepared_line," ")
		if(!splitpoint)
			continue
		var/command = copytext(prepared_line, 1, splitpoint)
		var/value = copytext(prepared_line, splitpoint + length(prepared_line[splitpoint]))
		switch(command)
			if("DELAY")
				var/delay_value = text2num(value)
				if(!delay_value)
					continue
				record.entries += list(list(HOLORECORD_DELAY,delay_value))
			if("NAME")
				if(!record.caller_name)
					record.caller_name = value
				else
					record.entries += list(list(HOLORECORD_RENAME,value))
			if("SAY")
				record.entries += list(list(HOLORECORD_SAY,value))
			if("SOUND")
				record.entries += list(list(HOLORECORD_SOUND,value))
			if("LANGUAGE")
				var/lang_type = text2path(value)
				if(ispath(lang_type,/datum/language))
					record.entries += list(list(HOLORECORD_LANGUAGE,lang_type))
			if("PRESET")
				var/preset_type = text2path(value)
				if(ispath(preset_type,/datum/preset_holoimage))
					record.entries += list(list(HOLORECORD_PRESET,preset_type))
	if(!preset_image_type)
		record.caller_image = image('icons/mob/simple/animal.dmi',"old")
	else
		var/datum/preset_holoimage/H = new preset_image_type
		record.caller_image = H.build_image()

//These build caller image from outfit and some additional data, for use by mappers for ruin holorecords
/datum/preset_holoimage
	var/nonhuman_mobtype //Fill this if you just want something nonhuman
	var/outfit_type
	var/species_type = /datum/species/human

/datum/preset_holoimage/proc/build_image()
	if(nonhuman_mobtype)
		var/mob/living/L = nonhuman_mobtype
		. = image(initial(L.icon),initial(L.icon_state))
	else
		var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy("HOLODISK_PRESET")
		if(species_type)
			mannequin.set_species(species_type)
		if(outfit_type)
			mannequin.equipOutfit(outfit_type,TRUE)
		mannequin.setDir(SOUTH)
		. = image(mannequin)
		unset_busy_human_dummy("HOLODISK_PRESET")

/datum/preset_holoimage/clown
	outfit_type = /datum/outfit/job/clown

/datum/preset_holoimage/engineer
	outfit_type = /datum/outfit/job/engineer

/datum/preset_holoimage/corgi
	nonhuman_mobtype = /mob/living/basic/pet/dog/corgi

/datum/preset_holoimage/engineer/mod
	outfit_type = /datum/outfit/job/engineer/mod

/datum/preset_holoimage/engineer/ce
	outfit_type = /datum/outfit/job/ce

/datum/preset_holoimage/engineer/ce/mod
	outfit_type = /datum/outfit/job/ce/mod

/datum/preset_holoimage/engineer/atmos
	outfit_type = /datum/outfit/job/atmos

/datum/preset_holoimage/engineer/atmos/mod
	outfit_type = /datum/outfit/job/atmos/mod

/datum/preset_holoimage/researcher
	outfit_type = /datum/outfit/job/scientist

/datum/preset_holoimage/captain
	outfit_type = /datum/outfit/job/captain

/datum/preset_holoimage/nanotrasenprivatesecurity
	outfit_type = /datum/outfit/nanotrasensoldiercorpse

/datum/preset_holoimage/syndicatebattlecruisercaptain
	outfit_type = /datum/outfit/syndicate_empty/battlecruiser

/datum/preset_holoimage/hivebot
	nonhuman_mobtype = /mob/living/basic/hivebot

/datum/preset_holoimage/ai
	nonhuman_mobtype = /mob/living/silicon/ai

/datum/preset_holoimage/robot
	nonhuman_mobtype = /mob/living/silicon/robot

/datum/preset_holoimage/assistant
	outfit_type = /datum/outfit/job/assistant

/obj/item/disk/holodisk/example
	preset_image_type = /datum/preset_holoimage/clown
	preset_record_text = {"
	NAME 小丑
	DELAY 10
	SAY 牧师为什么要穿过维护通道？
	DELAY 20
	SAY 因为他想去彼岸！
	SOUND clownstep
	DELAY 30
	LANGUAGE /datum/language/narsie
	SAY 我帮他过去了！
	DELAY 10
	SAY 还有，其实我是一只大猩猩
	DELAY 10
	PRESET /datum/preset_holoimage/gorilla
	NAME 大猩猩
	LANGUAGE /datum/language/common
	SAY 呜嘎
	DELAY 20"}

/obj/item/disk/holodisk/donutstation/whiteship
	name = "黑匣子转录盘 #DS024"
	desc = "一张全息录像盘，保存着 DS024 黑匣子最后一段可用录像。"
	preset_image_type = /datum/preset_holoimage/engineer/ce
	preset_record_text = {"
	NAME 盖瑟·肖特霍尔特
	SAY 引擎改造完成，船也装载好了。大家准备好了吗？
	DELAY 25
	PRESET /datum/preset_holoimage/engineer
	NAME 雅各布·乌尔曼
	SAY 咱们赶紧离开这个破站吧。
	DELAY 20
	PRESET /datum/preset_holoimage/engineer/atmos
	NAME 林赛·卡夫勒
	SAY 呃，长官？我们不该叫一艘备用穿梭机吗？这玩意儿的蓝空间引擎在我们跃迁过来时发出了特别古怪的声音……
	DELAY 30
	PRESET /datum/preset_holoimage/engineer/ce
	NAME 盖瑟·肖特霍尔特
	SAY 嗤！码头的船舶技工说，这东西要是犯毛病，狠狠踹上几脚就行了。让我来……
	DELAY 25
	SOUND punch
	SOUND sparks
	DELAY 10
	SOUND punch
	SOUND sparks
	DELAY 10
	SOUND punch
	SOUND sparks
	SOUND warpspeed
	DELAY 15
	PRESET /datum/preset_holoimage/engineer/atmos
	NAME 林赛·卡夫勒
	SAY 呃……它这样真的正常吗？？
	DELAY 15
	PRESET /datum/preset_holoimage/engineer/ce
	NAME 盖瑟·肖特霍尔特
	SAY 看吧？运行正常。那么，现在大家都准备好了吗？
	DELAY 10
	PRESET /datum/preset_holoimage/engineer
	NAME 雅各布·乌尔曼
	SAY 它本来就该这么发光吗？
	DELAY 20
	SOUND explosion

	"}

/obj/item/disk/holodisk/ruin/snowengieruin
	name = "黑匣子转录盘 #EB412"
	desc = "一张记录了 EB412 最后时刻的全息录像盘，上面留着一个血指印。"
	preset_image_type = /datum/preset_holoimage/engineer
	preset_record_text = {"
	NAME 戴夫·滕德雷尔
	SAY 玛丽亚，建造进展怎么样？
	DELAY 10
	NAME 玛丽亚·德尔
	PRESET /datum/preset_holoimage/engineer/atmos
	SAY 挺好的，别担心。我让普拉斯蒂克去处理了。说实话，我正忙着弄那个，呃，焚化炉。
	DELAY 30
	NAME 戴夫·滕德雷尔
	PRESET /datum/preset_holoimage/engineer
	SAY 行，太好了。不过科研那边实在不怎么样，连快速建造装置都没有——
	DELAY 20
	NAME 玛丽亚·德尔
	PRESET /datum/preset_holoimage/engineer/atmos
	SAY 别再念叨你的快速建造装置了。那东西根本没那么重要，直接建——
	DELAY 15
	SOUND explosion
	DELAY 10
	SAY 哦，操！
	DELAY 10
	PRESET /datum/preset_holoimage/engineer/atmos/mod
	LANGUAGE /datum/language/narsie
	NAME 未知
	SAY 降临吧，我的主！！
	DELAY 10
	LANGUAGE /datum/language/common
	NAME 普拉斯蒂克
	PRESET /datum/preset_holoimage/engineer/mod
	SAY 操，操，操！
	DELAY 20
	NAME 玛丽亚·德尔
	PRESET /datum/preset_holoimage/engineer/atmos
	SAY 乔治，等等——
	DELAY 10
	PRESET /datum/preset_holoimage/corgi
	NAME 黑匣子自动消息
	SAY 连接中断。正在将音频日志转存到磁盘。
	DELAY 50"}

/obj/item/disk/holodisk/ruin/ghost_restaurant
	name = "黑匣子转录盘 #NG234"
	preset_image_type = /datum/preset_holoimage/assistant
	preset_record_text = {"
	NAME 阿伦·布鲁
	SAY 收到纳米餐饮主题惊喜配送公司的消息——注册商标。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 老兄，你非得每次都念全名吗？
	DELAY 20
	NAME 阿伦·布鲁
	SAY 咳咳！
	DELAY 20
	NAME 阿伦·布鲁
	SAY 消息说他们超喜欢我们新的机器人主题！
	DELAY 20
	NAME 亨利·弗雷什
	SAY 哇，厉害！
	DELAY 20
	NAME 亨利·弗雷什
	SAY 我们会被调进主团队吗？
	DELAY 20
	NAME 阿伦·布鲁
	SAY 那当然！击个掌！
	DELAY 20
	SOUND punch
	NAME 亨利·弗雷什
	SAY 击掌！
	DELAY 20
	NAME 亨利·弗雷什
	SAY 哦，新订单。要的是，哈，*搞笑美食*。
	DELAY 20
	NAME 阿伦·布鲁
	SAY 简单！
	DELAY 20
	NAME 阿伦·布鲁
	SAY 我把这个机器人打扮成小丑。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 好吧，既然你这么没创意，就让它去要个香蕉派吧。
	DELAY 20
	NAME 阿伦·布鲁
	SAY 通往行星地表帕利亚奇 15 号的传送门已开启。
	DELAY 20
	NAME 阿伦·布鲁
	SAY 感觉挺合适。
	DELAY 15
	SOUND clown_step
	DELAY 10
	SOUND sparks
	DELAY 10
	NAME 阿伦·布鲁
	SAY 下一单要一道简单的农家菜。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 我可不像你，我很有创意。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 我把它打扮成稻草人。
	SOUND rustle
	DELAY 20
	NAME 阿伦·布鲁
	SAY 让它去要个，呃，热土豆吧。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 把它送到那个新地方，巴尔萨佐德火力基地。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 等等。
	DELAY 10
	NAME 亨利·弗雷什
	SAY 你知道那东西叫烤土豆吧？
	DELAY 10
	SOUND sparks
	DELAY 20
	NAME 阿伦·布鲁
	SAY 闭嘴，他们知道我什么意思！
	DELAY 20
	SOUND sparks
	DELAY 10
	NAME 亨利·弗雷什
	SAY 它回来了。
	DELAY 20
	NAME 亨利·弗雷什
	SAY 哈哈，它带回了一个生土豆。
	DELAY 20
	NAME 阿伦·布鲁
	SAY 亨利，它在滴答——
	DELAY 20
	SOUND explosion
	DELAY 20
	PRESET /datum/preset_holoimage/corgi
	NAME 黑匣子自动消息
	SAY 连接中断。正在将音频日志转存到磁盘。
	DELAY 50
	"}

/obj/item/disk/holodisk/ruin/space/travelers_rest
	name = "主人的备忘录"
	desc = "一张全息录像盘，存着前任主人留给另一个人的简短备忘。"
	preset_image_type = /datum/preset_holoimage/engineer/atmos
	preset_record_text = {"
		NAME 太空冒险家
		SOUND PING
		DELAY 20
		SAY 嘿，我给你留了这段话，等你回来就能听到。
		DELAY 50
		SAY 我收到了一艘货船的求救信号，准备过去找点好东西。
		DELAY 50
		SAY 你需要的话可以在这儿落脚，但走之前一定要检查锚缆。
		DELAY 50
		SAY 不检查的话，这东西可能会飘进太空。
		DELAY 50
		SAY 到时候说不定哪个怪人会发现它，把它据为己有。
		DELAY 50
		SAY 总之，我得走了，再见！
		DELAY 40
		SOUND sparks
	"}
