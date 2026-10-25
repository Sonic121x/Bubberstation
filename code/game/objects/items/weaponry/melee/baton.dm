/obj/item/melee/baton
	name = "警棍"
	desc = "一根木制警棍，专门用来揍那些罪犯渣滓。"
	desc_controls = "左键点击使目标晕眩，右键点击造成伤害。"
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "classic_baton"
	inhand_icon_state = "classic_baton"
	worn_icon_state = "classic_baton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 12 //9 hit crit
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 15
	sound_vary = TRUE

	/// Whether this baton is active or not
	var/active = TRUE
	/// Used interally, you don't want to modify
	var/cooldown_check = 0
	/// Default wait time until can stun again.
	var/cooldown = (4 SECONDS)
	/// The length of the knockdown applied to a struck living, non-cyborg mob.
	var/knockdown_time = (1.5 SECONDS)
	/// If affect_cyborg is TRUE, this is how long we stun cyborgs for on a hit.
	var/stun_time_cyborg = (5 SECONDS)
	/// The length of the knockdown applied to the user on clumsy_check()
	var/clumsy_knockdown_time = 18 SECONDS
	/// How much stamina damage we deal on a successful hit against a living, non-cyborg mob.
	var/stamina_damage = 55
	/// How much armor does our baton ignore? This operates as armour penetration, but only applies to the stun attack.
	var/stun_armour_penetration = 15 // pens very light / cosmetic armor
	/// What armor does our stun attack check before delivering the attack?
	var/armour_type_against_stun = MELEE
	/// Chance of causing force_say() when stunning a human mob
	var/force_say_chance = 33
	/// Can we stun cyborgs?
	var/affect_cyborg = FALSE
	/// The path of the default sound to play when we stun something.
	var/on_stun_sound = 'sound/effects/woodhit.ogg'
	/// The volume of the above.
	var/on_stun_volume = 75
	/// Whether the stun attack is logged. Only relevant for abductor batons, which have different modes.
	var/log_stun_attack = TRUE
	/// Boolean on whether people with chunky fingers can use this baton.
	var/chunky_finger_usable = FALSE
	/// Boolean, if TRUE when we harmbaton someone we will also try to stun if the baton is active / not on cooldown.
	var/stun_on_harmbaton = FALSE

	/// Text shown when trying to stun someone while the baton is on cooldown.
	var/wait_desc = ""

	/// What term do we use to describe our baton being 'ready', or the phrase to use when var/active is TRUE.
	var/activated_word = "就绪"

	/// The context to show when the baton is active and targeting a living thing
	var/context_living_target_active = "击晕"

	/// The context to show when the baton is active and targeting a living thing in combat mode
	var/context_living_target_active_combat_mode = "击晕"

	/// The context to show when the baton is inactive and targeting a living thing
	var/context_living_target_inactive = "戳刺"

	/// The context to show when the baton is inactive and targeting a living thing in combat mode
	var/context_living_target_inactive_combat_mode = "攻击"

	/// The RMB context to show when the baton is active and targeting a living thing
	var/context_living_rmb_active = "攻击"

	/// The RMB context to show when the baton is inactive and targeting a living thing
	var/context_living_rmb_inactive = "攻击"

/obj/item/melee/baton/Initialize(mapload)
	. = ..()

	register_item_context()
	add_deep_lore()

/obj/item/melee/baton/add_weapon_description()
	AddElement(/datum/element/weapon_description, attached_proc = PROC_REF(add_baton_notes))

/obj/item/melee/baton/proc/add_baton_notes()
	var/list/readout = list()

	if(affect_cyborg)
		readout += "它可以使半机械人晕眩 [round((stun_time_cyborg/10), 1)] 秒。"

	readout += "\n[active ? "它当前[span_warning("[activated_word]")]，能够击晕目标。" : "它[span_warning("未[activated_word]")]，无法击晕目标。"]"

	if(stamina_damage <= 0) // The advanced baton actually does have 0 stamina damage so...yeah.
		readout += "它要么[span_warning("完全无法进行击晕打击")]，要么[span_warning("以某种异常方式攻击")]。"
		return readout.Join("\n")

	readout += "击晕一名敌人需要 [span_warning("[HITS_TO_CRIT(stamina_damage)] 次打击")]。"

	readout += "\n每次打击的效果都可被 [span_warning("[armour_type_against_stun]")] 护甲削弱。"

	readout += "\n它的击晕穿甲能力为 [span_warning("[stun_armour_penetration]%")]。"
	return readout.Join("\n")

/obj/item/melee/baton/proc/add_deep_lore()
	return

#define STUN_ATTACK "stun attack"

/**
 * Checks if we can stun targets with the baton.
 *
 * Impure (has chat feedback and mutates state in some subtypes).
 * In other words don't call this unless a stun is being attempted.
 *
 * * target - The mob being hit with the baton
 * * user - The mob using the baton
 * * harmbatonning - Whether or not this is being called from a harmbaton attack
 *
 * Returns TRUE if we can stun the target, FALSE if we cannot.
 */
