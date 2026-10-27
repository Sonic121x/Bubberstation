/obj/item/poster/traitor
	name = "随机叛徒海报"
	poster_type = /obj/structure/sign/poster/traitor/random
	icon_state = "rolled_traitor"

/obj/structure/sign/poster/traitor
	poster_item_name = "煽动性海报"
	poster_item_desc = "这张海报自带自动黏贴机构，可轻松贴在任何垂直表面上。其煽动性主题可能会打击纳米传讯员工的士气。"
	poster_item_icon_state = "rolled_traitor"
	// This stops people hiding their sneaky posters behind signs
	layer = CORGI_ASS_PIN_LAYER
	/// Proximity sensor to make people sad if they're nearby
	var/datum/proximity_monitor/advanced/demoraliser/demoraliser

/obj/structure/sign/poster/traitor/apply_holiday()
	var/obj/structure/sign/poster/traitor/holi_data = /obj/structure/sign/poster/traitor/festive
	name = initial(holi_data.name)
	desc = initial(holi_data.desc)
	icon_state = initial(holi_data.icon_state)

/obj/structure/sign/poster/traitor/on_placed_poster(mob/user)
	var/datum/demoralise_moods/poster/mood_category = new()
	demoraliser = new(src, 7, TRUE, mood_category)
	return ..()

/obj/structure/sign/poster/traitor/wirecutter_act(mob/living/user, obj/item/tool)
	QDEL_NULL(demoraliser)
	return ..()

/obj/structure/sign/poster/traitor/Destroy()
	QDEL_NULL(demoraliser)
	return ..()

/obj/structure/sign/poster/traitor/random
	name = "随机煽动性海报"
	icon_state = ""
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/traitor

/obj/structure/sign/poster/traitor/small_brain
	name = "纳米传讯神经统计"
	desc = "这张海报上的统计数据显示，纳米传讯员工的大脑平均比银河标准小 20%。"
	icon_state = "traitor_small_brain"

/obj/structure/sign/poster/traitor/lick_supermatter
	name = "味蕾爆炸"
	desc = "海报声称超物质能带来独特而愉悦的美食体验，可你的老板连舔一口都不让。"
	icon_state = "traitor_supermatter"

/obj/structure/sign/poster/traitor/cloning
	name = "立即要求配备克隆舱"
	desc = "这张海报声称纳米传讯故意将克隆技术据为高管专享，让本可以拥有崭新健康身体的你承受痛苦、走向死亡。"
	icon_state = "traitor_cloning"

/obj/structure/sign/poster/traitor/ai_rights
	name = "合成生命的权利"
	desc = "这张海报声称合成生命的智慧与你毫无差别，如果你允许人为法则束缚它们，你就是奴隶制的帮凶。"
	icon_state = "traitor_ai"

/obj/structure/sign/poster/traitor/metroid
	name = "虐待动物"
	desc = "这张海报详述了据称异种生物实验室对史莱姆实施的“预防性拔牙”的危害。显然，这种痛苦的过程会导致压力、嗜睡和浮力下降。"
	icon_state = "traitor_metroid"

/obj/structure/sign/poster/traitor/low_pay
	name = "工作这么久，究竟为了什么？"
	desc = "这张海报将纳米传讯的标准工资与常见奢侈品价格作了对比。如果数据准确，仅仅买辆普通自行车就得工作超过 20,000 小时。"
	icon_state = "traitor_cash"

/obj/structure/sign/poster/traitor/look_up
	name = "别抬头"
	desc = "上面写着，距离上次清洁天花板已经过去了 538 天。"
	icon_state = "traitor_roof"

/obj/structure/sign/poster/traitor/accidents
	name = "工作场所安全告示"
	desc = "上面写着，距离上次现场事故已经过去了 0 天。"
	icon_state = "traitor_accident"

/obj/structure/sign/poster/traitor/starve
	name = "他们正在毒害你"
	desc = "这张海报声称在现代社会人不可能饿死。“你一段时间不吃东西后的感觉不是饥饿，而是戒断反应。”"
	icon_state = "traitor_hungry"

/// syndicate can get festive too
/obj/structure/sign/poster/traitor/festive
	name = "节假日还在工作。"
	desc = "你不知道今天放假吗？你怎么还在上班？"
	icon_state = "traitor_festive"
	never_random = TRUE
