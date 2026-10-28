//General modules for MODsuits

///Storage - Adds a storage component to the suit.
/obj/item/mod/module/storage
	name = "\improper MOD 紧凑存储模块"
	desc = "本质上是一系列集成储物隔间和专用口袋，安装在\
		套装表面各处，适合存放各种零零碎碎。这个版本经过精简以节省空间。"
	icon_state = "storage"
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/storage, /obj/item/mod/module/plate_compression)
	required_slots = list(ITEM_SLOT_BACK)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// The storage type to create for the module
	var/datum/storage/storage_type = /datum/storage/mod_storage

/obj/item/mod/module/storage/Initialize(mapload)
	. = ..()
	if(storage_type)
		create_storage(storage_type = storage_type)
		atom_storage.set_locked(STORAGE_FULLY_LOCKED)

/obj/item/mod/module/storage/on_install()
	. = ..()
	var/datum/storage/modstorage = mod.create_storage(storage_type = storage_type)
	modstorage.set_real_location(src)
	atom_storage.set_locked(STORAGE_NOT_LOCKED)
	var/obj/item/clothing/suit = mod.get_part_from_slot(ITEM_SLOT_OCLOTHING)
	if(istype(suit))
		RegisterSignal(suit, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(on_suit_unequip))
	// You could easily allow modsuits to be strip accessible like backpacks like so
	// But we figured there should be special handling for stuff like DNA locks first
	// mod.AddElement(/datum/element/strip_accessible_storage)

/obj/item/mod/module/storage/on_uninstall(deleting = FALSE)
	. = ..()
	atom_storage.set_locked(STORAGE_FULLY_LOCKED)
	QDEL_NULL(mod.atom_storage)
	if(!deleting)
		atom_storage.remove_all(mod.drop_location())
	var/obj/item/clothing/suit = mod.get_part_from_slot(ITEM_SLOT_OCLOTHING)
	if(istype(suit))
		UnregisterSignal(suit, COMSIG_ITEM_PRE_UNEQUIP)
	// mod.RemoveElement(/datum/element/strip_accessible_storage)

/obj/item/mod/module/storage/proc/on_suit_unequip(obj/item/source, force, atom/newloc, no_move, invdrop, silent)
	if(QDELETED(source) || !invdrop || !mod.wearer || newloc == mod.wearer || !mod.wearer.s_store)
		return
	if(!atom_storage?.attempt_insert(mod.wearer.s_store, mod.wearer, override = TRUE))
		balloon_alert(mod.wearer, "收纳失败！")
		to_chat(mod.wearer, span_warning("[src] 无法将 [mod.wearer.s_store] 收纳进自身！"))
		return
	to_chat(mod.wearer, span_notice("[src] 将 [mod.wearer.s_store] 收纳进自身。"))
	mod.wearer.temporarilyRemoveItemFromInventory(mod.wearer.s_store)

/obj/item/mod/module/storage/large_capacity
	name = "\improper MOD 存储模块"
	desc = "中村工程公司根据咚克公司的设计逆向研制的这套隐藏隔间系统，\
		完全位于套装内部，能均匀分散物品和重量，确保使用者获得舒适的体验；\
		无论是用于走私，还是单纯搬运。"
	complexity = 3
	icon_state = "storage_large"
	storage_type = /datum/storage/mod_storage/expanded
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/uranium = SHEET_MATERIAL_AMOUNT)

/obj/item/mod/module/storage/syndicate
	name = "\improper MOD 辛迪加存储模块"
	desc = "一种使用赛博太阳工业研发的纳米技术的存储系统，这些隔间利用\
		深奥的技术压缩放入其中的物品的物理物质，\
		本质上就是把物品缩小，以便更轻松、更便携地存放。"
	complexity = 3
	icon_state = "storage_syndi"
	storage_type = /datum/storage/mod_storage/syndicate

/obj/item/mod/module/storage/belt
	name = "\improper MOD 储物箱模块"
	desc = "在制造压缩式模块化套装核心时，总得做出一些妥协。\
		因此，玫瑰银河公司为其套装配备了一个薄型储物箱。\
		如果你发现标准模块化套装上装着这个，那几乎可以肯定有人在正规存储模块上坑了你。"
	icon_state = "storage_case"
	complexity = 0
	required_slots = list(ITEM_SLOT_BELT)
	storage_type = /datum/storage/mod_storage/belt

/obj/item/mod/module/storage/bluespace
	name = "\improper MOD 蓝空间存储模块"
	desc = "一种由纳米传讯研发的存储系统，这些隔间采用\
		微型化的蓝空间口袋，代表了存储技术的极致；无论放入其中的物体有多重。"
	complexity = 3
	icon_state = "storage_large"
	storage_type = /datum/storage/mod_storage/bluespace

///Ion Jetpack - Lets the user fly freely through space using battery charge.
/obj/item/mod/module/jetpack
	name = "\improper MOD 离子喷气背包模块"
	desc = "一系列安装在套装各处的电动推进器，是见习工程师们高度期待的模块。\
		这些喷气器不靠燃气燃烧推进，而是用套装的电量加速离子。\
		有人说这并非中村工程公司第一次涉足带喷气功能的套装。"
	icon_state = "jetpack"
	module_type = MODULE_TOGGLE
	complexity = 3
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.05
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/jetpack)
	overlay_state_inactive = "module_jetpack"
	overlay_state_active = "module_jetpack_on"
	required_slots = list(ITEM_SLOT_BACK)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)
	/// Do we have stabilizers? If yes the user won't move from inertia.
	var/stabilize = TRUE
	/// Callback to see if we can thrust the user.
	var/thrust_callback
	/// How much force this module can apply per tick
	var/drift_force = 1.5 NEWTONS

/obj/item/mod/module/jetpack/Initialize(mapload)
	. = ..()
	thrust_callback = CALLBACK(src, PROC_REF(allow_thrust))
	configure_jetpack(stabilize)

/obj/item/mod/module/jetpack/Destroy()
	thrust_callback = null
	return ..()

/**
 * configures/re-configures the jetpack component
 *
 * Arguments
 * stabilize - Should this jetpack be stabalized
 */
