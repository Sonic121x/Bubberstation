/*******************************\
|   SLOT MACHINES               |
|   Original code by Glloyd     |
|   Tgstation port by Miauw     |
|   Tgui spin by stylemistake   |
\*******************************/

#define SPIN_PRICE 5
#define WINNING_NOTHING 0
#define WINNING_FREESPIN 1
#define WINNING_SMALL 2
#define WINNING_BIG 3
#define WINNING_JACKPOT 4
#define PRIZE_SMALL 400
#define PRIZE_BIG 1000
#define PRIZE_JACKPOT 10000
#define SPIN_TIME 4 SECONDS
#define REEL_DEACTIVATE_DELAY 0.4 SECONDS
#define HOLOCHIP 1
#define COIN 2

/obj/machinery/computer/slot_machine
	name = "老虎机"
	desc = "不爱社交的赌客之选。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "slots"
	icon_keyboard = null
	icon_screen = "slots_screen"
	density = TRUE
	circuit = /obj/item/circuitboard/computer/slot_machine
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON // don't need to be literate to play slots
	light_color = LIGHT_COLOR_BROWN
	var/money = 3000 // How much money it has CONSUMED
	var/plays = 0
	var/working = FALSE
	var/winning = WINNING_NOTHING
	var/balance = 0 // How much money is in the machine, ready to be CONSUMED.
	var/jackpots = 0
	var/paymode = HOLOCHIP // toggles between HOLOCHIP/COIN, defined above
	var/cointype = /obj/item/coin/iron //default cointype

	/// The optional bank account used as the machine's bank. Player losses are deposited here, while payouts and jackpots are deducted from its balance
	var/datum/bank_account/house_bank_account

	/// Typepaths representing the symbols shown on this machine's reels
	var/list/symbol_paths = list(
		/obj/item/storage/bag/money,
		/obj/item/food/grown/cherry_bomb,
		/obj/item/grenade/flashbang,
		/obj/item/poker_chip,
		/obj/item/food/grown/chili,
		/obj/item/clothing/neck/necklace/dope,
		/obj/item/stack/spacecash/c20,
	)

	/// Used to determine the 1st name of the slot machine. Name = "[adjective] [noun]"
	var/list/slot_adjectives = list("烈焰", "加奖", "豪华", "贪婪", "巨型", "铂金", "幸运", "超级", "强悍", "超凡", "涡轮", "狂野")
	/// Used to determine the 2nd name of the slot machine. Name = "[adjective] [noun]"
	var/list/slot_nouns = list("赌本", "兑金", "财富", "头奖", "好运", "金钱", "发薪日", "滚轴", "财宝", "转盘", "旋转", "出击", "宝藏", "太空")

	/// The symbol typepath that pays out the jackpot when it lines up five wide
	var/jackpot_path = /obj/item/food/grown/cherry_bomb

	/// The symbol typepath that activates a trap when it lines up five wide (set to null to disable)
	var/trap_path = /obj/item/grenade/flashbang

	/// Cached list of symbol data (id/name/icon/icon_state) sent to ui_static_data
	var/list/symbol_data

	var/static/list/coinvalues
	var/list/reels = list(
		list("", "", ""),
		list("", "", ""),
		list("", "", ""),
		list("", "", ""),
		list("", "", ""),
	)
	var/static/list/ray_filter = list(type = "rays", y = 14, size = 40, density = 4, color = COLOR_RED_LIGHT, factor = 15, flags = FILTER_OVERLAY)

/obj/machinery/computer/slot_machine/Initialize(mapload)
	. = ..()
	jackpots = rand(1, 4) //false hope
	plays = rand(75, 200)

	name = make_machine_name()

	if(jackpot_path && !(jackpot_path in symbol_paths))
		stack_trace("[type] has jackpot_path [jackpot_path] not present in symbol_paths!")
	if(trap_path && !(trap_path in symbol_paths))
		stack_trace("[type] has trap_path [trap_path] not present in symbol_paths!")

	build_symbol_data()
	// Populate the reels
	randomize_reels()

	if (isnull(coinvalues))
		coinvalues = list()

		for(cointype in typesof(/obj/item/coin))
			var/obj/item/coin/C = new cointype
			coinvalues["[cointype]"] = C.get_item_credit_value()
			qdel(C) //Sigh

