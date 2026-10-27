#define RESKIN_CHARCOAL "炭黑"
#define RESKIN_NT "纳米传讯蓝"
#define RESKIN_SYNDIE "辛迪加红"

/obj/item/clothing/under/syndicate
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate_digi.dmi' // Anything that was in the syndicate.dmi, should be in the syndicate_digi.dmi

/obj/item/clothing/under/syndicate/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	//These are pre-set for ease and reference, as syndie under items SHOULDNT have sensors and should have similar stats; also its better to start with adjust = false
	has_sensor = NO_SENSORS
	can_adjust = FALSE

//Related files:
// modular_skyrat\modules\syndie_edits\code\syndie_edits.dm (this has the Overalls and non-Uniforms)
// modular_skyrat\modules\novaya_ert\code\uniform.dm (NRI uniform(s))

/*
*	TACTICOOL
*/

//This is an overwrite, not a fully new item, but still fits best here.

/obj/item/clothing/under/syndicate/tacticool //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "战术潮高领衫"
	desc = "一件贴身高领衫，耀眼的纳米传讯蓝。光是看着它，就让人想买一杯纳米传讯认证咖啡，走进办公室，然后——工作——。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi' //Since its an overwrite it needs new icon linking. Woe.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "tactifool_blue"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	resistance_flags = FLAMMABLE

/obj/item/clothing/under/syndicate/tacticool/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tacticool_turtleneck)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/tacticool_turtleneck
	abstract_type = /datum/atom_skin/tacticool_turtleneck

/datum/atom_skin/tacticool_turtleneck/nt
	preview_name = RESKIN_NT
	new_icon_state = "tactifool_blue"

/datum/atom_skin/tacticool_turtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "tactifool"

/obj/item/clothing/under/syndicate/tacticool/proc/on_reskin()
	SIGNAL_HANDLER
	if(icon_state == "tactifool")
		desc = "光是看着它，就让人想买一支 SKS 步枪，走进树林，然后——行动——。"
		inhand_icon_state = "bl_suit"

/obj/item/clothing/under/syndicate/tacticool/skirt //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "战术潮高领短裙"
	desc = "一件贴身高领短裙，耀眼的纳米传讯蓝。光是看着它，就让人想买一杯纳米传讯认证咖啡，走进办公室，然后——工作——。"
	icon_state = "tactifool_blue_skirt"
	armor_type = /datum/armor/clothing_under
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/tacticool/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tacticool_skirtleneck)

/datum/atom_skin/tacticool_skirtleneck
	abstract_type = /datum/atom_skin/tacticool_skirtleneck

/datum/atom_skin/tacticool_skirtleneck/nt
	preview_name = RESKIN_NT
	new_icon_state = "tactifool_blue_skirt"

/datum/atom_skin/tacticool_skirtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "tactifool_skirt"

/obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors //Halloween-only
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/skyrat/baseball
	name = "辛迪加棒球衫"
	desc = "接下来上场击球的是辛迪加毒蛇队，准备来一记他们的招牌核爆全垒打！让这些公司狗好好开开眼。" //NT pitches their plasma/bluespace(something)
	icon_state = "syndicate_baseball"

/*
*	TACTICAL (Real)
*/
//The red alts, for BLATANTLY syndicate stuff (Like DS2)
// (Multiple non-syndicate things use the base tactical turtleneck, they cant have it red nor reskinnable. OUR version, however, can be.)
/obj/item/clothing/under/syndicate/skyrat/tactical
	name = "战术高领衫"
	desc = "一件贴身的辛迪加红高领衫配炭黑色工装裤。穿着这身去辩解自己的立场，祝你好运。"
	icon_state = "syndicate_red"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	armor_type = /datum/armor/clothing_under/syndicate
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/skyrat/tactical/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tactical_turtleneck)
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/datum/atom_skin/tactical_turtleneck
	abstract_type = /datum/atom_skin/tactical_turtleneck

/datum/atom_skin/tactical_turtleneck/syndie
	preview_name = RESKIN_SYNDIE
	new_icon_state = "syndicate_red"

/datum/atom_skin/tactical_turtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "syndicate"

/obj/item/clothing/under/syndicate/skyrat/tactical/proc/on_reskin()
	SIGNAL_HANDLER
	if(icon_state == "syndicate")
		desc = "一件不起眼却略显可疑的高领衫，配数码迷彩工装裤。"
		inhand_icon_state = "bl_suit"

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt
	name = "战术高领短裙"
	desc = "一件贴身的辛迪加红高领短裙配炭黑色短裙。穿着这身去辩解自己的立场，祝你好运。"
	icon_state = "syndicate_red_skirt"
	inhand_icon_state = "r_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/reskinable_item, /datum/atom_skin/tactical_skirtleneck)

/datum/atom_skin/tactical_skirtleneck
	abstract_type = /datum/atom_skin/tactical_skirtleneck

/datum/atom_skin/tactical_skirtleneck/syndie
	preview_name = RESKIN_SYNDIE
	new_icon_state = "syndicate_red_skirt"

/datum/atom_skin/tactical_skirtleneck/charcoal
	preview_name = RESKIN_CHARCOAL
	new_icon_state = "syndicate_skirt"

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt/on_reskin()
	. = ..()
	if(icon_state == "syndicate_skirt")
		desc = "一件不起眼却略显可疑的高领短裙。"
		inhand_icon_state = "bl_suit"

/*
*	ENCLAVE
*/
/obj/item/clothing/under/syndicate/skyrat/enclave
	name = "新美国中士制服"
	desc = "在群星之间，关于疯狂科学家和暴躁教官的传闻四处流传；还有那些披着漆黑如夜铠甲的生物，由身穿这身制服的男人或女人率领。他们有一个共同点：对“美国梦”怀着深沉而狂热的民族主义热忱。"
	icon_state = "enclave"
	can_adjust = TRUE
	armor_type = /datum/armor/clothing_under

/obj/item/clothing/under/syndicate/skyrat/enclave/officer
	name = "新美国军官制服"
	icon_state = "enclaveo"

/obj/item/clothing/under/syndicate/skyrat/enclave/real
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/syndicate/skyrat/enclave/real/officer
	name = "新美国军官制服"
	icon_state = "enclaveo"

#undef RESKIN_CHARCOAL
#undef RESKIN_NT
#undef RESKIN_SYNDIE
