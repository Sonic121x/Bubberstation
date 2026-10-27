/obj/item/gun/ballistic/automatic
	abstract_type = /obj/item/gun/ballistic/automatic
	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = TRUE
	burst_size = 3
	burst_delay = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	semi_auto = TRUE
	fire_sound = 'sound/items/weapons/gun/smg/shot.ogg'
	fire_sound_volume = 90
	rack_sound = 'sound/items/weapons/gun/smg/smgrack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/smg/shot_suppressed.ogg'
	burst_fire_selection = TRUE
	drop_sound = 'sound/items/handling/gun/ballistics/smg/smg_drop1.ogg'
	pickup_sound = 'sound/items/handling/gun/ballistics/smg/smg_pickup1.ogg'

/obj/item/gun/ballistic/automatic/proto
	name = "\improper 纳米传讯军刀冲锋枪"
	desc = "一款原型全自动 9mm 冲锋枪，代号“SABR”。枪管带螺纹，可安装消音器。"
	icon_state = "saber"
	burst_size = 1
	actions_types = list()
	mag_display = TRUE
	empty_indicator = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm9mm
	pin = null
	bolt_type = BOLT_TYPE_LOCKING
	show_bolt_icon = FALSE

/obj/item/gun/ballistic/automatic/proto/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/proto/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/c20r
	name = "\improper C-20r 冲锋枪"
	desc = "一款无托式三发点射 .45 冲锋枪，代号“C-20r”。枪托上印着“斯卡伯勒军火公司——Per falcis, per pravitas”的铭文。"
	icon_state = "c20r"
	inhand_icon_state = "c20r"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/smgm45
	burst_delay = 2
	burst_size = 3
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/gun/ballistic/automatic/c20r/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 26, offset_y = 12)

/obj/item/gun/ballistic/automatic/c20r/update_overlays()
	. = ..()
	if(!chambered && empty_indicator) //this is duplicated due to a layering issue with the select fire icon.
		. += "[icon_state]_empty"

/obj/item/gun/ballistic/automatic/c20r/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/c20r/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/automatic/wt550
	name = "\improper WT-550 自动步枪"
	desc = "因散热问题会导致意外失能而引发公众反弹，纳米传讯将其召回。 \
		但这场声讨其实是辛迪加支持的一系列虚假信息行动炮制出来的，目的是迫使纳米传讯放弃 \
		它的弹道武器计划，把它逼进能量武器市场。如今它最常出现在海盗、 \
		经费不足的安保人员、货运技师、理论物理学家，以及边区黑帮分子手里。 \
		轻量且全自动。使用 4.6x30mm 弹药。"
	icon_state = "wt550"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	accepted_magazine_type = /obj/item/ammo_box/magazine/wt550m9
	burst_delay = 2
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/gun/ballistic/automatic/wt550/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.3 SECONDS)

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 25, offset_y = 12)

/obj/item/gun/ballistic/automatic/smartgun
	name = "\improper 阿比耶尔智能冲锋枪"
	desc = "一项关于智能武器技术的早期实验，能让子弹追踪开火时枪支所瞄准的目标。 \
		虽然追踪功能运作良好，但由于它几乎没有枪管，散布大得离谱。"
	icon_state = "smartgun"
	inhand_icon_state = "smartgun"
	accepted_magazine_type = /obj/item/ammo_box/magazine/smartgun
	burst_size = 4
	burst_delay = 1
	spread = 40
	dual_wield_spread = 20
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	can_suppress = FALSE
	mag_display = TRUE
	empty_indicator = TRUE
	click_on_low_ammo = FALSE
	/// List of the possible firing sounds
	var/list/firing_sound_list = list(
		'sound/items/weapons/gun/smartgun/smartgun_shoot_1.ogg',
		'sound/items/weapons/gun/smartgun/smartgun_shoot_2.ogg',
		'sound/items/weapons/gun/smartgun/smartgun_shoot_3.ogg',
	)

/obj/item/gun/ballistic/automatic/smartgun/fire_sounds()
	var/picked_fire_sound = pick(firing_sound_list)
	playsound(src, picked_fire_sound, fire_sound_volume, vary_fire_sound)

