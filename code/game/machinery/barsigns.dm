/obj/machinery/barsign // All Signs are 64 by 32 pixels, they take two tiles
	name = "酒吧招牌"
	desc = "不知为何尚未初始化的酒吧招牌。去找程序员投诉吧！"
	icon = 'icons/obj/machines/barsigns.dmi'
	icon_state = "empty"
	req_access = list(ACCESS_BAR)
	max_integrity = 500
	integrity_failure = 0.5
	armor_type = /datum/armor/sign_barsign
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.15
	/// Selected barsign being used
	var/datum/barsign/chosen_sign
	/// Do we attempt to rename the area we occupy when the chosen sign is changed?
	var/change_area_name = FALSE
	/// What kind of sign do we drop upon being disassembled?
	var/disassemble_result = /obj/item/wallframe/barsign

/datum/armor/sign_barsign
	melee = 20
	bullet = 20
	laser = 20
	energy = 100
	fire = 50
	acid = 50

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign, 32)

/obj/machinery/barsign/Initialize(mapload)
	. = ..()
	//Roundstart/map specific barsigns "belong" in their area and should be renaming it, signs created from wallmounts will not.
	change_area_name = mapload
	set_sign(new /datum/barsign/hiddensigns/signoff)
	if(mapload)
		find_and_mount_on_atom()

/obj/machinery/barsign/proc/set_sign(datum/barsign/sign)
	if(!istype(sign))
		return

	var/area/bar_area = get_area(src)
	if(change_area_name && sign.rename_area)
		rename_area(bar_area, sign.name)

	chosen_sign = sign
	update_appearance()

/obj/machinery/barsign/update_icon_state()
	if(!(machine_stat & BROKEN) && (!(machine_stat & NOPOWER) || machine_stat & EMPED) && chosen_sign && chosen_sign.icon_state)
		icon_state = chosen_sign.icon_state
	else
		icon_state = "empty"

	return ..()

/obj/machinery/barsign/update_desc()
	. = ..()

	if(chosen_sign && chosen_sign.desc)
		desc = chosen_sign.desc

/obj/machinery/barsign/update_name()
	. = ..()
	if(chosen_sign && chosen_sign.rename_area)
		name = "[initial(name)] ([chosen_sign.name])"
	else
		name = "[initial(name)]"

/obj/machinery/barsign/update_overlays()
	. = ..()

	if(((machine_stat & NOPOWER) && !(machine_stat & EMPED)) || (machine_stat & BROKEN))
		return

	if(chosen_sign && chosen_sign.light_mask)
		. += emissive_appearance(icon, "[chosen_sign.icon_state]-light-mask", src)

/obj/machinery/barsign/update_appearance(updates=ALL)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		set_light(0)
		return
	if(chosen_sign && chosen_sign.neon_color)
		set_light(MINIMUM_USEFUL_LIGHT_RANGE, 0.7, chosen_sign.neon_color)

/obj/machinery/barsign/proc/set_sign_by_name(sign_name)
	for(var/datum/barsign/sign as anything in subtypesof(/datum/barsign))
		if(initial(sign.name) == sign_name)
			var/new_sign = new sign
			set_sign(new_sign)

/obj/machinery/barsign/atom_break(damage_flag)
	. = ..()
	if(machine_stat & BROKEN)
		set_sign(new /datum/barsign/hiddensigns/signoff)

/obj/machinery/barsign/on_deconstruction(disassembled)
	if(disassembled)
		new disassemble_result(drop_location())
	else
		new /obj/item/stack/sheet/iron(drop_location(), 2)
		new /obj/item/stack/cable_coil(drop_location(), 2)

/obj/machinery/barsign/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src.loc, 'sound/effects/glass/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/tools/welder.ogg', 100, TRUE)

/obj/machinery/barsign/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/barsign/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!allowed(user))
		balloon_alert(user, "访问被拒绝！")
		return
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "控制装置无响应！")
		return
	pick_sign(user)

