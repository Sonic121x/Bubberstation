/obj/item/gun/ballistic/automatic/wt550
	can_suppress = FALSE
	can_be_sawn_off = TRUE
/obj/item/gun/ballistic/automatic/wt550/sawoff(mob/user)
	. = ..()
	if(.)
		desc = "你为什么要这么做"
		icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
		w_class = WEIGHT_CLASS_NORMAL
		spread = 10
		dual_wield_spread = 20
		recoil = SAWN_OFF_RECOIL
		update_appearance()

/obj/item/gun/ballistic/automatic/wt550/add_bayonet_point()
	return

/obj/item/gun/ballistic/automatic/wt550/Initialize(mapload)
	. = ..()
	if(type != /obj/item/gun/ballistic/automatic/wt550)
		return
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/wt550_burst, /datum/crafting_recipe/wt550_long)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/gun/ballistic/automatic/ntmp5
	burst_size = 1
	actions_types = list()
	name = "\improper NT22-HCS-MP“枪骑兵”"
	desc = "为持久非致命对抗而设计的硬光执法冲锋枪变体。其设计包含可伸缩枪托，便于隐藏。收起枪托后，其后坐力大到必须双手持握才能有效使用。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ntmp5.dmi'
	icon_state = "ntmp5"
	base_icon_state = "ntmp5"
	inhand_icon_state = "arg"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_MEDIUM
	slot_flags = ITEM_SLOT_BELT
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	bolt_type = BOLT_TYPE_STANDARD
	bolt_wording = "拉机柄"
	fire_delay = 0.15 SECONDS
	recoil = 1
	spread = 5
	mag_display = FALSE
	can_suppress = TRUE
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	spawn_magazine_type = /obj/item/ammo_box/magazine/recharge/ntmp5
	show_bolt_icon = FALSE
	var/stock_retracted = TRUE
	var/extended_icon_state = "ntmp5-stock"
	var/retracted_icon_state = "ntmp5"
	var/weapon_charge_overlay_state
	var/suppressor_overlay_state
	var/seclite_overlay_x = 25
	var/seclite_overlay_y = 11
	var/datum/component/automatic_fire/autofire_component

/obj/item/gun/ballistic/automatic/ntmp5/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/ntmp5/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_CTRL, PROC_REF(on_ctrl_click_stock_toggle))
	autofire_component = AddComponent(/datum/component/automatic_fire, fire_delay, allow_akimbo = FALSE)
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以" + EXAMINE_HINT("仔细查看") + "来进一步了解[src]。"), \
			lore = "NT22-HCS-MP 是 NT22-HCS 的改进型，又名“枪骑兵”，是一款为持久交战场景精炼的冲锋手枪。此变体专为需要对多个目标快速、反复施加作用的行动而设计，例如人群压制、通道封锁、防暴控制以及“劳资纠纷调解”。<br>\
			<br>\
			NT22-HCS-MP 完全兼容“执法者”的 .22HL 能量包，并整合了可支持持续自动射击的扩展能量循环架构。每发弹丸都实时合成。装填遵循简单流程，与熟悉传统弹道武器的人所习惯的方式一致：先拉开并锁定枪机，插入能量包，然后释放枪机，通常伴随着标志性的“一拍”。<br>\
			<br>\
			.22HL 弹丸会被加速到相当高的速度，在命中点释放可观的动能，随后瞬间消散，不会留下嵌入物。射速的提升以武器制造出的弹丸效能略有下降为代价。尽管如此，被 .22HL 命中的目标仍会承受剧烈的疼痛反应、力竭以及自主运动功能丧失。<br>\
			<br>\
			NT22-HCS-MP 配有可折叠枪托，能缩小其体积，使其可以被隐蔽地藏在夹克或背包下。操作指南建议将其用于对付口头威慑已经失效、又不值得升级为致命回应的不配合目标。尽管如此，关于 .22HL 累积暴露的长期数据仍然有限，这是事后报告流传受到特别严格限制的结果。" \
	)
	update_fire_delay_state()
	update_stock_state()

/obj/item/gun/ballistic/automatic/ntmp5/examine(mob/user)
	. = ..()
	. += span_notice("枪托当前处于[stock_retracted ? "收起" : "展开"]状态。按住 Ctrl 单击可切换。")

/obj/item/gun/ballistic/automatic/ntmp5/proc/on_ctrl_click_stock_toggle(datum/source, mob/user)
	SIGNAL_HANDLER
	stock_retracted = !stock_retracted
	balloon_alert(user, stock_retracted ? "枪托已收起" : "枪托已展开")
	playsound(src, 'sound/items/weapons/batonextend.ogg', 50, TRUE)
	update_stock_state()
	return CLICK_ACTION_SUCCESS
/obj/item/gun/ballistic/automatic/ntmp5/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = seclite_overlay_x, \
		overlay_y = seclite_overlay_y)

/obj/item/gun/ballistic/automatic/ntmp5/update_icon_state()
	base_icon_state = stock_retracted ? retracted_icon_state : extended_icon_state
	return ..()

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_overlay_states()
	weapon_charge_overlay_state = null
	suppressor_overlay_state = null

	if(magazine)
		var/current_ammo = magazine.ammo_count()
		if(current_ammo <= 0 || magazine.max_ammo <= 0)
			weapon_charge_overlay_state = "ntmp5-empty"
		else
			var/ammo_percent = current_ammo / magazine.max_ammo
			weapon_charge_overlay_state = "ntmp5-full"
			if(ammo_percent < 0.5)
				weapon_charge_overlay_state = "ntmp5-half"

	if(suppressed)
		suppressor_overlay_state = "ntmp5-suppressor"

