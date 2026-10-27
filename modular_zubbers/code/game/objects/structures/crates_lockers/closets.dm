/obj/structure/closet/examine(mob/user)
	. = ..()
	if(isobserver(user))
		. += span_info("里面装着：[english_list(contents, and_text = "和", comma_text = "、", final_comma_text = "")]。")

// Funny little closet for Lizard Gas.
/obj/structure/closet/lizardgas
	name = "蜥蜴燃气衣柜"
	desc = "哎呀，真可爱。现在回去工作。"
	icon = 'modular_zubbers/icons/obj/storage/closet.dmi'
	icon_state = "lizgas"
	icon_door = "lizgas"

/obj/structure/closet/lizardgas/PopulateContents()
	..()
	var/list/items_inside = list(
		/obj/item/clothing/head/beret/lizardgas = 2,
		/obj/item/clothing/suit/apron/chef/colorable_apron/lizardgas = 2,
		/obj/item/storage/backpack/satchel/lizardgas = 2)
	generate_items_inside(items_inside,src)
