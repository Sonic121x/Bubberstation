#define DEFAULT_MAX_CURSE_COUNT 5

/// Status effect that gives the target miscellanous debuffs while throwing a status alert and causing them to smoke from the damage they're incurring.
/// Purposebuilt for cursed slot machines.
/datum/status_effect/slot_machine_curse
	id = "cursed"
	alert_type = /atom/movable/screen/alert/status_effect/cursed
	remove_on_fullheal = TRUE
	heal_flag_necessary = HEAL_ADMIN
	/// The max number of curses a target can incur with this status effect.
	var/max_curse_count = DEFAULT_MAX_CURSE_COUNT
	/// The amount of times we have been "applied" to the target.
	var/curse_count = 0
	/// Raw probability we have to deal damage this tick.
	var/damage_chance = 10
	/// Are we currently in the process of sending a monologue?
	var/monologuing = FALSE
	/// The hand we are branded to.
	var/obj/item/bodypart/branded_hand = null
	/// The cached path of the particles we're using to smoke
	var/smoke_path = null

/datum/status_effect/slot_machine_curse/on_apply()
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_changed))
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	RegisterSignal(owner, COMSIG_CURSED_SLOT_MACHINE_USE, PROC_REF(check_curses))
	RegisterSignal(owner, COMSIG_CURSED_SLOT_MACHINE_LOST, PROC_REF(update_curse_count))
	RegisterSignal(SSdcs, COMSIG_GLOB_CURSED_SLOT_MACHINE_WON, PROC_REF(clear_curses))
	return ..()

/datum/status_effect/slot_machine_curse/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CURSED_SLOT_MACHINE_WON)
	branded_hand = null
	if (smoke_path)
		owner.remove_shared_particles(smoke_path)
	return ..()

/// Checks the number of curses we have and returns information back to the slot machine. `max_curse_amount` is set by the slot machine itself.
/datum/status_effect/slot_machine_curse/proc/check_curses(mob/user, max_curse_amount)
	SIGNAL_HANDLER
	if(curse_count >= max_curse_amount)
		return SLOT_MACHINE_USE_CANCEL

	if(monologuing)
		to_chat(owner, span_warning("你的手臂抗拒着拉动拉杆的动作！")) // listening to kitschy monologues to postpone your powergaming is the true curse here.
		return SLOT_MACHINE_USE_POSTPONE

/// Handles the debuffs of this status effect and incrementing the number of curses we have.
/datum/status_effect/slot_machine_curse/proc/update_curse_count()
	SIGNAL_HANDLER
	curse_count++

	linked_alert?.update_appearance() // we may have not initialized it yet

	addtimer(CALLBACK(src, PROC_REF(handle_after_effects), 1 SECONDS)) // give it a second to let the failure sink in before we exact our toll

/// Makes a nice lorey message about the curse level we're at. I think it's nice
/datum/status_effect/slot_machine_curse/proc/handle_after_effects()
	if(QDELETED(src))
		return

	monologuing = TRUE
	var/list/messages = list()
	switch(curse_count)
		if(1) // basically your first is a "freebie" that will still require urgent medical attention and will leave you smoking forever but could be worse tbh
			if(ishuman(owner))
				var/mob/living/carbon/human/human_owner = owner
				playsound(human_owner, SFX_SEAR, 50, TRUE)
				var/obj/item/bodypart/affecting = human_owner.get_active_hand()
				branded_hand = affecting
				affecting.force_wound_upwards(/datum/wound/burn/flesh/severe/cursed_brand, wound_source = "curse of the slot machine")

			messages += span_boldwarning("你的手灼痛起来，连忙松开了拉杆！随着手中的神经失去知觉，你感到一阵恶心……")
			messages += span_boldwarning("你的手似乎开始冒烟，不过还不算太糟……")
			messages += span_boldwarning("他妈的破机器。")

		if(2)
			messages += span_boldwarning("机器这次没有烫伤你，一定是烙印通过某种神秘力量认出了自己的源头……")
			messages += span_boldwarning("你的皮肤上开始冒出水泡和脓疮，每一个都嘶嘶地喷出滚烫的蒸汽……")
			messages += span_boldwarning("你明白了，这台机器用简单的诱惑折磨着你。它随时都能杀死你，却从强迫你继续玩下去之中获得病态的满足。")
			messages += span_boldwarning("如果能离开这里，再找些医疗用品，你或许还能活下来。现在收手还来得及吗？")
			messages += span_boldwarning("你闭上眼睛思索这个难题，烙印却传来一阵剧痛。一想到失去意识后可能发生的事，你便不寒而栗。")

		if(3)
			owner.emote("cough")
			messages += span_boldwarning("你感觉喉咙里逐渐积满了沙尘。你把喉咙深处的东西吐在了袖子上。")
			messages += span_boldwarning("是沙子。猩红的沙子。你这辈子从未如此口渴，却不敢相信自己的手能把水杯送到嘴边。")
			messages += span_boldwarning("你隐约觉得，如果别人赢了，或许也能解除你的诅咒。拯救你的生命是件高尚的事。")
			messages += span_boldwarning("当然，你也许得隐瞒这台机器的真面目，免得他们逃之夭夭，丢下你等死。")
			messages += span_boldwarning("为了消除自己贪图享乐招来的祸患，让别人遭受同样的命运，真的值得吗？你必须尽快做出决定。")

		if(4)
			messages += span_boldwarning("偏头痛不断加剧，思绪渐渐模糊。你的手拼命挪向老虎机，想再拉最后一次……")
			messages += span_boldwarning("这是意志对肉体的终极考验。你可以猛地收回手，逃离可怕的结局，可你的生命如今已如此卑微。")
			messages += span_boldwarning("这不正是它想要的吗？亲眼见证你败在它面前？强烈的冲动驱使你继续，而深深的恐惧已在你腹中翻涌。")
			messages += span_boldwarning("矛盾的是，绝望之中也有狂喜。你竟然还有力气再拉一次，怎能不欣喜若狂。")
			messages += span_boldwarning("一想到逃离这该死的机器，你的双腿便迫切地想拔腿就跑，可你的手臂仍沉溺于看着轮盘旋转的念头。")
			messages += span_userdanger("代价早已付清。你已无法选择自己的死法。尊严比生命更重要吗？")

		if(5 to INFINITY)
			if(max_curse_count != DEFAULT_MAX_CURSE_COUNT) // this probably will only happen through admin schenanigans letting people stack up infinite curses or something
				to_chat(owner, span_boldwarning("你<i>还</i>以为自己掌控着一切吗？"))
				return

			to_chat(owner, span_userdanger("为什么不能让我再试一次？！"))
			owner.investigate_log("has been gibbed by the cursed status effect after accumulating [curse_count] curses.", INVESTIGATE_DEATHS)
			owner.gib(DROP_ALL_REMAINS)
			qdel(src)
			return

	for(var/message in messages)
		to_chat(owner, message)
		sleep(1.5 SECONDS) // yes yes a bit fast but it can be a lot of text and i want the whole thing to send before the cooldown on the slot machine might expire
	monologuing = FALSE

