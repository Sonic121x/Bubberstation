//Niim Pocket Reolver - Fires Murphy ammo
/obj/item/gun/ballistic/revolver/protector_revolver
	name = "\improper “保护者”左轮手枪"
	desc = "“保护者”是为纳米传讯执法部门设计的紧凑型备用枪械。内置照明，枪机经过精细抛光，确保在任何环境下都能可靠运作；其弹膛适配纳米传讯制式 9mm 墨菲弹，以保证弹药通用。墨菲弹匣可直接卡在弹巢上，方便快速装填。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_sec"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/sec9mm
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 40
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	force = 9.5 //slightly worse than murphy/batong

/obj/item/gun/ballistic/revolver/protector_revolver/add_seclight_point()
	// The revolver's light comes attached but is unremovable.
	AddComponent(/datum/component/seclite_attachable, \
		starting_light = new /obj/item/flashlight/seclite(src), \
		is_light_removable = FALSE, \
		light_overlay_icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi', \
		light_overlay = "niimpocketrevolver_light")


/obj/item/gun/ballistic/revolver/defender_revolver
	name = "\improper “防卫者”左轮手枪"
	desc = "“防卫者”是一款廉价、劣质的火星仿制品，仿自“保护者”系列，不过街头传言称两者其实出自同一批工厂。发射 .38 弹药。粗糙的加工工艺略微降低了弹药威力与精度。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimpocketrevolver_civvie"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/defender38
	fire_sound = 'sound/items/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/items/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/items/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 50
	dry_fire_sound = 'sound/items/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_SMALL
	projectile_damage_multiplier = 0.8
	spread = 10
	force = 9.5 //slightly worse than murphy/batong


/obj/item/gun/ballistic/revolver/consultant
	name = "裁决"
	desc = "一把受知名尤妮卡启发而打造的漂亮左轮手枪，专为那些既想要手炮风范、又不愿承受携带负担的纳米传讯官员订制。这款光亮如镜的仿制品停止作用不如它的斯拉夫表亲，但轻便得多，使用也更舒适。"
	icon = 'modular_zubbers/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "niimconsultantrevolver"
	base_icon_state = "niimconsultantrevolver"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev32
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/revolver/consultant/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/revolver/consultant/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/examine_lore, \
		lore_hint = span_notice("你可以" + EXAMINE_HINT("仔细观察") + "来进一步了解 [src]。"), \
			lore = "“裁决”是一款颇具实验性质的设计。它最初由纳米传讯军械部起草，作为指挥官、上将及其他中央指挥部要员的仪仗佩枪。它首先是权威的象征，其次才是自卫工具；而其实际性能，是在外形被定稿为采购委员会口中“恰如其分地彰显权威”之后才被认真对待的。<br>\
<br>\
“裁决”以高抛光铬镍合金铸造并手工修饰——这道工序纳米传讯从未敢交给机器自动化，只能由理论上有薪水的实习生完成。它发射 .32 马格南弹，足以在需要时终结一场对峙。<br>\
<br>\
“裁决”仅通过嘉奖与晋升发放；枪管上会刻上获得者的姓名与所属部门。这一把上还没有任何名字，但也许你正好能赢得让它刻上你的名字的资格……" \
	)

/obj/item/ammo_box/magazine/internal/cylinder/rev32
	name = ".32 左轮弹巢"
	ammo_type = /obj/item/ammo_casing/c38/c32
	caliber = CALIBER_32
	max_ammo = 6
