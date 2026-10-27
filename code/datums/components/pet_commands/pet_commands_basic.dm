// None of these are really complex enough to merit their own file

/**
 * # Pet Command: Idle
 * Tells a pet to resume its idle behaviour, usually staying put where you leave it
 */
/datum/pet_command/idle
	command_name = "待命"
	command_desc = "命令宠物留在此处待命。"
	radial_icon_state = "halt"
	speech_commands = list("sit", "stay", "stop")
	command_feedback = "坐下"

/datum/pet_command/idle/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/stay)

/datum/pet_command/idle/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]原地待命！"

/**
 * # Pet Command: Stop
 * Tells a pet to exit command mode and resume its normal behaviour
 */
/datum/pet_command/free
	command_name = "自由活动"
	command_desc = "让宠物恢复自由行动。"
	radial_icon_state = "free"
	speech_commands = list("free", "loose")
	command_feedback = "放松下来"

/datum/pet_command/free/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, null)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/free/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]自由活动！"

/**
 * # Pet Command: Follow
 * Tells a pet to follow you until you tell it to do something else
 */
/datum/pet_command/follow
	command_name = "跟随"
	command_desc = "命令宠物跟随你。"
	radial_icon_state = "follow"
	speech_commands = list("heel", "follow")
	callout_type = /datum/callout_option/move
	///should we activate immediately if we're doing nothing else and gain a friend?
	var/activate_on_befriend = FALSE
	/// BT subtree installed by execute_action; override to use a mob-specific follow tree.
	var/follow_subtree = /datum/bt_node/subtree/pet_command/follow

/datum/pet_command/follow/set_command_active(mob/living/parent, mob/living/commander)
	. = ..()
	set_command_target(parent, commander)

/datum/pet_command/follow/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]跟上！"

/datum/pet_command/follow/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, follow_subtree)

/datum/pet_command/follow/add_new_friend(mob/living/tamer)
	. = ..()
	var/mob/living/parent = weak_parent.resolve()
	if (!parent)
		return
	if (activate_on_befriend && !parent.ai_controller.blackboard_key_exists(BB_ACTIVE_PET_COMMAND))
		try_activate_command(tamer)

/// Like follow but start active
/datum/pet_command/follow/start_active
	activate_on_befriend = TRUE

/**
 * # Pet Command: Play Dead
 * Pretend to be dead for a random period of time
 */
/datum/pet_command/play_dead
	command_name = "装死"
	command_desc = "表演一个阴森的小把戏。"
	radial_icon_state = "play_dead"
	speech_commands = list("play dead") // Don't get too creative here, people talk about dying pretty often

/datum/pet_command/play_dead/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/play_dead)

/datum/pet_command/play_dead/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]装死！"

/**
 * # Pet Command: Good Boy
 * React if complimented
 */
/datum/pet_command/good_boy
	command_name = "真乖"
	command_desc = "夸奖你的宠物。"
	hidden = TRUE

/datum/pet_command/good_boy/New(mob/living/parent)
	. = ..()
	speech_commands += "good [parent.name]"
	switch (parent.gender)
		if (MALE)
			speech_commands += "good boy"
			return
		if (FEMALE)
			speech_commands += "good girl"
			return
	// If we get past this point someone has finally added a non-binary dog

/datum/pet_command/good_boy/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, null)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
	var/mob/living/parent = weak_parent.resolve()
	if (!parent)
		return
	new /obj/effect/temp_visual/heart(parent.loc)
	parent.emote("spin")

/**
 * # Pet Command: Use ability
 * Use an an ability that does not require any targets
 */
/datum/pet_command/untargeted_ability
	///untargeted ability we will use
	var/ability_key

/datum/pet_command/untargeted_ability/execute_action(datum/ai_controller/controller)
	var/datum/action/cooldown/ability = controller.blackboard[ability_key]
	if(!ability?.IsAvailable())
		return
	controller.set_blackboard_key(BB_PET_ACTIVE_ABILITY, ability)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/untargeted_ability)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/untargeted_ability/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]使用技能！"

