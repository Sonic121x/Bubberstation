/datum/religion_rites/dream_projection
	name = "梦境投射"
	desc = "将你的梦境意识星体投射到你的一名追随者心中。\
		投射期间，你处于睡眠状态，并能通过选定追随者的双眼观察。\
		只有他们能听见你，你无法以任何方式与世界互动。\
		投射可随时结束，但若你被唤醒、受到攻击，\
		或追随者死亡，投射会提前终止。"
	favor_cost = 100
	ritual_length = 15 SECONDS

/datum/religion_rites/dream_projection/New()
	. = ..()
	ritual_invocations = list(
		"我们羊群中的一员迷失了，在清醒的世界中走失……",
		"牧者的职责，就是引导那些找不到路的人……",
		"让我走入他们的清醒梦境，为他们指明归途……",
	)

/datum/religion_rites/dream_projection/perform_rite(mob/living/user, atom/religious_tool)
	var/list/followers = list()
	for(var/mob/living/follower as anything in GLOB.mob_living_list)
		if(follower.mind?.holy_role && user != follower)
			followers += follower

	if(!length(followers))
		to_chat(user, span_warning("你没有可投射的追随者！"))
		return FALSE

	return ..()

/datum/religion_rites/dream_projection/post_invoke_effects(mob/living/user, atom/religious_tool)
	. = ..()
	var/list/followers = list()
	for(var/mob/living/follower as anything in GLOB.mob_living_list)
		if(follower.mind?.holy_role && user != follower)
			followers += follower

	if(!length(followers))
		refund(0.8)
		return

	var/mob/living/carbon/human/target = tgui_input_list(user, "选择一名要投射进入的追随者：", "梦境投射", followers)
	if(QDELETED(target) || target.stat == DEAD || isnull(target.mind?.holy_role))
		refund(0.8)
		return

	if(!user.apply_status_effect(/datum/status_effect/dream_projection, target))
		to_chat(user, span_warning("你没能入睡。"))
		refund(0.8)
		return

/datum/status_effect/dream_projection
	id = "dream_projection"
	duration = STATUS_EFFECT_PERMANENT
	alert_type = null
	on_remove_on_mob_delete = TRUE

	/// Target of the projection
	VAR_PRIVATE/mob/living/carbon/human/target
	/// Projection mob that the owner is put into
	VAR_PRIVATE/mob/eye/imaginary_friend/dream_projection/projection

/datum/status_effect/dream_projection/on_creation(mob/living/new_owner, mob/living/carbon/human/target)
	if(isnull(target))
		stack_trace("Dream projection created without a target!")
		qdel(src)
		return

	src.target = target
	return ..()

/datum/status_effect/dream_projection/get_examine_text()
	return "正处于沉睡，但双眼目光遥远，仿佛身在远方……"

/datum/status_effect/dream_projection/on_apply()
	if(!owner.SetSleeping(20 SECONDS))
		to_chat(owner, span_warning("你没能入睡。"))
		return FALSE

	. = ..()
	RegisterSignal(target, COMSIG_QDELETING, PROC_REF(end_projection))
	RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(end_projection))

	ADD_TRAIT(owner, TRAIT_DREAMING, TRAIT_STATUS_EFFECT(id))
	RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_KNOCKEDOUT), PROC_REF(interrupt_projection))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(interrupt_projection))
	RegisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(interrupt_projection))

	projection = new(target.loc)
	projection.AddComponent(/datum/component/temporary_body, old_mind = owner.mind)
	projection.real_name = owner.real_name
	projection.gender = owner.gender
	projection.human_icon = getFlatIcon(owner)
	projection.PossessByPlayer(owner.ckey)
	projection.attach_to_owner(target)

	RegisterSignal(projection, COMSIG_QDELETING, PROC_REF(stop_projection))

	owner.add_filter(id, 1, list("type" = "outline", "color" = "#aee2b2", "alpha" = 0, "size" = 2))
	owner.update_filters()
	var/filter = owner.get_filter(id)
	animate(filter, alpha = 150, time = 2 SECONDS, easing = SINE_EASING|EASE_IN, loop = -1)
	animate(alpha = 0, time = 2 SECONDS, easing = SINE_EASING|EASE_OUT)

/datum/status_effect/dream_projection/on_remove()
	. = ..()
	UnregisterSignal(target, COMSIG_QDELETING)
	UnregisterSignal(target, COMSIG_LIVING_DEATH)
	target = null

	REMOVE_TRAIT(owner, TRAIT_DREAMING, TRAIT_STATUS_EFFECT(id))
	UnregisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_KNOCKEDOUT))
	UnregisterSignal(owner, COMSIG_LIVING_DEATH)
	UnregisterSignal(owner, COMSIG_MOB_APPLY_DAMAGE)

	if(!QDELING(owner))
		owner.adjust_drowsiness(10 SECONDS)
		var/filter = owner.get_filter(id)
		animate(filter, alpha = 0, time = 1 SECONDS, easing = SINE_EASING|EASE_OUT)
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/datum, remove_filter), id), 1 SECONDS) // delay the filter removal to let the transition finish

	UnregisterSignal(projection, COMSIG_QDELETING)
	if(QDELING(projection))
		projection = null
	else
		QDEL_NULL(projection)

/datum/status_effect/dream_projection/tick(seconds_between_ticks)
	if(isnull(owner.mind?.holy_role))
		end_projection()
		return

	owner.SetSleeping(20 SECONDS) // keep the owner asleep

/datum/status_effect/dream_projection/proc/end_projection()
	SIGNAL_HANDLER
	to_chat(owner, span_warning("你的目标已不再有效，梦境投射结束了。"))
	owner.SetSleeping(10 SECONDS)
	qdel(src)

/datum/status_effect/dream_projection/proc/interrupt_projection()
	SIGNAL_HANDLER
	to_chat(owner, span_warning("你的梦境投射被打断了！"))
	INVOKE_ASYNC(src, TYPE_PROC_REF(/mob, emote), "gasp")
	owner.visible_message(span_notice("[owner] 猛地睁开双眼，惊醒了！"), vision_distance = COMBAT_MESSAGE_RANGE, ignored_mobs = owner)
	qdel(src)

/datum/status_effect/dream_projection/proc/stop_projection()
	SIGNAL_HANDLER
	to_chat(owner, span_warning("你结束了梦境投射，回到了自己的身体。"))
	owner.SetSleeping(10 SECONDS)
	qdel(src)

/mob/eye/imaginary_friend/dream_projection
	name = "梦境投射"

/mob/eye/imaginary_friend/dream_projection/Initialize(mapload)
	. = ..()
	var/datum/action/innate/stop_projection/exit_action = new(src)
	exit_action.Grant(src)
	overlay_fullscreen("curse", /atom/movable/screen/fullscreen/curse, 1) // todo something more fitting?

/mob/eye/imaginary_friend/dream_projection/Login()
	. = ..()
	client.eye = owner || src

/mob/eye/imaginary_friend/dream_projection/greet()
	return

// The IC tab was removed recently as of commenting. This should probably be adjusted.
GAME_VERB_DESC(/mob/eye/imaginary_friend/dream_projection, stop_projection, "停止投射", "停止星体投射并返回自己的身体。", "IC")

	qdel(src)

/mob/eye/imaginary_friend/dream_projection/attach_to_owner(mob/living/imaginary_friend_owner)
	. = ..()
	client?.eye = owner

/datum/action/innate/stop_projection
	name = "停止投射"
	desc = "停止星体投射并返回自己的身体。"

/datum/action/innate/stop_projection/Activate()
	qdel(owner)
