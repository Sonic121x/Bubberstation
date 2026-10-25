/**
 * # secret documents
 *
 * Indestructible antag objective that can be photocopied.
 *
 * Photocopying this is handled in photocopier.dm.
 * Cannot be destroyed, but can be spaced.
 * Save for the inhand, this does not actually have anything in common with /obj/item/paper.
*/
/obj/item/documents
	name = "秘密文件"
	desc = "“绝密”文件。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_generic"
	inhand_icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	layer = MOB_LAYER
	pressure_resistance = 2
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	// Could use a more specific sound since it's a lot of paper (ditto with `/paperwork`).
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'

///Nanotrasen documents
/obj/item/documents/nanotrasen
	desc = "“绝密”纳米传讯文件，里面填满了复杂的图表，以及姓名、日期和坐标的清单。"
	icon_state = "docs_verified"

///Syndicate documents
/obj/item/documents/syndicate
	desc = "“绝密”文件，详述了辛迪加的敏感情报行动。"

///Syndicate documents with a red seal
/obj/item/documents/syndicate/red
	name = "红色秘密文件"
	desc = "“绝密”文件，详述了辛迪加的敏感情报行动。这些文件盖有红色火漆印章以验证真伪。"
	icon_state = "docs_red"

///Syndicate documents with a blue seal
/obj/item/documents/syndicate/blue
	name = "蓝色秘密文件"
	desc = "“绝密”文件，详述了辛迪加的敏感情报行动。这些文件盖有蓝色火漆印章以验证真伪。"
	icon_state = "docs_blue"

///Syndicate mining documents
/obj/item/documents/syndicate/mining
	desc = "“绝密”文件，详述了辛迪加的等离子体采矿作业。"

/**
 * # secret documents (photocopy)
 *
 * Outcome of photocopying documents. Can be copied, and can have a blue/red seal forged.
*/
/obj/item/documents/photocopy
	desc = "一些绝密文件的复印件。没人会注意到它们不是原件……对吧？"
	///What seal was forged on the documents (color name string)
	var/forgedseal = 0
	///What was copied
	var/copy_type = null

/obj/item/documents/photocopy/Initialize(mapload, obj/item/documents/copy=null)
	. = ..()
	if(copy)
		copy_type = copy.type
		if(istype(copy, /obj/item/documents/photocopy)) // Copy Of A Copy Of A Copy
			var/obj/item/documents/photocopy/C = copy
			copy_type = C.copy_type

/obj/item/documents/photocopy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/toy/crayon/red) && !istype(tool, /obj/item/toy/crayon/blue))
		return NONE
	if (forgedseal)
		to_chat(user, span_warning("你已经给[src]盖过印章了！"))
		return ITEM_INTERACT_BLOCKING

	var/obj/item/toy/crayon/C = tool
	name = "[C.crayon_color] 秘密文件"
	icon_state = "docs_[C.crayon_color]"
	forgedseal = C.crayon_color
	to_chat(user, span_notice("你用[C.crayon_color]蜡笔画上了官方印章。没人会注意到的……对吧？"))
	update_appearance()
	return ITEM_INTERACT_SUCCESS
