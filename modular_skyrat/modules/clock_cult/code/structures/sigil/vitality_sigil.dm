/obj/structure/destructible/clockwork/sigil/vitality
	name = "活力矩阵"
	desc = "一件扭曲而令人困惑的神器，接触时会汲取未开化者的生命。"
	clockwork_desc = "一件美丽的神器，会汲取被放置在它上面的异教徒的生命。"
	icon_state = "sigilvitality"
	effect_stand_time = 2.5 SECONDS // You can't permastun someone with this, so you'll need to keep them grabbed + cuffed
	idle_color = "#5e87c4"
	invocation_color = "#83cbe7"
	pulse_color = "#c761d4"
	fail_color = "#525a80"
	looping = TRUE


/obj/structure/destructible/clockwork/sigil/vitality/can_affect(mob/living/affected_mob)
	if(affected_mob.stat == DEAD)
		return FALSE

	if(affected_mob.can_block_magic(MAGIC_RESISTANCE_HOLY))
		return FALSE

	if(HAS_TRAIT(affected_mob, TRAIT_NODEATH))
		return FALSE

	if(!ishuman(affected_mob))
		return FALSE

	return TRUE


/obj/structure/destructible/clockwork/sigil/vitality/apply_effects(mob/living/affected_mob)
	. = ..()
	if(!.)
		return FALSE

	if(IS_CLOCK(affected_mob))
		return

	if(affected_mob.can_block_magic(MAGIC_RESISTANCE_HOLY))
		return

	affected_mob.Paralyze(1 SECONDS)

	if(!affected_mob.adjust_brute_loss(20, updating_health = TRUE, forced = TRUE))
		visible_message(span_clockred("[src] 未能汲取 [affected_mob] 的灵魂！"))
		return

	playsound(loc, 'modular_skyrat/modules/clock_cult/sound/magic/ratvar_attack.ogg', 40)
	if((affected_mob.stat == DEAD) || (affected_mob.get_brute_loss() >= affected_mob.maxHealth))
		affected_mob.do_jitter_animation()
		affected_mob.death()
		playsound(loc, 'sound/effects/magic/exit_blood.ogg', 60)
		to_chat(affected_mob, span_clockred("你最后的生命被抽走了……"))
		check_special_role(affected_mob)
		GLOB.clock_vitality += (affected_mob.client ? 30 : 10) // 100 (for clients) total in the ideal situation, since it'll take 7 pulses to go from full to crit
		return

	affected_mob.visible_message(span_clockred("[affected_mob] 面色褪去，看起来十分虚弱。"), span_clockred("你感到自己的灵魂正在动摇……"))
	GLOB.clock_vitality += (affected_mob.client ? 10 : 0) // Monkey or whatever? You get jackshit


/// Checks the role of whoever was killed by the vitality sigil, and does any special code if needed.
/obj/structure/destructible/clockwork/sigil/vitality/proc/check_special_role(mob/living/affected_mob)
	if(IS_CULTIST(affected_mob))
		send_clock_message(null, "纳尔西的走狗 [affected_mob] 的活力已被汲取，欢呼吧！", "<span class='clockred'>")
		spawn_reebe(src)
	else
		send_clock_message(null, "[affected_mob] 的活力已被 [src] 汲取，欢呼吧！", "<span class='clockred'>")

