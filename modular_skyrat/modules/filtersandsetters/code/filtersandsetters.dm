#define TOOL_ALIEN_BONESET "alien bonesetter"

/obj/item/bonesetter/alien
	name = "异形接骨器"
	desc = "一件逆向工程仿制的接骨器……<b>从接受端来看可不太妙……</b>"
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	icon_state = "bonesetter"
	toolspeed = 0.25

/obj/item/bonesetter/alien/get_all_tool_behaviours()
	return list(TOOL_BONESET, TOOL_ALIEN_BONESET)

/datum/wound/item_can_treat(obj/item/potential_treater, mob/user)
	. = ..()
	// check if we have a valid treatable tool
	for(var/behaviour in potential_treater.get_all_tool_behaviours())
		if(behaviour in treatable_tools)
			return TRUE

/datum/wound/blunt/bone/severe
	treatable_tools = list(TOOL_ALIEN_BONESET)

/datum/wound/blunt/bone/severe/treat(obj/item/I, mob/user)
	if(!(TOOL_ALIEN_BONESET in I.get_all_tool_behaviours()))
		return ..()

	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] 开始[scanned ? "娴熟地" : ""]用 [I] 复位 [victim.p_their()] 的[limb.plaintext_zone]。"), span_warning("你开始用 [I] 复位自己的[limb.plaintext_zone][scanned ? "，同时留意全息影像的指示" : ""]……"))
	else
		user.visible_message(span_danger("[user] 开始[scanned ? "娴熟地" : ""]用 [I] 复位 [victim] 的[limb.plaintext_zone]。"), span_notice("你开始用 [I] 复位 [victim] 的[limb.plaintext_zone][scanned ? "，同时留意全息影像的指示" : ""]……"))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		limb.receive_damage(brute=25, wound_bonus=CANT_WOUND)
		victim.visible_message(span_danger("[user] 伴随着令人不适的<b>咔嚓</b>声，完成了 [victim.p_their()] [limb.plaintext_zone] 的复位！"), span_userdanger("你伴随着令人不适的<b>咔嚓</b>声，把自己的[limb.plaintext_zone]复位了！"))
	else
		limb.receive_damage(brute=20, wound_bonus=CANT_WOUND)
		user.visible_message(span_danger("[user] 伴随着令人不适的<b>咔嚓</b>声，完成了 [victim] 的[limb.plaintext_zone] 复位！"), span_nicegreen("你伴随着令人不适的<b>咔嚓</b>声，完成了 [victim] 的[limb.plaintext_zone] 复位！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] 伴随着令人不适的<b>咔嚓</b>声，把你的[limb.plaintext_zone]复位了！"))

	victim.emote("scream")
	playsound(user, 'sound/effects/wounds/crack1.ogg', 70, TRUE)
	qdel(src)

/datum/wound/blunt/bone/critical
	treatable_tools = list(TOOL_ALIEN_BONESET)

/datum/wound/blunt/bone/critical/treat(obj/item/I, mob/user)
	if(!(TOOL_ALIEN_BONESET in I.get_all_tool_behaviours()))
		return ..()

	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] 开始[scanned ? "娴熟地" : ""]用 [I] 复位 [victim.p_their()] 的[limb.plaintext_zone]。"), span_warning("你开始用 [I] 复位自己的[limb.plaintext_zone][scanned ? "，同时留意全息影像的指示" : ""]……"))
	else
		user.visible_message(span_danger("[user] 开始[scanned ? "娴熟地" : ""]用 [I] 复位 [victim] 的[limb.plaintext_zone]。"), span_notice("你开始用 [I] 复位 [victim] 的[limb.plaintext_zone][scanned ? "，同时留意全息影像的指示" : ""]……"))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		limb.receive_damage(brute=45, wound_bonus=CANT_WOUND)
		victim.visible_message(span_danger("[user] 伴随着令人不适的<b>咔嚓</b>声，完成了 [victim.p_their()] [limb.plaintext_zone] 的复位！"), span_userdanger("你伴随着令人不适的<b>咔嚓</b>声，把自己的[limb.plaintext_zone]复位了！"))
	else
		limb.receive_damage(brute=40, wound_bonus=CANT_WOUND)
		user.visible_message(span_danger("[user] 伴随着令人不适的<b>咔嚓</b>声，完成了 [victim] 的[limb.plaintext_zone] 复位！"), span_nicegreen("你伴随着令人不适的<b>咔嚓</b>声，完成了 [victim] 的[limb.plaintext_zone] 复位！"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] 伴随着令人不适的<b>咔嚓</b>声，把你的[limb.plaintext_zone]复位了！"))

	victim.emote("scream")
	playsound(user, 'sound/effects/wounds/crack2.ogg', 70, TRUE)
	qdel(src)

/datum/design/alienbonesetter
	name = "异形接骨器"
	desc = "一件逆向工程科技的怪胎，由某个疯子设计。"
	id = "alien_bonesetter"
	build_path = /obj/item/bonesetter/alien
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/blood_filter/alien
	name = "异形血液过滤器"
	desc = "一件逆向工程仿制的血液过滤器……<b>从接受端来看可不太妙……</b>"
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	custom_materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	icon_state = "bloodfilter"
	toolspeed = 0.25

/datum/design/alienbloodfilter
	name = "异形血液过滤器"
	desc = "一件逆向工程科技的怪胎，由某个疯子设计。"
	id = "alien_bloodfilter"
	build_path = /obj/item/blood_filter/alien
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/blood_filter/advanced
	name = "医疗组合工具"
	desc = "接骨器与血液过滤器的邪恶结合体。"
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	icon_state = "combitool"
	inhand_icon_state = "adv_retractor"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7

/obj/item/blood_filter/advanced/attack_self_secondary(mob/user)
	ui_interact(user)

/obj/item/blood_filter/advanced/BorgCtrlClick(mob/user)
	ui_interact(user)

/obj/item/blood_filter/advanced/get_all_tool_behaviours()
	return list(TOOL_BLOODFILTER, TOOL_BONESET)

/obj/item/blood_filter/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between bonesetter and bloodfilter and gives feedback to the user.
 */
/obj/item/blood_filter/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = (active ? TOOL_BONESET : TOOL_BLOODFILTER)
	balloon_alert(user, "工具已切换为[active ? "接骨" : "过滤血液"]")
	playsound(user ? user : src, 'sound/items/tools/change_drill.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/blood_filter/advanced/examine()
	. = ..()
	. += span_notice("它看起来像[tool_behaviour == TOOL_BLOODFILTER ? "血液过滤器" : "接骨器"]。")

/datum/design/combitool
	name = "医疗组合工具"
	desc = "该工具既可用作血液过滤器，也可用作接骨器。"
	id = "combitool"
	build_path = /obj/item/blood_filter/advanced
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/surgery_tools/New()
	design_ids += list(
		"combitool",
	)
	return ..()

/datum/techweb_node/alien_surgery/New()
	design_ids += list(
		"alien_bloodfilter",
		"alien_bonesetter",
	)
	return ..()

#undef TOOL_ALIEN_BONESET
