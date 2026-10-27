/datum/opposing_force_equipment/ranged
	category = OPFOR_EQUIPMENT_CATEGORY_RANGED
/datum/opposing_force_equipment/ranged/lmg
	name = "L6班用轻机枪"
	description = "一把经过大幅改装的7毫米轻机枪，型号为‘L6班用机枪’。机匣型号标记下方刻着‘奥赛克军械公司 - 2531’。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/lmg

/obj/item/storage/toolbox/guncase/skyrat/opfor/lmg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted(src)
	new /obj/item/ammo_box/magazine/m7mm(src)
	new /obj/item/ammo_box/magazine/m7mm(src)

/datum/opposing_force_equipment/ranged/hook_shotgun
	name = "钩索改装短管霰弹枪"
	description = "当你能把受害者拉到面前时，射程就不再是问题。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/hook_shotgun

/obj/item/storage/toolbox/guncase/skyrat/opfor/hook_shotgun/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/hook(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)
	new /obj/item/ammo_box/advanced/s12gauge/buckshot(src)

/datum/opposing_force_equipment/ranged/rebar_crossbow
	name = "辛迪加钢筋弩"
	description = "辛迪加很欣赏纳米传讯工程师自制的山寨钢筋弩，于是展示了这种武器经过正规研发后能达到的水平。\
			可装填三发且不会炸膛，并配有内置瞄准镜。通常使用辛迪加特制锯齿铁条，也可用扳手调整为发射性能较差的普通铁条。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow

/obj/item/storage/toolbox/guncase/skyrat/opfor/rebar_crossbow/PopulateContents()
	new /obj/item/gun/ballistic/rifle/rebarxbow/syndie(src)
	new /obj/item/book/granter/crafting_recipe/dusting/rebarxbowsyndie_ammo(src)

//laser
/datum/opposing_force_equipment/ranged/ion
	name = "离子卡宾枪"
	description = "MK.II原型离子投射器是大型离子步枪的轻型卡宾枪版本，设计兼顾人体工学与效率。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/ion

/obj/item/storage/toolbox/guncase/skyrat/opfor/ion/PopulateContents()
	new /obj/item/gun/energy/ionrifle/carbine(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

/datum/opposing_force_equipment/ranged/carbine
	name = "激光卡宾枪"
	description = "一把改装激光枪，射速大幅提升，但每发伤害明显降低。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/carbine

/obj/item/storage/toolbox/guncase/skyrat/opfor/carbine/PopulateContents()
	new /obj/item/gun/energy/laser/carbine(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

/datum/opposing_force_equipment/ranged/laser
	name = "激光枪"
	description = "一把基础型能量激光枪，发射能够穿透玻璃和薄金属的聚焦光束。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/laser

/obj/item/storage/toolbox/guncase/skyrat/opfor/laser/PopulateContents()
	new /obj/item/gun/energy/laser(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)

//foamforce
/datum/opposing_force_equipment/ranged/foamforce_lmg
	name = "泡沫火力轻机枪"
	description = "一把经过大幅改装的玩具轻机枪，型号为‘L6班用机枪’。适合8岁及以上人群。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/opfor/foamforce_lmg

/obj/item/storage/toolbox/guncase/skyrat/opfor/foamforce_lmg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot(src)
	new /obj/item/ammo_box/magazine/toy/m762/riot(src)
	new /obj/item/ammo_box/magazine/toy/m762/riot(src)


/datum/opposing_force_equipment/ranged_stealth
	category = OPFOR_EQUIPMENT_CATEGORY_RANGED_STEALTH

/datum/opposing_force_equipment/ranged_stealth/rapid_syringe
	name = "紧凑速射注射枪"
	description = "注射枪的紧凑改款，使用旋转弹巢，可容纳至多六支注射器。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/rapid_syringe

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/rapid_syringe/PopulateContents()
	new /obj/item/gun/syringe/rapidsyringe(src)
	new /obj/item/storage/belt/medbandolier(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)
	new /obj/item/reagent_containers/syringe/piercing(src)

/datum/opposing_force_equipment/ranged_stealth/c20r
	name = "C-20r冲锋枪"
	description = "一把无托式三发点射.45口径冲锋枪，型号为‘C-20r’。枪托上印着‘斯卡伯勒军火公司——凭镰刀，行邪道’。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/c20r/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r/unrestricted(src)
	new /obj/item/ammo_box/magazine/smgm45(src)
	new /obj/item/ammo_box/magazine/smgm45(src)

/datum/opposing_force_equipment/ranged_stealth/makarov
	name = "马卡洛夫手枪"
	description = "一把小巧易藏的9×25毫米Mk.12手枪。这把附带消音器。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/makarov/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol(src)
	new /obj/item/suppressor(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/magazine/m9mm(src)

/datum/opposing_force_equipment/ranged_stealth/m1911
	name = "M1911手枪"
	description = "一把经典的.45口径手枪，弹匣容量较小。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/m1911/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/datum/opposing_force_equipment/ranged_stealth/syndie_revolver
	name = "辛迪加左轮手枪"
	description = "斯卡伯勒制造的现代化七发左轮手枪。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/syndie_revolver

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/syndie_revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver(src)
	new /obj/item/ammo_box/speedloader/c357(src)
	new /obj/item/ammo_box/speedloader/c357(src)

/datum/opposing_force_equipment/ranged_stealth/ocelot
	name = "柯尔特和平缔造者左轮手枪"
	admin_note = "配有.357和平缔造者弹，伤害明显较低，但跳弹效果很酷！"
	description = "使用.357弹药的改装和平缔造者左轮手枪。威力低于普通.357弹，但跳弹能力强得多。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/ocelot

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/ocelot/PopulateContents()
	new /obj/item/gun/ballistic/revolver/ocelot(src)
	new /obj/item/ammo_box/speedloader/c357/peacemaker(src)
	new /obj/item/ammo_box/speedloader/c357/peacemaker(src)

//foamforce
/datum/opposing_force_equipment/ranged_stealth/foamforce_smg
	name = "咚克软冲锋枪"
	description = "一把无托式三发点射玩具冲锋枪，型号为‘C-20r’。适合8岁及以上人群。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg/PopulateContents()
	new /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot(src)
	new /obj/item/ammo_box/magazine/toy/smgm45/riot(src)
	new /obj/item/ammo_box/magazine/toy/smgm45/riot(src)

/datum/opposing_force_equipment/ranged_stealth/foamforce_smg_basic
	name = "泡沫火力冲锋枪"
	description = "一把三发点射玩具冲锋枪原型。适合8岁及以上人群。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg_basic

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/foamforce_smg_basic/PopulateContents()
	new /obj/item/gun/ballistic/automatic/toy/riot(src)
	new /obj/item/ammo_box/magazine/toy/smg/riot(src)
	new /obj/item/ammo_box/magazine/toy/smg/riot(src)

//laser
/datum/opposing_force_equipment/ranged_stealth/fisher
	item_type = /obj/item/gun/energy/recharge/fisher

/datum/opposing_force_equipment/ranged_stealth/ebow
	item_type = /obj/item/gun/energy/recharge/ebow

/datum/opposing_force_equipment/ranged_stealth/egun_mini
	name = "微型能量枪"
	description = "一把手枪大小的小型能量枪，内置手电筒，具有失能和杀伤两种模式。"
	item_type = /obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/egun_mini

/obj/item/storage/toolbox/guncase/skyrat/pistol/opfor/egun_mini/PopulateContents()
	new /obj/item/gun/energy/e_gun/mini(src)
	new /obj/item/storage/box/syndie_kit/recharger(src)