/obj/machinery/computer/slot_machine/Destroy()
	house_bank_account = null
	. = ..()

/// Generates a randomised slot name by pulling an adjective and a noun
/// Produces things like "Lucky Sevens", "Robust Payday", "Honking Bonanza", etc.
/obj/machinery/computer/slot_machine/proc/make_machine_name()
	var/adjective = pick(slot_adjectives)
	var/noun = pick(slot_nouns)
	return "[adjective] [noun]"

/// Builds symbol_data from symbol_paths to be used for DmIcon in TGUI
/obj/machinery/computer/slot_machine/proc/build_symbol_data()
	symbol_data = list()
	for(var/obj/symbol as anything in symbol_paths)
		symbol_data += list(list(
			"id" = "[symbol]",
			"icon_id" = sanitize_css_class_name("[symbol::icon][symbol::icon_state]")
		))

/obj/machinery/computer/slot_machine/on_deconstruction(disassembled)
	if(balance)
		give_payout(balance)

/obj/machinery/computer/slot_machine/process(seconds_per_tick)
	. = ..() //Sanity checks.
	if(!.)
		return .

	money += round(seconds_per_tick / 2) //SPESSH MAJICKS

/obj/machinery/computer/slot_machine/update_icon_state()
	if(machine_stat & BROKEN)
		icon_state = "slots_broken"
	else
		icon_state = "slots"
	return ..()

/obj/machinery/computer/slot_machine/update_overlays()
	if(working)
		icon_screen = "slots_screen_working"
	else
		icon_screen = "slots_screen"
	return ..()


/obj/machinery/computer/slot_machine/item_interaction(mob/living/user, obj/item/inserted, list/modifiers)
	if(istype(inserted, /obj/item/coin))
		var/obj/item/coin/inserted_coin = inserted
		if(paymode == COIN)
			if(prob(2))
				if(!user.transfer_item_to_turf(inserted_coin, drop_location(), silent = FALSE))
					return ITEM_INTERACT_BLOCKING
				inserted_coin.throw_at(user, 3, 10)
				if(prob(10))
					balance = max(balance - SPIN_PRICE, 0)
				to_chat(user, span_warning("[src]把你的硬币吐了出来！"))
				return ITEM_INTERACT_BLOCKING
			else
				if(!user.temporarilyRemoveItemFromInventory(inserted_coin))
					return ITEM_INTERACT_BLOCKING
				balloon_alert(user, "已投入硬币")
				balance += inserted_coin.value
				qdel(inserted_coin)
				return ITEM_INTERACT_SUCCESS
		else
			balloon_alert(user, "仅接受全息信用芯片！")
		return ITEM_INTERACT_BLOCKING

	if(istype(inserted, /obj/item/holochip))
		if(paymode == HOLOCHIP)
			var/obj/item/holochip/inserted_chip = inserted
			if(!user.temporarilyRemoveItemFromInventory(inserted_chip))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "已投入[inserted_chip.credits][MONEY_NAME_AUTOPURAL(inserted_chip.credits)]")
			balance += inserted_chip.credits
			qdel(inserted_chip)
			return ITEM_INTERACT_SUCCESS
		else
			balloon_alert(user, "仅接受硬币！")
		return ITEM_INTERACT_BLOCKING

	var/obj/item/card/id/id_card = inserted.GetID()
	if(isidcard(id_card))
		if(house_bank_account)
			say("已关联[house_bank_account.account_holder]的账户！")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
			return ITEM_INTERACT_BLOCKING

		var/datum/bank_account/id_bank_account = id_card.registered_account

		if(!id_bank_account)
			say("身份证上未检测到银行账户！")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
			return ITEM_INTERACT_BLOCKING

		if(!id_bank_account.has_money(PRIZE_SMALL))
			say("资金不足以支付可能产生的奖金，至少需要[PRIZE_SMALL]信用点！")
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
			return ITEM_INTERACT_BLOCKING

		var/msg = tgui_input_text(user, "输入老虎机名称（可选）", "老虎机定制", "老虎机", max_length = MAX_NAME_LEN)
		if(msg)
			name = msg

		playsound(src, 'sound/machines/terminal/terminal_success.ogg', 50, TRUE)
		desc = "归[id_bank_account.account_holder]所有，直接从其账户支取奖金。"
		house_bank_account = id_bank_account
		to_chat(user, span_notice("你将老虎机关联到了[id_bank_account.account_holder]的账户。"))
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/machinery/computer/slot_machine/multitool_act(mob/living/user, obj/item/tool)
	if(balance > 0)
		say("错误！更改支付方式前，请先清空机器余额。") //Prevents converting coins into holocredits and vice versa
		return ITEM_INTERACT_BLOCKING

	if(paymode == HOLOCHIP)
		paymode = COIN
		balloon_alert(user, "已切换为硬币支付")
	else
		paymode = HOLOCHIP
		balloon_alert(user, "已切换为全息信用芯片支付")
	return ITEM_INTERACT_SUCCESS