/obj/item/mod/module/jetpack/proc/configure_jetpack(stabilize)
	src.stabilize = stabilize

	AddComponent( \
		/datum/component/jetpack, \
		src.stabilize, \
		drift_force, \
		COMSIG_MODULE_TRIGGERED, \
		COMSIG_MODULE_DEACTIVATED, \
		MOD_ABORT_USE, \
		thrust_callback, \
		thrust_callback, \
		/datum/effect_system/trail_follow/ion/grav_allowed, \
	)

	if (!isnull(mod) && !isnull(mod.wearer) && mod.wearer.get_item_by_slot(slot_flags) == src)
		if (!stabilize)
			ADD_TRAIT(mod.wearer, TRAIT_NOGRAV_ALWAYS_DRIFT, REF(src))
		else
			REMOVE_TRAIT(mod.wearer, TRAIT_NOGRAV_ALWAYS_DRIFT, REF(src))

/obj/item/mod/module/jetpack/get_configuration()
	. = ..()
	.["stabilizers"] = add_ui_configuration("稳定器", "bool", stabilize)

/obj/item/mod/module/jetpack/configure_edit(key, value)
	switch(key)
		if("stabilizers")
			configure_jetpack(text2num(value))

/obj/item/mod/module/jetpack/proc/allow_thrust(use_fuel = TRUE)
	if(!use_fuel)
		return check_power(use_energy_cost)
	if(!drain_power(use_energy_cost))
		return FALSE
	return TRUE

/obj/item/mod/module/jetpack/on_activation(mob/activator)
	mod.wearer.add_movespeed_modifier(/datum/movespeed_modifier/jetpack/full_speed)
	if (!stabilize)
		ADD_TRAIT(mod.wearer, TRAIT_NOGRAV_ALWAYS_DRIFT, REF(src))

/obj/item/mod/module/jetpack/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	mod.wearer.remove_movespeed_modifier(/datum/movespeed_modifier/jetpack/full_speed)
	REMOVE_TRAIT(mod.wearer, TRAIT_NOGRAV_ALWAYS_DRIFT, REF(src))

/obj/item/mod/module/jetpack/advanced
	name = "\improper MOD 高级离子喷气背包模块"
	desc = "对前代电动推进器的改进。这一型号通过加装更多喷气口\
		并涂上红色涂料，实现了更高的精度和空间稳定性。"
	icon_state = "jetpack_advanced"
	overlay_state_inactive = "module_jetpackadv"
	overlay_state_active = "module_jetpackadv_on"
	drift_force = 2 NEWTONS

/// Cooldown to use if we didn't actually launch a jump jet
#define FAILED_ACTIVATION_COOLDOWN 3 SECONDS

///Jump Jet - Briefly removes the effect of gravity and pushes you up one z-level if possible.
/obj/item/mod/module/jump_jet
	name = "\improper MOD 离子跳跃喷气模块"
	desc = "一种专用离子推进器，能提供短暂而强劲、足以对抗重力的推力，\
		但之后需要时间充能。"
	icon_state = "jump_jet"
	module_type = MODULE_USABLE
	complexity = 3
	cooldown_time = 30 SECONDS
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/jump_jet)
	required_slots = list(ITEM_SLOT_BACK)

/obj/item/mod/module/jump_jet/on_use(mob/activator)
	if (DOING_INTERACTION(mod.wearer, mod.wearer))
		balloon_alert(activator, "忙！")
		return
	balloon_alert(mod.wearer, "正在发射……")
	mod.wearer.Shake(duration = 1 SECONDS)
	if (!do_after(mod.wearer, 1 SECONDS, target = mod.wearer))
		start_cooldown(FAILED_ACTIVATION_COOLDOWN) // Don't go on full cooldown if we failed to launch
		return FALSE
	playsound(mod.wearer, 'sound/vehicles/rocketlaunch.ogg', 100, TRUE)
	mod.wearer.apply_status_effect(/datum/status_effect/jump_jet)
	var/turf/launch_from = get_turf(mod.wearer)
	if (mod.wearer.zMove(UP, z_move_flags = ZMOVE_CHECK_PULLS))
		launch_from.visible_message(span_warning("[mod.wearer] 腾空而起！"))
	new /obj/effect/temp_visual/jet_plume(launch_from)

	var/obj/item/mod/module/jetpack/linked_jetpack = locate() in mod.modules
	if (!isnull(linked_jetpack) && !linked_jetpack.active)
		linked_jetpack.on_activation()
	return TRUE

#undef FAILED_ACTIVATION_COOLDOWN

///Status Readout - Puts a lot of information including health, nutrition, fingerprints, temperature to the suit TGUI.
/obj/item/mod/module/status_readout
	name = "\improper MOD 状态读取模块"
	desc = "一种曾经很常见的模块，可惜这项技术在太空较安全的地区已经不再流行；\
		却在顺旋边区的科研网络中获得了新生。这个特定单元会接入套装的脊柱，\
		能够采集并显示佩戴者所有可获取的生物特征数据；睡眠、营养、体能、指纹，\
		甚至还有整体健康状况之类的有用信息。生命体征监测器还配有一个扬声器，音量足够大，\
		能让附近所有人都知道有人确实死了。"
	icon_state = "status"
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 0.1
	incompatible_modules = list(/obj/item/mod/module/status_readout)
	tgui_id = "status_readout"
	required_slots = list(ITEM_SLOT_BACK)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2)
	/// Does this show damage types, body temp, satiety?
	var/display_detailed_vitals = TRUE
	/// Does this show DNA data?
	var/display_dna = FALSE
	/// Does this show the round ID and shift time?
	var/display_time = FALSE
	/// Death sound. May or may not be funny. Vareditable at your own risk.
	var/death_sound = 'sound/effects/flatline3.ogg'
	/// Death sound volume. Please be responsible with this.
	var/death_sound_volume = 50
	/// Does this boost suit sensor status across Z-levels?
	var/sensor_boost = TRUE

