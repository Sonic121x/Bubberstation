/obj/item/clothing/suit/hooded/cultrobes/eldritch/moon
	damage_modifier = 1.2

/obj/projectile/moon_parade
	range = 20

/obj/item/clothing/neck/heretic_focus/moon_amulet/examine(mob/user)
	. = ..()

	. += span_notice("增强月华之道侍徒的大脑恢复。可对目标施加月狂，使其陷入不辨敌我的狂怒。")
