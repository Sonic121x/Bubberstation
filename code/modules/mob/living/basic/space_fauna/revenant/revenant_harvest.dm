// This file contains the proc we use for revenant harvesting because it is a very long and bulky proc that takes up a lot of space elsewhere

/// Container proc for `harvest()`, handles the pre-checks as well as potential early-exits for any reason.
/// Will return FALSE if we can't execute `harvest()`, or will otherwise the result of `harvest()`: a boolean value.
/mob/living/basic/revenant/proc/attempt_harvest(mob/living/carbon/human/target)
	if(LAZYFIND(drained_mobs, REF(target)))
		to_chat(src, span_revenwarning("[target] 的灵魂已经死寂空虚。"))
		return FALSE

	if(!cast_check(0))
		return FALSE

	if(draining)
		to_chat(src, span_revenwarning("你已经在汲取某个灵魂的精华了！"))
		return FALSE

	if(target.flags_1 & HOLOGRAM_1)
		target.balloon_alert(src, "没有灵魂！") // it's a machine generated visual
		return

	draining = TRUE
	var/value_to_return = harvest_soul(target)
	if(!value_to_return)
		log_combat(src, target, "中断了收割")
	draining = FALSE

	return value_to_return

/// Harvest; activated by clicking a target, will try to drain their essence. Handles all messages and handling of the target.
/// Returns FALSE if we exit out of the harvest, TRUE if it is fully done.
/mob/living/basic/revenant/proc/harvest_soul(mob/living/carbon/human/target) // this isn't in the main revenant code file because holyyyy shit it's long
	if(QDELETED(target)) // what
		return FALSE

	// cache pronouns in case they get deleted as well as be a nice micro-opt due to the multiple times we use them
	var/target_their = target.p_their()
	var/target_Their = target.p_Their()
	var/target_Theyre = target.p_Theyre()
	var/target_They_have = "[target.p_They()] [target.p_have()]"

	if(!IS_UNCONSCIOUS_OR_CRIT(target))
		to_chat(src, span_revennotice("[target_Their] 的灵魂太过强韧，无法收割。"))
		if(prob(10))
			to_chat(target, span_revennotice("你感觉好像有人在注视着你。"))
		return FALSE

	log_combat(src, target, "开始收割了")
	face_atom(target)
	var/essence_drained = rand(15, 20)

	to_chat(src, span_revennotice("你搜寻着 [target] 的灵魂。"))

	if(!do_after(src, (rand(10, 20) DECISECONDS), target, timed_action_flags = IGNORE_HELD_ITEM)) //did they get deleted in that second?
		return FALSE

	var/target_has_client = !isnull(target.client)
	if(target_has_client || target.ckey) // any target that has been occupied with a ckey is considered "intelligent"
		to_chat(src, span_revennotice("[target_Their] 的灵魂因智慧而炽燃。"))
		essence_drained += rand(20, 30)

	if(target.stat != DEAD && !HAS_TRAIT(target, TRAIT_LESSER_HUMANOID))
		to_chat(src, span_revennotice("[target_Their] 的灵魂因生命而熊熊燃烧！"))
		essence_drained += rand(40, 50)

	if(!target_has_client && HAS_TRAIT(target, TRAIT_LESSER_HUMANOID))
		to_chat(src, span_revennotice("[target_Their] 的灵魂虚弱而发育不全。它值不了多少精华。"))
		essence_drained = 5

	to_chat(src, span_revennotice("[target_Their] 的灵魂虚弱而摇摇欲坠。是时候收割了。"))

	if(!do_after(src, (rand(15, 20) DECISECONDS), target, timed_action_flags = IGNORE_HELD_ITEM))
		to_chat(src, span_revennotice("收割已中止。"))
		return FALSE

	switch(essence_drained)
		if(1 to 30)
			to_chat(src, span_revennotice("[target] 产不出太多精华。不过，积少成多。"))
		if(30 to 70)
			to_chat(src, span_revennotice("[target] 能产出中等数量的精华。"))
		if(70 to 90)
			to_chat(src, span_revenboldnotice("真是盛宴！[target] 将为你产出大量精华。"))
		if(90 to INFINITY)
			to_chat(src, span_revenbignotice("啊，完美的灵魂。[target] 将为你产出巨量精华。"))

	if(!do_after(src, (rand(15, 25) DECISECONDS), target, timed_action_flags = IGNORE_HELD_ITEM)) //how about now
		to_chat(src, span_revenwarning("你离得太远，无法汲取 [target ? "[target] 的" : "[target_their] 的"] 灵魂。连接已经断裂。"))
		return FALSE

	if(!IS_UNCONSCIOUS_OR_CRIT(target))
		to_chat(src, span_revenwarning("[target_Theyre] 现在强大到足以挣脱你的汲取了！"))
		to_chat(target, span_bolddanger("你感觉有什么东西在你全身拉扯，随后又平息下去。")) //hey, wait a minute...
		return FALSE

	to_chat(src, span_revenminor("你开始从 [target] 的灵魂中汲取精华。"))
	if(target.stat != DEAD)
		to_chat(target, span_warning("你感到一阵极其难受的抽离感，对生命的掌控正逐渐变弱……"))
	if(target.stat == SOFT_CRIT)
		target.Stun(4.6 SECONDS)

	apply_status_effect(/datum/status_effect/revenant/revealed, 5 SECONDS)
	apply_status_effect(/datum/status_effect/incapacitating/paralyzed/revenant, 5 SECONDS)

	target.visible_message(span_warning("[target] 突然微微升到空中，[target_their] 皮肤变成了灰白色。"))

	if(target.can_block_magic(MAGIC_RESISTANCE_HOLY))
		to_chat(src, span_revenminor("不对劲！[target] 似乎在抵抗汲取，让你变得毫无防备！"))
		target.visible_message(
			span_warning("[target] 瘫倒在地上。"),
			span_revenwarning("紫色的光点在视野中舞动，渐渐远去——"),
		)
		return FALSE

	var/datum/beam/draining_beam = Beam(target, icon_state = "drain_life")
	if(!do_after(src, 4.6 SECONDS, target, timed_action_flags = (IGNORE_HELD_ITEM | IGNORE_INCAPACITATED))) //As one cannot prove the existence of ghosts, ghosts cannot prove the existence of the target they were draining.
		to_chat(src, span_revenwarning("[target ? "[target] 的灵魂已" : "[target_They_have]"]被抽离你的掌控。连接已经断裂。"))
		if(target)
			target.visible_message(
				span_warning("[target] 瘫倒在地上。"),
				span_revenwarning("紫色的光点在视野中舞动，渐渐远去——"),
			)
		qdel(draining_beam)
		return FALSE

	change_essence_amount(essence_drained, FALSE, target)

	if(essence_drained <= 90 && target.stat != DEAD && !HAS_TRAIT(target, TRAIT_LESSER_HUMANOID))
		max_essence += 5
		to_chat(src, span_revenboldnotice("吸收 [target] 的鲜活灵魂提升了你的精华上限。你的新精华上限为 [max_essence]。"))

	if(essence_drained > 90)
		max_essence += 15
		perfectsouls++
		to_chat(src, span_revenboldnotice("[target] 灵魂的完美提升了你的精华上限。你的新精华上限为 [max_essence]。"))

	to_chat(src, span_revennotice("[target] 的灵魂已被大幅削弱，暂时无法再产出精华。"))
	target.visible_message(
		span_warning("[target] 瘫倒在地上。"),
		span_revenwarning("紫色的光点在视野中舞动，逐渐闭合——"),
	)

	LAZYADD(drained_mobs, REF(target))
	if(target.stat != DEAD)
		target.investigate_log("因亡魂收割而死亡。", INVESTIGATE_DEATHS)
	target.death(FALSE)

	qdel(draining_beam)
	return TRUE
