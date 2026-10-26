/obj/item/clothing/under/rank/rnd
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd_digi.dmi'	// Anything that was in the rnd.dmi, should be in the rnd_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/rnd/scientist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/rank/rnd/roboticist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/rank/rnd/research_director/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

// Add a 'rnd/geneticist/skyrat' if you make Geneticist uniforms

/*
*	SCIENTIST
*/

/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility
	name = "科研实用制服"
	desc = "纳米传讯认证的科研人员穿着的实用制服。"
	icon_state = "util_sci"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	desc = "科研人员穿着的实用制服。"
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	name = "科研团队制服"
	desc = "一套简洁的半正式制服，由灰蓝色衬衫和米白色长裤组成，还配着一条荒唐却必须佩戴的领带。"
	icon_state = "hl_scientist"
	can_adjust = FALSE

/*
*	ROBOTICIST
*/

/obj/item/clothing/under/rank/rnd/roboticist/skyrat/sleek
	name = "流线型机器人学家连体服"
	desc = "机器人学家制服的流线型版本，还带有琥珀色的科幻风条纹。"
	icon_state = "robosleek"
	can_adjust = FALSE

/*
*	RESEARCH DIRECTOR
*/

/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit
	name = "科研主管连体服"
	desc = "一件闪亮的纳米织物制服，专为拥有“科研主管”头衔的人准备。其面料能提供轻微的生化污染物防护。"
	icon_state = "director_jumpsuit"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt // I know this seems wrong, but its for consistency sake; its the skirt version OF the jumpsuit
	name = "科研主管连体裙"
	icon_state = "director_jumpskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
*	OVERRIDES
*	ORION TODO: look over these when TG finishes their science resprites (any day now...)
*/

/obj/item/clothing/under/rank/rnd/scientist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "science_new"

/obj/item/clothing/under/rank/rnd/scientist/skirt
	icon_state = "sciwhite_skirt_new"

/obj/item/clothing/under/rank/rnd/roboticist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "robotics_new"

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	icon_state = "robotics_skirt_new"

/obj/item/clothing/under/rank/rnd/geneticist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "genetics_new"

/obj/item/clothing/under/rank/rnd/geneticist/skirt
	icon_state = "geneticswhite_skirt_new"
