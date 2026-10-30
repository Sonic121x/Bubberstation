
/obj/item/melee/sickly_blade
	name = "\improper 枯萎之刃"
	desc = "一把病态的绿色新月形刀刃，装饰着一只装饰性的眼睛。你感觉自己正被注视着……"
	icon = 'icons/obj/weapons/khopesh.dmi'
	icon_state = "eldritch_blade"
	inhand_icon_state = "eldritch_blade"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	force = 20
	throwforce = 10
	wound_bonus = 5
	exposed_wound_bonus = 15
	toolspeed = 0.375
	demolition_mod = 0.8
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	armour_penetration = 35
	attack_verb_continuous = list("攻击", "挥砍", "切割", "撕裂", "割裂", "扯碎", "切块", "撕碎")
	attack_verb_simple = list("攻击", "挥砍", "切割", "撕裂", "割裂", "扯碎", "切块", "撕碎")
	var/after_use_message = ""
	/// Tracks how many times attack_self() is called so that breaking a blade while in an arena has to be intentional
	var/escape_attempts = 0
	/// Timer that resets your escape_attempts back to 0
	var/escape_timer

/obj/item/melee/sickly_blade/examine(mob/user)
	. = ..()
	if(!check_usability(user))
		return

	//. += span_notice("You can shatter the blade to teleport to a random, (mostly) safe location by <b>activating it in-hand</b>.") // BUBBER EDIT REMOVOAL

/// Checks if the passed mob can use this blade without being stunned
/obj/item/melee/sickly_blade/proc/check_usability(mob/living/user)
	return IS_HERETIC_OR_MONSTER(user)

/obj/item/melee/sickly_blade/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return .
	if(!check_usability(user))
		to_chat(user, span_danger("你感到一股异质的智能脉冲抽击着你的心智！"))
		var/mob/living/carbon/human/human_user = user
		human_user.AdjustParalyzed(5 SECONDS)
		return TRUE
	if(SEND_SIGNAL(user, COMSIG_HERETIC_BLADE_PREATTACK, target, src) & COMPONENT_CANCEL_ATTACK_CHAIN)
		return TRUE

	return .

/obj/item/melee/sickly_blade/attack_self(mob/user)
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(heretic_datum?.unlimited_blades)
		return
	if(HAS_TRAIT(user, TRAIT_ELDRITCH_ARENA_PARTICIPANT))
		user.balloon_alert(user, "无法逃脱！")
		if(escape_attempts > 2)
			to_chat(user, span_hypnophrase(span_big("懦弱的绵羊终将被宰杀！")))
			playsound(src, SFX_SHATTER, 70, TRUE)
			var/obj/item/bodypart/to_remove = user.get_active_hand()
			to_remove.dismember()
			deltimer(escape_timer)
			qdel(src)
			return
		escape_attempts++
		escape_timer = addtimer(CALLBACK(src, PROC_REF(reset_attempts)), 2 SECONDS, TIMER_STOPPABLE)
		return
	if(HAS_TRAIT(user, TRAIT_NO_TELEPORT))
		user.balloon_alert(user, "无法击碎！")
		return
	seek_safety(user)

/obj/item/melee/sickly_blade/proc/reset_attempts()
	escape_attempts = 0
	deltimer(escape_timer)

/// Attempts to teleport the passed mob to somewhere safe on the station, if they can use the blade.
/obj/item/melee/sickly_blade/proc/seek_safety(mob/user)
	var/turf/safe_turf = find_safe_turf(z, extended_safety_checks = TRUE)
	if(check_usability(user))
		if(do_teleport(user, safe_turf, channel = TELEPORT_CHANNEL_MAGIC))
			to_chat(user, span_warning("当你击碎[src]时，你感到一阵能量涌过全身。[after_use_message]"))
		else
			to_chat(user, span_warning("你击碎了[src]，但你的恳求没有得到回应。"))
	else
		to_chat(user,span_warning("你击碎了[src]。"))
	playsound(src, SFX_SHATTER, 70, TRUE) //copied from the code for smashing a glass sheet onto the ground to turn it into a shard
	qdel(src)

/obj/item/melee/sickly_blade/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	SEND_SIGNAL(user, COMSIG_HERETIC_BLADE_ATTACK, target, src)

/obj/item/melee/sickly_blade/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	SEND_SIGNAL(user, COMSIG_HERETIC_RANGED_BLADE_ATTACK, interacting_with, src)
	return ITEM_INTERACT_BLOCKING

// Path of Rust's blade
/obj/item/melee/sickly_blade/rust
	name = "\improper 锈蚀之刃"
	desc = "这把新月形刀刃已破败不堪，渐渐锈蚀殆尽。\
		然而它依旧咬人，用参差不齐的腐牙撕裂血肉与骨骼。"
	icon_state = "rust_blade"
	inhand_icon_state = "rust_blade"
	after_use_message = "锈蚀群丘听见了你的呼唤……"

