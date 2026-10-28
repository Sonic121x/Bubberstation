/*
	Changeling Mutations! ~By Miauw (ALL OF IT :V)
	Contains:
		Arm Blade
		Space Suit
		Shield
		Armor
		Tentacles
*/


//Parent to shields and blades because muh copypasted code.
/datum/action/changeling/weapon
	abstract_type = /datum/action/changeling/weapon
	name = "有机武器"
	desc = "如果你看到这个，去告诉代码维护者"
	helptext = "去冲米奥和/或佩拉克普喊话"
	chemical_cost = 1000
	dna_cost = CHANGELING_POWER_UNOBTAINABLE

	var/silent = FALSE
	var/weapon_type
	var/weapon_name_simple

/datum/action/changeling/weapon/Grant(mob/granted_to)
	. = ..()
	if (!owner || !req_human)
		return
	RegisterSignal(granted_to, COMSIG_HUMAN_MONKEYIZE, PROC_REF(became_monkey))

/datum/action/changeling/weapon/Remove(mob/remove_from)
	UnregisterSignal(remove_from, COMSIG_HUMAN_MONKEYIZE)
	unequip_held(remove_from)
	return ..()

/// Remove weapons if we become a monkey
/datum/action/changeling/weapon/proc/became_monkey(mob/source)
	SIGNAL_HANDLER
	unequip_held(source)

/// Removes weapon if it exists, returns true if we removed something
/datum/action/changeling/weapon/proc/unequip_held(mob/user)
	var/found_weapon = FALSE
	for(var/obj/item/held in user.held_items)
		found_weapon = check_weapon(user, held) || found_weapon
	return found_weapon

/datum/action/changeling/weapon/try_to_sting(mob/user, mob/target)
	if (unequip_held(user))
		return
	..(user, target)

/datum/action/changeling/weapon/proc/check_weapon(mob/user, obj/item/hand_item)
	if(istype(hand_item, weapon_type))
		user.temporarilyRemoveItemFromInventory(hand_item, TRUE) //DROPDEL will delete the item
		if(!silent)
			playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
			user.visible_message(span_warning("[user] 伴着一声令人作呕的脆响，把自己的[weapon_name_simple]重新变回手臂！"), span_notice("我们把[weapon_name_simple]同化回体内。"), span_italics("你听到有机物被撕裂、扯开的声音！"))
		user.update_held_items()
		return TRUE

/datum/action/changeling/weapon/sting_action(mob/living/carbon/user)
	var/obj/item/held = user.get_active_held_item()
	if(held && !user.dropItemToGround(held))
		user.balloon_alert(user, "手被占用了！")
		return
	if(!istype(user))
		user.balloon_alert(user, "形态不对！")
		return
	..()
	var/limb_regen = 0
	if(HAS_TRAIT_FROM_ONLY(user, TRAIT_PARALYSIS_L_ARM, CHANGELING_TRAIT) || HAS_TRAIT_FROM_ONLY(user, TRAIT_PARALYSIS_R_ARM, CHANGELING_TRAIT))
		user.balloon_alert(user, "肌肉不够！") // no cheesing repuprosed glands
		return
	if(IS_RIGHT_INDEX(user.active_hand_index)) //we regen the arm before changing it into the weapon
		limb_regen = user.regenerate_limb(BODY_ZONE_R_ARM, 1)
	else
		limb_regen = user.regenerate_limb(BODY_ZONE_L_ARM, 1)
	if(limb_regen)
		user.visible_message(span_warning("[user] 缺失的手臂重新长了出来，发出响亮而怪诞的声音！"), span_userdanger("你的手臂重新长了出来，发出响亮的碎裂声，让你痛苦不堪！"), span_hear("你听到有机物被撕裂、扯开的声音！"))
		user.emote("scream")
	var/obj/item/W = new weapon_type(user, silent)
	user.put_in_hands(W)
	if(!silent)
		playsound(user, 'sound/effects/blob/blobattack.ogg', 30, TRUE)
	return W