/obj/machinery/barsign/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	if(panel_open)
		balloon_alert(user, "面板已打开")
		set_sign(new /datum/barsign/hiddensigns/signoff)
		return ITEM_INTERACT_SUCCESS

	balloon_alert(user, "面板已关闭")

	if(machine_stat & (NOPOWER|BROKEN) || !chosen_sign)
		set_sign(new /datum/barsign/hiddensigns/signoff)
	else
		set_sign(chosen_sign)

	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/wrench_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		balloon_alert(user, "请先打开面板！")
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	if(!do_after(user, (10 SECONDS), target = src))
		return ITEM_INTERACT_BLOCKING

	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/barsign/item_interaction(mob/living/user, obj/item/tool, list/modifiers)

	if(istype(tool, /obj/item/blueprints) && !change_area_name)
		if(!panel_open)
			balloon_alert(user, "请先打开面板！")
			return ITEM_INTERACT_BLOCKING

		change_area_name = TRUE
		balloon_alert(user, "招牌已注册")
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/stack/cable_coil) && panel_open)
		var/obj/item/stack/cable_coil/wire = tool

		if(atom_integrity >= max_integrity)
			balloon_alert(user, "不需要维修！")
			return ITEM_INTERACT_BLOCKING

		if(!wire.use(2))
			balloon_alert(user, "需要两段电缆！")
			return ITEM_INTERACT_BLOCKING

		balloon_alert(user, "已修复")
		atom_integrity = max_integrity
		set_machine_stat(machine_stat & ~BROKEN)
		update_appearance()
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/barsign/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return

	set_machine_stat(machine_stat | EMPED)
	addtimer(CALLBACK(src, PROC_REF(fix_emp), chosen_sign), 60 SECONDS)
	set_sign(new /datum/barsign/hiddensigns/empbarsign)

/// Callback to un-emp the sign some time.
/obj/machinery/barsign/proc/fix_emp(datum/barsign/sign)
	set_machine_stat(machine_stat & ~EMPED)
	if(!istype(sign))
		return

	set_sign(sign)

/obj/machinery/barsign/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(machine_stat & (NOPOWER|BROKEN|EMPED))
		balloon_alert(user, "控制装置无响应！")
		return FALSE

	balloon_alert(user, "已加载非法酒吧招牌")
	addtimer(CALLBACK(src, PROC_REF(finish_emag_act)), 10 SECONDS)
	return TRUE

/// Timer proc, called after ~10 seconds after [emag_act], since [emag_act] returns a value and cannot sleep
/obj/machinery/barsign/proc/finish_emag_act()
	set_sign(new /datum/barsign/hiddensigns/syndibarsign)

/obj/machinery/barsign/proc/pick_sign(mob/user)
	var/picked_name = tgui_input_list(user, "可用招牌", "酒吧招牌", sort_list(get_bar_names()))
	if(isnull(picked_name))
		return
	set_sign_by_name(picked_name)
	SSblackbox.record_feedback("tally", "barsign_picked", 1, chosen_sign.type)

/proc/get_bar_names()
	var/list/names = list()
	for(var/d in subtypesof(/datum/barsign))
		var/datum/barsign/D = d
		if(!initial(D.hidden))
			names += initial(D.name)
	. = names

/datum/barsign
	/// User-visible name of the sign.
	var/name
	/// Icon state associated with this sign
	var/icon_state
	/// Description shown in the sign's examine text.
	var/desc
	/// Hidden from list of selectable options.
	var/hidden = FALSE
	/// Rename the area when this sign is selected.
	var/rename_area = TRUE
	/// If a barsign has a light mask for emission effects
	var/light_mask = TRUE
	/// The emission color of the neon light
	var/neon_color

/datum/barsign/New()
	if(!desc)
		desc = "上面显示着“[name]”。"

// Specific bar signs.

