#define WRIST_WRENCH_COMBO "HG"
#define LAUNCH_KICK_COMBO "HD"
#define DROP_KICK_COMBO "DD"
#define KNEE_STOMACH_COMBO "GH"

/datum/martial_art/the_sleeping_carp
	name = "睡鲤拳"
	id = MARTIALART_SLEEPINGCARP
	help_verb = "回顾武学教诲"
	display_combos = TRUE
	grab_state_modifier = 1
	/// List of traits applied to users of this martial art.
	var/list/scarp_traits = list(TRAIT_NOGUNS, TRAIT_TOSS_GUN_HARD, TRAIT_HARDLY_WOUNDED, TRAIT_NODISMEMBER, TRAIT_HEAVY_SLEEPER, TRAIT_PERFECT_ATTACKER)
	/// List of objects exempt from reducing dodge probabilities
	var/list/exempt_objects = list(
		/obj/item/melee/baton/nunchaku,
		/obj/item/staff/bostaff,
		/obj/item/bambostaff,
		/obj/item/cane,
		/obj/item/nullrod/bostaff,
		/obj/item/knife,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/storage/toolbox,
		/obj/item/spear,
		/obj/item/claymore/shortsword,
		/obj/item/nullrod/nullblade,
		/obj/item/extendohand,
		/obj/item/mop,
		/obj/item/pushbroom,
		/obj/item/melee/baseball_bat,
		/obj/item/crowbar/hammer,
		/obj/item/toy/plush/carpplushie,
	)

/datum/martial_art/the_sleeping_carp/activate_style(mob/living/new_holder)
	. = ..()
	new_holder.add_traits(scarp_traits, SLEEPING_CARP_TRAIT)
	RegisterSignal(new_holder, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(new_holder, COMSIG_ATOM_PRE_BULLET_ACT, PROC_REF(hit_by_projectile))
	RegisterSignal(new_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(check_dodge))
	new_holder.add_faction(FACTION_CARP) //:D
	new_holder.grant_language(/datum/language/carptongue, ALL, type)

/datum/martial_art/the_sleeping_carp/deactivate_style(mob/living/remove_from)
	remove_from.remove_traits(scarp_traits, SLEEPING_CARP_TRAIT)
	UnregisterSignal(remove_from, list(COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_PRE_BULLET_ACT, COMSIG_LIVING_CHECK_BLOCK))
	remove_from.remove_faction(FACTION_CARP) //:(
	if (!QDELING(remove_from))
		remove_from.remove_language(/datum/language/carptongue, ALL, type)
	return ..()

/datum/martial_art/the_sleeping_carp/proc/check_streak(mob/living/attacker, mob/living/defender)
	if(findtext(streak,WRIST_WRENCH_COMBO))
		reset_streak()
		return wrist_wrench(attacker, defender)

	if(findtext(streak,LAUNCH_KICK_COMBO))
		reset_streak()
		return launch_kick(attacker, defender)

	if(findtext(streak,DROP_KICK_COMBO))
		reset_streak()
		return drop_kick(attacker, defender)

	if(findtext(streak,KNEE_STOMACH_COMBO))
		reset_streak()
		return knee_stomach(attacker, defender)

	return FALSE

/// Gnashing Teeth: Harm Grab, twists and possibly breaks the target's arm, disarming them.
/datum/martial_art/the_sleeping_carp/proc/wrist_wrench(mob/living/attacker, mob/living/defender)
	// Determine if our defender is a carbon. If not, we don't wrist wrench
	if(!iscarbon(defender))
		return FALSE

	// Determine if our target has a functioning active arm. If not, return.
	var/obj/item/bodypart/affecting = defender.get_active_hand()

	if(!affecting)
		return FALSE

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	defender.visible_message(
		span_danger("[attacker]猛地扭转了[defender]的[affecting]！"),
		span_userdanger("[attacker]猛地扭转了你的[affecting]！"),
		span_hear("你听到了令人作呕的骨裂声！"),
		null,
		attacker,
	)
	to_chat(attacker, span_danger("你猛地扭转了[defender]的[affecting]！"))
	playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)
	log_combat(attacker, defender, "wrist wrenched (Sleeping Carp)")
	defender.apply_damage(20, BRUTE, affecting, wound_bonus = 30)
	defender.drop_all_held_items()
	return TRUE

