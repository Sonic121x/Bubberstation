/obj/item/kinky_shocker
	name = "情趣电击器"
	desc = "能对人施加轻微电击的小玩具。"
	icon_state = "shocker_off"
	base_icon_state = "shocker"
	inhand_icon_state = "shocker_off"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	/// If the shocker is on or not
	var/shocker_on = FALSE
	/// Typecasted var that holds the cell placed in the shocker
	var/obj/item/stock_parts/power_store/cell/cell
	/// A type of what cell should be put in the shocker on initialize
	var/preload_cell_type = /obj/item/stock_parts/power_store/cell
	/// What it should cost the cell to use the shocker once
	var/cell_hit_cost = STANDARD_CELL_CHARGE * 0.015
	/// If the user should be able to remove the cell or not
	var/can_remove_cell = TRUE
	/// The custom part of the string that is displayed on activation of the shocker
	var/activate_sound = "sparks"

/obj/item/kinky_shocker/get_cell()
	return cell

/obj/item/kinky_shocker/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	if(!preload_cell_type)
		return
	if(!ispath(preload_cell_type, /obj/item/stock_parts/power_store/cell))
		log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
	else
		cell = new preload_cell_type(src)
/// Deduct an amount of charge from the cell
/obj/item/kinky_shocker/proc/deductcharge(chrgdeductamt)
	if(!cell)
		return
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not
	. = cell.use(chrgdeductamt)
	if(shocker_on && cell.charge < cell_hit_cost)
		//we're below minimum, turn off
		shocker_on = FALSE
		update_appearance()
		conditional_pref_sound(src, activate_sound, 75, TRUE, -1)

/obj/item/kinky_shocker/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("[src] 的剩余电量为 [round(cell.percent())]%。")
	else
		. += span_warning("[src] 尚未安装电源。")

/obj/item/kinky_shocker/attackby(obj/item/stock_parts/power_store/cell/powercell, mob/user, params)
	if(!istype(powercell))
		return ..()
	if(cell)
		to_chat(user, span_warning("[src] 已经装有电池！"))
	else
		if(powercell.maxcharge < cell_hit_cost)
			to_chat(user, span_notice("[src] 需要容量更大的电池。"))
			return
		if(!user.transferItemToLoc(powercell, src))
			return
		cell = powercell
		to_chat(user, span_notice("你给 [src] 装入了电池。"))
		update_appearance()

/obj/item/kinky_shocker/click_alt(mob/user)
	tryremovecell(user)
	return CLICK_ACTION_SUCCESS

/obj/item/kinky_shocker/proc/tryremovecell(mob/user)
	if(!(cell && can_remove_cell))
		return
	cell.update_appearance()
	cell.forceMove(get_turf(src))
	cell = null
	to_chat(user, span_notice("你取出了 [src] 的电池。"))
	shocker_on = FALSE
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/kinky_shocker/attack_self(mob/user)
	toggle_shocker(user)

/obj/item/kinky_shocker/proc/toggle_shocker(mob/user)
	if(cell && cell.charge >= cell_hit_cost)
		shocker_on = !shocker_on
		to_chat(user, span_notice("你[shocker_on? "打开了电击器。嗡！" : "关闭了电击器。"]"))
		conditional_pref_sound(user, shocker_on ? 'sound/items/weapons/magin.ogg' : 'sound/items/weapons/magout.ogg', 40, TRUE)
	else
		shocker_on = FALSE
		if(!cell)
			to_chat(user, span_warning("[src] 没有电源！"))
		else
			to_chat(user, span_warning("[src] 没电了。"))
	update_appearance()
	add_fingerprint(user)

/obj/item/kinky_shocker/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[shocker_on? "on" : "off"]"
	inhand_icon_state = "[base_icon_state]_[shocker_on? "on" : "off"]"