/obj/item/melee/baton/proc/try_stun(mob/living/target, mob/living/user, harmbatonning)
	PROTECTED_PROC(TRUE)
	if(!active)
		return FALSE
	if(!chunky_finger_usable && ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(human_user.check_chunky_fingers() && user.is_holding(src) && !HAS_MIND_TRAIT(user, TRAIT_CHUNKYFINGERS_IGNORE_BATON))
			if(!harmbatonning)
				balloon_alert(human_user, "手指太粗了！")
			return FALSE
	if(!COOLDOWN_FINISHED(src, cooldown_check))
		if(wait_desc && !harmbatonning)
			balloon_alert(user, wait_desc)
		return FALSE
	if(HAS_TRAIT_FROM(target, TRAIT_IWASBATONED, REF(user)) ) //no doublebaton abuse anon!
		if(!harmbatonning)
			target.balloon_alert(user, "还不能击晕！")
		return FALSE
	return TRUE

// Stun attack
/obj/item/melee/baton/pre_attack(atom/target, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return TRUE

	if(!isliving(target))
		return FALSE // bashing objects

	var/harmbatonning = LAZYACCESS(modifiers, RIGHT_CLICK)
	if(harmbatonning && !stun_on_harmbaton)
		return FALSE // harmbatonning, no stun

	// see if this attack will result in a stun, or if we need to cancel it
	if(!try_stun(target, user, harmbatonning))
		if(harmbatonning)
			return FALSE // if harmbatonning, ALwAYS attack
		if(active)
			return TRUE  // if active, but can't stun? no attack
		if(!user.combat_mode)
			return TRUE  // if not in combat mode? no attack

		return FALSE // otherwise, attack normally

	// clumsy people redirect this attack - yes, this bypasses IWASBATONED and such
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		user.visible_message(
			span_danger("[user]不小心用[src]砸到了自己的脑袋！真是个笨蛋！"),
			span_userdanger("你不小心用 [src] 砸到了自己的脑袋！"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)

		finalize_baton_attack(user, user, clumsy = TRUE)
		user.apply_damage(2 * force, BRUTE, BODY_ZONE_HEAD, attacking_item = src)
		log_combat(user, user, "因笨拙而误击晕了", src)
		user.do_attack_animation(user)
		user.changeNext_move(attack_speed)
		return TRUE // you hit yourself, nerd

	// if not harm batonning, we override the default attack properties do do nothing
	if(!harmbatonning)
		SET_ATTACK_FORCE(attack_modifiers, 0)
		MUTE_ATTACK_HITSOUND(attack_modifiers)
		HIDE_ATTACK_MESSAGES(attack_modifiers)
	// then denote the attack as "will stun" for afterattack
	LAZYSET(attack_modifiers, STUN_ATTACK, TRUE)
	return FALSE // attack and stun

// This is where stun gets applied
/obj/item/melee/baton/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(QDELETED(target) || !LAZYACCESS(attack_modifiers, STUN_ATTACK))
		return

	finalize_baton_attack(target, user)

	var/list/desc
	if(iscyborg(target))
		desc = get_cyborg_stun_description(target, user)
		if(!affect_cyborg)
			playsound(src, 'sound/effects/bang.ogg', 10, TRUE) //bonk
	else
		desc = get_stun_description(target, user)

	if(desc)
		target.visible_message(desc["visible"], desc["local"], visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)

/obj/item/melee/baton/apply_fantasy_bonuses(bonus)
	. = ..()
	stamina_damage = modify_fantasy_variable("stamina_damage", stamina_damage, bonus * 4)

/obj/item/melee/baton/remove_fantasy_bonuses(bonus)
	stamina_damage = reset_fantasy_variable("stamina_damage", stamina_damage)
	return ..()

/obj/item/melee/baton/add_item_context(datum/source, list/context, atom/target, mob/living/user)
	if (isturf(target))
		return NONE

	if (isobj(target))
		context[SCREENTIP_CONTEXT_LMB] = "攻击"
	else
		if (active)
			context[SCREENTIP_CONTEXT_RMB] = context_living_rmb_active

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_active_combat_mode
			else
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_active
		else
			context[SCREENTIP_CONTEXT_RMB] = context_living_rmb_inactive

			if (user.combat_mode)
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_inactive_combat_mode
			else
				context[SCREENTIP_CONTEXT_LMB] = context_living_target_inactive

	return CONTEXTUAL_SCREENTIP_SET

/// Wrapper for calling "stun()" and doing relevant vfx/sfx
/obj/item/melee/baton/proc/finalize_baton_attack(mob/living/target, mob/living/user, clumsy = FALSE)
	COOLDOWN_START(src, cooldown_check, cooldown)
	if(on_stun_sound)
		playsound(src, on_stun_sound, on_stun_volume, TRUE, -1)
	if(baton_effect(target, user, null, clumsy) && user)
		set_batoned(target, user, cooldown)
		log_combat(user, target, "击晕了", src.name)

/// The actual "stun()" of the stun baton
/obj/item/melee/baton/proc/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	PROTECTED_PROC(TRUE)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE)
	if(iscyborg(target))
		if(!affect_cyborg)
			return FALSE
		target.flash_act(affect_silicon = TRUE)
		target.Paralyze((isnull(stun_override) ? stun_time_cyborg : stun_override) * (trait_check ? 0.1 : 1))
		additional_effects_cyborg(target, user)
	else
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(prob(force_say_chance))
				human_target.force_say()
		var/armour_block = target.run_armor_check(BODY_ZONE_CHEST, armour_type_against_stun, null, null, stun_armour_penetration)
		target.apply_damage(stamina_damage, STAMINA, blocked = armour_block)
		if(!trait_check)
			target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	SEND_SIGNAL(target, COMSIG_MOB_BATONED, user, src)
	return TRUE

/// Default message for stunning a living, non-cyborg mob.
/obj/item/melee/baton/proc/get_stun_description(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	. = list()
	.["visible"] = span_danger("[user] 用 [src] 击倒了 [target]！")
	.["local"] = span_userdanger("[user] 用 [src] 击倒了你！")

/// Default message for stunning a cyborg.
/obj/item/melee/baton/proc/get_cyborg_stun_description(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	. = list()
	if(affect_cyborg)
		.["visible"] = span_danger("[user] 用警棍干扰了 [target] 的传感器！")
		.["local"] = span_danger("你用警棍干扰了 [target] 的传感器！")
	else
		.["visible"] = span_danger("[user] 试图用 [src] 击倒 [target]，结果不出所料地失败了！") //look at this duuuuuude
		.["local"] = span_userdanger("[user] 想用 [src]……击倒你？") //look at the top of his head!

/// Contains any special effects that we apply to living, non-cyborg mobs we stun. Does not include applying a knockdown, dealing stamina damage, etc.
/obj/item/melee/baton/proc/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	return

/// Contains any special effects that we apply to cyborgs we stun. Does not include flashing the cyborg's screen, hardstunning them, etc.
/obj/item/melee/baton/proc/additional_effects_cyborg(mob/living/target, mob/living/user)
	PROTECTED_PROC(TRUE)
	return

/// Used in marking a target as being hit by a baton
/obj/item/melee/baton/proc/set_batoned(mob/living/target, mob/living/user, cooldown)
	PRIVATE_PROC(TRUE)
	if(!cooldown)
		return
	var/user_ref = REF(user) // avoids harddels.
	ADD_TRAIT(target, TRAIT_IWASBATONED, user_ref)
	addtimer(TRAIT_CALLBACK_REMOVE(target, TRAIT_IWASBATONED, user_ref), cooldown)

#undef STUN_ATTACK

/obj/item/conversion_kit
	name = "改装套件"
	desc = "一个奇怪的盒子，里面装着木工工具和一张说明书，可以把电击棍改造成别的东西。"
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "uk"
	custom_price = PAYCHECK_COMMAND * 4.5

/obj/item/melee/baton/telescopic
	name = "伸缩警棍"
	desc = "一种紧凑而坚固的个人防卫武器，折叠后可以隐藏携带。"
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "telebaton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	inhand_icon_state = null
	attack_verb_continuous = list("hits", "pokes")
	attack_verb_simple = list("hit", "poke")
	worn_icon_state = "tele_baton"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	exposed_wound_bonus = 5
	clumsy_knockdown_time = 15 SECONDS
	active = FALSE
	activated_word = "已展开"
	var/folded_drop_sound = 'sound/items/baton/telescopic_baton_folded_drop.ogg'
	var/folded_pickup_sound = 'sound/items/baton/telescopic_baton_folded_pickup.ogg'
	var/unfolded_drop_sound = 'sound/items/baton/telescopic_baton_unfolded_drop.ogg'
	var/unfolded_pickup_sound = 'sound/items/baton/telescopic_baton_unfolded_pickup.ogg'
	pickup_sound = 'sound/items/baton/telescopic_baton_folded_pickup.ogg'
	drop_sound = 'sound/items/baton/telescopic_baton_folded_drop.ogg'
	sound_vary = TRUE
	/// The sound effecte played when our baton is extended.
	var/on_sound = 'sound/items/weapons/batonextend.ogg'
	/// The inhand iconstate used when our baton is extended.
	var/on_inhand_icon_state = "nullrod"
	/// The force on extension.
	var/active_force = 10

/obj/item/melee/baton/telescopic/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE, \
		attack_verb_continuous_on = list("smacks", "strikes", "cracks", "beats"), \
		attack_verb_simple_on = list("smack", "strike", "crack", "beat"), \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/obj/item/melee/baton/telescopic/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.apply_status_effect(/datum/status_effect/dazed)

/obj/item/melee/baton/telescopic/suicide_act(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	var/obj/item/organ/brain/our_brain = human_user.get_organ_by_type(/obj/item/organ/brain)

	user.visible_message(span_suicide("[user]把[src]塞进自己的鼻孔，按下了“展开”按钮！看起来是想把脑子清空。"))
	if(active)
		playsound(src, on_sound, 50, TRUE)
		add_fingerprint(user)
	else
		attack_self(user)

	sleep(0.3 SECONDS)
	if (QDELETED(human_user))
		return
	if(!QDELETED(our_brain))
		human_user.organs -= our_brain
		qdel(our_brain)
	new /obj/effect/gibspawner/generic(human_user.drop_location(), human_user)
	return BRUTELOSS

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback to the user and makes it show up inhand.
 */
/obj/item/melee/baton/telescopic/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	src.active = active
	inhand_icon_state = active ? on_inhand_icon_state : null // When inactive, there is no inhand icon_state.
	if(user)
		balloon_alert(user, active ? "已展开" : "已收起")
	if(!active)
		drop_sound = folded_drop_sound
		pickup_sound = folded_pickup_sound
	else
		drop_sound = unfolded_drop_sound
		pickup_sound = unfolded_pickup_sound
	playsound(src, on_sound, 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/baton/telescopic/bronze
	name = "青铜帽伸缩警棍"
	desc = "一种紧凑而坚固的个人防卫武器，折叠后可以隐藏携带。这把被评为青铜级，因此穿甲能力平平。"
	icon_state = "telebaton_bronze"

/obj/item/melee/baton/telescopic/silver
	name = "白银帽伸缩警棍"
	desc = "一种紧凑而坚固的个人防卫武器，折叠后可以隐藏携带。这把被评为白银级，因此穿甲能力尚可。"
	icon_state = "telebaton_silver"
	stun_armour_penetration = 30 // strong enough to pen sec armor

/obj/item/melee/baton/telescopic/gold
	name = "黄金帽伸缩警棍"
	desc = "一种紧凑而坚固的个人防卫武器，折叠后可以隐藏携带。这把被评为黄金级，因此穿甲能力出众。"
	icon_state = "telebaton_gold"
	stun_armour_penetration = 50 // strong enough to pen syndicate modsuits

/obj/item/melee/baton/telescopic/contractor_baton
	name = "承包商警棍"
	desc = "一种高科技伸缩电击棍，由赛博太阳工业研发。向目标的中枢神经系统释放精确电击，使其丧失行动能力。"
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "contractor_baton"
	worn_icon_state = "contractor_baton"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 5
	cooldown = 2.5 SECONDS
	force_say_chance = 80 //very high force say chance because it's funny
	stamina_damage = 85
	stun_armour_penetration = 30 // strong enough to pen sec armor
	clumsy_knockdown_time = 24 SECONDS
	affect_cyborg = TRUE
	wait_desc = "仍在充电！"
	on_stun_sound = 'sound/items/weapons/contractor_baton/contractorbatonhit.ogg'
	unfolded_drop_sound = 'sound/items/baton/contractor_baton_unfolded_pickup.ogg'
	unfolded_pickup_sound = 'sound/items/baton/contractor_baton_unfolded_pickup.ogg'

	on_inhand_icon_state = "contractor_baton_on"
	on_sound = 'sound/items/weapons/contractorbatonextend.ogg'
	active_force = 16

/obj/item/melee/baton/telescopic/contractor_baton/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	. = ..()
	target.set_jitter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))

/obj/item/melee/baton/security
	name = "电击棍"
	desc = "安全拘捕装置，由纳米传讯研发。向目标的中枢神经系统释放精确电击，使其丧失行动能力。"
	desc_controls = "左键点击使目标晕眩，右键点击造成伤害。"
	icon = 'icons/obj/weapons/baton.dmi'
	icon_state = "stunbaton"
	base_icon_state = "stunbaton"
	inhand_icon_state = "stunbaton"
	worn_icon_state = "baton"
	icon_angle = -45
	force = 10
	wound_bonus = 0
	attack_verb_continuous = list("beats")
	attack_verb_simple = list("beat")
	armor_type = /datum/armor/baton_security
	throwforce = 7
	force_say_chance = 50
	stamina_damage = 60
	armour_type_against_stun = ENERGY
	knockdown_time = 5 SECONDS
	clumsy_knockdown_time = 15 SECONDS
	cooldown = 2.5 SECONDS
	on_stun_sound = 'sound/items/weapons/egloves.ogg'
	on_stun_volume = 50
	active = FALSE
	stun_on_harmbaton = TRUE
	wait_desc = "仍在充电！"
	activated_word = "已激活"
	context_living_rmb_active = "伤害性击晕"
	light_range = 1.5
	light_system = OVERLAY_LIGHT
	light_on = FALSE
	light_color = LIGHT_COLOR_ORANGE
	light_power = 0.5
	var/inactive_drop_sound = 'sound/items/baton/stun_baton_inactive_drop.ogg'
	var/inactive_pickup_sound = 'sound/items/baton/stun_baton_inactive_pickup.ogg'
	var/active_drop_sound = 'sound/items/baton/stun_baton_active_drop.ogg'
	var/active_pickup_sound = 'sound/items/baton/stun_baton_active_pickup.ogg'
	drop_sound = 'sound/items/baton/stun_baton_inactive_drop.ogg'
	pickup_sound = 'sound/items/baton/stun_baton_inactive_pickup.ogg'
	sound_vary = TRUE

	var/throw_stun_chance = 35
	var/obj/item/stock_parts/power_store/cell
	var/preload_cell_type //if not empty the baton starts with this type of cell
	var/cell_hit_cost = STANDARD_CELL_CHARGE
	var/can_remove_cell = TRUE
	var/convertible = TRUE //if it can be converted with a conversion kit
	///Whether or not our inhand changes when active.
	var/active_changes_inhand = TRUE
	///When set, inhand_icon_state defaults to this instead of base_icon_state
	var/base_inhand_state = null

/datum/armor/baton_security
	bomb = 50
	fire = 80
	acid = 80

/obj/item/melee/baton/security/Initialize(mapload)
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type, /obj/item/stock_parts/power_store/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	RegisterSignal(src, COMSIG_ATOM_ATTACKBY, PROC_REF(convert))
	update_appearance()

/obj/item/melee/baton/security/get_cell()
	return cell

/obj/item/melee/baton/security/suicide_act(mob/living/user)
	if(cell?.charge && active)
		user.visible_message(span_suicide("[user]把通着电的[name]塞进了自己的嘴里！看起来是想自杀！"))
		finalize_baton_attack(user, user)
		return FIRELOSS
	else
		user.visible_message(span_suicide("[user]把[src]塞进了自己的喉咙！看起来是想自杀！"))
		return OXYLOSS

/obj/item/melee/baton/security/Destroy()
	if(cell)
		QDEL_NULL(cell)
	UnregisterSignal(src, COMSIG_ATOM_ATTACKBY)
	return ..()

/obj/item/melee/baton/security/proc/convert(datum/source, obj/item/item, mob/user)
	SIGNAL_HANDLER

	if(!istype(item, /obj/item/conversion_kit) || !convertible)
		return
	var/turf/source_turf = get_turf(src)
	var/obj/item/melee/baton/baton = new (source_turf)
	baton.alpha = 20
	playsound(source_turf, 'sound/items/tools/drill_use.ogg', 80, TRUE, -1)
	animate(src, alpha = 0, time = 1 SECONDS)
	animate(baton, alpha = 255, time = 1 SECONDS)
	qdel(item)
	qdel(src)

/obj/item/melee/baton/security/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(!active)
		return
	turn_off()
	update_appearance()
	return TRUE

/obj/item/melee/baton/security/Exited(atom/movable/mov_content)
	. = ..()
	if(mov_content == cell)
		cell = null
		turn_off()
		update_appearance()

/obj/item/melee/baton/security/update_icon_state()
	var/base_inhand = base_inhand_state || base_icon_state
	if(active)
		icon_state = "[base_icon_state]_active"
		if(active_changes_inhand)
			inhand_icon_state = "[base_inhand]_active"
		return ..()
	if(!cell)
		icon_state = "[base_icon_state]_nocell"
		inhand_icon_state = base_inhand
		return ..()
	icon_state = base_icon_state
	inhand_icon_state = base_inhand
	return ..()

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("[src] 当前电量为 [round(cell.percent())]%。")
	else
		. += span_warning("[src] 没有安装电源。")

/obj/item/melee/baton/security/screwdriver_act(mob/living/user, obj/item/tool)
	if(tryremovecell(user))
		tool.play_tool_sound(src)
	return TRUE

/obj/item/melee/baton/security/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stock_parts/power_store/cell))
		return NONE
	if(cell)
		to_chat(user, span_warning("[src] 已经有电池了！"))
		return ITEM_INTERACT_BLOCKING

	if(astype(tool, /obj/item/stock_parts/power_store/cell).maxcharge < cell_hit_cost)
		to_chat(user, span_notice("[src] 需要容量更高的电池。"))
		return ITEM_INTERACT_BLOCKING

	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING

	cell = tool
	to_chat(user, span_notice("你在 [src] 中装入了一块电池。"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/baton/security/proc/tryremovecell(mob/user)
	if(cell && can_remove_cell)
		cell.forceMove(drop_location())
		to_chat(user, span_notice("你从 [src] 中取出了电池。"))
		return TRUE
	return FALSE

/obj/item/melee/baton/security/attack_self(mob/user)
	if(cell?.charge >= cell_hit_cost && !active)
		turn_on(user)
		balloon_alert(user, "已开启")
	else
		turn_off()
		if(!cell)
			balloon_alert(user, "没有电源！")
		else if(cell?.charge < cell_hit_cost)
			balloon_alert(user, "电量耗尽！")
		else
			balloon_alert(user, "已关闭")
	add_fingerprint(user)

/// Toggles the stun baton's light
/obj/item/melee/baton/security/proc/toggle_light()
	set_light_on(!light_on)

/obj/item/melee/baton/security/proc/turn_on(mob/user)
	active = TRUE
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	update_appearance()
	toggle_light()
	do_sparks(1, TRUE, src)
	drop_sound = active_drop_sound
	pickup_sound = active_pickup_sound

/obj/item/melee/baton/security/proc/turn_off()
	active = FALSE
	set_light_on(FALSE)
	update_appearance()
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	drop_sound = inactive_drop_sound
	pickup_sound = inactive_pickup_sound

/obj/item/melee/baton/security/proc/deductcharge(deducted_charge)
	if(!cell)
		return
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not
	. = cell.use(deducted_charge)
	if(active && cell.charge < cell_hit_cost)
		//we're below minimum, turn off
		turn_off()

/obj/item/melee/baton/security/try_stun(mob/living/target, mob/living/user, harmbatonning)
	if(!active && !harmbatonning && !user.combat_mode)
		target.visible_message(
			span_warning("[user] 用 [src] 戳了戳 [target]。幸好它关着。"),
			span_warning("[user] 用 [src] 戳了戳你。幸好它关着。"),
			visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE,
		)
		return FALSE

	return ..()

/obj/item/melee/baton/security/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	if(iscyborg(loc))
		var/mob/living/silicon/robot/robot = loc
		if(!robot || !robot.cell || !robot.cell.use(cell_hit_cost))
			return FALSE
	else if(!deductcharge(cell_hit_cost))
		return FALSE
	stun_override = 0 //Avoids knocking people down prematurely.
	return ..()

/*
 * After a target is hit, we apply some status effects.
 * After a period of time, we then check to see what stun duration we give.
 */
/obj/item/melee/baton/security/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.set_jitter_if_lower(40 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_confusion_if_lower(10 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))
	target.set_stutter_if_lower(16 SECONDS * (HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) ? 0.5 : 1))

	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect_end), target), 2 SECONDS)

