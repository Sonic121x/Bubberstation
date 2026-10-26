/obj/item/anointing_oil
	name = "祝圣血树脂"
	desc = "于是赫尔加·刀臂向炉火开口，定下规矩：凡是给野兽赐名的同族，都须以征服与鲜血来完成。"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "potred"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY

	var/being_used = FALSE

/obj/item/anointing_oil/attack(mob/living/target_mob, mob/living/user, params)
	if (!is_species(user, /datum/species/human/felinid/primitive))
		to_chat(user, span_warning("你完全不知道这种恶心的混合物是做什么用的。"))
		return
	if(being_used || !ismob(target_mob)) //originally this was going to check if the mob was friendly, but if an icecat wants to name some terror mob while it's tearing chunks out of them, why not?
		return
	if(target_mob.ckey)
		to_chat(user, span_warning("你不会如此羞辱一个如此聪慧的生灵，让它连自己的名字都不能自己选。"))
		return

	if(try_anoint(target_mob, user))
		qdel(src)
	else
		being_used = FALSE

/obj/item/anointing_oil/proc/try_anoint(mob/living/target_mob, mob/living/user)
	being_used = TRUE

	var/new_name = sanitize_name(tgui_input_text(user, "说出这头野兽的新名字，让所有同族都听见。", "输入名字", target_mob.name, MAX_NAME_LEN))

	if(!new_name || QDELETED(src) || QDELETED(target_mob) || new_name == target_mob.name || !target_mob.Adjacent(user))
		being_used = FALSE
		return FALSE

	target_mob.visible_message(span_notice("[user] 俯下身，在 [target_mob] 身上涂抹出两道闪亮的血树脂痕，随即带着仪式的庄重直起身……"))
	user.say("从此冰雪将永远以 +[new_name]+ 之名识你。")

	user.log_message("对 [target_mob] 使用了 [src]，将其改名为 [new_name]。", LOG_GAME)

	target_mob.name = new_name

	//give the stupid dog zoomies from getting named
	if(istype(target_mob, /mob/living/basic/mining/wolf))
		target_mob.emote("awoo")
		target_mob.emote("spin")

	return TRUE

/obj/item/anointing_oil/examine(mob/user)
	. = ..()
	if(is_species(user, /datum/species/human/felinid/primitive))
		. += span_info("对着当地的野生动物使用，就能为它取一个名字。")

/datum/crafting_recipe/anointing_oil
	name = "祝圣血树脂"
	category = CAT_MISC
	//recipe given to icecats as part of their spawner/team setting
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED

	reqs = list(
		/datum/reagent/consumable/liquidgibs = 80,
		/datum/reagent/blood = 20,
	)

	result = /obj/item/anointing_oil
