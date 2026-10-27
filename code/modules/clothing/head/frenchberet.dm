/obj/item/clothing/head/beret/frenchberet
	name = "法国贝雷帽"
	desc = "一顶上等贝雷帽，浸透了那些烟不离手、酒不离口的巴黎人的气息。不知为何，你现在不太想参与军事冲突了。"
	flags_1 = NO_NEW_GAGS_PREVIEW_1
	clothing_traits = list(TRAIT_GARLIC_BREATH)

/obj/item/clothing/head/beret/frenchberet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("french_replacement.json", "french"), end_string = list(" Honh honh honh!"," Honh!"," 糟糕！"), end_string_chance = 3, slots = ITEM_SLOT_HEAD)
