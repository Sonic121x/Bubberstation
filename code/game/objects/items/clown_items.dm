/* Clown Items
 * Contains:
 * Soap
 * Bike Horns
 * Air Horns
 * Canned Laughter
 * Balloon Mallet
 */

/*
 * Soap
 */

/obj/item/soap
	name = "肥皂"
	desc = "一块廉价肥皂，没有气味。"
	gender = PLURAL
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "soap"
	inhand_icon_state = "soap"
	worn_icon_state = "soap"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	var/cleanspeed = 3.5 SECONDS //slower than mop
	force_string = "强力……仅针对细菌"
	var/uses = 100

/obj/item/soap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 80)
	AddComponent(/datum/component/cleaner, cleanspeed, 0.1, pre_clean_callback=CALLBACK(src, PROC_REF(should_clean)), on_cleaned_callback=CALLBACK(src, PROC_REF(decreaseUses))) //less scaling for soapies

/obj/item/soap/grind_results()
	return list(/datum/reagent/lye = 10)

/obj/item/soap/examine(mob/user)
	. = ..()
	var/max_uses = initial(uses)
	var/msg = "看起来像刚拆封一样。"
	if(uses != max_uses)
		var/percentage_left = uses / max_uses
		switch(percentage_left)
			if(0 to 0.15)
				msg = "只剩下一丁点了，你不确定还能用多久。"
			if(0.15 to 0.30)
				msg = "它已经溶掉了不少，但还能再用一阵。"
			if(0.30 to 0.50)
				msg = "虽然已不如最初，但肯定还能用。"
			if(0.50 to 0.75)
				msg = "它比原来小了一点，但肯定还能用挺久。"
			else
				msg = "它用过几次，但仍然很新。"
	. += span_notice("[msg]")

/obj/item/soap/homemade
	desc = "一块自制肥皂，闻起来像……呃……"
	icon_state = "soapgibs"
	inhand_icon_state = "soapgibs"
	worn_icon_state = "soapgibs"
	cleanspeed = 3 SECONDS // faster than base soap to reward chemists for going to the effort

/obj/item/soap/homemade/grind_results()
	return list(/datum/reagent/consumable/liquidgibs = 9, /datum/reagent/lye = 9)

/obj/item/soap/nanotrasen
	desc = "一块纳米传讯牌强效肥皂，闻起来有等离子体的气味。"
	icon_state = "soapnt"
	inhand_icon_state = "soapnt"
	worn_icon_state = "soapnt"
	cleanspeed = 2.8 SECONDS //janitor gets this
	uses = 300

/obj/item/soap/nanotrasen/grind_results()
	return list(/datum/reagent/toxin/plasma = 10, /datum/reagent/lye = 10)

/obj/item/soap/deluxe
	desc = "一块华夫公司牌豪华肥皂，散发着高档奢华的气息。"
	icon_state = "soapdeluxe"
	inhand_icon_state = "soapdeluxe"
	worn_icon_state = "soapdeluxe"
	cleanspeed = 2 SECONDS //captain gets one of these

/obj/item/soap/deluxe/grind_results()
	return list(/datum/reagent/consumable/aloejuice = 10, /datum/reagent/lye = 10)

/obj/item/soap/syndie
	desc = "一块不太可信的肥皂，由强效化学剂制成，能更快溶解血迹。"
	icon_state = "soapsyndie"
	inhand_icon_state = "soapsyndie"
	worn_icon_state = "soapsyndie"
	cleanspeed = 0.5 SECONDS //faster than mops so it's useful for traitors who want to clean crime scenes

/obj/item/soap/syndie/grind_results()
	return list(/datum/reagent/toxin/acid = 10, /datum/reagent/lye = 10)

/obj/item/soap/drone
	name = "\improper 集成肥皂模块"
	inhand_icon_state = "soapnt"
	worn_icon_state = "soapnt"
	cleanspeed = 0.5 SECONDS //can be changed if someone isn't happy
	uses = INFINITY

/obj/item/soap/omega
	name = "\improper 欧米伽肥皂"
	desc = "人类已知最先进的肥皂。细菌末日的开端。"
	icon_state = "soapomega"
	inhand_icon_state = "soapomega"
	worn_icon_state = "soapomega"
	cleanspeed = 0.3 SECONDS //Only the truest of mind soul and body get one of these
	uses = 800 //In the Greek numeric system, Omega has a value of 800

/obj/item/soap/omega/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 120) //Same slipperiness as Super Lube

