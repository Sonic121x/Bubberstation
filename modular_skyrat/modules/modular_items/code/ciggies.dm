/obj/item/holocigarette
	name = "全息香烟"
	desc = "用全息甲板技术制造出来的香烟。想抽烟又不想承担任何坏处？试试全息香烟吧！"
	icon = 'modular_zubbers/icons/obj/cigarettes.dmi'
	icon_state = "cigoff"
	throw_speed = 0.5
	inhand_icon_state = "cigoff"
	w_class = WEIGHT_CLASS_TINY
	slot_flags= ITEM_SLOT_MASK
	// Note - these are in masks.dmi not in cigarette.dmi
	/// The icon state used when this is lit.
	var/icon_on = "cigon"
	/// The icon state used when this is extinguished.
	var/icon_off = "cigoff"
	var/lit = FALSE
	actions_types = list(/datum/action/item_action/toggle_lit)

/obj/item/holocigarette/cigar
	name = "明亮宇宙雪茄"
	desc = "一支用全息甲板技术制造的精致雪茄。它的外包装上似乎印有“明亮宇宙”的品牌字样。"
	worn_icon = 'modular_zubbers/icons/mob/clothing/mask/mask.dmi'
	icon_state = "holocigaroff"
	icon_on = "holocigaron"
	icon_off = "holocigaroff"

/datum/action/item_action/toggle_lit
	name = "点燃"
	desc = "点燃或熄灭全息香烟"

/datum/action/item_action/toggle_lit/Trigger(trigger_flags)
	if(!..())
		return FALSE
	var/obj/item/holocigarette/smoked = target
	var/mob/living/carbon/smoker = owner
	if(smoked.lit == FALSE)
		smoked.icon_state = smoked.icon_on
		smoked.worn_icon_state = smoked.icon_on
		smoked.inhand_icon_state = smoked.icon_on
		smoked.lit = TRUE
		smoked.name = "已点燃 [smoked.name]"
	else
		smoked.icon_state = smoked.icon_off
		smoked.worn_icon_state = smoked.icon_off
		smoked.inhand_icon_state = smoked.icon_off
		smoked.lit = FALSE
		smoked.name = copytext_char(smoked.name, 5) //5 == length_char("lit ") + 1
	smoked.update_icon()
	smoker.update_worn_mask()
	smoker.update_held_items()
