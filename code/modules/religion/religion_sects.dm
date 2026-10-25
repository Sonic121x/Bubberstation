/**
 * # Religious Sects
 *
 * Religious Sects are a way to convert the fun of having an active 'god' (admin) to code-mechanics so you aren't having to press adminwho.
 *
 * Sects are not meant to overwrite the fun of choosing a custom god/religion, but meant to enhance it.
 * The idea is that Space Jesus (or whoever you worship) can be an evil bloodgod who takes the lifeforce out of people, a nature lover, or all things righteous and good. You decide!
 *
 */
/datum/religion_sect
	/// Name of the religious sect
	var/name = "宗教教派基础类型"
	/// Flavorful quote given about the sect, used in tgui
	var/quote = "向程序员巴士致敬！程序员巴士第一！去他妈的玩家群体！"
	/// Opening message when someone gets converted
	var/desc = "哦天哪！这到底是什么？！？！？！？"
	/// Tgui icon used by this sect - https://fontawesome.com/icons/
	var/tgui_icon = "bug"
	/// holder for alignments.
	var/alignment = ALIGNMENT_GOOD
	/// Does this require something before being available as an option?
	var/starter = TRUE
	/// The Sect's 'Mana'
	var/favor = 0 //MANA!
	/// The max amount of favor the sect can have
	var/max_favor = 1000
	/// The default value for an item that can be sacrificed
	var/default_item_favor = 5
	/// Turns into 'desired_items_typecache', and is optionally assoc'd to sacrifice instructions if needed.
	var/list/desired_items
	/// Autopopulated by `desired_items`
	var/list/desired_items_typecache
	/// Lists of rites by type. Converts itself into a list of rites with "name - desc (favor_cost)" = type
	var/list/rites_list = list()
	/// Changes the Altar of Gods icon
	var/altar_icon
	/// Changes the Altar of Gods icon_state
	var/altar_icon_state
	/// Changes the Altar of Gods emissive overlay icon_state
	var/altar_emissive_icon_state
	/// Currently Active (non-deleted) rites
	var/list/active_rites
	/// Chance that we fail a bible blessing.
	var/smack_chance = DEFAULT_SMACK_CHANCE
	/// Whether the structure has CANDLE OVERLAYS!
	var/candle_overlay = TRUE

/datum/religion_sect/New()
	. = ..()
	if(desired_items)
		desired_items_typecache = typecacheof(desired_items)
	if(!locate(/datum/religion_rites/deaconize) in rites_list)
		rites_list += list(/datum/religion_rites/deaconize)
	on_select()

/// Activates once selected
/datum/religion_sect/proc/on_select()
	SHOULD_CALL_PARENT(TRUE)
	SSblackbox.record_feedback("text", "sect_chosen", 1, name)

/// Activates once selected and on newjoins, oriented around people who become holy.
/datum/religion_sect/proc/on_conversion(mob/living/chap)
	SHOULD_CALL_PARENT(TRUE)
	to_chat(chap, span_boldnotice("\"[quote]\""))
	to_chat(chap, span_notice("[desc]"))
	chap.add_faction(FACTION_HOLY)

/// Activates if religious sect is reset by admins, should clean up anything you added on conversion.
/datum/religion_sect/proc/on_deconversion(mob/living/chap)
	SHOULD_CALL_PARENT(TRUE)
	to_chat(chap, span_boldnotice("你已失去\the [name] 的认可。"))
	if(chap.mind.holy_role == HOLY_ROLE_HIGHPRIEST)
		to_chat(chap, span_notice("回到祭坛重建你的教派。"))
	chap.remove_faction(FACTION_HOLY)

/// Returns TRUE if the item can be sacrificed. Can be modified to fit item being tested as well as person offering. Returning TRUE will stop the attackby sequence and proceed to on_sacrifice.
/datum/religion_sect/proc/can_sacrifice(obj/item/sacrifice, mob/living/chap)
	. = TRUE
	if(chap.mind.holy_role == HOLY_ROLE_DEACON)
		to_chat(chap, span_warning("你只是 [GLOB.deity] 的一名执事，因此无法主持仪式。"))
		return
	if(!is_type_in_typecache(sacrifice, desired_items_typecache))
		return FALSE

/// Activates when the sect sacrifices an item. This proc has NO bearing on the attackby sequence of other objects when used in conjunction with the religious_tool component.
/datum/religion_sect/proc/on_sacrifice(obj/item/sacrifice, mob/living/chap)
	return adjust_favor(default_item_favor, chap)

