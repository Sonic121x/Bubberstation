//Magical traumas, caused by spells and curses.
//Blurs the line between the victim's imagination and reality
//Unlike regular traumas this can affect the victim's body and surroundings

/datum/brain_trauma/magic
	abstract_type = /datum/brain_trauma/magic
	resilience = TRAUMA_RESILIENCE_LOBOTOMY

/datum/brain_trauma/magic/lumiphobia
	name = "畏光症"
	desc = "患者对光线产生了无法解释的不良反应。"
	scan_desc = "光线过度敏感"
	symptoms = "暴露于强光时会表现出极度不适和不良反应，\
		并会竭尽全力避开有光照的区域。\
		这种敏感可能造成类似严重晒伤的皮肤损伤。"
	gain_text = span_warning("你渴望黑暗。")
	lose_text = span_notice("光线不再让你难受了。")
	/// Cooldown to prevent warning spam
	COOLDOWN_DECLARE(damage_warning_cooldown)
	var/next_damage_warning = 0

/datum/brain_trauma/magic/lumiphobia/on_life(seconds_per_tick)
	..()
	var/turf/owner_turf = owner.loc
	if(!istype(owner_turf))
		return

	if(!owner_turf.check_lumcount_above(SHADOW_SPECIES_LIGHT_THRESHOLD)) //if there's enough light, start dying
		return

	if(COOLDOWN_FINISHED(src, damage_warning_cooldown))
		to_chat(owner, span_warning("<b>光线灼烧着你！</b>"))
		COOLDOWN_START(src, damage_warning_cooldown, 10 SECONDS)
	owner.take_overall_damage(burn = 1.5 * seconds_per_tick)

/datum/brain_trauma/magic/poltergeist
	name = "骚灵缠身"
	desc = "患者似乎被某种暴力的隐形实体盯上了。"
	scan_desc = "超自然活动"
	symptoms = "身边频繁出现无缘无故的物理扰动，\
		例如物品在没有明显原因的情况下被投掷或移动。"
	gain_text = span_warning("你感觉附近有一个满怀恶意的存在。")
	lose_text = span_notice("你感觉那个满怀恶意的存在逐渐消失了。")

/datum/brain_trauma/magic/poltergeist/on_life(seconds_per_tick)
	..()
	if(!SPT_PROB(2, seconds_per_tick))
		return

	var/most_violent = -1 //So it can pick up items with 0 throwforce if there's nothing else
	var/obj/item/throwing
	for(var/obj/item/I in view(5, get_turf(owner)))
		if(I.anchored)
			continue
		if(I.throwforce > most_violent)
			most_violent = I.throwforce
			throwing = I
	if(throwing)
		throwing.throw_at(owner, 8, 2)

/datum/brain_trauma/magic/antimagic
	name = "魔法绝缘症"
	desc = "患者对魔法力量完全没有反应。"
	scan_desc = "奇术空白"
	symptoms = "完全免疫常规科学无法解释的效果，\
		例如巫师联邦成员所展示的能力。"
	gain_text = span_notice("你意识到魔法不可能是真的。")
	lose_text = span_notice("你意识到魔法或许是真的。")

/datum/brain_trauma/magic/antimagic/on_gain()
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, TRAUMA_TRAIT)
	. = ..()

/datum/brain_trauma/magic/antimagic/on_lose()
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, TRAUMA_TRAIT)
	..()

/datum/brain_trauma/magic/stalker
	name = "尾随幻影"
	desc = "患者被一个只有自己能看到的幻影跟踪。"
	scan_desc = "超感知被害妄想"
	symptoms = "始终感觉有看不见的实体在监视或追逐自己，\
		从而加剧焦虑和偏执，并偶尔幻视到附近的幽灵身影。\
		极端情况下，患者甚至会被看似无形的力量伤害。"
	gain_text = span_warning("你感觉有什么东西想杀死你……")
	lose_text = span_notice("你不再感到背后有目光盯着你了。")
	/// Type of stalker that is chasing us
	var/stalker_type = /obj/effect/client_image_holder/stalker_phantom
	/// Reference to the stalker that is chasing us
	var/obj/effect/client_image_holder/stalker_phantom/stalker
	/// Plays a sound when the stalker is near their victim
	var/close_stalker = FALSE

/datum/brain_trauma/magic/stalker/Destroy()
	QDEL_NULL(stalker)
	return ..()

/datum/brain_trauma/magic/stalker/on_gain()
	create_stalker()
	return ..()

/datum/brain_trauma/magic/stalker/proc/create_stalker()
	var/turf/stalker_source = locate(owner.x + pick(-12, 12), owner.y + pick(-12, 12), owner.z) //random corner
	stalker = new stalker_type(stalker_source, owner)

/datum/brain_trauma/magic/stalker/on_lose()
	QDEL_NULL(stalker)
	return ..()

/datum/brain_trauma/magic/stalker/on_life(seconds_per_tick)
	// Dead and unconscious people are not interesting to the psychic stalker.
	if(IS_UNCONSCIOUS_OR_CRIT(owner))
		return

	// Not even nullspace will keep it at bay.
	if(!stalker || !stalker.loc || stalker.z != owner.z)
		qdel(stalker)
		create_stalker()

	if(get_dist(owner, stalker) <= 1)
		playsound(owner, 'sound/effects/magic/demon_attack1.ogg', 50)
		owner.visible_message(span_warning("无形的利爪撕扯着[owner]！"), span_userdanger("幽灵般的利爪撕扯着你的身体！"))
		owner.take_bodypart_damage(rand(20, 45), wound_bonus=CANT_WOUND)
	else if(SPT_PROB(30, seconds_per_tick))
		stalker.forceMove(get_step_towards(stalker, owner))
	if(get_dist(owner, stalker) <= 8)
		if(!close_stalker)
			var/sound/slowbeat = sound('sound/effects/health/slowbeat.ogg', repeat = TRUE)
			owner.playsound_local(owner, slowbeat, 40, 0, channel = CHANNEL_HEARTBEAT, use_reverb = FALSE)
			close_stalker = TRUE
	else
		if(close_stalker)
			owner.stop_sound_channel(CHANNEL_HEARTBEAT)
			close_stalker = FALSE
	..()

/obj/effect/client_image_holder/stalker_phantom
	name = "???"
	desc = "它越来越近了……"
	image_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	image_state = "curseblob"

// Heretic subtype that replaces the ghost guy with a stargazer
/datum/brain_trauma/magic/stalker/cosmic
	stalker_type = /obj/effect/client_image_holder/stalker_phantom/cosmic
	random_gain = FALSE
	known_trauma = FALSE

/obj/effect/client_image_holder/stalker_phantom/cosmic
	image_icon = 'icons/mob/nonhuman-player/96x96eldritch_mobs.dmi'
	image_state = "star_gazer"