// Path of Ash's blade
/obj/item/melee/sickly_blade/ash
	name = "\improper 灰烬之刃"
	desc = "熔融而未经锻造，一团扭曲成焦炭与矿渣的金属。\
		它未被塑形，却渴望超越自身，以钝刃割出满是煤烟的伤口。"
	icon_state = "ash_blade"
	inhand_icon_state = "ash_blade"
	after_use_message = "守夜者听见了你的呼唤……"
	resistance_flags = FIRE_PROOF

// Path of Flesh's blade
/obj/item/melee/sickly_blade/flesh
	name = "\improper 血染之刃"
	desc = "一把由血肉畸变生物诞生的新月形刀刃。\
		它感知敏锐，渴望将自己自可怖起源以来所承受的痛苦散布给他人。"
	icon_state = "flesh_blade"
	inhand_icon_state = "flesh_blade"
	after_use_message = "元帅听见了你的呼唤……"

/obj/item/melee/sickly_blade/flesh/Initialize(mapload)
	. = ..()

	AddComponent(
		/datum/component/blood_walk,\
		blood_type = /obj/effect/decal/cleanable/blood,\
		blood_spawn_chance = 66.6,\
		max_blood = INFINITY,\
	)

	AddComponent(
		/datum/component/bloody_spreader,\
		blood_dna = list("Alien DNA" = get_blood_type(/datum/blood_type/xeno)),\
	)

// Path of Void's blade
/obj/item/melee/sickly_blade/void
	name = "\improper 虚空之刃"
	desc = "毫无实质，这把刀刃映照出虚无。\
		它是纯净的真实写照，以及其实现之后随之而来的混沌。"
	icon_state = "void_blade"
	inhand_icon_state = "void_blade"
	after_use_message = "贵族听见了你的呼唤……"

// Path of the Blade's... blade.
// Opting for /dark instead of /blade to avoid "sickly_blade/blade".
/obj/item/melee/sickly_blade/dark
	name = "\improper 断裂之刃"
	desc = "一把英勇的刀刃，被劈裂、被撕碎。\
		刀刃狂怒地切割着。银色的伤痕将它永远束缚于其黑暗的使命。"
	icon_state = "dark_blade"
	base_icon_state = "dark_blade"
	inhand_icon_state = "dark_blade"
	after_use_message = "破碎的冠军听见了你的呼唤……"
	///If our blade is currently infused with the mansus grasp
	var/infused = FALSE

/obj/item/melee/sickly_blade/dark/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(!infused || target == user || !isliving(target) || QDELETED(target))
		return
	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	var/mob/living/living_target = target
	if(!heretic_datum)
		return

	// Apply our heretic mark
	var/datum/heretic_knowledge/limited_amount/starting/base_blade/mark_to_apply = heretic_datum.get_knowledge(/datum/heretic_knowledge/limited_amount/starting/base_blade)
	if(!mark_to_apply)
		return
	mark_to_apply.create_mark(user, living_target)
	infused = FALSE
	update_appearance(UPDATE_ICON)
	user.update_held_items()

	if(!check_behind(user, living_target))
		return
	// We're officially behind them, apply effects
	living_target.AdjustParalyzed(1.5 SECONDS)
	living_target.apply_damage(10, BRUTE, wound_bonus = CANT_WOUND)
	living_target.balloon_alert(user, "背刺！")
	playsound(living_target, 'sound/items/weapons/guillotine.ogg', 100, TRUE)

/obj/item/melee/sickly_blade/dark/dropped(mob/user, silent)
	. = ..()
	if(infused)
		infused = FALSE
		update_appearance(UPDATE_ICON)

/obj/item/melee/sickly_blade/dark/update_icon_state()
	. = ..()
	if(infused)
		icon_state = base_icon_state + "_infused"
		inhand_icon_state = base_icon_state + "_infused"
	else
		icon_state = base_icon_state
		inhand_icon_state = base_icon_state

// Path of Cosmos's blade
/obj/item/melee/sickly_blade/cosmic
	name = "\improper 星辰之刃"
	desc = "一点天界共鸣，被塑成星辰织就的刀刃。\
		一位虹彩般的流亡者，划出光辉的轨迹，拼命渴求着统一。"
	icon_state = "cosmic_blade"
	inhand_icon_state = "cosmic_blade"
	after_use_message = "观星者听见了你的呼唤……"

