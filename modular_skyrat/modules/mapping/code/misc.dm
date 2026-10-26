/obj/item/melee/sabre/luna
	name = "露娜"
	desc = "一名疯女人为纪念一段她以为几乎真实存在的时间与地点锻造而成。剑身上刻满各式的月亮，不同的相标记着剑刃的不同部位。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"

/obj/machinery/vending/security/noaccess
	req_access = null
	allow_custom = FALSE

/obj/structure/closet/secure_closet/medical2/unlocked/Initialize(mapload)
	. = ..()
	locked = FALSE
	update_appearance()