/obj/item/mod/module/status_readout/add_ui_data()
	. = ..()
	.["display_time"] = display_time
	.["shift_time"] = round_timestamp()
	.["shift_id"] = GLOB.round_id
	.["health"] = mod.wearer?.health || 0
	.["health_max"] = mod.wearer?.getMaxHealth() || 0
	if(display_detailed_vitals)
		.["loss_brute"] = mod.wearer?.get_brute_loss() || 0
		.["loss_fire"] = mod.wearer?.get_fire_loss() || 0
		.["loss_tox"] = mod.wearer?.get_tox_loss() || 0
		.["loss_oxy"] = mod.wearer?.get_oxy_loss() || 0
		.["body_temperature"] = mod.wearer?.bodytemperature || 0
		.["nutrition"] = mod.wearer?.nutrition || 0
	if(display_dna)
		.["dna_unique_identity"] = mod.wearer ? md5(mod.wearer.dna.unique_identity) : null
		.["dna_unique_enzymes"] = mod.wearer?.dna.unique_enzymes
	.["viruses"] = null
	if(!length(mod.wearer?.diseases))
		return .
	var/list/viruses = list()
	for(var/datum/disease/virus as anything in mod.wearer.diseases)
		var/list/virus_data = list()
		virus_data["name"] = virus.name
		virus_data["type"] = virus.spread_text
		virus_data["stage"] = virus.stage
		virus_data["maxstage"] = virus.max_stages
		virus_data["cure"] = virus.cure_text
		viruses += list(virus_data)
	.["viruses"] = viruses

	return .

/obj/item/mod/module/status_readout/get_configuration()
	. = ..()
	.["display_detailed_vitals"] = add_ui_configuration("详细生命体征", "bool", display_detailed_vitals)
	.["display_dna"] = add_ui_configuration("DNA 信息", "bool", display_dna)
	.["sensor_boost"] = add_ui_configuration("套装传感器增强", "bool", sensor_boost)

/obj/item/mod/module/status_readout/configure_edit(key, value)
	switch(key)
		if("display_detailed_vitals")
			display_detailed_vitals = text2num(value)
		if("display_dna")
			display_dna = text2num(value)
		if("sensor_boost")
			sensor_boost = text2num(value)
			update_sensor_booster()

/obj/item/mod/module/status_readout/on_part_activation()
	RegisterSignal(mod.wearer, COMSIG_LIVING_DEATH, PROC_REF(death_sound))
	update_sensor_booster()

/obj/item/mod/module/status_readout/on_part_deactivation(deleting)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_DEATH)
	REMOVE_TRAIT(mod.wearer, TRAIT_MULTIZ_SUIT_SENSORS, REF(src))

/obj/item/mod/module/status_readout/proc/update_sensor_booster()
	if(sensor_boost)
		ADD_TRAIT(mod.wearer, TRAIT_MULTIZ_SUIT_SENSORS, REF(src))
	else
		REMOVE_TRAIT(mod.wearer, TRAIT_MULTIZ_SUIT_SENSORS, REF(src))

/obj/item/mod/module/status_readout/proc/death_sound(mob/living/carbon/human/wearer)
	SIGNAL_HANDLER
	if(death_sound && death_sound_volume)
		playsound(wearer, death_sound, death_sound_volume, FALSE)

///Eating Apparatus - Lets the user eat/drink with the suit on.
/obj/item/mod/module/mouthhole
	name = "\improper MOD 进食装置模块"
	desc = "矿工们的最爱，这项头盔改装在嘴部前方利用一层纳米技术屏障，\
		让使用者能在保持防护和气压的同时吃喝。不过，它不能让你摆脱面罩，\
		胡椒喷雾仍能穿过，而且它也无法改善歌利亚牛排的味道。"
	icon_state = "apparatus"
	complexity = 1
	incompatible_modules = list(/obj/item/mod/module/mouthhole)
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_MASK)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	/// Former flags of the helmet.
	var/former_helmet_flags = NONE
	/// Former visor flags of the helmet.
	var/former_visor_helmet_flags = NONE
	/// Former flags of the mask.
	var/former_mask_flags = NONE
	/// Former visor flags of the mask.
	var/former_visor_mask_flags = NONE

/obj/item/mod/module/mouthhole/on_install()
	. = ..()
	var/obj/item/clothing/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(istype(helmet))
		former_helmet_flags = helmet.flags_cover
		former_visor_helmet_flags = helmet.visor_flags_cover
		helmet.flags_cover &= ~(HEADCOVERSMOUTH|PEPPERPROOF)
		helmet.visor_flags_cover &= ~(HEADCOVERSMOUTH|PEPPERPROOF)
	var/obj/item/clothing/mask = mod.get_part_from_slot(ITEM_SLOT_MASK)
	if(istype(mask))
		former_mask_flags = mask.flags_cover
		former_visor_mask_flags = mask.visor_flags_cover
		mask.flags_cover &= ~(MASKCOVERSMOUTH |PEPPERPROOF)
		mask.visor_flags_cover &= ~(MASKCOVERSMOUTH |PEPPERPROOF)

/obj/item/mod/module/mouthhole/can_install(obj/item/mod/control/mod)
	var/obj/item/clothing/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	var/obj/item/clothing/mask = mod.get_part_from_slot(ITEM_SLOT_MASK)
	if(istype(helmet) && ((helmet.flags_cover|helmet.visor_flags_cover) & (HEADCOVERSMOUTH|PEPPERPROOF)))
		return ..()
	if(istype(mask) && ((mask.flags_cover|mask.visor_flags_cover) & (MASKCOVERSMOUTH|PEPPERPROOF)))
		return ..()
	return FALSE

/obj/item/mod/module/mouthhole/on_uninstall(deleting = FALSE)
	. = ..()
	if(deleting)
		return
	var/obj/item/clothing/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(istype(helmet))
		helmet.flags_cover |= former_helmet_flags
		helmet.visor_flags_cover |= former_visor_helmet_flags
	var/obj/item/clothing/mask = mod.get_part_from_slot(ITEM_SLOT_MASK)
	if(istype(mask))
		mask.flags_cover |= former_mask_flags
		mask.visor_flags_cover |= former_visor_mask_flags

///EMP Shield - Protects the suit from EMPs.
/obj/item/mod/module/emp_shield
	name = "\improper MOD EMP 护盾模块"
	desc = "一种安装在套装内的场抑制器，可保护套装免受反馈伤害，例如\
		电磁脉冲，否则这些脉冲会损坏套装或其模块的电子系统。\
		不过，这么做会消耗套装的电力。"
	icon_state = "empshield"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/emp_shield)
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5)
	/// How much emp protection this module grants to its wearer when fully extended.
	var/protection_factor = EMP_PROTECTION_MODERATE

