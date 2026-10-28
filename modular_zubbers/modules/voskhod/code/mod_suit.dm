/obj/item/clothing/head/helmet/space/voskhod
	name = "\proper 旭日-P 无动力战斗头盔"
	desc = "一顶复合石墨烯-塑钢头盔，内衬弹道尼龙，配有可展开的气密聚碳酸酯面罩与呼吸器系统。<br>\
	这一件的循环呼吸器已被拆走，无法再为用户合成可供呼吸的空气。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/head.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	supports_variations_flags = NONE

/obj/item/clothing/suit/space/voskhod
	name = "\proper 旭日-P 无动力战斗装甲"
	desc = "一套混合式抗太空装甲，以改装过的量产诺梅克斯-气凝胶飞行服为基础，聚脲涂层、耐久纤维衬里的轻型塑钢板尽可能不妨碍活动。\
	这些“瘫痪版”的量产型号去掉了大部分主要功能：从臭名昭著的伤口处理系统，到不太受待见的死亡警报。它更高效的轻质装甲板被换成了单纯的装甲级钢材与陶瓷，使整套装甲明显更加笨重。"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/spacesuit.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'
	icon_state = "nri_soldier"
	armor_type = /datum/armor/hev_suit_nri
	allowed = list(/obj/item/gun, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	supports_variations_flags = NONE //It's already huge enough to look like it can work with digis
	slowdown = 1

/datum/crafting_recipe/voskhod_to_mod
	name = "无动力旭日→翻新旭日MOD改装"
	desc = "虽然这通常在专用的自动工作台上完成，但你也可以手动多摆弄一阵子，达到同样的效果。"
	result = /obj/effect/spawner/random/voskhod_refit
	reqs = list(
		/obj/item/clothing/suit/space/voskhod = 1,
		/obj/item/clothing/head/helmet/space/voskhod = 1,
		/obj/item/crafting_conversion_kit/voskhod_refit = 1,
		/obj/item/storage/backpack/industrial/cin_surplus = 1,
		/obj/item/mod/core = 1,
		/obj/item/stock_parts/power_store/cell/high = 1,
		/obj/item/stack/sheet/plasteel = 10,
		/obj/item/stack/cable_coil = 15,
		/obj/item/assembly/health = 1,
	)
	tool_behaviors = list(TOOL_WELDER, TOOL_MULTITOOL)
	time = 30 SECONDS
	category = CAT_CLOTHING
	crafting_flags = parent_type::crafting_flags | CRAFT_SKIP_MATERIALS_PARITY

/obj/effect/spawner/random/voskhod_refit
	name = "已改装 MODskhod 生成器"
	icon = 'modular_zubbers/icons/obj/clothing/modsuit/mod_clothing.dmi'
	icon_state = "voskhod-chestplate-sealed"
	spawn_all_loot = TRUE
	spawn_loot_count = 1
	loot = list(/obj/item/mod/control/pre_equipped/voskhod)
	custom_materials = list(/datum/material/alloy/plasteel = SHEET_MATERIAL_AMOUNT * 10, /datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.95, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 1.45)

/obj/item/mod/module/auto_doc
	name = "MOD 自动医疗模块"
	desc = "逆向工程重新设计的医疗辅助系统，原本用于如今已退役的旭日战斗装甲。\
		它所用的技术与 N-URSEI 自动医疗套件非常相似，但更小型化，且不具备自我合成能力。\
		借助内置的化合物储罐与微型化学混合器，它能给使用者注射多种药物，\
		帮助其恢复。但该系统严重依赖一些在战斗中难以获得的化合物来配制注射液，\
		主要是隐生物素，这些物质会不时出现在使用者的血液中；而它简陋的损伤评估系统往往只在你中度受伤时才会启动。"
	icon_state = "adrenaline_boost"
	module_type = MODULE_TOGGLE
	incompatible_modules = list(
		/obj/item/mod/module/adrenaline_boost,
		/obj/item/mod/module/auto_doc,
		/obj/item/mod/module/ash_accretion,
	)
	complexity = 4
	removable = TRUE
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 20
	/// Reagent used as 'fuel'
	var/reagent_required = /datum/reagent/cryptobiolin
	/// How much of a reagent we need to refill a single boost.
	var/reagent_required_amount = 20
	/// Maximum amount of reagents this module can hold.
	var/reagent_max_amount = 120
	/// Flat health threshold above which the module won't heal.
	var/health_threshold = 80
	/// Cooldown betwen each treatment.
	var/general_cooldown = 25 SECONDS

	/// Timer for the healing cooldown.
	COOLDOWN_DECLARE(heal_timer)
	/// Timer for the stamina damage cooldown.
	COOLDOWN_DECLARE(stamina_timer)
	/// Timer for the blood-refilling cooldown.
	COOLDOWN_DECLARE(blood_timer)

/obj/item/mod/module/auto_doc/Initialize(mapload)
	. = ..()
	create_reagents(reagent_max_amount)

/obj/item/mod/module/auto_doc/on_active_process(seconds_per_tick)
	if(!reagents.has_reagent(reagent_required, reagent_required_amount))
		balloon_alert(mod.wearer, "化学物质不足！")
		deactivate()
		return FALSE

	var/new_oxyloss = mod.wearer.get_oxy_loss()
	var/new_bruteloss = mod.wearer.get_brute_loss()
	var/new_fireloss = mod.wearer.get_fire_loss()
	var/new_toxloss = mod.wearer.get_tox_loss()

	if(mod.wearer.get_blood_volume() < BLOOD_VOLUME_OKAY && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
		if(!COOLDOWN_FINISHED(src, blood_timer))
			return FALSE
		mod.wearer.reagents.add_reagent(/datum/reagent/blood, 25, list("viruses"=null,"blood_DNA"=null,"blood_type"=mod.wearer.dna.blood_type,"resistances"=null,"trace_chem"=null))
		mod.wearer.reagents.add_reagent(/datum/reagent/medicine/coagulant, 2.5 * seconds_per_tick)
		mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
		reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
		to_chat(mod.wearer, span_warning("血液已灌注。"))
		drain_power(use_energy_cost * 10 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS, TIMER_STOPPABLE|TIMER_DELETE_ME)
		COOLDOWN_START(src, blood_timer, general_cooldown)

	if(mod.wearer.health < health_threshold)
		if(!COOLDOWN_FINISHED(src, heal_timer))
			return FALSE
		if(new_oxyloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/salbutamol, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/internals/internals_on.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("血氧已饱和。"))
		if(new_bruteloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/sal_acid, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("已施用创伤治疗。"))
		if(new_fireloss && reagents.total_volume >= reagent_required_amount * 1 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 2.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/mine_salve, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/effects/spray2.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 1 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("已涂抹药膏。"))
		if(new_toxloss && reagents.total_volume >= reagent_required_amount * 0.5 * seconds_per_tick)
			mod.wearer.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 2.5 * seconds_per_tick)
			mod.wearer.playsound_local(mod, 'sound/items/hypospray.ogg', 25, TRUE)
			reagents.remove_reagent(reagent_required, reagent_required_amount * 0.5 * seconds_per_tick)
			to_chat(mod.wearer, span_warning("已注射解毒剂。"))
		drain_power(use_energy_cost * 15 * seconds_per_tick)
		addtimer(CALLBACK(src, PROC_REF(heal_aftereffects), mod.wearer), 60 SECONDS)
		COOLDOWN_START(src, heal_timer, general_cooldown)

/obj/item/mod/module/auto_doc/emp_act(severity)
	. = ..()
	on_emp(src, severity, .)

/obj/item/mod/module/auto_doc/proc/on_emp(datum/source, severity, protection)
	SIGNAL_HANDLER
	if(protection & EMP_PROTECT_SELF)
		return
	heal_aftereffects(mod.wearer, TRUE)

/// Refills the module with needed chemicals, assuming the container isn't closed or the module isn't full.
/obj/item/mod/module/auto_doc/proc/charge_boost(obj/item/attacking_item, mob/user)
	if(!attacking_item.is_open_container())
		return FALSE
	if(reagents.has_reagent(reagent_required, reagent_max_amount))
		balloon_alert(mod.wearer, "已经满了！")
		return FALSE
	if(!attacking_item.reagents.trans_to(src, reagent_required_amount, target_id = reagent_required))
		return FALSE
	balloon_alert(mod.wearer, "已补充装填！")
	return TRUE

/obj/item/mod/module/auto_doc/on_install()
	. = ..()
	RegisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_refill))
	RegisterSignal(mod, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp))

