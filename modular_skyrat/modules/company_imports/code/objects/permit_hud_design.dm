// Printable permit HUD, mirroring the other Integrated HUDs designs so it isn't a magic item locked to the blacksmith's loadout.
/datum/design/permit_hud
	name = "许可 HUD"
	desc = "一种基本的平视显示器，可扫描视野内的人形生物，并标出其 ID 是否带有枪械许可。"
	id = "permit_hud"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/clothing/glasses/hud/permit
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE
	)
