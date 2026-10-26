/*
*	QM Sporter Rifle
*/

/obj/item/gun/ballistic/rifle/boltaction/sporterized
	name = "\improper 联合精密步枪"
	desc = "一把深度改装的萨赫诺步枪，零件由位于木星周边的希豪轻武器公司制造。\
		容量比标准萨赫诺步枪更大，可装八发.310弹药。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/guns40x.dmi'
	icon_state = "rengo"
	worn_icon_state = "enchanted_rifle" // Not actually magical looking, just looks closest to this one
	inhand_icon_state = "sakhno"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/bubba
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/sporterized/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/energy/recharge/ebow/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35)

/obj/item/gun/ballistic/rifle/boltaction/sporterized/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/rifle/boltaction/sporterized/examine(mob/user)
	. = ..()
	. += span_notice("你可以<b>仔细查看</b>以进一步了解这件武器。")

/obj/item/gun/ballistic/rifle/boltaction/sporterized/examine_more(mob/user)
	. = ..()

	. += "希豪“联合”改装步枪。希豪轻武器公司将所需零件作为套件出售，\
		可替换普通萨赫诺步枪上许多过时或陈旧的部件。\
		虽然未必提升了什么性能，但弹仓稍长了一些。武器\
		整体也更短，更方便某些人操作。不能锯短，\
		切掉这件武器的任何部分都可能让它无法工作。"

	return .

/obj/item/gun/ballistic/rifle/boltaction/sporterized/empty
	bolt_locked = TRUE // so the bolt starts visibly open
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/bubba/empty

/obj/item/ammo_box/magazine/internal/boltaction/bubba
	name = "萨赫诺扩容内置弹仓"
	desc = "你是怎么把它取出来的？"
	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/boltaction/bubba/empty
	start_empty = TRUE

/*
*	Box that contains Sakhno rifles, but less soviet union since we don't have one of those
*/

/obj/item/storage/toolbox/guncase/soviet/sakhno
	desc = "一个武器箱。绿色外壳看起来相当陈旧，不过除此之外状况还不错。"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/cases.dmi'
	material_flags = NONE // ????? Why do these have materials enabled??