/obj/machinery/computer/slot_machine/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	var/datum/effect_system/basic/spark_spread/spark_system = new(src.loc, 4, 0)
	spark_system.start()
	playsound(src, SFX_SPARKS, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	balloon_alert(user, "机器已被做手脚")
	return TRUE

/obj/machinery/computer/slot_machine/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet_batched/slot_machines),
	)

/obj/machinery/computer/slot_machine/ui_interact(mob/living/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlotMachine", name)
		ui.open()

/obj/machinery/computer/slot_machine/ui_static_data(mob/user)
	var/list/data = list()
	data["symbols"] = symbol_data
	data["cost"] = SPIN_PRICE
	data["jackpot"] = PRIZE_JACKPOT
	data["jackpot_id"] = "[jackpot_path]"
	if(trap_path)
		data["trap_id"] = "[trap_path]"
	return data

/obj/machinery/computer/slot_machine/ui_data(mob/user)
	var/list/data = list()
	var/list/_reels = list()
	for(var/reel in reels)
		_reels += list(list(
			"symbols" = reel,
		))
	data["reels"] = _reels
	data["balance"] = balance
	data["working"] = working
	data["winning"] = winning
	data["money"] = money
	data["plays"] = plays
	data["jackpots"] = jackpots
	data["paymode"] = paymode
	return data


/obj/machinery/computer/slot_machine/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("spin")
			spin(ui.user)
			return TRUE
		if("payout")
			if(balance > 0)
				give_payout(balance)
				balance = 0
				return TRUE

/obj/machinery/computer/slot_machine/emp_act(severity)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN) || . & EMP_PROTECT_SELF)
		return
	if(prob(15 * severity))
		return
	if(prob(1)) // :^)
		obj_flags |= EMAGGED
	var/severity_ascending = 4 - severity
	money = max(rand(money - (200 * severity_ascending), money + (200 * severity_ascending)), 0)
	balance = max(rand(balance - (50 * severity_ascending), balance + (50 * severity_ascending)), 0)
	money -= max(0, give_payout(min(rand(-50, 100 * severity_ascending)), money)) //This starts at -50 because it shouldn't always dispense coins yo
	spin()

/// Returns TRUE if the owner has enough funds to payout
/obj/machinery/computer/slot_machine/proc/has_funds_to_pay(payout)
	if(!house_bank_account) // no owner so NT is paying
		return TRUE

	if(house_bank_account.has_money(payout))
		return TRUE

	say("[house_bank_account.account_holder]的银行账户余额不足以支付可能产生的奖金，请联系账户持有人补充资金，或降低赌注！")
	playsound(src, 'sound/machines/buzz/buzz-two.ogg', 30, TRUE)
	return FALSE

