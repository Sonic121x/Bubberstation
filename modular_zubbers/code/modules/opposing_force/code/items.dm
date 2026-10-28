/obj/item/codeword_granter
	name = "暗语手册"
	desc = "一本黑色手册，封面上由工厂最优秀的印刷机精心印着一个红色 S。"
	icon = 'modular_zubbers/code/modules/opposing_force/icons/items.dmi'
	icon_state = "codeword_book"
	/// Number of charges the book has, limits the number of times it can be used.
	charges = 1


/obj/item/codeword_granter/attack_self(mob/living/user)
	if(!isliving(user))
		return

	to_chat(user, span_boldannounce("你开始翻阅[src]，忽然感到自己获知了以下暗语："))

	user.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_phrase_regex, "blue", src)
	user.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_response_regex, "red", src)
	to_chat(user, "<b>暗语口令</b>：[jointext(SStraitor.syndicate_code_phrase, ", ")]")
	to_chat(user, "<b>暗语应答</b>：[span_red("[jointext(SStraitor.syndicate_code_response, ", ")]")]")

	use_charge(user)


/obj/item/codeword_granter/attack(mob/living/attacked_mob, mob/living/user)
	if(!istype(attacked_mob) || !istype(user))
		return

	if(attacked_mob == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(attacked_mob.stat == DEAD)
		attacked_mob.visible_message(span_danger("[user]用[src]拍打[attacked_mob]毫无生气的尸体。"), span_userdanger("[user]用[src]拍打你毫无生气的尸体。"), span_hear("你听到拍打声。"))
	else
		attacked_mob.visible_message(span_notice("[user]用[src]猛敲[attacked_mob]的脑袋，以此教导[attacked_mob.p_them()]！"), span_boldnotice("当[user]用[src]打你时，你忽然感到自己获知了一些[span_red("特定的词语")]。"), span_hear("你听到拍打声。"))
		attacked_mob.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_phrase_regex, "blue", src)
		attacked_mob.AddComponent(/datum/component/codeword_hearing, SStraitor.syndicate_code_response_regex, "red", src)
		to_chat(attacked_mob, span_boldnotice("你忽然感到自己获知了以下暗语："))
		to_chat(attacked_mob, "<b>暗语口令</b>：[span_blue("[jointext(SStraitor.syndicate_code_phrase, ", ")]")]")
		to_chat(attacked_mob, "<b>暗语应答</b>：[span_red("[jointext(SStraitor.syndicate_code_response, ", ")]")]")
		use_charge(user)


/obj/item/codeword_granter/use_charge(mob/user)
	charges--

	if(!charges)
		var/turf/src_turf = get_turf(src)
		src_turf.visible_message(span_warning("[src]的封面与内容开始扭曲变化！它从你手中滑落！"))
		new /obj/item/book/manual/random(src_turf)
		qdel(src)


/obj/item/antag_granter/changeling
	name = "病毒注射器"
	desc = "一支蓝色注射器，装满了黏稠的红色物质。除了靠近粗大针头处的一道橙色警示条纹外，没有任何标记。"
	icon_state = "changeling_injector"
	antag_datum = /datum/antagonist/changeling
	user_message = "当你将这种物质注入体内，你开始感觉……<span class='red'><b>好多了</b></span>。"


/obj/item/antag_granter/heretic
	name = "奇怪的书"
	desc = "一本紫色封面的书，上面有一只绿色的眼睛。你发誓它正在看着你……"
	icon_state = "heretic_granter"
	antag_datum = /datum/antagonist/heretic
	user_message = "当你打开这本书，眼前闪过一道强光，<span class='hypnophrase'>世界在你眼中变得前所未有地清晰</span>。"

/obj/item/antag_granter/clock_cultist
	name = "黄铜装置"
	desc = "黄铜制成的齿轮状装置，中央悬浮着一枚玻璃透镜。"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "vanguard_cogwheel"
	antag_datum = /datum/antagonist/clock_cultist/solo
	user_message = "耳边响起嗡鸣，<span class='brass'>关于尊主的知识充满了你的头脑</span>。"

/obj/item/antag_granter/clock_cultist/attack_self(mob/user, modifiers)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/clockwork/clockwork_slab/slab = new
	user.put_in_hands(slab, FALSE)
