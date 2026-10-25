/obj/item/grenade/syndieminibomb
	desc = "辛迪加制造的爆炸物，用于散播破坏与混乱。"
	name = "辛迪加迷你炸弹"
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "syndicate"
	inhand_icon_state = "flashbang"
	worn_icon_state = "minibomb"
	ex_dev = 1
	ex_heavy = 2
	ex_light = 4
	ex_flame = 2

/obj/item/grenade/syndieminibomb/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	update_mob()
	qdel(src)

/obj/item/grenade/syndieminibomb/concussion
	name = "高爆手榴弹"
	desc = "紧凑的破片手榴弹，用于重创附近的生物，并顺带造成些破坏。拔销后向远处投掷。"
	icon_state = "concussion"
	ex_heavy = 2
	ex_light = 3
	ex_flame = 3

/obj/item/grenade/frag
	name = "破片手榴弹"
	desc = "反人员破片手榴弹，擅长用金属弹片撕碎缺乏防护的目标。"
	icon_state = "frag"
	shrapnel_type = /obj/projectile/bullet/shrapnel
	shrapnel_radius = 4
	ex_heavy = 1
	ex_light = 3
	ex_flame = 4

/obj/item/grenade/frag/mega
	name = "超级破片手榴弹"
	desc = "反一切破片手榴弹，擅长用金属弹片撕碎任何东西。"
	shrapnel_type = /obj/projectile/bullet/shrapnel/mega
	shrapnel_radius = 12

/obj/item/grenade/frag/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	update_mob()
	qdel(src)

/obj/item/grenade/gluon
	desc = "先进手榴弹，会释放有害的胶子流，使附近的人受到辐射、疲惫并发抖。极度低温还可能使周围地面结霜打滑。"
	name = "胶子破片手榴弹"
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "bluefrag"
	inhand_icon_state = "flashbang"
	var/freeze_range = 4
	var/rad_range = 4
	var/rad_threshold = RAD_EXTREME_INSULATION
	var/stamina_damage = 30
	var/temp_adjust = -230

/obj/item/grenade/gluon/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	update_mob()
	playsound(loc, 'sound/effects/empulse.ogg', 50, TRUE)
	radiation_pulse(get_turf(src), max_range = rad_range, threshold = rad_threshold, chance = 100) // Activate on the turf, because we'll be gone before SSradiation fires
	for (var/turf/open/floor/floor in view(freeze_range, loc))
		floor.MakeSlippery(TURF_WET_PERMAFROST, 6 MINUTES)
		for(var/mob/living/carbon/victim in floor)
			victim.adjust_stamina_loss(stamina_damage)
			victim.adjust_bodytemperature(temp_adjust)
	qdel(src)