//Parent to space suits and armor.
/datum/action/changeling/suit
	abstract_type = /datum/action/changeling/suit
	name = "有机护体"
	desc = "如果你看到这个，去告诉代码维护者"
	helptext = "去冲米奥和/或佩拉克普喊话"
	chemical_cost = 1000
	dna_cost = CHANGELING_POWER_UNOBTAINABLE

	var/helmet_type = null
	var/suit_type = null
	var/suit_name_simple = "    "
	var/helmet_name_simple = "     "
	var/recharge_slowdown = 0
	var/blood_on_castoff = 0

/datum/action/changeling/suit/Grant(mob/granted_to)
	. = ..()
	if (!owner || !req_human)
		return
	RegisterSignal(granted_to, COMSIG_HUMAN_MONKEYIZE, PROC_REF(became_monkey))

/datum/action/changeling/suit/Remove(mob/remove_from)
	UnregisterSignal(remove_from, COMSIG_HUMAN_MONKEYIZE)
	check_suit(remove_from)
	return ..()

/// Remove suit if we become a monkey
/datum/action/changeling/suit/proc/became_monkey()
	SIGNAL_HANDLER
	check_suit(owner)

/datum/action/changeling/suit/try_to_sting(mob/user, mob/target)
	if(check_suit(user))
		return
	var/mob/living/carbon/human/H = user
	..(H, target)

//checks if we already have an organic suit and casts it off.
/datum/action/changeling/suit/proc/check_suit(mob/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	if(!ishuman(user) || !changeling)
		return 1
	var/mob/living/carbon/human/H = user

	if(istype(H.wear_suit, suit_type) || istype(H.head, helmet_type))
		var/name_to_use = (isnull(suit_type) ? helmet_name_simple : suit_name_simple)
		H.visible_message(span_warning("[H] 褪下了自己的[name_to_use]！"), span_warning("我们褪下了自己的[name_to_use]。"), span_hear("你听到有机物被撕开、扯碎的声音！"))
		if(!isnull(helmet_type))
			H.temporarilyRemoveItemFromInventory(H.head, TRUE) //The qdel on dropped() takes care of it
		if(!isnull(suit_type))
			H.temporarilyRemoveItemFromInventory(H.wear_suit, TRUE)
		H.update_worn_oversuit()
		H.update_worn_head()
		H.update_body_parts()

		if(blood_on_castoff)
			H.add_splatter_floor()
			playsound(H.loc, 'sound/effects/splat.ogg', 50, TRUE) //So real sounds

		changeling.chem_recharge_slowdown -= recharge_slowdown
		return 1

/datum/action/changeling/suit/sting_action(mob/living/carbon/human/user)
	if(!user.canUnEquip(user.wear_suit) && !isnull(suit_type))
		user.balloon_alert(user, "身体被占用了！")
		return
	if(!user.canUnEquip(user.head) && !isnull(helmet_type))
		user.balloon_alert(user, "头部被占用了！")
		return
	..()
	if(!isnull(suit_type))
		user.dropItemToGround(user.wear_suit)
		user.equip_to_slot_if_possible(new suit_type(user), ITEM_SLOT_OCLOTHING, 1, 1, 1)
	if(!isnull(helmet_type))
		user.dropItemToGround(user.head)
		user.equip_to_slot_if_possible(new helmet_type(user), ITEM_SLOT_HEAD, 1, 1, 1)

	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user)
	changeling.chem_recharge_slowdown += recharge_slowdown
	return TRUE


//fancy headers yo
/***************************************\
|***************ARM BLADE***************|
\***************************************/
/datum/action/changeling/weapon/arm_blade
	name = "臂刃"
	desc = "我们把一条手臂重组成一把致命的刀刃。消耗 20 单位化学物质。"
	helptext = "我们可以用与生成时相同的方式收回臂刃。处于低等形态时无法使用。"
	button_icon_state = "arm_blade"
	category = "combat"
	chemical_cost = 20
	dna_cost = 2
	req_human = TRUE
	weapon_type = /obj/item/melee/arm_blade
	weapon_name_simple = "臂刃"

/obj/item/melee/arm_blade
	name = "臂刃"
	desc = "一把由骨骼与血肉构成的怪诞刀刃，切开人体如同热刀切黄油。"
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 25
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 10
	exposed_wound_bonus = 10
	armour_penetration = 35
	var/can_drop = FALSE
	var/fake = FALSE
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/melee/arm_blade/Initialize(mapload,silent,synthetic)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc) && !silent)
		loc.visible_message(span_warning("一把怪诞的刀刃在[loc.name]的手臂上成形！"), span_warning("我们的手臂扭曲变异，变成了一把致命的刀刃。"), span_hear("你听到有机物被撕开、扯碎的声音！"))
	if(synthetic)
		can_drop = TRUE
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	)

