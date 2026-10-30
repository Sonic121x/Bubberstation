//These mutations change your overall "form" somehow, like size

//Epilepsy gives a very small chance to have a seizure every life tick, knocking you unconscious.
/datum/mutation/epilepsy
	name = "癫痫"
	desc = "受试者会间歇性癫痫发作。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_danger("你感到头痛。")
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/epilepsy/on_life(seconds_per_tick)
	if(SPT_PROB(0.5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick))
		trigger_seizure()

/datum/mutation/epilepsy/proc/trigger_seizure()
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return
	owner.visible_message(span_danger("[owner]开始癫痫发作！"), span_userdanger("你的癫痫发作了！"))
	owner.Unconscious(200 * GET_MUTATION_POWER(src))
	owner.set_jitter(2000 SECONDS * GET_MUTATION_POWER(src)) //yes this number looks crazy but the jitter animations are amplified based on the duration.
	owner.add_mood_event("epilepsy", /datum/mood_event/epilepsy)
	addtimer(CALLBACK(src, PROC_REF(jitter_less)), 9 SECONDS)

/datum/mutation/epilepsy/proc/jitter_less()
	if(QDELETED(owner))
		return

	owner.set_jitter(20 SECONDS)

/datum/mutation/epilepsy/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_FLASHED, PROC_REF(get_flashed_nerd))

/datum/mutation/epilepsy/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	UnregisterSignal(owner, COMSIG_MOB_FLASHED)

/datum/mutation/epilepsy/proc/get_flashed_nerd()
	SIGNAL_HANDLER

	if(!prob(30))
		return
	trigger_seizure()


//Unstable DNA induces random mutations!
/datum/mutation/bad_dna
	name = "不稳定 DNA"
	desc = "受试者会随机产生其他突变或改变外貌特征。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你感觉有些异样。")
	locked = TRUE

/datum/mutation/bad_dna/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	to_chat(owner, text_gain_indication)
	var/mob/new_mob
	if(prob(95))
		switch(rand(1,3))
			if(1)
				new_mob = owner.easy_random_mutate(NEGATIVE + MINOR_NEGATIVE)
			if(2)
				new_mob = owner.random_mutate_unique_identity()
			if(3)
				new_mob = owner.random_mutate_unique_features()
	else
		new_mob = owner.easy_random_mutate(POSITIVE)
	if(new_mob && ismob(new_mob))
		owner = new_mob
	. = owner
	on_losing(owner)


//Cough gives you a chronic cough that causes you to drop items.
/datum/mutation/cough
	name = "咳嗽"
	desc = "受试者患有慢性咳嗽。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你开始咳嗽。")
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/cough/on_life(seconds_per_tick)
	if(SPT_PROB(2.5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner))
		owner.drop_all_held_items()
		owner.emote("cough")
		if(GET_MUTATION_POWER(src) > 1)
			var/cough_range = GET_MUTATION_POWER(src) * 4
			var/turf/target = get_ranged_target_turf(owner, REVERSE_DIR(owner.dir), cough_range)
			owner.throw_at(target, cough_range, GET_MUTATION_POWER(src))

/datum/mutation/paranoia
	name = "偏执"
	desc = "受试者很容易受到惊吓，并可能产生幻觉。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_danger("尖叫声在你的脑海中回荡……")
	text_lose_indication = span_notice("脑海中的尖叫声消退了。")

/datum/mutation/paranoia/on_life(seconds_per_tick)
	if(SPT_PROB(2.5, seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner))
		owner.emote("scream")
		if(prob(25))
			owner.adjust_hallucinations(40 SECONDS)

//Dwarfism shrinks your body and lets you pass tables.
/datum/mutation/dwarfism
	name = "侏儒症"
	desc = "受试者的细胞更加紧密，使其体型缩小。"
	quality = POSITIVE
	difficulty = 16
	instability = POSITIVE_INSTABILITY_MINOR
	conflicts = list(/datum/mutation/gigantism, /datum/mutation/acromegaly)
	locked = TRUE // Default intert species for now, so locked from regular pool.

/datum/mutation/dwarfism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	// SKYRAT EDIT BEGIN
	if(owner.current_size < 1 || isteshari(owner))
		to_chat(owner, "你的身体正在缩小，但内脏却没有！糟了！")
		owner.adjust_brute_loss(25)
		return
	// SKYRAT EDIT END
	ADD_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("周围的一切似乎都变大了……"))

