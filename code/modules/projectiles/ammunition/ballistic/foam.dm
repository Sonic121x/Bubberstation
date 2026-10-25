/obj/item/ammo_casing/foam_dart
	name = "泡沫飞镖"
	desc = "要么咚克，要么拉倒！8 岁及以上适用。"
	projectile_type = /obj/projectile/bullet/foam_dart
	caliber = CALIBER_FOAM
	icon = 'icons/obj/weapons/guns/toy.dmi'
	icon_state = "foamdart"
	base_icon_state = "foamdart"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.1125)
	harmful = FALSE
	newtonian_force = 0.5
	embed_type = /datum/embedding/foam_dart
	var/modified = FALSE
	var/static/list/insertable_items_hint = list(/obj/item/pen)
	///For colored magazine overlays.
	var/tip_color = "blue"

/obj/item/ammo_casing/foam_dart/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless, TRUE)

/obj/item/ammo_casing/foam_dart/update_icon_state()
	. = ..()
	if(modified)
		icon_state = "[base_icon_state]_empty"
		loaded_projectile?.icon_state = "[loaded_projectile.base_icon_state]_empty_proj"
		return
	icon_state = "[base_icon_state]"
	loaded_projectile?.icon_state = "[loaded_projectile.base_icon_state]_proj"

/obj/item/ammo_casing/foam_dart/update_desc()
	. = ..()
	desc = "要么咚克，要么拉倒！[modified ? "……不过，这枚看起来不太安全。" : "8 岁及以上适用。"]"

/obj/item/ammo_casing/foam_dart/examine_more(mob/user)
	. = ..()
	if(!HAS_TRAIT(src, TRAIT_DART_HAS_INSERT))
		var/list/type_initial_names = list()
		for(var/type in insertable_items_hint)
			var/obj/item/type_item = type
			type_initial_names += "\a [initial(type_item.name)]"
		. += span_notice("[modified ? "你可以" : "如果你用螺丝刀取下安全帽，你可以"]插入一个小物件\
			[length(type_initial_names) ? "，例如 [english_list(type_initial_names, and_text = "或 ", final_comma_text = "、")]" : ""]。")

/obj/item/ammo_casing/foam_dart/screwdriver_act(mob/living/user, obj/item/tool)
	if(modified)
		return NONE
	var/obj/projectile/bullet/foam_dart/dart = loaded_projectile
	modified = TRUE
	dart.modified = TRUE
	dart.damage_type = BRUTE
	dart.set_embed(null) // Cap is what makes them sticky
	to_chat(user, span_notice("你取下了 [src] 上的安全帽。"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/ammo_casing/foam_dart/riot
	name = "防暴泡沫飞镖"
	desc = "用玩具来维持人群秩序是谁想出来的高招？18 岁及以上适用。"
	projectile_type = /obj/projectile/bullet/foam_dart/riot
	icon_state = "foamdart_riot"
	base_icon_state = "foamdart_riot"
	tip_color = "red"
	embed_type = /datum/embedding/foam_dart/riot
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