/obj/item/melee/arm_blade/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(QDELETED(target))
		return
	if(istype(target, /obj/structure/table))
		var/obj/smash = target
		smash.deconstruct(FALSE)

	else if(istype(target, /obj/machinery/computer))
		target.attack_alien(user) //muh copypasta

	else if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/opening = target

		if((!opening.requiresID() || opening.allowed(user)) && opening.hasPower()) //This is to prevent stupid shit like hitting a door with an arm blade, the door opening because you have acces and still getting a "the airlocks motors resist our efforts to force it" message, power requirement is so this doesn't stop unpowered doors from being pried open if you have access
			return
		if(opening.locked)
			opening.balloon_alert(user, "已上闩！")
			return

		if(opening.hasPower())
			user.visible_message(span_warning("[user] 把 [src] 插进气闸，开始把它撬开！"), span_warning("我们开始强行撬开[opening]。"), \
			span_hear("你听到金属刮擦的刺耳声。"))
			playsound(opening, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
			if(!do_after(user, 10 SECONDS, target = opening))
				return
		//user.say("Heeeeeeeeeerrre's Johnny!")
		user.visible_message(span_warning("[user] 用自己的[src]强行撬开了气闸！"), span_warning("我们强行撬开了[opening]。"), \
		span_hear("你听到金属刮擦的刺耳声。"))
		opening.open(BYPASS_DOOR_CHECKS)

/obj/item/melee/arm_blade/dropped(mob/user)
	..()
	if(can_drop)
		new /obj/item/melee/synthetic_arm_blade(get_turf(user))

/***************************************\
|***********COMBAT TENTACLES*************|
\***************************************/

/datum/action/changeling/weapon/tentacle
	name = "触手"
	desc = "我们准备好一条触手，用来抓取物品或猎物。消耗 10 单位化学物质。"
	helptext = "我们可以用它抓取一次远处的物品。若用于活物，效果取决于我们的战斗模式：\
	在中立姿态下，我们只会把它们拖近；若我们尝试推搡，则会夺走它们活跃手中的持物而不是它们本人；\
	在战斗姿态下，抓住受害者后会将其纳入我们的掌控，若我们同时还持有锋利武器或拥有臂刃，则会将其拉近并刺穿。此效果可穿透护甲。\
	处于低等形态时无法使用。"
	button_icon_state = "tentacle"
	category = "combat"
	chemical_cost = 10
	dna_cost = 2
	req_human = TRUE
	weapon_type = /obj/item/gun/magic/tentacle
	weapon_name_simple = "触手"
	silent = TRUE

/obj/item/gun/magic/tentacle
	name = "触手"
	desc = "一条能伸出去抓取物品或人的肉质触手。"
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "tentacle"
	inhand_icon_state = "tentacle"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = NEEDS_PERMIT | ABSTRACT | DROPDEL | NOBLUDGEON
	flags_1 = NONE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = NONE
	antimagic_flags = NONE
	pinless = TRUE
	ammo_type = /obj/item/ammo_casing/magic/tentacle
	fire_sound = 'sound/effects/splat.ogg'
	force = 0
	max_charges = 1
	fire_delay = 1 DECISECONDS
	throwforce = 0 //Just to be on the safe side
	throw_range = 0
	throw_speed = 0
	can_hold_up = FALSE

/obj/item/gun/magic/tentacle/Initialize(mapload, silent)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		if(!silent)
			loc.visible_message(span_warning("[loc.name] 的手臂开始非人地伸长！"), span_warning("我们的手臂扭曲变异，变成了一条触手。"), span_hear("你听到有机物被撕开、扯碎的声音！"))
		else
			to_chat(loc, span_notice("你准备好伸出一条触手。"))


/obj/item/gun/magic/tentacle/shoot_with_empty_chamber(mob/living/user as mob|obj)
	user.balloon_alert(user, "还没准备好！")

/obj/item/gun/magic/tentacle/process_fire(atom/target, mob/living/user, message, params, zone_override, bonus_spread)
	var/obj/projectile/tentacle/tentacle_shot = chambered.loaded_projectile //Gets the actual projectile we will fire
	tentacle_shot.fire_modifiers = params2list(params)
	. = ..()
	if(charges == 0)
		qdel(src)

/obj/item/gun/magic/tentacle/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 把 [src] 紧紧缠在自己脖子上！看起来是想自杀！"))
	return OXYLOSS

/obj/item/ammo_casing/magic/tentacle
	name = "触手"
	desc = "一条触手。"
	projectile_type = /obj/projectile/tentacle
	caliber = CALIBER_TENTACLE
	firing_effect_type = null
	var/obj/item/gun/magic/tentacle/gun //the item that shot it

/obj/item/ammo_casing/magic/tentacle/Initialize(mapload)
	gun = loc
	. = ..()

/obj/item/ammo_casing/magic/tentacle/Destroy()
	gun = null
	return ..()

/obj/projectile/tentacle
	name = "触手"
	icon_state = "tentacle_end"
	pass_flags = PASSTABLE
	damage = 0
	damage_type = BRUTE
	range = 8
	hitsound = 'sound/items/weapons/shove.ogg'
	var/chain
	var/obj/item/ammo_casing/magic/tentacle/source //the item that shot it
	///Click params that were used to fire the tentacle shot
	var/list/fire_modifiers

/obj/projectile/tentacle/Initialize(mapload)
	source = loc
	. = ..()

/obj/projectile/tentacle/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "tentacle", emissive = NONE)
	..()