/datum/mutation/dwarfism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	// SKYRAT EDIT BEGIN
	if(owner.current_size < 1 || isteshari(owner))
		to_chat(owner, "内脏不再挤压你的身体，你感觉轻松了。")
		REMOVE_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
		return
	// SKYRAT EDIT END
	REMOVE_TRAIT(owner, TRAIT_DWARF, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然变大了！"), span_notice("周围的一切似乎都缩小了……"))

/datum/mutation/acromegaly
	name = "肢端肥大症"
	desc = "受试者的细胞层层堆叠，使其身高异乎寻常。"
	quality = MINOR_NEGATIVE
	difficulty = 16
	instability = NEGATIVE_STABILITY_MODERATE
	synchronizer_coeff = 1
	conflicts = list(/datum/mutation/dwarfism)

/datum/mutation/acromegaly/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_TOO_TALL, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然长高了！"), span_notice("你莫名有点想和拿投石索的小个子打一架。或者去打场篮球。"))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(head_bonk))
	owner.regenerate_icons()

/datum/mutation/acromegaly/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	REMOVE_TRAIT(owner, TRAIT_TOO_TALL, GENETIC_MUTATION)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("你恢复了平常的身高。"))
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(head_bonk))
	owner.regenerate_icons()

// This is specifically happening because they're not used to their new height and are stumbling around into machinery made for normal humans
/datum/mutation/acromegaly/proc/head_bonk(mob/living/parent)
	SIGNAL_HANDLER
	var/atom/movable/whacked_by = (locate(/obj/machinery/door/airlock) in parent.loc) || (locate(/obj/machinery/door/firedoor) in parent.loc) || (locate(/obj/structure/mineral_door) in parent.loc)
	if(!whacked_by || prob(100 - (8 *  GET_MUTATION_SYNCHRONIZER(src))))
		return
	to_chat(parent, span_danger("你的头撞到了[whacked_by]的门楣！"))
	var/dmg = HAS_TRAIT(parent, TRAIT_HEAD_INJURY_BLOCKED) ? rand(1,4) : rand(2,9)
	parent.apply_damage(dmg, BRUTE, BODY_ZONE_HEAD)
	parent.do_attack_animation(whacked_by, ATTACK_EFFECT_PUNCH)
	playsound(whacked_by, 'sound/effects/bang.ogg', 10, TRUE)
	parent.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH, 10 SECONDS)

/datum/mutation/gigantism
	name = "巨人症" //negative version of dwarfism
	desc = "受试者的细胞分布更加疏松，使其体型增大。"
	quality = MINOR_NEGATIVE
	difficulty = 12
	conflicts = list(/datum/mutation/dwarfism)

/datum/mutation/gigantism/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	// SKYRAT EDIT BEGIN
	if(owner.current_size > 1)
		to_chat(owner, "你的身体继续变大，但骨头似乎长得过头了！")
		owner.adjust_brute_loss(25) // take some DAMAGE
		return
	// SKYRAT EDIT END
	ADD_TRAIT(owner, TRAIT_GIANT, GENETIC_MUTATION)
	owner.update_transform(1.25)
	owner.visible_message(span_danger("[owner]突然变大了！"), span_notice("周围的一切似乎都缩小了……"))

/datum/mutation/gigantism/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	// SKYRAT EDIT BEGIN
	if(owner.current_size > 1)
		to_chat(owner, "骨骼终于不再疯长，你感觉轻松了。")
		return
	// SKYRAT EDIT END
	REMOVE_TRAIT(owner, TRAIT_GIANT, GENETIC_MUTATION)
	owner.update_transform(0.8)
	owner.visible_message(span_danger("[owner]突然缩小了！"), span_notice("周围的一切似乎都变大了……"))

//Clumsiness has a very large amount of small drawbacks depending on item.
/datum/mutation/clumsy
	name = "笨拙"
	desc = "受试者的脑功能受损，行为举止如同小丑。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = MINOR_NEGATIVE
	text_gain_indication = span_danger("你感到头昏。")
	mutation_traits = list(TRAIT_CLUMSY)

//Tourettes causes you to randomly stand in place and shout.
/datum/mutation/tourettes
	name = "抽动秽语综合征"
	desc = "受试者患有慢性抽动障碍，会不由自主地大喊或抽搐。"
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_NONE
	text_gain_indication = span_danger("你抽搐了一下。")
	synchronizer_coeff = 1

/datum/mutation/tourettes/on_life(seconds_per_tick)
	if(SPT_PROB(5 * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick) && !IS_UNCONSCIOUS_OR_CRIT(owner) && !owner.IsStun())
		switch(rand(1, 3))
			if(1)
				owner.emote("twitch")
			if(2 to 3)
				owner.say("[prob(50) ? ";" : ""][pick("狗屎", "尿", "操", "臭婊子", "舔屌的", "他妈的", "奶子")]", forced=name)
		var/w_offset =  rand(-2, 2)
		var/z_offset = rand(-1, 1)
		animate(owner, pixel_w = w_offset, pixel_z = z_offset, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE|ANIMATION_PARALLEL)
		animate(owner, pixel_w = -w_offset, pixel_z = -z_offset, time = 0.1 SECONDS, flags = ANIMATION_RELATIVE)


//Deafness makes you deaf.
/datum/mutation/deaf
	name = "失聪"
	desc = "受试者完全失聪，听不到任何声音。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_danger("你似乎什么也听不见了。")
	mutation_traits = list(TRAIT_DEAF)