/// After the initial stun period, we check to see if the target needs to have the stun applied.
/obj/item/melee/baton/security/proc/apply_stun_effect_end(mob/living/target)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
	if(!target.IsKnockdown())
		to_chat(target, span_warning("你的肌肉一阵痉挛，使你瘫倒在地[trait_check ? "，但你的身体很快恢复了过来……" : "！"]"))

	if(!trait_check)
		target.Knockdown(knockdown_time)

/obj/item/melee/baton/security/get_stun_description(mob/living/target, mob/living/user)
	. = list()

	.["visible"] = span_danger("[user] 用 [src] 击晕了 [target]！")
	.["local"] = span_userdanger("[user] 用 [src] 击晕了你！")

/obj/item/melee/baton/security/get_cyborg_stun_description(mob/living/target, mob/living/user)
	. = ..()
	if(!affect_cyborg)
		.["visible"] = span_danger("[user] 试图用 [src] 击晕 [target]，结果不出所料地失败了！")
		.["local"] = span_userdanger("[user] 想用 [src]……击晕你？")

/obj/item/melee/baton/security/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!. && active && prob(throw_stun_chance) && isliving(hit_atom))
		finalize_baton_attack(hit_atom, throwingdatum?.get_thrower())

/obj/item/melee/baton/security/emp_act(severity)
	. = ..()
	if (!cell)
		return
	if (!(. & EMP_PROTECT_SELF))
		cell.emp_act(severity)

	if (cell.charge >= cell_hit_cost)
		var/scramble_time
		scramble_mode()
		for(var/loops in 1 to rand(6, 12))
			scramble_time = rand(5, 15) / (1 SECONDS)
			addtimer(CALLBACK(src, PROC_REF(scramble_mode)), scramble_time*loops * (1 SECONDS))