/// Returns a description for religious tools
/datum/religion_sect/proc/tool_examine(mob/living/holy_creature)
	return "你目前拥有 [round(favor)] 点 [GLOB.deity] 的恩宠。"

/// Adjust Favor by a certain amount. Can provide optional features based on a user. Returns actual amount added/removed
/datum/religion_sect/proc/adjust_favor(amount = 0, mob/living/chap)
	. = amount
	if(favor + amount < 0)
		. = favor //if favor = 5 and we want to subtract 10, we'll only be able to subtract 5
	if((favor + amount > max_favor))
		. = (max_favor-favor) //if favor = 5 and we want to add 10 with a max of 10, we'll only be able to add 5
	favor = clamp(0, max_favor, favor+amount)

/// Sets favor to a specific amount. Can provide optional features based on a user.
/datum/religion_sect/proc/set_favor(amount = 0, mob/living/chap)
	favor = clamp(0,max_favor,amount)
	return favor

/// Activates when an individual uses a rite. Can provide different/additional benefits depending on the user.
/datum/religion_sect/proc/on_riteuse(mob/living/user, atom/religious_tool)

/// Replaces the bible's bless mechanic. Return TRUE if you want to not do the brain hit.
/datum/religion_sect/proc/sect_bless(mob/living/target, mob/living/chap)
	if(!ishuman(target))
		return BLESSING_FAILED

	var/mob/living/carbon/human/blessed = target
	for(var/obj/item/bodypart/bodypart as anything in blessed.get_bodyparts())
		if(IS_ROBOTIC_LIMB(bodypart))
			to_chat(chap, span_warning("[GLOB.deity] 拒绝治疗这具金属污秽之物！"))
			return BLESSING_IGNORED

	return standard_bless_healing(blessed, chap)

/datum/religion_sect/proc/standard_bless_healing(mob/living/carbon/human/blessed, mob/living/chap)
	if(!ishuman(blessed))
		blessed.adjust_brute_loss(-10)
		blessed.adjust_fire_loss(-10)
		return BLESSING_SUCCESS

	var/heal_amt = 10
	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1, BODYTYPE_ORGANIC)

	if(!length(hurt_limbs))
		return BLESSING_IGNORED

	for(var/obj/item/bodypart/affecting as anything in hurt_limbs)
		if(affecting.heal_damage(heal_amt, heal_amt, required_bodytype = BODYTYPE_ORGANIC))
			blessed.update_damage_overlays()

	blessed.visible_message(span_notice("[chap] 借 [GLOB.deity] 之力治疗了 [blessed]！"))
	to_chat(blessed, span_boldnotice("愿 [GLOB.deity] 的力量促使你痊愈！"))
	playsound(chap, SFX_PUNCH, 25, TRUE, -1)
	blessed.add_mood_event("blessing", /datum/mood_event/blessing)
	return BLESSING_SUCCESS

/// What happens if we bless a corpse? By default just do the default smack behavior
/datum/religion_sect/proc/sect_dead_bless(mob/living/target, mob/living/chap)
	return FALSE

/**** Nanotrasen Approved God ****/

/datum/religion_sect/puritanism
	name = "纳米传讯认可之神"
	desc = "中规中矩的教派，没有任何额外好处或恩赐。"
	quote = "纳米传讯推荐！"
	tgui_icon = "bible"

/**** Mechanical God ****/

/datum/religion_sect/mechanical
	name = "机械之神"
	quote = "愿你在金属外壳中找到安宁。"
	desc = "圣经现在能为半机械人充能，并在瞄准时治疗机械肢体，但\
	无法治疗有机肢体。你现在可以献祭电池，获得的恩宠取决于其电量。"
	tgui_icon = "robot"
	alignment = ALIGNMENT_NEUT
	desired_items = list(/obj/item/stock_parts/power_store = "带有电池电量")
	rites_list = list(/datum/religion_rites/synthconversion, /datum/religion_rites/machine_blessing)
	altar_icon_state = "convertaltar-blue"
	max_favor = 2500

