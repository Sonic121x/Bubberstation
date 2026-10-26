/datum/signal/subspace/vocal/proc/on_heard(atom/movable/hearer)
	if (!isliving(hearer))
		return
	var/mob/living/living_hearer = hearer
	if (data["cursed"] && !IS_HERETIC_OR_MONSTER(living_hearer) && !issilicon(living_hearer) && !living_hearer.has_status_effect(/datum/status_effect/heretic_comms_immunity))
		living_hearer.mob_mood?.adjust_sanity(-5)
		living_hearer.apply_status_effect(/datum/status_effect/heretic_comms_immunity)
		if (prob(20))
			to_chat(living_hearer, span_warning("无线电里的话语在脑海中回荡，不对劲，哪里都不对劲……"))
			to_chat(living_hearer, span_warning("你觉得关闭附近的无线电也许会有所帮助。"))
			living_hearer.adjust_organ_loss(ORGAN_SLOT_BRAIN, 10, BRAIN_DAMAGE_MILD)
			living_hearer.adjust_hallucinations_up_to(40 SECONDS, 5 MINUTES)

/obj/machinery/telecomms/processor/update_overlays()
	. = ..()

	if (GLOB.processors_cursed)
		. += mutable_appearance('icons/mob/effects/heretic_aura.dmi', "heretic_aura")

/obj/machinery/telecomms/processor/examine(mob/user)
	. = ..()

	if (GLOB.processors_cursed)
		. += span_warning("可怕的秘密已经泄露。它会随时间消退……")
		. += span_notice("关闭处理器可阻止诅咒扭曲心智的效果——但之后记得重新开启。")

/datum/status_effect/heretic_comms_immunity // antispam
	id = "heretic_comms_immunity"
	alert_type = null
	tick_interval = STATUS_EFFECT_NO_TICK
	duration = 1 SECONDS