/datum/barsign/maltesefalcon
	name = "马耳他之鹰"
	icon_state = "maltesefalcon"
	desc = "马耳他之鹰，太空酒吧与烧烤餐厅。"
	neon_color = "#5E8EAC"

/datum/barsign/thebark
	name = "汪汪酒吧"
	icon_state = "thebark"
	desc = "伊恩最爱的酒吧。"
	neon_color = "#f7a604"

/datum/barsign/harmbaton
	name = "伤害警棍"
	icon_state = "theharmbaton"
	desc = "为安保人员和助理提供同样出色的用餐体验。"
	neon_color = "#ff7a4d"

/datum/barsign/thesingulo
	name = "奇点酒吧"
	icon_state = "thesingulo"
	desc = "不想被人叫出名字的人常来的地方。"
	neon_color = "#E600DB"

/datum/barsign/thedrunkcarp
	name = "醉鲤鱼"
	icon_state = "thedrunkcarp"
	desc = "喝酒不开游，游泳不喝酒。"
	neon_color = "#a82196"

/datum/barsign/scotchservinwill
	name = "威利的苏格兰酒馆"
	icon_state = "scotchservinwill"
	desc = "从小丑变成酒保，威利可真是出人头地了。"
	neon_color = "#fee4bf"

/datum/barsign/officerbeersky
	name = "比尔斯基警官酒馆"
	icon_state = "officerbeersky"
	desc = "他妈的，这些酒真好喝。"
	neon_color = "#16C76B"

/datum/barsign/thecavern
	name = "洞窟酒吧"
	icon_state = "thecavern"
	desc = "听着好曲，品着好酒。"
	neon_color = "#0fe500"

/datum/barsign/theouterspess
	name = "外太空酒吧"
	icon_state = "theouterspess"
	desc = "这家酒吧其实并不在外太空。"
	neon_color = "#30f3cc"

/datum/barsign/slipperyshots
	name = "滑滑小酒杯"
	icon_state = "slipperyshots"
	desc = "喝上我们的小杯烈酒，一路滑向酩酊大醉！"
	neon_color = "#70DF00"

/datum/barsign/thegreytide
	name = "灰潮酒吧"
	icon_state = "thegreytide"
	desc = "放下打人的工具箱，悠闲地喝杯啤酒！"
	neon_color = "#00F4D6"

/datum/barsign/honkednloaded
	name = "滑稽满膛"
	icon_state = "honkednloaded"
	desc = "滑稽。"
	neon_color = "#FF998A"

/datum/barsign/le_cafe_silencieux
	name = "寂静咖啡馆"
	icon_state = "le_cafe_silencieux"
	desc = "..."
	neon_color = "#ffffff"

/datum/barsign/thenest
	name = "巢穴酒吧"
	icon_state = "thenest"
	desc = "打击犯罪忙了一夜后，来这里歇脚喝一杯再好不过。"
	neon_color = "#4d6796"

/datum/barsign/thecoderbus
	name = "程序员巴士"
	icon_state = "thecoderbus"
	desc = "一家争议颇多的酒吧，以品种繁多、不断变化的饮品闻名。"
	neon_color = "#ffffff"

/datum/barsign/theadminbus
	name = "管理员巴士"
	icon_state = "theadminbus"
	desc = "主要由太空法官光顾的场所。这里遭到轰炸的频率可比庭审低多了。"
	neon_color = "#ffffff"

/datum/barsign/oldcockinn
	name = "老公鸡客栈"
	icon_state = "oldcockinn"
	desc = "这块招牌不知为何让你满心绝望。"
	neon_color = "#a4352b"

/datum/barsign/thewretchedhive
	name = "罪恶蜂巢"
	icon_state = "thewretchedhive"
	desc = "依法提醒：饮用前请检查饮品中是否含酸。"
	neon_color = "#26b000"

