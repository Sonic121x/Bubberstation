/obj/item/organ/cyberimp/eyes
	name = "赛博眼部植入体"
	desc = "用于眼睛的植入体。"
	icon_state = "eye_implant"
	slot = ORGAN_SLOT_EYES
	zone = BODY_ZONE_PRECISE_EYES
	w_class = WEIGHT_CLASS_TINY

// HUD implants
/obj/item/organ/cyberimp/eyes/hud
	name = "HUD 植入体"
	desc = "这些赛博眼会在你看到的一切之上叠加显示 HUD。也许吧。"
	slot = ORGAN_SLOT_HUD
	actions_types = list(/datum/action/item_action/organ_action/toggle_hud)
	var/HUD_traits = list()
	/// Whether the HUD implant is on or off
	var/toggled_on = TRUE
	/// Eyecolor from the HUD
	var/hud_color = "#3CB8A5"

/obj/item/organ/cyberimp/eyes/hud/Initialize(mapload)
	. = ..()
	if(toggled_on)
		for(var/hud_trait in HUD_traits)
			add_organ_trait(hud_trait)

/obj/item/organ/cyberimp/eyes/hud/proc/toggle_hud(mob/living/carbon/human/eye_owner)
	if(toggled_on)
		toggled_on = FALSE
		for(var/hud_trait in HUD_traits)
			remove_organ_trait(hud_trait)
		balloon_alert(eye_owner, "HUD 已禁用")
		if(hud_color)
			eye_owner.remove_eye_color(EYE_COLOR_HUD_PRIORITY)
		return
	toggled_on = TRUE
	for(var/hud_trait in HUD_traits)
		add_organ_trait(hud_trait)
	balloon_alert(eye_owner, "HUD 已启用")
	if(hud_color)
		eye_owner.add_eye_color_right(hud_color, EYE_COLOR_HUD_PRIORITY)

/obj/item/organ/cyberimp/eyes/hud/on_mob_insert(mob/living/carbon/human/eye_owner, special = FALSE, movement_flags)
	. = ..()
	if(toggled_on && hud_color)
		eye_owner.add_eye_color_right(hud_color, EYE_COLOR_HUD_PRIORITY, !special)

/obj/item/organ/cyberimp/eyes/hud/on_mob_remove(mob/living/carbon/human/eye_owner, special, movement_flags)
	. = ..()
	if(toggled_on && hud_color)
		eye_owner.remove_eye_color(EYE_COLOR_HUD_PRIORITY, !special)

/obj/item/organ/cyberimp/eyes/hud/medical
	name = "医疗 HUD 植入体"
	desc = "这些赛博眼部植入体会在你看到的一切之上叠加显示医疗 HUD。"
	icon_state = "eye_implant_medical"
	HUD_traits = list(TRAIT_MEDICAL_HUD)
	hud_color = "#1D8FEC"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/organ/cyberimp/eyes/hud/security
	name = "安保 HUD 植入体"
	desc = "这些赛博眼部植入体会在你看到的一切之上叠加显示安保 HUD。"
	icon_state = "eye_implant_security"
	HUD_traits = list(TRAIT_SECURITY_HUD)
	hud_color = "#9A151E"
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6)

/obj/item/organ/cyberimp/eyes/hud/diagnostic
	name = "诊断 HUD 植入体"
	desc = "这些赛博眼部植入体会在你看到的一切之上叠加显示诊断 HUD。"
	icon_state = "eye_implant_diagnostic"
	HUD_traits = list(TRAIT_DIAGNOSTIC_HUD, TRAIT_BOT_PATH_HUD)
	hud_color = "#CC6E33"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.6, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.6)

/obj/item/organ/cyberimp/eyes/hud/security/syndicate
	name = "违禁安保 HUD 植入体"
	desc = "赛博太阳工业品牌的安保 HUD 植入体。这些非法赛博眼部植入体会在你看到的一切之上叠加显示安保 HUD。"
	icon_state = "eye_implant_syndicate"
	organ_flags = ORGAN_ROBOTIC | ORGAN_HIDDEN
	hud_color = null