/obj/item/gun/ballistic/automatic/ntmp5/proc/update_fire_delay_state()
	if(istype(magazine, /obj/item/ammo_box/magazine/recharge/ntmp5/laser) || magazine?.type == /obj/item/ammo_box/magazine/recharge/ntusp)
		fire_delay = 0.25 SECONDS
	else
		fire_delay = 0.15 SECONDS

	if(autofire_component)
		autofire_component.autofire_shot_delay = fire_delay

/obj/item/gun/ballistic/automatic/ntmp5/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(.)
		update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	. = ..()
	update_fire_delay_state()

/obj/item/gun/ballistic/automatic/ntmp5/update_overlays()
	var/previous_can_unsuppress = can_unsuppress
	can_unsuppress = FALSE
	. = ..()
	can_unsuppress = previous_can_unsuppress

	update_overlay_states()

	if(suppressor_overlay_state)
		. += suppressor_overlay_state
	if(weapon_charge_overlay_state)
		. += weapon_charge_overlay_state


/obj/item/gun/ballistic/automatic/ntmp5/proc/update_stock_state()
	if(stock_retracted)
		update_weight_class(WEIGHT_CLASS_NORMAL)
		weapon_weight = WEAPON_HEAVY
		recoil = 1
		spread = 12
	else
		update_weight_class(WEIGHT_CLASS_BULKY)
		weapon_weight = WEAPON_MEDIUM
		recoil = 0
		spread = 5
	update_appearance()

/obj/item/gun/ballistic/automatic/wt550
	desc = "作为一款发射 4.6x30mm 弹药的安保全自动枪械，WT550 最初因辛迪加的一场虚假信息宣传而被召回，那场宣传 \
		试图迫使纳米传讯放弃其弹道枪械项目。尽管那是假的，550 至今仍 \
		在箱子里附赠一张“99% 消除紊乱保证”贴纸出售。"
/obj/item/gun/ballistic/automatic/wt550/burst
	name = "\improper WT-550-B 自动点射步枪"
	desc = "它算不上真正的步枪，改装后更接近冲锋枪，但体积却依旧同样笨重。配有改装机匣与枪管，以及两发点射扳机机构。整体表现优于普通自动步枪，但后坐力稍大。枪管带螺纹，可安装消音器。使用 4.6x30mm 弹药。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "wt550b"
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	can_suppress = TRUE
	can_be_sawn_off = FALSE
	suppressor_x_offset = 4
	spread = 3
	recoil = 0.25
	burst_delay = 1
	burst_size = 2
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3
	)

/obj/item/gun/ballistic/automatic/wt550/burst/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.5 SECONDS)

/obj/item/gun/ballistic/automatic/wt550/burst/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 17, \
		overlay_y = 9)

/obj/item/gun/ballistic/automatic/wt550/dmr
	name = "\improper WT-550-C 自动步枪"
	desc = "射程更远的 WT-550，使用售后套件与零件组装而成。配备最长的枪管与定制扳机，以提升远距离表现。装有定制瞄准镜，枪管带螺纹可安装消音器。使用 4.6x30mm 弹药。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/wide_guns.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	worn_icon_state = "gun"
	fire_sound = 'modular_zubbers/sound/weapons/gun/wt551/shot.ogg'
	weapon_weight = WEAPON_HEAVY
	can_suppress = TRUE
	can_be_sawn_off = FALSE
	suppressor_x_offset = 6
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 1.50 // 30 damage base + wounding at half the firerate
	projectile_speed_multiplier = 1.50
	projectile_wound_bonus = 5
	burst_delay = 6
	burst_size = 1
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 8.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3
	)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/wt550/dmr/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.6 SECONDS)
	AddComponent(/datum/component/scope, range_modifier = 2.0)

/obj/item/gun/ballistic/automatic/battle_rifle_basic
	name = "\improper .38 战斗步枪"
	desc = "纳米传讯最新原型长枪的低技术替代版本，为不喜欢 NT-38 的人提供了另一种选择。 \
		尽管名字如此、也被当作战斗步枪使用，严格来说它是一把发射手枪弹的卡宾枪。 \
		舍弃先进的电子设备与集成技术优势，反而让它运行得无限可靠。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/wide_guns.dmi'
	icon_state = "battle_rifle"
	lefthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_zubbers/icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "battle_rifle"
	worn_icon = 'icons/mob/clothing/back.dmi'
	worn_icon_state = "battle_rifle"
	slot_flags = ITEM_SLOT_BACK

	weapon_weight = WEAPON_HEAVY
	accepted_magazine_type = /obj/item/ammo_box/magazine/m38
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	mag_display = TRUE
	empty_indicator = TRUE
	fire_delay = 1.5 DECISECONDS
	burst_size = 1
	actions_types = list()
	fire_sound = 'sound/items/weapons/thermalpistol.ogg'
	suppressor_x_offset = 0

	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
	)

	SET_BASE_PIXEL(-8, 0)

/obj/item/gun/ballistic/automatic/battle_rifle_basic/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 26, \
		overlay_y = 10)
