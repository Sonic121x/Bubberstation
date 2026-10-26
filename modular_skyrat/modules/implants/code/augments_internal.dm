/obj/item/organ/cyberimp/brain/anti_sleep
	name = "CNS 应急启动器"
	desc = "这种植入体在检测到你于快速眼动睡眠周期之外陷入昏迷时，会自动尝试把你电醒。冷却时间较短。与 CNS 重启植入体冲突，两者无法共存。"
	icon_state = "brain_implant_rebooter"
	slot = ORGAN_SLOT_BRAIN_CNS //One or the other, not both.
	var/cooldown

/obj/item/organ/cyberimp/brain/anti_sleep/on_life(seconds_per_tick, times_fired)
	if(timeleft(cooldown))
		return

	var/mob/living/carbon/human/human_owner = owner
	if(!IS_UNCONSCIOUS_OR_CRIT(human_owner))

		return

	human_owner.AdjustUnconscious(-50 * seconds_per_tick, FALSE)
	human_owner.AdjustSleeping(-50 * seconds_per_tick, FALSE)
	to_chat(owner, span_notice("你感到一股能量涌过全身！"))
	cooldown = addtimer(CALLBACK(src, PROC_REF(sleepytimerend)), 5 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_DELETE_ME)
	. = ..()

/obj/item/organ/cyberimp/brain/anti_sleep/proc/sleepytimerend()
	to_chat(owner, span_notice("你听到脑中传来一声轻响，你的 CNS 应急启动器已完成充能。"))
	cooldown = null

/obj/item/organ/cyberimp/brain/anti_sleep/emp_act(severity)
	. = ..()
	var/mob/living/carbon/human/human_owner = owner
	if((organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	organ_flags |= ORGAN_FAILING
	human_owner.AdjustUnconscious(200)
	cooldown = addtimer(CALLBACK(src, PROC_REF(reboot)), (9 SECONDS / severity), TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_DELETE_ME)

/obj/item/organ/cyberimp/brain/anti_sleep/proc/reboot()
	organ_flags &= ~ORGAN_FAILING
