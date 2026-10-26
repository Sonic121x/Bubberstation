/obj/item/clothing/under/rank/cargo
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo_digi.dmi' // Anything that was in the cargo.dmi, should be in the cargo_digi.dmi
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/cargo/tech/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

/obj/item/clothing/under/rank/cargo/qm/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/cargo.dmi'

// Add a /obj/item/clothing/under/rank/cargo/miner/skyrat if you add miner uniforms

/*
*	CARGO TECH
*/

/obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	name = "后勤实用制服"
	desc = "后勤部门员工穿着的实用制服。"
	icon_state = "util_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/cargo/tech/skyrat/long
	name = "货运技术员长款连体服"
	desc = "给那些宁愿护住双腿、也不愿露出来的搬箱工。"
	icon_state = "cargo_long"
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/long/skirt
	name = "货运技术员长款短裙"
	desc = "给那些宁愿护住双腿、也不愿露出来的搬箱工——只不过这条裙子并不护腿。"
	icon_state = "cargo_long_skirt"
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/gorka
	name = "后勤高尔卡服"
	desc = "后勤部门穿着的粗犷实用高尔卡服。"
	icon_state = "gorka_cargo"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	name = "后勤高领毛衣"
	desc = "后勤部门穿着的贴身高领毛衣。"
	icon_state = "turtleneck_cargo"

/obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck/skirt
	name = "后勤高领短裙"
	desc = "后勤部门穿着的贴身高领毛衣，这次还连了一条裙子！"
	icon_state = "skirtleneck"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/tech/skyrat/evil
	name = "黑色货运制服"
	desc = "一件标准货运制服，只是多了几分……古老可敬的气息。"
	icon_state = "qmsynd"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	name = "货运技术员休闲装"
	desc = "一条时髦的黑色牛仔裤配一件普通毛衣，适合放松状态的技术员。"
	icon_state = "cargotechjean"
	can_adjust = FALSE

/*
*	QUARTERMASTER
*/

/obj/item/clothing/under/rank/cargo/qm/skyrat/gorka
	name = "货运主管高尔卡服"
	desc = "一件带银色标记的粗犷实用高尔卡服。与普通员工的款式不同，这一件的内衬是丝绸的。"
	icon_state = "gorka_qm"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck
	name = "货运主管高领毛衣"
	desc = "货运主管穿着的贴身高领毛衣，其标志性搭配是一条看起来就很贵的西装长裤。"
	icon_state = "turtleneck_qm"

/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt
	name = "货运主管高领短裙"
	desc = "货运主管穿着的贴身高领毛衣，那件丝绸短裙优雅的双层内衬足以说明这一点。"
	icon_state = "skirtleneckQM"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/qm/skyrat/syndie
	name = "甲板军官连体服"
	desc = "一套深色西装搭配经典的货运背心。献给掌管一切纸面事务的终极大师。"
	icon_state = "qmsynd"
	has_sensor = NO_SENSORS
	armor_type = /datum/armor/clothing_under/skyrat_syndie
	can_adjust = FALSE

/datum/armor/clothing_under/skyrat_syndie
	melee = 10
	fire = 50
	acid = 40

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal
	name = "货运主管正式连体服"
	desc = "为老派货运主管准备的西部风格替换制服。"
	icon_state = "supply_chief"
	can_adjust = FALSE

/obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt
	name = "货运主管正式短裙"
	desc = "为老派货运主管准备的西部风格替换制服。附赠裙子！"
	icon_state = "supply_chief_skirt"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/cargo/qm/skyrat/casual
	name = "货运主管休闲装"
	desc = "一件棕色夹克配同色长裤，适合放松状态的货运主管。"
	icon_state = "qmc"
