// Note: Everyone knows what an emag is, both IC and OOC, they even make toy lookalikes.
/obj/item/card/emag
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "一张经过特殊改装的身份证，用于破坏机械并解除安全防护。辛迪加特工以此臭名昭著。"

// The 'closer inspection' extra desc for these goes in special_desc
/obj/item/card/emagfake
	desc = /obj/item/card/emag::desc
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE_TOY
	special_desc = "仔细一看，这张卡是粗劣的仿制品，背面印着“咚克公司”标志。"

/obj/item/card/emag/doorjack
	desc = "这张外观过时的身份证明显经过非法加装电路的改装。看起来像臭名昭著的“emag”。"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "通常被称为“门控器”，这张非法改装的身份证能干扰气闸电子设备。内置自充电电池。常被辛迪加特工使用。"
