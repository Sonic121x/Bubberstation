// Shotgun

/obj/item/ammo_casing/shotgun
	name = "霰弹独头弹"
	desc = "一枚 12 号铅制独头弹。"
	icon_state = "blshell"
	worn_icon_state = "shell"
	caliber = CALIBER_SHOTGUN
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2)
	projectile_type = /obj/projectile/bullet/shotgun_slug
	newtonian_force = 1.25

/obj/item/ammo_casing/shotgun/milspec
	name = "军用规格霰弹独头弹"
	desc = "一枚 12 号军用规格铅制独头弹。"
	projectile_type = /obj/projectile/bullet/shotgun_slug/milspec

/obj/item/ammo_casing/shotgun/executioner
	name = "行刑者独头弹"
	desc = "一枚 12 号铅制独头弹，专为在命中时摧毁血肉而打造。"
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/executioner

/obj/item/ammo_casing/shotgun/pulverizer
	name = "粉碎者独头弹"
	desc = "一枚 12 号铅制独头弹，专为在命中时粉碎骨骼而打造。"
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_slug/pulverizer

/obj/item/ammo_casing/shotgun/beanbag
	name = "豆袋弹"
	desc = "一枚用于防暴的弱效豆袋弹。"
	icon_state = "bshell"
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3)
	projectile_type = /obj/projectile/bullet/shotgun_beanbag

/obj/item/ammo_casing/shotgun/incendiary
	name = "燃烧独头弹"
	desc = "一枚涂有燃烧剂的霰弹独头弹。"
	icon_state = "ishell"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/ammo_casing/shotgun/incendiary/no_trail
	name = "精准燃烧独头弹"
	desc = "一枚涂有燃烧剂的霰弹独头弹，经过特殊处理，只在命中时点燃。"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/no_trail

/obj/item/ammo_casing/shotgun/dragonsbreath
	name = "龙息弹"
	desc = "一种会喷射一片燃烧弹丸的霰弹。"
	icon_state = "ishell2"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	pellets = 6
	variance = 15
	randomspread = TRUE
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun/stunslug
	name = "电击独头弹"
	desc = "一枚致晕电击独头弹。"
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/shotgun_stunslug
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*2.5)

/obj/item/ammo_casing/shotgun/meteorslug
	name = "陨星独头弹"
	desc = "一种搭载 CMC 技术的霰弹，开火时会发射一枚巨型独头弹。"
	icon_state = "mshell"
	projectile_type = /obj/projectile/bullet/cannonball/meteorslug
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3.2)

/obj/item/ammo_casing/shotgun/pulseslug
	name = "脉冲独头弹"
	desc = "一种可以装入霰弹枪的精密装置。底火充当按钮，触发增益介质并释放一道强大的\
	能量冲击。虽然热量与能量消耗使其只能使用一次，但它仍能让使用者攻击那些\
	弹道弹药难以应付的目标。"
	icon_state = "pshell"
	projectile_type = /obj/projectile/beam/pulse/shotgun
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.8, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.65, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.6)

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12 独头弹"
	desc = "一枚用于 12 号霰弹枪的高爆破门弹。"
	icon_state = "heshell"
	projectile_type = /obj/projectile/bullet/shotgun_frag12
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun/buckshot
	name = "鹿弹"
	desc = "一枚 12 号鹿弹。"
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot
	pellets = 6
	variance = 15
	randomspread = TRUE

/obj/item/ammo_casing/shotgun/buckshot/old
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/old
	can_misfire = TRUE
	misfire_increment = 2
	integrity_damage = 4

/obj/item/ammo_casing/shotgun/buckshot/old/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, atom/fired_from)
	. = ..()
	if(fired_from)
		do_smoke(0, fired_from, fired_from)

/obj/item/ammo_casing/shotgun/buckshot/milspec
	name = "军用规格鹿弹"
	desc = "一枚 12 号鹿弹，被各类准军事组织与雇佣兵部队使用。"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_buckshot/milspec

/obj/item/ammo_casing/shotgun/buckshot/spent
	projectile_type = null

/obj/item/ammo_casing/shotgun/rubbershot
	name = "橡胶弹"
	desc = "一种装满密实橡胶球的霰弹壳，用于从远处使人群丧失行动能力。"
	icon_state = "rshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_rubbershot
	pellets = 6
	variance = 15
	randomspread = TRUE
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3)

/obj/item/ammo_casing/shotgun/incapacitate
	name = "定制失能弹"
	desc = "一种装满了……某种东西的霰弹壳，用于使目标丧失行动能力。"
	icon_state = "bountyshell"
	projectile_type = /obj/projectile/bullet/pellet/shotgun_incapacitate
	pellets = 12//double the pellets, but half the stun power of each, which makes this best for just dumping right in someone's face.
	variance = 25
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2)

