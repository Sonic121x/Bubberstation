// Base medigun code
/obj/item/gun/energy/cell_loaded/medigun
	name = "医疗枪"
	desc = "这是我的智能枪，它不会伤害任何友方，反而会治疗他们！如果你不知怎么拿到了这把枪，请上报 github。"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi'
	icon_state = "medigun"
	inhand_icon_state = "chronogun" // Fits best with how the medigun looks, might be changed in the future
	ammo_type = list(/obj/item/ammo_casing/energy/medical) // The default option that heals oxygen
	w_class = WEIGHT_CLASS_NORMAL
	cell_type = /obj/item/stock_parts/power_store/cell/medigun
	modifystate = 1
	ammo_x_offset = 3
	charge_sections = 3
	maxcells = 3
	allowed_cells = list(/obj/item/weaponcell/medical)
	item_flags = null
	gun_flags = TURRET_INCOMPATIBLE

// Standard medigun - this is what you will get from Cargo, most likely.
/obj/item/gun/energy/cell_loaded/medigun/standard
	name = "VeyMedical CWM-479 电池驱动医疗枪"
	desc = "这是由 Vey-Med 生产的标准型医疗枪，用于在不理想的环境下进行治疗。其医疗电池舱额定可容纳三块电池。"

// Upgraded medigun
/obj/item/gun/energy/cell_loaded/medigun/upgraded
	name = "VeyMedical CWM-479-FC 电池驱动医疗枪"
	desc = "这是标准型 CWM-479 医疗枪的升级版。虽然仍只能容纳三块电池，但其电池已升级为更高容量和更快充电速度。"
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/upgraded

/obj/item/gun/energy/cell_loaded/medigun/upgraded/Initialize(mapload)
	. = ..()
	var/mutable_appearance/fastcharge_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_fastcharge")
	add_overlay(fastcharge_medigun)

// CMO and CC MediGun
/obj/item/gun/energy/cell_loaded/medigun/cmo
	name = "VeyMedical CWM-479-CC 电池驱动医疗枪"
	desc = "CWM-479 系列医疗枪中最先进的版本，配备六个电池槽和一块自动充电电池。"
	cell_type = /obj/item/stock_parts/power_store/cell/medigun/experimental
	maxcells = 6
	selfcharge = 1
	can_charge = FALSE

/obj/item/gun/energy/cell_loaded/medigun/cmo/Initialize(mapload)
	. = ..()
	var/mutable_appearance/cmo_medigun = mutable_appearance('modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/projectile.dmi', "medigun_cmo")
	add_overlay(cmo_medigun)

// Medigun power cells
/obj/item/stock_parts/power_store/cell/medigun // This is the cell that mediguns from cargo will come with
	name = "基础医疗枪电池"
	maxcharge = STANDARD_CELL_CHARGE
	chargerate = STANDARD_CELL_CHARGE * 0.03

/obj/item/stock_parts/power_store/cell/medigun/upgraded
	name = "升级型医疗枪电池"
	maxcharge = STANDARD_CELL_CHARGE * 1.4
	chargerate = STANDARD_CELL_CHARGE * 0.06

/obj/item/stock_parts/power_store/cell/medigun/experimental // This cell type is meant to be used in self charging mediguns like CMO and ERT one.
	name = "实验型医疗枪电池"
	maxcharge = 1.8 * STANDARD_CELL_CHARGE
	chargerate = 0.1 * STANDARD_CELL_CHARGE
// End of power cells

