// Deprecated, you do not need to use this type for melee weapons.
/obj/item/melee
	abstract_type = /obj/item/melee
	item_flags = NEEDS_PERMIT

/obj/item/melee/synthetic_arm_blade
	name = "合成臂刃"
	desc = "一把怪诞的刀刃，仔细看似乎是由合成血肉制成的，但作为武器，感觉依然能造成极其严重的伤害。"
	icon = 'icons/obj/weapons/changeling_items.dmi'
	icon_state = "arm_blade"
	inhand_icon_state = "arm_blade"
	icon_angle = 180
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 10
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击", "劈砍", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")
	attack_verb_simple = list("攻击", "劈砍", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")
	sharpness = SHARP_EDGED
	var/list/alt_continuous = list("刺", "穿刺", "贯穿")
	var/list/alt_simple = list("刺", "穿刺", "贯穿")

/obj/item/melee/synthetic_arm_blade/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	)
	//very imprecise

/obj/item/melee/beesword
	name = "毒刺"
	desc = "取自一只巨型蜜蜂，并在纯蜂蜜中折叠了一千次。能刺穿任何东西。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "beesword"
	inhand_icon_state = "stinger"
	worn_icon_state = "stinger"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	throwforce = 10
	attack_speed = CLICK_CD_RAPID
	block_chance = 20
	armour_penetration = 65
	attack_verb_continuous = list("劈砍", "蜇刺", "扎", "戳")
	attack_verb_simple = list("劈砍", "蜇刺", "扎", "戳")
	hitsound = 'sound/items/weapons/rapierhit.ogg'
	block_sound = 'sound/items/weapons/parry.ogg'

/obj/item/melee/beesword/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight, and also you aren't going to really block someone full body tackling you with a sword. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/melee/beesword/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(iscarbon(target) && !QDELETED(target))
		var/mob/living/carbon/carbon_target = target
		carbon_target.reagents.add_reagent(/datum/reagent/toxin, 4)

/obj/item/melee/beesword/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]刺自己的喉咙！看来是想自杀！"))
	playsound(get_turf(src), hitsound, 75, TRUE, -1)
	return TOXLOSS

/obj/item/melee/curator_whip
	name = "馆长之鞭"
	desc = "风格有些古怪、也有些过时，但被它抽到依然疼得要命。"
	icon = 'icons/obj/weapons/whip.dmi'
	icon_state = "whip"
	inhand_icon_state = "chain"
	icon_angle = -90
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	worn_icon_state = "whip"
	slot_flags = ITEM_SLOT_BELT
	force = 15
	demolition_mod = 0.25
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("抽打", "鞭打", "鞭笞", "惩戒")
	attack_verb_simple = list("抽打", "鞭打", "鞭笞", "惩戒")
	hitsound = 'sound/items/weapons/whip.ogg'

/obj/item/melee/curator_whip/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		human_target.drop_all_held_items()
		human_target.visible_message(span_danger("[user]卸下了[human_target]的武器！"), span_userdanger("[user]卸下了你的武器！"))

/obj/item/melee/roastingstick
	name = "高级烤棒"
	desc = "一根可伸缩的烤棒，配有微型护盾发生器，专为进入各种高科技屏蔽烤箱和火坑而设计。"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "roastingstick"
	inhand_icon_state = null
	worn_icon_state = "tele_baton"
	icon_angle = -45
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	attack_verb_continuous = list("敲", "戳")
	attack_verb_simple = list("敲", "戳")
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 2.5)
	/// The sausage attatched to our stick.
	var/obj/item/food/sausage/held_sausage
	/// Static list of things our roasting stick can interact with.
	var/static/list/ovens
	/// The beam that links to the oven we use
	var/datum/beam/beam