//Monified turns you into a monkey.
/datum/mutation/race
	name = "猴化"
	desc = "一组奇怪的基因，据信是猴子与人类之间的区别所在。"
	text_gain_indication = span_green("你感觉自己格外像一只猴子。")
	text_lose_indication = span_notice("你感觉恢复了原样。")
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_MAJOR // mmmonky
	remove_on_aheal = FALSE
	locked = TRUE //Species specific, keep out of actual gene pool
	warn_admins_on_inject = TRUE
	var/datum/species/original_species = /datum/species/human
	var/original_name

/datum/mutation/race/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	if(HAS_TRAIT(owner, TRAIT_LESSER_HUMANOID))
		return
	original_species = owner.dna.species.type
	original_name = owner.real_name
	owner.monkeyize()

/datum/mutation/race/on_losing(mob/living/carbon/human/owner)
	if(owner.stat == DEAD)
		return
	. = ..()
	if(.)
		return
	if(QDELETED(owner))
		return

	owner.fully_replace_character_name(null, original_name)
	owner.humanize(original_species)

/datum/mutation/glow
	name = "发光"
	desc = "受试者的皮肤发出柔和的光芒，照亮周围区域。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的皮肤开始发出柔和的光芒。")
	instability = POSITIVE_INSTABILITY_MINI
	power_coeff = 1
	conflicts = list(/datum/mutation/glow/anti)
	var/glow_power = 2
	var/glow_range = 2.5
	var/glow_color
	var/obj/effect/dummy/lighting_obj/moblight/glow

/datum/mutation/glow/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	glow_color = get_glow_color()
	glow = owner.mob_light()

// Override modify here without a parent call, because we don't actually give an action.
/datum/mutation/glow/setup()
	if(!glow)
		return

	glow.set_light_range_power_color(glow_range * GET_MUTATION_POWER(src), glow_power, glow_color)

/datum/mutation/glow/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	QDEL_NULL(glow)

/// Returns a color for the glow effect
/datum/mutation/glow/proc/get_glow_color()
	return pick(COLOR_RED, COLOR_BLUE, COLOR_YELLOW, COLOR_GREEN, COLOR_PURPLE, COLOR_ORANGE)

/datum/mutation/glow/anti
	name = "吸光"
	desc = "受试者的皮肤吸收光线，使周围区域变暗。"
	text_gain_indication = span_notice("你周围的光似乎消失了。")
	conflicts = list(/datum/mutation/glow)
	instability = POSITIVE_INSTABILITY_MINOR
	locked = TRUE
	glow_power = -1.5

/datum/mutation/glow/anti/get_glow_color()
	return COLOR_BLACK

/datum/mutation/strong
	name = "强健"
	desc = "受试者的肌肉略微膨胀，提高整体力量与锻炼效率。"
	quality = POSITIVE
	text_gain_indication = span_notice("你感觉强壮有力。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 16
	mutation_traits = list(TRAIT_STRENGTH)

/datum/mutation/stimmed
	name = "激素强化"
	desc = "受试者的体内化学平衡更加稳定，锻炼效率得到提高。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINI
	text_gain_indication = span_notice("你感觉兴奋而有劲。")
	difficulty = 16
	mutation_traits = list(TRAIT_STIMMED)

/datum/mutation/insulated
	name = "绝缘"
	desc = "受试者的身体不导电。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的指尖麻木了。")
	text_lose_indication = span_notice("你的指尖恢复了知觉。")
	difficulty = 16
	instability = POSITIVE_INSTABILITY_MODERATE
	mutation_traits = list(TRAIT_SHOCKIMMUNE)

/datum/mutation/fire
	name = "烈焰汗液"
	desc = "受试者的皮肤会随机自燃，但最终会变得更加耐烧。"
	quality = NEGATIVE
	text_gain_indication = span_warning("你感觉很热。")
	text_lose_indication = span_notice("你感觉凉快多了。")
	conflicts = list(/datum/mutation/adaptation/heat)
	difficulty = 14
	synchronizer_coeff = 1
	power_coeff = 1

/datum/mutation/fire/on_life(seconds_per_tick)
	if(SPT_PROB((0.05+(100-dna.stability)/19.5) * GET_MUTATION_SYNCHRONIZER(src), seconds_per_tick))
		owner.adjust_fire_stacks(2 * GET_MUTATION_POWER(src))
		owner.ignite_mob()

/datum/mutation/fire/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	MODIFY_PHYSIOLOGY(owner, BURN, 0.5)

/datum/mutation/fire/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	MODIFY_PHYSIOLOGY(owner, BURN, 2)

/datum/mutation/badblink
	name = "空间不稳定"
	desc = "受试者与现实空间的联系十分薄弱，可能发生位移，常伴有极度恶心。"
	quality = NEGATIVE
	text_gain_indication = span_warning("你周围的空间令人作呕地扭曲着。")
	text_lose_indication = span_notice("你周围的空间恢复了正常。")
	difficulty = 18//high so it's hard to unlock and abuse
	instability = NEGATIVE_STABILITY_MODERATE
	synchronizer_coeff = 1
	energy_coeff = 1
	power_coeff = 1
	var/warpchance = 0