/datum/barsign/robustacafe
	name = "罗布斯塔咖啡馆"
	icon_state = "robustacafe"
	desc = "连续五年稳居“最致命酒吧斗殴”纪录榜首。"
	neon_color = "#c45f7a"

/datum/barsign/emergencyrumparty
	name = "紧急朗姆派对"
	icon_state = "emergencyrumparty"
	desc = "长期停业后，最近终于重新获批开业。"
	neon_color = "#f90011"

/datum/barsign/combocafe
	name = "组合咖啡馆"
	icon_state = "combocafe"
	desc = "以毫无创意的饮品组合闻名整个星系。"
	neon_color = "#33ca40"

/datum/barsign/vladssaladbar
	name = "弗拉德的沙拉吧"
	icon_state = "vladssaladbar"
	desc = "现已更换经营者。弗拉德总是太爱扣动那把霰弹枪的扳机。"
	neon_color = "#306900"

/datum/barsign/theshaken
	name = "摇出来的酒吧"
	icon_state = "theshaken"
	desc = "本店不供应搅拌调制的饮品。"
	neon_color = "#dcd884"

/datum/barsign/thealenath
	name = "艾尔纳斯啤酒馆"
	icon_state = "thealenath"
	desc = "好了，伙计。我看你已经喝得艾尔纳斯了。该叫出租车了。"
	neon_color = "#ed0000"

/datum/barsign/thealohasnackbar
	name = "阿罗哈小吃吧"
	icon_state = "alohasnackbar"
	desc = "一块雅致而不得罪人的提基酒吧招牌。"
	neon_color = ""

/datum/barsign/thenet
	name = "网罗酒吧"
	icon_state = "thenet"
	desc = "你似乎总会在这里一泡就是好几个小时。"
	neon_color = "#0e8a00"

/datum/barsign/maidcafe
	name = "女仆咖啡馆"
	icon_state = "maidcafe"
	desc = "欢迎回来，主人！"
	neon_color = "#ff0051"

/datum/barsign/the_lightbulb
	name = "灯泡咖啡馆"
	icon_state = "the_lightbulb"
	desc = "深受飞蛾和蛾人欢迎的咖啡馆。曾因酒保用樟脑丸保护备用制服而停业一周。"
	neon_color = "#faff82"

/datum/barsign/goose
	name = "放飞大鹅"
	icon_state = "goose"
	desc = "喝到吐，或者喝到打破现实法则，或者两样都来！"
	neon_color = "#00cc33"

/datum/barsign/maltroach
	name = "麦芽蛾蟑"
	icon_state = "maltroach"
	desc = "蛾蟑们礼貌地迎接你进酒吧，还是它们只是在互相问好？"
	neon_color = "#649e8a"

/datum/barsign/rock_bottom
	name = "人生谷底"
	icon_state = "rock-bottom"
	desc = "感觉自己身陷低谷时，不如喝一杯。"
	neon_color = "#aa2811"

/datum/barsign/orangejuice
	name = "橙子果汁铺"
	icon_state = "orangejuice"
	desc = "献给那些想对不喝酒的人体贴周到的顾客。"
	neon_color = COLOR_ORANGE

/datum/barsign/tearoom
	name = "小点心茶室"
	icon_state = "little_treats"
	desc = "为宇宙中所有讲究的绅士准备的惬意茶室。"
	neon_color = COLOR_LIGHT_ORANGE

/datum/barsign/assembly_line
	name = "流水线酒吧"
	icon_state = "the-assembly-line"
	desc = "每一杯饮品都以工业效率精心调制！"
	neon_color = "#ffffff"

/datum/barsign/bargonia
	name = "酒吧共和国"
	icon_state = "bargonia"
	desc = "仓库渴望更伟大的使命……于是补给部宣布酒吧共和国成立！"
	neon_color = COLOR_WHITE

/datum/barsign/cult_cove
	name = "邪教海湾"
	icon_state = "cult-cove"
	desc = "纳尔西最爱的度假胜地。"
	neon_color = COLOR_RED

