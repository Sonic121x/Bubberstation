/obj/item/organ/zombie_infection
	name = "溃烂脓液"
	desc = "一张由脓液与内脏构成的黑色网状物。"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ZOMBIE
	icon_state = "blacktumor"
	var/causes_damage = TRUE
	var/living_transformation_time = 3 SECONDS
	var/converts_living = FALSE

	var/revive_time_min = 45 SECONDS
	var/revive_time_max = 70 SECONDS
	var/timer_id

	var/datum/weakref/ghost_poll

/obj/item/organ/zombie_infection/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)
	GLOB.zombie_infection_list += src

/obj/item/organ/zombie_infection/Destroy()
	GLOB.zombie_infection_list -= src
	. = ..()

/obj/item/organ/zombie_infection/feel_for_damage(self_aware)
	// keep stealthy for now, revisit later
	return ""

/obj/item/organ/zombie_infection/on_mob_insert(mob/living/carbon/new_owner, special = FALSE, movement_flags)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/organ/zombie_infection/on_mob_remove(mob/living/carbon/new_owner, special = FALSE, movement_flags)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	if(timer_id)
		deltimer(timer_id)
	QDEL_NULL(ghost_poll)

/obj/item/organ/zombie_infection/on_find(mob/living/finder)
	to_chat(finder, span_warning("头颅内部是一张令人作呕的黑色 \
		脓液与内脏之网，像某种 \
		生物背带一样紧紧缠绕着大脑。"))

/obj/item/organ/zombie_infection/process(seconds_per_tick)
	if(!owner)
		return
	if(!(src in owner.organs))
		Remove(owner)
	if(!(owner.mob_biotypes & MOB_ORGANIC) || HAS_TRAIT(owner, TRAIT_UNHUSKABLE)) // does not process in inorganic things
		return
	if (causes_damage && !owner.has_status_effect(/datum/status_effect/zombie) && owner.stat != DEAD)
		owner.adjust_tox_loss(0.5 * seconds_per_tick)
		if (SPT_PROB(5, seconds_per_tick))
			to_chat(owner, span_danger("你感到恶心……"))
	if(timer_id || HAS_TRAIT(owner, TRAIT_SUICIDED) || !owner.get_organ_by_type(/obj/item/organ/brain))
		return
	if(owner.stat != DEAD && !converts_living)
		return
	if(!owner.has_status_effect(/datum/status_effect/zombie))
		to_chat(owner, span_cult_large("你能感觉到自己的心脏正在停止跳动，但有些事不对劲…… \
		生命并未抛弃你这具残破的躯体。你只感到一种深沉而不可动摇的饥饿， \
		连死亡也无法阻止它，你终将再度站起！"))
	var/revive_time = rand(revive_time_min, revive_time_max)
	var/flags = TIMER_STOPPABLE
	timer_id = addtimer(CALLBACK(src, PROC_REF(zombify), owner), revive_time, flags)

/obj/item/organ/zombie_infection/proc/zombify(mob/living/carbon/target)
	timer_id = null

	if(!converts_living && owner.stat != DEAD)
		return

	// mindless zombies are nerfed a bit to encourage infecting real players instead of random morgue bodies
	target.apply_status_effect(isnull(target.mind) ? /datum/status_effect/zombie/mindless : /datum/status_effect/zombie)

	var/stand_up = IS_UNCONSCIOUS(target)

	//Fully heal the zombie's damage the first time they rise
	if(!target.heal_and_revive(0, span_danger("[target] 突然抽搐起来，[stand_up ? "踉跄着站起身来，" : ""]双眼浮现出贪婪的饥饿！")))
		return

	zombie_welcome(target)
	if(target.mind || target.client)
		if(stand_up)
			target.get_up()
		return

	ghost_poll = WEAKREF(target.AddComponent( \
		/datum/component/ghost_direct_control, \
		ban_type = NONE, \
		poll_ignore_key = POLL_IGNORE_RECOVERED_CREW, \
		poll_question = "你想成为 [span_green("[isnull(target.mind) ? "无意识僵尸" : "僵尸"]")] 吗？", \
		role_name = "僵尸", \
		extra_control_checks = CALLBACK(src, PROC_REF(check_ghost_control_eligibility)), \
		after_assumed_control = CALLBACK(src, PROC_REF(after_ghost_control)), \
		joinable_mobs_title = "僵尸", \
	))
	SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_TOMBSTONE] = TRUE

/obj/item/organ/zombie_infection/proc/check_ghost_control_eligibility(mob/candidate)
	if(QDELETED(src) || QDELETED(owner))
		return FALSE
	if(!owner.has_status_effect(/datum/status_effect/zombie) || owner.stat == DEAD)
		return FALSE
	return TRUE

/obj/item/organ/zombie_infection/proc/after_ghost_control(mob/candidate)
	owner.Knockdown(living_transformation_time)
	zombie_welcome(owner)
	ghost_poll = null

/obj/item/organ/zombie_infection/proc/zombie_welcome(mob/living/carbon/new_zombie)
	if(new_zombie.client)
		to_chat(new_zombie, span_alien("你饥渴难耐！"))
		to_chat(new_zombie, span_alertalien("你现在是一具僵尸！不要寻求治愈，不要以任何方式帮助任何非僵尸，不要伤害你的僵尸同胞，并通过杀死他人来传播疾病。你是饥饿与暴力的造物。"))
		playsound(new_zombie, 'sound/effects/hallucinations/far_noise.ogg', 50, 1)

	new_zombie.do_jitter_animation(living_transformation_time)
	new_zombie.Stun(living_transformation_time)

/obj/item/organ/zombie_infection/nodamage
	causes_damage = FALSE