/obj/item/mod/module/emp_shield/on_install()
	. = ..()
	mod.AddElement(/datum/element/empprotection, EMP_PROTECT_ALL)
	var/list/all_parts = mod.get_parts()
	for(var/obj/item/clothing/mod_part as anything in all_parts)
		mod_part.emp_protection += protection_factor/all_parts.len

/obj/item/mod/module/emp_shield/on_uninstall(deleting = FALSE)
	. = ..()
	mod.RemoveElement(/datum/element/empprotection, EMP_PROTECT_ALL)
	var/list/all_parts = mod.get_parts()
	for(var/obj/item/clothing/mod_part as anything in all_parts)
		mod_part.emp_protection -= protection_factor/all_parts.len

/obj/item/mod/module/emp_shield/advanced
	name = "\improper MOD 高级 EMP 护盾模块"
	desc = "一种安装在套装内的高级场抑制器，可保护套装免受反馈伤害，例如\
		电磁脉冲，否则这些脉冲会损坏套装或佩戴者身上电子设备的电子系统，\
		包括义体增强。不过，这么做会消耗套装的电力。"
	complexity = 2

/obj/item/mod/module/emp_shield/advanced/on_part_activation()
	mod.wearer.AddElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)

/obj/item/mod/module/emp_shield/advanced/on_part_deactivation(deleting = FALSE)
	mod.wearer.RemoveElement(/datum/element/empprotection, EMP_PROTECT_SELF|EMP_PROTECT_CONTENTS)

///Flashlight - Gives the suit a customizable flashlight.
/obj/item/mod/module/flashlight
	name = "\improper MOD 手电筒模块"
	desc = "一对简单的可调手电筒，安装在头盔左右两侧，\
		能在多种范围和颜色下提供照明。\
		有些生存主义者偏爱用绿光照明，原因不明。"
	icon_state = "flashlight"
	module_type = MODULE_TOGGLE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/flashlight)
	overlay_state_inactive = "module_light"
	light_system = OVERLAY_LIGHT_DIRECTIONAL
	light_color = COLOR_WHITE
	light_range = 4
	light_power = 1
	light_on = FALSE
	required_slots = list(ITEM_SLOT_HEAD|ITEM_SLOT_MASK)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// Charge drain per range amount.
	var/base_power = DEFAULT_CHARGE_DRAIN * 0.1
	/// Minimum range we can set.
	var/min_range = 2
	/// Maximum range we can set.
	var/max_range = 5

/obj/item/mod/module/flashlight/on_activation(mob/activator)
	set_light_flags(light_flags | LIGHT_ATTACHED)
	set_light_on(active)
	active_power_cost = base_power * light_range

/obj/item/mod/module/flashlight/on_deactivation(mob/activator, display_message = TRUE, deleting = FALSE)
	set_light_flags(light_flags & ~LIGHT_ATTACHED)
	set_light_on(active)

/obj/item/mod/module/flashlight/on_saboteur(datum/source, disrupt_duration)
	. = ..()
	if(active)
		on_deactivation()
		return TRUE

/obj/item/mod/module/flashlight/on_process(seconds_per_tick)
	active_power_cost = base_power * light_range
	return ..()

/obj/item/mod/module/flashlight/generate_worn_overlay(obj/item/source, mutable_appearance/standing)
	. = ..()
	if(!active)
		return
	var/mutable_appearance/light_icon = mutable_appearance(overlay_icon_file, "module_light_on", layer = standing.layer + 0.2, appearance_flags = RESET_COLOR)
	light_icon.color = light_color
	. += light_icon

/obj/item/mod/module/flashlight/get_configuration()
	. = ..()
	.["light_color"] = add_ui_configuration("灯光颜色", "color", light_color)
	.["light_range"] = add_ui_configuration("照明范围", "number", light_range)

/obj/item/mod/module/flashlight/configure_edit(key, value)
	switch(key)
		if("light_color")
			value = tgui_color_picker(usr, "选择新的灯光颜色", "手电筒颜色")
			if(!value)
				return
			if(is_color_dark(value, 50))
				balloon_alert(mod.wearer, "太暗了！")
				return
			set_light_color(value)
			update_clothing_slots()
		if("light_range")
			set_light_range(clamp(value, min_range, max_range))

///Like the flashlight module, except the light color is stuck to black and cannot be changed.
/obj/item/mod/module/flashlight/darkness
	name = "\improper MOD 暗光手电模块"
	desc = "一对古怪的可调暗光手电，安装在头盔两侧，\
		能在可调范围内提供黑暗。"
	light_color = COLOR_BLACK
	light_system = OVERLAY_LIGHT
	light_range = 2
	min_range = 1
	max_range = 3

/obj/item/mod/module/flashlight/darkness/get_configuration()
	. = ..()
	. -= "light_color"

///Dispenser - Dispenses an item after a time passes.
/obj/item/mod/module/dispenser
	name = "\improper MOD 汉堡配发模块"
	desc = "一件罕见的逆向工程设备，原型来自一艘咚克公司的飞船。\
		它能从套装的电量中抽取惊人的能量，在使用者手套的掌心\
		制造可食用的有机物；不过，研究似乎完全止步于汉堡。\
		值得注意的是，所有让它配发伯爵红茶的尝试都失败了。"
	icon_state = "dispenser"
	module_type = MODULE_USABLE
	complexity = 3
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 2
	incompatible_modules = list(/obj/item/mod/module/dispenser)
	cooldown_time = 5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	/// Path we dispense.
	var/dispense_type = /obj/item/food/burger/plain
	/// Time it takes for us to dispense.
	var/dispense_time = 0 SECONDS

/obj/item/mod/module/dispenser/on_use(mob/activator)
	if(dispense_time && !do_after(mod.wearer, dispense_time, target = mod))
		balloon_alert(mod.wearer, "被打断了！")
		return FALSE
	var/obj/item/dispensed = new dispense_type(mod.wearer.loc)
	mod.wearer.put_in_hands(dispensed)
	balloon_alert(activator, "已配发 [dispensed]")
	playsound(src, 'sound/machines/click.ogg', 100, TRUE)
	drain_power(use_energy_cost)
	return dispensed

