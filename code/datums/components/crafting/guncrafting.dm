//Gun crafting parts til they can be moved elsewhere

// PARTS //
/obj/item/weaponcrafting
	abstract_type = /obj/item/weaponcrafting

/obj/item/weaponcrafting/Initialize(mapload)
	. = ..()
	create_slapcraft_component()

/obj/item/weaponcrafting/proc/create_slapcraft_component()
	return

/obj/item/weaponcrafting/receiver
	name = "模块化机匣"
	desc = "一套原型模块化枪械机匣与扳机组件。"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "receiver"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5.55, /datum/material/cardboard = SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)

/obj/item/weaponcrafting/receiver/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/pipegun)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/weaponcrafting/stock
	name = "步枪枪托"
	desc = "一块用木头粗略雕成的经典步枪枪托，也可作为握把使用。"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 8, /datum/material/plastic = SMALL_MATERIAL_AMOUNT)
	resistance_flags = FLAMMABLE
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "riflestock"

/obj/item/weaponcrafting/stock/create_slapcraft_component()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/smoothbore_disabler, /datum/crafting_recipe/laser_musket)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/weaponcrafting/giant_wrench
	name = "大巴掌零件套件"
	desc = "用于制造俗称“大巴掌”的巨型扳手的非法零件。"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "weaponkit_gw"

/obj/item/weaponcrafting/giant_wrench/create_slapcraft_component() // slappycraft
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/giant_wrench)

	AddElement(
		/datum/element/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

///These gun kits are printed from the security protolathe to then be used in making new weapons

// GUN PART KIT //

/obj/item/weaponcrafting/gunkit // These don't get a slapcraft component, it's added to the gun - more intuitive player-facing to slap the kit onto the gun.
	name = "通用枪械零件套件"
	desc = "这是个空的枪械零件容器！你怎么会有这个？"
	icon = 'icons/obj/weapons/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/weaponcrafting/gunkit/nuclear
	name = "高级能量枪零件套件（致命/非致命）"
	desc = "一个手提箱，装有将标准能量枪改装为高级能量枪所需的零件。"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/tesla
	name = "特斯拉炮零件套件（致命）"
	desc = "一个手提箱，装有以稳定的磁通异常为核心制造特斯拉炮所需的零件。请小心轻放。"
	icon_state = "weaponskit_tesla"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/weaponcrafting/gunkit/xray
	name = "X射线激光枪零件套件（致命）"
	desc = "一个手提箱，装有将激光枪改装为X射线激光枪所需的零件。大多数零件都不该直接朝向面部。"
	custom_materials = list(
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/weaponcrafting/gunkit/ion
	name = "离子卡宾枪零件套件（非致命/高破坏力/对硅基生命极其致命）"
	desc = "一个手提箱，装有将标准激光枪改装为离子卡宾枪所需的零件。非常适合对付你没有权限打开的储物柜。"
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 4, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)

/obj/item/weaponcrafting/gunkit/temperature
	name = "温控枪零件套件（低致命性/对蜥蜴人极其致命）"
	desc = "一个手提箱，装有将标准能量枪改装为温控枪所需的零件。既适合生日派对，也适合屠杀蜥蜴人原住民。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 1.5)

/obj/item/weaponcrafting/gunkit/beam_rifle
	name = "\improper 事件视界反存在光束步枪零件套件（末日装置，禁止制造）"
	desc = "究竟是怎样疯狂的头脑创造了这套可怕的建造套件？竟想打造框架，利用流经顺旋星区的诡异能量实施如此骇人的暴行？"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 2.25,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 2.5,
	)

/obj/item/weaponcrafting/gunkit/ebow
	name = "能量弩零件套件（低致命性）"
	desc = "一套严重违法的武器改装套件，可将标准原型动能加速器改成几乎以假乱真的能量弩。简直和真品一样！"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/weaponcrafting/gunkit/hellgun
	name = "地狱火激光枪劣化套件（战争罪级致命性）"
	desc = "拿来一把运作正常的激光枪，把内部结构糟蹋一通，让它变得炽热而凶残。现在你有了一把地狱火激光枪。你这个恶魔。"

/obj/item/weaponcrafting/gunkit/photon
	name = "光子炮零件套件（非致命）"
	desc = "一个手提箱，装有以稳定的磁通异常为核心制造光子炮所需的零件。将太阳之力掌握于双手之中。"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 7, /datum/material/gold = SHEET_MATERIAL_AMOUNT * 5)

/obj/item/weaponcrafting/gunkit/sks
	name = "\improper 萨赫诺SKS半自动步枪零件套件（致命）"
	desc = "一个手提箱，装有制造萨赫诺SKS半自动步枪所需的零件。这东西在边境世界随处可见。"
