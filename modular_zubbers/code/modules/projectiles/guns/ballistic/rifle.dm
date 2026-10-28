/obj/item/gun/ballistic/rifle/rebarxbow
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbow"

/obj/item/gun/ballistic/rifle/rebarxbow/syndie
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "rebarxbowsyndie"

/obj/item/ammo_box/magazine/internal/boltaction/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/internal/boltaction/jezail/empty
	start_empty = TRUE

/obj/item/gun/ballistic/rifle/boltaction/donkrifle/empty
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/jezail/empty


/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp
	name = "古董猎枪"
	desc = "这把 Sahko 显然比常见的 3SU、乃至更常遇到的泛斯拉夫联邦遗物都要受宠得多。令人费解的是，为什么有人会费心在一把普通步枪上镶嵌如此精美的材料、加上一个奇怪的五芒星标记，还配上一具如此老旧的瞄具。我们永远无从得知，但它现在在你手里。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "lionhunter"
	inhand_icon_state = "lionhunter"
	worn_icon_state = "lionhunter"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/empty

/obj/item/gun/ballistic/rifle/boltaction/lionhunterlarp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)
/obj/item/gun/ballistic/rifle/stingballer
	name = "\improper S-K 震爆弹步枪"
	desc = "一种气动步枪，专为快速发射震爆弹丸而设计。最多可装填 50 发。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "stingballer"
	fire_sound = 'modular_zubbers/sound/weapons/gun/light_gunfire.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/stingballer
	need_bolt_lock_to_interact = TRUE
	semi_auto = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	internal_magazine = TRUE
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = 2
	mag_display_ammo = TRUE
	spread = 7.5
	projectile_damage_multiplier = 0.50
	projectile_speed_multiplier = 1.25

/obj/item/gun/ballistic/rifle/stingballer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.125 SECONDS)

/obj/item/gun/ballistic/rifle/stingballer/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 26, offset_y = 12)

/obj/item/gun/ballistic/rifle/stingballer/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 20, \
		overlay_y = 10)