/obj/item/gun/ballistic/automatic/mini_uzi
	name = "\improper U3 型乌兹冲锋枪"
	desc = "一款轻量化的点射冲锋枪，适合你真的很想让某个人死的时候。使用 9mm 弹药。"
	icon_state = "miniuzi"
	accepted_magazine_type = /obj/item/ammo_box/magazine/uzim9mm
	burst_size = 2
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/items/weapons/gun/pistol/slide_lock.ogg'

/**
 * Weak uzi for syndicate chimps. It comes in a 4 TC kit.
 * Roughly 9 damage per bullet every 0.2 seconds, equaling out to downing an opponent in a bit over a second, if they have no armor.
 */
/obj/item/gun/ballistic/automatic/mini_uzi/chimpgun
	name = "\improper MONK-10"
	desc = "由辛迪加猴子为辛迪加猴子研发。尽管名字如此，这把武器看起来远比 MAC-10 更像乌兹。使用 9mm 弹药。枪身另一侧贴着一张标签，上面写着“干点天性使然的事吧”。"
	projectile_damage_multiplier = 0.4
	projectile_wound_bonus = -25
	pin = /obj/item/firing_pin/monkey

/obj/item/gun/ballistic/automatic/m90
	name = "\improper M-90gl 卡宾枪"
	desc = "一款三发点射的 .223 顶装式卡宾枪，代号“M-90gl”。下挂一具榴弹发射器。"
	desc_controls = "右键使用榴弹发射器。"
	icon_state = "m90"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "m90"
	selector_switch_icon = TRUE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m223
	can_suppress = FALSE
	burst_size = 3
	burst_delay = 2
	spread = 5
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/items/weapons/gun/smg/shot_alt.ogg'
	/// Attached underbarrel grenade launcher
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel/underbarrel

/obj/item/gun/ballistic/automatic/m90/Initialize(mapload)
	. = ..()
	underbarrel = new(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/m90/Destroy()
	QDEL_NULL(underbarrel)
	return ..()

/obj/item/gun/ballistic/automatic/m90/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/m90/unrestricted/Initialize(mapload)
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/m90/try_fire_gun(atom/target, mob/living/user, params)
	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		return underbarrel.try_fire_gun(target, user, params)
	return ..()

/obj/item/gun/ballistic/automatic/m90/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(isammocasing(tool))
		if(istype(tool, underbarrel.magazine.ammo_type))
			underbarrel.item_interaction(user, tool, modifiers)
		return ITEM_INTERACT_BLOCKING
	return ..()

/obj/item/gun/ballistic/automatic/tommygun
	name = "\improper 汤普森冲锋枪"
	desc = "基于经典的“芝加哥打字机”。"
	icon_state = "tommygun"
	inhand_icon_state = "shotgun"
	selector_switch_icon = TRUE
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/tommygunm45
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	burst_delay = 1
	bolt_type = BOLT_TYPE_OPEN
	empty_indicator = TRUE
	show_bolt_icon = FALSE
	/// Rate of fire, set on initialize only
	var/rof = 0.1 SECONDS

/obj/item/gun/ballistic/automatic/tommygun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, rof)

/**
 * Weak tommygun for syndicate chimps. It comes in a 4 TC kit.
 * Roughly 9 damage per bullet every 0.2 seconds, equaling out to downing an opponent in a bit over a second, if they have no armor.
 */
/obj/item/gun/ballistic/automatic/tommygun/chimpgun
	name = "\improper 打字机"
	desc = "那是最美好的时代，那是最 BLURST 的时代！？你们这群蠢猴子！"
	burst_delay = 2
	rof = 0.2 SECONDS
	projectile_damage_multiplier = 0.4
	projectile_wound_bonus = -25
	pin = /obj/item/firing_pin/monkey

/obj/item/gun/ballistic/automatic/ar
	name = "\improper NT-ARG“登舰者”"
	desc = "纳米传讯战斗部队使用的坚固突击步枪。"
	icon_state = "arg"
	inhand_icon_state = "arg"
	slot_flags = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/m223
	can_suppress = FALSE
	burst_size = 3
	burst_delay = 1

