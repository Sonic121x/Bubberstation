/obj/item/seeds/tower
	name = "塔盖菇菌丝包"
	desc = "这种菌丝会成长为塔盖菇。"
	icon_state = "mycelium-tower"
	species = "towercap"
	plantname = "塔盖菇"
	product = /obj/item/grown/log
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/service/hydroponics/growing_mushrooms.dmi'
	icon_dead = "towercap-dead"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = list(/obj/item/seeds/tower/steel)
	reagents_add = list(/datum/reagent/cellulose = 0.05)
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/seeds/tower/steel
	name = "钢盖菇菌丝包"
	desc = "这种菌丝会长成钢木原木。"
	icon_state = "mycelium-steelcap"
	species = "steelcap"
	plantname = "钢盖菇"
	product = /obj/item/grown/log/steel
	mutatelist = null
	reagents_add = list(/datum/reagent/cellulose = 0.05, /datum/reagent/iron = 0.05)
	rarity = PLANT_MODERATELY_RARE

/obj/item/grown/log
	seed = /obj/item/seeds/tower
	name = "塔盖菇原木"
	desc = "它比差的好，它很好！"
	icon_state = "logs"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("猛击", "痛打", "重砸", "敲打")
	attack_verb_simple = list("猛击", "痛打", "重砸", "敲打")
	/// Type of plank you can get from this type of log
	var/plank_type = /obj/item/stack/sheet/mineral/wood
	/// How many planks you can get from this type of log, without counting seed potency
	var/plank_count = 1
	/// Name of plank, shown in context tips and balloon alerts when cutting the log
	var/plank_name = "木板"
	var/static/list/accepted = typecacheof(list(
		/obj/item/food/grown/tobacco,
		/obj/item/food/grown/tea,
		/obj/item/food/grown/ash_flora/mushroom_leaf,
		/obj/item/food/grown/ambrosia/vulgaris,
		/obj/item/food/grown/ambrosia/deus,
		/obj/item/food/grown/wheat,
	))

/obj/item/grown/log/Initialize(mapload, obj/item/seeds/new_seed)
	. = ..()
	register_context()
	if(seed)
		plank_count += round(seed.potency / 25)

/obj/item/grown/log/add_context(
	atom/source,
	list/context,
	obj/item/held_item,
	mob/living/user,
)

	if(isnull(held_item))
		return NONE

	if(held_item.get_sharpness())
		// May be a little long, but I think "cut into planks" for steel caps may be confusing.
		context[SCREENTIP_CONTEXT_LMB] = "切成[plank_name]"
		return CONTEXTUAL_SCREENTIP_SET

	if(CheckAccepted(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "制作火把"
		return CONTEXTUAL_SCREENTIP_SET

	return NONE

/obj/item/grown/log/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.get_sharpness())
		user.balloon_alert(user, "制成了 [plank_count] 份 [plank_name]")
		new plank_type(user.loc, plank_count)
		qdel(src)
		return ITEM_INTERACT_SUCCESS

	if(CheckAccepted(tool))
		var/obj/item/food/grown/leaf = tool
		if(!HAS_TRAIT(leaf, TRAIT_DRIED))
			balloon_alert(user, "先把它弄干！")
			return ITEM_INTERACT_BLOCKING

		user.balloon_alert(user, "火把已制成")
		var/obj/item/flashlight/flare/torch/new_torch = new /obj/item/flashlight/flare/torch(user.loc)
		user.dropItemToGround(tool)
		user.put_in_active_hand(new_torch)
		qdel(leaf)
		qdel(src)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/item/grown/log/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, accepted)

/obj/item/grown/log/tree
	seed = null
	name = "原木"
	desc = "倒————啦————！"
	plank_count = 10

/obj/item/grown/log/steel
	seed = /obj/item/seeds/tower/steel
	name = "钢盖菇原木"
	desc = "它是金属做的。"
	icon_state = "steellogs"
	plank_type = /obj/item/stack/rods
	plank_name = "金属杆"

/obj/item/grown/log/steel/CheckAccepted(obj/item/I)
	return FALSE

/obj/structure/punji_sticks
	name = "尖竹桩"
	desc = "别踩上去。"
	icon = 'icons/obj/service/hydroponics/equipment.dmi'
	icon_state = "punji"
	resistance_flags = FLAMMABLE
	max_integrity = 30
	density = FALSE
	anchored = TRUE
	buckle_lying = 90
	custom_materials = list(/datum/material/bamboo = SHEET_MATERIAL_AMOUNT * 5)
	/// Overlay we apply when impaling a mob.
	var/mutable_appearance/stab_overlay

/obj/structure/punji_sticks/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, min_damage = 20, max_damage = 30, flags = CALTROP_BYPASS_SHOES)
	build_stab_overlay()

/obj/structure/punji_sticks/proc/build_stab_overlay()
	stab_overlay = mutable_appearance(icon, "[icon_state]_stab", layer = ABOVE_MOB_LAYER)

/obj/structure/punji_sticks/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents)
	. = ..()
	if(same_z_layer)
		return
	build_stab_overlay()
	update_appearance()

/obj/structure/punji_sticks/post_buckle_mob(mob/living/M)
	update_appearance()
	return ..()

/obj/structure/punji_sticks/post_unbuckle_mob(mob/living/M)
	update_appearance()
	return ..()

/obj/structure/punji_sticks/update_overlays()
	. = ..()
	if(length(buckled_mobs))
		. += stab_overlay

/obj/structure/punji_sticks/intercept_zImpact(list/falling_movables, levels)
	. = ..()
	for(var/mob/living/fallen_mob in falling_movables)
		if(LAZYLEN(buckled_mobs))
			return
		if(buckle_mob(fallen_mob, TRUE))
			to_chat(fallen_mob, span_userdanger("你被 [src] 刺穿了！"))
			fallen_mob.apply_damage(25 * levels, BRUTE, sharpness = SHARP_POINTY)
			if(iscarbon(fallen_mob))
				var/mob/living/carbon/fallen_carbon = fallen_mob
				fallen_carbon.emote("scream")
				fallen_carbon.bleed(30)
	. |= FALL_INTERCEPTED | FALL_NO_MESSAGE

/obj/structure/punji_sticks/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(force)
		return ..()
	to_chat(buckled_mob, span_warning("你开始从 [src] 里爬出来。"))
	buckled_mob.apply_damage(5, BRUTE, sharpness = SHARP_POINTY)
	if(!do_after(buckled_mob, 5 SECONDS, target = src))
		to_chat(buckled_mob, span_userdanger("你没能把自己从 [src] 上脱开。"))
		return
	return ..()

/obj/structure/punji_sticks/spikes
	name = "木刺"
	icon_state = "woodspike"
