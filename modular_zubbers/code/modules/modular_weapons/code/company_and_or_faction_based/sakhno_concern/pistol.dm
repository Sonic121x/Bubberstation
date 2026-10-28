#define PERCENT_DMG_DROP (-0.1) //How much damage is lost per tile, as a negative percentage of damage at time of firing.
#define LOADING_TIME (0.75 SECONDS) //How long it takes to load a cartridge, to prevent instant loading and firing again.

/obj/item/gun/ballistic/derringer
	name = "\improper 隐蔽德林加"
	desc = "一把非常紧凑的双管手枪，发射 .310 飞箭弹。 \
		尽管使用步枪弹药，但短枪管带来的弹道性能实在 \
		难以令人满意，而且弹道下坠极为严重。"
	icon = 'modular_zubbers/icons/obj/guns/sakhno_concern_guns32x.dmi'
	icon_state = "derringer"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	projectile_damage_multiplier = 0.75 //Drops damage to "45" from 60, for base .310 strikla
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/derringer
	fire_sound = 'sound/items/weapons/gun/revolver/shot_alt.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 65
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	rack_sound_volume = 0
	fire_delay = 3
	internal_magazine = TRUE
	casing_ejector = FALSE
	bolt_type = BOLT_TYPE_NO_BOLT

/obj/item/gun/ballistic/derringer/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0) //It's a derringer, damage drops off rather quickly so it's not used as a cheap pocket rifle.
	if(chambered.loaded_projectile)
		var/projectileDamage = chambered.loaded_projectile.damage
		var/projectileStamina = chambered.loaded_projectile.stamina
		//Damage fall-off is 10% of the projectile's total damage at firing, including the multiplier penalty. This allows it to travel slightly further than a screen's length.
		chambered.loaded_projectile.damage_falloff_tile = ((projectileDamage * projectile_damage_multiplier) * PERCENT_DMG_DROP)
		chambered.loaded_projectile.stamina_falloff_tile = ((projectileStamina * projectile_damage_multiplier) * PERCENT_DMG_DROP)

	. = ..()

/obj/item/gun/ballistic/derringer/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SAKHNO)

/obj/item/gun/ballistic/derringer/examine_more(mob/user)
	. = ..()

	. += "隐蔽德林加最初是作为萨赫诺步枪的随身副武器推向市场的， \
		让使用者拥有一件易于携带和隐藏的自卫武器，而无需 \
		随身备着好几种口径的弹药。虽然初期销量喜人，但其糟糕的 \
		远距离表现最终导致该型号停产。剩余库存大部分 \
		被清仓处理，如今在二手市场上价格相当实惠。 \
		与它们搭配销售的步枪不同，这些年来它们的状况要好得多。"

	return .

/obj/item/gun/ballistic/derringer/attackby(obj/item/A, mob/user, params) // Forced delay on loading derringer, only checks for valid ammo types/boxes though.
	if (is_type_in_list(A, list(/obj/item/ammo_casing/strilka310,
								/obj/item/ammo_box/c310_cargo_box,
								/obj/item/ammo_box/speedloader/strilka310)))
		if(!do_after(user, LOADING_TIME, src, IGNORE_USER_LOC_CHANGE)) // We are allowed to move while reloading.
			to_chat(user, span_danger("你未能将一发子弹上膛到 [src] 中！"))
			return TRUE

	. = ..()

#undef LOADING_TIME
#undef PERCENT_DMG_DROP
