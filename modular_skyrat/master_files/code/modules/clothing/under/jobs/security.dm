/obj/item/clothing/under/rank/security
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

//DEBATE MOVING *ALL* SECURITY STUFF HERE? Even overrides, at least as a like, sub-file?

/*
*	SECURITY OFFICER
*/

/obj/item/clothing/under/rank/security/skyrat/utility
	name = "安保实用制服"
	desc = "洛普兰认证的安保官穿着的实用制服。"
	icon_state = "util_sec_old"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec
	desc = "受过训练的安保官穿着的实用制服。"
	icon_state = "util_sec_old"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate
	armor_type = /datum/armor/clothing_under/redsec_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/security/peacekeeper/skirt
	name = "安保战斗服"
	desc = "一套不对称的男女通用制服，裤腿被换成了实用短裙。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_state = "security_skirt_redsec"
	icon_state = "security_skirt_redsec"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec
	name = "安保战斗服"
	desc = "一套不对称的男女通用制服，裤腿被换成了实用短裙。如今换上了经典的安保红！"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_state = "security_skirt_redsec"
	icon_state = "security_skirt_redsec"
	can_adjust = TRUE
	alt_covers_chest = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/skirt_redsec/Initialize(mapload)
	. = ..()
	var/list/reskin_components = GetComponents(/datum/component/reskinable_item)
	for(var/datum/component/reskinable_item/reskin_component as anything in reskin_components)
		qdel(reskin_component)

/obj/item/clothing/under/rank/security/peacekeeper/trousers
	name = "安保长裤"
	desc = "一条红色安保作战长裤。为了安全起见，大概该配上一件防弹背心。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "workpants_red"
	body_parts_covered = GROIN|LEGS
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_NO_BREASTS

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	name = "安保短裤"
	desc = "一条红色安保作战短裤。为了安全起见，绝对该配上一件防弹背心。"
	icon_state = "workshorts_red"

/obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/security_peacekeeper_shorts)

/datum/atom_skin/security_peacekeeper_shorts
	abstract_type = /datum/atom_skin/security_peacekeeper_shorts

/datum/atom_skin/security_peacekeeper_shorts/red_short
	preview_name = "红色变体，短款"
	new_icon_state = "workshorts_red"

/datum/atom_skin/security_peacekeeper_shorts/red_short_short
	preview_name = "红色变体，超短款"
	new_icon_state = "workshorts_red_short"

/obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	name = "安保连体服"
	desc = "维和者常穿的高领毛衣，下接一条长裤。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "jumpsuit_red"
	can_adjust = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/officer/skirt
	name = "安保连体裙"
	desc = "维和者常穿的高领毛衣，下接一条短裙。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "secskirt"

/obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	name = "安保迷你裙"
	desc = "这条迷你裙最初登上过一本恶搞日历，但当他们意识到它很适合干旱气候后，便被正式采用了。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "miniskirt_red"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE
	can_adjust = TRUE
	body_parts_covered = GROIN | LEGS

/*
*	HEAD OF SECURITY
*/

/datum/armor/clothing_under/redsec_syndicate
	melee = 10
	fire = 50
	acid = 40
