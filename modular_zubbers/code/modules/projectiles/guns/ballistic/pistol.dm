/obj/item/gun/ballistic/automatic/pistol/ntusp
	name = "\improper NT22-HCS“执法者”"
	desc = "纳米传讯内部防御与安保计划出品的紧凑型硬光执法手枪。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "ntusp"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/ntusp
	can_suppress = TRUE
	bolt_type = BOLT_TYPE_LOCKING
	vary_fire_sound = FALSE
	fire_sound_volume = 80
	bolt_wording = "套筒"
	suppressor_x_offset = 0

/obj/item/gun/ballistic/automatic/pistol/ntusp/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)


/obj/item/gun/ballistic/automatic/pistol/ntusp/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以" + EXAMINE_HINT("仔细查看") + "来进一步了解[src]。"), \
		lore = "NT22-HCS 是纳米传讯军械部首次成功将硬光投射技术应用于可行的手枪形态。它被资产保护部人员非正式地称为“执法者”，在硬光应用研究建模计划下研发，专为资产保护部量身打造。<br>\
			<br>\
			NT22-HCS 不使用常规弹药，而是发射专有的 .22HL 无壳硬光弹；这些弹丸在击发的瞬间由插入弹匣井的纳米传讯专利高密度电池包合成。该武器不会产生弹壳，也不会留下可回收物质。<br>\
			<br>\
			.22HL 弹丸会被加速到相当高的速度，在命中点释放可观的动能，然后彻底消失，不会留下嵌入物。作为附带效果，弹丸终端速度产生的热能在接触部位造成疼痛的摩擦灼伤。<br>\
			<br>\
			NT22-HCS 是资产保护部在要员保护行动、出入管控与威胁清除中首选的近距离执法工具。它被归类为低致命武器。被 .22HL 击中的目标会出现剧烈疼痛反应、定向障碍以及自主运动功能丧失。操作指南建议将其用于对付口头威慑已经失效、又不值得升级为致命回应的不配合目标。<br>\
			<br>\
			关于 .22HL 累积暴露的长期数据仍相当有限，这是该技术过于新颖、且事后医疗报告流传受到极严格限制的结果。" \
	)

/obj/item/gun/ballistic/automatic/pistol/ntusp/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 15, \
		overlay_y = 13)

/obj/item/gun/ballistic/automatic/pistol/deagle/regal
	projectile_damage_multiplier = 1.0
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 30,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 25,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 11.5
	)