/obj/item/melee/roastingstick/Initialize(mapload)
	. = ..()
	if (!ovens)
		ovens = typecacheof(list(/obj/singularity, /obj/energy_ball, /obj/machinery/power/supermatter_crystal, /obj/structure/bonfire))
	AddComponent( \
		/datum/component/transforming, \
		hitsound_on = hitsound, \
		clumsy_check = FALSE, \
		inhand_icon_change = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_PRE_TRANSFORM, PROC_REF(attempt_transform))
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_PRE_TRANSFORM].
 *
 * If there is a sausage attached, returns COMPONENT_BLOCK_TRANSFORM.
 */
/obj/item/melee/roastingstick/proc/attempt_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(held_sausage)
		to_chat(user, span_warning("在[held_sausage]还挂着的时候，你没法收回[src]！"))
		return COMPONENT_BLOCK_TRANSFORM

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives feedback on stick extension.
 */
/obj/item/melee/roastingstick/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	inhand_icon_state = active ? "nullrod" : null
	if(user)
		balloon_alert(user, "[active ? "已展开" : "已收起"] [src]")
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/melee/roastingstick/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if (!istype(tool, /obj/item/food/sausage))
		return NONE

	if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		to_chat(user, span_warning("你必须先展开[src]才能往上挂东西！"))
		return ITEM_INTERACT_BLOCKING

	if (held_sausage)
		to_chat(user, span_warning("[held_sausage]已经挂在[src]上了！"))
		return ITEM_INTERACT_BLOCKING

	if (!user.transferItemToLoc(tool, src))
		to_chat(user, span_warning("[tool]似乎不太想被挂到[src]上！"))
		return ITEM_INTERACT_BLOCKING

	held_sausage = tool
	update_appearance()
	return ITEM_INTERACT_SKIP_TO_ATTACK

/obj/item/melee/roastingstick/attack_hand(mob/user, list/modifiers)
	..()
	if (held_sausage)
		user.put_in_hands(held_sausage)

/obj/item/melee/roastingstick/update_overlays()
	. = ..()
	if(held_sausage)
		. += mutable_appearance(icon, "roastingstick_sausage")

/obj/item/melee/roastingstick/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == held_sausage)
		held_sausage = null
		update_appearance()

/obj/item/melee/roastingstick/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return NONE
	if (!is_type_in_typecache(interacting_with, ovens))
		return NONE
	if (istype(interacting_with, /obj/singularity) || istype(interacting_with, /obj/energy_ball) && get_dist(user, interacting_with) < 10)
		to_chat(user, span_notice("你把[held_sausage]朝[interacting_with]伸了过去。"))
		playsound(src, 'sound/items/tools/rped.ogg', 50, TRUE)
		beam = user.Beam(interacting_with, icon_state = "rped_upgrade", time = 10 SECONDS)
		finish_roasting(user, interacting_with)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/melee/roastingstick/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if (!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return NONE
	if (!is_type_in_typecache(interacting_with, ovens))
		return NONE
	to_chat(user, span_notice("你把[src]朝[interacting_with]伸了过去。"))
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	finish_roasting(user, interacting_with)
	return ITEM_INTERACT_SUCCESS

/obj/item/melee/roastingstick/proc/finish_roasting(user, atom/target)
	if(do_after(user, 10 SECONDS, target = user))
		to_chat(user, span_notice("你把[held_sausage]烤好了。"))
		playsound(src, 'sound/items/tools/welder2.ogg', 50, TRUE)
		held_sausage.add_atom_colour(rgb(103, 63, 24), FIXED_COLOUR_PRIORITY)
		held_sausage.name = "[target.name]烤[held_sausage.name]"
		held_sausage.desc = "[held_sausage.desc]它在[target]上被烤得恰到好处。"
		update_appearance()
	else
		QDEL_NULL(beam)
		playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
		to_chat(user, span_notice("你把[src]收了起来。"))

/obj/item/melee/cleric_mace
	name = "教士钉锤"
	desc = "它是棍棒的孙子，却是棒球棒的爷爷。过去多为圣职教团所用。"
	icon = 'icons/map_icons/items/_item.dmi'
	icon_state = "/obj/item/melee/cleric_mace"
	post_init_icon_state = "default"
	inhand_icon_state = "default"
	worn_icon_state = "default_worn"
	icon_angle = -45

	greyscale_config = /datum/greyscale_config/cleric_mace
	greyscale_config_inhand_left = /datum/greyscale_config/cleric_mace_lefthand
	greyscale_config_inhand_right = /datum/greyscale_config/cleric_mace_righthand
	greyscale_config_worn = /datum/greyscale_config/cleric_mace
	greyscale_colors = COLOR_WHITE + COLOR_BROWN

	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_AFFECT_STATISTICS
	// Defaults to an iron head, wooden handle mace
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.5, /datum/material/wood = SHEET_MATERIAL_AMOUNT * 1.5)
	material_slots = list(/datum/material_slot/weapon_head/mace = /datum/material/iron, /datum/material_slot/handle = /datum/material/wood)
	slot_flags = ITEM_SLOT_BELT
	force = 16
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 8
	block_chance = 10
	block_sound = 'sound/items/weapons/genhit.ogg'
	armour_penetration = 50
	attack_verb_continuous = list("猛击", "打击", "砸裂", "重打")
	attack_verb_simple = list("猛击", "打击", "砸裂", "重打")

