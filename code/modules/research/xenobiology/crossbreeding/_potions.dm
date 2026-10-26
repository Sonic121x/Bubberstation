/*
Slimecrossing Potions
	Potions added by the slimecrossing system.
	Collected here for clarity.
*/

//Extract cloner - Charged Grey
/obj/item/slimepotion/extract_cloner
	name = "提取物克隆药水"
	desc = "提取物强化药水的更强版本，能够克隆普通的史莱姆提取物。"
	icon_state = "potgold"

/obj/item/slimepotion/extract_cloner/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(istype(interacting_with, /obj/item/slimecross))
		to_chat(user, span_warning("[interacting_with] 过于复杂，药水无法克隆！"))
		return ITEM_INTERACT_BLOCKING
	if(!istype(interacting_with, /obj/item/slime_extract))
		return ITEM_INTERACT_BLOCKING
	var/obj/item/slime_extract/S = interacting_with
	if(S.recurring)
		to_chat(user, span_warning("[interacting_with] 过于复杂，药水无法克隆！"))
		return ITEM_INTERACT_BLOCKING
	var/path = S.type
	var/obj/item/slime_extract/C = new path(get_turf(interacting_with))
	C.extract_uses = S.extract_uses
	to_chat(user, span_notice("你把药水倒在 [interacting_with] 上，液体凝固成了一份它的复制品！"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Peace potion - Charged Light Pink
/obj/item/slimepotion/peacepotion
	name = "安抚药水"
	desc = "一种浅粉色的化学溶液，闻起来像液态的和平，还有汞盐。"
	icon_state = "potlightpink"

/obj/item/slimepotion/peacepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/peace_target = interacting_with
	if(!isliving(peace_target) || peace_target.stat == DEAD)
		to_chat(user, span_warning("[src] 只对活物有效。"))
		return ITEM_INTERACT_BLOCKING
	if(ismegafauna(peace_target))
		to_chat(user, span_warning("[src] 对纯粹邪恶的存在无效！"))
		return ITEM_INTERACT_BLOCKING
	if(peace_target != user)
		peace_target.visible_message(span_danger("[user] 开始给 [peace_target] 喂 [src]！"),
			span_userdanger("[user] 开始给你喂 [src]！"))
	else
		peace_target.visible_message(span_danger("[user] 开始喝 [src]！"),
			span_danger("你开始喝 [src]！"))

	if(!do_after(user, 10 SECONDS, target = peace_target))
		return ITEM_INTERACT_BLOCKING
	if(peace_target != user)
		to_chat(user, span_notice("你给 [peace_target] 喂下了 [src]！"))
	else
		to_chat(user, span_warning("你喝下了 [src]！"))
	if(isanimal_or_basicmob(peace_target))
		ADD_TRAIT(peace_target, TRAIT_PACIFISM, MAGIC_TRAIT)
	else if(iscarbon(peace_target))
		var/mob/living/carbon/peaceful_carbon = peace_target
		peaceful_carbon.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_SURGERY)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Love potion - Charged Pink
/obj/item/slimepotion/lovepotion
	name = "爱情药水"
	desc = "一种粉色的化学混合液，据说能唤起爱意。"
	icon_state = "potpink"

/obj/item/slimepotion/lovepotion/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/love_target = interacting_with
	if(!isliving(love_target) || love_target.stat == DEAD)
		to_chat(user, span_warning("爱情药水只对活物有效，变态！"))
		return ITEM_INTERACT_BLOCKING
	if(ismegafauna(love_target))
		to_chat(user, span_warning("爱情药水对纯粹邪恶的存在无效！"))
		return ITEM_INTERACT_BLOCKING
	if(user == love_target)
		to_chat(user, span_warning("你可不能喝下爱情药水。你是个自恋狂吗？"))
		return ITEM_INTERACT_BLOCKING
	if(love_target.has_status_effect(/datum/status_effect/in_love))
		to_chat(user, span_warning("[love_target] 已经坠入爱河了！"))
		return ITEM_INTERACT_BLOCKING

	love_target.visible_message(span_danger("[user] 开始给 [love_target] 喂爱情药水！"),
		span_userdanger("[user] 开始给你喂爱情药水！"))

	if(!do_after(user, 5 SECONDS, target = love_target))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你给 [love_target] 喂下了爱情药水！"))
	to_chat(love_target, span_notice("你对 [user] 产生了感情，也对 [user.p_they()] like[user.p_s()] 的每一个人心生爱慕。"))
	love_target.add_ally(user)
	love_target.apply_status_effect(/datum/status_effect/in_love, user)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Pressure potion - Charged Dark Blue
/obj/item/slimepotion/spaceproof
	name = "史莱姆加压药水"
	desc = "一种强效化学密封剂，能让任何衣物变得气密。可使用两次。"
	icon_state = "potblack"
	var/uses = 2

/obj/item/slimepotion/spaceproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	var/obj/item/clothing/clothing = interacting_with
	if(!istype(clothing))
		to_chat(user, span_warning("这药水只能用于衣物！"))
		return ITEM_INTERACT_BLOCKING
	if(istype(clothing, /obj/item/clothing/suit/space))
		to_chat(user, span_warning("[interacting_with] 已经耐压了！"))
		return ITEM_INTERACT_BLOCKING
	if(clothing.min_cold_protection_temperature == SPACE_SUIT_MIN_TEMP_PROTECT && (clothing.clothing_flags & STOPSPRESSUREDAMAGE))
		to_chat(user, span_warning("[interacting_with] 已经耐压了！"))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你把蓝色黏液涂抹在 [clothing] 上，使其变得气密。"))
	clothing.name = "耐压的 [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_NAVY, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	clothing.cold_protection = clothing.body_parts_covered
	clothing.clothing_flags |= STOPSPRESSUREDAMAGE
	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

//Enhancer potion - Charged Cerulean
/obj/item/slimepotion/enhancer/max
	name = "提取物最大化剂"
	desc = "一种效力极强的化学混合液，能将史莱姆提取物的使用次数最大化。"
	icon_state = "potcerulean"

//Lavaproofing potion - Charged Red
/obj/item/slimepotion/lavaproof
	name = "史莱姆抗熔岩药水"
	desc = "一种奇怪的偏红色黏液，据说能像排斥水一样排斥熔岩，且不会降低可燃性。可使用两次。"
	icon_state = "potyellow"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	var/uses = 2

/obj/item/slimepotion/lavaproof/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	if(uses <= 0)
		qdel(src)
		return ITEM_INTERACT_BLOCKING
	if(!isitem(interacting_with))
		to_chat(user, span_warning("这东西没法涂上抗熔岩液体！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/clothing = interacting_with
	to_chat(user, span_notice("你把红色黏液涂抹在 [clothing] 上，使其能够抵御熔岩。"))
	clothing.name = "抗熔岩的 [clothing.name]"
	clothing.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
	clothing.add_atom_colour(color_transition_filter(COLOR_MAROON, SATURATION_OVERRIDE), FIXED_COLOUR_PRIORITY)
	clothing.resistance_flags |= LAVA_PROOF
	if (isclothing(clothing))
		var/obj/item/clothing/clothing_real = clothing
		clothing_real.clothing_flags |= LAVAPROTECT
		clothing_real.resistance_flags |= FIRE_PROOF
	uses--
	if(uses <= 0)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

//Revival potion - Charged Grey
/obj/item/slimepotion/slime_reviver
	name = "史莱姆复苏药水"
	desc = "注入了等离子体与压缩凝胶，能让死去的史莱姆重获生机。"
	icon_state = "potgrey"

/obj/item/slimepotion/slime_reviver/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(. & ITEM_INTERACT_ANY_BLOCKER)
		return .
	var/mob/living/basic/slime/revive_target = interacting_with
	if(!isslime(revive_target))
		to_chat(user, span_warning("这药水只对史莱姆有效！"))
		return ITEM_INTERACT_BLOCKING
	if(revive_target.stat != DEAD)
		to_chat(user, span_warning("这只史莱姆还活着！"))
		return ITEM_INTERACT_BLOCKING
	if(revive_target.maxHealth <= 0)
		to_chat(user, span_warning("这只史莱姆太不稳定，无法复生！"))
		return ITEM_INTERACT_BLOCKING
	user.do_attack_animation(interacting_with)
	revive_target.revive(HEAL_ALL)
	revive_target.visible_message(span_notice("[revive_target] 重新焕发生机，眨着眼醒了过来！"))
	revive_target.maxHealth -= 10 //Revival isn't healthy.
	revive_target.health -= 10
	revive_target.regenerate_icons()
	qdel(src)
	return ITEM_INTERACT_SUCCESS

//Stabilizer potion - Charged Blue
/obj/item/slimepotion/slime/chargedstabilizer
	name = "史莱姆全能稳定剂"
	desc = "一种效力极强的化学混合液，能彻底阻止史莱姆发生突变。"
	icon_state = "potcyan"

/obj/item/slimepotion/slime/chargedstabilizer/interact_with_slime(mob/living/basic/slime/interacting_slime, mob/living/user, list/modifiers)
	if(IS_UNCONSCIOUS_OR_CRIT(interacting_slime))
		to_chat(user, span_warning("这只史莱姆已经死了！"))
		return ITEM_INTERACT_BLOCKING
	if(interacting_slime.mutation_chance == 0)
		to_chat(user, span_warning("这只史莱姆本来就没有突变几率！"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你给这只史莱姆喂下了全能稳定剂。它这一周期不会突变了！"))
	interacting_slime.mutation_chance = 0
	qdel(src)
	return ITEM_INTERACT_SUCCESS