/obj/item/melee/baton/security/proc/scramble_mode()
	if (!cell || cell.charge < cell_hit_cost)
		return
	active = !active
	toggle_light()
	do_sparks(1, TRUE, src)
	playsound(src, SFX_SPARKS, 75, TRUE, -1)
	update_appearance()

/obj/item/melee/baton/security/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/loaded/hos
	preload_cell_type = /obj/item/stock_parts/power_store/cell/super

// Stunsword Skins
/datum/atom_skin/stunsword
	abstract_type = /datum/atom_skin/stunsword
	change_inhand_icon_state = TRUE
	change_base_icon_state = TRUE
	change_worn_icon_state = FALSE

/datum/atom_skin/stunsword/default
	preview_name = "默认"
	new_icon_state = "stunsword"

/datum/atom_skin/stunsword/energy
	preview_name = "能量"
	new_icon_state = "stunsword_energy"

///Stun Sword
/obj/item/melee/baton/security/stunsword
	name = "\improper NT-20“王者之剑”电击剑"
	desc = "它是一把剑，还能电人，你还想要什么？"
	icon_state = "stunsword"
	inhand_icon_state = "stunsword"
	base_icon_state = "stunsword"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	w_class = WEIGHT_CLASS_HUGE
	sharpness = SHARP_EDGED
	force = 30
	throwforce = 10
	wound_bonus = 0
	exposed_wound_bonus = 30
	stun_armour_penetration = 40
	throw_stun_chance = 60
	convertible = FALSE

	obj_flags = UNIQUE_RENAME