// It only inherits the name of the main material it's made of. The secondary is in the description.
/obj/item/melee/cleric_mace/get_material_prefixes(list/materials)
	var/datum/material/material = get_material_from_slot(/datum/material_slot/weapon_head)
	return material?.name

/obj/item/melee/cleric_mace/finalize_material_effects(list/materials)
	. = ..()
	var/datum/material/material = get_material_from_slot(/datum/material_slot/handle)
	if (material)
		desc = "[initial(desc)]它的握柄由[material.name]制成。"

/obj/item/melee/cleric_mace/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	// Don't bring a...mace to a gunfight, and also you aren't going to really block someone full body tackling you with a mace.
	// Or a road roller, if one happened to hit you.
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0
	return ..()

/datum/material_slot/weapon_head/mace
	name = "锤头"
	material_amount = 3

/obj/item/sord
	name = "\improper SORD"
	desc = "这东西烂得无法形容，你连拿稳它都很困难。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "sord"
	inhand_icon_state = "sord"
	icon_angle = -35
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 2
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击", "劈砍", "刺", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")
	attack_verb_simple = list("攻击", "劈砍", "刺", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")

/obj/item/sord/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正试图用[src]刺穿自己！要不是它太烂，这大概就是自杀了。"), \
	span_suicide("你试图用[src]刺穿自己，但根本没用……"))
	return SHAME

/obj/item/carpenter_hammer
	name = "木匠锤"
	icon = 'icons/obj/weapons/hammer.dmi'
	icon_state = "carpenter_hammer"
	inhand_icon_state = "carpenter_hammer"
	worn_icon_state = "clawhammer" //plaecholder
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	desc = "看着有点诡异的锤子。"
	force = 17
	throwforce = 14
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 20
	demolition_mod = 1.15
	slot_flags = ITEM_SLOT_BELT

/obj/item/carpenter_hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)
	AddComponent(/datum/component/item_killsound, \
	allowed_mobs = list(/mob/living/carbon/human), \
	killsound = 'sound/items/weapons/hammer_death_scream.ogg', \
	replace_default_death_sound = TRUE, \
	)

/obj/item/carpenter_hammer/examine(mob/user)
	. = ..()
	. += ""
	. += "现实世界小贴士："
	. += pick(
		"从医院到住宅，每栋建筑都有一个充当心脏的房间，把血液和养分输送到各个末端。\
		试着找出你家的心脏吧！",
		"你吃过的所有食物都是腐烂的。你从没吃过新鲜的食物。",
		"病毒并不存在。生病只是你的身体在惩罚你做过的错事。",
		"出于结构安全考虑，空间站北墙内必须嵌入至少 50 颗哺乳动物的牙齿。",
		"蜻蜓女王沉睡着，微笑着。",
	)