/obj/projectile/tentacle/proc/reset_throw(mob/living/carbon/human/user)
	if(user.throw_mode)
		user.throw_mode_off(THROW_MODE_TOGGLE) //Don't annoy the changeling if he doesn't catch the item

/obj/projectile/tentacle/proc/tentacle_grab(mob/living/carbon/human/user, mob/living/carbon/victim)
	if(!user.Adjacent(victim))
		return

	if(user.get_active_held_item() && !user.get_inactive_held_item())
		user.swap_hand()

	if(user.get_active_held_item())
		return

	victim.grabbedby(user)
	victim.grippedby(user, instant = TRUE) //instant aggro grab

	for(var/obj/item/weapon in user.held_items)
		if(weapon.get_sharpness())
			victim.visible_message(span_danger("[user] 用自己的[weapon.name]刺穿了[victim]！"), span_userdanger("[user] 用自己的[weapon.name]刺穿了你！"))
			victim.apply_damage(weapon.force, BRUTE, BODY_ZONE_CHEST, attacking_item = weapon)
			user.do_item_attack_animation(victim, used_item = weapon, animation_type = ATTACK_ANIMATION_PIERCE)
			user.add_blood_DNA_to_items(victim.get_blood_dna_list(), ITEM_SLOT_ICLOTHING|ITEM_SLOT_OCLOTHING)
			playsound(get_turf(user),weapon.hitsound,75,TRUE)
			return