/obj/item/melee/baton/security/stunsword/setup_reskins()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/stunsword)

/obj/item/melee/baton/security/stunsword/add_deep_lore()
	return

/obj/item/melee/baton/security/stunsword/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/bluespace // 40% stun_armour_penetration

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/melee/baton/security/cattleprod
	name = "电击杆"
	desc = "一根临时拼凑的电击棍。"
	desc_controls = "左键点击使目标晕眩，右键点击造成伤害。"
	icon = 'icons/obj/weapons/spear.dmi'
	icon_state = "stunprod"
	base_icon_state = "stunprod"
	inhand_icon_state = "prod"
	base_inhand_state = "prod"
	worn_icon_state = null
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 3
	throwforce = 5
	cell_hit_cost = STANDARD_CELL_CHARGE * 2
	throw_stun_chance = 10
	slot_flags = ITEM_SLOT_BACK
	convertible = FALSE
	active_changes_inhand = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	var/obj/item/assembly/igniter/sparkler
	///Determines whether or not we can improve the cattleprod into a new type. Prevents turning the cattleprod subtypes into different subtypes, or wasting materials on making it....another version of itself.
	var/can_upgrade = TRUE

/obj/item/melee/baton/security/cattleprod/Initialize(mapload)
	. = ..()
	sparkler = new (src)