/datum/mutation/badblink/on_life(seconds_per_tick)
	if(SPT_PROB(warpchance, seconds_per_tick))
		var/warpmessage = pick(
		span_warning("[owner]的背部以令人作呕的姿势扭转了720度，随后凭空消失。"),
		span_warning("[owner]以某种奇怪的后空翻姿势翻进了另一个维度。看起来相当疼。"),
		span_warning("[owner]向左一跳，向右一步，随即跃出了现实。"),
		span_warning("[owner]的躯干开始向内翻折，最终连同[owner]一起消失在现实中。"),
		span_warning("上一刻你还看得到[owner]，下一刻[owner]就不见了。"))
		owner.visible_message(warpmessage, span_userdanger("你跌穿现实时感到一阵恶心！"))
		var/warpdistance = rand(10, 15) * GET_MUTATION_POWER(src)
		do_teleport(owner, get_turf(owner), warpdistance, channel = TELEPORT_CHANNEL_FREE)
		owner.adjust_disgust(GET_MUTATION_SYNCHRONIZER(src) * (warpchance * warpdistance))
		warpchance = 0
		owner.visible_message(span_danger("[owner]凭空出现了！"))
	else
		warpchance += 0.0625 * seconds_per_tick / GET_MUTATION_ENERGY(src)

/datum/mutation/acidflesh
	name = "酸蚀血肉"
	desc = "受试者的皮下积聚酸性化学物质，通常会致命。"
	instability = NEGATIVE_STABILITY_MAJOR
	quality = NEGATIVE
	text_gain_indication = span_userdanger("你的血肉化为酸液，可怕的灼烧感笼罩全身！")
	text_lose_indication = span_notice("你的血肉恢复了正常，全身都轻松了下来。")
	difficulty = 18//high so it's hard to unlock and use on others
	/// The cooldown for the warning message
	COOLDOWN_DECLARE(msgcooldown)

/datum/mutation/acidflesh/on_life(seconds_per_tick)
	if(SPT_PROB(13, seconds_per_tick))
		if(COOLDOWN_FINISHED(src, msgcooldown))
			to_chat(owner, span_danger("你的酸性血肉正在冒泡……"))
			COOLDOWN_START(src, msgcooldown, 20 SECONDS)
		if(prob(15))
			owner.acid_act(rand(30, 50), 10)
			owner.visible_message(span_warning("[owner]的皮肤冒起气泡并破裂。"), span_userdanger("你冒泡的血肉破裂了！好烫！"))
			playsound(owner,'sound/items/weapons/sear.ogg', 50, TRUE)

/datum/mutation/spastic
	name = "肌肉痉挛"
	desc = "受试者会发生肌肉痉挛。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_warning("你抽动了一下。")
	text_lose_indication = span_notice("你的抽动停止了。")
	difficulty = 16

/datum/mutation/spastic/on_acquiring()
	. = ..()
	if(!.)
		return
	owner.apply_status_effect(/datum/status_effect/spasms)

/datum/mutation/spastic/on_losing()
	if(..())
		return
	owner.remove_status_effect(/datum/status_effect/spasms)

/datum/mutation/extrastun
	name = "两只左脚"
	desc = "受试者的右脚变成了另一只左脚，症状包括走着走着就与地板亲密接触。"
	instability = NEGATIVE_STABILITY_MODERATE
	quality = NEGATIVE
	text_gain_indication = span_warning("你的右脚感觉……像左脚。")
	text_lose_indication = span_notice("你的右脚感觉正常了。")
	difficulty = 16

/datum/mutation/extrastun/on_acquiring()
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/datum/mutation/extrastun/on_losing()
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

///Triggers on moved(). Randomly makes the owner trip
/datum/mutation/extrastun/proc/on_move()
	SIGNAL_HANDLER

	if(prob(99.5)) //The brawl mutation
		return
	if(owner.buckled || owner.body_position == LYING_DOWN || HAS_TRAIT(owner, TRAIT_IMMOBILIZED) || owner.throwing || owner.movement_type & (VENTCRAWLING | FLYING | FLOATING))
		return //remove the 'edge' cases
	to_chat(owner, span_danger("你被自己的脚绊倒了。"))
	owner.Knockdown(30)

/datum/mutation/martyrdom
	name = "血肉殉爆"
	desc = "受试者濒死时会猛烈地炸成碎片，此过程不可逆转。\
		据悉不会损坏周围事物，但目睹这一幕会让人极其、极其眩晕。"
	instability = NEGATIVE_STABILITY_MAJOR // free stability >:)
	locked = TRUE
	quality = POSITIVE //not that cloning will be an option a lot but generally lets keep this around i guess?
	text_gain_indication = span_warning("你感到强烈的烧心感。")
	text_lose_indication = span_notice("你的内脏感觉舒坦了。")

/datum/mutation/martyrdom/on_acquiring()
	. = ..()
	if(!.)
		return
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(bloody_shower))

/datum/mutation/martyrdom/on_losing()
	. = ..()
	if(.)
		return TRUE
	UnregisterSignal(owner, COMSIG_MOB_STATCHANGE)

