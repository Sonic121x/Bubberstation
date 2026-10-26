#define BERSERK_MAX_CHARGE 100
#define PROJECTILE_HIT_MULTIPLIER 1.5
#define DAMAGE_TO_CHARGE_SCALE 1
#define CHARGE_DRAINED_PER_SECOND 3
#define BERSERK_MELEE_ARMOR_ADDED 50
#define BERSERK_ATTACK_SPEED_MODIFIER 0.25

/obj/item/crusher_trophy/gladiator
	name = "灰烬之骨"
	desc = "一套覆满烟灰的肋骨，来自一位值得尊敬的战士。适合用作动能粉碎器的战利品。"
	icon_state = "demon_claws"
	color = "#808080"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/gladiator
	bonus_value = 15

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "使动能粉碎器有 <b>[bonus_value]%</b> 的几率格挡来袭攻击。"

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance -= bonus_value

/obj/item/clothing/neck/warrior_cape
	name = "被标记者的斗篷"
	desc = "那些曾与死亡对视、并最终胜出的人所穿的斗篷。"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	icon_state = "berk_cape"
	inhand_icon_state = "" //lul
	resistance_flags = INDESTRUCTIBLE

/obj/item/clothing/neck/warrior_cape/loadout //Subtype for loadout item so i can make it not "indestructible"
	name = "破烂斗篷"
	desc = "一件曾属于某个令人畏惧的敌人的斗篷，如今由那些与死亡对视并胜出的人穿着；它看上去相当破旧，已不复当年光洁如新的模样。"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/warrior_cape/examine()
	. = ..()
	. += span_warning("与浪潮抗争吧，无论它多么强大。")

/obj/item/clothing/suit/hooded/berserker/gatsu
	name = "狂战士护甲"
	desc = "一套注入了强大灵性磁力的古代躯体护甲，能大幅提升穿戴者的近战能力，代价是摧残其心智并让身体过度透支。"
	icon_state = "berk_suit"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	worn_icon_digi = 'modular_skyrat/modules/gladiator/icons/berserk_suit_digi.dmi'
	hoodtype = /obj/item/clothing/head/hooded/berserker/gatsu
	w_class = WEIGHT_CLASS_BULKY
	armor_type = /datum/armor/berserker_gatsu
	resistance_flags = INDESTRUCTIBLE

/datum/armor/berserker_gatsu
	melee = 30
	bullet = 30
	laser = 10
	energy = 20
	bomb = 50
	bio = 60
	fire = 100
	acid = 100
	wound = 10

/obj/item/clothing/suit/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("狂暴模式需要装备这套护甲的头盔，且只能通过承受伤害来充能。")

/obj/item/clothing/head/hooded/berserker/gatsu
	name = "狂战士头盔"
	desc = "一顶造型独特、长着骇人红眼的头盔，会把使用者封在其中。"
	icon_state = "berk_helm"
	icon = 'modular_skyrat/modules/gladiator/icons/berserk_icons.dmi'
	worn_icon = 'modular_skyrat/modules/gladiator/icons/berserk_suit.dmi'
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor_type = /datum/armor/berserker_gatsu
	resistance_flags = INDESTRUCTIBLE
	actions_types = list(/datum/action/item_action/berserk_mode)

/obj/item/clothing/head/hooded/berserker/gatsu/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, LOCKED_HELMET_TRAIT)

/obj/item/clothing/head/hooded/berserker/gatsu/examine()
	. = ..()
	. += span_warning("狂暴模式在充能 100% 时可用，并且需要保持头盔闭合才能持续生效。") //woag!!!

/obj/item/clothing/head/hooded/berserker/gatsu/process(seconds_per_tick)
	if(berserk_active)
		berserk_charge = clamp(berserk_charge - CHARGE_DRAINED_PER_SECOND * seconds_per_tick, 0, BERSERK_MAX_CHARGE)
	if(!berserk_charge)
		if(ishuman(loc))
			end_berserk(loc)

/obj/item/clothing/head/hooded/berserker/gatsu/dropped(mob/user)
	. = ..()
	end_berserk(user)

/obj/item/clothing/head/hooded/berserker/gatsu/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(berserk_active)
		return
	var/berserk_value = damage * DAMAGE_TO_CHARGE_SCALE
	if(attack_type == PROJECTILE_ATTACK)
		berserk_value *= PROJECTILE_HIT_MULTIPLIER
	berserk_charge = clamp(round(berserk_charge + berserk_value), 0, BERSERK_MAX_CHARGE)
	if(berserk_charge >= BERSERK_MAX_CHARGE)
		balloon_alert(owner, "狂暴已充能")