/obj/machinery/computer/slot_machine/proc/spin(mob/user)
	if(!can_spin(user))
		return

	if(!has_funds_to_pay(PRIZE_SMALL))
		return

	if(!use_energy(active_power_usage, force = FALSE))
		say("电量不足！")
		return

	var/the_name
	if(user)
		the_name = user.real_name
		visible_message(span_notice("[user]拉下了拉杆，老虎机开始转动！"))
		if(isliving(user))
			var/mob/living/living_user = user
			living_user.add_mood_event("slots_spin", /datum/mood_event/slots)
	else
		the_name = "埃克赛巴凯"

	balance -= SPIN_PRICE
	money += SPIN_PRICE

	if(house_bank_account)
		// Since big jackpots & free games aren't deducted directly from the account holder NT takes a 40% cut of profit
		// Also discourages infinite money exploits since people playing slot machines they own will cause them to slowly lose money
		house_bank_account.adjust_money(SPIN_PRICE * 0.60, "老虎机：投注")

	plays += 1
	working = TRUE

	update_appearance()

	// Play the lever pull sound and a reel spin sound after a short delay
	playsound(src, 'sound/machines/lever/lever_start.ogg', 50)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), src, 'sound/machines/roulette/roulettewheel.ogg', 20), 0.3 SECONDS)

	// Randomize reels to get the new final state.
	randomize_reels()

	// Now wait for a pre-determined delay to set machine to a non-spinning state.
	// On the UI side, result is pre-determined: after the delay below,
	// animation stops at the newly calculated state of the reels.
	addtimer(CALLBACK(src, PROC_REF(finish_spinning), user, the_name), SPIN_TIME)

/obj/machinery/computer/slot_machine/proc/finish_spinning(mob/user, the_name)
	working = FALSE
	give_prizes(the_name, user)
	update_appearance()

/// Check if the machine can be spun
/obj/machinery/computer/slot_machine/proc/can_spin(mob/user)
	if(machine_stat & NOPOWER)
		balloon_alert(user, "没有电力！")
		return FALSE
	if(machine_stat & BROKEN)
		balloon_alert(user, "机器已损坏！")
		return FALSE
	if(working)
		balloon_alert(user, "已经在转动了！")
		return FALSE
	if(balance < SPIN_PRICE)
		balloon_alert(user, "余额不足！")
		return FALSE
	return TRUE

/// Randomize the states of all reels
/obj/machinery/computer/slot_machine/proc/randomize_reels()
	for(var/list/reel in reels)
		reel[1] = "[pick(symbol_paths)]"
		reel[2] = "[pick(symbol_paths)]"
		reel[3] = "[pick(symbol_paths)]"

/// Triggers a negative effect for a slot machine if all trap icons are lined up in the middle
/obj/machinery/computer/slot_machine/proc/activate_trap(mob/living/user)
	say("超级大输家！准备领取你的特别奖品吧！")

	switch(trap_path)
		if(/obj/item/restraints/handcuffs)
			if(iscarbon(user))
				var/mob/living/carbon/carbon_user = user
				playsound(loc, 'sound/items/weapons/handcuffs.ogg', 30, TRUE, -2)
				carbon_user.set_handcuffed(new /obj/item/restraints/handcuffs(user))
		if(/obj/item/suspiciousphone)
			playsound(loc,  'sound/items/dump_it.ogg', 30, TRUE, -2)
			balance = 0
		if(/obj/singularity)
			user.electrocute_act(80, src, flags = SHOCK_ILLUSION | SHOCK_NOGLOVES)
		else // gibonite, syndicate bombs, flashbangs, etc.
			var/obj/item/grenade/flashbang/bang = new(get_turf(src))
			bang.arm_grenade(null, 1 SECONDS)