// L6 SAW //

/obj/item/gun/ballistic/automatic/l6_saw
	name = "\improper L6 SAW"
	desc = "一款经过大量改装的 7mm 轻机枪，代号“L6 SAW”。机匣上代号下方刻有“奥赛克军械公司——2531”。"
	icon_state = "l6"
	inhand_icon_state = "l6closedmag"
	base_icon_state = "l6"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	accepted_magazine_type = /obj/item/ammo_box/magazine/m7mm
	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	actions_types = list()
	can_suppress = FALSE
	spread = 7
	pin = /obj/item/firing_pin/implant/pindicate
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	tac_reloads = FALSE
	fire_sound = 'sound/items/weapons/gun/l6/shot.ogg'
	rack_sound = 'sound/items/weapons/gun/l6/l6_rack.ogg'
	suppressed_sound = 'sound/items/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/cover_open = FALSE

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/l6_saw/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/l6_saw/examine(mob/user)
	. = ..()
	. += "<b>Alt + 点击</b>以[cover_open ? "关上" : "打开"]防尘盖。"
	if(cover_open && magazine)
		. += span_notice("看起来你可以用<b>空着的手</b>取下弹匣。")


/obj/item/gun/ballistic/automatic/l6_saw/click_alt(mob/user)
	cover_open = !cover_open
	balloon_alert(user, "防尘盖已[cover_open ? "打开" : "关上"]")
	playsound(src, 'sound/items/weapons/gun/l6/l6_door.ogg', 60, TRUE)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/gun/ballistic/automatic/l6_saw/update_icon_state()
	. = ..()
	inhand_icon_state = "[base_icon_state][cover_open ? "open" : "closed"][magazine ? "mag":"nomag"]"

/obj/item/gun/ballistic/automatic/l6_saw/update_overlays()
	. = ..()
	. += "l6_door_[cover_open ? "open" : "closed"]"


/obj/item/gun/ballistic/automatic/l6_saw/try_fire_gun(atom/target, mob/living/user, params)
	if(cover_open)
		balloon_alert(user, "先把防尘盖关上！")
		return FALSE

	. = ..()
	if(.)
		update_appearance()
	return .

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/ballistic/automatic/l6_saw/attack_hand(mob/user, list/modifiers)
	if (loc != user)
		..()
		return
	if (!cover_open)
		balloon_alert(user, "先把防尘盖打开！")
		return
	..()

/obj/item/gun/ballistic/automatic/l6_saw/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!cover_open && istype(tool, accepted_magazine_type))
		balloon_alert(user, "先把防尘盖打开！")
		return ITEM_INTERACT_BLOCKING
	return ..()

// Laser rifle (rechargeable magazine) //

/obj/item/gun/ballistic/automatic/laser
	name = "激光步枪"
	desc = "尽管能量武器的火力相对较弱、有时会遭人嘲笑，但可充电弹药带来的后勤奇迹，让纳米传讯在许多敌人面前占尽优势。"
	icon_state = "oldrifle"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge
	empty_indicator = TRUE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 2 DECISECONDS
	can_suppress = FALSE
	burst_size = 0
	actions_types = list()
	fire_sound = 'sound/items/weapons/laser.ogg'
	casing_ejector = FALSE

// NT Battle Rifle //