/datum/barsign/neon_flamingo
	name = "霓虹火烈鸟"
	icon_state = "neon-flamingo"
	desc = "一辆欢迎所有人上车的巴士，缺乏张扬天赋的人除外。"
	neon_color = COLOR_PINK

/datum/barsign/slowdive
	name = "缓缓下潜"
	icon_state = "slowdive"
	desc = "离开地狱的第一站，进入天堂前的最后一站。"
	neon_color = COLOR_RED

/datum/barsign/the_red_mons
	name = "红山酒吧"
	icon_state = "the-red-mons"
	desc = "来自红色星球的饮品。"
	neon_color = COLOR_RED

/datum/barsign/the_rune
	name = "符文酒吧"
	icon_state = "therune"
	desc = "扭转现实的饮品。"
	neon_color = COLOR_RED

/datum/barsign/the_wizard
	name = "巫师酒吧"
	icon_state = "the-wizard"
	desc = "魔法调酒。"
	neon_color = COLOR_RED

/datum/barsign/months_moths_moths
	name = "蛾蛾蛾"
	icon_state = "moths-moths-moths"
	desc = "活蛾！"
	neon_color = COLOR_RED

/datum/barsign/coldones
	name = "来杯冰的"
	icon_state = "cold-ones"
	desc = "这就是所谓的酸奶效应。"
	neon_color = ""

/datum/barsign/doctorsorders
	name = "遵医嘱"
	icon_state = "doctors-orders"
	desc = "供应非处方止痛药。"
	neon_color = ""

/datum/barsign/wrongturn
	name = "拐错弯"
	icon_state = "wrong-turn"
	desc = "你并不觉得迷路了。不过没什么是喝上几杯解决不了的。"
	neon_color = ""

/datum/barsign/punpunspub
	name = "潘潘酒馆"
	icon_state = "pun-puns-pub"
	desc = "经历了他经历的那些事？换我也想守着酒过日子。"
	neon_color = ""

// Hidden signs list below this point

/datum/barsign/hiddensigns
	hidden = TRUE

/datum/barsign/hiddensigns/empbarsign
	name = "电磁脉冲损坏"
	icon_state = "empbarsign"
	desc = "某处出了严重问题。"
	rename_area = FALSE

/datum/barsign/hiddensigns/syndibarsign
	name = "辛迪猫"
	icon_state = "syndibarsign"
	desc = "加入辛迪加，否则就去死。"
	neon_color = "#ff0000"

/datum/barsign/hiddensigns/signoff
	name = "关闭"
	icon_state = "empty"
	desc = "这块招牌似乎没有开启。"
	rename_area = FALSE
	light_mask = FALSE

// For other locations that aren't in the main bar
/obj/machinery/barsign/all_access
	req_access = null
	disassemble_result = /obj/item/wallframe/barsign/all_access

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/barsign/all_access, 32)

/obj/item/wallframe/barsign
	name = "酒吧招牌框架"
	desc = "用来吸引人群光顾你的酒吧。需要组装。"
	icon = 'icons/obj/machines/wallmounts.dmi'
	icon_state = "barsign"
	result_path = /obj/machinery/barsign
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
	pixel_shift = 32

/obj/item/wallframe/barsign/Initialize(mapload)
	. = ..()
	desc += "可使用[span_bold("空间站蓝图")]注册，将招牌与其所在区域关联。"

/obj/item/wallframe/barsign/try_build(turf/on_wall, mob/user)
	. = ..()
	if(!.)
		return .

	if(isopenturf(get_step(on_wall, EAST))) //This takes up 2 tiles so we want to make sure we have two tiles to hang it from.
		balloon_alert(user, "需要更多支撑！")
		return FALSE

/obj/item/wallframe/barsign/all_access
	desc = "用来吸引人群光顾你的酒吧。需要组装。这个没有权限锁。"
	result_path = /obj/machinery/barsign/all_access
