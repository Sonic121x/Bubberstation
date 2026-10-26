/obj/item/cigarette/pipe/crackpipe
	name = "快克烟斗"
	desc = "一支光滑的玻璃烟斗，专门用来吸食一种东西：快克。"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	worn_icon = 'modular_skyrat/modules/morenarcotics/icons/mask.dmi'
	icon_state = "glass_pipeoff" //it seems like theres some unused crack pipe sprite in masks.dmi, sweet!
	icon_on = "glass_pipeon"
	icon_off = "glass_pipeoff"
	chem_volume = 20

/obj/item/cigarette/pipe/crackpipe/process(seconds_per_tick)
	smoketime -= seconds_per_tick
	if(smoketime <= 0)
		if(ismob(loc))
			var/mob/living/smoking_mob = loc
			to_chat(smoking_mob, span_notice("你的[name]熄灭了。"))
			lit = FALSE
			icon_state = icon_off
			inhand_icon_state = icon_off
			smoking_mob.update_worn_mask()
			packeditem = FALSE
			name = "空的[initial(name)]"
		STOP_PROCESSING(SSobj, src)
		return
	open_flame()
	if(reagents?.total_volume) // check if it has any reagents at all
		handle_reagents()


/obj/item/cigarette/pipe/crackpipe/attackby(obj/item/used_item, mob/user, params)
	if(is_type_in_list(used_item, list(/obj/item/reagent_containers/crack,/obj/item/reagent_containers/blacktar)))
		to_chat(user, span_notice("你将[used_item]塞进[src]。"))
		smoketime = 2 * 60
		name = "装有[used_item.name]的[initial(name)]"
		if(used_item.reagents)
			used_item.reagents.trans_to(src, used_item.reagents.total_volume, transferred_by = user)
		qdel(used_item)
	else
		var/lighting_text = used_item.ignition_effect(src,user)
		if(lighting_text)
			if(smoketime > 0)
				light(lighting_text)
			else
				to_chat(user, span_warning("里面没有能吸的东西！"))
		else
			return ..()