///Longfall - Nullifies fall damage, removing charge instead.
/obj/item/mod/module/longfall
	name = "\improper MOD 坠落缓冲模块"
	desc = "既能保护套装也能保护佩戴者，\
		利用常见系统将坠落可能造成的伤害转化为动能电荷，\
		并用内置陀螺仪确保使用者安全落地。\
		对采矿、单轨铁路甚至跳伞都很有用！"
	icon_state = "longfall"
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 5
	incompatible_modules = list(/obj/item/mod/module/longfall)
	required_slots = list(ITEM_SLOT_FEET)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/longfall/on_part_activation()
	RegisterSignal(mod.wearer, COMSIG_LIVING_Z_IMPACT, PROC_REF(z_impact_react))

/obj/item/mod/module/longfall/on_part_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_LIVING_Z_IMPACT)

/obj/item/mod/module/longfall/proc/z_impact_react(datum/source, levels, turf/fell_on)
	SIGNAL_HANDLER
	if(!drain_power(use_energy_cost * levels))
		return NONE
	new /obj/effect/temp_visual/mook_dust(fell_on)

	/// Boolean that tracks whether we fell more than one z-level. If TRUE, we stagger our wearer.
	var/extreme_fall = FALSE

	if(levels >= 2)
		extreme_fall = TRUE
		mod.wearer.adjust_staggered_up_to(STAGGERED_SLOWDOWN_LENGTH * levels, 10 SECONDS)

	mod.wearer.visible_message(
		span_notice("[mod.wearer] 安全地落在 [fell_on] 上[extreme_fall ? "，但勉强才站稳脚跟。" : "，而且相当帅气地稳稳站住" ]。"),
		span_notice("[src] 保护你免受伤害！"),
	)
	return ZIMPACT_CANCEL_DAMAGE|ZIMPACT_NO_MESSAGE|ZIMPACT_NO_SPIN

///Thermal Regulator - Regulates the wearer's core temperature.
/obj/item/mod/module/thermal_regulator
	name = "\improper MOD 温度调节模块"
	desc = "先进的气候控制系统，使用一件贴身内衬，其中交织着数千条细小而\
		柔韧的冷却管路。它让冷却液以使用者设定的各种温度循环，\
		确保他们始终舒适；即便他们属于喜欢高温的那类人。"
	icon_state = "regulator"
	module_type = MODULE_TOGGLE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/thermal_regulator)
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// The temperature we are regulating to.
	var/temperature_setting = BODYTEMP_NORMAL
	/// Minimum temperature we can set.
	var/min_temp = T20C
	/// Maximum temperature we can set.
	var/max_temp = 318.15

/obj/item/mod/module/thermal_regulator/get_configuration()
	. = ..()
	.["temperature_setting"] = add_ui_configuration("温度", "number", temperature_setting - T0C)

/obj/item/mod/module/thermal_regulator/configure_edit(key, value)
	switch(key)
		if("temperature_setting")
			temperature_setting = clamp(value + T0C, min_temp, max_temp)

/obj/item/mod/module/thermal_regulator/on_active_process(seconds_per_tick)
	mod.wearer.adjust_bodytemperature(get_temp_change_amount((temperature_setting - mod.wearer.bodytemperature), BODYTEMP_SUIT_CHANGE_RATE * seconds_per_tick))

///DNA Lock - Prevents people without the set DNA from activating the suit.
/obj/item/mod/module/dna_lock
	name = "\improper MOD DNA 锁模块"
	desc = "一种与套装系统上的各种锁具和密封装置联动的模块，\
		使套装只能被与使用者 DNA 完全相符的人穿戴；\
		不过，这个极其敏感的模块会被 EMP 烧毁。幸好克隆已被取缔。"
	icon_state = "dnalock"
	module_type = MODULE_USABLE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 3
	incompatible_modules = list(/obj/item/mod/module/dna_lock, /obj/item/mod/module/eradication_lock)
	cooldown_time = 0.5 SECONDS
	custom_materials = list(/datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// The DNA we lock with.
	var/dna = null

/obj/item/mod/module/dna_lock/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_MOD_ACTIVATE, PROC_REF(on_mod_activation))
	RegisterSignal(mod, COMSIG_MOD_MODULE_REMOVAL, PROC_REF(on_mod_removal))
	RegisterSignal(mod, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))
	RegisterSignal(mod, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag))

/obj/item/mod/module/dna_lock/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, COMSIG_MOD_ACTIVATE)
	UnregisterSignal(mod, COMSIG_MOD_MODULE_REMOVAL)
	UnregisterSignal(mod, COMSIG_ATOM_EMP_ACT)
	UnregisterSignal(mod, COMSIG_ATOM_EMAG_ACT)

/obj/item/mod/module/dna_lock/on_use(mob/activator)
	/// Bubber Edit Start - Proteans
	if(istype(mod, /obj/item/mod/control/pre_equipped/protean))
		var/obj/item/mod/control/pre_equipped/protean/p_suit = mod
		var/obj/item/mod/core/protean/p_core = mod.core
		var/datum/species/protean/species = p_core.linked_species
		if(species.owner.loc == p_suit.loc)
			return balloon_alert(p_suit.wearer, "按钮无响应")
	/// Bubber Edit End
	dna = mod.wearer.dna.unique_enzymes
	balloon_alert(activator, "DNA 已更新")
	drain_power(use_energy_cost)

/obj/item/mod/module/dna_lock/emp_act(severity)
	. = ..()
	on_emp(src, severity, .)

/obj/item/mod/module/dna_lock/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	return on_emag(src, user, emag_card)

/obj/item/mod/module/dna_lock/proc/dna_check(mob/user)
	if(!iscarbon(user))
		return FALSE
	/// Bubber Edit Start
	var/obj/item/mod/control/pre_equipped/protean/suit = mod
	if(istype(suit))
		return TRUE
	/// Bubber Edit End
	var/mob/living/carbon/carbon_user = user
	if(!dna  || (carbon_user.has_dna() && carbon_user.dna.unique_enzymes == dna))
		return TRUE
	balloon_alert(user, "DNA 已锁定！")
	return FALSE

