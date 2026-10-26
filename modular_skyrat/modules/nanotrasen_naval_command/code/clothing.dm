
// UNDER
/obj/item/clothing/under/rank/centcom/skyrat/naval
	name = "海军少尉制服"
	desc = "纳米传讯海军少尉穿着的制服。"
	icon_state = "naval_ensign"
	can_adjust = TRUE

/obj/item/clothing/under/rank/centcom/skyrat/naval/commander
	name = "海军指挥制服"
	desc = "纳米传讯海军指挥军官穿着的制服。"
	icon_state = "naval_command"

/obj/item/clothing/under/rank/centcom/skyrat/naval/admiral
	name = "海军上将制服"
	desc = "纳米传讯海军上将穿着的制服。"
	icon_state = "naval_admiral"

/obj/item/clothing/under/rank/centcom/skyrat/naval/fleet_admiral
	name = "海军元帅制服"
	desc = "纳米传讯海军元帅穿着的制服。"
	icon_state = "naval_fleet_admiral"

// GLOVES
/obj/item/clothing/gloves/combat/naval
	name = "纳米传讯海军手套"
	desc = "一双饰有金色缝线的优质厚手套，配发给纳米传讯海军指挥官。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	icon_state = "naval_command"

/obj/item/clothing/gloves/combat/naval/fleet_admiral
	name = "海军元帅手套"
	icon_state = "naval_fleet_admiral"


// HATS
/obj/item/clothing/head/hats/caphat/naval
	name = "海军帽"
	desc = "纳米传讯海军人员佩戴的帽子。"
	icon_state = "naval_command"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/caphat/naval/fleet_admiral
	name = "海军元帅帽"
	desc = "纳米传讯海军元帅佩戴的帽子。"
	icon_state = "naval_fleet_admiral"


// NECK
/obj/item/clothing/neck/pauldron
	name = "海军少校肩甲"
	desc = "一块红色衬垫肩甲，标识纳米传讯海军少校军衔。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "pauldron_ltcr"

/obj/item/clothing/neck/pauldron/commander
	name = "海军中校肩甲"
	desc = "一块红色衬垫肩甲，标识纳米传讯海军中校军衔。"
	icon_state = "pauldron_commander"

/obj/item/clothing/neck/pauldron/captain
	name = "海军上校肩甲"
	desc = "一块红色衬垫肩甲，标识纳米传讯海军上校军衔。"
	icon_state = "pauldron_captain"

/obj/item/clothing/neck/cloak/admiral
	name = "海军上将披风"
	desc = "一件鲜绿色披风，缀有金色缝线，由纳米传讯海军上将穿着。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "cape_admiral"

/obj/item/clothing/neck/cloak/fleet_admiral
	name = "海军元帅披风"
	desc = "一件威严非凡的披风，由纳米传讯海军最高军衔者——海军元帅穿着。"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "cape_fleet_admiral"

// SUITS
/obj/item/clothing/suit/armor/vest/capcarapace/naval
	name = "海军胸甲"
	desc = "海军指挥部成员穿戴的胸甲。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "naval_carapace"

// GLASSES
/obj/item/clothing/glasses/hud/security/sunglasses/black
	name = "黑色安保墨镜"
	desc = "海军指挥部军官佩戴的黑色墨镜。"
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sun"

/obj/item/clothing/glasses/hud/security/sunglasses/black/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)