/obj/projectile/tentacle/on_hit(atom/movable/target, blocked = 0, pierce_hit)
	if(!isliving(firer) || !ismovable(target))
		return ..()

	if(blocked >= 100)
		return BULLET_ACT_BLOCK

	var/mob/living/ling = firer
	if(isitem(target) && iscarbon(ling))
		var/obj/item/catching = target
		if(catching.anchored)
			return BULLET_ACT_BLOCK

		var/mob/living/carbon/carbon_ling = ling
		to_chat(carbon_ling, span_notice("你把 [catching] 拉向自己。"))
		carbon_ling.throw_mode_on(THROW_MODE_TOGGLE)
		catching.throw_at(
			target = carbon_ling,
			range = 10,
			speed = 2,
			thrower = carbon_ling,
			diagonals_first = TRUE,
			callback = CALLBACK(src, PROC_REF(reset_throw), carbon_ling),
			gentle = TRUE,
		)
		return BULLET_ACT_HIT

	. = ..()
	if(. != BULLET_ACT_HIT)
		return .
	var/mob/living/victim = target
	if(!isliving(victim) || target.anchored || victim.throwing)
		return BULLET_ACT_BLOCK

	if(!iscarbon(victim) || !ishuman(ling) || !ling.combat_mode)
		victim.visible_message(
			span_danger("[victim] 被 [ling] 的 [src] 抓住了！"),
			span_userdanger("一条 [src] 抓住了你，把你拖向 [ling]！"),
		)
		victim.throw_at(
			target = get_step_towards(ling, victim),
			range = 8,
			speed = 2,
			thrower = ling,
			diagonals_first = TRUE,
			gentle = TRUE,
		)
		return BULLET_ACT_HIT

	if(LAZYACCESS(fire_modifiers, RIGHT_CLICK))
		var/obj/item/stealing = victim.get_active_held_item()
		if(!isnull(stealing))
			if(victim.dropItemToGround(stealing))
				victim.visible_message(
					span_danger("[stealing] 被 [src] 从 [victim] 手中扯了下来！"),
					span_userdanger("一条 [src] 把 [stealing] 从你手中拽走了！"),
				)
				return on_hit(stealing) //grab the item as if you had hit it directly with the tentacle

			to_chat(ling, span_warning("你似乎没法把 [stealing] 从 [victim] 的手中撬下来！"))
			return BULLET_ACT_BLOCK

		to_chat(ling, span_danger("[victim] 手上没有可以缴械的东西！"))
		return BULLET_ACT_HIT

	if(ling.combat_mode)
		victim.visible_message(
			span_danger("[victim] 被一条 [src] 抛向 [ling]！"),
			span_userdanger("一条 [src] 抓住了你，把你抛向 [ling]！"),
		)
		victim.throw_at(
			target = get_step_towards(ling, victim),
			range  = 8,
			speed = 2,
			thrower = ling,
			diagonals_first = TRUE,
			callback = CALLBACK(src, PROC_REF(tentacle_grab), ling, victim),
			gentle = TRUE,
		)

	return BULLET_ACT_HIT

/obj/projectile/tentacle/Destroy()
	QDEL_NULL(chain)
	source = null
	return ..()


/***************************************\
|****************SHIELD*****************|
\***************************************/
/datum/action/changeling/weapon/shield
	name = "有机护盾"
	desc = "我们把一条手臂重组成一面坚硬的护盾。消耗 20 单位化学物质。"
	helptext = "有机组织无法永远承受伤害；护盾被击中太多次后会碎裂。我们吸收的基因组越多，它就越坚固。处于低等形态时无法使用。"
	button_icon_state = "organic_shield"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE

	weapon_type = /obj/item/shield/changeling
	weapon_name_simple = "护盾"

/datum/action/changeling/weapon/shield/sting_action(mob/user)
	var/datum/antagonist/changeling/changeling = IS_CHANGELING(user) //So we can read the absorbed_count.
	if(!changeling)
		return

	var/obj/item/shield/changeling/S = ..(user)
	S.remaining_uses = round(changeling.absorbed_count * 3)
	return TRUE

/obj/item/shield/changeling
	name = "盾状肉体"
	desc = "一团坚韧的骨质组织。你还能看到手指在盾面上扭成一团的痕迹。"
	item_flags = ABSTRACT | DROPDEL
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "ling_shield"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	block_chance = 50
	is_bashable = FALSE

	var/remaining_uses //Set by the changeling ability.

/obj/item/shield/changeling/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message(span_warning("[loc.name] 的手掌末端迅速膨胀，形成一团巨大的盾状肉体！"), span_warning("我们把手掌膨胀成一面坚固的护盾。"), span_hear("你听到有机物被撕开、扯碎的声音！"))

/obj/item/shield/changeling/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == OVERWHELMING_ATTACK)
		return FALSE

	if(remaining_uses < 1)
		if(ishuman(loc))
			var/mob/living/carbon/human/H = loc
			H.visible_message(span_warning("[H] 伴着一声令人作呕的脆响，把自己的护盾重新变回手臂！"), span_notice("我们把护盾同化回体内"), span_italics("你听到有机物被撕开、扯碎的声音！"))
		qdel(src)
		return 0
	else
		remaining_uses--
		return ..()