/obj/item/soap/omega/grind_results()
	return list(
		/datum/reagent/consumable/potato_juice = 9,
		/datum/reagent/consumable/ethanol/lizardwine = 9,
		/datum/reagent/monkey_powder = 9,
		/datum/reagent/drug/krokodil = 9,
		/datum/reagent/toxin/acid/nitracid = 9,
		/datum/reagent/baldium = 9,
		/datum/reagent/consumable/ethanol/hooch = 9,
		/datum/reagent/bluespace = 9,
		/datum/reagent/drug/pumpup = 9,
		/datum/reagent/consumable/space_cola = 9,
		/datum/reagent/iron = 9
	)

/obj/item/soap/omega/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]把自己从时间线上擦除！看起来[user.p_theyre()]想自杀！"))
	new /obj/structure/chrono_field(user.loc, user)
	return MANUAL_SUICIDE

/obj/item/paper/fluff/stations/soap
	name = "古老清洁诗篇"
	desc = "一张辗转多人之手的旧纸。"
	default_raw_text = "<h1><b>欧米伽肥皂传说</b></h1><br><br><b>土豆</b>精华要榨汁，切莫磨成泥。<br><b>蜥蜴</b>尾巴酿成酒，倒入莫迟疑。<br>添点<b>猴子粉</b>，帮忙省力气。<br>再加些<b>鳄鱼毒</b>，冰毒会炸可不宜。<br><b>硝酸</b>配<b>脱发剂</b>，有机物都化去。<br>满满一杯<b>私酿酒</b>，罪孽也洗净。<br>撒入<b>蓝空间粉尘</b>，污渍无处匿。<br>一针<b>振奋剂</b>，让安保头疼不已。<br>一罐<b>太空可乐</b>，眼看尘垢消离。<br>尽力<b>加热</b>，让肥皂成为你的利器。<br>每样各取<b>十</b>单位，无敌肥皂便成矣。"

/obj/item/soap/suicide_act(mob/living/user)
	user.say(";他他他他他他他喵的！！", forced="soap suicide")
	user.visible_message(span_suicide("[user]把[src]举到嘴边疯狂啃咬，嘴里冒出浓密的泡沫！这下[user.p_They()]再也别想要那把 BB 枪了！"))
	do_foam(1, src, get_turf(user))
	return TOXLOSS

/obj/item/soap/proc/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	. = CLEAN_ALLOWED
	if(!check_allowed_items(atom_to_clean))
		. |= CLEAN_NO_XP|CLEAN_NO_WASH

/**
 * Decrease the number of uses the bar of soap has.
 *
 * The higher the cleaning skill, the less likely the soap will lose a use.
 * Arguments
 * * source - the source of the cleaning
 * * target - The atom that is being cleaned
 * * user - The mob that is using the soap to clean.
 */
/obj/item/soap/proc/decreaseUses(datum/source, atom/target, mob/living/user, clean_succeeded)
	if(!clean_succeeded)
		return
	var/skillcheck = 1
	if(user?.mind)
		skillcheck = user.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER)
	if(prob(skillcheck*100)) //higher level = more uses assuming RNG is nice
		uses--
	if(uses <= 0)
		noUses(user)

/obj/item/soap/proc/noUses(mob/user)
	to_chat(user, span_warning("[src]碎成了小块！"))
	qdel(src)

/obj/item/soap/nanotrasen/cyborg
	name = "内置肥皂"

/obj/item/soap/nanotrasen/cyborg/noUses(mob/user)
	to_chat(user, span_warning("[src]的化学剂用完了！请前往充电器补充。"))

/obj/item/soap/nanotrasen/cyborg/should_clean(datum/cleaning_source, atom/atom_to_clean, mob/living/cleaner)
	if(uses <= 0)
		return CLEAN_BLOCKED
	return ..()

/*
 * Bike Horns
 */

/obj/item/bikehorn
	name = "自行车喇叭"
	desc = "从自行车上拆下的喇叭，据说是用回收小丑制作的。"
	icon = 'icons/obj/art/horn.dmi'
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	worn_icon_state = "horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	throwforce = 0
	hitsound = null //To prevent tap.ogg playing, as the item lacks of force
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 7
	attack_verb_continuous = list("叭叭轰鸣")
	attack_verb_simple = list("叭叭轰鸣")
	///sound file given to the squeaky component we make in Initialize() so sub-types can specify their own sound
	var/sound_file = 'sound/items/bikehorn.ogg'

/obj/item/bikehorn/Initialize(mapload)
	. = ..()
	var/list/sound_list = list()
	sound_list[sound_file] = 1
	AddComponent(/datum/component/squeak, sound_list, 50, falloff_exponent = 20)