/obj/item/mod/module/dna_lock/proc/on_emp(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	dna = null

/obj/item/mod/module/dna_lock/proc/on_emag(datum/source, mob/user, obj/item/card/emag/emag_card)
	SIGNAL_HANDLER

	dna = null
	return TRUE

/obj/item/mod/module/dna_lock/proc/on_mod_activation(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!dna_check(user))
		return MOD_CANCEL_ACTIVATE

/obj/item/mod/module/dna_lock/proc/on_mod_removal(datum/source, mob/user)
	SIGNAL_HANDLER

	if(!dna_check(user))
		return MOD_CANCEL_REMOVAL

///Plasma Stabilizer - Prevents plasmamen from igniting in the suit
/obj/item/mod/module/plasma_stabilizer
	name = "\improper MOD 等离子稳定模块"
	desc = "这套系统本质上在套装内部形成了一个独立的大气环境，\
		高效而迅速地防止氧气让使用者的头部燃起火焰。\
		这让等离子人得以安全地摘下头盔，从而更方便地\
		装备任何与 MOD 套装相关的设备，或者其他东西。\
		面罩上那片紫色玻璃似乎是为了怀旧而造的。"
	icon_state = "plasma_stabilizer"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/plasma_stabilizer)
	required_slots = list(ITEM_SLOT_HEAD)
	custom_materials = list(/datum/material/plasma = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/plasma_stabilizer/generate_worn_overlay(obj/item/source, mutable_appearance/standing)
	. = ..()
	if (!.)
		return

	var/mutable_appearance/visor_overlay = mod.get_visor_overlay(standing)
	visor_overlay.appearance_flags |= RESET_COLOR
	visor_overlay.color = COLOR_VIOLET
	. += visor_overlay

/obj/item/mod/module/plasma_stabilizer/on_equip()
	ADD_TRAIT(mod.wearer, TRAIT_HEAD_ATMOS_SEALED, REF(src))

/obj/item/mod/module/plasma_stabilizer/on_unequip()
	REMOVE_TRAIT(mod.wearer, TRAIT_HEAD_ATMOS_SEALED, REF(src))


//Finally, https://pipe.miroware.io/5b52ba1d94357d5d623f74aa/mspfa/Nuke%20Ops/Panels/0648.gif can be real:
///Hat Stabilizer - Allows displaying a hat over the MOD-helmet, à la plasmamen helmets.
/obj/item/mod/module/hat_stabilizer
	name = "\improper MOD 帽子固定模块"
	desc = "一套简单的可展开支架，直接位于头顶；\
		这些支架会在帽子下方展开，防止帽子掉落，使帽子能戴在密闭头盔之上。\
		不过，头盔展开时你仍需要先把帽子从头上取下。\
		对纳米传讯的舰长们来说这是必备之物，能让他们即使穿着 MOD 套装也能炫耀那顶权威十足的帽子。"
	icon_state = "hat_holder"
	incompatible_modules = list(/obj/item/mod/module/hat_stabilizer)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)
	required_slots = list(ITEM_SLOT_HEAD)
	/*Intentionally left inheriting 0 complexity and removable = TRUE;
	even though it comes inbuilt into the Magnate/Corporate MODS and spawns in maints, I like the idea of stealing them*/
	/// Original cover flags for the MOD helmet, before a hat is placed
	var/former_flags
	var/former_visor_flags

/obj/item/mod/module/hat_stabilizer/on_part_activation()
	var/obj/item/clothing/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(!istype(helmet))
		return
	// Override pre-existing component
	helmet.AddComponent(/datum/component/hat_stabilizer, loose_hat = FALSE)

/obj/item/mod/module/hat_stabilizer/on_part_deactivation(deleting = FALSE)
	if(deleting)
		return
	var/obj/item/clothing/helmet = mod.get_part_from_slot(ITEM_SLOT_HEAD)
	if(!istype(helmet))
		return
	// Override again!
	helmet.AddComponent(/datum/component/hat_stabilizer, loose_hat = TRUE)

/obj/item/mod/module/hat_stabilizer/syndicate
	name = "\improper MOD 精英帽子固定模块"
	desc = "一套简单的可展开支架，直接位于头顶；\
		这些支架会在帽子下方展开，防止帽子掉落，使帽子能戴在密闭头盔之上。\
		不过，头盔展开时你仍需要先把帽子从头上取下。对\
		辛迪加特工和代理人来说这都是必备之物，能让他们即使穿着 MOD 套装也能继续在对手面前耍帅。"
	complexity = 0
	removable = FALSE

///Sign Language Translator - allows people to sign over comms using the modsuit's gloves.
/obj/item/mod/module/signlang_radio
	name = "\improper MOD 手套翻译模块"
	desc = "一种在套装手套中加入运动传感器的模块，\
		它与一台短程亚空间发射器配合工作，\
		让听觉受损者能在通讯频道上使用手语。"
	icon_state = "signlang_radio"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/signlang_radio)
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)

/obj/item/mod/module/signlang_radio/on_part_activation()
	ADD_TRAIT(mod.wearer, TRAIT_CAN_SIGN_ON_COMMS, REF(src))

/obj/item/mod/module/signlang_radio/on_part_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_CAN_SIGN_ON_COMMS, REF(src))

///A module that recharges the suit by an itsy tiny bit whenever the user takes a step. Originally called "magneto module" but the videogame reference sounds cooler.
/obj/item/mod/module/joint_torsion
	name = "\improper MOD 关节扭转棘轮模块"
	desc = "一台紧凑而微弱的交流发电机，靠行走为套装的内部电池充电。在零重力下不管用。可以安装多个。"
	icon_state = "joint_torsion"
	complexity = 1
	required_slots = list(ITEM_SLOT_FEET)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 2.5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT)
	var/power_per_step = DEFAULT_CHARGE_DRAIN * 0.45