/***************************************\
|*****************ARMOR*****************|
\***************************************/
/datum/action/changeling/suit/armor
	name = "几丁质护甲"
	desc = "我们把皮肤变成坚硬的几丁质，以保护我们免受伤害。消耗 20 单位化学物质。"
	helptext = "维持护甲需要持续消耗少量化学物质。护甲能为抵御蛮力与能量武器提供不错的防护。处于低等形态时无法使用。"
	button_icon_state = "chitinous_armor"
	category = "combat"
	chemical_cost = 20
	dna_cost = 1
	req_human = TRUE
	recharge_slowdown = 0.125

	suit_type = /obj/item/clothing/suit/armor/changeling
	helmet_type = /obj/item/clothing/head/helmet/changeling
	suit_name_simple = "护甲"
	helmet_name_simple = "头盔"

/obj/item/clothing/suit/armor/changeling
	name = "几丁质肉体"
	desc = "一层坚韧、坚硬的黑色几丁质外壳。"
	icon_state = "lingarmor"
	inhand_icon_state = null
	item_flags = DROPDEL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_changeling
	flags_inv = HIDEJUMPSUIT
	cold_protection = 0
	heat_protection = 0

/datum/armor/armor_changeling
	melee = 40
	bullet = 40
	laser = 40
	energy = 50
	bomb = 10
	bio = 10
	fire = 90
	acid = 90

/obj/item/clothing/suit/armor/changeling/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)
	if(ismob(loc))
		loc.visible_message(span_warning("[loc.name] 的血肉变黑，迅速转变成坚硬的几丁质肉体！"), span_warning("我们硬化血肉，造出了一副护甲！"), span_hear("你听到有机物被撕开、扯碎的声音！"))

/obj/item/clothing/head/helmet/changeling
	name = "几丁质肉体"
	desc = "一层坚韧、坚硬的黑色几丁质外壳，正面是透明的几丁质。"
	icon_state = "lingarmorhelmet"
	inhand_icon_state = null
	item_flags = DROPDEL
	armor_type = /datum/armor/helmet_changeling
	flags_inv = HIDEEARS|HIDEHAIR|HIDEEYES|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT

/datum/armor/helmet_changeling
	melee = 40
	bullet = 40
	laser = 40
	energy = 50
	bomb = 10
	bio = 10
	fire = 90
	acid = 90

/obj/item/clothing/head/helmet/changeling/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)

/datum/action/changeling/suit/hive_head
	name = "蜂巢头"
	desc = "我们在头上覆盖一层类似蜂巢的蜡质外壳，可以用它培育蜜蜂来攻击敌人。消耗 15 单位化学物质。"
	helptext = "蜂巢头几乎提供不了什么护甲，但可以让使用者放出蜜蜂攻击目标。可以把试剂注入蜂巢，使放出的所有蜜蜂都携带这些试剂。"
	button_icon_state = "hive_head"
	category = "combat"
	chemical_cost = 15
	dna_cost = 2
	req_human = FALSE
	blood_on_castoff = TRUE

	helmet_type = /obj/item/clothing/head/helmet/changeling_hivehead
	helmet_name_simple = "蜂巢头"

/obj/item/clothing/head/helmet/changeling_hivehead
	name = "蜂巢头"
	desc = "一层覆盖你头部的奇怪蜡质外壳。会让你耳鸣。"
	icon_state = "hivehead"
	inhand_icon_state = null
	flash_protect = FLASH_PROTECTION_FLASH
	item_flags = DROPDEL
	armor_type = /datum/armor/changeling_hivehead
	flags_inv = HIDEEARS|HIDEHAIR|HIDEEYES|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT
	actions_types = list(/datum/action/cooldown/hivehead_spawn_minions)
	///Does this hive head hold reagents?
	var/holds_reagents = TRUE

/obj/item/clothing/head/helmet/changeling_hivehead/Initialize(mapload)
	. = ..()
	if(holds_reagents)
		create_reagents(50, REFILLABLE)

/datum/armor/changeling_hivehead
	melee = 10
	bullet = 10
	laser = 10
	energy = 10
	bio = 50

/obj/item/clothing/head/helmet/changeling_hivehead/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CHANGELING_TRAIT)