/obj/item/phone
	name = "红色电话"
	desc = "万一出了什么岔子……"
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("拨打", "震响")
	attack_verb_simple = list("拨打", "震响")
	hitsound = 'sound/items/weapons/ring.ogg'

/obj/item/phone/suicide_act(mob/living/user)
	if(locate(/obj/structure/chair/stool) in user.loc)
		user.visible_message(span_suicide("[user]开始用[src]的电线上吊！看来是想自杀！"))
	else
		user.visible_message(span_suicide("[user]正用[src]的线缆勒住自己的脖子！看来是想自杀！"))
	return OXYLOSS

/obj/item/bambostaff
	name = "竹棍"
	desc = "一根长竹制成的棍棒，两端包着钢。据说蜘蛛氏族的新人在学习使用武士刀之前，会先用这种棍棒训练。"
	force = 10
	block_chance = 45
	block_sound = 'sound/items/weapons/genhit.ogg'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("猛砸", "重击", "敲打", "猛敲")
	attack_verb_simple = list("猛砸", "重击", "敲打", "猛敲")
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "bambostaff0"
	base_icon_state = "bambostaff"
	inhand_icon_state = "bambostaff0"
	worn_icon_state = "bambostaff0"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	custom_materials = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT * 4)

/obj/item/bambostaff/Initialize(mapload)
	. = ..()
	// there are too many puns to choose from. ('Bo' is the 'real' name for this kind of weapon.)
	name = pick("竹棍", "竹棒", "竹竿", "竹杖", "长竹棍", "竹节棍", "竹子棍", "青竹棍", "竹条")
	AddComponent(/datum/component/two_handed, \
		force_unwielded = 10, \
		force_wielded = 14, \
	)
	AddComponent(/datum/component/walking_aid)

/obj/item/bambostaff/update_icon_state()
	icon_state = inhand_icon_state = "[base_icon_state][HAS_TRAIT(src, TRAIT_WIELDED)]"
	return ..()

/obj/item/bambostaff/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "这次攻击", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(attack_type == PROJECTILE_ATTACK || attack_type == LEAP_ATTACK || attack_type == OVERWHELMING_ATTACK)
		final_block_chance = 0 //Don't bring a staff to a gunfight, and also you aren't going to really block someone full body tackling you with a staff. Or a road roller, if one happened to hit you.
	return ..()

/obj/item/staff
	name = "巫师法杖"
	desc = "显然是巫师使用的法杖。"
	icon = 'icons/obj/weapons/guns/magic.dmi'
	icon_state = "staff"
	inhand_icon_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 100
	attack_verb_continuous = list("重捶", "敲打", "惩戒")
	attack_verb_simple = list("重捶", "敲打", "惩戒")
	resistance_flags = FLAMMABLE

/obj/item/staff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/walking_aid)

/obj/item/staff/broom
	name = "扫帚"
	desc = "用来扫地，也用来在夜里咯咯笑着飞向夜空。不含黑猫。"
	icon_state = "broom"
	inhand_icon_state = "broom"
	resistance_flags = FLAMMABLE

/obj/item/staff/tape
	name = "胶带法杖"
	desc = "一卷牢牢粘在棍子上的胶带。"
	icon_state = "tapestaff"
	inhand_icon_state = "tapestaff"
	resistance_flags = FLAMMABLE

/obj/item/staff/stick
	name = "棍子"
	desc = "把别人的饮料顺着吧台拖走的好工具。"
	icon = 'icons/obj/weapons/staff.dmi'
	icon_state = "cane"
	inhand_icon_state = "stick"
	icon_angle = 135
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/tailclub
	name = "尾锤"
	desc = "用来用蜥蜴自己的尾巴把它们打死。"
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "tailclub"
	icon_angle = -25
	force = 14
	throwforce = 1 // why are you throwing a club do you even weapon
	throw_speed = 1
	throw_range = 1
	attack_verb_continuous = list("锤击", "重捶")
	attack_verb_simple = list("锤击", "重捶")
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)

