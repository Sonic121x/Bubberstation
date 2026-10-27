#define GBP_PUNCH_REWARD 150

/obj/item/card/id
	COOLDOWN_DECLARE(gbp_redeem_cooldown)

/obj/item/gbp_punchcard
	name = "优秀助理积分卡"
	desc = "优秀助理积分计划旨在为纳米传讯舰船与殖民地上原本无业或无薪的人员补充收入。<br>\
	只需让部门主管的 PDA 在你的积分卡上打孔，再到优秀助理积分机处兑换，每个孔即可获得 150 信用币！<br>\
	每张卡最多可打六个孔。兑换现有卡片后会发放新卡。请勿遗失你的积分卡。"
	icon = 'modular_skyrat/modules/cargo/icons/punchcard.dmi'
	icon_state = "punchcard_0"
	w_class = WEIGHT_CLASS_TINY
	var/max_punches = 6
	var/punches = 0
	req_access = list(ACCESS_COMMAND) // Without this, assistants can punch the card that comes from the machine after they've turned in their roundstart card by using their own PDA.
	COOLDOWN_DECLARE(gbp_punch_cooldown)

/obj/item/gbp_punchcard/starting
	icon_state = "punchcard_1"
	punches = 1 // GBP_PUNCH_REWARD credits by default
	req_access = list(ACCESS_COMMAND)

/obj/item/gbp_punchcard/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()

	var/is_valid_item = istype(attacking_item, /obj/item/gbp_puncher)
	if(!is_valid_item && istype(attacking_item, /obj/item/modular_computer/pda))
		var/obj/item/modular_computer/pda/pda = attacking_item
		is_valid_item = check_access(pda.stored_id)
		if (!is_valid_item)
			balloon_alert(user, "无权限！")

	if(is_valid_item)
		if(!COOLDOWN_FINISHED(src, gbp_punch_cooldown))
			balloon_alert(user, "冷却中！（[DisplayTimeText(COOLDOWN_TIMELEFT(src, gbp_punch_cooldown))]）")
			return
		if(punches < max_punches)
			punches++
			icon_state = "punchcard_[punches]"
			COOLDOWN_START(src, gbp_punch_cooldown, 90 SECONDS)
			log_econ("[user] punched a GAP card that is now at [punches]/[max_punches] punches.")
			playsound(attacking_item, 'sound/items/boxcutter_activate.ogg', 100)
			if(punches == max_punches)
				playsound(src, 'sound/items/party_horn.ogg', 100)
				say("恭喜，你的积分卡已经集满了！")
		else
			balloon_alert(user, "没有空位！")

/obj/item/gbp_puncher
	name = "优秀助理积分打孔器"
	desc = "用于优秀助理积分系统的打孔器。在积分卡上使用即可打一个孔。做好被助理们缠着求打孔的准备。"
	icon = 'modular_skyrat/modules/cargo/icons/punchcard.dmi'
	icon_state = "puncher"
	w_class = WEIGHT_CLASS_TINY

/obj/machinery/gbp_redemption
	name = "优秀助理积分兑换机"
	desc = "把你的优秀助理积分卡交到这里，按打孔数量领取报酬，还能拿到一张新卡！"
	icon = 'modular_skyrat/modules/cargo/icons/punchcard.dmi'
	icon_state = "gbp_machine"
	density = TRUE
	circuit = /obj/item/circuitboard/machine/gbp_redemption

/obj/machinery/gbp_redemption/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/gbp_redemption/update_icon_state()
	. = ..()
	if(panel_open)
		icon_state = "[initial(icon_state)]_open"
		return
	icon_state = initial(icon_state)

/obj/machinery/gbp_redemption/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	return default_deconstruction_screwdriver(user, tool)

/obj/machinery/gbp_redemption/attackby(obj/item/attacking_item, mob/user, params)
	if(default_pry_open(attacking_item, close_after_pry = TRUE))
		return

	if(default_deconstruction_crowbar(attacking_item))
		return

	if(istype(attacking_item, /obj/item/gbp_punchcard))
		var/obj/item/gbp_punchcard/punchcard = attacking_item
		var/amount_to_reward = punchcard.punches * GBP_PUNCH_REWARD
		if(!punchcard.punches)
			playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
			say("未打孔的卡无法兑换！")
			return

		var/obj/item/card/id/card_used
		if(isliving(user))
			var/mob/living/living_user = user
			card_used = living_user.get_idcard(TRUE)

		if(isnull(card_used))
			return

		if(!COOLDOWN_FINISHED(card_used, gbp_redeem_cooldown))
			balloon_alert(user, "冷却中！[DisplayTimeText(COOLDOWN_TIMELEFT(card_used, gbp_redeem_cooldown))]")
			return

		if(!card_used.registered_account || !istype(card_used.registered_account.account_job, /datum/job/assistant))
			playsound(src, 'sound/machines/scanner/scanbuzz.ogg', 100)
			say("没有有效的助理银行账户，无法兑换积分卡！")
			return

		if(punchcard.punches < punchcard.max_punches)
			if(tgui_alert(user, "你的积分卡还没集满！确定要兑换吗？这会启动 15 分钟计时。", "这可真是够敷衍的", list("否", "是")) != "是")
				return

		if(!punchcard.punches) // check to see if someone left the dialog open to redeem a card twice
			return

		var/validated_punches = punchcard.punches
		punchcard.punches = 0
		playsound(src, 'sound/machines/printer.ogg', 100)
		card_used.registered_account.adjust_money(amount_to_reward, "GAP：打孔 [validated_punches] 个")
		log_econ("[amount_to_reward] 信用币已因兑换 GAP 卡发放到 [card_used.registered_account.account_holder] 的账户。")
		say("已向你的账户发放 [amount_to_reward]，并配发了一份口粮包！感谢你成为优秀助理！请取走你的新积分卡。")
		COOLDOWN_START(card_used, gbp_redeem_cooldown, 12 MINUTES)
		user.temporarilyRemoveItemFromInventory(punchcard)
		qdel(punchcard)
		var/obj/item/storage/fancy/nugget_box/nuggies = new(get_turf(src))
		var/obj/item/gbp_punchcard/replacement_card = new(get_turf(src))
		user.put_in_hands(nuggies)
		user.put_in_hands(replacement_card)
		return

	return ..()

/obj/item/circuitboard/machine/gbp_redemption
	name = "优秀助理积分兑换机"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/gbp_redemption
	req_components = list(
		/datum/stock_part/servo = 1)

/datum/outfit/job/assistant/pre_equip(mob/living/carbon/human/human, visualsOnly)
	. = ..()
	backpack_contents += list(/obj/item/gbp_punchcard/starting)

/datum/design/board/gbp_machine
	name = "优秀助理积分兑换机电路板"
	desc = "优秀助理积分兑换机的电路板。"
	id = "gbp_machine"
	build_path = /obj/item/circuitboard/machine/gbp_redemption
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO

#undef GBP_PUNCH_REWARD
