/obj/item/clothing/under/rank/cargo
	icon = 'icons/obj/clothing/under/cargo.dmi'
	worn_icon = 'icons/mob/clothing/under/cargo.dmi'
	abstract_type = /obj/item/clothing/under/rank/cargo

/obj/item/clothing/under/rank/cargo/qm
	name = "货运主管制服"
	desc = "一件棕色衬衫，配一条黑色长裤。特别设计用来防止搬弄文件造成的背部损伤。"
	icon_state = "qm"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargo/qm/skirt
	name = "货运主管短裙"
	desc = "一件棕色衬衫，配一条黑色百褶长裙。特别设计用来防止搬弄文件造成的背部损伤。"
	icon_state = "qm_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/tech
	name = "货运技术员制服"
	desc = "一件棕色毛衣和一条黑色牛仔裤，因为说实话，谁喜欢短裤呢？"
	icon_state = "cargotech"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/under/rank/cargo/tech/alt
	name = "货运技术员短裤"
	desc = "我喜欢短裤裤裤裤！穿着舒服又方便！"
	icon_state = "cargotech_alt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	bodyshapes_with_variations = NONE

/obj/item/clothing/under/rank/cargo/tech/skirt
	name = "货运技术员短裙"
	desc = "一件棕色毛衣和一条相配的黑色短裙。"
	icon_state = "cargo_skirt"
	inhand_icon_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	bodyshapes_with_variations = NONE
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/cargo/tech/skirt/alt
	name = "货运技术员超短裙"
	desc = "我喜欢短裙裙裙裙！穿着舒服又方便！"
	icon_state = "cargo_skirt_alt"

/obj/item/clothing/under/rank/cargo/miner
	name = "矿工连体服"
	desc = "一件利落的连体服，配一套结实的背带工装裤。非常脏。"
	icon_state = "miner"
	inhand_icon_state = null
	armor_type = /datum/armor/clothing_under/cargo_miner
	resistance_flags = NONE

/datum/armor/clothing_under/cargo_miner
	fire = 80
	wound = 10

/obj/item/clothing/under/rank/cargo/miner/lavaland
	name = "矿工连体服"
	desc = "一套灰色制服，适合在危险环境中作业。"
	icon_state = "explorer"
	inhand_icon_state = null

/obj/item/clothing/under/rank/cargo/bitrunner
	name = "比特潜行者连体服"
	desc = "一件比特潜行者穿的皮革质感连体服。俗气，但长时间坐着穿很舒服。"
	icon_state = "bitrunner"
	inhand_icon_state = "w_suit"
