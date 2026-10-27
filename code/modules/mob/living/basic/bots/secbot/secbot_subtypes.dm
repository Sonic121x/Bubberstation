/mob/living/basic/bot/secbot/beepsky
	name = "毕普·奥斯基指挥官"
	desc = "这是毕普·奥斯基指挥官！作为站内所有机器人的正式上级，他依旧像刚被制造出来那天一样谦逊而忠于法律。"
	bot_mode_flags = BOT_MODE_ON | BOT_MODE_AUTOPATROL | BOT_MODE_REMOTE_ENABLED
	commissioned = TRUE


/mob/living/basic/bot/secbot/beepsky/officer
	name = "毕普斯基警官"
	desc = "这是毕普斯基警官！靠一颗土豆和一杯威士忌驱动，机身还做了加固，更加结实。"
	health = 45

/mob/living/basic/bot/secbot/beepsky/officer/Initialize(mapload)
	. = ..()
	// Beepsky hates people scanning them
	RegisterSignal(src, COMSIG_MOVABLE_SPY_STEALING, PROC_REF(on_spy_scan))

/mob/living/basic/bot/secbot/beepsky/officer/proc/on_spy_scan(datum/source, mob/user)
	SIGNAL_HANDLER

	ai_controller?.insert_blackboard_key_lazylist(BB_BASIC_MOB_RETALIATE_LIST, user)

/mob/living/basic/bot/secbot/beepsky/ofitser
	name = "监狱警官"
	desc = "以劳工的血汗为动力。"
	bot_mode_flags = ~(BOT_MODE_CAN_BE_SAPIENT|BOT_MODE_AUTOPATROL)

/mob/living/basic/bot/secbot/beepsky/armsky
	name = "阿姆斯基军士长"
	desc = "这是阿姆斯基军士长！他是典狱长手下一位满腹牢骚的助手，要是他有手的话，大概会开枪打你。"
	health = 45
	bot_mode_flags = ~(BOT_MODE_CAN_BE_SAPIENT|BOT_MODE_AUTOPATROL)
	security_mode_flags = SECBOT_DECLARE_ARRESTS | SECBOT_CHECK_IDS | SECBOT_CHECK_RECORDS | SECBOT_CHECK_WEAPONS

/mob/living/basic/bot/secbot/beepsky/jr
	name = "小不点警官"
	desc = "这是毕普·奥斯基指挥官那个个子更小、却同样凶悍的表亲——小不点。"
	commissioned = FALSE

/mob/living/basic/bot/secbot/beepsky/jr/Initialize(mapload)
	. = ..()
	update_transform(0.8)

/mob/living/basic/bot/secbot/pingsky
	name = "平斯基警官"
	desc = "这是平斯基警官！因为怀有反人类情绪，他被派去负责卫星站守卫任务。"
	light_color = "#62baf5"
	radio_channel = RADIO_CHANNEL_AI_PRIVATE
	bot_mode_flags = ~(BOT_MODE_CAN_BE_SAPIENT|BOT_MODE_AUTOPATROL)
	security_mode_flags = SECBOT_DECLARE_ARRESTS | SECBOT_CHECK_IDS | SECBOT_CHECK_RECORDS

/mob/living/basic/bot/secbot/genesky
	name = "基因斯基警官"
	desc = "标准安保机器人机型中体格壮硕的一个变体。"
	health = 50
	faction = list(FACTION_NANOTRASEN_PRIVATE)
	bot_mode_flags = BOT_MODE_ON
	bot_access_flags = BOT_COVER_LOCKED | BOT_COVER_EMAGGED

/mob/living/basic/bot/secbot/beepsky/explode()
	var/atom/current_location = drop_location()
	new /obj/item/stock_parts/power_store/cell/potato(current_location)
	var/obj/item/reagent_containers/cup/glass/drinkingglass/shotglass/drinking_oil = new(current_location)
	drinking_oil.reagents.add_reagent(/datum/reagent/consumable/ethanol/whiskey, 15)
	return ..()