// Upgrade Kit
/obj/item/custom_kit/medigun_fastcharge
	name = "VeyMedical CWM-479 升级套件"
	desc = "升级医疗枪内部的电池，使其充电更快、电池容量更高。需要先取出医疗枪内的电池！"
	custom_materials = list(
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma = SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/gun/energy/cell_loaded/medigun/standard
	to_obj = /obj/item/gun/energy/cell_loaded/medigun/upgraded

/obj/item/custom_kit/medigun_fastcharge/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/gun/energy/cell_loaded/medigun/standard/our_medigun = target_obj
	if(length(our_medigun.installedcells))
		balloon_alert(user, "请先卸下电池！")
		return FALSE
	return TRUE

// Medigun wiki book
/obj/item/book/manual/wiki/mediguns
	name = "医疗枪操作手册"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "manual"
	starting_author = "VeyMedical"
	starting_title = "医疗枪操作手册"
	page_link = "Guide_to_Mediguns"

// Medigun Gunsets
/obj/item/storage/briefcase/medicalgunset
	name = "医疗枪补给包"
	desc = "用于医疗枪的补给包。"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/misc.dmi'
	icon_state = "case_standard"
	inhand_icon_state = "lockbox"
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound =  'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/briefcase/medicalgunset/standard
	name = "VeyMedical CWM-479 电池驱动医疗枪箱"
	desc = "内含 CWM-479 医疗枪和一本说明书的公文包。"

/obj/item/storage/briefcase/medicalgunset/standard/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/standard(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/obj/item/storage/briefcase/medicalgunset/cmo
	name = "VeyMedical CWM-479-CC 电池驱动医疗枪箱"
	desc = "内含实验型 CWM-479-CC 医疗枪、一套三块基础医疗电池和一本说明书的公文包。"
	icon_state = "case_cmo"

/obj/item/storage/briefcase/medicalgunset/cmo/PopulateContents()
	new /obj/item/gun/energy/cell_loaded/medigun/cmo(src)
	new /obj/item/weaponcell/medical/tier_1/brute(src)
	new /obj/item/weaponcell/medical/tier_1/burn(src)
	new /obj/item/weaponcell/medical/tier_1/toxin(src)
	new /obj/item/book/manual/wiki/mediguns(src)

/*
* Medigun Cells - Spritework is done by Arctaisia!
*/

// Default Cell
/obj/item/weaponcell/medical
	name = "默认医疗电池"
	desc = "标准的氧气电池，大多数枪械出厂时已装有它。"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	ammo_type = /obj/item/ammo_casing/energy/medical // This is the ammo type that all mediguns come with.
	medicell_examine = TRUE

/obj/item/weaponcell/medical/tier_1/oxygen
	name = "氧气 I 医疗电池"
	desc = "一块散发微弱蓝光的小电池。可用于医疗枪，启用基础缺氧治疗功能。"

/*
* Tier I cells
*/

// Brute I
/obj/item/weaponcell/medical/tier_1/brute
	name = "钝击 I 医疗电池"
	desc = "一块散发微弱红光的小电池。可用于医疗枪，启用基础钝击伤害治疗功能。"
	icon_state = "Brute1"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute1
	primary_mode = /obj/item/ammo_casing/energy/medical/brute1/safe
	toggle_modes = TRUE

// Burn I
/obj/item/weaponcell/medical/tier_1/burn
	name = "灼伤 I 医疗电池"
	desc = "一块散发微弱黄光的小电池。可用于医疗枪，启用基础灼伤伤害治疗功能。"
	icon_state = "Burn1"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn1/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn1
	primary_mode = /obj/item/ammo_casing/energy/medical/burn1/safe
	toggle_modes = TRUE
// Toxin I
/obj/item/weaponcell/medical/tier_1/toxin
	name = "毒素 I 医疗电池"
	desc = "一块散发微弱绿光的小电池。可用于医疗枪，启用基础毒素伤害治疗功能。"
	icon_state = "Toxin1"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin1

/*
* Tier II Cells
*/

/obj/item/weaponcell/medical/tier_2
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
	)

// Brute II
/obj/item/weaponcell/medical/tier_2/brute
	name = "钝击 II 医疗电池"
	desc = "一块散发明显红光的小电池。可用于医疗枪，启用改良的钝击伤害治疗功能。"
	icon_state = "Brute2"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute2
	primary_mode = /obj/item/ammo_casing/energy/medical/brute2/safe
	toggle_modes = TRUE

// Burn II
/obj/item/weaponcell/medical/tier_2/burn
	name = "灼伤 II 医疗电池"
	desc = "一块散发明显黄光的小电池。可用于医疗枪，启用改良的灼伤伤害治疗功能。"
	icon_state = "Burn2"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn2/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn2
	primary_mode = /obj/item/ammo_casing/energy/medical/burn2/safe
	toggle_modes = TRUE

// Toxin II
/obj/item/weaponcell/medical/tier_2/toxin
	name = "毒素 II 医疗电池"
	desc = "一块散发明显绿光的小电池。可用于医疗枪，启用改良的毒素伤害治疗功能。"
	icon_state = "Toxin2"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin2

// Oxygen II
/obj/item/weaponcell/medical/tier_2/oxygen
	name = "氧气 II 医疗电池"
	desc = "一块散发明显蓝光的小电池。可用于医疗枪，启用改良的缺氧治疗功能。"
	icon_state = "Oxy2"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy2

/*
* Tier III Cells
*/
/obj/item/weaponcell/medical/tier_3
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)

// Brute III
/obj/item/weaponcell/medical/tier_3/brute
	name = "钝击 III 医疗电池"
	desc = "一块散发强烈红光并配有强化外壳的小电池。可用于医疗枪，启用高级钝击伤害治疗功能。"
	icon_state = "Brute3"
	ammo_type = /obj/item/ammo_casing/energy/medical/brute3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute3
	primary_mode = /obj/item/ammo_casing/energy/medical/brute3/safe
	toggle_modes = TRUE

