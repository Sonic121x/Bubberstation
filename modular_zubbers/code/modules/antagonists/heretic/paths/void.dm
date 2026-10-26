// rework void chill to like, cause sleep and healing at max stacks? But if you touch them at all they break out
// possinly also make it just not do damage bc sleep is kinda strong
// damage resistance on the wakeup attack?

/datum/action/cooldown/spell/pointed/void_phase
	desc = "让你闪现到指定地点，并在目的地和当前位置周围\
		造成3×3范围伤害。\
		最小距离3格，最大距离9格。目标必须处于视线内。"
	cooldown_time = 35 SECONDS // extra thick cooldown for a very strong teleport ability

/datum/action/cooldown/spell/pointed/void_phase/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	if (isclosedturf(get_turf(cast_on)))
		owner.balloon_alert(owner, "不能对墙壁施放！")
		return SPELL_CANCEL_CAST

	var/turf/in_LOS = view(cast_range, owner)
	if (!(cast_on in in_LOS))
		owner.balloon_alert(owner, "必须看得到目标！")
		return SPELL_CANCEL_CAST

/datum/heretic_knowledge_tree_column/void
	knowledge_tier3 = /datum/heretic_knowledge/spell/void_stealth
	description = list(
		"虚空之道侧重于潜行、严寒、机动和低温治疗。",
		"如果你喜欢扮演灵活的刺客，将敌人冻在原地后遁入相位，就选择这条道路。",
	)
	pros = list(
		"抵御太空环境的危险。",
		"法术施加可叠加的减益，使目标降温并减速。",
		"拥有强大的机动法术。",
		"潜行能力极强。",
	)
	cons = list(
		"虽然能抵御太空环境，但在太空中的机动性远不如步行。",
		"难以对付免疫寒冷效果的敌人。",
		"难以对付硅基生命。",
		"敌人可以利用你的虚空寒冷治疗自己。如果看到有人在战斗中睡着，攻击对方即可中断治疗。",
	)
	tips = list(
		"漫宿之握可使目标失声，非常适合无声暗杀（注意，它不会使制服传感器短路，击杀后务必将其关闭）。握击还会施加印记，由虚空之刃触发时会给目标叠满虚空寒冷，使其举步维艰。",
		"虚空寒冷由法术、漫宿之握、印记及升级后的刀刃施加。每层降低目标10%的移动速度并使其逐渐降温，最多叠加5层。",
		"受到虚空寒冷影响者睡着后，会进入邪异睡眠，恢复伤势并闭合创伤。攻击对方会中断这一过程。",
		"叠满5层后，虚空寒冷还会阻止目标升温。",
		"暗夜之幕让你持续完全隐形，只要不受到攻击就不会结束。可用于伏击或摆脱追兵。",
		"虚空牢笼可使目标停滞10秒，适合面对多个敌人时暂时隔离其中一人。",
		"虚空牢笼可对自己施放，并缓慢治疗其中的人。你可以牺牲行动能力来抵挡即将到来的伤害。",
		"虚空导管是你的标志性能力。它会冻结周围空气，并使附近敌人入睡。可用于扩张寒冷领域，瘫痪进攻者。",
	)

/datum/heretic_knowledge/spell/void_pull
	unreachable = TRUE

/datum/heretic_knowledge/spell/void_stealth
	name = "暗夜之幕"
	desc = "以密不透光的虚空包裹你，使旁人无法看见。此状态下，你会冷却周围空气，因此别在\
	同一个地方待太久，否则别人会察觉。攻击或受到攻击都会破除隐形。"
	gain_text = "贵胄如鼠般轻柔地行走，在漆黑无垠的虚空中不留一丝涟漪。很快，我闭上双眼——\
	祂便在那里，引力令人无处可逃。"
	action_to_add = /datum/action/cooldown/spell/void_stealth
	cost = 2