/datum/religion_sect/mechanical/sect_bless(mob/living/target, mob/living/chap)
	if(iscyborg(target))
		var/mob/living/silicon/robot/R = target
		var/charge_amount = 0.05 * STANDARD_CELL_CHARGE
		if(target.mind?.holy_role == HOLY_ROLE_HIGHPRIEST)
			charge_amount *= 2
		R.cell?.charge += charge_amount
		R.visible_message(span_notice("[chap] 借 [GLOB.deity] 之力为 [R] 充能！"))
		to_chat(R, span_boldnotice("你被 [GLOB.deity] 的力量充能了！"))
		R.add_mood_event("blessing", /datum/mood_event/blessing)
		playsound(chap, 'sound/effects/bang.ogg', 25, TRUE, -1)
		return BLESSING_SUCCESS

	if(!ishuman(target))
		return BLESSING_FAILED

	var/mob/living/carbon/human/blessed = target

	//first we determine if we can charge them
	var/did_we_charge = FALSE
	var/obj/item/organ/stomach/ethereal/eth_stomach = blessed.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(eth_stomach))
		eth_stomach.adjust_charge(0.06 * STANDARD_CELL_CHARGE)
		did_we_charge = TRUE

	//if we're not targeting a robot part we stop early
	var/obj/item/bodypart/bodypart = blessed.get_bodypart(chap.zone_selected)
	if(IS_ORGANIC_LIMB(bodypart))
		if(!did_we_charge)
			to_chat(chap, span_warning("[GLOB.deity] 对治疗这种血肉之物嗤之以鼻！"))
			return BLESSING_IGNORED

		blessed.visible_message(span_notice("[chap] 借 [GLOB.deity] 之力为 [blessed] 充能！"))
		to_chat(blessed, span_boldnotice("你感到被 [GLOB.deity] 的力量充能了！"))
		blessed.add_mood_event("blessing", /datum/mood_event/blessing)
		playsound(chap, 'sound/machines/synth/synth_yes.ogg', 25, TRUE, -1)
		return BLESSING_SUCCESS

	//charge(?) and go
	if(bodypart.heal_damage(5,5,BODYTYPE_ROBOTIC))
		blessed.update_damage_overlays()

	blessed.visible_message(span_notice("[chap] 借 [GLOB.deity] 之力[did_we_charge ? "修理并充能" : "修理"]了 [blessed]！"))
	to_chat(blessed, span_boldnotice("[GLOB.deity] 的内在机关[did_we_charge ? "修理并充能" : "修理"]了你！"))
	playsound(chap, 'sound/effects/bang.ogg', 25, TRUE, -1)
	blessed.add_mood_event("blessing", /datum/mood_event/blessing)
	return BLESSING_SUCCESS

/datum/religion_sect/mechanical/on_sacrifice(obj/item/stock_parts/power_store/cell/power_cell, mob/living/chap)
	if(!istype(power_cell))
		return

	if(power_cell.charge() < 0.3 * STANDARD_CELL_CHARGE)
		to_chat(chap, span_notice("[GLOB.deity] 不接受这点可怜的电力。"))
		return

	adjust_favor(round(power_cell.charge() / (0.3 * STANDARD_CELL_CHARGE)), chap)
	to_chat(chap, span_notice("你将 [power_cell] 的电力献给 [GLOB.deity]，令其满意。"))
	qdel(power_cell)
	return TRUE

/**** Pyre God ****/

/datum/religion_sect/pyre
	name = "焚焰之神"
	desc = "献祭烧伤严重的燃烧尸体与蜡烛即可获得恩宠。"
	quote = "它必须燃烧！原始能量必须受到敬畏。"
	tgui_icon = "fire-alt"
	alignment = ALIGNMENT_NEUT
	max_favor = 10000
	desired_items = list(/obj/item/flashlight/flare/candle = "已经点燃")
	rites_list = list(/datum/religion_rites/fireproof, /datum/religion_rites/burning_sacrifice, /datum/religion_rites/infinite_candle)
	altar_icon_state = "convertaltar-red"

/datum/religion_sect/pyre/on_select()
	. = ..()
	AddComponent(/datum/component/sect_nullrod_bonus, list(
		/obj/item/gun/ballistic/bow/divine = list(
			/datum/religion_rites/blazing_star,
		),
	))

/datum/religion_sect/pyre/on_sacrifice(obj/item/flashlight/flare/candle/offering, mob/living/user)
	if(!istype(offering))
		return
	if(!offering.light_on)
		to_chat(user, span_notice("蜡烛需要点燃才能献上！"))
		return
	to_chat(user, span_notice("[GLOB.deity] 对你的献祭感到满意。"))
	adjust_favor(40, user) //it's not a lot but hey there's a pacifist favor option at least
	qdel(offering)
	return TRUE