/// Crashing Wave Kick: Harm Disarm combo, throws people seven tiles backwards
/datum/martial_art/the_sleeping_carp/proc/launch_kick(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	defender.visible_message(
		span_warning("[attacker]一脚正中[defender]的胸口，将其踢飞！"),
		span_userdanger("[attacker]一脚正中你的胸口，将你踢飞！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
	defender.throw_at(throw_target, 7, 4, attacker)
	defender.apply_damage(15, attacker.get_attack_type(), BODY_ZONE_CHEST, wound_bonus = CANT_WOUND)
	log_combat(attacker, defender, "launchkicked (Sleeping Carp)")
	return TRUE

/// Keelhaul: Disarm Disarm combo, knocks people down and deals substantial stamina damage, and also discombobulates them. Knocks objects out of their hands if they're already on the ground.
/datum/martial_art/the_sleeping_carp/proc/drop_kick(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	if(defender.body_position == STANDING_UP)
		defender.Knockdown(4 SECONDS)
		defender.visible_message(span_warning("[attacker]踢中了[defender]的头，将其踢得脸朝下摔在地上！"), \
					span_userdanger("[attacker]踢中了你的头，将你踢倒在地！"), span_hear("你听到了令人作呕的肉体撞击声！"), COMBAT_MESSAGE_RANGE, attacker)
	else
		defender.drop_all_held_items()
		defender.visible_message(span_warning("[attacker]踢中了[defender]的头！"), \
					span_userdanger("[attacker]踢中了你的头！"), span_hear("你听到了令人作呕的肉体撞击声！"), COMBAT_MESSAGE_RANGE, attacker)
	defender.apply_damage(40, STAMINA)
	defender.adjust_dizzy_up_to(10 SECONDS, 10 SECONDS)
	defender.adjust_temp_blindness_up_to(2 SECONDS, 10 SECONDS)
	log_combat(attacker, defender, "dropkicked (Sleeping Carp)")
	return TRUE

/// Kraken Wrack: Grab Harm combo, causes them to be silenced and briefly stunned, as well as doing a moderate amount of stamina damage.
/datum/martial_art/the_sleeping_carp/proc/knee_stomach(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	playsound(attacker, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	defender.visible_message(
		span_warning("[attacker]一记凶狠的膝撞击中了[defender]！"),
		span_userdanger("[attacker]的膝盖狠狠撞中了你！"),
		span_hear("你听到了令人作呕的肉体撞击声！"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	defender.apply_damage(20, STAMINA)
	defender.Paralyze(1 SECONDS)
	defender.adjust_silence_up_to(5 SECONDS, 5 SECONDS)
	if(defender.losebreath <= 10)
		defender.losebreath = clamp(defender.losebreath + 5, 0, 10)
	log_combat(attacker, defender, "kneed in the stomach (Sleeping Carp)")
	return TRUE

/datum/martial_art/the_sleeping_carp/grab_act(mob/living/attacker, mob/living/defender)
	if(!can_deflect(attacker)) //allows for deniability
		return MARTIAL_ATTACK_INVALID

	if(defender.check_block(attacker, 0, "[attacker]的抓取", UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("G", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	var/grab_log_description = "grabbed"
	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)
	if(!IS_UNCONSCIOUS(defender) && defender.get_stamina_loss() >= 80) //We put our target to sleep.
		defender.visible_message(
			span_danger("[attacker]精准地捏住[defender]颈部的一条神经，使其失去意识！"),
			span_userdanger("[attacker]捏住了你颈部的某个部位，你失去了意识！"),
		)
		grab_log_description = "grabbed and nerve pinched"
		defender.Unconscious(10 SECONDS)
	defender.apply_damage(20, STAMINA)
	log_combat(attacker, defender, "[grab_log_description] (Sleeping Carp)")
	return MARTIAL_ATTACK_INVALID // normal grab

/datum/martial_art/the_sleeping_carp/harm_act(mob/living/attacker, mob/living/defender)
	if(attacker.grab_state == GRAB_KILL \
		&& attacker.zone_selected == BODY_ZONE_HEAD \
		&& attacker.pulling == defender \
		&& defender.stat != DEAD \
	)
		var/obj/item/bodypart/head = defender.get_bodypart(BODY_ZONE_HEAD)
		if(!isnull(head))
			playsound(defender, 'sound/effects/wounds/crack1.ogg', 100)
			defender.visible_message(
				span_danger("[attacker]扭断了[defender]的脖子！"),
				span_userdanger("[attacker]扭断了你的脖子！"),
				span_hear("你听到一声令人作呕的脆响！"),
				ignored_mobs = attacker
			)
			to_chat(attacker, span_danger("你动作利落地扭断了[defender]的脖子！"))
			log_combat(attacker, defender, "snapped neck")
			defender.apply_damage(100, BRUTE, BODY_ZONE_HEAD, wound_bonus=CANT_WOUND)
			if(!HAS_TRAIT(defender, TRAIT_NODEATH))
				defender.death()
				defender.investigate_log("被[attacker]扭断了脖子。", INVESTIGATE_DEATHS)
			return MARTIAL_ATTACK_SUCCESS

	if(defender.check_block(attacker, 10, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("H", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_INVALID // normal punch

/datum/martial_art/the_sleeping_carp/disarm_act(mob/living/attacker, mob/living/defender)
	if(!can_deflect(attacker)) //allows for deniability
		return MARTIAL_ATTACK_INVALID
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	playsound(defender, 'sound/items/weapons/punch1.ogg', 25, TRUE, -1)
	defender.apply_damage(20, STAMINA)
	log_combat(attacker, defender, "disarmed (Sleeping Carp)")
	return MARTIAL_ATTACK_INVALID // normal disarm

/datum/martial_art/the_sleeping_carp/proc/can_deflect(mob/living/carp_user)
	if(!can_use(carp_user) || !carp_user.combat_mode)
		return FALSE
	if(INCAPACITATED_IGNORING(carp_user, INCAPABLE_GRAB)) //NO STUN
		return FALSE
	if(!(carp_user.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return FALSE
	if(HAS_TRAIT(carp_user, TRAIT_HULK)) //NO HULK
		return FALSE
	if(!isturf(carp_user.loc)) //NO MOTHERFLIPPIN MECHS!
		return FALSE
	return TRUE

/datum/martial_art/the_sleeping_carp/proc/hit_by_projectile(mob/living/carp_user, obj/projectile/hitting_projectile, def_zone)
	SIGNAL_HANDLER

	var/determine_avoidance = 100
	var/additional_adjustments = 0

	if(istype(hitting_projectile, /obj/projectile/bullet/c38/match/true)) // 75% chance to ignore evasion
		additional_adjustments -= 75

	determine_avoidance = clamp(determine_avoidance + carp_style_check(carp_user) + additional_adjustments, 0, 100)

	if(istype(hitting_projectile, /obj/projectile/bullet/harpoon)) // WHITE WHALE HOLY GRAIL
		return NONE

	if(!can_deflect(carp_user))
		return NONE

	if(!prob(determine_avoidance))
		return NONE



	carp_user.visible_message(
		span_danger("[carp_user]轻而易举地拍开了[hitting_projectile]！居然能徒手挡子弹！"),
		span_userdanger("你弹开了[hitting_projectile]！"),
	)
	playsound(carp_user, SFX_BULLET_MISS, 75, TRUE)
	hitting_projectile.firer = carp_user
	hitting_projectile.set_angle(rand(0, 360))//SHING
	return COMPONENT_BULLET_PIERCED

/// Signal from getting attacked with an item, for a special interaction with touch spells
/datum/martial_art/the_sleeping_carp/proc/on_attackby(mob/living/carp_user, obj/item/attack_weapon, mob/attacker, list/modifiers)
	SIGNAL_HANDLER

	if(!istype(attack_weapon, /obj/item/melee/touch_attack))
		return
	if(!can_deflect(carp_user))
		return
	var/obj/item/melee/touch_attack/touch_weapon = attack_weapon
	carp_user.visible_message(
		span_danger("[carp_user]小心地躲开了[attacker]的[touch_weapon]！"),
		span_userdanger("你格外小心，避开了[attacker]的[touch_weapon]！"),
	)
	return COMPONENT_NO_AFTERATTACK

/// If our user has committed to being as martial arty as they can be, they may be able to avoid incoming attacks.
/datum/martial_art/the_sleeping_carp/proc/check_dodge(mob/living/carp_user, atom/movable/hitby, damage, attack_text, attack_type, ...)
	SIGNAL_HANDLER

	var/determine_avoidance = clamp(round(carp_style_check(carp_user) / (attack_type == OVERWHELMING_ATTACK ? 2 : 1), 1), 0, 75)

	if(!can_deflect(carp_user))
		return

	if(attack_type == PROJECTILE_ATTACK || attack_type == THROWN_PROJECTILE_ATTACK)
		return NONE

	if(!prob(determine_avoidance))
		return NONE

	carp_user.visible_message(
		span_danger("[carp_user]以惊人的速度利落地避开了[attack_text]！"),
		span_userdanger("你躲开了[attack_text]！"),
	)
	playsound(carp_user.loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
	return SUCCESSFUL_BLOCK

/* Determines how 'carp-y' or how 'martial arts-y' we are, granting us the ability to avoid attacks.
* At a baseline, we will always avoid projectile attacks, but we may not necessarily avoid other attacks.
* If we wear carp based clothing, or martial arts based clothing, we improve our style factor.
* If we are a carp mutant, we improve our style factor.
* If we literally are a carp, we just assume we're very carpy and return our max value.
* If we wear a lot of armor, we reduce our style factor. Some martial arts or carp items may result in a net netural bonus.
* If there is anything in our hands, we're also less likely to avoid attacks.
*/
/datum/martial_art/the_sleeping_carp/proc/carp_style_check(mob/living/carp_user)
	// An evaluation of how 'carp' we are.
	var/style_factor_points = 0

	if(istype(carp_user, /mob/living/basic/space_dragon) || istype(carp_user, /mob/living/basic/carp))
		return 100

	if(!ishuman(carp_user)) // We're not concerned about nonhumans here, we can assume we've covered any relevant mobs by checking for carp.
		return 0

	var/mob/living/carbon/human/human_carp_user = carp_user

	var/obj/item/bodypart/potential_head = human_carp_user.get_bodypart(BODY_ZONE_HEAD)
	var/obj/item/bodypart/potential_chest = human_carp_user.get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/clothing/is_it_the_shoes = human_carp_user.get_item_by_slot(ITEM_SLOT_FEET)

	// The presence of armor and heavy objects is a style malus
	var/style_factor_malus = 0

	// Lets look to see if any relevant headwear is armored or on theme
	if(potential_head)
		for(var/obj/item/clothing/possible_headbands in human_carp_user.get_clothing_on_part(potential_head))
			if(possible_headbands.clothing_flags & CARP_STYLE_FACTOR)
				style_factor_points += 20 // Basically, you only need one chest level item to contribute
		style_factor_malus += human_carp_user.run_armor_check(potential_head, MELEE)

	// Then let's look for any chest clothing that is either armored or on theme
	if(potential_chest)
		for(var/obj/item/clothing/possible_gi in human_carp_user.get_clothing_on_part(potential_chest))
			if(possible_gi.clothing_flags & CARP_STYLE_FACTOR)
				style_factor_points += 20 // Only need one head level item to contribute
		style_factor_malus += human_carp_user.run_armor_check(potential_chest, MELEE)

	// We also consider whether our footwear is appropriate
	if(istype(is_it_the_shoes) && is_it_the_shoes.clothing_flags & CARP_STYLE_FACTOR)
		style_factor_points += 20

	// Achieved a carp state of mind.
	if(human_carp_user.has_status_effect(/datum/status_effect/organ_set_bonus/carp))
		style_factor_points += 20

	// We check for wielded objects. If they're not abstract items or exempt items, we add their weight as a penalty. And their block chance.
	for(var/obj/item/possibly_a_held_object in human_carp_user.held_items)
		if(possibly_a_held_object.item_flags & (ABSTRACT|HAND_ITEM) && !possibly_a_held_object.block_chance)
			continue

		if(possibly_a_held_object in exempt_objects)
			continue

		if(possibly_a_held_object.w_class <= WEIGHT_CLASS_SMALL && !possibly_a_held_object.block_chance)
			continue

		style_factor_malus += possibly_a_held_object.block_chance
		style_factor_malus += possibly_a_held_object.w_class * 10 * (HAS_TRAIT(possibly_a_held_object, TRAIT_WIELDED) ? 2 : 1)

	if(human_carp_user.body_position != STANDING_UP) // this ain't monkey style
		style_factor_points -= 30

	style_factor_points -= style_factor_malus

	return style_factor_points

/// Verb added to humans who learn the art of the sleeping carp.
/datum/martial_art/the_sleeping_carp/get_style_help()
	. = list()

	. += span_info("<b><i>你凝神内省，回忆起睡鲤拳的教诲……</i></b>\n\
		[span_notice("利齿撕咬")]：拳击、抓取。猛扭对手的手臂，使其脱臼甚至骨折，并迫使其丢下手中物品。\n\
		[span_notice("破浪踢")]：拳击、推搡。以惊人的力量将对手踢飞！\n\
		[span_notice("拖龙骨")]：推搡、推搡。以非致命踢击将对手打倒在地，扰乱其感官并造成大量耐力伤害；若对方已趴下，还会打落其手中物品。\n\
		[span_notice("海妖重击")]：抓取、拳击。以膝盖撞击对手，造成大量耐力伤害，并使其短暂眩晕、喘不过气、难以说话。\n\
		[span_notice("抓取与推搡")]：战斗模式下，普通抓取和推搡也会造成可观的耐力伤害，且抓取更难挣脱。抓住耐力严重耗尽的人时，你会将其击昏！\n\
		<span class='notice'>在战斗模式下，只要未眩晕、不是浩克且不在机甲中，你就能反弹所有来袭的投射物，将它们打回发射者身上！\n\
		然而，穿戴护甲或手持普通大小及更重的物品会降低你躲避投射物的能力。\n\
		若你身着武术或鲤鱼主题的服饰，全身心投入武者生活，则能获得更强的力量，甚至有机会躲避近战武器或徒手攻击。\n\
		部分近战武器，如长棍、长矛、短剑、刀、工具箱、棒球棍，以及无法格挡的小型物品，可以安全携带而不影响防御。善用这一点获取战术优势。\n\
		此外，你在战斗中更不易受创，肢体也不会被切断。这能让你在持久战中坚持更久，尤其是在面对斩击及其他致出血武器时。\n\
		但你并非无敌：即使较少受到严重创伤，你仍须留意生命值，并备好适当的医疗用品以便在战斗间隙使用。\n\
		此外，修行使你厌恶枪械，你已无法使用它们。</span>")
	return .

/obj/item/staff/bostaff
	name = "武术长棍"
	desc = "用抛光木材制成的长棍，是古老地球武术中的传统兵器。既可用于杀敌，也可用于制服对手。"
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 20
	throw_speed = 2
	attack_verb_continuous = list("猛砸", "重击", "敲打", "抽打")
	attack_verb_simple = list("猛砸", "重击", "敲打", "抽打")
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "bostaff0"
	base_icon_state = "bostaff"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	block_chance = 50

/obj/item/staff/bostaff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 10, \
		force_wielded = 24, \
	)

/obj/item/staff/bostaff/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

/obj/item/staff/bostaff/attack(mob/target, mob/living/user, list/modifiers, list/attack_modifiers)
	add_fingerprint(user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
		to_chat(user, span_warning("你用[src]砸中了自己的头。"))
		user.Paralyze(6 SECONDS)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(2*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(2*force)
		return
	if(iscyborg(target))
		return ..()
	if(!isliving(target))
		return ..()
	var/mob/living/carbon/C = target
	if(IS_UNCONSCIOUS_OR_CRIT(C))
		to_chat(user, span_warning("攻击无力还手的对手有违武德。"))
		return
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(!HAS_TRAIT(src, TRAIT_WIELDED))
			return ..()
		if(!ishuman(target))
			return ..()
		var/mob/living/carbon/human/H = target
		var/list/fluffmessages = list("棒击", "拍打", "横扫", "殴打", "重击")
		H.visible_message(span_warning("[user]用[src][pick(fluffmessages)]了[H]！"), \
						span_userdanger("[user]用[src][pick(fluffmessages)]了你！"), span_hear("你听到了令人作呕的肉体撞击声！"), null, user)
		to_chat(user, span_danger("你用[src][pick(fluffmessages)]了[H]！"))
		playsound(get_turf(user), 'sound/effects/woodhit.ogg', 75, TRUE, -1)
		H.adjust_stamina_loss(rand(13,20))
		if(prob(10))
			H.visible_message(span_warning("[H]倒下了！"), \
							span_userdanger("你的双腿支撑不住了！"))
			H.Paralyze(8 SECONDS)
		if(H.staminaloss && !H.IsSleeping())
			var/total_health = (H.health - H.staminaloss)
			if(total_health <= HEALTH_THRESHOLD_CRIT && !IS_UNCONSCIOUS_OR_CRIT(H))
				H.visible_message(span_warning("[user]重击了[H]的头部，将其打昏！"), \
								span_userdanger("[user]将你打昏了！"), span_hear("你听到了令人作呕的肉体撞击声！"), null, user)
				to_chat(user, span_danger("你重击了[H]的头部，将其打昏！"))
				H.SetSleeping(60 SECONDS)
				H.adjust_organ_loss(ORGAN_SLOT_BRAIN, 15, 150)
	else
		return ..()

/obj/item/staff/bostaff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!HAS_TRAIT(src, TRAIT_WIELDED))
		return ..()
	return FALSE

/obj/item/clothing/gloves/the_sleeping_carp
	name = "睡鲤手套"
	desc = "这副手套能让人施展睡鲤拳。"
	icon_state = "black"
	greyscale_colors = COLOR_BLACK
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/the_sleeping_carp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/the_sleeping_carp)

#undef WRIST_WRENCH_COMBO
#undef LAUNCH_KICK_COMBO
#undef DROP_KICK_COMBO
#undef KNEE_STOMACH_COMBO