/// Checks if any prizes have been won, and pays them out
/obj/machinery/computer/slot_machine/proc/give_prizes(usrname, mob/living/user)
	var/linelength = get_lines()
	var/did_player_win = TRUE

	if(trap_path && check_middle_row_all(trap_path))
		activate_trap(user)

	else if(check_middle_row_all(jackpot_path))
		winning = WINNING_JACKPOT
		var/prize = money + PRIZE_JACKPOT
		say("头奖！你赢得了[prize][MONEY_NAME]！")
		priority_announce("恭喜[user ? user.real_name : usrname]在[chinese_area_display(get_area_name(src))]的老虎机上赢得头奖！")
		user.add_mood_event(SLOTS_MOOD_CATEGORY, /datum/mood_event/slots/win/jackpot)
		add_memory_in_range(user, 7, /datum/memory/won_jackpot, protagonist = user, deuteragonist = src)
		jackpots += 1
		money = 0
		if(paymode == HOLOCHIP)
			new /obj/item/holochip(loc, prize)
		else
			for(var/i in 1 to 5)
				cointype = pick(subtypesof(/obj/item/coin))
				var/obj/item/coin/payout_coin = new cointype(loc)
				random_step(payout_coin, 2, 50)
				playsound(src, pick(list('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg')), 50, TRUE)
				sleep(REEL_DEACTIVATE_DELAY)

	else if(linelength == 5)
		winning = WINNING_BIG
		say("大赢家！你赢得了一千[MONEY_NAME]！")
		give_money(PRIZE_BIG)
		user.add_mood_event(SLOTS_MOOD_CATEGORY, /datum/mood_event/slots/win/big)

	else if(linelength == 4)
		winning = WINNING_SMALL
		say("获胜！你赢得了四百[MONEY_NAME]！")
		give_money(PRIZE_SMALL)
		user.add_mood_event(SLOTS_MOOD_CATEGORY, /datum/mood_event/slots/win)

	else if(linelength == 3)
		winning = WINNING_FREESPIN
		balloon_alert(user, "赢得3次免费游玩！")
		balance += SPIN_PRICE * 4
		money = max(money - SPIN_PRICE * 4, money)

	else
		winning = WINNING_NOTHING
		balloon_alert(user, "运气欠佳！")
		did_player_win = FALSE
		user.add_mood_event(SLOTS_MOOD_CATEGORY, /datum/mood_event/slots/loss)

	playsound(src, 'sound/machines/lever/lever_stop.ogg', 50)

	SStgui.update_uis(src)
	addtimer(CALLBACK(src, PROC_REF(clear_winning)), 3 SECONDS)

	if(did_player_win)
		add_filter("jackpot_rays", 3, ray_filter)
		animate(get_filter("jackpot_rays"), offset = 10, time = 3 SECONDS, loop = -1)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/datum, remove_filter), "jackpot_rays"), 3 SECONDS)
		playsound(src, 'sound/machines/roulette/roulettejackpot.ogg', 50, TRUE)

/obj/machinery/computer/slot_machine/proc/clear_winning()
	winning = WINNING_NOTHING

/// Checks for a jackpot (5 matching symbols in the middle row) for the given symbol typepath
/obj/machinery/computer/slot_machine/proc/check_middle_row_all(symbol_path)
	var/symbol_id = "[symbol_path]"
	for(var/list/reel in reels)
		if(reel[2] != symbol_id)
			return FALSE
	return TRUE

/// Finds the largest number of consecutive matching icons in a row
/obj/machinery/computer/slot_machine/proc/get_lines()
	var/amountthesame = 0

	for(var/row in 1 to 3)
		var/current_symbol = null
		var/current_run = 0

		for(var/list/reel in reels)
			var/symbol = reel[row]
			if(symbol == current_symbol)
				current_run++
			else
				current_symbol = symbol
				current_run = 1
			if(current_run >= 3)
				amountthesame = max(amountthesame, current_run)

	return amountthesame

/// Give the specified amount of money. If the amount is greater than the amount of prize money available, add the difference as balance
/obj/machinery/computer/slot_machine/proc/give_money(amount)
	var/amount_to_give = min(amount, money)
	var/surplus = amount - give_payout(amount_to_give)
	money -= amount_to_give
	balance += surplus

	if(house_bank_account)
		house_bank_account.adjust_money(-amount_to_give, "老虎机：派彩")