/obj/item/bikehorn/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(user != M && ishuman(user))
		var/mob/living/carbon/human/H = user
		if (HAS_TRAIT(H, TRAIT_CLUMSY)) //only clowns can unlock its true powers
			M.add_mood_event("honk", /datum/mood_event/honk)
	return ..()

/obj/item/bikehorn/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]庄严地把[src]对准自己的太阳穴！看起来[user.p_theyre()]想自杀！"))
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)
	return BRUTELOSS

//air horn
/obj/item/bikehorn/airhorn
	name = "气喇叭"
	desc = "卧槽，伙计，你从哪儿找到的？"
	icon_state = "air_horn"
	worn_icon_state = "horn_air"
	sound_file = 'sound/items/airhorn/airhorn2.ogg'
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT)

/datum/crafting_recipe/airhorn
	name = "气喇叭"
	result = /obj/item/bikehorn/airhorn
	reqs = list(
		/obj/item/bikehorn = 1,
		/obj/item/toy/crayon/spraycan = 1,
	)
	category = CAT_ENTERTAINMENT

//golden bikehorn
/obj/item/bikehorn/golden
	name = "金色自行车喇叭"
	desc = "金子做的？分明是香蕉矿！叭！"
	icon_state = "gold_horn"
	inhand_icon_state = "gold_horn"
	worn_icon_state = "horn_gold"
	COOLDOWN_DECLARE(golden_horn_cooldown)
	custom_materials = list(/datum/material/bananium = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/bikehorn/golden/attack()
	flip_mobs()
	return ..()

/obj/item/bikehorn/golden/attack_self(mob/user)
	flip_mobs()
	..()

/obj/item/bikehorn/golden/proc/flip_mobs(mob/living/carbon/M, mob/user)
	if(!COOLDOWN_FINISHED(src, golden_horn_cooldown))
		return
	var/turf/T = get_turf(src)
	for(M in ohearers(7, T))
		if(!HAS_TRAIT(M, TRAIT_DEAF))
			M.emote("flip")
	COOLDOWN_START(src, golden_horn_cooldown, 1 SECONDS)

/obj/item/bikehorn/rubberducky/plasticducky
	name = "塑料小黄鸭"
	desc = "可爱洗澡玩具的廉价塑料仿制品。"
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/bikehorn/rubberducky
	name = "橡皮小黄鸭"
	desc = "橡皮小鸭你真棒，洗澡有你好欢畅。橡皮小鸭呀，我好喜欢你呀～" //thanks doohl
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "rubberducky"
	inhand_icon_state = "rubberducky"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	worn_icon_state = "duck"
	sound_file = 'sound/effects/quack.ogg'

//canned laughter
/obj/item/reagent_containers/cup/soda_cans/canned_laughter
	name = "罐装笑声"
	desc = "光看着它就让人想咯咯笑。"
	icon_state = "laughter"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/laughter = 50)

//balloon mallet
/obj/item/balloon_mallet
	name = "气球大槌"
	desc = "大槌本是以沉重著称的武器，这把却由轻飘飘的气球制成。里面的空气让挥击毫无力道。被这东西打中可真丢脸。"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "balloon_mallet"
	inhand_icon_state = "balloon_mallet"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	siemens_coefficient = 0
	force = 1
	throw_speed = 1
	throwforce = 1
	throw_range = 1
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("槌击", "压平")
	attack_verb_simple = list("槌击", "压平")
	max_integrity = 20
	armor_type = /datum/armor/item_banhammer
	resistance_flags = FIRE_PROOF
	custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 10.8)

/obj/item/balloon_mallet/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user,TRAIT_BALLOON_SUTRA))
		. += "小丑星球高等种姓的神圣武器，用于将恐惧打入敌人心中。请谨慎挥舞。"

/obj/item/balloon_mallet/attack(mob/living/target, mob/living/user)
	playsound(loc, 'sound/mobs/non-humanoids/clown/hehe.ogg', 20)
	if (!isliving(target))
		return
	switch(target.mob_mood.sanity)
		if (SANITY_INSANE to SANITY_CRAZY)
			force = 8
		if (SANITY_UNSTABLE to SANITY_DISTURBED)
			force = 4
			target.add_mood_event("humiliated", /datum/mood_event/mallet_humiliation)
		if (SANITY_NEUTRAL to SANITY_GREAT)
			target.add_mood_event("humiliated", /datum/mood_event/mallet_humiliation)

	if(user.combat_mode)
		return ..(target, user)