// Path of Knock's blade
/obj/item/melee/sickly_blade/lock
	name = "\improper 钥匙之刃"
	desc = "既是刀，又是钥匙——开启什么？\
		它将打开何等宏大的门户？"
	icon_state = "key_blade"
	inhand_icon_state = "key_blade"
	after_use_message = "执事们听见了你的呼唤……"
	tool_behaviour = TOOL_CROWBAR
	toolspeed = 1.3

// Path of Moon's blade
/obj/item/melee/sickly_blade/moon
	name = "\improper 月华之刃"
	desc = "一把铁制刀刃，映照着大地的真理：终有一天，所有人都将加入剧团。\
		一个带来欢乐的剧团，无论他们愿不愿意，都会在他们脸上刻出笑容。"
	icon_state = "moon_blade"
	inhand_icon_state = "moon_blade"
	after_use_message = "月华听见了你的呼唤……"

// Path of Nar'Sie's blade
// What!? This blade is given to cultists as an altar item when they sacrifice a heretic.
// It is also given to the heretic themself if they sacrifice a cultist.
/obj/item/melee/sickly_blade/cursed
	name = "\improper 诅咒之刃"
	desc = "一把黑暗的刀刃，被诅咒着永远流血。在异质力量与黑暗的持续撕扯中，它被迫接受任何持刀者为主人。\
		它眼睛的角膜不断向地面滴血，那刺目的注视却始终停留在你身上。"
	force = 25
	throwforce = 15
	block_chance = 35
	wound_bonus = 25
	exposed_wound_bonus = 15
	armour_penetration = 35
	icon_state = "cursed_blade"
	inhand_icon_state = "cursed_blade"

/obj/item/melee/sickly_blade/cursed/Initialize(mapload)
	. = ..()

	var/examine_text = {"允许绘制纳尔西教派的血符文。
	异质力量与纳尔西的威能相结合，可大幅提升符文绘制速度，
	同时使这把刀刃的凶残力量远超寻常。\n
	<b>教徒还可以在手中将其击碎（右键），将自己传送到相对安全的地方。<b>"}

	AddComponent(/datum/component/cult_ritual_item, span_cult(examine_text), turfs_that_boost_us = /turf) // Always fast to draw!

/obj/item/melee/sickly_blade/cursed/attack_self_secondary(mob/user)
	seek_safety(user, TRUE)

/obj/item/melee/sickly_blade/cursed/seek_safety(mob/user, secondary_attack = FALSE)
	if(IS_CULTIST(user) && !secondary_attack)
		return FALSE
	return ..()

/obj/item/melee/sickly_blade/cursed/check_usability(mob/living/user)
	if(IS_HERETIC_OR_MONSTER(user) || IS_CULTIST(user))
		return TRUE
	if(prob(15))
		to_chat(user, span_cult_large(pick("\"一颗未被触及的心灵？有趣。\"", "\"我想阻止你也不值得费这个力气。\"", "\"去吧。我不在乎。\"", "\"你很快就会属于我。\"")))
		user.apply_damage(5, BURN, user.get_active_hand())
		playsound(src, SFX_SEAR, 25, TRUE)
		to_chat(user, span_danger("你的手发出嘶嘶声。")) // Nar nar might not care but their essence still doesn't like you
	else if(prob(15))
		to_chat(user, span_big(span_hypnophrase("LW'NAFH'NAHOR UH'ENAH'YMG EPGOKA AH NAFL MGEMPGAH'EHYE")))
		to_chat(user, span_danger("可怕而难以理解的话语涌入你的脑海！"))
		user.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15) // This can kill you if you ignore it
	return TRUE

/obj/item/melee/sickly_blade/cursed/equipped(mob/user, slot)
	. = ..()
	if(IS_HERETIC_OR_MONSTER(user))
		after_use_message = "漫宿听见了你的呼唤……"
	else if(IS_CULTIST(user))
		after_use_message = "纳尔西听见了你的呼唤……"
	else
		after_use_message = null

/obj/item/melee/sickly_blade/cursed/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	. = ..()

	var/datum/antagonist/heretic/heretic_datum = GET_HERETIC(user)
	if(!heretic_datum)
		return NONE

	// Can only carve runes with it if off combat mode.
	if(isopenturf(target) && !user.combat_mode)
		heretic_datum.try_draw_rune(user, target, drawing_time = 14 SECONDS) // Faster than pen, slower than cicatrix
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/melee/sickly_blade/cursed/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE
	return ..()

// Weaker blade variant given to people so they can participate in the heretic arena spell
/obj/item/melee/sickly_blade/training
	name = "\improper 残缺之刃"
	desc = "出于怜悯，给予那些无法接受真相之人的刀刃。\
		愿它在与你相伴的短暂时间里成为一种祝福。"
	force = 17
	armour_penetration = 0

/obj/item/melee/sickly_blade/training/check_usability(mob/living/user)
	return TRUE // If you can hold this, you can use it