/obj/item/melee/baton/security/cattleprod/add_deep_lore()
	return

/obj/item/melee/baton/security/cattleprod/item_interaction(mob/living/user, obj/item/tool, list/modifiers)//handles sticking a crystal onto a stunprod to make an improved cattleprod
	if(!istype(tool, /obj/item/stack))
		return ..()

	if(!can_upgrade)
		user.visible_message(span_warning("这根电击杆已经改良过了！"))
		return ITEM_INTERACT_BLOCKING

	if(cell)
		user.visible_message(span_warning("电击杆还装着电池时，你不能把晶体装上去！"))
		return ITEM_INTERACT_BLOCKING

	var/our_prod
	if(istype(tool, /obj/item/stack/ore/bluespace_crystal))
		var/obj/item/stack/ore/bluespace_crystal/our_crystal = tool
		our_crystal.use(1)
		our_prod = /obj/item/melee/baton/security/cattleprod/teleprod

	else if(istype(tool, /obj/item/stack/telecrystal))
		var/obj/item/stack/telecrystal/our_crystal = tool
		our_crystal.use(1)
		our_prod = /obj/item/melee/baton/security/cattleprod/telecrystalprod
	else
		to_chat(user, span_notice("你觉得 [tool] 无法改良 [src]。"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("你把 [tool] 牢牢插进了 [sparkler]。"))
	remove_item_from_storage(user)
	qdel(src)
	var/obj/item/melee/baton/security/cattleprod/brand_new_prod = new our_prod(user.loc)
	user.put_in_hands(brand_new_prod)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/baton/security/cattleprod/try_stun(mob/living/target, mob/living/user, harmbatonning)
	return ..() && sparkler.activate()

/obj/item/melee/baton/security/cattleprod/Destroy()
	QDEL_NULL(sparkler)
	return ..()

/obj/item/melee/baton/security/cattleprod/loaded
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/boomerang
	name = "\improper OZtek 回旋镖"
	desc = "这种高科技回旋镖由澳斯特拉利库斯联邦于 2486 年为伟大的太空鸸鹋战争发明，在击晕船员方面也格外好用。扔出去时记得接住！"
	throw_speed = 1
	icon = 'icons/obj/weapons/thrown.dmi'
	icon_state = "boomerang"
	base_icon_state = "boomerang"
	inhand_icon_state = "boomerang"
	force = 5
	throwforce = 5
	throw_range = 5
	cell_hit_cost = STANDARD_CELL_CHARGE * 2
	throw_stun_chance = 99  //Have you prayed today?
	convertible = FALSE
	active_changes_inhand = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*5, /datum/material/gold = SHEET_MATERIAL_AMOUNT)