/obj/item/melee/flyswatter
	name = "苍蝇拍"
	desc = "用来消灭各种尺寸的害虫。"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "flyswatter"
	inhand_icon_state = "flyswatter"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	throwforce = 1
	attack_verb_continuous = list("拍打", "猛拍")
	attack_verb_simple = list("拍打", "猛拍")
	hitsound = 'sound/effects/snap.ogg'
	w_class = WEIGHT_CLASS_SMALL
	/// Things in this list will be instantly splatted.  Flyman weakness is handled in the flyman species weakness proc.
	var/static/list/splattable

/obj/item/melee/flyswatter/Initialize(mapload)
	. = ..()
	if (isnull(splattable))
		splattable = typecacheof(list(
			/mob/living/basic/ant,
			/mob/living/basic/butterfly,
			/mob/living/basic/cockroach,
			/mob/living/basic/cockroach/bloodroach,
			/mob/living/basic/spider/growing/spiderling,
			/mob/living/basic/bee,
			/obj/effect/decal/cleanable/ants,
			/obj/item/queen_bee,
		))
	AddComponent(/datum/component/bane, affected_biotypes = MOB_BUG, pre_bane_callback = CALLBACK(src, PROC_REF(bane_check)) )

// Different type of bug mobs get different amounts of damage multipliers
/obj/item/melee/flyswatter/proc/bane_check(mob/living/target, mob/living/attacker, list/attack_modifiers)
	if(isanimal_or_basicmob(target))
		MODIFY_ATTACK_FORCE(attack_modifiers, 24)
	else if(isflyperson(target))
		MODIFY_ATTACK_FORCE(attack_modifiers, 29)
	else if(ismoth(target))
		MODIFY_ATTACK_FORCE(attack_modifiers, 9)
	else // ?? Whatever
		MODIFY_ATTACK_FORCE(attack_modifiers, 14)

/obj/item/melee/flyswatter/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(is_type_in_typecache(target, splattable))
		to_chat(user, span_warning("你轻松地把[target]拍扁了。"))
		if(QDELETED(target))
			return
		if(isliving(target))
			new /obj/effect/decal/cleanable/insectguts(target.drop_location())
			var/mob/living/bug = target
			bug.investigate_log("has been splatted by a flyswatter.", INVESTIGATE_DEATHS)
			bug.gib(DROP_ALL_REMAINS)
		else
			qdel(target)

/obj/item/proc/can_trigger_gun(mob/living/user, akimbo_usage)
	if(!user.can_use_guns(src))
		return FALSE
	return TRUE

/obj/item/gohei
	name = "御币"
	desc = "一根末端系着白色纸垂的木棍。原本是巫女用来净化的法器，如今被站上那些宝贝的二次元爱好者所用。"
	resistance_flags = FLAMMABLE
	force = 5
	throwforce = 5
	hitsound = SFX_SWING_HIT
	attack_verb_continuous = list("敲打", "猛敲", "猛击", "重捶")
	attack_verb_simple = list("敲打", "猛敲", "猛击", "重捶")
	icon = 'icons/obj/weapons/club.dmi'
	icon_state = "gohei"
	inhand_icon_state = "gohei"
	icon_angle = -65
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'

/obj/item/melee/moonlight_greatsword
	name = "月光大剑"
	desc = "不过，别告诉别人你往敏捷上加过点。"
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "swordon"
	inhand_icon_state = "swordon"
	worn_icon_state = "swordon"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_chance = 20
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	force = 14
	throwforce = 12
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	attack_verb_continuous = list("攻击", "劈砍", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")
	attack_verb_simple = list("攻击", "劈砍", "切削", "撕裂", "割裂", "撕扯", "切碎", "砍")
	var/list/alt_continuous = list("刺", "穿刺", "贯穿")
	var/list/alt_simple = list("刺", "穿刺", "贯穿")

/obj/item/melee/moonlight_greatsword/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)