/obj/item/mod/module/joint_torsion/on_part_activation()
	if(!(mod.wearer.movement_type & (FLOATING|FLYING)))
		RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))
	/// This way we don't even bother to call on_moved() while flying/floating
	RegisterSignal(mod.wearer, COMSIG_MOVETYPE_FLAG_ENABLED, PROC_REF(on_movetype_flag_enabled))
	RegisterSignal(mod.wearer, COMSIG_MOVETYPE_FLAG_DISABLED, PROC_REF(on_movetype_flag_disabled))

/obj/item/mod/module/joint_torsion/on_part_deactivation(deleting = FALSE)
	UnregisterSignal(mod.wearer, list(COMSIG_MOVABLE_MOVED, COMSIG_MOVETYPE_FLAG_ENABLED, COMSIG_MOVETYPE_FLAG_DISABLED))

/obj/item/mod/module/joint_torsion/proc/on_movetype_flag_enabled(datum/source, flag, old_state)
	SIGNAL_HANDLER
	if(!(old_state & (FLOATING|FLYING)) && flag & (FLOATING|FLYING))
		UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)

/obj/item/mod/module/joint_torsion/proc/on_movetype_flag_disabled(datum/source, flag, old_state)
	SIGNAL_HANDLER
	if(old_state & (FLOATING|FLYING) && !(mod.wearer.movement_type & (FLOATING|FLYING)))
		RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_moved))

/obj/item/mod/module/joint_torsion/proc/on_moved(mob/living/carbon/human/wearer, atom/old_loc, movement_dir, forced)
	SIGNAL_HANDLER
	//Shouldn't work if the wearer isn't really walking/running around.
	if(forced || wearer.throwing || wearer.body_position == LYING_DOWN || wearer.buckled || CHECK_MOVE_LOOP_FLAGS(wearer, MOVEMENT_LOOP_OUTSIDE_CONTROL))
		return
	mod.core.add_charge(power_per_step)

/// Module that shoves garbage inside its material container when the user crosses it, and eject the recycled material with MMB.
/obj/item/mod/module/recycler
	name = "\improper MOD 回收模块"
	desc = "一种创新的垃圾收集模块，能把收集到的垃圾回收成可用的材料。\
		对残骸和某些物品无效。可能会回收实弹弹药。\
		对附近的地面或储物容器使用可卸载已存储的材料。"
	icon_state = "recycler"
	module_type = MODULE_ACTIVE
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.5
	complexity = 2
	incompatible_modules = list(/obj/item/mod/module/recycler)
	overlay_state_inactive = "module_recycler"
	overlay_state_active = "module_recycler"
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 2)
	/// A multiplier of the amount of material extracted from the item
	var/efficiency = 1
	/// Items that will be collected
	var/list/allowed_item_types = list(
		/obj/item/trash,
		/obj/item/shard,
		/obj/item/light,
		/obj/item/broken_bottle,
		/obj/item/ammo_casing,
		/obj/item/cigbutt,
	)
	/// Materials that will be extracted.
	var/list/accepted_mats
	var/datum/material_container/container

/obj/item/mod/module/recycler/Initialize(mapload)
	. = ..()

	if(!length(accepted_mats))
		accepted_mats = SSmaterials.get_materials_by_flag(MATERIAL_SILO_STORED)

	container = new ( \
		src, \
		accepted_mats, \
		50 * SHEET_MATERIAL_AMOUNT, \
		MATCONTAINER_EXAMINE | MATCONTAINER_NO_INSERT, \
		container_signals = list( \
			COMSIG_MATCONTAINER_STACK_RETRIEVED = TYPE_PROC_REF(/obj/item/mod/module/recycler, InsertSheets) \
		) \
	)

/obj/item/mod/module/recycler/Destroy()
	QDEL_NULL(container)
	return ..()

/obj/item/mod/module/recycler/on_activation(mob/activator)
	RegisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED, PROC_REF(on_wearer_moved))

/obj/item/mod/module/recycler/on_deactivation(mob/activator, display_message, deleting = FALSE)
	UnregisterSignal(mod.wearer, COMSIG_MOVABLE_MOVED)
	if(mod.wearer.loc)
		UnregisterSignal(mod.wearer.loc, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))

/obj/item/mod/module/recycler/proc/on_wearer_moved(datum/source, atom/old_loc, dir, forced)
	SIGNAL_HANDLER
	if(old_loc)
		UnregisterSignal(mod.wearer.loc, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON))
	if(mod.wearer.loc)
		RegisterSignal(mod.wearer.loc, COMSIG_ATOM_ENTERED, PROC_REF(on_obj_entered))
		RegisterSignal(mod.wearer.loc, COMSIG_ATOM_AFTER_SUCCESSFUL_INITIALIZED_ON, PROC_REF(on_atom_initialized_on))
	for(var/obj/item/item in mod.wearer.loc)
		if(!is_type_in_list(item, allowed_item_types))
			return
		insert_trash(item)

/obj/item/mod/module/recycler/proc/on_obj_entered(atom/new_loc, atom/movable/arrived, atom/old_loc)
	SIGNAL_HANDLER
	if(is_type_in_list(arrived, allowed_item_types))
		insert_trash(arrived)

/obj/item/mod/module/recycler/proc/on_atom_initialized_on(atom/loc, atom/new_atom)
	SIGNAL_HANDLER
	// Give the new atom the time to fully initialize and maybe live if the wearer moves away.
	if(is_type_in_list(new_atom, allowed_item_types))
		addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/mod/module/recycler, insert_trash_if_nearby), new_atom), 0.5 SECONDS)

/obj/item/mod/module/recycler/proc/insert_trash_if_nearby(atom/new_atom)
	if(new_atom && mod?.wearer && new_atom.loc == mod.wearer.loc)
		insert_trash(new_atom)

/obj/item/mod/module/recycler/proc/insert_trash(obj/item/item)
	var/retrieved = container.insert_item(item, multiplier = efficiency)
	if(retrieved == MATERIAL_INSERT_ITEM_NO_MATS) //even if it doesn't have any material to give, trash is trash.
		qdel(item)
	playsound(src, SFX_RUSTLE, 50, TRUE, -5)

/obj/item/mod/module/recycler/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!target?.atom_storage)
		target = get_turf(target)
		if(!isopenturf(target) || !mod.wearer.Adjacent(target))
			return FALSE
	dispense(target)

