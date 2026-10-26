/obj/structure/alien/weeds/xen
	name = "异星杂草"
	desc = "厚厚一层藤蔓状的东西覆盖着地面。"
	color = "#ac3b06"

/obj/structure/spacevine/xen
	name = "异星藤蔓"
	color = "#ac3b06"

/obj/structure/spacevine/xen/Initialize(mapload)
	. = ..()
	add_atom_colour("#ac3b06", FIXED_COLOUR_PRIORITY)

/obj/structure/spacevine/xen/thick
	name = "粗壮的异星藤蔓"
	color = "#ac3b06"
	opacity = TRUE

/obj/structure/mineral_door/xen
	name = "有机门"
	color = "#ff8d58"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	openSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'
	closeSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'

/obj/machinery/door/puzzle/keycard/xen
	name = "密封有机门"
	desc = "一扇异常坚固、看起来像有机体的门。"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	puzzle_id = "xen"

/obj/item/keycard/xen
	name = "异星钥匙卡"
	desc = "一张异星钥匙卡。"
	color = "#ac3b06"
	puzzle_id = "xen"

/obj/structure/marker_beacon/green
	picked_color = "Lime"
	// set icon_state to make it clear for mappers
	icon_state = "markerlime-on"

/obj/structure/pod
	name = "补给舱"
	desc = "肯定有人把它从很远的地方送了过来。"
	icon = 'modular_skyrat/modules/black_mesa/icons/structures.dmi'
	icon_state = "pod"
	pixel_x = SUPPLYPOD_X_OFFSET
	anchored = TRUE

/obj/structure/closet/secure_closet/security/black_mesa
	req_access = list(ACCESS_AWAY_SEC)

