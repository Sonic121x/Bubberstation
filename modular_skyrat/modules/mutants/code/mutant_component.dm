/**
 * Mutant Component
 *
 * This component is used to handle all of the intermediate processes for transforming someone from a human
 * into a zombie.
 */


#define CURE_TIME (10 SECONDS)
#define REVIVE_TIME_LOWER (2 MINUTES)
#define REVIVE_TIME_UPPER (3 MINUTES)
#define IMMUNITY_LOWER (5 MINUTES)
#define IMMUNITY_UPPER (10 MINUTES)
#define RNA_REFRESH_TIME (2 MINUTES) // How soon can we extract more RNA?

/datum/component/mutant_infection
	/// The reference to our host body.
	var/mob/living/carbon/human/host
	/// The previous species of the person infected. Used when they are uninfected.
	var/datum/species/old_species = /datum/species/human
	/// A list of possible mutant species we can choose from when someone is converted.
	var/list/mutant_species = list(/datum/species/mutant/infectious/fast, /datum/species/mutant/infectious/slow)
	/// The species we have selected after we have converted.
	var/datum/species/selected_type
	/// A list of phrases people are sent while they are being converted.
	var/list/insanity_phrases = list(
		"你热得受不了！情况不对劲！",
		"你无法清醒思考，求求谁来结束这痛苦！",
		"啊啊啊啊啊啊啊啊啊！"
		)
	/// Our timer ID used for seperate parts of the infection.
	var/timer_id
	/// Have we have our RNA extracted? If so, we can't have it extracted again.
	var/rna_extracted = FALSE
	/// How much toxin damage we take per tick. - Can probably be a define.
	var/tox_loss_mod = 0.5

/datum/component/mutant_infection/Initialize()
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent

	if(host.stat == DEAD)
		var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
		timer_id = addtimer(CALLBACK(src, PROC_REF(transform_host)), revive_time, TIMER_STOPPABLE)
		to_chat(host, span_userdanger("你感到血管搏动，身体开始抽搐……"))

	RegisterSignal(parent, COMSIG_MUTANT_CURED, PROC_REF(cure_host))

	START_PROCESSING(SSobj, src)

/datum/component/mutant_infection/Destroy(force, silent)
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(parent, list(COMSIG_MUTANT_CURED, COMSIG_LIVING_DEATH))
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(host)
		remove_infection()
		host = null
	return ..()

