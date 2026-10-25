//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/gun/ballistic/revolver/grenadelauncher
	name = "撅开式榴弹发射器"
	desc = "一支撅开式榴弹发射器。以现代标准看很原始，但它还能用，那谁还能抱怨呢？"
	icon_state = "grenade_launcher"
	inhand_icon_state = "grenade_launcher"
	worn_icon_state = "shotgun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	pin = /obj/item/firing_pin/implant/pindicate
	bolt_type = BOLT_TYPE_NO_BOLT
	can_muzzle_flash = FALSE

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted/tear
	spawn_magazine_type = /obj/item/ammo_box/magazine/internal/grenadelauncher/tear

/obj/item/gun/ballistic/revolver/grenadelauncher/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if((. = ITEM_INTERACT_SUCCESS) && (istype(tool, /obj/item/ammo_box) || isammocasing(tool)))
		chamber_round()

/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel
	name = "下挂榴弹发射器"
	spawn_blacklisted = TRUE
	pin = null

/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel/Initialize(mapload)
	. = ..()
	var/obj/item/gun/gun = loc
	if (!istype(gun))
		return INITIALIZE_HINT_QDEL
	pin = gun.pin
	RegisterSignal(gun, COMSIG_GUN_PIN_INSERTED, PROC_REF(on_pin_inserted))
	RegisterSignal(gun, COMSIG_GUN_PIN_REMOVED, PROC_REF(on_pin_removed))

/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel/proc/on_pin_inserted(obj/item/gun/source, obj/item/firing_pin/new_pin, mob/living/user)
	SIGNAL_HANDLER
	pin = new_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel/proc/on_pin_removed(obj/item/gun/source, obj/item/firing_pin/old_pin, mob/living/user)
	SIGNAL_HANDLER
	pin = null

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg
	desc = "一支六发榴弹发射器。"
	name = "多管榴弹发射器"
	icon = 'icons/obj/devices/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/grenademulti
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg/attack_self()
	return

/obj/item/gun/ballistic/automatic/gyropistol
	name = "旋喷手枪"
	desc = "一款为发射自推进火箭弹而设计的原型手枪。"
	icon_state = "gyropistol"
	fire_sound = 'sound/items/weapons/gun/general/grenade_launch.ogg'
	accepted_magazine_type = /obj/item/ammo_box/magazine/m75
	burst_size = 1
	fire_delay = 0 SECONDS
	actions_types = list()
	casing_ejector = FALSE

/obj/item/gun/ballistic/rocketlauncher
	name = "\improper Dardo-RE 火箭筒"
	desc = "一支可重复使用的火箭推进榴弹发射器。发射管上印着一个指向发射器前方的箭头， \
		旁边写着“此端朝向敌人”。似乎有人把 \
		最后那个词划掉了，还在上面写了“NT”。发射器尾部附近贴着一张警告贴纸， \
		写着“开火前确认后方喷焰区无障碍”，天知道那是什么意思。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	worn_icon_state = "rocketlauncher"
	SET_BASE_PIXEL(-8, 0)
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/rocketlauncher
	fire_sound = 'sound/items/weapons/gun/general/rocket_launch.ogg'
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	can_suppress = FALSE
	pin = /obj/item/firing_pin/implant/pindicate
	burst_size = 1
	fire_delay = 0 SECONDS
	casing_ejector = FALSE
	weapon_weight = WEAPON_HEAVY
	bolt_type = BOLT_TYPE_NO_BOLT
	internal_magazine = TRUE
	cartridge_wording = "火箭弹"
	empty_indicator = TRUE
	tac_reloads = FALSE
	can_muzzle_flash = FALSE
	/// Do we shit flames behind us when we fire?
	var/backblast = TRUE

/obj/item/gun/ballistic/rocketlauncher/Initialize(mapload)
	. = ..()
	if(backblast)
		AddElement(/datum/element/backblast)

/obj/item/gun/ballistic/rocketlauncher/unrestricted
	desc = "一支可重复使用的火箭推进榴弹发射器。发射管上印着指向发射器前方的箭头， \
		旁边写着“此端朝向敌人”。 \
		发射器尾部附近贴着一张警告贴纸，写着“开火前确认后方喷焰区无障碍”，天知道那是什么意思。"
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/rocketlauncher/nobackblast
	name = "\improper Dardo-REF 无焰火箭筒"
	desc = "一支可重复使用的火箭推进榴弹发射器。发射管上印着指向发射器前方的箭头， \
		旁边写着“此端朝向敌人”。 \
		这一支加装了专用的尾焰导流器，以防使用过程中发生“友军”误伤的“意外”。"
	backblast = FALSE

/obj/item/gun/ballistic/rocketlauncher/try_fire_gun(atom/target, mob/living/user, params)
	. = ..()
	if(!.)
		return
	magazine.get_round() //Hack to clear the mag after it's fired

/obj/item/gun/ballistic/rocketlauncher/attack_self_tk(mob/user)
	return //too difficult to remove the rocket with TK

/obj/item/gun/ballistic/rocketlauncher/update_overlays()
	. = ..()
	if(get_ammo())
		. += "rocketlauncher_loaded"

/obj/item/gun/ballistic/rocketlauncher/suicide_act(mob/living/user)
	user.visible_message(span_warning("[user] 把 [src] 对准了地面！看来是想来一次帅气的火箭跳！"), \
		span_userdanger("你把 [src] 对准地面，准备来一次炫酷到爆的火箭跳……"))
	if(can_shoot())
		ADD_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src))
		playsound(src, 'sound/vehicles/rocketlaunch.ogg', 80, TRUE, 5)
		animate(user, pixel_z = 300, time = 30, flags = ANIMATION_RELATIVE, easing = LINEAR_EASING)
		sleep(7 SECONDS)
		animate(user, pixel_z = -300, time = 5, flags = ANIMATION_RELATIVE, easing = LINEAR_EASING)
		sleep(0.5 SECONDS)
		REMOVE_TRAIT(user, TRAIT_NO_TRANSFORM, REF(src))
		process_fire(user, user, TRUE)
		if(!QDELETED(user)) //if they weren't gibbed by the explosion, take care of them for good.
			user.gib(DROP_ALL_REMAINS)
		return MANUAL_SUICIDE
	else
		sleep(0.5 SECONDS)
		shoot_with_empty_chamber(user)
		sleep(2 SECONDS)
		user.visible_message(span_warning("[user] 环顾四周，意识到自己居然还在。于是把 [src] 塞进喉咙，用它把自己呛死了！"), \
			span_userdanger("你环顾四周，发现自己居然还在，于是把 [src] 塞进喉咙，把自己呛死了！"))
		sleep(2 SECONDS)
		return OXYLOSS

/obj/item/gun/ballistic/rocketlauncher/unrestricted/nanotrasen
	desc = "一支可重复使用的火箭推进榴弹发射器。枪管附近用笔写着“辛迪加往这边走”，还画了一个箭头。 \
	贴腮板旁贴着一张标签，写着“开火前确保后方区域无障碍”"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/rocketlauncher/empty
