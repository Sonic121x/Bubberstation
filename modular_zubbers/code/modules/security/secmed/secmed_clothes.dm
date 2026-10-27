/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	name = "安保医疗兵实验服"
	desc = "一件轻便的背心，由安保医疗兵穿着。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/labcoat.dmi'
	icon_state = "secmed_labcoat" //Icon located in modular_skyrat/master_files/icons/(obj or mob)/clothing/suits/labcoat.dmi
	blood_overlay_type = "armor"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/skyrat_security_medic

/datum/armor/skyrat_security_medic
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/medkit
		)

/datum/armor/hazardvest_security_medic
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/hazardvest/security_medic
	name = "安保医疗兵高可见背心"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	icon_state = "secmed_vest"
	worn_icon_state = "secmed_vest"
	armor_type = /datum/armor/hazardvest_security_medic
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/applicator/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	name = "安保医疗兵装甲背心"
	desc = "安保医疗兵的装甲背心，上面有些小口袋，可以装小物件。"
	icon = 'modular_zubbers/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/suits/armor.dmi'
	worn_icon_teshari = 'modular_zubbers/icons/mob/clothing/suits/armor_teshari.dmi'
	icon_state = "secmed_armor"
	worn_icon_state = "secmed_armor"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/applicator/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
	name = "安保医疗兵制服"
	desc = "一件轻装甲制服，由纳米传讯资产保护医疗队的成员穿着。"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	icon_state = "security_medic_jumpsuit"
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	worn_icon_state = "security_medic_jumpsuit"
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'

/obj/item/clothing/under/rank/security/peacekeeper/security_medic
	name = "安保医疗兵高领衫"
	desc = "一件舒适的高领衫，配有白色臂章，表明穿着者是安保医疗兵。"
	icon = 'modular_zubbers/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/under/security.dmi'
	icon_state = "security_medic_turtleneck"
	worn_icon_digi = 'modular_zubbers/icons/mob/clothing/under/security_digi.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	name = "安保医疗兵高领裙"
	desc = "一件舒适的高领衫，配有白色臂章和棕色裙子，表明穿着者是安保医疗兵。"
	icon_state = "security_medic_turtleneck_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/beret/sec/security_medic
	name = "安保医疗兵贝雷帽"
	desc = "一顶结实的贝雷帽，上面印有医疗徽记。采用加固面料，能提供足够的防护。"
	icon_state = "/obj/item/clothing/head/beret/sec/security_medic"
	greyscale_colors = "#3F3C40#870E12"
	post_init_icon_state = "beret_badge_med"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic
	name = "安保医疗兵头盔"
	desc = "为安保医疗兵配发的标准战斗头盔。具有不错的抗拉强度和防护能力。把头压低点。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_zubbers/icons/mob/clothing/head/helmet.dmi'
	icon_state = "secmed_helmet"
	base_icon_state = "secmed_helmet"
	actions_types = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/belt/security/medic
	name = "安保医疗兵腰带"
	desc = "一条外观讲究的安保腰带，上面印有安保医疗兵的标记。可惜只能装安保装备。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "belt_medic"
	icon_state = "belt_medic"

/obj/item/storage/belt/security/medic/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/medic/alternate
	name = "安保医疗兵腰带"
	worn_icon_state = "belt_medic_alt"
	icon_state = "belt_medic_alt"
