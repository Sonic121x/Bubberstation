// Cleaving saw

/obj/item/melee/cleaving_saw
	name = "劈砍锯"
	desc = "这把锯能高效地放野兽的血，还能变形为一把利用离心力的长劈刀。"
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	icon_state = "cleaving_saw"
	inhand_icon_state = "cleaving_saw"
	worn_icon_state = "cleaving_saw"
	attack_verb_continuous = list("攻击着", "锯切着", "切片着", "撕扯着", "割裂着", "撕裂着", "切丁着", "切割着")
	attack_verb_simple = list("攻击", "锯切", "切片", "撕扯", "割裂", "撕裂", "切丁", "切割")
	force = 12
	throwforce = 20
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	/// List of factions we deal bonus damage to
	var/list/nemesis_factions = list(FACTION_MINING, FACTION_BOSS)
	/// Amount of damage we deal to the above factions
	var/faction_bonus_force = 30
	/// Whether the cleaver is actively AoE swiping something.
	var/swiping = FALSE
	/// Amount of bleed stacks gained per hit
	var/bleed_stacks_per_hit = 3
	/// Force when the saw is opened.
	var/open_force = 20
	/// Throwforce when the saw is opened.
	var/open_throwforce = 20

/obj/item/melee/cleaving_saw/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		transform_cooldown_time = (CLICK_CD_MELEE * 0.25), \
		force_on = open_force, \
		throwforce_on = open_throwforce, \
		sharpness_on = sharpness, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		attack_verb_continuous_on = list("劈开着", "横打着", "斩击着", "砍剁着"), \
		attack_verb_simple_on = list("劈开", "横扫", "斩击", "砍剁"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/cleaving_saw/examine(mob/user)
	. = ..()
	. += span_notice("它处于[HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "展开状态，会以宽阔弧线劈砍敌人，并对动物造成额外伤害" : "闭合状态，可用于快速连续攻击，使动物流血"]。")
	. += span_notice("两种模式都会累积已有的流血效果，若流血叠得足够高，便会爆发一次高额伤害。")
	. += span_notice("在攻击后立刻变形，可让下一次攻击更快出手。")

/obj/item/melee/cleaving_saw/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 正[HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) ? "把 [src] 合上，夹住自己的脖子" : "把 [src] 张开，插进自己的胸膛"]！看起来是想自杀了！"))
	attack_self(user)
	return BRUTELOSS

/obj/item/melee/cleaving_saw/melee_attack_chain(mob/user, atom/target, list/modifiers)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		user.changeNext_move(CLICK_CD_MELEE * 0.5) //when closed, it attacks very rapidly

/obj/item/melee/cleaving_saw/attack(mob/living/target, mob/living/carbon/human/user, list/modifiers, list/attack_modifiers)
	var/is_open = HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE)
	if(!is_open || swiping || !target.density || get_turf(target) == get_turf(user))
		for(var/found_faction in target.get_faction())
			if(!(found_faction in nemesis_factions))
				continue
			if(is_open)
				MODIFY_ATTACK_FORCE(attack_modifiers, faction_bonus_force)
			nemesis_effects(user, target)
			break
		. = ..()
		return

	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	swiping = TRUE
	var/static/list/cleaving_saw_cleave_angles = list(0, -45, 45) //so that the animation animates towards the target clicked and not towards a side target
	for(var/i in cleaving_saw_cleave_angles)
		var/turf/turf = get_step(user_turf, turn(dir_to_target, i))
		for(var/mob/living/living_target in turf)
			if(user.Adjacent(living_target) && living_target.body_position != LYING_DOWN)
				melee_attack_chain(user, living_target)
	swiping = FALSE

/*
 * If we're attacking [target]s in our nemesis list, apply unique effects.
 *
 * user - the mob attacking with the saw
 * target - the mob being attacked
 */
/obj/item/melee/cleaving_saw/proc/nemesis_effects(mob/living/user, mob/living/target)
	if(istype(target, /mob/living/simple_animal/hostile/asteroid/elite))
		return
	var/datum/status_effect/stacking/saw_bleed/existing_bleed = target.has_status_effect(/datum/status_effect/stacking/saw_bleed)
	if(existing_bleed)
		existing_bleed.add_stacks(bleed_stacks_per_hit)
	else
		target.apply_status_effect(/datum/status_effect/stacking/saw_bleed, bleed_stacks_per_hit)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback and makes the nextmove after transforming much quicker.
 */
/obj/item/melee/cleaving_saw/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	user.changeNext_move(CLICK_CD_MELEE * 0.25)
	if(user)
		balloon_alert(user, "[active ? "已展开" : "已闭合"] [src]")
	playsound(src, 'sound/effects/magic/clockwork/fellowship_armory.ogg', 35, TRUE, frequency = 90000 - (active * 30000))
	return COMPONENT_NO_DEFAULT_MESSAGE

// Wildhunter's butchering knife

/obj/item/knife/hunting/wildhunter
	name = "野猎者的屠宰刀"
	desc = "一把用灰岩制成的魔法刀。曾是最好的猎手用来屠宰当地动物的工具。能把一切切成最简单的形态。"
	icon = 'icons/obj/weapons/stabby_wide.dmi'
	inhand_icon_state = "wildhuntingknife"
	icon_state = "wildhuntingknife"
	icon_angle = 180
	force = 20
	wound_bonus = 15
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("切片着", "狩猎着", "屠宰着", "刺穿着")
	attack_verb_simple = list("切片", "狩猎", "屠宰", "刺穿")

//best butchering tool
/obj/item/knife/hunting/wildhunter/set_butchering()
	AddComponent(\
		/datum/component/butchering, \
		speed = 1.5 SECONDS , \
		effectiveness = 125, \
		bonus_modifier = 0, \
	)

/obj/item/knife/hunting/wildhunter/make_stabby()
	return

//cut those trophies
/obj/item/knife/hunting/wildhunter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!istype(interacting_with, /obj/item/crusher_trophy))
		return NONE
	var/obj/item/crusher_trophy/trophy = interacting_with
	if(!length(trophy.wildhunter_drops))
		return NONE
	balloon_alert(user, "正在切割战利品……")
	if(!do_after(user, 4 SECONDS, trophy))
		return ITEM_INTERACT_BLOCKING
	for (var/path, count in trophy.wildhunter_drops)
		if (ispath(path, /obj/item/stack))
			new path(trophy.drop_location(), count)
			continue

		for (var/i in 1 to count)
			new path(trophy.drop_location())
	qdel(trophy)
	return ITEM_INTERACT_SUCCESS