// Burn III
/obj/item/weaponcell/medical/tier_3/burn
	name = "灼伤 III 医疗电池"
	desc = "一块散发强烈黄光并配有强化外壳的小电池。可用于医疗枪，启用高级灼伤伤害治疗功能。"
	icon_state = "Burn3"
	ammo_type = /obj/item/ammo_casing/energy/medical/burn3/safe
	secondary_mode = /obj/item/ammo_casing/energy/medical/burn3
	primary_mode = /obj/item/ammo_casing/energy/medical/burn3/safe
	toggle_modes = TRUE

// Toxin III
/obj/item/weaponcell/medical/tier_3/toxin
	name = "毒素 III 医疗电池"
	desc = "一块散发强烈绿光并配有强化外壳的小电池。可用于医疗枪，启用高级毒素伤害治疗功能。"
	icon_state = "Toxin3"
	ammo_type = /obj/item/ammo_casing/energy/medical/toxin3

// Oxygen III
/obj/item/weaponcell/medical/tier_3/oxygen
	name = "氧气 III 医疗电池"
	desc = "一块散发强烈蓝光并配有强化外壳的小电池。可用于医疗枪，启用高级缺氧治疗功能。"
	icon_state = "Oxy3"
	ammo_type = /obj/item/ammo_casing/energy/medical/oxy3

/*
* Utility Cells
*/

/obj/item/weaponcell/medical/utility
	name = "功能型医疗电池"
	desc = "你本不该看到这个。如果你看到了，请去骂你当地的程序员。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcell/medical/utility/clotting
	name = "凝血医疗电池"
	desc = "一块用于处理出血患者的医疗电池。"
	icon_state = "clotting"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/clotting

/obj/item/weaponcell/medical/utility/temperature
	name = "体温调节医疗电池"
	desc = "一块将患者体温调节到“血液在血管中冻结”与“血液在血管中瞬间沸腾”之间最佳区间的医疗电池。"
	icon_state = "temperature"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/temperature

/obj/item/weaponcell/medical/utility/hardlight_gown
	name = "硬光病号服医疗电池"
	desc = "一块能在目标身上生成硬光病号服的医疗电池。"
	icon_state = "gown"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/gown

/obj/item/weaponcell/medical/utility/salve
	name = "硬光药膏医疗电池"
	desc = "一块能将具有治疗作用的合成植物物质凝珠施用于患者的医疗电池。"
	icon_state = "salve"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/salve

/obj/item/weaponcell/medical/utility/bed
	name = "硬光担架床医疗电池"
	desc = "一块能在已躺倒在地的患者身下召唤临时担架床的医疗电池。"
	icon_state = "gown"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3,
	)
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/bed

/obj/item/weaponcell/medical/utility/body_teleporter
	name = "遗体传送医疗电池"
	desc = "一块能让使用者将尸体传送到自己身边的医疗电池。"
	icon_state = "body"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/body_teleporter

/obj/item/weaponcell/medical/utility/relocation
	name = "强制转移医疗电池"
	desc = "一块能在宽限期后安全转移人员的医疗电池，需由拥有相应权限的人在指定区域（通常是医疗部）内使用。"
	icon_state =  "body"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT * 3,
	)
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation/standard

/obj/item/weaponcell/medical/utility/relocation/upgraded
	name = "升级型强制转移医疗电池"
	desc = "转移医疗电池的升级版。它取消了权限和区域限制，并禁用了标准宽限期。"
	ammo_type = /obj/item/ammo_casing/energy/medical/utility/relocation

//Empty Medicell//
/obj/item/custom_kit/empty_cell //Having the empty cell as an upgrade kit sounds jank, but it should work well.
	name = "空药膏医疗电池"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "empty"
	desc = "一块未激活的药膏医疗电池，将其用于芦荟叶即可制成可用的电池。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
	)
	from_obj = /obj/item/food/grown/aloe
	to_obj = /obj/item/weaponcell/medical/utility/salve

/obj/item/custom_kit/empty_cell/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)

/obj/item/custom_kit/empty_cell/body_teleporter
	name = "空遗体传送医疗电池"
	desc = "一块未激活的遗体传送医疗电池，将其用于蓝空间史莱姆提取物即可制成可用的电池。"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/body_teleporter

/obj/item/custom_kit/empty_cell/relocator
	name = "空强制转移医疗电池"
	desc = "一块未激活的强制转移医疗电池，将其用于蓝空间史莱姆提取物即可制成可用的电池。"
	from_obj = /obj/item/slime_extract/bluespace
	to_obj = /obj/item/weaponcell/medical/utility/relocation
