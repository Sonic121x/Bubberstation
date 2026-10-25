#define TAROT_GHOST_TIMER (666 SECONDS) // this translates into 11 mins and 6 seconds

//These cards certainly won't tell the future, but you can play some nice games with them.
/obj/item/toy/cards/deck/tarot
	name = "塔罗牌组"
	desc = "一副完整的 78 张塔罗牌。包含 4 组各 14 张花色牌，以及齐全的王牌组。"
	cardgame_desc = "塔罗牌占卜"
	icon_state = "deck_tarot_full"
	deckstyle = "tarot"

/obj/item/toy/cards/deck/tarot/initialize_cards()
	for(var/suit in list("Hearts", "Pikes", "Clovers", "Tiles"))
		for(var/i in 1 to 10)
			initial_cards += "[i] of [suit]"
		for(var/person in list("Valet", "Chevalier", "Dame", "Roi"))
			initial_cards += "[person] of [suit]"
	for(var/trump in list("The Magician", "The High Priestess", "The Empress", "The Emperor", "The Hierophant", "The Lover", "The Chariot", "Justice", "The Hermit", "The Wheel of Fortune", "Strength", "The Hanged Man", "Death", "Temperance", "The Devil", "The Tower", "The Star", "The Moon", "The Sun", "Judgement", "The World", "The Fool"))
		initial_cards += trump

/obj/item/toy/cards/deck/tarot/draw(mob/user)
	. = ..()
	if(prob(50))
		var/obj/item/toy/singlecard/card = .
		if(!card)
			return

		var/matrix/M = matrix()
		M.Turn(180)
		card.transform = M

/obj/item/toy/cards/deck/tarot/pick_card(mob/living/user, list/obj/item/toy/singlecard/cards)
	// If the user is cursed they have increase chance of drawing Death or The Tower
	if(!HAS_TRAIT(user, TRAIT_CURSED))
		return ..()

	var/total_card = length(cards)
	// give a boosted chance if they're using the full deck
	var/chance_modifier = total_card >= 56 ? 24 : 4
	if(!prob(min(33, chance_modifier / total_card * 100)))
		return ..()

	for(var/obj/item/toy/singlecard/card as anything in cards)
		if(card.cardname == "Death" || card.cardname == "The Tower")
			return card

	return ..()

/obj/item/toy/cards/deck/tarot/haunted
	name = "闹鬼塔罗牌组"
	desc = "一副看上去阴森可怖的塔罗牌。你能感觉到有超自然的存在与这些牌相连……"
	/// ghost notification cooldown
	COOLDOWN_DECLARE(ghost_alert_cooldown)

/obj/item/toy/cards/deck/tarot/haunted/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/two_handed, \
		attacksound = 'sound/items/cards/cardflip.ogg', \
		wield_callback = CALLBACK(src, PROC_REF(on_wield)), \
		unwield_callback = CALLBACK(src, PROC_REF(on_unwield)), \
	)

/obj/item/toy/cards/deck/tarot/haunted/proc/on_wield(obj/item/source, mob/living/carbon/user)
	ADD_TRAIT(user, TRAIT_SIXTHSENSE, MAGIC_TRAIT)
	to_chat(user, span_notice("通往冥界的帷幕被拉开了。你能感觉到亡魂在呼唤……"))

	if(!COOLDOWN_FINISHED(src, ghost_alert_cooldown))
		return

	COOLDOWN_START(src, ghost_alert_cooldown, TAROT_GHOST_TIMER)
	notify_ghosts(
		"有人在 [get_area(src)] 开始玩起了 [name]！",
		source = src,
		header = "闹鬼塔罗牌组",
		ghost_sound = 'sound/effects/ghost2.ogg',
		notify_volume = 75,
	)

/obj/item/toy/cards/deck/tarot/haunted/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	REMOVE_TRAIT(user, TRAIT_SIXTHSENSE, MAGIC_TRAIT)
	to_chat(user, span_notice("通往冥界的帷幕合上了。你感觉自己的感官恢复了正常。"))

#undef TAROT_GHOST_TIMER
