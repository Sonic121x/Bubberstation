//Recharge subtype - used by stuff like protokinetic accelerators and ebows, one shot at a time, recharges.
/obj/item/gun/energy/recharge
	icon_state = "kineticgun"
	base_icon_state = "kineticgun"
	desc = "一把自行充能的枪。每次只能装一发。"
	automatic_charge_overlays = FALSE
	cell_type = /obj/item/stock_parts/power_store/cell/emproof
	/// If set to something, instead of an overlay, sets the icon_state directly.
	var/no_charge_state
	/// Does it hold charge when not put away?
	var/holds_charge = FALSE
	/// How much time we need to recharge
	var/recharge_time = 1.6 SECONDS
	/// Sound we use when recharged
	var/recharge_sound = 'sound/items/weapons/kinetic_reload.ogg'
	/// An ID for our recharging timer.
	var/recharge_timerid
	/// Do we recharge slower with more of our type?
	var/unique_frequency = FALSE

/obj/item/gun/energy/recharge/apply_fantasy_bonuses(bonus)
	. = ..()
	recharge_time = modify_fantasy_variable("recharge_time", recharge_time, -bonus, minimum = 0.2 SECONDS)

/obj/item/gun/energy/recharge/remove_fantasy_bonuses(bonus)
	recharge_time = reset_fantasy_variable("recharge_time", recharge_time)
	return ..()

/obj/item/gun/energy/recharge/Initialize(mapload)
	. = ..()
	if(!holds_charge)
		empty()
	AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)

/obj/item/gun/energy/recharge/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	. = ..()
	attempt_reload()

/obj/item/gun/energy/recharge/equipped(mob/user)
	. = ..()
	if(!can_shoot())
		attempt_reload()

/obj/item/gun/energy/recharge/dropped()
	. = ..()
	if(!QDELING(src) && !holds_charge)
		// Put it on a delay because moving item from slot to hand
		// calls dropped().
		addtimer(CALLBACK(src, PROC_REF(empty_if_not_held)), 0.1 SECONDS)

/obj/item/gun/energy/recharge/handle_chamber()
	. = ..()
	attempt_reload()

/obj/item/gun/energy/recharge/proc/empty_if_not_held()
	if(!ismob(loc))
		empty()
		deltimer(recharge_timerid)

/obj/item/gun/energy/recharge/proc/empty()
	if(cell)
		cell.use(cell.charge)
	update_appearance()

/obj/item/gun/energy/recharge/proc/attempt_reload(set_recharge_time)
	if(!cell)
		return
	if(cell.charge == cell.maxcharge)
		return
	if(!set_recharge_time)
		set_recharge_time = recharge_time
	var/carried = 0
	if(!unique_frequency)
		for(var/obj/item/gun/energy/recharge/recharging_gun in loc.get_all_contents())
			if(recharging_gun.type != type || recharging_gun.unique_frequency)
				continue
			carried++
	carried = max(carried, 1)
	deltimer(recharge_timerid)
	recharge_timerid = addtimer(CALLBACK(src, PROC_REF(reload)), set_recharge_time * carried, TIMER_STOPPABLE)

/obj/item/gun/energy/recharge/proc/reload()
	cell.give(cell.maxcharge)
	if(!suppressed && recharge_sound)
		playsound(src.loc, recharge_sound, 60, TRUE)
	else
		to_chat(loc, span_warning("[src] 悄无声息地充能完毕。"))
	update_appearance()

/obj/item/gun/energy/recharge/update_overlays()
	. = ..()
	if(!no_charge_state && !can_shoot())
		. += "[base_icon_state]_empty"

/obj/item/gun/energy/recharge/update_icon_state()
	. = ..()
	if(no_charge_state)
		if(can_shoot())
			icon_state = base_icon_state
		else
			icon_state = no_charge_state

/obj/item/gun/energy/recharge/ebow
	name = "迷你能量弩"
	desc = "辛迪加潜行专家钟爱的武器。"
	icon_state = "crossbow"
	base_icon_state = "crossbow"
	inhand_icon_state = "crossbow"
	no_charge_state = "crossbow_empty"
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	suppressed = SUPPRESSED_QUIET
	ammo_type = list(/obj/item/ammo_casing/energy/bolt)
	recharge_time = 2 SECONDS
	holds_charge = TRUE
	unique_frequency = TRUE

/obj/item/gun/energy/recharge/ebow/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 20, offset_y = 12)

/obj/item/gun/energy/recharge/ebow/halloween
	name = "玉米糖弩"
	desc = "辛迪加“不给糖就捣蛋”爱好者钟爱的武器。"
	icon_state = "crossbow_halloween"
	base_icon_state = "crossbow_halloween"
	no_charge_state = "crossbow_halloween_empty"
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/halloween)

/obj/item/gun/energy/recharge/ebow/large
	name = "能量弩"
	desc = "逆向工程自辛迪加技术的武器。"
	icon_state = "crossbowlarge"
	base_icon_state = "crossbowlarge"
	no_charge_state = "crossbowlarge_empty"
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	suppressed = SUPPRESSED_NONE
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/large)

/// A silly gun that does literally zero damage, but disrupts electrical sources of light, like flashlights.
/obj/item/gun/energy/recharge/fisher
	name = "\improper SC/FISHER 干扰枪"
	desc = "一把自行充能、一体式消音、经过改装的动能加速器，不造成任何伤害，\
		但会干扰灯具、区域供电控制器和安保摄像头等电子设备。\
		充能一次可射击两次。\
		弹丸可以绕过机械射击，但精确射中灯具需要一双巧手。"
	icon_state = "fisher"
	base_icon_state = "fisher"
	dry_fire_sound_volume = 10
	w_class = WEIGHT_CLASS_SMALL
	holds_charge = TRUE
	suppressed = SUPPRESSED_QUIET
	recharge_time = 1.2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/fisher)

/obj/item/gun/energy/recharge/fisher/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore = "SC/FISHER 是一把非法改装的动能加速器，被截短并重新装配进一个微型能量枪\
			机匣，专门用于实施短暂而有效的电子战。<br>\
			<br>\
			SC/FISHER 功能的核心——经过重新设计的动能加速器——经过改装，使其动能弹丸能够\
			<b>暂时干扰手电筒、摄像头、区域供电控制器和个人 AI 语音模块</b>，代价是不造成任何伤害。\
			用 SC/FISHER 近身击打或投掷命中目标时，该效果持续时间更长，但\
			你大概不该把它往人身上扔。<br>\
			<br>\
			有人会说，为了一招干扰灯光、打坏灯具的花哨功能而牺牲伤害，\
			让 SC/FISHER 成了装备研发上的死胡同；但也有人认为，能对着光源和烦人的个人 AI\
			射击以干扰其功能，既有趣又符合战术。<br>\
			<br>\
			买家自慎。" \
	)

/obj/item/gun/energy/recharge/fisher/attack(mob/living/target_mob, mob/living/user, list/modifiers, list/attack_modifiers)
	. = ..()
	if(.)
		return
	var/obj/projectile/energy/fisher/melee/simulated_hit = new
	simulated_hit.firer = user
	simulated_hit.on_hit(target_mob)

/obj/item/gun/energy/recharge/fisher/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	// ...you reeeeeally just shoot them, but in case you can't/won't
	. = ..()
	var/obj/projectile/energy/fisher/melee/simulated_hit = new
	simulated_hit.firer = throwingdatum?.get_thrower()
	simulated_hit.on_hit(hit_atom)
