/obj/item/ammo_casing/rocket
	name = "\improper Dardo 高爆火箭弹"
	desc = "一枚 84mm 高爆火箭弹。朝人发射，然后祈祷吧。"
	caliber = CALIBER_84MM
	icon_state = "srm-8"
	base_icon_state = "srm-8"
	projectile_type = /obj/projectile/bullet/rocket
	newtonian_force = 2

/obj/item/ammo_casing/rocket/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/rocket/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]"

/obj/item/ammo_casing/rocket/heap
	name = "\improper Dardo 高爆穿甲火箭弹"
	desc = "一枚 84mm 高爆多用途火箭弹。专供你只希望某样东西彻底消失的时候使用。"
	icon_state = "84mm-heap"
	base_icon_state = "84mm-heap"
	projectile_type = /obj/projectile/bullet/rocket/heap

/obj/item/ammo_casing/rocket/weak
	name = "\improper Dardo 低当量高爆火箭弹"
	desc = "一枚 84mm 高爆火箭弹。这一枚没那么毁天灭地。"
	icon_state = "low_yield_rocket"
	base_icon_state = "low_yield_rocket"
	projectile_type = /obj/projectile/bullet/rocket/weak

/obj/item/ammo_casing/rocket/reverse
	projectile_type = /obj/projectile/bullet/rocket/reverse

/obj/item/ammo_casing/a75
	desc = "一个 .75 子弹壳。"
	caliber = CALIBER_75
	icon_state = "s-casing-live"
	base_icon_state = "s-casing-live"
	projectile_type = /obj/projectile/bullet/gyro

/obj/item/ammo_casing/a75/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/item/ammo_casing/a75/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]"