/obj/item/mod/module/auto_doc/on_uninstall(deleting = FALSE)
	. = ..()
	UnregisterSignal(mod, COMSIG_ATOM_ITEM_INTERACTION)
	UnregisterSignal(mod, COMSIG_ATOM_EMP_ACT)

/obj/item/mod/module/auto_doc/proc/try_refill(source, mob/user, obj/item/attacking_item)
	SIGNAL_HANDLER
	if(charge_boost(attacking_item))
		return COMPONENT_NO_AFTERATTACK
	return NONE

/// With a certain chance, triggers a spontaneous injection of cryptobiolin  into the user's bloodstream; suit design's rather ancient and prone to mishaps.
/obj/item/mod/module/auto_doc/proc/heal_aftereffects(mob/affected_mob, forced)
	if(!affected_mob)
		return
	var/fault_chance = (reagents.maximum_volume/(reagents.total_volume ? reagents.total_volume : 20))*5 // 5% at max cryptobiolin , 20% at low-to-none cryptobiolin
	if(prob(fault_chance) || forced == TRUE)
		reagents.trans_to(affected_mob, min(15,reagents.total_volume))
		balloon_alert(affected_mob, "试剂罐泄漏！")
		affected_mob.playsound_local(mod, 'sound/effects/spray3.ogg', 25, TRUE)

/obj/item/reagent_containers/cup/glass/waterbottle/large/cryptobiolin
	name = "一瓶“医疗试剂”"
	desc = "没有什么比一瓶塑料装的自动医疗补充液更能代表“预算削减”了。"
	list_reagents = list(/datum/reagent/cryptobiolin  = 100)
