/obj/projectile/bullet/c46x30mm
	name = "4.6x30mm 子弹"
	damage = 20
	wound_bonus = -5
	exposed_wound_bonus = 5
	embed_falloff_tile = -4

/obj/projectile/bullet/c46x30mm/ap
	name = "4.6x30mm 穿甲弹"
	damage = 15
	armour_penetration = 40
	embed_type = null

/obj/projectile/bullet/incendiary/c46x30mm //Not a typo. /obj/projectile/bullet/incendiary is a type.
	name = "4.6x30mm 燃烧弹"
	damage = 10
	fire_stacks = 1

/obj/projectile/bullet/c46x30mm/compressed
	name = "压缩 4.6x30mm 子弹"
	damage = 12

/obj/projectile/bullet/c45/lesser_reaper
	name = ".45 收割者弹丸"
	icon = 'modular_zubbers/icons/obj/weapons/guns/projectiles.dmi'
	icon_state = "reaper"
	damage = 50
	armour_penetration = 30
	speed = 1.75