/obj/item/clothing/head/hooded/berserker/gatsu/IsReflect()
	if(berserk_active)
		return TRUE

/obj/item/claymore/dragonslayer
	name = "\proper 屠龙者"
	desc = "一把大到几乎称不上是剑的刀刃。太大、太厚、太重、也太粗糙，更像是一大块生铁。"
	icon = 'modular_skyrat/modules/gladiator/icons/dragonslayer.dmi'
	icon_state = "dragonslayer"
	inhand_icon_state = "dragonslayer"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/64x64_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	force = 20
	wound_bonus = 10
	exposed_wound_bonus = 5
	resistance_flags = INDESTRUCTIBLE
	armour_penetration = 35 //this boss is really hard and this sword is really big
	block_chance = 25
	sharpness = SHARP_EDGED
	item_flags = NO_BLOOD_ON_ITEM
	// aughhghghgh this really should be elementized but this works for now
	var/faction_bonus_force = 40
	var/static/list/nemesis_factions = list("mining", "boss")
	/// how much stamina does it cost to roll
	var/roll_stamcost = 10
	/// how far do we roll?
	var/roll_range = 3
	var/roll_delay = 2 SECONDS
	// prevents you from becoming a bayblade
	COOLDOWN_DECLARE(dodgeroll_cooldown)

/obj/item/claymore/dragonslayer/examine()
	. = ..()
	. += span_warning("经超自然能量淬炼，专克熔岩地带的敌人与首领。右键消耗耐力进行闪避。")

/obj/item/claymore/dragonslayer/attack(mob/living/target, mob/living/carbon/human/user)
	var/is_nemesis_faction = FALSE
	for(var/found_faction in target.get_faction())
		if(found_faction in nemesis_factions)
			is_nemesis_faction = TRUE
			force += faction_bonus_force
			break
	. = ..()
	if(is_nemesis_faction)
		force -= faction_bonus_force

/obj/item/claymore/dragonslayer/ranged_interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	if(user.IsImmobilized() || !COOLDOWN_FINISHED(src, dodgeroll_cooldown)) // can't dodge
		return NONE
	var/turf/where_to = get_turf(interacting_with)
	COOLDOWN_START(src, dodgeroll_cooldown, roll_delay)
	user.apply_damage(damage = roll_stamcost, damagetype = STAMINA)
	user.Immobilize(0.1 SECONDS) // you dont get to adjust your roll
	user.throw_at(where_to, range = roll_range, speed = 1, force = MOVE_FORCE_NORMAL)
	user.apply_status_effect(/datum/status_effect/dodgeroll_iframes)
	playsound(user, SFX_BODYFALL, 50, TRUE)
	playsound(user, SFX_RUSTLE, 50, TRUE)
	return ITEM_INTERACT_SUCCESS

/datum/status_effect/dodgeroll_iframes
	id = "dodgeroll_dodging"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 1 SECONDS // worth tweaking?

/datum/status_effect/dodgeroll_iframes/on_apply()
	RegisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(whiff))
	return TRUE

/datum/status_effect/dodgeroll_iframes/on_remove()
	UnregisterSignal(owner, COMSIG_LIVING_CHECK_BLOCK)
	return ..()

/datum/status_effect/dodgeroll_iframes/proc/whiff()
	SIGNAL_HANDLER
	owner.balloon_alert_to_viewers("未命中！")
	playsound(src, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
	return SUCCESSFUL_BLOCK

/obj/item/claymore/dragonslayer/very_fucking_loud
	name = "\proper 淬炼屠龙者"
	desc = null
	hitsound = 'modular_skyrat/modules/gladiator/Clang_cut.ogg'

/obj/item/claymore/dragonslayer/very_fucking_loud/examine()
	. = ..()
	. += span_userdanger("铛！")

/obj/structure/closet/crate/necropolis/gladiator
	name = "角斗士宝箱"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "骇人角斗士宝箱"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	if(prob(5))
		new /obj/item/claymore/dragonslayer/very_fucking_loud(src)
	else
		new /obj/item/claymore/dragonslayer(src)
	new /obj/item/clothing/suit/hooded/berserker/gatsu(src)
	new /obj/item/clothing/neck/warrior_cape(src)
	new /obj/item/crusher_trophy/gladiator(src)

#undef BERSERK_MAX_CHARGE
#undef PROJECTILE_HIT_MULTIPLIER
#undef DAMAGE_TO_CHARGE_SCALE
#undef CHARGE_DRAINED_PER_SECOND
#undef BERSERK_MELEE_ARMOR_ADDED
#undef BERSERK_ATTACK_SPEED_MODIFIER