/obj/item/gun/ballistic/automatic/battle_rifle
	name = "\improper NT BR-38 战斗步枪"
	desc = "纳米传讯最新式的 .38 特种长枪原型，仅配发给其私人安保队伍。 \
		严格来说它是一支手枪弹口径的卡宾枪，尽管名字和用途都把它当精确射手步枪。加速技术 \
		提升了弹道性能，但也带来了维护负担。"
	icon = 'icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "battle_rifle"
	inhand_icon_state = "battle_rifle"
	base_icon_state = "battle_rifle"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "battle_rifle"
	slot_flags = ITEM_SLOT_BACK

	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/m38
	w_class = WEIGHT_CLASS_BULKY
	force = 15 //this thing is kind of oversized, okay?
	mag_display = TRUE
	projectile_damage_multiplier = 1.2
	projectile_speed_multiplier = 1.2
	fire_delay = 2 DECISECONDS
	burst_size = 1
	actions_types = list()
	fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	suppressor_x_offset = 0

	/// Determines how many shots we can make before the weapon needs to be maintained.
	var/shots_before_degradation = 10
	/// The max number of allowed shots this gun can have before degradation.
	var/max_shots_before_degradation = 10
	/// Determines the degradation stage. The higher the value, the more poorly the weapon performs.
	var/degradation_stage = 0
	/// Maximum degradation stage.
	var/degradation_stage_max = 5
	/// The probability of degradation increasing per shot.
	var/degradation_probability = 10
	/// The maximum speed malus for projectile flight speed. Projectiles probably shouldn't move too slowly or else they will start to cause problems.
	var/maximum_speed_malus = 0.7
	/// What is our damage multiplier if the gun is emagged?
	var/emagged_projectile_damage_multiplier = 1.6

	/// Whether or not our gun is suffering an EMP related malfunction.
	var/emp_malfunction = FALSE

	/// Our timer for when our gun is suffering an extreme malfunction. AKA it is going to explode
	var/explosion_timer

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/battle_rifle/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 2)
	AddElement(/datum/element/examine_lore, \
		lore = "BR-38 是纳米传讯最新一款完全自研、可直接列装、带加速辅助的弹道枪械。<br>\
		<br>\
		集成在枪管组件中的加速导轨能把射出的弹丸推到比无辅助子弹更高的速度， \
		让即使 .38 特种这样老而威力偏弱的弹药也能获得更好的弹道性能与停止作用。 \
		尽管这样的膛室设计让它更像一支手枪弹口径的卡宾枪，而不是战斗步枪，但市场部和 \
		董事会议室里围绕名字的无数争论终究得有一方让步；最终让步的，是这个略显误导的代号。<br>\
		<br>\
		不过，它坎坷的研发经历并非全都能遮掩过去。<br>\
		<br>\
		讽刺的是，纳米传讯在弹道安保武器上历来多有麻烦，而 BR-38 也有一个重大缺陷。 \
		若武器被非法改装，其封闭式散热系统可能让武器系统出现意料之外的失能。 \
		纳米传讯的武器研发团队仍在处理这个问题，同时还在设法弄清为什么该武器的板载计算系统 \
		会出现如此多的计算错误，之后才能推进全面商业化。" \
	)
	register_context()

/obj/item/gun/ballistic/automatic/battle_rifle/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(held_item?.tool_behaviour == TOOL_MULTITOOL && shots_before_degradation < max_shots_before_degradation)
		context[SCREENTIP_CONTEXT_LMB] = "重置系统"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/gun/ballistic/automatic/battle_rifle/examine(mob/user)
	. = ..()
	if(shots_before_degradation)
		. += span_notice("[src] 还能再射击 [shots_before_degradation] 次，之后就可能出现系统退化。")
	else
		. += span_notice("[src] 正处于系统退化过程中。目前处于第 [degradation_stage] 阶段，共 [degradation_stage_max] 阶段。用多功能工具对 [src] 重新校准。或者把它放进武器充电器。")
	. += span_notice("你可以[EXAMINE_HINT("仔细查看")]来多了解一点 [src] 的情况。")



/obj/item/gun/ballistic/automatic/battle_rifle/update_icon_state()
	. = ..()
	if(!shots_before_degradation)
		inhand_icon_state = "[base_icon_state]-empty"
	else
		inhand_icon_state = "[base_icon_state]"

/obj/item/gun/ballistic/automatic/battle_rifle/update_overlays()
	. = ..()
	if(degradation_stage)
		. += "[base_icon_state]_empty"
	else if(shots_before_degradation)
		var/ratio_for_overlay = CEILING(clamp(shots_before_degradation / max_shots_before_degradation, 0, 1) * 3, 1)
		. += "[icon_state]_stage_[ratio_for_overlay]"

/obj/item/gun/ballistic/automatic/battle_rifle/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF) && prob(50 / severity))
		shots_before_degradation = 0
		emp_malfunction = TRUE
		attempt_degradation(TRUE)

