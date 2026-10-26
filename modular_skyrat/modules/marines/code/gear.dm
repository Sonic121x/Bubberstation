/obj/item/gun/ballistic/automatic/ar/modular/m44a
	name = "\improper NT M44A 脉冲步枪"
	desc = "一把纳米传讯特制的弹道脉冲步枪，使用压缩弹匣，在紧凑的枪身中爆发出惊人的火力。"
	icon_state = "m44a"
	inhand_icon_state = "m44a"
	icon = 'modular_skyrat/modules/marines/icons/m44a.dmi'
	righthand_file = 'modular_skyrat/modules/marines/icons/m44a_r.dmi'
	lefthand_file = 'modular_skyrat/modules/marines/icons/m44a_l.dmi'
	fire_sound = 'modular_skyrat/modules/marines/sound/m44a.ogg'
	fire_delay = 1
	burst_size = 3
	spread = 6
	pin = /obj/item/firing_pin/implant/mindshield
	can_suppress = FALSE
	mag_display = TRUE
	mag_display_ammo = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m44a
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/ballistic/automatic/ar/modular/m44a/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/ar/modular/m44a/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/ammo_box/magazine/m44a
	name = "M44A 弹匣（.300 压缩型）"
	desc = "这只弹匣利用蓝空间压缩腔，可为 M44A 脉冲步枪装填最多九十九发 .300 口径无壳弹。"
	icon = 'modular_skyrat/modules/marines/icons/m44a.dmi'
	icon_state = "300compressed"
	max_ammo = 99
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/c300
	caliber = "300comp"

/obj/item/ammo_casing/c300
	name = ".300 无壳弹"
	desc = "一枚 .300 无壳弹，用于纳米传讯专有枪械。"
	caliber = "300comp"
	projectile_type = /obj/projectile/bullet/a300

/obj/item/ammo_casing/c300/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/caseless)

/obj/projectile/bullet/a300
	name = ".300 无壳弹头"
	damage = 13
	armour_penetration = 30 //gonna actually kill the brit that made this var require a U in armor
	embed_data = null
	shrapnel_type = null

/obj/item/gun/ballistic/automatic/ar/modular/m44a/scoped
	name = "\improper NT M44AS 脉冲步枪"
	desc = "一把纳米传讯特制的弹道脉冲步枪，使用压缩弹匣，在紧凑的枪身中爆发出惊人的火力。这一把装有远程瞄准镜。"
	icon_state = "m44a_s"
	inhand_icon_state = "m44a_s"

/obj/item/gun/ballistic/automatic/ar/modular/m44a/scoped/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2.2)

/obj/item/gun/ballistic/shotgun/automatic/as2/ubsg
	name = "\improper M2 自动霰弹枪下挂组件"
	desc = "这东西不该出现在这儿！"
	can_suppress = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/as2/ubsg

/obj/item/gun/ballistic/shotgun/automatic/as2/ubsg/give_gun_safeties()
	return

/obj/item/ammo_box/magazine/internal/shot/as2/ubsg
	max_ammo = 3
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun
	name = "\improper NT M44ASG 脉冲步枪"
	desc = "一把纳米传讯特制的弹道脉冲步枪，使用压缩弹匣，在紧凑的枪身中爆发出惊人的火力。这一把装有两发半自动 12 号口径的下挂霰弹枪。"
	icon_state = "m44a_sg"
	inhand_icon_state = "m44a_sg"
	/// Reference to the underbarrel shotgun
	var/obj/item/gun/ballistic/shotgun/automatic/as2/ubsg/underbarrel

/obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/shotgun/automatic/as2/ubsg(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		return underbarrel.try_fire_gun(target, user, params)
	return ..()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isammocasing(tool))
		if(istype(tool, underbarrel.magazine.ammo_type))
			underbarrel.attackby(tool, user, list2params(modifiers))
			underbarrel.attack_self(user)
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher
	name = "\improper NT M44AGL 脉冲步枪"
	desc = "一把纳米传讯特制的弹道脉冲步枪，使用压缩弹匣，在紧凑的枪身中爆发出惊人的火力。这一把装有下挂榴弹发射器和红点瞄准镜，方便对准。是在补偿什么吗？"
	icon_state = "m44a_gl"
	inhand_icon_state = "m44a_gl"
	/// Underbarrel grenade launcher reference
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel

/obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		return underbarrel.try_fire_gun(target, user, params)
	return ..()

/obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isammocasing(tool))
		if(istype(tool, underbarrel.magazine.ammo_type))
			underbarrel.attackby(tool, user, list2params(modifiers))
			underbarrel.attack_self(user)
		return ITEM_INTERACT_BLOCKING
	return ..()
