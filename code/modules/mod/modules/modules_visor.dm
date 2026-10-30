//Visor modules for MODsuits

///Base Visor - Adds a specific HUD and traits to you.
/obj/item/mod/module/visor
	name = "\improper MOD 护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。据说戴上它还能让你看到身后。"
	module_type = MODULE_TOGGLE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/visor)
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_EYES|ITEM_SLOT_MASK)
	/// The traits given by the visor.
	var/list/visor_traits = list()

/obj/item/mod/module/visor/on_activation(mob/activator)
	if(length(visor_traits))
		mod.wearer.add_traits(visor_traits, REF(src))
	mod.wearer.update_sight()

/obj/item/mod/module/visor/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	if(length(visor_traits))
		mod.wearer.remove_traits(visor_traits, REF(src))
	mod.wearer.update_sight()

//Medical Visor - Gives you a medical HUD.
/obj/item/mod/module/visor/medhud
	name = "\improper MOD 医疗护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。它会将套装传感器数据与现代化的 \
		生物扫描套件相互比对，让使用者能够看到有机生命体当前的健康状况，并 \
		以便捷的读数方式调阅病历等数据。据说戴上它还能让你看到身后。"
	icon_state = "medhud_visor"
	visor_traits = list(TRAIT_MEDICAL_HUD)
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

//Diagnostic Visor - Gives you a diagnostic HUD.
/obj/item/mod/module/visor/diaghud
	name = "\improper MOD 诊断护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。它利用一系列高级传感器读取 \
		先进机械、外骨骼和其他设备的数据，让使用者能够看到这些设备的当前电量 \
		与结构完整度。据说戴上它还能让你看到身后。"
	icon_state = "diaghud_visor"
	visor_traits = list(TRAIT_DIAGNOSTIC_HUD, TRAIT_BOT_PATH_HUD)
	custom_materials = list(/datum/material/gold = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

//Security Visor - Gives you a security HUD.
/obj/item/mod/module/visor/sechud
	name = "\improper MOD 安保护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。这个模块是一套经过重度改装的瞄准系统， \
		接入了各类犯罪数据库，可以查看逮捕记录、指挥简单的安保机器人， \
		并且大体上知道该朝谁开枪。据说戴上它还能让你看到身后。"
	icon_state = "sechud_visor"
	visor_traits = list(TRAIT_SECURITY_HUD)
	custom_materials = list(/datum/material/titanium = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

//Meson Visor - Gives you meson vision.
/obj/item/mod/module/visor/meson
	name = "\improper MOD 介子护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。这个模块基于广受喜爱的介子扫描仪 \
		技术，银河各地的建筑工人和矿工都用它在任何光照条件下看穿墙壁、 \
		观察基本的建筑结构与地形布局。据说戴上它还能让你看到身后。"
	icon_state = "meson_visor"
	visor_traits = list(TRAIT_MESON_VISION, TRAIT_MADNESS_IMMUNE)
	custom_materials = list(/datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

//Thermal Visor - Gives you thermal vision.
/obj/item/mod/module/visor/thermal
	name = "\improper MOD 热成像护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。它使用小型红外扫描仪探测并识别 \
		使用者附近物体的热辐射输出。虽然它能探测到连啮齿动物这样小的物体 \
		散发的热量，但仍会产生令人不适的红色叠影。据说戴上它还能让你看到身后。"
	icon_state = "thermal_visor"
	visor_traits = list(TRAIT_THERMAL_VISION)

//Night Visor - Gives you night vision.
/obj/item/mod/module/visor/night
	name = "\improper MOD 夜视护目镜模块"
	desc = "安装在套装护目镜里的平视显示器。这在民用和军用领域都很常见， \
		它让使用者能在完全黑暗中看清周围环境，将视野增强十倍； \
		代价是把一切都照成诡异的绿色荧光。据说戴上它还能让你看到身后。"
	icon_state = "night_visor"
	incompatible_modules = list(/obj/item/mod/module/visor, /obj/item/mod/module/night)
	visor_traits = list(TRAIT_TRUE_NIGHT_VISION)

/obj/item/mod/module/night // Not Visor type so that it remains compatible with other visors
	name = "\improper MOD 夜视模块"
	desc = "安装在套装护目镜里的平视显示器。这在民用和军用领域都很常见， \
		它让使用者能在完全黑暗中看清周围环境，将视野增强十倍； \
		代价是把一切都照成诡异的绿色荧光。据说戴上它还能让你看到身后。 \
		这一款是特殊版本，可以与其他护目镜模块兼容。"
	icon_state = "night_visor"
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.1
	complexity = 0
	removable = FALSE
	module_type = MODULE_TOGGLE
	incompatible_modules = list(/obj/item/mod/module/night, /obj/item/mod/module/visor/night)
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_EYES|ITEM_SLOT_MASK)

/obj/item/mod/module/night/on_activation(mob/activator)
	ADD_TRAIT(mod.wearer, TRAIT_TRUE_NIGHT_VISION, REF(src))

/obj/item/mod/module/night/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_TRUE_NIGHT_VISION, REF(src))
