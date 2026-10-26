/obj/item/gun/magic/hook/contractor
	name = "SCORPION 抓钩"
	desc = "一种硬光抓钩，用于非致命地把目标拉近使用者。"
	icon = 'modular_skyrat/modules/contractor/icons/hook.dmi'
	icon_state = "hook_weapon"
	inhand_icon_state = "" //nah
	ammo_type = /obj/item/ammo_casing/magic/hook/contractor

/obj/item/ammo_casing/magic/hook/contractor
	projectile_type = /obj/projectile/hook/contractor

/obj/projectile/hook/contractor
	icon = 'modular_skyrat/modules/contractor/icons/hook_projectile.dmi'
	damage = 0
	stamina = 25
	chain_icon = 'modular_skyrat/modules/contractor/icons/hook_projectile.dmi'

/obj/item/gun/magic/hook/contractor/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(1))
		user.say("+给我过来！+", forced = "scorpion hook")
	return ..()
