/obj/item/clothing/suit/costume/ghost_sheet
	name = "幽灵床单"
	desc = "双手自行漂浮，因此格外阴森。"
	icon_state = "ghost_sheet"
	inhand_icon_state = null
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEBELT|HIDEJUMPSUIT
	alternate_worn_layer = UNDER_HEAD_LAYER
	species_exception = list(/datum/species/golem)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/ghost_sheet/Initialize(mapload)
	. = ..()
	if(check_holidays(HALLOWEEN))
		update_icon(UPDATE_OVERLAYS)
	AddElement(/datum/element/adjust_fishing_difficulty, 8)

/obj/item/clothing/suit/costume/ghost_sheet/worn_overlays(mutable_appearance/standing, isinhands, icon_file, bodyshape = NONE)
	. = ..()
	if(!isinhands && check_holidays(HALLOWEEN))
		. += emissive_appearance('icons/mob/simple/mob.dmi', "ghost", offset_spokesman = src, alpha = src.alpha)

/obj/item/clothing/suit/spooky_ghost_sheet
	name = "阴森幽灵"
	desc = "这明显只是一条床单，不过也许可以穿上试试？"
	icon = 'icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'icons/mob/clothing/suits/costume.dmi'
	icon_state = "ghost_sheet"
	inhand_icon_state = null
	user_vars_to_edit = list("name" = "阴森幽灵", "real_name" = "Spooky Ghost", "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT|HIDEBELT|HIDEJUMPSUIT
	species_exception = list(/datum/species/golem)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire
