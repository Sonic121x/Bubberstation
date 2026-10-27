/obj/item/wrench
	name = "扳手"
	desc = "一把用途普通的扳手。通常就握在你手里。"
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench"
	inhand_icon_state = "wrench"
	worn_icon_state = "wrench"
	icon_angle = -135
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	obj_flags = CONDUCTS_ELECTRICITY
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 7
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_SMALL
	usesound = 'sound/items/tools/ratchet.ogg'
	operating_sound = list('sound/items/tools/ratchet_fast.ogg', 'sound/items/tools/ratchet_slow.ogg')
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*1.5)
	drop_sound = 'sound/items/handling/tools/wrench_drop.ogg'
	pickup_sound = 'sound/items/handling/tools/wrench_pickup.ogg'

	attack_verb_continuous = list("猛砸", "重击", "痛打", "狠敲")
	attack_verb_simple = list("猛砸", "重击", "痛打", "狠敲")
	tool_behaviour = TOOL_WRENCH
	toolspeed = 1
	armor_type = /datum/armor/item_wrench

/datum/armor/item_wrench
	fire = 50
	acid = 30

/obj/item/wrench/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/falling_hazard, damage = force, wound_bonus = wound_bonus, hardhat_safety = TRUE, crushes = FALSE, impact_sound = hitsound)

/obj/item/wrench/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正用[src]把自己往死里砸！看起来是想自杀！"))
	playsound(loc, 'sound/items/weapons/genhit.ogg', 50, TRUE, -1)
	return BRUTELOSS

/obj/item/wrench/abductor
	name = "外星扳手"
	desc = "一把极化的扳手。它能让放在钳口之间的任何东西旋转起来。"
	icon = 'icons/obj/antags/abductor.dmi'
	inside_belt_icon_state = "wrench_alien"
	icon_angle = -135
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/silver = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SHEET_MATERIAL_AMOUNT)
	usesound = 'sound/effects/empulse.ogg'
	toolspeed = 0.1


/obj/item/wrench/medical
	name = "医疗扳手"
	desc = "一把具有常见（医疗？）用途的医疗扳手。通常就握在你手里。"
	icon_state = "wrench_medical"
	inhand_icon_state = "wrench_medical"
	force = 2 //MEDICAL
	throwforce = 4
	attack_verb_continuous = list("治疗", "医疗处理", "轻拍", "戳刺", "分析") //"cobbyed"
	attack_verb_simple = list("治疗", "医疗处理", "轻拍", "戳刺", "分析")
	///var to hold the name of the person who suicided
	var/suicider

/obj/item/wrench/medical/examine(mob/user)
	. = ..()
	if(suicider)
		. += span_notice("不知为何，它让你想起了[suicider]。")

/obj/item/wrench/medical/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]正向医疗扳手祈祷，求它取走自己的灵魂。看起来是想自杀！"))
	user.Stun(100, ignore_canstun = TRUE)// Stun stops them from wandering off
	user.set_light_color(COLOR_VERY_SOFT_YELLOW)
	user.set_light(2)
	user.add_overlay(mutable_appearance('icons/mob/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER))
	playsound(loc, 'sound/effects/pray.ogg', 50, TRUE, -1)

	// Let the sound effect finish playing
	add_fingerprint(user)
	sleep(2 SECONDS)
	if(!user)
		return
	for(var/obj/item/suicide_wrench in user)
		user.dropItemToGround(suicide_wrench)
	suicider = user.real_name
	user.dust()
	return OXYLOSS

/obj/item/wrench/cyborg
	name = "液压扳手"
	desc = "一把先进的机械扳手，由内置液压驱动。速度是手持版本的两倍。"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "toolkit_engiborg_wrench"
	icon_angle = 0
	toolspeed = 0.5

/obj/item/wrench/combat
	name = "战斗扳手"
	desc = "就像一把普通扳手，但更硬核。常出现于战场上。"
	icon_state = "wrench_combat"
	inhand_icon_state = "wrench_combat"
	inside_belt_icon_state = "wrench_combat"
	icon_angle = -90
	attack_verb_continuous = list("毁灭", "残暴打击", "对……施以战争罪行", "抹除", "羞辱")
	attack_verb_simple = list("毁灭", "残暴打击", "对……施以战争罪行", "抹除", "羞辱")
	tool_behaviour = null

/obj/item/wrench/combat/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 6, \
		throwforce_on = 8, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Gives it wrench behaviors when active.
 */
/obj/item/wrench/combat/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = active ? TOOL_WRENCH : initial(tool_behaviour)
	if(user)
		balloon_alert(user, "[name][active ? "已展开，悲哉！":"已收束"]")
	playsound(src, active ? 'sound/items/weapons/saberon.ogg' : 'sound/items/weapons/saberoff.ogg', 5, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/wrench/bolter
	name = "闩锁扳手"
	desc = "一种专为抓住气闸闩锁系统而设计的扳手，无论气闸供电状态如何都能将其升起。"
	icon_state = "bolter_wrench"
	inhand_icon_state = "bolter_wrench"
	icon_angle = -90
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT)
