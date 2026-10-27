/obj/item/clothing/mask/fakemoustache
	name = "假胡子"
	desc = "警告：胡子是假的。"
	icon_state = "fake-moustache"
	alternate_worn_layer = ABOVE_BODY_FRONT_HEAD_LAYER
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE
	species_exception = list(/datum/species/golem)

/obj/item/clothing/mask/fakemoustache/italian
	name = "意大利式胡子"
	desc = "由正宗意大利胡子毛制成。会让佩戴者产生无法抗拒的疯狂打手势冲动。"

/obj/item/clothing/mask/fakemoustache/italian/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("italian_replacement.json", "italian"), end_string = list(" 意大利饺，意大利饺，把配方交出来！"," 我的妈呀！"," 我的妈呀！这肉丸可真辣！", " 啦 啦 啦 啦 啦，缆车缆车！"), end_string_chance = 3, slots = ITEM_SLOT_MASK)
