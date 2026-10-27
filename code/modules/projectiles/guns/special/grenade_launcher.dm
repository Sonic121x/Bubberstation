/obj/item/gun/grenadelauncher
	name = "气动榴弹发射器"
	desc = "一件可怕、非常可怕的玩意。实在是太糟糕了！"
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "riotgun"
	inhand_icon_state = "riotgun"
	w_class = WEIGHT_CLASS_BULKY
	can_muzzle_flash = FALSE
	throw_speed = 2
	throw_range = 7
	force = 5
	var/list/grenades = new/list()
	var/max_grenades = 3
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)

/obj/item/gun/grenadelauncher/examine(mob/user)
	. = ..()
	. += "已装填 [grenades.len] / [max_grenades] 枚榴弹。"

/obj/item/gun/grenadelauncher/apply_fantasy_bonuses(bonus)
	. = ..()
	max_grenades = modify_fantasy_variable("max_syringes", max_grenades, bonus, minimum = 1)

/obj/item/gun/grenadelauncher/remove_fantasy_bonuses(bonus)
	max_grenades = reset_fantasy_variable("max_syringes", max_grenades)
	return ..()

/obj/item/gun/grenadelauncher/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!isgrenade(tool))
		return NONE
	if(istype(tool, /obj/item/grenade/c4))
		return NONE
	if(grenades.len == max_grenades)
		balloon_alert(user, "已经装满了！")
		return ITEM_INTERACT_BLOCKING
	if(!user.transferItemToLoc(tool, src))
		return ITEM_INTERACT_BLOCKING
	grenades += tool
	balloon_alert(user, "已装填 [grenades.len] / [max_grenades] 枚榴弹")
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/grenadelauncher/can_shoot()
	return grenades.len

/obj/item/gun/grenadelauncher/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	user.visible_message(span_danger("[user] 发射了一枚榴弹！"), \
						span_danger("你扣动了榴弹发射器！"))
	var/obj/item/grenade/F = grenades[1] //Now with less copypasta!
	grenades -= F
	F.forceMove(user.loc)
	F.throw_at(target, 30, 2, user)
	message_admins("[ADMIN_LOOKUPFLW(user)] 用榴弹发射器（[src]）从 [AREACOORD(user)] 朝 [target] [AREACOORD(target)] 发射了一枚榴弹（[F.name]）。")
	user.log_message("用榴弹发射器（[src]）从 [AREACOORD(user)] 朝 [target] [AREACOORD(target)] 发射了一枚榴弹（[F.name]）。", LOG_GAME)
	user.log_message("用榴弹发射器（[src]）从 [AREACOORD(user)] 朝 [target] [AREACOORD(target)] 发射了一枚榴弹（[F.name]）。", LOG_ATTACK, log_globally = FALSE)
	F.active = 1
	F.icon_state = initial(F.icon_state) + "_active"
	playsound(user.loc, 'sound/items/weapons/armbomb.ogg', 75, TRUE, -3)
	addtimer(CALLBACK(F, TYPE_PROC_REF(/obj/item/grenade, detonate)), 1.5 SECONDS)
	return TRUE