/obj/item/melee/baton/security/boomerang/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range + 2, TRUE)

/obj/item/melee/baton/security/boomerang/add_deep_lore()
	return

/obj/item/melee/baton/security/boomerang/loaded //Same as above, comes with a cell.
	preload_cell_type = /obj/item/stock_parts/power_store/cell/high

/obj/item/melee/baton/security/cattleprod/teleprod
	name = "传送电击杆"
	desc = "末端装有蓝空间晶体的电击杆。那块晶体看起来可不太好碰。"
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "teleprod"
	base_icon_state = "teleprod"
	inhand_icon_state = "teleprod"
	slot_flags = null
	can_upgrade = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/melee/baton/security/cattleprod/teleprod/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	. = ..()
	if(!. || target.move_resist >= MOVE_FORCE_OVERPOWERING)
		return
	do_teleport(target, get_turf(target), clumsy ? 50 : 15, channel = TELEPORT_CHANNEL_BLUESPACE)

/obj/item/melee/baton/security/cattleprod/telecrystalprod
	name = "窃取杆"
	desc = "末端装有传送水晶的电击杆。它迸出的火花透着偷窃与颠覆的渴望。"
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "telecrystalprod"
	base_icon_state = "telecrystalprod"
	inhand_icon_state = "telecrystalprod"
	slot_flags = null
	throw_stun_chance = 50 //I think it'd be funny
	can_upgrade = FALSE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/telecrystal = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/melee/baton/security/cattleprod/telecrystalprod/baton_effect(mob/living/target, mob/living/user, stun_override, clumsy)
	. = ..()
	if(!.)
		return
	var/obj/item/stuff_in_hand = target.get_active_held_item()
	if(!user || !stuff_in_hand || !target.temporarilyRemoveItemFromInventory(stuff_in_hand))
		return
	if(user.put_in_inactive_hand(stuff_in_hand))
		stuff_in_hand.loc.visible_message(span_warning("[stuff_in_hand] 突然出现在 [user] 手中！"))
	else
		stuff_in_hand.forceMove(user.drop_location())
		stuff_in_hand.loc.visible_message(span_warning("[stuff_in_hand] 突然出现了！"))

	if(clumsy && user.dropItemToGround(src, force = TRUE, silent = TRUE))
		do_teleport(src, get_turf(user), 50, channel = TELEPORT_CHANNEL_BLUESPACE) //Wait, where did it go?