/// Pay out the specified amount in either coins or holochips
/obj/machinery/computer/slot_machine/proc/give_payout(amount)
	if(paymode == HOLOCHIP)
		cointype = /obj/item/holochip
	else
		cointype = obj_flags & EMAGGED ? /obj/item/coin/iron : /obj/item/coin/silver

	if(!(obj_flags & EMAGGED))
		amount = dispense(amount, cointype, null, 0)

	else
		var/mob/living/target = locate() in range(2, src)

		amount = dispense(amount, cointype, target, 1)

	return amount

/// Dispense the given amount. If machine is set to use coins, will use the specified coin type.
/// If throwit and target are set, will launch the payment at the target
/obj/machinery/computer/slot_machine/proc/dispense(amount = 0, cointype = /obj/item/coin/silver, throwit = FALSE, mob/living/target)
	if(paymode == HOLOCHIP)
		var/obj/item/holochip/chip = new /obj/item/holochip(loc,amount)

		if(throwit && target)
			chip.throw_at(target, 3, 10)
	else
		var/value = coinvalues["[cointype]"]
		if(value <= 0)
			CRASH("Coin value of zero, refusing to payout in dispenser")
		while(amount >= value)
			var/obj/item/coin/thrown_coin = new cointype(loc) //DOUBLE THE PAIN
			amount -= value
			if(throwit && target)
				thrown_coin.throw_at(target, 3, 10)
			else
				random_step(thrown_coin, 2, 40)

	playsound(src, pick(list('sound/machines/coindrop.ogg', 'sound/machines/coindrop2.ogg')), 50, TRUE)
	return amount

/obj/machinery/computer/slot_machine/command
	name = "指挥部老虎机"
	desc = "拉杆由纯金制成，屏幕则用劳累过度的助理们的眼泪擦得锃亮。"
	symbol_paths = list(
		/obj/item/disk/nuclear,
		/obj/item/clothing/accessory/medal/gold,
		/obj/item/hand_tele,
		/mob/living/basic/pet/dog/corgi,
		/obj/item/card/id/advanced/gold,
		/obj/item/melee/sabre,
		/obj/item/grenade/syndieminibomb
	)
	jackpot_path = /obj/item/clothing/accessory/medal/gold
	trap_path = /obj/item/grenade/syndieminibomb

/obj/machinery/computer/slot_machine/command/Initialize(mapload)
	slot_adjectives += list("皇家", "帝王", "黄金", "舰长的", "荣耀")
	slot_nouns += list("勋章", "赎金", "权威", "指挥")
	. = ..()

/obj/machinery/computer/slot_machine/security
	name = "安保老虎机"
	desc = "从查获的辛迪加赌窝中没收后改装而来。输钱是犯罪，赢钱也是犯罪。"
	symbol_paths = list(
		/obj/item/food/donut/berry,
		/mob/living/basic/bot/secbot/beepsky,
		/obj/item/melee/baton/security/loaded,
		/obj/item/gun/energy/disabler,
		/obj/vehicle/sealed/mecha/ripley/paddy,
		/obj/item/book/manual/wiki/security_space_law,
		/obj/item/grown/bananapeel
	)
	jackpot_path = /obj/item/food/donut/berry
	trap_path = /obj/item/grown/bananapeel

/obj/machinery/computer/slot_machine/security/Initialize(mapload)
	slot_adjectives += list("眩晕", "闪光", "没收", "忠诚", "逮捕")
	slot_nouns += list("警棍", "甜甜圈", "违禁品", "禁闭室", "安保")
	. = ..()