#define GREEDY_HEAL_COST 50

/datum/religion_sect/greed
	name = "贪婪之神"
	quote = "贪婪是好事。"
	desc = "在你的商业神祇眼中，财富就是恩宠。赚取足够的财富，以购买更多商业机会。"
	tgui_icon = "dollar-sign"
	altar_icon_state = "convertaltar-yellow"
	alignment = ALIGNMENT_EVIL //greed is not good wtf
	rites_list = list(/datum/religion_rites/greed/vendatray, /datum/religion_rites/greed/custom_vending)
	altar_icon_state = "convertaltar-yellow"

/datum/religion_sect/greed/tool_examine(mob/living/holy_creature) //display money policy
	return "在 [GLOB.deity] 眼中，你的财富就是你的恩宠。"

/datum/religion_sect/greed/sect_bless(mob/living/blessed_living, mob/living/chap)
	if(!ishuman(blessed_living))
		return BLESSING_FAILED

	var/datum/bank_account/account = chap.get_bank_account()
	if(!account)
		to_chat(chap, span_warning("你需要有支付治疗费用的方式！"))
		return BLESSING_IGNORED

	if(account.account_balance < GREEDY_HEAL_COST)
		to_chat(chap, span_warning("来自 [GLOB.deity] 的治疗需要 [GREEDY_HEAL_COST] [MONEY_NAME]，可恢复 30 点生命！"))
		return BLESSING_IGNORED

	var/mob/living/carbon/human/blessed = blessed_living
	for(var/obj/item/bodypart/robolimb as anything in blessed.get_bodyparts())
		if(IS_ROBOTIC_LIMB(robolimb))
			to_chat(chap, span_warning("[GLOB.deity] 拒绝治疗这具金属污秽之物！"))
			return BLESSING_IGNORED

	account.adjust_money(-GREEDY_HEAL_COST, "Church Donation: Treatment")
	var/heal_amt = 30
	var/list/hurt_limbs = blessed.get_damaged_bodyparts(1, 1, BODYTYPE_ORGANIC)
	if(!length(hurt_limbs))
		return BLESSING_IGNORED

	for(var/obj/item/bodypart/affecting as anything in hurt_limbs)
		if(affecting.heal_damage(heal_amt, heal_amt, required_bodytype = BODYTYPE_ORGANIC))
			blessed.update_damage_overlays()

	blessed.visible_message(span_notice("[chap] 从 [GLOB.deity] 那里为 [blessed] 换来了一次治疗！"))
	to_chat(blessed, span_boldnotice("愿 [GLOB.deity] 的力量促使你痊愈！感谢你选择 [GLOB.deity]！"))
	playsound(chap, 'sound/effects/cashregister.ogg', 60, TRUE)
	blessed.add_mood_event("blessing", /datum/mood_event/blessing)
	return BLESSING_SUCCESS

#undef GREEDY_HEAL_COST

/datum/religion_sect/burden
	name = "受难之神"
	quote = "要感受自由，必须先理解囚禁。"
	desc = "以任何方式使自己失能。恶劣突变、失去肢体、创伤，\
		甚至成瘾。你将从这个被击败的躯壳中领悟宇宙的奥秘。"
	tgui_icon = "user-injured"
	altar_icon_state = "convertaltar-burden"
	alignment = ALIGNMENT_NEUT
	candle_overlay = FALSE
	smack_chance = 0
	rites_list = list(/datum/religion_rites/nullrod_transformation)