/datum/action/cooldown/spell/void_stealth
	name = "暗夜之幕"
	desc = "以密不透光的虚空包裹你，使你几乎无法被旁人看见。此状态下，你会冷却周围空气，因此别在\
	同一个地方待太久，否则别人会察觉。隐形时无法攻击，受到攻击会立即解除隐形。"
	/// The cloak currently active
	var/datum/status_effect/void_stealth/active_cloak
	/// The cooldown applied after our cloak is removed.
	var/remove_time = 140 SECONDS

	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_ecult.dmi'
	button_icon_state = "voidpull"

	sound = null
	school = SCHOOL_FORBIDDEN
	invocation_type = INVOCATION_NONE // sneaky spell
	spell_requirements = NONE

	cooldown_time = 2 SECONDS

/datum/action/cooldown/spell/void_stealth/before_cast(mob/living/cast_on)
	. = ..()
	// We handle the CD on our own
	return . | SPELL_NO_IMMEDIATE_COOLDOWN

/datum/action/cooldown/spell/void_stealth/cast(atom/cast_on)
	. = ..()

	if(active_cloak)
		uncloak_mob(cast_on)
		StartCooldown(remove_time)

	else
		cloak_mob(cast_on)
		StartCooldown()

/datum/action/cooldown/spell/void_stealth/proc/cloak_mob(mob/living/cast_on)
	active_cloak = cast_on.apply_status_effect(/datum/status_effect/void_stealth)
	to_chat(cast_on, span_notice("虚空包围了你，你的身影从凡世的目光中消失。"))

/datum/action/cooldown/spell/void_stealth/proc/uncloak_mob(mob/living/cast_on, show_message = TRUE)
	if(!QDELETED(active_cloak))
		UnregisterSignal(active_cloak, COMSIG_QDELETING)
		qdel(active_cloak)
	active_cloak = null

	if(show_message)
		cast_on.visible_message(
			span_warning("[cast_on]凭空出现了！"),
			span_notice("包裹身形的虚空散去，你再次显现在凡世之中。"),
		)
	StartCooldown(remove_time)

/// Shadow cloak effect. Sets the owner's alpha very low while also chilling the area around them
/// If hit at all, the cloak is cancelled and put on cooldown
/datum/status_effect/void_stealth
	id = "void_stealth"
	alert_type = null
	// in kelvin, the rate we cool the tile we're on
	var/cooling_per_sec = 10

/datum/status_effect/void_stealth/tick(seconds_between_ticks)
	. = ..()

	var/turf/location = get_turf(owner)
	if(location)
		var/datum/gas_mixture/enviro = location.return_air()
		enviro.temperature = max(enviro.temperature - cooling_per_sec * seconds_between_ticks, 50)
		location.air_update_turf(FALSE, FALSE)