/obj/machinery/computer/slot_machine/medical
	name = "医疗老虎机"
	desc = "现代医学的奇迹！能治愈无聊，却会引发急性财务坏死。"
	symbol_paths = list(
		/obj/item/storage/medkit/brute,
		/obj/vehicle/sealed/mecha/odysseus,
		/obj/item/clothing/glasses/hud/health,
		/mob/living/basic/pet/cat/runtime,
		/obj/item/plunger,
		/obj/item/clothing/neck/stethoscope,
		/obj/machinery/syndicatebomb,
	)
	jackpot_path = /obj/item/clothing/neck/stethoscope
	trap_path = /obj/machinery/syndicatebomb

/obj/machinery/computer/slot_machine/medical/Initialize(mapload)
	slot_adjectives += list("突变", "过量", "传染", "治愈", "焦尸")
	slot_nouns += list("急救箱", "除颤器", "病人", "医生", "疗法")
	. = ..()

/obj/machinery/computer/slot_machine/engineering
	name = "工程老虎机"
	desc = "专供那些以为戴上绝缘手套就天下无敌的人赌博。游玩前请先接地。"
	symbol_paths = list(
		/obj/item/storage/toolbox/mechanical,
		/obj/item/blueprints,
		/obj/item/clothing/gloves/color/yellow,
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/glasses/meson,
		/mob/living/basic/parrot/poly,
		/obj/singularity,
	)
	jackpot_path = /obj/item/blueprints
	trap_path = /obj/singularity

/obj/machinery/computer/slot_machine/engineering/Initialize(mapload)
	slot_adjectives += list("超级充能", "加压", "放射性", "过载", "崩解", "绝缘")
	slot_nouns += list("工具箱", "发射器", "超物质")
	. = ..()

/obj/machinery/computer/slot_machine/cargo
	name = "货运老虎机"
	desc = "每在这里花掉一个信用点，就少一个信用点浪费在食物或药品之类的“无用”东西上。"
	symbol_paths = list(
		/obj/item/bounty_cube,
		/obj/item/clipboard,
		/obj/item/universal_scanner,
		/mob/living/basic/sloth,
		/obj/item/multitool,
		/obj/vehicle/sealed/mecha/ripley,
		/obj/item/suspiciousphone,
	)
	jackpot_path = /obj/item/bounty_cube
	trap_path = /obj/item/suspiciousphone

/obj/machinery/computer/slot_machine/cargo/Initialize(mapload)
	slot_adjectives += list("速递", "走私", "赃物", "逾期", "补贴", "列单")
	slot_nouns += list("赏金", "货箱", "清单", "骡子机器人", "利润")
	. = ..()

/obj/machinery/computer/slot_machine/service
	name = "服务老虎机"
	desc = "拉杆由擀面杖改装而成。每一次输局都是今日特餐的又一份食材。"
	symbol_paths = list(
		/obj/item/clothing/head/hats/tophat,
		/obj/item/reagent_containers/cup/watering_can,
		/obj/item/clothing/shoes/galoshes,
		/mob/living/basic/goat/pete,
		/obj/item/book/bible,
		/obj/item/kitchen/rollingpin,
		/obj/item/seeds/random,
	)
	jackpot_path = /obj/item/seeds/random
	trap_path = /mob/living/basic/goat/pete

/obj/machinery/computer/slot_machine/service/Initialize(mapload)
	slot_adjectives += list("发酵", "调味", "微醺", "洁净", "有机", "烹饪", "清爽", "神赐", "神圣")
	slot_nouns += list("食谱", "鸡尾酒", "丰收", "洗涤器")
	. = ..()

/obj/machinery/computer/slot_machine/science
	name = "科研老虎机"
	desc = "滚轴似乎同时存在于多个维度中。每个维度里的它都照样会吞掉你的钱。"
	symbol_paths = list(
		/obj/item/stack/sheet/mineral/gold,
		/obj/item/stack/sheet/mineral/silver,
		/obj/item/stack/sheet/mineral/uranium,
		/obj/item/stack/sheet/mineral/plasma,
		/obj/item/stack/sheet/mineral/runite,
		/obj/item/clothing/mask/facehugger/lamarr,
		/obj/item/gibtonite,
	)
	jackpot_path = /obj/item/stack/sheet/mineral/runite
	trap_path = /obj/item/gibtonite

