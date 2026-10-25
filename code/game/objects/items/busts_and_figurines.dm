/obj/item/statuebust
	name = "半身像"
	desc = "价值连城的古代大理石半身像，就该放在博物馆里的那种。" //or you can hit people with it
	icon = 'icons/obj/art/statue.dmi'
	icon_state = "bust"
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 2
	attack_verb_continuous = list("砸击")
	attack_verb_simple = list("砸击")
	var/impressiveness = 45

/obj/item/statuebust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/art, impressiveness)
	AddElement(/datum/element/beauty, 1000)

/obj/item/statuebust/hippocratic
	name = "希波克拉底半身像"
	desc = "著名的科斯岛希腊医生希波克拉底的半身像，他常被称为西方医学之父。"
	icon_state = "hippocratic"
	impressiveness = 50
	// If it hits the prob(reference_chance) chance, this is set to TRUE. Adds medical HUD when wielded, but has a 10% slower attack speed and is too bloody to make an oath with.
	var/reference = FALSE
	// Chance for above.
	var/reference_chance = 1
	// Minimum time inbetween oaths.
	COOLDOWN_DECLARE(oath_cd)

/obj/item/statuebust/hippocratic/evil
	reference_chance = 100

/obj/item/statuebust/hippocratic/Initialize(mapload)
	. = ..()
	if(prob(reference_chance))
		name = "庄严誓言"
		desc = "艺术爱好者会珍爱这尊希波克拉底半身像，纪念医护人员还认为不伤害他人是个好主意的时代。"
		attack_speed = CLICK_CD_SLOW
		reference = TRUE

/obj/item/statuebust/hippocratic/examine(mob/user)
	. = ..()
	if(reference)
		. += span_notice("你本可以手持半身像激活它，宣读或撤回希波克拉底誓言……但看来有人只把它当成希波克拉底的建议。这东西上面糊满了血迹和碎肉。")
		return
	. += span_notice("你可以手持半身像激活它，宣读或撤回希波克拉底誓言！除了让你成为和平主义者或获得吹嘘的资本外，没有其他效果。不会移除其他来源的和平主义。请勿食用。")

/obj/item/statuebust/hippocratic/equipped(mob/living/carbon/human/user, slot)
	..()
	if(!(slot & ITEM_SLOT_HANDS))
		return
	ADD_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/dropped(mob/living/carbon/human/user)
	..()
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_MEDICAL_HUD, type))
		return
	REMOVE_TRAIT(user, TRAIT_MEDICAL_HUD, type)

/obj/item/statuebust/hippocratic/attack_self(mob/user)
	if(!iscarbon(user))
		to_chat(user, span_warning("你想起希波克拉底誓言特指的是‘我的人类同胞’，意识到它对你毫无意义。"))
		return

	if(reference)
		to_chat(user, span_warning("你正准备宣誓，却意识到对着一尊糊满鲜血的半身像这样做，恐怕不是个好主意。"))
		return

	if(!COOLDOWN_FINISHED(src, oath_cd))
		to_chat(user, span_warning("你刚刚才宣誓或撤回誓言，现在还不能反悔。半身像厌恶地望着你。"))
		return

	COOLDOWN_START(src, oath_cd, 5 MINUTES)

	if(HAS_TRAIT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("你已经立下誓言，现在开始准备撤回它……"))
		if(do_after(user, 5 SECONDS, target = user))
			user.say("好吧，这什么希波河马的玩意儿行不通。我不干了！", forced = "hippocratic hippocrisy")
			REMOVE_TRAIT(user, TRAIT_PACIFISM, type)

	// they can still do it for rp purposes
	if(HAS_TRAIT_NOT_FROM(user, TRAIT_PACIFISM, type))
		to_chat(user, span_warning("你本来就不愿伤害他人，这不会起任何作用！"))


	to_chat(user, span_notice("你回想起希波克拉底誓言的内容，准备宣誓……"))
	if(do_after(user, 4 SECONDS, target = user))
		user.say("我宣誓，将尽我所能，运用我的判断，恪守以下誓约：", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 2 SECONDS, target = user))
		user.say("我将为病人的福祉，采取一切必要措施，避免过度治疗与放弃治疗这两种陷阱。", forced = "hippocratic oath")
	else
		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("我将牢记，我始终是社会的一员，对所有人类同胞负有特殊的责任，无论他们身心健康，还是体弱多病。", forced = "hippocratic oath")
	else

		return fuck_it_up(user)
	if(do_after(user, 3 SECONDS, target = user))
		user.say("倘若我不违背此誓言，愿我得享生活与艺术之乐，生前受人尊敬，身后受人爱戴与怀念。愿我的一切行为始终维护医道最优良的传统，愿我长久享受治愈求助者的喜悦。", forced = "hippocratic oath")
	else
		return fuck_it_up(user)

	to_chat(user, span_notice("誓言结束时，满足、理解与使命感涌上心头。你稍一想到伤害他人，便不寒而栗。"))
	ADD_TRAIT(user, TRAIT_PACIFISM, type)

// Bully the guy for fucking up.
/obj/item/statuebust/hippocratic/proc/fuck_it_up(mob/living/carbon/user)
	to_chat(user, span_warning("你像个傻子一样忘了后面的词。希波克拉底半身像失望地俯视着你。"))
	user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 2)
	COOLDOWN_RESET(src, oath_cd)

/obj/item/maneki_neko
	name = "招财猫"
	desc = "一只拿着钱币的猫咪摆件，据说能带来好运和财富，始终挥动着爪子作招手状。"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "maneki-neko"
	w_class = WEIGHT_CLASS_SMALL
	force = 5
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	attack_verb_continuous = list("砸击", "招呼", "击打")
	attack_verb_simple = list("砸击", "招呼", "击打")

/obj/item/maneki_neko/Initialize(mapload)
	. = ..()
	//Not compatible with greyscale configs because it's animated.
	add_atom_colour(pick_weight(list(COLOR_WHITE = 3, COLOR_GOLD = 2, COLOR_DARK = 1)), FIXED_COLOUR_PRIORITY)
	var/mutable_appearance/neko_overlay = mutable_appearance(icon, "maneki-neko-overlay", appearance_flags = RESET_COLOR|KEEP_APART)
	add_overlay(neko_overlay)
	AddElement(/datum/element/art, GOOD_ART)
	AddElement(/datum/element/beauty, 800)
