/obj/structure/flora/tree/pine/xmas/millionaire //not really a tree but the code is close enough
	icon = 'modular_zubbers/icons/obj/fluff/bonus.dmi'
	icon_state = "bonusnt"
	pixel_x = 0
	name = "奖金袋堆"
	desc = "一堆奖金袋。找找写着你名字的那一袋！"
	var/gift_type = /obj/item/storage/box/papersack/millionaire_bonus
	var/unlimited = FALSE
	var/static/list/took_bonus

/obj/structure/flora/tree/pine/xmas/millionaire/Initialize(mapload)
	. = ..()
	if(!took_bonus)
		took_bonus = list()

/obj/structure/flora/tree/pine/xmas/millionaire/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.ckey)
		return

	if(took_bonus[user.ckey] && !unlimited)
		to_chat(user, span_warning("你已经领过奖金了！"))
		return
	to_chat(user, span_warning("翻找片刻后，你找到了写着自己名字的奖金袋！"))

	if(!unlimited)
		took_bonus[user.ckey] = TRUE

	var/obj/item/G = new gift_type(src)
	user.put_in_hands(G)
