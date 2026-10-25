
/**
 * Upon completion of a civilian bounty, one of these is created.
 * It is sold to cargo to give the cargo budget bounty money, and the person who completed it cash.
 */
/obj/item/bounty_cube
	name = "悬赏方块"
	desc = "一团压缩的实体光数据，内含已完成的悬赏。用货运穿梭机出售它来领取赏金！"
	icon = 'icons/obj/economy.dmi'
	icon_state = "bounty_cube"
	///Value of the bounty that this bounty cube sells for.
	var/bounty_value = 0
	///Multiplier for the bounty payout received by the Supply budget if the cube is sent without having to nag.
	var/speed_bonus = 0.2
	///Percentage of the bounty payout received by the people who completed the bounty. Split between multiple people in the event multiple people finished a global bounty.
	var/holder_cut = BOUNTY_CUT_STANDARD
	///Multiplier for the bounty payout received by the person who claims the handling tip.
	var/handler_tip = 0.1
	///Time between nags.
	var/nag_cooldown = 5 MINUTES
	///How much the time between nags extends each nag.
	var/nag_cooldown_multiplier = 1.25
	///Next world tick to nag Supply listeners.
	var/next_nag_time
	///Who completed the bounty.
	var/bounty_holder
	///What job the bounty holder had.
	var/bounty_holder_job
	///What the bounty was for.
	var/bounty_name
	///Bank account of the people who completed the bounty.
	var/list/datum/bank_account/bounty_holder_accounts
	///Bank account of the person who receives the handling tip.
	var/datum/bank_account/bounty_handler_account

/obj/item/bounty_cube/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NO_BARCODES, INNATE_TRAIT) // Don't allow anyone to override our pricetag component with a barcode

/obj/item/bounty_cube/examine()
	. = ..()
	if(speed_bonus)
		. += span_notice("距离失去<b>[bounty_value * speed_bonus]</b> [MONEY_NAME_SINGULAR]的快速送达奖金还剩<b>[time2text(next_nag_time - world.time,"mm:ss", NO_TIMEZONE)]</b>。")
	if(handler_tip && !bounty_handler_account)
		. += span_notice("在货运穿梭机中用出口扫描仪扫描它，可登记你的银行账户，以领取<b>[bounty_value * handler_tip]</b> [MONEY_NAME_SINGULAR]的经手小费。")

/obj/item/bounty_cube/process(seconds_per_tick)
	//if our nag cooldown has finished and we aren't on Centcom or in transit, then nag
	if(COOLDOWN_FINISHED(src, next_nag_time) && !is_centcom_level(z) && !is_reserved_level(z))
		//set up our fallback message, in case of AAS being broken it will be sent to card holders
		var/nag_message = "[src]仍滞留在[chinese_area_display(get_area_name(src))]，尚未发运。"

		//nag on Supply channel and reduce the speed bonus multiplier to nothing
		var/obj/machinery/announcement_system/aas = get_announcement_system(/datum/aas_config_entry/bounty_cube_unsent, src, list(RADIO_CHANNEL_SUPPLY))
		if (aas)
			nag_message = aas.compile_config_message(/datum/aas_config_entry/bounty_cube_unsent, list("LOCATION" = chinese_area_display(get_area_name(src)), "COST" = bounty_value), "Regular Message")
			if (speed_bonus)
				aas.announce(/datum/aas_config_entry/bounty_cube_unsent, list("LOCATION" = chinese_area_display(get_area_name(src)), "COST" = bounty_value, "BONUSLOST" = bounty_value * speed_bonus), list(RADIO_CHANNEL_SUPPLY), "When Bonus Lost")
			else
				aas.broadcast("[nag_message]", list(RADIO_CHANNEL_SUPPLY))
		speed_bonus = 0

		//alert the holder
		for(var/datum/bank_account/bounty_holder_account in bounty_holder_accounts)
			bounty_holder_account.bank_card_talk("[nag_message]")

		//if someone has registered for the handling tip, nag them
		bounty_handler_account?.bank_card_talk(nag_message)

		//increase our cooldown length and start it again
		nag_cooldown = nag_cooldown * nag_cooldown_multiplier
		COOLDOWN_START(src, next_nag_time, nag_cooldown)

