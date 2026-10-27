/datum/bloodsucker_clan/nosferatu
	name = CLAN_NOSFERATU
	description = "诺斯费拉图氏族无法融入船员之中，也没有避世伪装和面纱等能力。\n\
		此外，他们永远弯腰驼背、面容毁坏，稍加查看就能看出是吸血鬼，\n\
		但他们能钻进通风管道。\n\
		宠爱血仆也会永久毁容，并能钻通风管，不过必须全身赤裸。\n\
		他们还具备夜视能力，知道每根电线的用途，且行走无声。"
	clan_objective = /datum/objective/bloodsucker/kindred
	join_icon_state = "nosferatu"
	join_description = "你将永久毁容，任何查看你的人都能认出你是吸血鬼，\
		失去避世伪装能力，但获得穿着衣服也能钻通风管的能力。"
	blood_drink_type = BLOODSUCKER_DRINK_INHUMANELY
	var/ventcrawl_time = 10 SECONDS

/datum/bloodsucker_clan/nosferatu/New(datum/antagonist/bloodsucker/owner_datum)
	. = ..()
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(istype(power, /datum/action/cooldown/bloodsucker/masquerade) || istype(power, /datum/action/cooldown/bloodsucker/veil))
			bloodsuckerdatum.RemovePower(power)
	var/mob/living/mob = bloodsuckerdatum.owner.current
	if(!mob.has_quirk(/datum/quirk/badback))
		mob.add_quirk(/datum/quirk/badback)

	mob.add_traits(list(TRAIT_DISFIGURED, TRAIT_VENTCRAWLER_NUDE), BLOODSUCKER_TRAIT)

	RegisterSignal(bloodsuckerdatum, COMSIG_BLOODSUCKER_EXAMINE, PROC_REF(on_mob_examine))
	RegisterSignal(mob, COMSIG_CAN_VENTCRAWL, PROC_REF(can_ventcrawl))
	RegisterSignal(mob, COMISG_VENTCRAWL_PRE_ENTER, PROC_REF(on_ventcrawl_enter))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_EXIT, PROC_REF(on_ventcrawl_pre_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_EXIT, PROC_REF(on_ventcrawl_exit))
	RegisterSignal(mob, COMSIG_VENTCRAWL_PRE_CANCEL, PROC_REF(on_ventcrawl_cancel))

/datum/bloodsucker_clan/nosferatu/proc/get_ventcrawl_time()
	return max(ventcrawl_time - bloodsuckerdatum.GetRank() SECONDS, 2 SECONDS)

/datum/bloodsucker_clan/nosferatu/proc/can_ventcrawl(mob/living/carbon/human/owner_mob, atom/vent, provide_feedback)
	SIGNAL_HANDLER
	for(var/item in owner_mob.held_items)
		if(isnull(item))
			continue
		if(provide_feedback)
			to_chat(owner_mob, span_warning("手持物品时无法钻通风管！"))
		return FALSE
	return TRUE

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_cancel(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	animate(ventcrawl_target)

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_enter(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_pre_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	var/crawl_time = get_ventcrawl_time()
	playsound(ventcrawl_target, 'sound/effects/bang.ogg', 25)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(playsound), crawl_time, 'sound/effects/bang.ogg', 25), ventcrawl_time * 0.6)
	ventcrawl_target.Shake(pixelshiftx = 1, pixelshifty = 1, duration = crawl_time, shake_interval = 0.3 SECONDS)
	return crawl_time

/datum/bloodsucker_clan/nosferatu/proc/on_ventcrawl_exit(mob/living/carbon/human/owner_mob, obj/machinery/atmospherics/components/ventcrawl_target)
	SIGNAL_HANDLER
	// cooldown all non-inherent abilities on exit to prevent instant ambushes
	for(var/datum/action/cooldown/bloodsucker/power as anything in bloodsuckerdatum.powers)
		if(power.purchase_flags & BLOODSUCKER_DEFAULT_POWER)
			continue
		power.StartCooldown()

/datum/bloodsucker_clan/nosferatu/proc/on_mob_examine(datum/antagonist/bloodsucker/owner_datum, datum/source, mob/examiner, examine_text)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/ogled = owner_datum.owner.current
	var/mob/living/ogler = examiner
	if(isliving(examiner) && examiner != ogled && !ogler.mob_mood.has_mood_of_category("nosferatu_examine"))
		ogler.add_mood_event("nosferatu_examine", /datum/mood_event/nosferatu_examined, ogled, owner_datum.GetRank())
		ogler.adjust_disgust(owner_datum.GetRank() * 10)
	// show that they are dangerous nosferatu, as if you're gazing upon them with fear, without mentioning the clan name/antagonist name, describe their appearance
	examine_text += span_danger("[ogled]看起来像个苍白怪诞的驼背，满嘴参差不齐的黄牙，呼吸中带着浓烈的鲜血腥味。你看着这一切，既害怕又恶心。")
	examine_text += span_userdanger("[ogled]显然是个吸血鬼！")

/datum/bloodsucker_clan/nosferatu/Destroy(force)
	var/datum/action/cooldown/bloodsucker/feed/suck = locate() in bloodsuckerdatum.powers
	if(suck)
		bloodsuckerdatum.RemovePower(suck)
	bloodsuckerdatum.give_starting_powers()
	bloodsuckerdatum.owner.current.remove_quirk(/datum/quirk/badback)
	bloodsuckerdatum.owner.current.remove_traits(list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED), BLOODSUCKER_TRAIT)
	UnregisterSignal(bloodsuckerdatum, list(COMSIG_BLOODSUCKER_EXAMINE, COMSIG_CAN_VENTCRAWL, COMISG_VENTCRAWL_PRE_ENTER, COMSIG_VENTCRAWL_PRE_EXIT, COMSIG_VENTCRAWL_EXIT))
	return ..()

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_gain(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	var/list/traits_to_add = list(TRAIT_VENTCRAWLER_NUDE, TRAIT_DISFIGURED, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES, TRAIT_SILENT_FOOTSTEPS)
	ghouldatum.owner.current.add_traits(traits_to_add, GHOUL_TRAIT)
	ghouldatum.traits += traits_to_add
	ghouldatum.owner.current.update_sight()
	to_chat(ghouldatum.owner.current, span_notice("此外，你现在可以赤身钻通风管，并已永久毁容。你还拥有夜视能力，知道该剪哪根电线，且行走无声。"))

/datum/bloodsucker_clan/nosferatu/favorite_ghoul_loss(datum/antagonist/bloodsucker/source, datum/antagonist/ghoul/ghouldatum)
	ghouldatum.owner.current.update_sight()
