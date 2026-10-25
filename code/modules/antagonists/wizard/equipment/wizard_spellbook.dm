/obj/item/spellbook
	name = "法术书"
	desc = "一本散发着力量光芒的诡异书卷。"
	icon = 'icons/obj/service/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY

	/// The number of book charges we have to buy spells
	var/uses = 10
	/// The bonus that you get from going semi-random.
	var/semi_random_bonus = 2
	/// The bonus that you get from going full random.
	var/full_random_bonus = 5
	/// Determines if this spellbook can refund anything.
	var/refunds_allowed = TRUE
	/// The mind that first used the book. Automatically assigned when a wizard spawns.
	var/datum/mind/owner
	/// A list to all spellbook entries within
	var/list/entries = list()

/obj/item/spellbook/Initialize(mapload)
	. = ..()
	prepare_spells()
	RegisterSignal(src, COMSIG_ITEM_MAGICALLY_CHARGED, PROC_REF(on_magic_charge))

/obj/item/spellbook/Destroy(force)
	owner = null
	entries.Cut()
	return ..()

/**
 * Signal proc for [COMSIG_ITEM_MAGICALLY_CHARGED]
 *
 * Has no effect on charge, but gives a funny message to people who think they're clever.
 */
/obj/item/spellbook/proc/on_magic_charge(datum/source, datum/action/cooldown/spell/spell, mob/living/caster)
	SIGNAL_HANDLER

	to_chat(caster, span_warning("封面上浮现出发着红光的字母……"))
	to_chat(caster, span_red(pick(
		"想得美，不行！",
		"很聪明，但还不够聪明！",
		"正是这种明目张胆的作弊，才让我们接受了你的申请！",
		"可爱！真可爱！",
		"你不会真以为有这么容易吧？",
	)))

	return COMPONENT_ITEM_BURNT_OUT

/obj/item/spellbook/examine(mob/user)
	. = ..()
	if(owner)
		. += "封面上有一个小小的签名：“[owner]”。"
	else
		. += "它似乎没有作者。"

/obj/item/spellbook/attack_self(mob/user)
	if(!owner)
		if(!user.mind)
			return
		to_chat(user, span_notice("你把[src]绑定到自己身上。"))
		owner = user.mind
		return

	if(user.mind != owner)
		if(IS_WIZARD_APPRENTICE(user))
			to_chat(user, span_warning("要是被人发现你偷看老师的法术书，你很可能会被巫师学院开除。还是别这么做。"))
		else
			to_chat(user, span_warning("[src]不承认你是它的主人，拒绝打开！"))
		return

	return ..()

