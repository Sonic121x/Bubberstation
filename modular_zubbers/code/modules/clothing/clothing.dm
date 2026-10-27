/// For applying a normalization
/obj/item/clothing/proc/normalize_mob_size(mob/living/carbon/human/resizer)
	if(resizer.normalized)
		to_chat(resizer, span_danger("这件饰品嗡嗡作响，正被另一件覆盖。"))
		playsound(resizer, 'sound/machines/buzz/buzz-sigh.ogg', 50, 1)
		return
	playsound(resizer, 'sound/effects/magic.ogg', 50, 1)
	flash_lighting_fx(3, 3, LIGHT_COLOR_PURPLE)
	resizer.visible_message(span_warning("一道紫光吞没了[resizer]，随后其体型恢复了正常！"), span_notice("你感到一阵温暖，随后一切都缩放到了你的尺寸……"))
	if(resizer.get_quirk(/datum/quirk/oversized))
		resizer.remove_quirk(/datum/quirk/oversized)
	else
		resizer.update_transform(RESIZE_DEFAULT_SIZE / resizer?.client?.prefs?.read_preference(/datum/preference/numeric/body_size))
	resizer.normalized = TRUE

/// For removing a normalization, and reverting back to normal
/obj/item/clothing/proc/denormalize_mob_size(mob/living/carbon/human/resizer)
	if(resizer.normalized)
		playsound(resizer,'sound/items/weapons/emitter2.ogg', 50, 1)
		flash_lighting_fx(3, 3, LIGHT_COLOR_YELLOW)
		resizer.visible_message(span_warning("金光吞没了[resizer]，其体型猛地弹回默认身高！"), span_notice("能量涌遍全身，你恢复了正常。"))
		for(var/quirk in resizer?.client?.prefs?.all_quirks)
			if(quirk == "Oversized")
				resizer.add_quirk(/datum/quirk/oversized, announce = FALSE)
				break
		if(!resizer.get_quirk(/datum/quirk/oversized))
			resizer.update_transform(resizer?.client?.prefs?.read_preference(/datum/preference/numeric/body_size))
		resizer.normalized = FALSE