/obj/item/kinky_shocker/attack(mob/living/target, mob/living/user)
	. = ..()
	if(target.stat == DEAD)
		return

	var/mob/living/carbon/human/carbon_target
	if(ishuman(target))
		carbon_target = target
	else if(!iscyborg(target))
		return

	if(!shocker_on)
		to_chat(user, span_danger("必须先开启 [src] 才能使用！"))
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] 不愿意让你这么做。"))
		return

	var/message = ""
	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/genital/vagina = target.get_organ_slot(ORGAN_SLOT_VAGINA)
			var/penis_message = (user == target) ? pick("把 [src] 抵在自己的阴茎上，任其电击。好痛……",
					"用 [src] 电击自己的阴茎") \
				: pick("用 [src] 电击 [target] 的阴茎",
					"拿 [src] 电击 [target] 的阴茎",
					"把 [src] 抵在 [target] 的阴茎上并开启")

			var/vagina_message = (user == target) ? pick("把 [src] 抵在自己的阴道上，任其电击。好痛……",
					"用 [src] 电击自己的阴部") \
				: pick("用 [src] 电击 [target] 的阴道",
					"用 [src] 电击 [target] 的阴部",
					"把 [src] 抵在 [target] 的阴道上并开启")

			if(penis?.is_exposed() && vagina?.is_exposed())
				message = pick(penis_message, vagina_message)
			else if(vagina?.is_exposed())
				message = vagina_message
			else if(penis?.is_exposed())
				message = penis_message
			else if(carbon_target?.is_bottomless())
				message = (user == target) ? pick("把 [src] 抵在自己的腹部，任其电击。好痛……",
						"用 [src] 电击自己的肚子") \
					: pick("用 [src] 电击 [target] 的腹部",
						"用 [src] 电击 [target] 的肚子",
						"把 [src] 抵在 [target] 的腹部并开启")
			else if(iscyborg(target))
				message = (user == target) ? pick("把 [src] 抵在自己的合成生殖器上，任其电击。好痛……",
						"用 [src] 电击自己的肚子") \
					: pick("用 [src] 电击 [target] 的合成生殖器",
						"用 [src] 电击 [target] 的肚子",
						"把 [src] 抵在 [target] 的合成生殖器上并开启")
			else
				to_chat(user, span_danger("[target] 的胯部似乎被遮住了！"))
				return

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/genital/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.is_exposed())
				message = (user == target) ? pick("把 [src] 抵在自己的乳房上，任其电击",
						"用 [src] 电击自己的乳房") \
					: pick("用 [src] 电击 [target] 的乳房",
						"用 [src] 电击 [target] 的乳头",
						"把 [src] 抵在 [target] 的乳房上并开启")
			else if(carbon_target?.is_topless() || iscyborg(target))
				message = (user == target) ? pick("把 [src] 抵在自己的胸部，任其电击",
						"用 [src] 电击自己的乳头") \
					: pick("用 [src] 电击 [target] 的胸部",
						"用 [src] 电击 [target] 的乳头",
						"把 [src] 抵在 [target] 的胸部并开启")
			else
				to_chat(user, span_danger("[target] 的胸部似乎被遮住了！"))
				return

		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			if(carbon_target && !carbon_target.has_arms())
				to_chat(user, span_danger("[target] 似乎没有手臂！"))
				return
			if(carbon_target && !carbon_target.is_hands_uncovered())
				to_chat(user, span_danger("[target] 的手臂似乎被遮住了！"))
				return
			var/arm = user.zone_selected == BODY_ZONE_L_ARM ? "左臂" : "右臂"
			message = (user == target) ? pick("把 [src] 抵在自己的[arm]上，任其电击",
					"用 [src] 电击自己的手臂") \
				: pick("用 [src] 电击 [target] 的[arm]",
					"拿 [src] 电击 [target] 的[arm]",
					"把 [src] 抵在 [target] 的[arm]上并开启")

		if(BODY_ZONE_HEAD)
			if(carbon_target && !carbon_target.is_head_uncovered())
				to_chat(user, span_danger("[target] 的头部似乎被遮住了！"))
				return
			message = (user == target) ? pick("把 [src] 抵在自己的头上，任其电击。好痛！为什么要这么做？！",
					"用 [src] 电击自己的头部") \
				: pick("用 [src] 电击 [target] 的头部",
					"用 [src] 电击 [target] 的脖子",
					"把 [src] 抵在 [target] 的脖子上并开启")

		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(carbon_target && !carbon_target.has_feet())
				to_chat(user, span_danger("[target] 似乎没有腿！"))
				return
			if(carbon_target && !carbon_target.is_barefoot())
				to_chat(user, span_danger("[target] 的脚趾似乎被遮住了！"))
				return
			var/leg = user.zone_selected == BODY_ZONE_L_LEG ? "左腿" : "右腿"
			message = (user == target) ? pick("把 [src] 抵在自己的[leg]上，任其电击",
					"用 [src] 电击自己的腿") \
				: pick("用 [src] 电击 [target] 的[leg]",
					"用 [src] 电击 [target] 的[user.zone_selected == BODY_ZONE_L_LEG ? "左脚" : "右脚"]",
					"把 [src] 抵在 [target] 的[leg]上并开启")
		else
			to_chat(user, span_danger("你不能电击 [target] 的那个部位！"))
			return

	user.visible_message(span_purple("[user] [message]!"))
	conditional_pref_sound(loc, 'sound/items/weapons/taserhit.ogg', 70, 1, -1)
	deductcharge(cell_hit_cost)
	if(prob(80))
		target.try_lewd_autoemote(pick("twitch", "twitch_s", "shiver", "scream"))
	target.do_jitter_animation()
	target.adjust_stamina_loss(3)
	target.adjust_pain(9)
	target.adjust_stutter(30 SECONDS)