/obj/item/spellbook/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	// This can be generalized in the future, but for now it stays
	var/datum/spellbook_entry/item/spawner_entry
	var/success_string
	if(istype(tool, /obj/item/antag_spawner/contract))
		if(astype(tool, /obj/item/antag_spawner/contract).used)
			to_chat(user, span_warning("这份合约已被使用，你现在无法取回点数了！"))
			return ITEM_INTERACT_BLOCKING
		spawner_entry = locate(/datum/spellbook_entry/item/contract) in entries
		success_string = "你把合约塞回法术书，取回了自己的点数。"

	if(istype(tool, /obj/item/antag_spawner/slaughter_demon/laughter))
		spawner_entry = locate(/datum/spellbook_entry/item/hugbottle) in entries
		success_string = "转念一想，召唤恶魔也许并不是个有趣的主意。你取回了点数。"

	else if(istype(tool, /obj/item/antag_spawner/slaughter_demon))
		spawner_entry = locate(/datum/spellbook_entry/item/bloodbottle) in entries
		success_string = "转念一想，召唤恶魔也许是个坏主意。你取回了点数。"

	if(isnull(success_string))
		return NONE
	if(!istype(spawner_entry)) // No success_string means it isn't a valid item, no spawner entry means the book doesn't have it(somehow)(they had this check before I got here)
		to_chat(user, span_warning("[src]似乎不想退还[tool]。"))
		return ITEM_INTERACT_BLOCKING
	if(!spawner_entry.can_refund(user, src, tool))
		to_chat(user, span_warning("你无法退还[src]。"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice(success_string))
	uses += spawner_entry.cost
	spawner_entry.times--
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/// Instantiates our list of spellbook entries.
/obj/item/spellbook/proc/prepare_spells()
	var/entry_types = subtypesof(/datum/spellbook_entry)
	for(var/type in entry_types)
		var/datum/spellbook_entry/possible_entry = new type()
		if(!possible_entry.can_be_purchased())
			qdel(possible_entry)
			continue

		possible_entry.set_spell_info() //loads up things for the entry that require checking spell instance.
		entries |= possible_entry

/obj/item/spellbook/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Spellbook")
		ui.open()

/obj/item/spellbook/ui_data(mob/user)
	var/list/data = list()
	data["owner"] = owner
	data["points"] = uses
	return data

//This is a MASSIVE amount of data, please be careful if you remove it from static.
/obj/item/spellbook/ui_static_data(mob/user)
	var/list/data = list()
	// Collect all info from each intry.
	var/list/entry_data = list()
	for(var/datum/spellbook_entry/entry as anything in entries)
		var/list/individual_entry_data = list()
		individual_entry_data["name"] = entry.name
		individual_entry_data["desc"] = entry.desc
		individual_entry_data["ref"] = REF(entry)
		individual_entry_data["requires_wizard_garb"] = entry.requires_wizard_garb
		individual_entry_data["cost"] = entry.cost
		individual_entry_data["times"] = entry.times
		individual_entry_data["cooldown"] = entry.cooldown
		individual_entry_data["cat"] = entry.category
		individual_entry_data["refundable"] = entry.refundable
		individual_entry_data["buyword"] = entry.buy_word
		entry_data += list(individual_entry_data)

	data["entries"] = entry_data
	data["semi_random_bonus"] = initial(uses) + semi_random_bonus
	data["full_random_bonus"] = initial(uses) + full_random_bonus
	return data

/obj/item/spellbook/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/human/wizard = usr
	if(!istype(wizard))
		to_chat(wizard, span_warning("这本书似乎不听低级生命体的话。"))
		return FALSE

	// Actions that are always available
	switch(action)
		if("purchase")
			var/datum/spellbook_entry/entry = locate(params["spellref"]) in entries
			return purchase_entry(entry, wizard)

		if("refund")
			var/datum/spellbook_entry/entry = locate(params["spellref"]) in entries
			if(!istype(entry))
				CRASH("[type] had an invalid ref to a spell passed in refund.")
			if(!entry.can_refund(wizard, src))
				return FALSE
			var/result = entry.refund_spell(wizard, src)
			if(result <= 0)
				return FALSE

			entry.times = 0
			uses += result
			return TRUE

	if(uses < initial(uses))
		to_chat(wizard, span_warning("你需要拥有全部法术点数才能这样做！"))
		return FALSE

	// Actions that are only available if you have full spell points
	switch(action)
		if("semirandomize")
			semirandomize(wizard, semi_random_bonus)
			return TRUE

		if("randomize")
			randomize(wizard, full_random_bonus)
			return TRUE

		if("purchase_loadout")
			wizard_loadout(wizard, params["id"])
			return TRUE

/// Attempts to purchased the passed entry [to_buy] for [user].
/obj/item/spellbook/proc/purchase_entry(datum/spellbook_entry/to_buy, mob/living/carbon/human/user)
	if(!istype(to_buy))
		CRASH("Spellbook attempted to buy an invalid entry. Got: [to_buy ? "[to_buy] ([to_buy.type])" : "null"]")
	if(!to_buy.can_buy(user, src))
		return FALSE
	if(!to_buy.buy_spell(user, src))
		return FALSE

	to_buy.times++
	if(HAS_TRAIT(user, TRAIT_SPELLS_LOTTERY))
		if(prob(50 / to_buy.cost))
			to_chat(user, span_notice("这个法术是免费送给你的！"))
			return TRUE
	uses -= to_buy.cost
	return TRUE

/// Purchases a wizard loadout [loadout] for [wizard].
/obj/item/spellbook/proc/wizard_loadout(mob/living/carbon/human/wizard, loadout)
	var/list/wanted_spells
	switch(loadout)
		if(WIZARD_LOADOUT_CLASSIC) //(Fireball>2, MM>2, Smite>2, Jauntx2>4) = 10
			wanted_spells = list(
				/datum/spellbook_entry/fireball = 1,
				/datum/spellbook_entry/magicm = 1,
				/datum/spellbook_entry/disintegrate = 1,
				/datum/spellbook_entry/jaunt = 2,
			)
		if(WIZARD_LOADOUT_MJOLNIR) //(Mjolnir>2, Summon Itemx1>1, Mutate>2, Force Wall>1, Blink>2, tesla>2) = 10
			wanted_spells = list(
				/datum/spellbook_entry/item/mjolnir = 1,
				/datum/spellbook_entry/summonitem = 1,
				/datum/spellbook_entry/mutate = 1,
				/datum/spellbook_entry/forcewall = 1,
				/datum/spellbook_entry/blink = 1,
				/datum/spellbook_entry/teslablast = 1,
			)
		if(WIZARD_LOADOUT_WIZARMY) //(Soulstones>2, Staff of Change>2, A Necromantic Stone>2, Teleport>2, Ethereal Jaunt>2) = 10
			wanted_spells = list(
				// /datum/spellbook_entry/item/soulstones = 1, BUBBERSTATION CHANGE: NO MORE SOULSTONES. -2
				// /datum/spellbook_entry/item/staffchange = 1, BUBBERSTATION CHANGE: NO MORE STAFF OF CHANGE. -2
				/datum/spellbook_entry/item/necrostone = 1,
				/datum/spellbook_entry/teleport = 1,
				/datum/spellbook_entry/jaunt = 1,
				/datum/spellbook_entry/lichdom = 1, //BUBBERSTATION ADDITION: ADDS LICHDOM. +2
				/datum/spellbook_entry/item/vendormancer = 1, //BUBBERSTATION ADDITION: ADDS VENDORMANCER. +2
			)
		if(WIZARD_LOADOUT_SOULTAP) //(Soul Tap>1, Smite>2, Flesh to Stone>2, Mindswap>2, Knock>1, Teleport>2) = 10
			wanted_spells = list(
				/datum/spellbook_entry/tap = 1,
				/datum/spellbook_entry/disintegrate = 1,
				/datum/spellbook_entry/fleshtostone = 1,
				/datum/spellbook_entry/mindswap = 1,
				/datum/spellbook_entry/knock = 1,
				/datum/spellbook_entry/teleport = 1,
			)

	if(!length(wanted_spells))
		stack_trace("Wizard Loadout \"[loadout]\" did not find a loadout that existed.")
		return

	for(var/entry in wanted_spells)
		if(!ispath(entry, /datum/spellbook_entry))
			stack_trace("Wizard Loadout \"[loadout]\" had a non-spellbook_entry type in its wanted spells list. ([entry])")
			continue

		var/datum/spellbook_entry/to_buy = locate(entry) in entries
		if(!istype(to_buy))
			stack_trace("Wizard Loadout \"[loadout]\" had an invalid entry in its wanted spells list. ([entry])")
			continue

		for(var/i in 1 to wanted_spells[entry])
			if(!purchase_entry(to_buy, wizard))
				stack_trace("Wizard Loadout \"[loadout]\" was unable to buy a spell for [wizard]. ([entry])")
				message_admins("巫师 [wizard] 购买了配装 \"[loadout]\"，但因某种原因无法购买其中一项条目（[to_buy]）。")
				break

	refunds_allowed = FALSE

	if(uses > 0)
		stack_trace("Wizard Loadout \"[loadout]\" does not use 10 wizard spell slots (used: [initial(uses) - uses]). Stop scamming players out.")

/// Purchases a semi-random wizard loadout for [wizard]
/// If passed a number [bonus_to_give], the wizard is given additional uses on their spellbook, used in randomization.
/obj/item/spellbook/proc/semirandomize(mob/living/carbon/human/wizard, bonus_to_give = 0)
	var/list/needed_cats = list("Offensive", "Mobility")
	var/list/shuffled_entries = shuffle(entries)
	for(var/i in 1 to 2)
		for(var/datum/spellbook_entry/entry as anything in shuffled_entries)
			if(!(entry.category in needed_cats))
				continue
			if(!purchase_entry(entry, wizard))
				continue
			needed_cats -= entry.category //so the next loop doesn't find another offense spell
			break

	refunds_allowed = FALSE
	//we have given two specific category spells to the wizard. the rest are completely random!
	randomize(wizard, bonus_to_give = bonus_to_give)

/// Purchases a fully random wizard loadout for [wizard], with a point bonus [bonus_to_give].
/// If passed a number [bonus_to_give], the wizard is given additional uses on their spellbook, used in randomization.
/obj/item/spellbook/proc/randomize(mob/living/carbon/human/wizard, bonus_to_give = 0)
	var/list/entries_copy = entries.Copy()
	uses += bonus_to_give
	while(uses > 0 && length(entries_copy))
		var/datum/spellbook_entry/entry = pick(entries_copy)
		if(!purchase_entry(entry, wizard))
			continue
		entries_copy -= entry

	refunds_allowed = FALSE