/datum/component/mutant_infection/proc/remove_infection()
	if(ismutant(host) && old_species)
		host.set_species(old_species)
	host.revive(HEAL_ALL,force_grab_ghost = TRUE)
	to_chat(host, span_greentext("你感觉自己摆脱了那可怕的疾病！"))
	ADD_TRAIT(host, TRAIT_MUTANT_IMMUNE, "mutant_virus")
	host.mind?.remove_antag_datum(/datum/antagonist/mutant)
	host.remove_filter("infection_glow")
	host.update_appearance()
	addtimer(CALLBACK(host, /mob/living/carbon/human/proc/remove_mutant_immunity), rand(IMMUNITY_LOWER, IMMUNITY_UPPER), TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/extract_rna()
	if(rna_extracted)
		return FALSE
	to_chat(host, span_userdanger("你感觉自己的基因正在改变！"))
	rna_extracted = TRUE
	addtimer(CALLBACK(src, PROC_REF(refresh_rna)), RNA_REFRESH_TIME, TIMER_STOPPABLE)
	return TRUE

/datum/component/mutant_infection/proc/refresh_rna()
	rna_extracted = FALSE

/mob/living/carbon/human/proc/remove_mutant_immunity()
	REMOVE_TRAIT(src, TRAIT_MUTANT_IMMUNE, "mutant_virus")

/datum/component/mutant_infection/process(seconds_per_tick)
	if(!ismutant(host) && host.stat != DEAD)
		var/toxloss = host.get_tox_loss()
		if(toxloss < 50)
			host.adjust_tox_loss(tox_loss_mod * seconds_per_tick)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(host, span_userdanger("你一瞬间失去了对身体动作的控制！"))
				host.Paralyze(10)
		else
			host.adjust_tox_loss((tox_loss_mod * 2) * seconds_per_tick)
			if(SPT_PROB(10, seconds_per_tick))
				var/obj/item/bodypart/wound_area = host.get_bodypart(BODY_ZONE_CHEST)
				if(wound_area)
					var/datum/wound/slash/flesh/moderate/rotting_wound = new
					rotting_wound.apply_wound(wound_area)
				host.emote(pick(list("cough", "sneeze", "scream")))
	if(timer_id)
		return
	if(host.stat != DEAD)
		return
	if(!ismutant(host))
		to_chat(host, span_cult_large("你感到心脏停止跳动，但事情有些不对劲……\
		生命并未抛弃你破碎的身躯。你只感到一种深沉而永恒的饥饿，\
		连死亡也无法阻止。你将再次站起来！"))
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	to_chat(host, span_redtext("你将在约[revive_time/10]秒后转化。"))
	timer_id = addtimer(CALLBACK(src, PROC_REF(transform_host)), revive_time, TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/cure_host()
	SIGNAL_HANDLER
	if(!host.stat == DEAD)
		to_chat(host, span_notice("你开始感到精神焕发、充满活力！"))
	STOP_PROCESSING(SSobj, src)
	addtimer(CALLBACK(src, PROC_REF(Destroy)), CURE_TIME)

/datum/component/mutant_infection/proc/transform_host()
	timer_id = null

	selected_type = pick(mutant_species)

	if(!ismutant(host))
		old_species = host.dna.species
		host.set_species(selected_type)

	var/stand_up = (host.stat == DEAD) || (IS_UNCONSCIOUS_OR_CRIT(host))

	//Fully heal the mutant's damage the first time they rise
	regenerate()

	host.do_jitter_animation(30)
	host.visible_message(span_danger("[host]突然抽搐，[stand_up ? "摇摇晃晃地站起身，" : ""]眼中露出贪婪的饥饿！"), span_alien("你饥渴难耐！"))
	playsound(host.loc, 'sound/effects/hallucinations/far_noise.ogg', 50, TRUE)
	if(is_species(host, /datum/species/mutant/infectious/fast))
		to_chat(host, span_redtext("你是迅捷僵尸。你跑得快，攻击也更迅速；但要小心，你的身体更脆弱，更容易受到伤害。"))
	else
		to_chat(host, span_redtext("你是迟缓僵尸。你行动缓慢，攻击也更慢，但力道更重。你对大多数类型的伤害有更强的抵抗力。"))
	to_chat(host, span_alertalien("你现在是一只突变体！不要寻求治愈，不要以任何方式帮助非突变体，也不要伤害突变体同胞。你仍保留部分高级认知功能，能够进行一定程度的思考。"))
	host.mind?.add_antag_datum(/datum/antagonist/mutant)
	create_glow()
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(mutant_death))

/datum/component/mutant_infection/proc/mutant_death()
	SIGNAL_HANDLER
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	to_chat(host, span_cult_large("你感到心脏停止跳动，但事情有些不对劲……你将再次站起来！"))
	to_chat(host, span_redtext("你将在约[revive_time/10]秒后复活。"))
	timer_id = addtimer(CALLBACK(src, PROC_REF(regenerate)), revive_time, TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/regenerate()
	if(!host.mind)
		var/mob/canidate = SSpolling.poll_ghosts_for_target("你想扮演突变体（[host.name]）吗？", checked_target = host)
		if(!istype(canidate))
			return
		host.key = canidate.key
	to_chat(host, span_notice("随着组织不断愈合与重组，\
		你感到体内外都传来阵阵瘙痒。"))
	playsound(host, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	host.revive(HEAL_ALL, force_grab_ghost = TRUE)

/datum/component/mutant_infection/proc/create_glow()
	var/atom/movable/parent_movable = parent
	if(!istype(parent_movable))
		return

	parent_movable.add_filter("infection_glow", 2, list("type" = "outline", "color" = COLOR_RED, "size" = 2))
	addtimer(CALLBACK(src, PROC_REF(start_glow_loop), parent_movable), rand(0.1 SECONDS, 1.9 SECONDS))

/datum/component/mutant_infection/proc/start_glow_loop(atom/movable/parent_movable)
	var/filter = parent_movable.get_filter("infection_glow")
	if(!filter)
		return

	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)

#undef CURE_TIME
#undef REVIVE_TIME_LOWER
#undef REVIVE_TIME_UPPER
#undef IMMUNITY_LOWER
#undef IMMUNITY_UPPER
#undef RNA_REFRESH_TIME