/datum/religion_sect/burden/on_conversion(mob/living/carbon/human/new_convert)
	..()
	if(!ishuman(new_convert))
		to_chat(new_convert, span_warning("[GLOB.deity] 需要更高层次的生物才能完全理解苦难。你并未背负负担。"))
		return
	new_convert.gain_trauma(/datum/brain_trauma/special/burdened, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/religion_sect/burden/on_deconversion(mob/living/carbon/human/new_convert)
	if (ishuman(new_convert))
		new_convert.cure_trauma_type(/datum/brain_trauma/special/burdened, TRAUMA_RESILIENCE_ABSOLUTE)
	return ..()

/datum/religion_sect/burden/tool_examine(mob/living/carbon/human/burdened) //display burden level
	if(ishuman(burdened))
		var/datum/brain_trauma/special/burdened/burden = burdened.has_trauma_type(/datum/brain_trauma/special/burdened)
		if(burden)
			return "你的负担等级为 [burden.burden_level]/9。"
	return "你并未背负负担。"

/datum/religion_sect/burden/sect_bless(mob/living/carbon/target, mob/living/carbon/chaplain)
	if(!istype(target) || !istype(chaplain))
		return BLESSING_FAILED

	var/datum/brain_trauma/special/burdened/burden = chaplain.has_trauma_type(/datum/brain_trauma/special/burdened)
	if(!burden)
		return BLESSING_FAILED

	var/burden_modifier = max(1 - 0.07 * burden.burden_level, 0.01)
	var/transferred = FALSE
	var/list/hurt_limbs = target.get_damaged_bodyparts(1, 1, BODYTYPE_ORGANIC) + target.get_wounded_bodyparts(BODYTYPE_ORGANIC)
	var/list/chaplains_limbs = list()
	for(var/obj/item/bodypart/possible_limb in chaplain.get_bodyparts())
		if(IS_ORGANIC_LIMB(possible_limb))
			chaplains_limbs += possible_limb

	if(length(chaplains_limbs))
		for(var/obj/item/bodypart/affected_limb as anything in hurt_limbs)
			var/obj/item/bodypart/chaplains_limb = chaplain.get_bodypart(affected_limb.body_zone)
			if(!chaplains_limb || !IS_ORGANIC_LIMB(chaplains_limb))
				chaplains_limb = pick(chaplains_limbs)
			var/brute_damage = affected_limb.brute_dam
			var/burn_damage = affected_limb.burn_dam
			if((brute_damage || burn_damage))
				transferred = TRUE
				affected_limb.heal_damage(brute_damage, burn_damage, required_bodytype = BODYTYPE_ORGANIC)
				chaplains_limb.receive_damage(brute_damage * burden_modifier, burn_damage * burden_modifier, forced = TRUE, wound_bonus = CANT_WOUND)
			for(var/datum/wound/iter_wound as anything in affected_limb.wounds)
				transferred = TRUE
				iter_wound.remove_wound()
				iter_wound.apply_wound(chaplains_limb)

		if(HAS_TRAIT_FROM(target, TRAIT_HUSK, BURN))
			transferred = TRUE
			target.cure_husk(BURN)
			chaplain.become_husk(BURN)

	var/toxin_damage = target.get_tox_loss()
	if(toxin_damage && !HAS_TRAIT(chaplain, TRAIT_TOXIMMUNE))
		transferred = TRUE
		target.adjust_tox_loss(-toxin_damage)
		chaplain.adjust_tox_loss(toxin_damage * burden_modifier, forced = TRUE)

	var/suffocation_damage = target.get_oxy_loss()
	if(suffocation_damage && !HAS_TRAIT(chaplain, TRAIT_NOBREATH))
		transferred = TRUE
		target.adjust_oxy_loss(-suffocation_damage)
		chaplain.adjust_oxy_loss(suffocation_damage * burden_modifier, forced = TRUE)

	var/cached_blood_volume = target.get_blood_volume()
	if (cached_blood_volume < BLOOD_VOLUME_SAFE)
		if (target.get_blood_compatibility(chaplain))
			var/amount_to_transfer = BLOOD_VOLUME_SAFE - cached_blood_volume
			transferred |= chaplain.transfer_blood_to(target, amount_to_transfer, ignore_low_blood = TRUE)
	else if (cached_blood_volume > BLOOD_VOLUME_EXCESS)
		transferred |= target.transfer_blood_to(chaplain, cached_blood_volume - BLOOD_VOLUME_EXCESS)

	target.update_damage_overlays()
	chaplain.update_damage_overlays()
	if(!transferred)
		to_chat(chaplain, span_warning("他们身上没有负担！"))
		return BLESSING_IGNORED

	target.visible_message(span_notice("[chaplain] 承接了 [target] 的负担！"))
	to_chat(target, span_boldnotice("愿 [GLOB.deity] 的力量促使你痊愈！"))
	playsound(chaplain, SFX_PUNCH, 25, vary = TRUE, extrarange = -1)
	target.add_mood_event("blessing", /datum/mood_event/blessing)
	return BLESSING_SUCCESS

/datum/religion_sect/burden/sect_dead_bless(mob/living/target, mob/living/chaplain)
	return sect_bless(target, chaplain)

/datum/religion_sect/honorbound
	name = "荣誉之神"
	quote = "需要一场善良而荣誉的讨伐邪恶之战。"
	desc = "你的神祇要求你进行公平决斗。你不得攻击未准备好者、正义者或无辜者。\
	你通过让他人加入十字军来获得恩宠，也可以消耗恩宠宣布一场战斗，从而绕过部分攻击条件。"
	tgui_icon = "scroll"
	altar_icon_state = "convertaltar-white"
	alignment = ALIGNMENT_GOOD
	rites_list = list(/datum/religion_rites/deaconize/crusader, /datum/religion_rites/forgive, /datum/religion_rites/summon_rules)

/datum/religion_sect/honorbound/on_conversion(mob/living/carbon/new_convert)
	..()
	if(!ishuman(new_convert))
		to_chat(new_convert, span_warning("[GLOB.deity] 对低等生物毫无敬意，拒绝让你受荣誉准则约束。"))
		return FALSE
	new_convert.gain_trauma(/datum/brain_trauma/special/honorbound, TRAUMA_RESILIENCE_MAGIC)

/datum/religion_sect/honorbound/on_deconversion(mob/living/carbon/human/new_convert)
	if (ishuman(new_convert))
		new_convert.cure_trauma_type(/datum/brain_trauma/special/honorbound, TRAUMA_RESILIENCE_MAGIC)
	return ..()

#define MINIMUM_YUCK_REQUIRED 5

/datum/religion_sect/maintenance
	name = "维护区之神"
	quote = "你的王国在黑暗之中。"
	desc = "献祭由浸过焊接燃料的老鼠制成的有机浆液以获得恩宠。用恩宠换取适应维护通道的能力。"
	tgui_icon = "eye"
	altar_icon_state = "convertaltar-maint"
	alignment = ALIGNMENT_EVIL //while maint is more neutral in my eyes, the flavor of it kinda pertains to rotting and becoming corrupted by the maints
	rites_list = list(/datum/religion_rites/maint_adaptation, /datum/religion_rites/adapted_eyes, /datum/religion_rites/adapted_food, /datum/religion_rites/ritual_totem)
	desired_items = list(/obj/item/reagent_containers = "装有有机浆液")

/datum/religion_sect/maintenance/sect_bless(mob/living/blessed_living, mob/living/chap)
	if(!ishuman(blessed_living))
		return BLESSING_FAILED

	var/mob/living/carbon/human/blessed = blessed_living
	if(blessed.reagents.has_reagent(/datum/reagent/drug/maint/sludge))
		to_chat(blessed, span_warning("[GLOB.deity] 已经赐予其力量了。"))
		return BLESSING_IGNORED

	blessed.reagents.add_reagent(/datum/reagent/drug/maint/sludge, 5)
	blessed.visible_message(span_notice("[chap] 借 [GLOB.deity] 之力赋予 [blessed] 力量！"))
	to_chat(blessed, span_boldnotice("[GLOB.deity] 的力量使你在短时间内更难受伤！"))
	playsound(chap, SFX_PUNCH, 25, TRUE, -1)
	blessed.add_mood_event("blessing", /datum/mood_event/blessing)
	return BLESSING_SUCCESS //trust me, you'll be feeling the pain from the maint drugs all well enough

/datum/religion_sect/maintenance/on_sacrifice(obj/item/reagent_containers/offering, mob/living/user)
	if(!istype(offering))
		return
	var/datum/reagent/yuck/wanted_yuck = offering.reagents.has_reagent(/datum/reagent/yuck, MINIMUM_YUCK_REQUIRED)
	var/favor_earned = offering.reagents.get_reagent_amount(/datum/reagent/yuck)
	if(!wanted_yuck)
		to_chat(user, span_warning("[offering] 没有足够的有机浆液供 [GLOB.deity] 享用。"))
		return
	to_chat(user, span_notice("[GLOB.deity] 喜爱有机浆液。"))
	adjust_favor(favor_earned, user)
	playsound(get_turf(offering), 'sound/items/drink.ogg', 50, TRUE)
	offering.reagents.clear_reagents()
	return TRUE

#undef MINIMUM_YUCK_REQUIRED

/datum/religion_sect/spar
	name = "决斗之神"
	quote = "你的下一击必须更快，新手。坚定你的心。"
	desc = "与其他船员切磋以获得恩宠或其他奖励。用恩宠换取在真正战斗中坚定自身的能力。"
	tgui_icon = "fist-raised"
	altar_icon_state = "convertaltar-orange"
	alignment = ALIGNMENT_NEUT
	rites_list = list(
		/datum/religion_rites/sparring_contract,
		/datum/religion_rites/ceremonial_weapon,
		/datum/religion_rites/declare_arena,
		/datum/religion_rites/tenacious,
		/datum/religion_rites/unbreakable,
	)
	///the one allowed contract. making a new contract dusts the old one
	var/obj/item/sparring_contract/existing_contract
	///places you can spar in. rites can be used to expand this list with new arenas!
	var/list/arenas = list(
		"Recreation Area" = /area/station/commons/fitness/recreation,
		"Chapel" = /area/station/service/chapel,
	)
	///how many matches you've lost with holy stakes. 3 = excommunication
	var/matches_lost = 0
	///past opponents who you've beaten in holy battles. You can't fight them again to prevent favor farming
	var/list/past_opponents = list()

/datum/religion_sect/spar/tool_examine(mob/living/holy_creature)
	return "你以 [GLOB.deity] 之名赢下了 [round(favor)] 场可兑换的切磋。你已输掉 [matches_lost] 场神圣比赛。输掉三场后你将被逐出教会。"

/datum/religion_sect/music
	name = "节庆之神"
	quote = "万物都遵循节奏：宇宙的心跳！"
	desc = "创造美妙的音乐！用节拍安抚或割裂你的朋友与敌人。"
	tgui_icon = "music"
	altar_icon_state = "convertaltar-festival"
	alignment = ALIGNMENT_GOOD
	candle_overlay = FALSE
	rites_list = list(
		/datum/religion_rites/holy_violin,
		/datum/religion_rites/portable_song_tuning,
		/datum/religion_rites/song_tuner/evangelism,
		/datum/religion_rites/song_tuner/light,
		/datum/religion_rites/song_tuner/nullwave,
		/datum/religion_rites/song_tuner/pain,
		/datum/religion_rites/song_tuner/lullaby,
	)

/datum/religion_sect/music/on_conversion(mob/living/chap)
	. = ..()
	new /obj/item/choice_beacon/music(get_turf(chap))

/datum/religion_sect/dreams
	name = "梦境之神"
	quote = "梦是通往灵魂的窗口。"
	desc = "深入梦境以洞悉宇宙。通过做梦或祝福做梦的生物获得恩宠。\
		你的祝福会引发梦境，并促进熟睡者的治疗。"
	tgui_icon = FA_ICON_CLOUD
	alignment = ALIGNMENT_GOOD
	altar_icon_state = "convertaltar-dream"
	altar_emissive_icon_state = "convertaltar-dream-em"
	candle_overlay = FALSE
	rites_list = list(
		/datum/religion_rites/deaconize/dreamers,
		/datum/religion_rites/banish_nightmare,
		/datum/religion_rites/dream_portent,
		/datum/religion_rites/dream_projection,
		/datum/religion_rites/dream_protection,
		/datum/religion_rites/slumber_party,
	)
	smack_chance = 20
	/// Whether the dream protection rite has been used
	VAR_FINAL/dream_protection = FALSE
	/// Number of deacons added thus far
	VAR_FINAL/deacon_count = 0
	/// Max number of deacons
	var/max_deacons = 3
	/// Chance a given dream will be a vague portent
	var/vague_portent_chance = 10
	/// Lazylist of mobs that were blessed recently
	/// Blocks mobs from being repeatedly blessed for favor
	VAR_PRIVATE/list/recent_bless_refs
	/// Cooldown between any follower receiving a vague portent
	COOLDOWN_DECLARE(vague_portent_cooldown)

/datum/religion_sect/dreams/on_conversion(mob/living/chap)
	. = ..()
	RegisterSignal(chap, COMSIG_PRE_DREAMING, PROC_REF(pre_dream))
	RegisterSignal(chap, COMSIG_START_DREAMING, PROC_REF(on_dream))
	if(dream_protection)
		chap.apply_status_effect(/datum/status_effect/dream_protection)

/datum/religion_sect/dreams/on_deconversion(mob/living/chap)
	. = ..()
	UnregisterSignal(chap, COMSIG_PRE_DREAMING)
	UnregisterSignal(chap, COMSIG_START_DREAMING)
	chap.remove_status_effect(/datum/status_effect/dream_protection)

/datum/religion_sect/dreams/proc/pre_dream(mob/living/chap, list/dream_pool)
	SIGNAL_HANDLER

	// prioritize specific portents if they're in the pool
	if(locate(/datum/dream/specific_portent) in dream_pool)
		return
	if(!COOLDOWN_FINISHED(src, vague_portent_cooldown))
		return
	if(!prob(vague_portent_chance))
		return

	dream_pool[new /datum/dream/random/vague_portent()] = /datum/dream/random::weight * 0.1

/datum/religion_sect/dreams/proc/on_dream(mob/living/chap, datum/dream/dream_instance)
	SIGNAL_HANDLER

	// no reward for the dream your god is specifically giving you
	if(istype(dream_instance, /datum/dream/specific_portent))
		return

	var/dream_favor = 10
	// but you do get a slight boost for having a *vague* one
	if(istype(dream_instance, /datum/dream/random/vague_portent))
		COOLDOWN_START(src, vague_portent_cooldown, 30 SECONDS)
		dream_favor *= 1.5

	to_chat(chap, span_cyan("[GLOB.deity] 赞许你的沉睡。"))
	adjust_favor(dream_favor, chap)

// dream blessing only works on dreaming targets.
// blessing someone asleep causes them to dream, and blessing a dreamer rewards favor.
// it also heals regardless of if the target is mechanical or organic. do robots dream of electric sheep?
/datum/religion_sect/dreams/sect_bless(mob/living/target, mob/living/chap)
	if(HAS_TRAIT(target, TRAIT_DREAMING))
		var/result = standard_bless_healing(target, chap)
		var/tarref = REF(target)
		if(!LAZYFIND(recent_bless_refs, tarref))
			adjust_favor(20 * (isnull(target.mind) ? 0.5 : 1) * (target.IsSleeping() ? 1 : 0.5), chap)
			LAZYADD(recent_bless_refs, tarref)
			addtimer(CALLBACK(src, PROC_REF(clear_bless_ref), tarref), 6 MINUTES)
			result = BLESSING_SUCCESS

		if(result == BLESSING_SUCCESS)
			to_chat(chap, span_cyan("[GLOB.deity] 赞许 [target] 的沉睡。"))
		return result

	if(IS_UNCONSCIOUS(target))
		if(iscarbon(target))
			var/mob/living/carbon/sleeper = target
			sleeper.dream()

		to_chat(chap, span_cyan("[GLOB.deity] 祝福 [target] 的沉睡。"))
		var/result = standard_bless_healing(target, chap)
		if(dream_protection && target.mind && target.apply_status_effect(/datum/status_effect/dream_protection/temporary))
			result = BLESSING_SUCCESS

		if(result == BLESSING_SUCCESS)
			to_chat(chap, span_cyan("[GLOB.deity] 祝福 [target] 的沉睡。"))
		return result

	to_chat(chap, span_warning("[GLOB.deity] 对祝福清醒者毫无兴趣。"))
	return BLESSING_IGNORED

/datum/religion_sect/dreams/sect_dead_bless(mob/living/target, mob/living/chap)
	var/tarref = REF(target)
	if(LAZYFIND(recent_bless_refs, tarref))
		return BLESSING_IGNORED

	to_chat(chap, span_cyan("[GLOB.deity] 守护着 [target] 的永恒安息。"))
	if(dream_protection && target.mind)
		target.apply_status_effect(/datum/status_effect/dream_protection/deceased)
	adjust_favor(10 * (target.mind ? 1 : 0.5), chap)
	LAZYADD(recent_bless_refs, tarref)
	addtimer(CALLBACK(src, PROC_REF(clear_bless_ref), tarref), 6 MINUTES)
	return BLESSING_SUCCESS

/datum/religion_sect/dreams/proc/clear_bless_ref(tarref)
	LAZYREMOVE(recent_bless_refs, tarref)

/datum/religion_sect/dreams/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, dream_protection))
		for(var/mob/living/chap as anything in GLOB.mob_living_list)
			if(chap.mind?.holy_role)
				if(var_value)
					chap.apply_status_effect(/datum/status_effect/dream_protection)
				else
					chap.remove_status_effect(/datum/status_effect/dream_protection)