/obj/item/clothing/head/helmet/changeling_hivehead/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/organ/monster_core/regenerative_core/legion) || !holds_reagents)
		return NONE
	visible_message(span_boldwarning("当 [user] 把 [tool] 塞进 [src] 时，[src] 开始发生变异。"))
	var/mob/living/carbon/human/wearer = loc
	playsound(wearer, 'sound/effects/blob/attackblob.ogg', 60, TRUE)
	wearer.temporarilyRemoveItemFromInventory(src, TRUE)
	wearer.equip_to_slot_if_possible(new /obj/item/clothing/head/helmet/changeling_hivehead/legion(wearer), ITEM_SLOT_HEAD, 1, 1, 1)
	qdel(tool)
	return ITEM_INTERACT_SUCCESS

/datum/action/cooldown/hivehead_spawn_minions
	name = "释放蜜蜂"
	desc = "放出一群蜜蜂，攻击其他所有生命体。"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"
	button_icon = 'icons/mob/simple/bees.dmi'
	button_icon_state = "queen_item"
	cooldown_time = 30 SECONDS
	///The mob we're going to spawn
	var/spawn_type = /mob/living/basic/bee/timed/short
	///How many are we going to spawn
	var/spawn_count = 6

/datum/action/cooldown/hivehead_spawn_minions/PreActivate(atom/target)
	if(owner.movement_type & VENTCRAWLING)
		owner.balloon_alert(owner, "此处无法使用")
		return FALSE
	return ..()

/datum/action/cooldown/hivehead_spawn_minions/Activate(atom/target)
	. = ..()
	do_tell()
	var/spawns = spawn_count
	if(owner.stat >= HARD_CRIT)
		spawns = 1
	for(var/i in 1 to spawns)
		var/mob/living/basic/summoned_minion = new spawn_type(owner.drop_location())
		summoned_minion.set_allies(list("[REF(owner)]"))
		summoned_minion.set_faction(null)
		minion_additional_changes(summoned_minion)

///Our tell that we're using this ability. Usually a sound and a visible message.area
/datum/action/cooldown/hivehead_spawn_minions/proc/do_tell()
	owner.visible_message(span_warning("[owner] 的脑袋开始嗡嗡作响，蜜蜂纷纷涌出！"), span_warning("我们放出了蜜蜂。"), span_hear("你听到响亮的嗡嗡声！"))
	playsound(owner, 'sound/mobs/non-humanoids/bee/bee_swarm.ogg', 60, TRUE)

///Stuff we want to do to our minions. This is in its own proc so subtypes can override this behaviour.
/datum/action/cooldown/hivehead_spawn_minions/proc/minion_additional_changes(mob/living/basic/minion)
	var/mob/living/basic/bee/summoned_bee = minion
	var/obj/item/clothing/head/helmet/changeling_hivehead/hivehead = owner.get_item_by_slot(ITEM_SLOT_HEAD)
	if(istype(summoned_bee) && istype(hivehead) && length(hivehead.reagents.reagent_list))
		summoned_bee.assign_reagent(pick(hivehead.reagents.reagent_list))

/obj/item/clothing/head/helmet/changeling_hivehead/legion
	name = "军团蜂巢头"
	desc = "一层覆盖你头部的奇怪骨质外壳，内部是血肉。出奇地舒适。"
	icon_state = "hivehead_legion"
	actions_types = list(/datum/action/cooldown/hivehead_spawn_minions/legion)
	holds_reagents = FALSE

/datum/action/cooldown/hivehead_spawn_minions/legion
	name = "释放军团"
	desc = "放出一群军团成员，攻击其他所有生命体。"
	button_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	button_icon_state = "legion_head"
	cooldown_time = 15 SECONDS
	spawn_type = /mob/living/basic/mining/legion_brood
	spawn_count = 4

/datum/action/cooldown/hivehead_spawn_minions/legion/do_tell()
	owner.visible_message(span_warning("[owner] 的脑袋开始晃动，军团成员纷纷涌出！"), span_warning("我们放出了军团。"), span_hear("你听到响亮的挤压声！"))
	playsound(owner, 'sound/effects/blob/attackblob.ogg', 60, TRUE)

/datum/action/cooldown/hivehead_spawn_minions/legion/minion_additional_changes(mob/living/basic/minion)
	var/mob/living/basic/mining/legion_brood/brood = minion
	if (istype(brood))
		brood.assign_creator(owner, FALSE)