/obj/item/mod/module/recycler/proc/dispense(atom/target)
	if(container.retrieve_all(target))
		balloon_alert(mod.wearer, "材料已配发")
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, TRUE)
		return
	balloon_alert(mod.wearer, "材料不足")
	playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)

/obj/item/mod/module/recycler/proc/InsertSheets(obj/item/recycler, obj/item/stack/sheets, atom/context)
	SIGNAL_HANDLER

	attempt_insert_storage(sheets)

/obj/item/mod/module/recycler/proc/attempt_insert_storage(obj/item/to_drop)
	if(!isturf(to_drop.loc) && !to_drop.loc.atom_storage?.attempt_insert(to_drop, mod.wearer, override = TRUE))
		to_drop.forceMove(to_drop.loc.drop_location())

///A black market variant of the above that dispenses riot foam dart boxes
/obj/item/mod/module/recycler/donk
	name = "\improper MOD 防暴泡沫弹回收模块"
	desc = "一种 MOD 模块，能把发射过的泡沫弹（以及垃圾）收集起来重新包装成半尺寸的防暴泡沫弹弹药箱。\
		对附近的地面或储物容器使用可卸载已存储的弹药箱。"
	icon_state = "donk_recycler"
	overlay_state_inactive = "module_donk_recycler"
	overlay_state_active = "module_donk_recycler"
	efficiency = 0.7 // Stops getting as many riot foam darts as one consumes.
	accepted_mats = list(/datum/material/iron)
	///The type of ammo box that it dispenses
	var/ammobox_type = /obj/item/ammo_box/foambox/riot/mini
	///The cost of each dispensed ammo box
	var/required_amount = SHEET_MATERIAL_AMOUNT*12.5

/obj/item/mod/module/recycler/donk/dispense(atom/target)
	if(!container.use_amount_mat(required_amount, /datum/material/iron))
		balloon_alert(mod.wearer, "材料不足")
		playsound(src, 'sound/machines/buzz/buzz-sigh.ogg', 50, TRUE)
		return
	var/obj/item/ammo_box/product = new ammobox_type(target)
	attempt_insert_storage(product)
	balloon_alert(mod.wearer, "弹药箱已配发。")
	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 50, TRUE)

/obj/item/mod/module/fishing_glove
	name = "\improper MOD 钓鱼手套模块"
	desc = "一种 MOD 模块，可装入外置钓竿，让使用者无需手持也能钓鱼，同时还能让钓鱼稍微容易一些。"
	icon_state = "fishing_glove"
	complexity = 1
	overlay_state_inactive = "fishing_glove"
	incompatible_modules = list(/obj/item/mod/module/fishing_glove)
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)
	var/obj/item/fishing_rod/equipped

/obj/item/mod/module/fishing_glove/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/mod/module/fishing_glove/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!held_item && equipped)
		context[SCREENTIP_CONTEXT_RMB] = "取出钓竿"
		return CONTEXTUAL_SCREENTIP_SET
	if(istype(held_item, /obj/item/fishing_rod))
		context[SCREENTIP_CONTEXT_LMB] = "插入钓竿"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/mod/module/fishing_glove/examine(mob/user)
	. = ..()
	. += span_info("装入并激活后，你可以 [EXAMINE_HINT("右键点击")] MOD 手套来打开钓竿界面。")
	if(equipped)
		. += span_info("上面装有一个 [icon2html(equipped, user)]。[EXAMINE_HINT("右键点击")] 可将其取下。")

/obj/item/mod/module/fishing_glove/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/fishing_rod))
		return ..()
	if(equipped)
		balloon_alert(user, "已经装有钓竿了！")
	if(!user.transferItemToLoc(tool, src))
		user.balloon_alert(user, "卡住了！")
	equipped = tool
	balloon_alert(user, "钓竿已插入")
	playsound(src, 'sound/items/click.ogg', 50, TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/item/mod/module/fishing_glove/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!equipped)
		return
	user.put_in_hands(equipped)
	balloon_alert(user, "钓竿已取出")
	playsound(src, 'sound/items/click.ogg', 50, TRUE)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/mod/module/fishing_glove/Exited(atom/movable/gone)
	if(gone == equipped)
		equipped = null
		var/obj/item/gloves = mod?.get_part_from_slot(ITEM_SLOT_GLOVES)
		if(gloves && !QDELETED(mod))
			qdel(gloves.GetComponent(/datum/component/profound_fisher))
	return ..()

/obj/item/mod/module/fishing_glove/on_part_activation()
	var/obj/item/gloves = mod.get_part_from_slot(ITEM_SLOT_GLOVES)
	if(!gloves)
		return
	gloves.AddElement(/datum/element/adjust_fishing_difficulty, -5)
	if(equipped)
		gloves.AddComponent(/datum/component/profound_fisher, equipped, delete_rod_when_deleted = FALSE)

/obj/item/mod/module/fishing_glove/on_part_deactivation(deleting = FALSE)
	var/obj/item/gloves = mod.get_part_from_slot(ITEM_SLOT_GLOVES)
	if(gloves && !deleting)
		gloves.RemoveElement(/datum/element/adjust_fishing_difficulty)
		qdel(gloves.GetComponent(/datum/component/profound_fisher))

/obj/item/mod/module/shock_absorber
	name = "\improper MOD 电击吸收模块"
	desc = "一种让使用者更难被警棍击倒、并抵抗警棍造成的中枢神经干扰的模块。"
	icon_state = "no_baton"
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/shock_absorber)
	required_slots = list(ITEM_SLOT_BACK|ITEM_SLOT_BELT)

/obj/item/mod/module/shock_absorber/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src))
	RegisterSignal(mod.wearer, COMSIG_MOB_BATONED, PROC_REF(mob_batoned))

/obj/item/mod/module/shock_absorber/on_part_deactivation(deleting)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_BATON_RESISTANCE, REF(src))
	UnregisterSignal(mod.wearer, COMSIG_MOB_BATONED)

/obj/item/mod/module/shock_absorber/proc/mob_batoned(datum/source)
	SIGNAL_HANDLER
	drain_power(use_energy_cost)
	do_sparks(5, TRUE, mod.wearer.loc)
