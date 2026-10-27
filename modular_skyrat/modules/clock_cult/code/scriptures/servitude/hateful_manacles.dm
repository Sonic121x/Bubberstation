/datum/scripture/slab/hateful_manacles
	name = "憎恨镣铐"
	desc = "在目标手腕上形成复制镣铐，功能如同手铐，可束缚住目标。"
	tip = "在近距离铐住目标，将其制服以便提取活力。"
	button_icon_state = "Hateful Manacles"
	power_cost = 50
	invocation_time = 2 SECONDS // 2 to invoke, 3 to cuff
	invocation_text = list("Shackle the heretic...", "Break them in body and spirit!")
	slab_overlay = "hateful_manacles"
	use_time = 20 SECONDS
	cogs_required = 1
	category = SPELLTYPE_SERVITUDE


/datum/scripture/slab/hateful_manacles/apply_effects(mob/living/carbon/target_carbon)
	. = ..()
	if(!istype(target_carbon) || IS_CLOCK(target_carbon))
		return FALSE

	if(target_carbon.handcuffed)
		target_carbon.balloon_alert(invoker, "已被束缚！")
		return FALSE

	playsound(target_carbon, 'sound/items/weapons/handcuffs.ogg', 30, TRUE, -2)
	target_carbon.visible_message(span_danger("[invoker] 在 [target_carbon] 周围凝成一口能量之井，黄铜在其手腕上浮现！"),\
						span_userdanger("[invoker] 正试图束缚你！"))

	if(!do_after(invoker, 3 SECONDS, target = target_carbon))
		return FALSE

	if(target_carbon.handcuffed)
		return FALSE

	target_carbon.handcuffed = new /obj/item/restraints/handcuffs/clockwork(target_carbon)
	target_carbon.update_handcuffed()
	log_combat(invoker, target_carbon, "handcuffed")

	return TRUE


/obj/item/restraints/handcuffs/clockwork
	name = "复制镣铐"
	desc = "由冰冷刺骨的金属制成的沉重镣铐。看起来像黄铜，但摸起来坚固得多。"
	icon_state = "brass_manacles"
	item_flags = DROPDEL