/datum/mutation/martyrdom/proc/bloody_shower(datum/source, new_stat)
	SIGNAL_HANDLER

	if(new_stat < HARD_CRIT)
		return
	var/list/organs = owner.get_organs_for_zone(BODY_ZONE_HEAD, TRUE)

	for(var/obj/item/organ/I in organs)
		qdel(I)

	explosion(owner, light_impact_range = 2, adminlog = TRUE, explosion_cause = src)
	for(var/mob/living/carbon/human/splashed in view(2, owner))
		var/obj/item/organ/eyes/eyes = splashed.get_organ_slot(ORGAN_SLOT_EYES)
		if(eyes)
			to_chat(splashed, span_userdanger("喷洒的鲜血遮蔽了你的视线！"))
			eyes.apply_organ_damage(5)
		else
			to_chat(splashed, span_userdanger("你被一股……血浪击倒了？！"))
		splashed.Stun(2 SECONDS)
		splashed.set_eye_blur_if_lower(40 SECONDS)
		splashed.adjust_confusion(3 SECONDS)
	for(var/mob/living/silicon/borgo in view(2, owner))
		to_chat(borgo, span_userdanger("喷洒的鲜血使你的传感器失灵了！"))
		borgo.Paralyze(6 SECONDS)
	owner.investigate_log("因血肉殉爆突变而炸成了碎片。", INVESTIGATE_DEATHS)
	owner.gib(DROP_ALL_REMAINS)

/datum/mutation/headless
	name = "头部过敏性排斥综合征"
	desc = "简称 H.A.R.S.。受试者的身体排斥头部，导致大脑缩入胸腔。\
		逆转这种突变非常危险，不过能够再生头部的非致命器官。"
	instability = NEGATIVE_STABILITY_MAJOR
	difficulty = 12 //pretty good for traitors
	quality = NEGATIVE //holy shit no eyes or tongue or ears
	text_gain_indication = span_warning("你感觉有些不对劲。")
	warn_admins_on_inject = TRUE

/datum/mutation/headless/on_acquiring()
	. = ..()
	if(!.)
		return

	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.Remove(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)
		brain.zone = BODY_ZONE_CHEST
		brain.Insert(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)

	var/obj/item/bodypart/head/head = owner.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		owner.visible_message(span_warning("[owner]的头颅伴着令人作呕的碎裂声炸开了！"), ignored_mobs = list(owner))
		new /obj/effect/gibspawner/generic(get_turf(owner), owner)
		head.drop_organs()
		head.dismember(dam_type = BRUTE, silent = TRUE)
		qdel(head)
	RegisterSignal(owner, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB, PROC_REF(abort_attachment))

/datum/mutation/headless/on_losing()
	. = ..()
	if(.)
		return TRUE

	UnregisterSignal(owner, COMSIG_ATTEMPT_CARBON_ATTACH_LIMB)
	var/successful = owner.regenerate_limb(BODY_ZONE_HEAD)
	if(!successful)
		stack_trace("HARS mutation head regeneration failed! (usually caused by headless syndrome having a head)")
		return TRUE
	var/obj/item/organ/brain/brain = owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(brain)
		brain.Remove(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)
		brain.zone = initial(brain.zone)
		brain.Insert(owner, special = TRUE, movement_flags = NO_ID_TRANSFER)

	var/list/excluded_zones = GLOB.all_body_zones - BODY_ZONE_HEAD
	owner.dna.species.regenerate_organs(owner, replace_current = FALSE, excluded_zones = excluded_zones) //replace_current needs to be FALSE to prevent weird adding and removing mutation healing
	owner.apply_damage(damage = 50, damagetype = BRUTE, def_zone = BODY_ZONE_HEAD) //and this to DISCOURAGE organ farming, or at least not make it free.
	owner.visible_message(span_warning("[owner]的头颅伴着令人作呕的碎裂声重新长了出来！"), span_warning("你的头颅伴着令人作呕的碎裂声重新长了出来！好疼。"))
	new /obj/effect/gibspawner/generic(get_turf(owner), owner)

/datum/mutation/headless/proc/abort_attachment(datum/source, obj/item/bodypart/new_limb, special) //you aren't getting your head back
	SIGNAL_HANDLER

	if(istype(new_limb, /obj/item/bodypart/head))
		return COMPONENT_NO_ATTACH

// You bleed faster but regenerate blood faster
/datum/mutation/bloodier
	name = "超代谢造血"
	desc = "受试者的新陈代谢加速，造血速度大幅提高。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINOR
	text_gain_indication = span_notice("你感觉心跳加快了。")
	text_lose_indication = span_notice("你的心跳慢了下来。")
	difficulty = 16
	synchronizer_coeff = 1
	power_coeff = 1

	/// Modifies the bleed rate of the owner
	var/bleed_rate = 1.5
	/// Modifies the blood regeneration rate of the owner
	var/blood_regen_rate = 6
	/// Tracks if we've modified the physiology of the owner
	VAR_PRIVATE/physiology_modified = FALSE