/// Cleans ourselves up and removes our curses. Meant to be done in a "positive" way, when the curse is broken. Directly use qdel otherwise.
/datum/status_effect/slot_machine_curse/proc/clear_curses()
	SIGNAL_HANDLER

	if(!isnull(branded_hand))
		var/datum/wound/brand = branded_hand.get_wound_type(/datum/wound/burn/flesh/severe/cursed_brand)
		brand?.remove_wound()

	owner.visible_message(
		span_notice("[owner.name]身上的烟雾渐渐消散……"),
		span_notice("你的皮肤终于恢复平静，喉咙也不再那么干燥……烙印消失了，诅咒确实已经解除。"),
	)
	qdel(src)

/// If our owner's stat changes, rapidly surge the damage chance.
/datum/status_effect/slot_machine_curse/proc/on_stat_changed()
	SIGNAL_HANDLER
	if(!IS_UNCONSCIOUS_OR_CRIT(owner) || owner.stat == DEAD) // reset on these two states
		damage_chance = initial(damage_chance)
		return

	to_chat(owner, span_userdanger("你的身体逐渐崩溃，老虎机的诅咒在体内汹涌蔓延！"))
	damage_chance += 75 //ruh roh raggy

/// If our owner dies without getting gibbed (as in of other causes), stop smoking because we've "expended all the life energy".
/datum/status_effect/slot_machine_curse/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER

	if(!gibbed && smoke_path)
		owner.remove_shared_particles(smoke_path)

/datum/status_effect/slot_machine_curse/update_particles()
	var/particle_path = /particles/smoke/steam/mild
	switch(curse_count)
		if(2 to 3)
			particle_path = /particles/smoke/steam
		if(4 to INFINITY)
			particle_path = /particles/smoke/steam/bad

	if(smoke_path == particle_path)
		return

	if (smoke_path)
		owner.remove_shared_particles(smoke_path)
	owner.add_shared_particles(particle_path)
	smoke_path = particle_path

/datum/status_effect/slot_machine_curse/tick(seconds_between_ticks)
	if(curse_count <= 1)
		return // you get one "freebie" (single damage) to nudge you into thinking this is a bad idea before the house begins to win.

	// the house won.
	var/ticked_coefficient = (rand(15, 40) / 100)
	var/effective_percentile_chance = ((curse_count == 2 ? 1 : curse_count) * damage_chance * ticked_coefficient)

	if(SPT_PROB(effective_percentile_chance, seconds_between_ticks))
		owner.apply_damages(
			brute = (curse_count * ticked_coefficient),
			burn = (curse_count * ticked_coefficient),
			oxy = (curse_count * ticked_coefficient),
		)

/atom/movable/screen/alert/status_effect/cursed
	name = "受到诅咒！"
	desc = "手上的烙印提醒着你自己的贪婪，不过除此之外，你似乎还算正常。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "cursed_by_slots"

/atom/movable/screen/alert/status_effect/cursed/update_desc()
	. = ..()
	var/datum/status_effect/slot_machine_curse/linked_effect = attached_effect
	var/curses = linked_effect?.curse_count
	switch(curses)
		if(2)
			desc = "你开始为自己的贪婪付出代价……"
		if(3)
			desc = "你现在真的很难受……可为什么要就此收手？"
		if(4 to INFINITY)
			desc = "真正的赢家会在拿到终极大奖之前收手。"

#undef DEFAULT_MAX_CURSE_COUNT
