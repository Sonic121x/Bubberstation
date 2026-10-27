/obj/item/clothing/mask/balaclava
	name = "巴拉克拉瓦头套"
	desc = "满载钞票"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets; yes, that's below hair, but it already has HIDEHAIR
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/balaclava/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/floortilebalaclava
	name = "地砖纹头套"
	desc = "最新款地砖迷彩头套，专为走廊战打造。\
		透气性、灵活性与舒适度俱佳。由 Camo-J's 设计。"
	icon_state = "floortile_balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/floortilebalaclava/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/adjust_fishing_difficulty, -5) //tacticool

/obj/item/clothing/mask/floortilebalaclava/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/luchador
	name = "卢查多面具"
	desc = "由强劲的格斗家佩戴，高高飞起击败敌人！"
	icon_state = "luchag"
	inhand_icon_state = null
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/luchador/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/speechmod, replacements = strings("luchador_replacement.json", "luchador"), end_string = " OLE!", end_string_chance = 25, uppercase = TRUE, slots = ITEM_SLOT_MASK)

/obj/item/clothing/mask/luchador/tecnicos
	name = "技术派面具"
	desc = "由维护正义、堂堂正正作战的强劲格斗家佩戴。"
	icon_state = "luchador"

/obj/item/clothing/mask/luchador/rudos
	name = "鲁多派面具"
	desc = "由为取胜不择手段的强劲格斗家佩戴。"
	icon_state = "luchar"

/obj/item/clothing/mask/russian_balaclava
	name = "俄式头套"
	desc = "保护你的脸免受风雪侵袭。"
	icon_state = "rus_balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	alternate_worn_layer = LOW_FACEMASK_LAYER //This lets it layer below glasses and headsets; yes, that's below hair, but it already has HIDEHAIR
	w_class = WEIGHT_CLASS_SMALL
