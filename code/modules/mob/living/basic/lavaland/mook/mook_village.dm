///unique items that spawn at the mook village
/obj/structure/ore_container/material_stand
	name = "材料台"
	desc = "这东西谁都能随便用吗？"
	icon = 'icons/mob/simple/jungle/mook.dmi'
	icon_state = "material_stand"
	density = TRUE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE
	bound_width = 64
	bound_height = 64

///put ore icons on the counter!
/obj/structure/ore_container/material_stand/update_overlays()
	. = ..()
	for(var/obj/item/stack/ore/ore_item in contents)
		var/image/ore_icon = image(icon = initial(ore_item.icon), icon_state = initial(ore_item.icon_state), layer = LOW_ITEM_LAYER)
		ore_icon.transform = ore_icon.transform.Scale(0.6, 0.6)
		ore_icon.pixel_w = rand(9, 17)
		ore_icon.pixel_z = rand(2, 4)
		. += ore_icon

/obj/effect/landmark/mook_village
	name = "穆克村庄地标"
	icon_state = "x"