/datum/status_effect/void_stealth/on_apply()
	animate(owner, alpha = 5, 2 SECONDS)
	// Add the relevant traits and modifiers
	owner.add_traits(list(TRAIT_UNKNOWN_APPEARANCE), TRAIT_STATUS_EFFECT(id))
	// Register signals to cause effects
	RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_change))
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_block_check))
	RegisterSignal(owner, COMSIG_USER_PRE_ITEM_ATTACK, PROC_REF(before_attack))
	RegisterSignal(owner, COMSIG_USER_ITEM_INTERACTION, PROC_REF(on_item_interaction))
	RegisterSignal(owner, COMSIG_LIVING_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(owner, COMSIG_MOB_BEFORE_SPELL_CAST, PROC_REF(before_spell_cast))
	return TRUE

/datum/status_effect/void_stealth/proc/before_spell_cast(datum/source, datum/spell)
	SIGNAL_HANDLER
	if(!istype(spell, /datum/action/cooldown/spell/void_stealth))
		owner.balloon_alert(owner, "隐形时无法施法！")
		return SPELL_CANCEL_CAST


/datum/status_effect/void_stealth/on_remove()
	// Remove traits and modifiers
	owner.remove_traits(list(TRAIT_UNKNOWN_APPEARANCE), TRAIT_STATUS_EFFECT(id))
	animate(owner, alpha = initial(owner.alpha), 0.5 SECONDS)
	// Clear signals
	UnregisterSignal(owner, list(
		COMSIG_MOB_STATCHANGE,
		COMSIG_LIVING_CHECK_BLOCK,
		COMSIG_USER_PRE_ITEM_ATTACK,
		COMSIG_USER_ITEM_INTERACTION,
		COMSIG_LIVING_UNARMED_ATTACK,
		COMSIG_MOB_BEFORE_SPELL_CAST
	))

/// Signal proc for [COMSIG_USER_PRE_ITEM_ATTACK], disallows the use of weapons while stealth is active
/datum/status_effect/void_stealth/proc/before_attack(datum/source, obj/item/weapon, atom/target, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER

	if (isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN

/// Signal proc for [COMSIG_LIVING_CHECK_BLOCK], any attack at all cancels the stealth
/datum/status_effect/void_stealth/proc/on_block_check(datum/source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	var/datum/action/cooldown/spell/void_stealth/stealth = locate() in owner.actions
	stealth?.uncloak_mob(owner)
	if (!stealth)
		qdel(src)

/// Signal proc for [COMSIG_MOB_STATCHANGE], going past soft crit will stop the effect
/datum/status_effect/void_stealth/proc/on_stat_change(datum/source, new_stat, old_stat)
	SIGNAL_HANDLER

	// Going above unconscious will self-delete
	if(new_stat >= SOFT_CRIT)
		var/datum/action/cooldown/spell/void_stealth/stealth = locate() in owner.actions
		stealth?.uncloak_mob()
		if (!stealth)
			qdel(src)

/datum/status_effect/void_stealth/proc/on_item_interaction(datum/source, obj/item/tool, list/modifiers)
	SIGNAL_HANDLER

	return ITEM_INTERACT_BLOCKING

/datum/status_effect/void_stealth/proc/on_unarmed_attack(datum/signal_source, mob/living/source, atom/target, proximity, modifiers)
	SIGNAL_HANDLER

	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/heretic_knowledge/spell/void_prison
	desc = "赋予你虚空牢笼，将受害者封入一个球体。在此状态下，\
	目标不会受到伤害，并会缓慢恢复。可对自己施放。"

/datum/action/cooldown/spell/pointed/void_prison
	desc = "将目标送入虚空10秒。\
		期间目标无法行动，也无法被触及，并会缓慢恢复。\
		随后将返回凡世。可对自己施放。"

/datum/action/cooldown/spell/pointed/void_prison/is_valid_target(atom/cast_on)
	if (!ismob(cast_on))
		return FALSE
	var/mob/target_mob = cast_on
	if (target_mob.has_status_effect(/datum/status_effect/crucible_soul))
		owner.balloon_alert(owner, "目标处于相位中，无法使用！")
		return FALSE

	return TRUE // self cast

/datum/status_effect/void_prison
	var/healing_per_second = -2

/datum/status_effect/void_prison/tick(seconds_between_ticks)
	. = ..()

	owner.adjust_brute_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_fire_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_tox_loss(healing_per_second * seconds_between_ticks)
	owner.adjust_oxy_loss(healing_per_second * seconds_between_ticks)

	// TODO heal wounds

/atom/movable/screen/alert/status_effect/void_chill
	desc = "某种力量正从内到外冻结你。你从未感受过如此压抑的寒冷……然而其中又有种令人安心的感觉。\
	点击此提示进入深度睡眠，通过冷冻沙酮恢复伤势。注意：只有受到攻击或此状态消失时才会醒来。使用莱波拉嗪可以缓解减速！"

/datum/status_effect/void_chill/update_movespeed(stacks)
	. = ..()

	if (owner.has_reagent(/datum/reagent/medicine/leporazine))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/void_chill, update = TRUE, multiplicative_slowdown = (0.1 * stacks)) // massive reduction
	else if (owner.has_reagent(/datum/reagent/consumable/coffee) || owner.has_reagent(/datum/reagent/consumable/tea))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/void_chill, update = TRUE, multiplicative_slowdown = (0.3 * stacks)) // moderate reduction

/atom/movable/screen/alert/status_effect/void_chill/Click(location, control, params)
	. = ..()

	if (!isliving(owner))
		return
	var/mob/living/living_owner = owner
	if (living_owner.IsSleeping())
		return
	if (IS_UNCONSCIOUS_OR_CRIT(living_owner))
		return
	if (!tgui_alert(living_owner, "进入舒缓的睡眠吗？（受到攻击会醒来）", "虚空睡眠", list("是", "否"), timeout = 5 SECONDS))
		return
	if (living_owner.IsSleeping())
		return
	if (QDELETED(src))
		return

	if(!istype(attached_effect, /datum/status_effect/void_chill))
		return
	var/datum/status_effect/void_chill/chill_effect = attached_effect

	chill_effect.put_to_bed(owner)

/datum/status_effect/void_chill
	VAR_PROTECTED/in_eldritch_sleep = FALSE
	/// Makes choosing to sleep a commitment that can take you out of any fight.
	var/bonus_sleepy_time = 150 SECONDS
	var/should_reduce_timer_on_wakeup = FALSE
	COOLDOWN_DECLARE(wakeup_period)

/datum/status_effect/void_chill/proc/put_to_bed(mob/living/sleepy_boy)
	if (sleepy_boy.IsSleeping())
		return
	if (!IS_UNCONSCIOUS(sleepy_boy))
		return
	if (QDELETED(src))
		return
	set_sleep_status(TRUE)

/datum/status_effect/void_chill/proc/set_sleep_status(new_value, silent = FALSE, forced = FALSE)
	if (in_eldritch_sleep == new_value)
		return

	in_eldritch_sleep = new_value

	if (in_eldritch_sleep)
		if (!forced)
			duration += bonus_sleepy_time
			should_reduce_timer_on_wakeup = TRUE

		owner.AdjustSleeping(60 SECONDS) // removes when void chill goes away as well
		RegisterSignal(owner, COMSIG_MOB_STATCHANGE, PROC_REF(on_stat_changed))
		RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(on_block_check))
		if (!silent)
			to_chat(owner, span_hypnophrase("你飘入深邃黑暗的梦境，那里有死亡、虚空，还有令人安心的寒冷……"))
	else
		COOLDOWN_START(src, wakeup_period, 5 SECONDS)
		if (should_reduce_timer_on_wakeup)
			duration -= bonus_sleepy_time
		should_reduce_timer_on_wakeup = FALSE
		owner.SetSleeping(0)
		owner.adjust_drowsiness(-60 SECONDS)
		UnregisterSignal(owner, list(COMSIG_MOB_STATCHANGE, COMSIG_LIVING_CHECK_BLOCK))
		if (!iscarbon(owner))
			return
		var/mob/living/carbon/carbon_owner = owner
		var/datum/reagents/reagents = carbon_owner.reagents
		reagents.remove_reagent(/datum/reagent/medicine/cryoxadone/heretic, 500) // just get it alllll out

/datum/status_effect/void_chill/proc/on_stat_changed(datum/signal_source, new_stat, old_stat)
	SIGNAL_HANDLER

	if (new_stat <= SOFT_CRIT)
		set_sleep_status(FALSE)

/datum/status_effect/void_chill/proc/on_block_check(datum/signal_source, atom/hit_by, damage, attack_text, attack_type, armour_penetration, damage_type)
	SIGNAL_HANDLER

	owner.visible_message(
		span_warning("[owner]猛然从深眠中惊醒！"),
		span_userdanger("你猛然从深眠中惊醒！")
	)
	set_sleep_status(FALSE, silent = TRUE)
	//return SUCCESSFUL_BLOCK // TODO reenable if we make it so you can fall into the sleep due to cold involuntarily

/datum/status_effect/void_chill/get_examine_text()
	if (in_eldritch_sleep)
		return span_boldnotice("[owner]陷入了格外深沉的睡眠，闪烁的虚空触须正在封闭伤口……将其唤醒可能会中断这一过程。")
	return ..()

/datum/status_effect/void_chill/Destroy()
	set_sleep_status(FALSE)

	return ..()

/datum/status_effect/void_chill/tick(seconds_between_ticks)
	. = ..()

	if (in_eldritch_sleep)
		if (!iscarbon(owner))
			return
		var/mob/living/carbon/carbon_owner = owner
		var/datum/reagents/reagents = carbon_owner.reagents
		reagents.add_reagent(/datum/reagent/medicine/cryoxadone/heretic, 0.8 * seconds_between_ticks)
	else
		if (stacks >= 5)
			if (SPT_PROB(5, seconds_between_ticks))
				to_chat(owner, span_hypnophrase("寒冷让你的动作、思绪和心跳都慢了下来……你想小睡一会儿。"))
			if (SPT_PROB(5, seconds_between_ticks))
				owner.emote("yawn")
		if (owner.IsSleeping())
			if (COOLDOWN_FINISHED(src, wakeup_period))
				set_sleep_status(TRUE, forced = TRUE)

/datum/reagent/medicine/cryoxadone/heretic
	name = "虚空之触"
	description = "一种性质类似冷冻沙酮的奇异物质。"
	color = "#00c878"
	metabolization_rate = 0.75
	overdose_threshold = 0
	chemical_flags = NONE
	process_flags = REAGENT_ORGANIC|REAGENT_SYNTHETIC // yes synths. u get healing 2

/datum/heretic_knowledge/spell/void_conduit
	desc = "赋予你虚空导管，召唤一扇通往虚空本身的脉动之门。每次脉动都会冻结空气，使异信者受到虚空寒冷并昏昏欲睡。异教徒则会获得低压抗性。"

/datum/action/cooldown/spell/conjure/void_conduit
	desc = "开启一扇虚空之门，间歇释放脉冲，冻结周围空气，使异信者受到虚空寒冷并昏昏欲睡。\
		受导管影响而睡着的异信者会进入深度邪异睡眠，得到治疗，但一段时间内无法行动。\
		受影响的异教徒则会获得低压抗性。"

/obj/structure/void_conduit
	var/cooling_per_pulse = 5

/obj/structure/void_conduit/handle_effects(list/turfs)
	// no parent call. bESPOKE behavior
	for(var/turf/affected_turf as anything in turfs)
		var/datum/gas_mixture/enviro = affected_turf.return_air()
		enviro.temperature = max(enviro.temperature - cooling_per_pulse, 20)
		affected_turf.air_update_turf(FALSE, FALSE)
		for(var/atom/thing_to_affect as anything in affected_turf.contents)
			if(isliving(thing_to_affect))
				var/mob/living/affected_mob = thing_to_affect
				if(affected_mob.can_block_magic(MAGIC_RESISTANCE))
					continue
				if(IS_HERETIC_OR_MONSTER(affected_mob) || HAS_TRAIT(affected_mob, TRAIT_MANSUS_TOUCHED))
					affected_mob.apply_status_effect(/datum/status_effect/void_conduit)
				else
					affected_mob.apply_status_effect(/datum/status_effect/void_chill, 1)
					if (!affected_mob.IsSleeping())
						var/datum/status_effect/void_chill/chill = affected_mob.has_status_effect(/datum/status_effect/void_chill)
						if (!isnull(chill) && chill.stacks >= 5)
							var/tempcheck = affected_mob.get_temperature() <= 200
							if (ishuman(affected_mob))
								tempcheck = FALSE
								var/mob/living/carbon/human/human_mob = affected_mob
								if (human_mob.coretemperature <= 175)
									tempcheck = TRUE
							if (tempcheck && prob(40))
								affected_mob.AdjustSleeping(3 SECONDS) // ko
						if (prob(15))
							to_chat(affected_mob, span_warning("寒冷让你昏昏欲睡……"))

/obj/structure/void_conduit/examine(mob/user)
	. = ..()

	. += span_notice("冷却周围区域，使附近敌人受到虚空寒冷并昏昏欲睡，困倦达到一定程度后会强制入睡。")