/datum/mutation/bloodier/on_acquiring(mob/living/carbon/human/owner)
	. = ..()
	if(!.)
		return
	if(!physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, blood_regen_rate)
		physiology_modified = TRUE

/datum/mutation/bloodier/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	if(physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 1/bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, 1/blood_regen_rate)
		physiology_modified = FALSE // just in case

/datum/mutation/bloodier/setup()
	if(owner && physiology_modified)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, 1/bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, 1/blood_regen_rate)
		physiology_modified = FALSE

	bleed_rate = clamp(initial(bleed_rate) * GET_MUTATION_SYNCHRONIZER(src) * GET_MUTATION_POWER(src), 1, 2)
	blood_regen_rate = clamp(initial(blood_regen_rate) * GET_MUTATION_POWER(src), 4, 12)

	if(owner && !physiology_modified) // redundant but just in case
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLEED, bleed_rate)
		MODIFY_PHYSIOLOGY(owner, PHYS_COEFF_BLOOD_REGEN, blood_regen_rate)
		physiology_modified = TRUE
	return TRUE

// You eat rocks
/datum/mutation/rock_eater
	name = "食岩者"
	desc = "受试者的身体能够消化岩石与矿物。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MINI
	text_gain_indication = span_notice("你突然很想吃石头。")
	text_lose_indication = span_notice("你想吃点正常的饭菜。")
	difficulty = 12
	mutation_traits = list(TRAIT_ROCK_EATER)
	conflicts = list(/datum/mutation/rock_absorber)

// You eat rock but also get buffs from them
/datum/mutation/rock_absorber
	name = "岩石吸收"
	desc = "受试者的身体能够消化岩石与矿物，并获得其特性。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MAJOR
	text_gain_indication = span_notice("你无比渴望吃石头。")
	text_lose_indication = span_notice("你想吃点正常的饭菜。")
	mutation_traits = list(TRAIT_ROCK_EATER, TRAIT_ROCK_METAMORPHIC)
	conflicts = list(/datum/mutation/rock_eater)
	locked = TRUE

// Soft crit is disabed
/datum/mutation/inexorable
	name = "坚韧不屈"
	desc = "受试者的身体能够超越正常人类的耐力极限继续行动，但会因此受到内部损伤。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你感觉势不可挡。")
	text_lose_indication = span_notice("你突然觉得自己更像普通人了。")
	difficulty = 24
	synchronizer_coeff = 1
	mutation_traits = list(TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA)

/datum/mutation/inexorable/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(acquirer, COMSIG_LIVING_HEALTH_UPDATE, PROC_REF(check_health))
	check_health()

/datum/mutation/inexorable/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_LIVING_HEALTH_UPDATE)
	REMOVE_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))

/datum/mutation/inexorable/proc/check_health(...)
	SIGNAL_HANDLER
	if(owner.health > owner.crit_threshold || IS_UNCONSCIOUS_OR_CRIT(owner))
		REMOVE_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))
	else
		ADD_TRAIT(owner, TRAIT_FORCE_WHISPER, REF(src))