/obj/machinery/computer/slot_machine/science/Initialize(mapload)
	slot_adjectives += list("原子", "蓝空间", "宇宙", "黄金", "钻石", "白银", "铀", "量子", "异常", "等离子", "实验", "机械")
	slot_nouns += list("异常", "遗物", "史莱姆", "提取物", "电路", "发现", "爆炸")
	. = ..()

/obj/machinery/computer/slot_machine/clown
	desc = "赌博真有趣！散发着香蕉、湿鞋和悔恨的气味。HONK！"
	symbol_paths = list(
		/obj/item/food/grown/banana,
		/obj/item/toy/crayon/spraycan/lubecan,
		/obj/item/card/id/advanced/rainbow,
		/obj/vehicle/sealed/mecha/honker,
		/obj/item/clothing/mask/gas/clown_hat,
		/obj/item/storage/backpack/clown,
		/obj/item/restraints/handcuffs,
	)
	jackpot_path = /obj/vehicle/sealed/mecha/honker
	trap_path = /obj/item/restraints/handcuffs

/obj/machinery/computer/slot_machine/clown/Initialize(mapload)
	slot_adjectives += list("喇叭", "滑溜", "恶作剧", "吱呀", "爆笑", "窃笑")
	slot_nouns += list("香蕉", "果皮", "整蛊", "笑话", "笑点", "糖果", "HONK")
	. = ..()

/obj/machinery/computer/slot_machine/mime
	desc = "赌博是一场无声的悲剧。这台机器冷漠地回望着你。"
	symbol_paths = list(
		/obj/item/book/granter/action/spell/mime/mimery,
		/obj/item/clothing/mask/gas/mime,
		/obj/item/toy/crayon/spraycan/mimecan,
		/obj/item/reagent_containers/cup/glass/bottle/bottleofnothing,
		/obj/item/clothing/gloves/color/white,
		/obj/item/storage/backpack/mime,
		/obj/item/restraints/handcuffs,
	)
	jackpot_path = /obj/item/book/granter/action/spell/mime/mimery
	trap_path = /obj/item/restraints/handcuffs

/obj/machinery/computer/slot_machine/mime/Initialize(mapload)
	slot_adjectives += list("无声", "透明", "不可言说", "失语", "安静", "寂静", "隐形", "想象", "空虚")
	slot_nouns += list("沉默", "哑剧", "内向者", "虚无", "法棍")
	. = ..()

/obj/machinery/computer/slot_machine/syndicate
	name = "辛迪加老虎机"
	desc = "专供已经输掉一切的特工赌博。纳米传讯去死，你的钱包也去死。"
	symbol_paths = list(
		/obj/machinery/nuclearbomb,
		/obj/item/card/emag,
		/obj/item/storage/toolbox/syndicate,
		/obj/vehicle/sealed/mecha/gygax/dark,
		/obj/item/soap/syndie,
		/obj/item/gun/energy/recharge/ebow,
		/obj/item/restraints/handcuffs,
	)
	jackpot_path = /obj/machinery/nuclearbomb
	trap_path = /obj/item/restraints/handcuffs

/obj/machinery/computer/slot_machine/syndicate/Initialize(mapload)
	slot_adjectives += list("隐秘", "核能", "可疑", "血腥", "辛迪", "破坏", "秘密", "非法", "叛逆")
	slot_nouns += list("传送水晶", "上行链路", "炸弹", "特工", "磁盘", "核弹", "辛迪加", "叛徒")
	. = ..()

#undef SPIN_PRICE
#undef WINNING_NOTHING
#undef WINNING_FREESPIN
#undef WINNING_SMALL
#undef WINNING_BIG
#undef WINNING_JACKPOT
#undef PRIZE_SMALL
#undef PRIZE_BIG
#undef PRIZE_JACKPOT
#undef SPIN_TIME
#undef REEL_DEACTIVATE_DELAY
#undef HOLOCHIP
#undef COIN
