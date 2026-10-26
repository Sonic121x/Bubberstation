//This file is for any station-aligned or neutral factions, not JUST Nanotrasen.
//Try to keep them all a subtype of centcom/skyrat, for file sorting and balance - all faction representatives should have the same/similarly armored uniforms

/obj/item/clothing/under/rank/centcom
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom_digi.dmi'	// Anything that was in the rnd.dmi, should be in the rnd_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/centcom/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/*
*	NANOTRASEN
*/
//Check modular_skyrat\modules\nanotrasen_naval_command\code\clothing.dm for more of these! (Or, currently, ALL of these.)

/*
*	LOPLAND
*/
/obj/item/clothing/under/rank/centcom/skyrat/lopland
	name = "\improper 洛普兰企业制服"
	desc = "洛普兰企业人员穿着的流线型连体服。它的衬垫厚得令人意外。"
	icon_state = "lopland_shirt"
	worn_icon_state = "lopland_shirt"

/obj/item/clothing/under/rank/centcom/skyrat/lopland/instructor
	name = "\improper 洛普兰教官制服"
	desc = "洛普兰认证教官穿着的浮夸军装式连体服，背后还印着一个巨大的洛普兰标志。口袋的数量多到能让太空陆战队员落泪。"
	icon_state = "lopland_tac"
	worn_icon_state = "lopland_tac"


/*
*	MISC
*/
// pizza and other misc ERTs in this file too?