/**
 * # Pet Command: Attack
 * Tells a pet to chase and bite the next thing you point at
 */
/datum/pet_command/attack
	command_name = "攻击"
	command_desc = "命令宠物攻击你指向的目标。"
	radial_icon_state = "attack"
	requires_pointing = TRUE
	callout_type = /datum/callout_option/attack
	speech_commands = list("attack", "sic", "kill")
	command_feedback = "低吼"
	pointed_reaction = "，发出了低吼"
	/// Balloon alert to display if providing an invalid target
	var/refuse_reaction = "摇头"
	var/datum/bt_node/subtree/attack_subtree = /datum/bt_node/subtree/pet_command/attack

// Refuse to target things we can't target, chiefly other friends
/datum/pet_command/attack/set_command_target(mob/living/parent, atom/target)
	if (!target)
		return FALSE
	var/mob/living/living_parent = parent
	if (!living_parent.ai_controller)
		return FALSE
	var/datum/targeting_strategy/targeter = GET_TARGETING_STRATEGY(living_parent.ai_controller.blackboard[targeting_strategy_key])
	if (!targeter)
		return FALSE
	if (!targeter.is_valid_target(living_parent, target))
		refuse_target(parent, target)
		return FALSE
	return ..()

/datum/pet_command/attack/retrieve_command_text(atom/living_pet, atom/target)
	return isnull(target) ? null : "示意[living_pet]攻击[target]！"

/// Display feedback about not targeting something
/datum/pet_command/attack/proc/refuse_target(mob/living/parent, atom/target)
	var/mob/living/living_parent = parent
	living_parent.balloon_alert_to_viewers("[refuse_reaction]")
	living_parent.visible_message(span_notice("[living_parent]拒绝攻击[target]。"))

/datum/pet_command/attack/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, attack_subtree)

/**
 * # Breed command. breed with a partner!
 */
/datum/pet_command/breed
	command_name = "繁殖"
	command_desc = "命令宠物尝试与伴侣繁殖。"
	requires_pointing = TRUE
	radial_icon_state = "breed"
	speech_commands = list("breed", "consummate")

/datum/pet_command/breed/set_command_target(mob/living/parent, atom/target)
	if(isnull(target) || !isliving(target))
		return FALSE
	if(!HAS_TRAIT(parent, TRAIT_MOB_BREEDER) || !HAS_TRAIT(target, TRAIT_MOB_BREEDER))
		return FALSE
	if(isnull(parent.ai_controller))
		return FALSE
	if(!parent.ai_controller.blackboard[BB_BREED_READY] || isnull(parent.ai_controller.blackboard[BB_BABIES_PARTNER_TYPES]))
		return FALSE
	var/mob/living/living_target = target
	if(!living_target.ai_controller?.blackboard[BB_BREED_READY])
		return FALSE
	return ..()

/datum/pet_command/breed/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/breed)

/datum/pet_command/breed/retrieve_command_text(atom/living_pet, atom/target)
	return isnull(target) ? null : "示意[living_pet]与[target]繁殖！"

/**
 * # Pet Command: Targetted Ability
 * Tells a pet to use some kind of ability on the next thing you point at
 */
/datum/pet_command/use_ability
	command_name = "使用技能"
	command_desc = "命令宠物对你指向的目标使用特殊技能。"
	radial_icon = 'icons/mob/actions/actions_spells.dmi'
	radial_icon_state = "projectile"
	requires_pointing = TRUE
	speech_commands = list("shoot", "blast", "cast")
	command_feedback = "低吼"
	pointed_reaction = "，发出了低吼"
	/// Blackboard key where a reference to some kind of mob ability is stored
	var/pet_ability_key

/datum/pet_command/use_ability/execute_action(datum/ai_controller/controller)
	if (!pet_ability_key)
		return
	var/datum/action/cooldown/using_action = controller.blackboard[pet_ability_key]
	if (QDELETED(using_action))
		return
	// Store the action datum in a fixed key so the targeted_ability subtree can find it
	controller.override_blackboard_key(BB_TARGETED_ACTION, using_action)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/targeted_ability)

/datum/pet_command/use_ability/retrieve_command_text(atom/living_pet, atom/target)
	return isnull(target) ? null : "示意[living_pet]对[target]使用技能！"

/datum/pet_command/protect_owner
	command_name = "保护主人"
	command_desc = "宠物会赶来协助你。"
	hidden = TRUE
	callout_type = /datum/callout_option/guard
	///the range our owner needs to be in for us to protect him
	var/protect_range = 9
	///message cooldown to prevent too many people from telling you not to commit suicide
	COOLDOWN_DECLARE(self_harm_message_cooldown)
	var/datum/bt_node/subtree/protect_owner_subtree = /datum/bt_node/subtree/pet_command/protect_owner

/datum/pet_command/protect_owner/add_new_friend(mob/living/tamer)
	RegisterSignal(tamer, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(set_attacking_target))
	if(!HAS_TRAIT(tamer, TRAIT_RELAYING_ATTACKER))
		tamer.AddElement(/datum/element/relay_attackers)

/datum/pet_command/protect_owner/remove_friend(mob/living/unfriended)
	UnregisterSignal(unfriended, COMSIG_ATOM_WAS_ATTACKED)

/datum/pet_command/protect_owner/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, protect_owner_subtree)

/datum/pet_command/protect_owner/set_command_active(mob/living/parent, mob/living/victim)
	. = ..()
	set_command_target(parent, victim)

/datum/pet_command/protect_owner/valid_callout_target(mob/living/speaker, datum/callout_option/callout, atom/target)
	return target == speaker || get_dist(speaker, target) <= 1

/datum/pet_command/protect_owner/proc/set_attacking_target(atom/source, mob/living/attacker)
	SIGNAL_HANDLER

	var/mob/living/basic/owner = weak_parent.resolve()
	if(isnull(owner))
		return
	if(source == attacker)
		var/list/interventions = owner.ai_controller?.blackboard[BB_OWNER_SELF_HARM_RESPONSES] || list()
		if (length(interventions) && COOLDOWN_FINISHED(src, self_harm_message_cooldown) && prob(30))
			COOLDOWN_START(src, self_harm_message_cooldown, 5 SECONDS)
			var/chosen_statement = pick(interventions)
			INVOKE_ASYNC(owner, TYPE_PROC_REF(/atom/movable, say), chosen_statement)
		return
	var/mob/living/current_target = owner.ai_controller?.blackboard[BB_CURRENT_PET_TARGET]
	if(attacker == current_target) //we are already dealing with this target
		return
	if(isliving(attacker) && can_see(owner, attacker, protect_range))
		set_command_active(owner, attacker)

/**
 * # Fish command: command the mob to fish at the next fishing spot you point at.
 */
/datum/pet_command/fish
	command_name = "捕鱼"
	command_desc = "命令宠物尝试在附近的钓点捕鱼。"
	requires_pointing = TRUE
	radial_icon_state = "fish"
	speech_commands = list("fish")

/datum/pet_command/fish/execute_action(datum/ai_controller/controller)
	if(!controller.blackboard_key_exists(BB_CURRENT_PET_TARGET))
		controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/stay)
		return
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/fish)

/datum/pet_command/fish/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]去捕鱼！"

/datum/pet_command/move
	command_name = "移动"
	command_desc = "命令宠物移动到指定位置！"
	requires_pointing = TRUE
	radial_icon_state = "move"
	speech_commands = list("move", "walk")

/datum/pet_command/move/set_command_target(mob/living/parent, atom/target)
	if(isnull(target) || !can_see(parent, target, 9))
		return FALSE
	return ..()

/datum/pet_command/move/execute_action(datum/ai_controller/controller)
	controller.set_behavior_tree_override(SUBPLAN_ID_PET_COMMAND, /datum/bt_node/subtree/pet_command/move_to)

/datum/pet_command/move/retrieve_command_text(atom/living_pet, atom/target)
	return "示意[living_pet]移动！"
