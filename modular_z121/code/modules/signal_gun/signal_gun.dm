/obj/item/ammo_box/magazine/internal/shot/liberator
    name = "解放者内置弹管"
    ammo_type = /obj/item/ammo_casing/shotgun/buckshot
    caliber = CALIBER_SHOTGUN
    max_ammo = 1

/obj/item/gun/ballistic/shotgun/signal_gun
    name = "信号枪"
    desc = "可以发射12号霰弹的枪，但结构脆弱，只能使用一次。"
    icon = 'modular_z121/icons/obj/guns/signal_gun.dmi'
    icon_state = "signal_gun"
    lefthand_file = 'modular_z121/icons/mob/guns/signal_gun_lefthand.dmi'
    righthand_file = 'modular_z121/icons/mob/guns/signal_gun_righthand.dmi'
    inhand_icon_state = "signal_gun"
    inhand_x_dimension = 32
    inhand_y_dimension = 32
    custom_materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 2)
    bolt_type = BOLT_TYPE_NO_BOLT
    internal_magazine = TRUE
    casing_ejector = FALSE
    force = 10
    max_integrity = 100
    accepted_magazine_type = /obj/item/ammo_box/magazine/internal/shot/liberator
    can_suppress = FALSE
    semi_auto = FALSE
    show_bolt_icon = FALSE
    spread = 15
    projectile_damage_multiplier = 0.8
    var/open = FALSE
    w_class = WEIGHT_CLASS_SMALL
    slot_flags = NONE

/obj/item/gun/ballistic/shotgun/signal_gun/Initialize(mapload)
    . = ..()
    if(magazine)
        for(var/obj/item/ammo_casing/casing in magazine.stored_ammo)
            qdel(casing)
        magazine.stored_ammo.Cut()
    if(chambered)
        qdel(chambered)
        chambered = null
    open = FALSE
    update_appearance()

/obj/item/gun/ballistic/shotgun/signal_gun/update_overlays()
    . = ..()
    var/state = open ? "signal_gun_on" : "signal_gun_off"
    . += state

/obj/item/gun/ballistic/shotgun/signal_gun/attack_self(mob/living/user)
    if(open)
        open = FALSE
        if(magazine && magazine.ammo_count() > 0)
            chamber_round()
            to_chat(user, span_notice("你合上了[src]的枪膛，装入了一发霰弹。"))
        else
            to_chat(user, span_notice("你合上了[src]的枪膛，里面没有霰弹。"))
    else
        if(chambered)
            chambered.forceMove(drop_location())
            chambered = null
            to_chat(user, span_notice("你打开了[src]的枪膛，一发霰弹掉了出来。"))
        else
            to_chat(user, span_notice("你打开了[src]的枪膛。"))
        open = TRUE
    update_appearance()

/obj/item/gun/ballistic/shotgun/signal_gun/can_shoot()
    return !open && chambered?.loaded_projectile ? TRUE : FALSE

/obj/item/gun/ballistic/shotgun/signal_gun/load_gun(obj/item/ammo, mob/living/user)
    if(!open)
        to_chat(user, span_warning("必须打开枪膛才能给[src]装弹！"))
        return FALSE
    return ..()

/obj/item/gun/ballistic/shotgun/signal_gun/unload_ammo(mob/living/user, forced = FALSE)
    if(!open)
        to_chat(user, span_warning("必须打开枪膛才能给[src]退弹！"))
        return
    return ..()

/obj/item/gun/ballistic/shotgun/signal_gun/shoot_live_shot(mob/living/user, pointblank = FALSE, atom/pbtarget = null, message = TRUE)
    . = ..()
    if(!.)
        return
    new /obj/effect/decal/cleanable/plastic(get_turf(src))
    playsound(loc, /datum/sound_effect/shatter, 75, TRUE)
    visible_message(span_danger("[src]碎成了一地碎片！"))
    qdel(src)