/**
 * Configures the bounty cube's name, value, and annouces to the crew
 */
/obj/item/bounty_cube/proc/set_up(datum/bounty/my_bounty, obj/item/card/id/holder_id)
	bounty_value = my_bounty.get_bounty_reward()
	bounty_name = my_bounty.name
	bounty_holder = holder_id.registered_name
	bounty_holder_job = holder_id.assignment
	bounty_holder_accounts = my_bounty.contribution

	name = "\improper [bounty_value] [MONEY_SYMBOL] [name]"
	desc += "销售标签显示，这是<i>[bounty_holder]（[chinese_job_display(bounty_holder_job)]）</i>完成<i>[bounty_name]</i>悬赏的奖励。"
	AddComponent(/datum/component/pricetag, bounty_holder_accounts.Copy(), holder_cut, FALSE)
	AddComponent(/datum/component/gps, "[src]")

	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, next_nag_time, nag_cooldown)
	aas_config_announce(/datum/aas_config_entry/bounty_cube_created, list(
		"LOCATION" = chinese_area_display(get_area_name(src)),
		"PERSON" = bounty_holder,
		"RANK" = chinese_job_display(bounty_holder_job),
		"BONUSTIME" = time2text(next_nag_time - world.time,"mm:ss", NO_TIMEZONE),
		"COST" = bounty_value
	), src, list(RADIO_CHANNEL_SUPPLY))

//for when you need a REAL bounty cube to test with and don't want to do a bounty each time your code changes
/obj/item/bounty_cube/debug_cube
	name = "调试用悬赏方块"
	desc = "在手中使用可为其设置随机悬赏。需要能够检测到一张关联银行账户的身份卡。\
	这会通过无线电将你的姓名和位置通报给补给部，货运技术员将获准格杀勿论并出动。"
	var/set_up = FALSE

/obj/item/bounty_cube/debug_cube/attack_self(mob/user)
	if(!isliving(user))
		to_chat(user, span_warning("你没有使用它的资格！"))
		return ..()

	if(!set_up)
		var/mob/living/squeezer = user
		if(squeezer.get_bank_account())
			set_up(random_bounty(), squeezer.get_idcard())
			set_up = TRUE
			return ..()
		to_chat(user, span_notice("它无法检测到你的银行账户。"))

	return ..()

// Bounty Cube AAS Config Entries

/datum/aas_config_entry/bounty_cube_created
	name = "货运提示：悬赏方块已生成"
	announcement_lines_map = list(
		"Message" = "%PERSON（%RANK）在%LOCATION生成了价值%COST信用点的悬赏方块。快速送达奖金将在%BONUSTIME后失效。")
	vars_and_tooltips_map = list(
		"LOCATION" = "将替换为方块所在的位置。",
		"PERSON" = "将替换为生成方块的人。",
		"RANK" = "将替换为其职位。",
		"BONUSTIME" = "将替换为快速送达奖金的剩余时限。",
		"COST" = "将替换为方块的价值。",
	)

/datum/aas_config_entry/bounty_cube_unsent
	name = "货运提示：悬赏方块尚未发运"
	announcement_lines_map = list(
		"Regular Message" = "价值%COST信用点的悬赏方块仍滞留在%LOCATION，尚未发运。",
		"When Bonus Lost" = "价值%COST信用点的悬赏方块仍滞留在%LOCATION，尚未发运。已失去%BONUSLOST信用点的快速送达奖金。")
	vars_and_tooltips_map = list(
		"LOCATION" = "将替换为方块所在的位置。",
		"COST" = "将替换为方块的价值。",
		"BONUSLOST" = "将替换为损失的奖金，仅用于奖金失效时的消息！",
	)
