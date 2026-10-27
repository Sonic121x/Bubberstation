/obj/item/clothing/head/costume/garland
	name = "花环"
	desc = "在某个地方，有人戴着这玩意儿还饿着肚子。而那个人绝对不是你。"
	icon_state = "garland"
	worn_icon_state = "garland"

/obj/item/clothing/head/costume/garland/equipped(mob/living/user, slot)
	. = ..()
	if(slot_flags & slot)
		user.add_mood_event("garland", /datum/mood_event/garland)

/obj/item/clothing/head/costume/garland/dropped(mob/living/user)
	. = ..()
	user.clear_mood_event("garland")

/obj/item/clothing/head/costume/garland/rainbowbunch
	name = "彩虹花冠"
	desc = "由彩虹花丛的花朵编成的花冠。"
	icon_state = "rainbow_bunch_crown_1"
	base_icon_state = "rainbow_bunch_crown"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.3) //tied together with cable coil

/obj/item/clothing/head/costume/garland/rainbowbunch/Initialize(mapload)
	. = ..()
	var/crown_type = rand(1,4)
	icon_state = "[base_icon_state]_[crown_type]"
	switch(crown_type)
		if(1)
			desc += " 这一顶有红、黄、白色的花。"
		if(2)
			desc += " 这一顶有蓝、黄、绿、白色的花。"
		if(3)
			desc += " 这一顶有红、蓝、紫、粉色的花。"
		if(4)
			desc += " 这一顶有黄、绿、白色的花。"

/obj/item/clothing/head/costume/garland/sunflower
	name = "向日葵花冠"
	desc = "一顶由向日葵编成的明亮花冠，肯定能让任何人的一天都亮起来！"
	icon_state = "sunflower_crown"
	worn_icon_state = "sunflower_crown"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.3) //tied together with cable coil

/obj/item/clothing/head/costume/garland/poppy
	name = "罂粟花冠"
	desc = "一顶用一串鲜红罂粟花编成的花冠。"
	icon_state = "poppy_crown"
	worn_icon_state = "poppy_crown"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.3) //tied together with cable coil

/obj/item/clothing/head/costume/garland/lily
	name = "百合花冠"
	desc = "一顶枝叶繁茂的花冠，正面簇拥着大朵白百合。"
	icon_state = "lily_crown"
	worn_icon_state = "lily_crown"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.3) //tied together with cable coil

