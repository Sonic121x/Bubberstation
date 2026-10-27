/datum/round_event_control/fax_spam
	name = "传真垃圾邮件"
	description = "向空间站所有传真机发送垃圾宣传册"
	typepath = /datum/round_event/fax_spam
	weight = 50
	min_players = 10 // Better chance of there being heads of staff that get annoyed by this
	max_occurrences = 2
	category = EVENT_CATEGORY_BUREAUCRATIC
	earliest_start = 20 MINUTES

	track = EVENT_TRACK_MUNDANE
	tags = list(TAG_NEUTRAL)

/datum/round_event/fax_spam
	announce_chance = 0
	fakeable = FALSE
	var/obj/item/paper/fluff/advertisement/spam_type

/datum/round_event/fax_spam/setup()
	if(prob(25)) // Rarer, nongeneric spam
		spam_type = pick(typesof(/obj/item/paper/fluff/advertisement))
	else
		spam_type = /obj/item/paper/fluff/junkmail_generic

/datum/round_event/fax_spam/start()
	for(var/obj/machinery/fax/fax_machine as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/fax))
		if(fax_machine.visible_to_network && is_station_level(fax_machine.z))
			var/obj/item/paper/fluff/advertisement/spam_message = new spam_type
			fax_machine.receive(spam_message, pick("傻甜筒", "小丑退休计划", "洪克好价！", "未知发件人"))

/obj/item/paper/fluff/advertisement
	icon = 'modular_zubbers/icons/obj/service/advertisements.dmi'
	name = "通用广告"
	desc = "一本塞满无用广告的宣传册。"

/obj/item/paper/fluff/advertisement/grand_nomad_fleet
	name = "\improper 致全体蛾族人声明"
	desc = "由著名的大上将西尼奥里印发的宣传册，他是蛾族大游牧舰队的军事领袖。\
	他的面容连同标志性的义体和威武的绒毛一起印在封面上。 \
	他身旁用粗体字写着“致所有仍迷失的同胞”。"
	icon_state = "nomad"
	var/static/random_sector_number = null

/obj/item/paper/fluff/advertisement/grand_nomad_fleet/Initialize(mapload)
	. = ..()
	if(isnull(random_sector_number))
		random_sector_number = rand(10000, 80000)
	add_raw_text("致 [GLOB.station_name] 所有迷失的蛾族同胞！\n\
	加入大游牧舰队，与你的同胞重聚，一同寻找新的家园。 \
	我们已派出一支小型巡逻队和一艘民用运输船停泊在邻近星区 [random_sector_number]。 \
	我们将在约 3 小时后启程，请速来。")

/obj/item/paper/fluff/advertisement/toolbox
	name = "强劲宣传册"
	desc = "封面上印着一只大工具箱的宣传册"
	default_raw_text = "用我们全新的独家 <b> 强劲工具箱 </b> 系列，证明你是精英中的精英。 \
	提供 7 种不同颜色，包括全新的亮粉色！500cr 起售。"
	icon_state = "toolbox"

/obj/item/paper/fluff/advertisement/toolbox/Initialize(mapload)
	. = ..()
	icon_state = initial(icon_state)

/obj/item/paper/fluff/advertisement/gilded
	name = "提兹拉王子声明"
	desc = "一本烫金宣传册，正面印着皇家红色的文字。"
	default_raw_text = "你好。我是流落在外的提兹拉王子巴尔纳克西四世，在我急需帮助之时向你致信。 \
	人们以为我在一次遭分离主义者袭击的穿梭机行程中身亡，但我其实活了下来，一直躲藏在 \
	你们的空间站上。请把 1000cr 的全息币装进写有你名字的袋子，放在废物处理区，好让我能买一张 \
	低调的穿梭机票返回我的宫殿。等我与家人团聚，定会让你沐浴在王室财富之中。"
	icon_state = "gilded"

/obj/item/paper/fluff/advertisement/gilded/Initialize(mapload)
	. = ..()
	icon_state = initial(icon_state)