/obj/item/melee/baton/nunchaku
	name = "辛迪加健身双节棍"
	desc = "整个辛迪加最常见的健身器材，钛合金棍的重量严格为 13 磅"
	desc_controls = "左键点击使目标晕眩，右键点击造成伤害。投掷模式下可反击任何近战/投掷攻击。"
	icon_state = "nunchaku"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	inhand_icon_state = "nunchaku"
	worn_icon_state = "nunchaku"
	attack_verb_continuous = list("beats", "whips", "smashes", "punishes")
	attack_verb_simple = list("beat", "whip", "smash", "punish")
	hitsound = 'sound/items/weapons/chainhit.ogg'
	block_sound = 'sound/items/weapons/block_shield.ogg'
	slot_flags = ITEM_SLOT_BELT
	cooldown = CLICK_CD_MELEE
	knockdown_time = 0.25 SECONDS
	demolition_mod = 1.5
	stamina_damage = 30 // 4 hit stamcrit
	stun_armour_penetration = 25 // bronze-silver telescopic
	force = 16 // 7 hit crit
	exposed_wound_bonus = 5

/obj/item/melee/baton/nunchaku/proc/randomize_state()
	icon_state = pick(list("nunchaku", "nunchaku_x", "nunchaku_y"))
	update_appearance()

/obj/item/melee/baton/nunchaku/after_throw(datum/callback/callback)
	. = ..()
	randomize_state()

/obj/item/melee/baton/nunchaku/afterattack(atom/target, mob/user, click_parameters)
	. = ..()
	randomize_state()

/obj/item/melee/baton/nunchaku/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type, damage_type)
	if(attack_type == PROJECTILE_ATTACK || !owner.throw_mode)
		return ..()

	randomize_state()

	// blocks any melee/throwable attacks
	owner.adjust_stamina_loss(5)
	final_block_chance = 100

	// counterattack at melee
	if(attack_type in list(MELEE_ATTACK, UNARMED_ATTACK, LEAP_ATTACK))
		var/mob/living/attacker = GET_ASSAILANT(hitby)
		playsound(src, pick(list('sound/items/weapons/cqchit2.ogg', 'sound/items/weapons/cqchit1.ogg')), 70, FALSE)
		melee_attack_chain(owner, attacker, LEFT_CLICK)

	return ..()

// Deep Lore //

/obj/item/melee/baton/security/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以[EXAMINE_HINT("仔细观察")]以了解更多关于 [src] 的信息。"), \
		lore = "安全拘捕装置（在警员培训手册中有时简称 SAD）是 \
		钉头锤与电击杆的邪恶结合体。它被设计用来让罪犯当场止步，纳米传讯的安保人员 \
		几乎从不离身他们那根可靠的电击棍，前提是没把它丢在什么地方。<br>\
		<br>\
		纳米传讯的安保人员素来奉行“先棍后审”， \
		因此早已名声复杂。该装置只需用导电的打击头直接击中几次， \
		就能迅速关停罪犯的中枢神经系统。<br>\
		<br>\
		由于使用电击棍会带来种种伦理困境，地球政府的执法部门一直避免采用。 \
		对其使用情况的研究显示，被人类电击棍击中会造成大量 \
		长期的身体与精神影响。公民权利倡导团体抗议将电击棍 \
		作为执法工具普及，认为它们“不人道”且“专制”。而纳米传讯则 \
		毫无这种顾虑，把电击棍当作合规手段部署到其所有现有空间站 \
		和设施，用来对付自家不听话的员工。" \
	)

// Contractor Baton

/obj/item/melee/baton/telescopic/contractor_baton/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以[EXAMINE_HINT("仔细观察")]以了解更多关于 [src] 的信息。"), \
		lore = "契约获取装置（在加密通信中有时简称 CAD）是 \
		赛博太阳工业武器中最常见的一种。它与纳米传讯自家的安全拘捕装置 \
		用途相似，能够对目标造成迅速的中枢神经系统紊乱，使其陷入 \
		无助状态。它同时也是一根好用的钝器，这一点同样与电击棍相同。为了最大程度地 \
		便于隐藏，该警棍还能伸缩收起，只需扣动扳机 \
		就能迅速展开。<br>\
		<br>\
		承包商警棍因承包商而得名——他们是赛博太阳工业派去绑架并押走 \
		高价值敌方人员以进行审讯的精英外勤特工。任何有可能掌握纳米传讯机密或敏感数据的人 \
		都可能成为赛博太阳工业的目标。该公司不断雇用承包商 \
		探查纳米传讯的漏洞，从他们的员工开始。" \
	)