/obj/item/gun/ballistic/automatic/battle_rifle/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	projectile_damage_multiplier = emagged_projectile_damage_multiplier
	balloon_alert(user, "散热系统已关闭")
	return TRUE

/obj/item/gun/ballistic/automatic/battle_rifle/multitool_act(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 20 SECONDS, volume = 50))
		balloon_alert(user, "被打断了！")
		return ITEM_INTERACT_BLOCKING

	emp_malfunction = FALSE
	shots_before_degradation = initial(shots_before_degradation)
	degradation_stage = initial(degradation_stage)
	projectile_speed_multiplier = initial(projectile_speed_multiplier)
	fire_delay = initial(fire_delay)
	update_appearance()
	balloon_alert(user, "系统已重置")
	return ITEM_INTERACT_SUCCESS

/obj/item/gun/ballistic/automatic/battle_rifle/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(chambered.loaded_projectile && prob(75) && (emp_malfunction || degradation_stage == degradation_stage_max))
		balloon_alert_to_hearers("*咔嗒*")
		playsound(src, dry_fire_sound, dry_fire_sound_volume, TRUE)
		return

	. = ..()
	if(!.)
		return

	else if(shots_before_degradation)
		shots_before_degradation --

	else if ((obj_flags & EMAGGED) && degradation_stage == degradation_stage_max && !explosion_timer)
		perform_extreme_malfunction(user)

	else
		attempt_degradation(FALSE)

/// Proc to handle weapon degradation. Called when attempting to fire or immediately after an EMP takes place.
/obj/item/gun/ballistic/automatic/battle_rifle/proc/attempt_degradation(force_increment = FALSE)
	if(!prob(degradation_probability) && !force_increment || degradation_stage == degradation_stage_max)
		return //Only update if we actually increment our degradation stage

	degradation_stage = clamp(degradation_stage + (obj_flags & EMAGGED ? 2 : 1), 0, degradation_stage_max)
	projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) + degradation_stage * 0.1, initial(projectile_speed_multiplier), maximum_speed_malus)
	fire_delay = initial(fire_delay) + (degradation_stage * 0.5)
	do_sparks(1, TRUE, src)
	update_appearance()

/// Called by /obj/machinery/recharger while inserted: attempts to recalibrate our gun but reducing degradation.
/obj/item/gun/ballistic/automatic/battle_rifle/proc/attempt_recalibration(restoring_shots_before_degradation = FALSE, recharge_rate = 1)
	emp_malfunction = FALSE

	if(restoring_shots_before_degradation)
		shots_before_degradation = clamp(round(shots_before_degradation + recharge_rate, 1), 0, max_shots_before_degradation)

	else
		degradation_stage = clamp(degradation_stage - 1, 0, degradation_stage_max)
		if(degradation_stage)
			projectile_speed_multiplier = clamp(initial(projectile_speed_multiplier) - degradation_stage * 0.1, maximum_speed_malus, initial(projectile_speed_multiplier))
			fire_delay = initial(fire_delay) + (degradation_stage * 0.5)
		else
			projectile_speed_multiplier = initial(projectile_speed_multiplier)
			fire_delay = initial(fire_delay)

	update_appearance()

/// Proc to handle the countdown for our detonation
/obj/item/gun/ballistic/automatic/battle_rifle/proc/perform_extreme_malfunction(mob/living/user)
	balloon_alert(user, "枪要炸了，快扔掉！")
	explosion_timer = addtimer(CALLBACK(src, PROC_REF(fucking_explodes_you)), 5 SECONDS, (TIMER_UNIQUE|TIMER_OVERRIDE))
	playsound(src, 'sound/items/weapons/gun/general/empty_alarm.ogg', 50, FALSE)

/// proc to handle our detonation
/obj/item/gun/ballistic/automatic/battle_rifle/proc/fucking_explodes_you()
	explosion(src, devastation_range = 1, heavy_impact_range = 3, light_impact_range = 6, explosion_cause = src)

//component for seclight attachment
/obj/item/gun/ballistic/automatic/battle_rifle/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 28, \
		overlay_y = 12)