/datum/mutation/inexorable/on_life(seconds_per_tick)
	if(owner.health > owner.crit_threshold || IS_UNCONSCIOUS_OR_CRIT(owner) || HAS_TRAIT(owner, TRAIT_STASIS))
		return
	if(HAS_TRAIT(owner, TRAIT_NOCRITDAMAGE) && owner.health <= owner.hardcrit_threshold + 10)
		return
	// Gives you 30 seconds of being in fake soft crit... give or take
	if(HAS_TRAIT(owner, TRAIT_TOXIMMUNE) || HAS_TRAIT(owner, TRAIT_TOXINLOVER))
		owner.adjust_brute_loss(1 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
	else
		owner.adjust_tox_loss(0.5 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
		owner.adjust_brute_loss(0.5 * seconds_per_tick * GET_MUTATION_SYNCHRONIZER(src))
	// Offsets suffocation but not entirely
	owner.adjust_oxy_loss(-0.5 * seconds_per_tick)

/datum/mutation/limb_regeneration
	name = "再生"
	desc = "在休息与营养充足时，受试者的身体能够在睡眠中再生失去的肢体或器官。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你感到一阵奇怪的刺痒。")
	text_lose_indication = span_notice("奇怪的刺痒感消退了。")
	difficulty = 20
	synchronizer_coeff = 1
	power_coeff = 1

	/// Threshold of nutrition required to regenerate limbs/organs
	var/nutrition_threshold = NUTRITION_LEVEL_FED * 0.85
	/// If TRUE we notified the user they could probably use the mutation if they eat/slept first - comes with a bonus to trigger chance
	VAR_PRIVATE/notified_of_ability = FALSE

/datum/mutation/limb_regeneration/can_acquire(mob/living/carbon/human/acquirer)
	return !HAS_TRAIT(acquirer, TRAIT_NOHUNGER)

/datum/mutation/limb_regeneration/on_life(seconds_per_tick)
	if(owner.stat >= HARD_CRIT)
		return
	if(!SPT_PROB(5 * (notified_of_ability ? 4 : 1) * (GET_MUTATION_POWER(src) ** 2), seconds_per_tick))
		return

	var/list/missing_limbs = owner.get_missing_limbs()
	var/list/missing_important_organs = owner.get_missing_organs(include_appendix = (GET_MUTATION_POWER(src) > 1)) // appendix can regrow if you have power
	var/list/missing_special_organs = list()
	for(var/organ_type in owner.dna?.species?.mutant_organs)
		if(!owner.get_organ_by_type(organ_type) && should_visual_organ_apply_to(organ_type, owner))
			missing_special_organs += organ_type

	if(!length(missing_limbs) && !length(missing_important_organs) && !length(missing_special_organs))
		return

	if(owner.nutrition <= nutrition_threshold)
		if(IS_UNCONSCIOUS(owner) && !notified_of_ability)
			to_chat(owner, span_green("你感到一阵奇怪的刺痒，仿佛身体正在尝试做些什么——不过你觉得应该先吃顿饭。"))
			notified_of_ability = TRUE
		return
	if(!IS_UNCONSCIOUS(owner))
		if(owner.nutrition > nutrition_threshold && !notified_of_ability)
			to_chat(owner, span_green("你感到一阵奇怪的刺痒，仿佛身体正在尝试做些什么——不过你觉得应该先睡上一觉。"))
			notified_of_ability = TRUE
		return

	notified_of_ability = FALSE
	// "core organs" and limbs are prioritized
	if(length(missing_important_organs) || length(missing_limbs))
		if(length(missing_important_organs) && (prob(50) || !length(missing_limbs)))
			var/replacement_type = owner.dna.species.get_mutant_organ_type_for_slot(pick(missing_important_organs))
			var/obj/item/organ/replacement = new replacement_type()
			replacement.Insert(owner, special = TRUE)
			to_chat(owner, span_green("刺痒感越来越强烈，最终你感觉到新的[replacement.name]在原来的位置长了出来！"))
		else
			var/replacing_zone = pick(missing_limbs)
			owner.regenerate_limb(replacing_zone)
			var/obj/item/bodypart/replacement = owner.get_bodypart(replacing_zone)
			to_chat(owner, span_green("刺痒感越来越强烈，最终你感觉到新的[chinese_body_zone_display(replacement.plaintext_zone)]在原来的位置长了出来！"))
			owner.visible_message(span_warning("[owner]的[chinese_body_zone_display(replacement.plaintext_zone)]在一阵响亮而怪异的声音中再生了！"), ignored_mobs = list(owner))
		owner.adjust_nutrition(-NUTRITION_LEVEL_FULL * 0.5 * GET_MUTATION_SYNCHRONIZER(src))
		playsound(owner, 'sound/effects/magic/demon_consume.ogg', 33, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	// "cosmetic" organs are second priority and cheaper to regenerate
	if(length(missing_special_organs))
		var/replacement_type = pick(missing_special_organs)
		var/obj/item/organ/replacement = new replacement_type()
		replacement.Insert(owner, special = TRUE)
		to_chat(owner, span_green("刺痒感越来越强烈，最终你感觉到新的[replacement.name]在原来的位置长了出来！"))
		if(replacement.organ_flags & ORGAN_EXTERNAL)
			owner.visible_message(span_warning("[owner]的[replacement.name]在一阵响亮而怪异的声音中再生了！"), ignored_mobs = list(owner))
		owner.adjust_nutrition(-NUTRITION_LEVEL_FULL * 0.3 * GET_MUTATION_SYNCHRONIZER(src))
		playsound(owner, 'sound/effects/magic/demon_consume.ogg', 33, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		return

	stack_trace("Limb regeneration failed to find a missing limb or organ to regenerate for [owner] despite passing the checks")

/datum/mutation/chemical_allergy
	name = "化学过敏"
	desc = "受试者的身体对几乎所有药物或毒品过敏，会导致短暂的基因不稳定波动及其他副作用。"
	quality = NEGATIVE
	instability = NEGATIVE_STABILITY_MAJOR
	text_gain_indication = span_warning("你的皮肤感到一阵奇怪的刺激。")
	text_lose_indication = span_notice("皮肤上的刺激感消退了。")
	difficulty = 20

	/// Typecache of reagents that trigger the allergy
	var/static/list/danger_reagents
	/// If we're currently experiencing negative effects
	VAR_PRIVATE/was_experiencing_allergy = FALSE

/datum/mutation/chemical_allergy/New()
	. = ..()
	if(length(danger_reagents))
		return

	danger_reagents = typecacheof(list(
		/datum/reagent/medicine,
		/datum/reagent/drug,
	)) - typecacheof(list(
		/datum/reagent/medicine/mannitol,
		/datum/reagent/medicine/mutadone,
	)) - GLOB.allergy_reagent_blacklist

/datum/mutation/chemical_allergy/on_acquiring(mob/living/carbon/human/acquirer)
	. = ..()
	if(!.)
		return
	RegisterSignal(acquirer, COMSIG_LIVING_HEALTHSCAN, PROC_REF(on_healthscan))

/datum/mutation/chemical_allergy/on_losing(mob/living/carbon/human/owner)
	. = ..()
	if(.)
		return
	UnregisterSignal(owner, COMSIG_LIVING_HEALTHSCAN)

/datum/mutation/chemical_allergy/proc/on_healthscan(datum/source, list/render_list, advanced, mob/user, mode, tochat)
	SIGNAL_HANDLER

	render_list += "<span class='alert ml-1'>"
	render_list += conditional_tooltip("受试者患有[name]", "受试者会对大多数药物产生不良反应——\
		除非万不得已，否则治疗时应避免使用化学药物。", tochat)
	render_list += "</span><br>"

/datum/mutation/chemical_allergy/on_life(seconds_per_tick)
	if(!has_danger_reagent())
		if(was_experiencing_allergy)
			was_experiencing_allergy = FALSE
			instability *= 2
			owner.dna.update_instability()
		return
	if(!SPT_PROB(80, seconds_per_tick))
		return
	if(!was_experiencing_allergy)
		was_experiencing_allergy = TRUE
		instability *= 0.5 // halves the negative instability it rewards, which could push you into danger territory!
		owner.dna.update_instability()

	if(SPT_PROB(66, seconds_per_tick))
		owner.set_stutter_if_lower(4 SECONDS)
	if(SPT_PROB(33, seconds_per_tick))
		owner.adjust_disgust(24, DISGUST_LEVEL_VERYDISGUSTED)
		owner.adjust_tox_loss(pick(2, 3, 4), forced = TRUE)
	if(SPT_PROB(12, seconds_per_tick))
		owner.adjust_jitter_up_to(6 SECONDS, 36 SECONDS)
		owner.adjust_dizzy_up_to(6 SECONDS, 36 SECONDS)
		owner.adjust_blood_volume(-pick(12, 16, 20, 24), minimum = BLOOD_VOLUME_OKAY)
	if(SPT_PROB(6, seconds_per_tick))
		owner.adjust_confusion_up_to(4 SECONDS, 12 SECONDS)
		owner.losebreath = max(owner.losebreath, 4)

/datum/mutation/chemical_allergy/proc/has_danger_reagent()
	for(var/datum/reagent/reagent as anything in owner.reagents?.reagent_list)
		if(!is_type_in_typecache(reagent, danger_reagents))
			continue
		if(!reagent.metabolizing || reagent.volume < 1)
			continue
		return TRUE

	return FALSE

/datum/mutation/venomous_strikes
	name = "毒牙利爪"
	desc = "受试者的身体产生一种弱毒素，可通过抓挠或撕咬注入他人体内。\
		若自身接触到同类毒素，也能将其从血液中过滤掉。"
	quality = POSITIVE
	instability = POSITIVE_INSTABILITY_MODERATE
	text_gain_indication = span_notice("你的牙齿和指甲感觉更尖锐了。")
	text_lose_indication = span_notice("你的牙齿和指甲感觉更钝了。")
	/// Type of chem to inject
	var/venom_type = /datum/reagent/toxin
	/// Amount of chem to inject per attack
	var/venom_amount = 3

/datum/mutation/venomous_strikes/on_acquiring(mob/living/carbon/human/owner)
	text_gain_indication = (owner.get_active_hand()?.unarmed_attack_effect == ATTACK_EFFECT_CLAW) ? span_notice("你的牙齿和爪子感觉更尖锐了。") : initial(text_gain_indication)
	. = ..()
	if(!.)
		return
	apply_venom()

/datum/mutation/venomous_strikes/on_losing(mob/living/carbon/human/owner)
	text_lose_indication = (owner.get_active_hand()?.unarmed_attack_effect == ATTACK_EFFECT_CLAW) ? span_notice("你的牙齿和爪子感觉更钝了。") : initial(text_lose_indication)
	. = ..()
	if(.)
		return
	remove_venom()

/datum/mutation/venomous_strikes/vv_edit_var(var_name, var_value)
	if(var_name != NAMEOF(src, venom_type) && var_name != NAMEOF(src, venom_amount))
		return ..()

	remove_venom()
	. = ..()
	apply_venom()

/datum/mutation/venomous_strikes/pre_apply_chromosome()
	apply_venom()

/datum/mutation/venomous_strikes/post_apply_chromosome()
	remove_venom()

/datum/mutation/venomous_strikes/proc/apply_venom()
	owner.AddElement(/datum/element/venomous, venom_type, venom_amount * GET_MUTATION_POWER(src), INJECT_CHECK_IGNORE_SPECIES)

/datum/mutation/venomous_strikes/proc/remove_venom()
	owner.RemoveElement(/datum/element/venomous, venom_type, venom_amount * GET_MUTATION_POWER(src), INJECT_CHECK_IGNORE_SPECIES)

/datum/mutation/venomous_strikes/on_life(seconds_per_tick)
	owner.reagents.remove_reagent(venom_type, round(venom_amount * 0.33, CHEMICAL_VOLUME_ROUNDING) * seconds_per_tick)
