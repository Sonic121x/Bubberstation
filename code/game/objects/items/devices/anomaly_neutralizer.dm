/obj/item/anomaly_neutralizer
	name = "异常体中和器"
	desc = "能够瞬间中和异常实体或异界实体的一次性装置。"
	icon = 'icons/obj/devices/tool.dmi'
	icon_state = "neutralyzer"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	item_flags = NOBLUDGEON
	custom_materials = list(/datum/material/plasma = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SHEET_MATERIAL_AMOUNT, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)

/obj/item/anomaly_neutralizer/Initialize(mapload)
	. = ..()

	// Primarily used to delete and neutralize anomalies.
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "你用%THEWEAPON中和了%THEEFFECT，同时烧毁了装置的电路。", \
		tip_text = "中和异常体", \
		on_clear_callback = CALLBACK(src, PROC_REF(on_anomaly_neutralized)), \
		effects_we_clear = list(/obj/effect/anomaly))

	// Can also be used to delete drained heretic influences, to stop fools from losing arms.
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "你用%THEWEAPON关闭了%THEEFFECT，同时烧毁了装置的电路。", \
		tip_text = "关闭裂隙", \
		on_clear_callback = CALLBACK(src, PROC_REF(on_use)), \
		effects_we_clear = list(/obj/effect/visible_heretic_influence))

/**
 * Callback for the effect remover component to handle neutralizing anomalies.
 */
/obj/item/anomaly_neutralizer/proc/on_anomaly_neutralized(obj/effect/anomaly/target, mob/living/user)
	target.anomalyNeutralize()
	on_use(target, user)

/**
 * Use up the anomaly neutralizer. Cause some sparks and delete it.
 */
/obj/item/anomaly_neutralizer/proc/on_use(obj/effect/target, mob/living/user)
	do_sparks(3, FALSE, user)
	qdel(src)