/obj/item/ammo_casing/shotgun/flechette
	name = "飞镖弹"
	desc = "一种装满小型金属飞镖的霰弹壳。能在血肉与凯夫拉上扎出许多小孔。适合把某人的\
		内脏变成外脏。"
	icon_state = "flechette"
	projectile_type = /obj/projectile/bullet/pellet/flechette
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	pellets = 8
	variance = 10

/obj/item/ammo_casing/shotgun/flechette/donk
	name = "\improper 咚克公司“咚克尖刺”霰弹壳"
	desc = "咚克公司为了给公开市场推出一款激动人心的新霰弹，发明了他们所谓的“咚克尖刺”。\
		这是一种不用标准黑色金属、而是用……塑料制成的飞镖弹。由于市场对这款产品完全没有\
		信心，它在商业上彻底失败了。如今整个星区的垃圾填埋场里躺着数百万枚这种东西。这就是其中一枚。\
		看起来像咚克口袋饼！尝起来像死亡！"
	icon_state = "flechette_donk"
	projectile_type = /obj/projectile/bullet/pellet/flechette/donk
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)
	pellets = 5

/obj/item/ammo_casing/shotgun/ion
	name = "离子弹"
	desc = "一种高级霰弹，利用亚空间安塞波晶体产生类似标准离子步枪的效果。\
	晶体的独特性质会将脉冲分裂成一片各自较弱的能量束。"
	icon_state = "ionshell"
	projectile_type = /obj/projectile/ion/weak
	pellets = 4
	variance = 15
	randomspread = TRUE
	custom_materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.15, /datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver = SMALL_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 0.6)

/obj/item/ammo_casing/shotgun/scatterlaser
	name = "散射激光弹"
	desc = "一种高级霰弹，内置微型激光器，以弹道弹药的形式复现散射激光武器的效果。"
	icon_state = "lshell"
	projectile_type = /obj/projectile/beam/scatter
	pellets = 6
	variance = 15
	randomspread = TRUE
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun/scatterlaser/emp_act(severity)
	. = ..()
	if(isnull(loaded_projectile) || !prob(40/severity))
		return
	name = "故障激光弹"
	desc = "一种高级霰弹，内置微型激光器，以弹道弹药的形式复现散射激光武器的效果。为这套装置供电的电容器似乎在冒烟。"
	projectile_type = /obj/projectile/beam/scatter/pathetic
	loaded_projectile = new projectile_type(src)

/obj/item/ammo_casing/shotgun/techshell
	name = "未装填科技霰弹"
	desc = "一种高科技霰弹，可装入材料以产生独特效果。"
	icon_state = "cshell"
	projectile_type = null
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)

/obj/item/ammo_casing/shotgun/techshell/Initialize(mapload)
	. = ..()

	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/meteorslug, /datum/crafting_recipe/pulseslug, /datum/crafting_recipe/dragonsbreath, /datum/crafting_recipe/ionslug)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/ammo_casing/shotgun/dart
	name = "霰弹飞镖"
	desc = "一种用于霰弹枪的飞镖。最多可注入 15 单位任意化学物质。"
	icon_state = "cshell"
	projectile_type = /obj/projectile/bullet/dart
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 3)
	var/reagent_amount = 15

/obj/item/ammo_casing/shotgun/dart/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount, OPENCONTAINER)

// Can't be collected into an ammo box from the floor, for whatever reason.
/obj/item/ammo_casing/shotgun/dart/collect_into_box(mob/living/user, obj/item/ammo_box/box)
	return FALSE

/obj/item/ammo_casing/shotgun/dart/large
	name = "加大号霰弹飞镖"
	desc = "一种用于霰弹枪的飞镖。最多可注入 25 单位任意化学物质。"
	reagent_amount = 25
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/ammo_casing/shotgun/dart/bioterror
	name = "生物恐怖飞镖"
	desc = "一种装满致命毒素的改良霰弹飞镖。最多可注入 30 单位任意化学物质。"
	reagent_amount = 30
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/ammo_casing/shotgun/dart/bioterror/Initialize(mapload)
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 6)
	reagents.add_reagent(/datum/reagent/toxin/spore, 6)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 6) //;HELP OPS IN MAINT
	reagents.add_reagent(/datum/reagent/toxin/coniine, 6)
	reagents.add_reagent(/datum/reagent/toxin/sodium_thiopental, 6)

/obj/item/ammo_casing/shotgun/breacher
	name = "破门独头弹"
	desc = "一枚 12 号反器材独头弹。非常适合快速高效地破开气闸与窗户。"
	icon_state = "breacher"
	projectile_type = /obj/projectile/bullet/shotgun_breaching
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT*2)
