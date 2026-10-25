//Medical modules for MODsuits

#define HEALTH_SCAN "健康"
#define WOUND_SCAN "创伤"
#define CHEM_SCAN "化学品"

///Health Analyzer - Gives the user a ranged health analyzer and their health status in the panel.
/obj/item/mod/module/health_analyzer
	name = "MOD 健康分析仪模块"
	desc = "一种安装在套装手套内的模块。这是一套高科技生物扫描套件，\
		让使用者即使隔着一段距离也能获得他人生命体征和伤势的详细信息，\
		只需手腕一动。数据会以方便的形式显示出来，但怎么用就看你自己了。"
	icon_state = "health"
	module_type = MODULE_ACTIVE
	complexity = 1
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/health_analyzer)
	cooldown_time = 0.5 SECONDS
	tgui_id = "health_analyzer"
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// Scanning mode, changes how we scan something.
	var/mode = HEALTH_SCAN

	/// List of all scanning modes.
	var/static/list/modes = list(HEALTH_SCAN, WOUND_SCAN, CHEM_SCAN)

/obj/item/mod/module/health_analyzer/add_ui_data()
	. = ..()
	.["health"] = mod.wearer?.health || 0
	.["health_max"] = mod.wearer?.getMaxHealth() || 0
	.["loss_brute"] = mod.wearer?.get_brute_loss() || 0
	.["loss_fire"] = mod.wearer?.get_fire_loss() || 0
	.["loss_tox"] = mod.wearer?.get_tox_loss() || 0
	.["loss_oxy"] = mod.wearer?.get_oxy_loss() || 0

	return .

/obj/item/mod/module/health_analyzer/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!isliving(target) || !mod.wearer.can_read(src))
		return
	switch(mode)
		if(HEALTH_SCAN)
			healthscan(mod.wearer, target)
		if(WOUND_SCAN)
			woundscan(mod.wearer, target)
		if(CHEM_SCAN)
			chemscan(mod.wearer, target)
	drain_power(use_energy_cost)

/obj/item/mod/module/health_analyzer/get_configuration()
	. = ..()
	.["mode"] = add_ui_configuration("扫描模式", "list", mode, modes)

/obj/item/mod/module/health_analyzer/configure_edit(key, value)
	switch(key)
		if("mode")
			mode = value

#undef HEALTH_SCAN
#undef WOUND_SCAN
#undef CHEM_SCAN

///Quick Carry - Lets the user carry bodies quicker.
/obj/item/mod/module/quick_carry
	name = "MOD 快速搬运模块"
	desc = "一套先进伺服装置，可以重新引导套装手臂的动力来帮助搬运伤员；\
		或者单纯为了好玩。不过，纳米传讯锁定了该模块在徒手格斗中的辅助能力。"
	icon_state = "carry"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/quick_carry, /obj/item/mod/module/constructor)
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 5)
	var/quick_carry_trait = TRAIT_QUICK_CARRY

/obj/item/mod/module/quick_carry/on_part_activation()
	. = ..()
	ADD_TRAIT(mod.wearer, TRAIT_FASTMED, REF(src))
	ADD_TRAIT(mod.wearer, quick_carry_trait, REF(src))

/obj/item/mod/module/quick_carry/on_part_deactivation(deleting = FALSE)
	. = ..()
	REMOVE_TRAIT(mod.wearer, TRAIT_FASTMED, REF(src))
	REMOVE_TRAIT(mod.wearer, quick_carry_trait, REF(src))

/obj/item/mod/module/quick_carry/advanced
	name = "MOD 高级快速搬运模块"
	removable = FALSE
	complexity = 0
	quick_carry_trait = TRAIT_QUICKER_CARRY

///Injector - Gives the suit an extendable large-capacity piercing syringe.
/obj/item/mod/module/injector
	name = "MOD 注射模块"
	desc = "一种安装在套装手腕处的模块，可作为一支大容量注射器使用，\
		其针尖足够细，能找准任何装甲上的紧急注射口，\
		并轻松刺入。包括你自己的。"
	icon_state = "injector"
	module_type = MODULE_ACTIVE
	complexity = 1
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	device = /obj/item/reagent_containers/syringe/mod
	incompatible_modules = list(/obj/item/mod/module/injector)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/syringe/mod
	name = "MOD 注射器"
	desc = "一支大容量注射器，其针尖足够细，能找准\
		任何装甲上的紧急注射口，并轻松刺入。包括你自己的。"
	icon_state = "mod_0"
	base_icon_state = "mod"
	amount_per_transfer_from_this = 30
	possible_transfer_amounts = list(5, 10, 15, 20, 30)
	volume = 30
	inject_flags = INJECT_CHECK_PENETRATE_THICK
	custom_materials = null

/obj/item/reagent_containers/syringe/mod/update_reagent_overlay()
	if(reagents?.total_volume)
		var/mutable_appearance/filling_overlay = mutable_appearance('icons/obj/medical/reagent_fillings.dmi', "mod[get_rounded_vol()]")
		filling_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += filling_overlay

///Organizer - Lets you shoot organs, immediately replacing them if the target has the organ manipulation surgery.
/obj/item/mod/module/organizer
	name = "MOD 器官整备模块"
	desc = "一件从坠毁的英特戴恩制药公司飞船中回收的设备，\
		这个模块重见天日，不知是福是祸。\
		它是一件臂挂式设备，所用技术类似现代的快速部件更换装置，\
		能在手术中一次性瞬间更换最多 5 个器官，无需先行摘除，甚至可以远程操作。\
		德福雷斯特医疗公司建议不要告知病人它已被使用。"
	icon_state = "organizer"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/organizer, /obj/item/mod/module/microwave_beam)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	/// How many organs the module can hold.
	var/max_organs = 5
	/// A list of all our organs.
	var/organ_list = list()

/obj/item/mod/module/organizer/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/wearer_human = mod.wearer
	if(isorgan(target))
		if(!wearer_human.Adjacent(target))
			return
		var/atom/movable/organ = target
		if(length(organ_list) >= max_organs)
			balloon_alert(mod.wearer, "器官太多了！")
			return
		organ_list += organ
		organ.forceMove(src)
		balloon_alert(mod.wearer, "已拾起 [organ]")
		playsound(src, 'sound/vehicles/mecha/hydraulic.ogg', 25, TRUE)
		drain_power(use_energy_cost)
		return
	if(!length(organ_list))
		return
	var/atom/movable/fired_organ = pop(organ_list)
	var/obj/projectile/organ/projectile = new /obj/projectile/organ(mod.wearer.loc, fired_organ)
	projectile.aim_projectile(target, mod.wearer)
	projectile.firer = mod.wearer
	playsound(src, 'sound/vehicles/mecha/hydraulic.ogg', 25, TRUE)
	INVOKE_ASYNC(projectile, TYPE_PROC_REF(/obj/projectile, fire))
	drain_power(use_energy_cost)

/obj/projectile/organ
	name = "器官"
	damage = 0
	hitsound = 'sound/effects/blob/attackblob.ogg'
	hitsound_wall = 'sound/effects/blob/attackblob.ogg'
	/// A reference to the organ we "are".
	var/obj/item/organ/organ

/obj/projectile/organ/Initialize(mapload, obj/item/stored_organ)
	. = ..()
	if(!stored_organ)
		return INITIALIZE_HINT_QDEL
	appearance = stored_organ.appearance
	stored_organ.forceMove(src)
	organ = stored_organ

/obj/projectile/organ/Destroy()
	organ = null
	return ..()

/obj/projectile/organ/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == organ)
		organ = null

/obj/projectile/organ/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(!isliving(target) || (organ.organ_flags & ORGAN_UNUSABLE))
		organ.forceMove(drop_location())
		return
	var/mob/living/organ_receiver = target
	// bodyparts actually *do* hit a specific bodypart, but random variance would make this projectile unusable
	// so we just fake it, and assume the organ always hits the place it needs to go
	var/obj/item/bodypart/fake_hit_part = organ_receiver.get_bodypart(length(organ.valid_zones) ? pick(organ.valid_zones) : deprecise_zone(organ.zone))
	if(!LIMB_HAS_SURGERY_STATE(fake_hit_part, SURGERY_SKIN_OPEN|SURGERY_ORGANS_CUT|SURGERY_BONE_SAWED))
		organ.forceMove(drop_location())
		return

	// handles swapping any existing organ out for us
	organ.Insert(target)

///Patrient Transport - Generates hardlight bags you can put people in.
/obj/item/mod/module/criminalcapture/patienttransport
	name = "MOD 病患运输模块"
	desc = "一种嵌入套装前臂的模块。无数支多半已失踪的采矿队被派往\
		因德西菲瑞斯及其他危险地点，这些经历给德福雷斯特医疗公司上了许多课。\
		实体尸体袋难以储藏、难以展开，在恶劣环境下更是难以保持完好。\
		于是硬光运输袋登场了。只需一个手势即可召唤，没有重量，并对\
		佩戴者能想到的任何极端环境免疫，这个袋子完美地适用于\
		在任何时间、任何环境下运输任何尸体。"
	icon_state = "patient_transport"
	bodybag_type = /obj/structure/closet/body_bag/environmental/hardlight
	capture_time = 1.5 SECONDS
	packup_time = 0.5 SECONDS
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 5)

///Defibrillator - Gives the suit an extendable pair of shock paddles.
/obj/item/mod/module/defibrillator
	name = "MOD 除颤模块"
	desc = "一种嵌入套装护手的模块；医务人员通常称之为‘治愈之手’。\
		使用者将双掌放在病人上方。套装内的机载计算机会计算所需的电压，\
		改装过的瞄准计算机会确定使用者按压的最佳位置。\
		二十五磅的力被施加到病人的皮肤上。电流从套装手套传出，\
		对心脏进行反向电击，随后佩戴者便以英雄之姿回到医疗部。别想着把它当武器用；\
		制造法规和软件锁定都明令禁止这么做。"
	icon_state = "defibrillator"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN * 25
	device = /obj/item/shockpaddles/mod
	overlay_state_inactive = "module_defibrillator"
	overlay_state_active = "module_defibrillator_active"
	incompatible_modules = list(/obj/item/mod/module/defibrillator)
	cooldown_time = 0.5 SECONDS
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5)
	var/defib_cooldown = 5 SECONDS

/obj/item/mod/module/defibrillator/Initialize(mapload)
	. = ..()
	RegisterSignal(device, COMSIG_DEFIBRILLATOR_SUCCESS, PROC_REF(on_defib_success))

/obj/item/mod/module/defibrillator/proc/on_defib_success(obj/item/shockpaddles/source)
	drain_power(use_energy_cost)
	source.recharge(defib_cooldown)
	return COMPONENT_DEFIB_STOP

/obj/item/shockpaddles/mod
	name = "MOD 除颤护手"
	req_defib = FALSE
	icon_state = "defibgauntlets0"
	inhand_icon_state = "defibgauntlets0"
	base_icon_state = "defibgauntlets"

/obj/item/mod/module/defibrillator/combat
	name = "MOD 战斗除颤模块"
	desc = "一种嵌入套装护手的模块；医务人员通常称之为‘治愈之手’。\
		使用者将双掌放在病人上方。套装内的机载计算机会计算所需的电压，\
		改装过的瞄准计算机会确定使用者按压的最佳位置。\
		二十五磅的力被施加到病人的皮肤上。电流从套装手套传出，\
		对心脏进行反向电击，随后佩戴者便以英雄之姿回到医疗部。\
		英特戴恩制药公司将民用版治愈之手宣传为万无一失、无法用作武器。\
		但当需要为自家特工提供可用的医疗设备时，他们毫不犹豫地拆掉了\
		那些内置保险。外勤特工得以享受他们口中的‘电击手套’，能把电流\
		直接施加到受害者的心脏上使其丧失行动能力，甚至可能用足够的电量让心脏彻底停跳。"
	complexity = 1
	module_type = MODULE_ACTIVE
	overlay_state_inactive = "module_defibrillator_combat"
	overlay_state_active = "module_defibrillator_combat_active"
	device = /obj/item/shockpaddles/syndicate/mod
	defib_cooldown = 2.5 SECONDS

/obj/item/shockpaddles/syndicate/mod
	name = "MOD 战斗除颤护手"
	req_defib = FALSE
	icon_state = "syndiegauntlets0"
	inhand_icon_state = "syndiegauntlets0"
	base_icon_state = "syndiegauntlets"

///Thread Ripper - Temporarily rips apart clothing to make it not cover the body.
/obj/item/mod/module/thread_ripper
	name = "MOD 裂线模块"
	desc = "一种定制模块，与套装的手腕集成。裂线模块基于\
		可追溯至 2562 年初的新近技术，当时一位知名的纳米传讯研究员试图\
		扩展自动衣柜中的快速裁缝技术。裂线模块不能创造\
		阳光下任何一种织物图案，而是能快速把它们拆解。\
		从凯夫拉编织物到皮革，再到耐久纤维，都能按佩戴者的要求迅速扯开\
		再缝合回去，这一进展常被医务人员用来便捷地\
		进行手术、除颤或注射化学药剂，让病人不必担心自己的\
		名牌时装被弄坏。"
	icon_state = "thread_ripper"
	module_type = MODULE_ACTIVE
	complexity = 2
	use_energy_cost = DEFAULT_CHARGE_DRAIN
	incompatible_modules = list(/obj/item/mod/module/thread_ripper)
	cooldown_time = 1.5 SECONDS
	overlay_state_inactive = "module_threadripper"
	required_slots = list(ITEM_SLOT_GLOVES)
	custom_materials = list(/datum/material/silver = SMALL_MATERIAL_AMOUNT * 7.5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5)
	/// An associated list of ripped clothing and the body part covering slots they covered before
	var/list/ripped_clothing = list()

/obj/item/mod/module/thread_ripper/on_select_use(atom/target)
	. = ..()
	if(!.)
		return
	if(!mod.wearer.Adjacent(target) || !iscarbon(target) || target == mod.wearer)
		balloon_alert(mod.wearer, "目标无效！")
		return
	var/mob/living/carbon/carbon_target = target
	if(length(ripped_clothing))
		balloon_alert(mod.wearer, "已经撕开了！")
		return
	balloon_alert(mod.wearer, "正在撕裂衣物……")
	playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE, frequency = -1)
	if(!do_after(mod.wearer, 1.5 SECONDS, target = carbon_target))
		balloon_alert(mod.wearer, "被打断了！")
		return
	var/target_zones = body_zone2cover_flags(mod.wearer.zone_selected)
	for(var/obj/item/clothing as anything in carbon_target.get_equipped_items())
		if(!clothing)
			continue
		var/shared_flags = target_zones & clothing.body_parts_covered
		if(shared_flags)
			ripped_clothing[clothing] = shared_flags
			clothing.body_parts_covered &= ~shared_flags

/obj/item/mod/module/thread_ripper/on_process(seconds_per_tick)
	. = ..()
	if(!.)
		return
	if(!length(ripped_clothing))
		return
	var/zipped = FALSE
	for(var/obj/item/clothing as anything in ripped_clothing)
		if(QDELETED(clothing))
			ripped_clothing -= clothing
			continue
		var/mob/living/carbon/clothing_wearer = clothing.loc
		if(istype(clothing_wearer) && mod.wearer.Adjacent(clothing_wearer) && !clothing_wearer.is_holding(clothing))
			continue
		zipped = TRUE
		clothing.body_parts_covered |= ripped_clothing[clothing]
		ripped_clothing -= clothing
	if(zipped)
		playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE)
		balloon_alert(mod.wearer, "衣物已修复")

/obj/item/mod/module/thread_ripper/on_part_deactivation(deleting = FALSE)
	if(!length(ripped_clothing))
		return
	for(var/obj/item/clothing as anything in ripped_clothing)
		if(QDELETED(clothing))
			ripped_clothing -= clothing
			continue
		clothing.body_parts_covered |= ripped_clothing[clothing]
	ripped_clothing = list()
	if(!deleting)
		playsound(src, 'sound/items/zip/zip.ogg', 25, TRUE)

///Surgical Processor - Lets you do advanced surgeries portably.
/obj/item/mod/module/surgical_processor
	name = "MOD 手术处理器模块"
	desc = "一种搭载机载手术计算机的模块，可连接其他计算机下载并\
		随时随地进行高级手术。"
	icon_state = "surgical_processor"
	module_type = MODULE_ACTIVE
	complexity = 2
	active_power_cost = DEFAULT_CHARGE_DRAIN
	device = /obj/item/surgical_processor/mod
	incompatible_modules = list(/obj/item/mod/module/surgical_processor)
	cooldown_time = 0.5 SECONDS
	custom_materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 2.5)

/obj/item/surgical_processor/mod
	name = "MOD 手术处理器"
	custom_materials = null

/obj/item/mod/module/surgical_processor/preloaded
	desc = "一种搭载机载手术计算机的模块，可连接其他计算机下载并\
		随时随地进行高级手术。这一台已预装了一些高级手术。"
	device = /obj/item/surgical_processor/mod/preloaded

/obj/item/surgical_processor/mod/preloaded
	loaded_surgeries = list(
		/datum/surgery_operation/basic/tend_wounds/combo/upgraded/master,
		/datum/surgery_operation/limb/bioware/cortex_folding,
		/datum/surgery_operation/limb/bioware/cortex_folding/mechanic,
		/datum/surgery_operation/limb/bioware/cortex_imprint,
		/datum/surgery_operation/limb/bioware/cortex_imprint/mechanic,
		/datum/surgery_operation/limb/bioware/ligament_hook,
		/datum/surgery_operation/limb/bioware/ligament_hook/mechanic,
		/datum/surgery_operation/limb/bioware/ligament_reinforcement,
		/datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic,
		/datum/surgery_operation/limb/bioware/muscled_veins,
		/datum/surgery_operation/limb/bioware/muscled_veins/mechanic,
		/datum/surgery_operation/limb/bioware/nerve_grounding,
		/datum/surgery_operation/limb/bioware/nerve_grounding/mechanic,
		/datum/surgery_operation/limb/bioware/nerve_splicing,
		/datum/surgery_operation/limb/bioware/nerve_splicing/mechanic,
		/datum/surgery_operation/limb/bioware/vein_threading,
		/datum/surgery_operation/limb/bioware/vein_threading/mechanic,
		/datum/surgery_operation/organ/brainwash,
		/datum/surgery_operation/organ/brainwash/mechanic,
		/datum/surgery_operation/organ/pacify,
		/datum/surgery_operation/organ/pacify/mechanic,
	)

/obj/item/mod/module/surgical_processor/emergency
	desc = "一种搭载机载手术计算机的模块，可连接其他计算机下载并\
		随时随地进行高级手术。这一台已预装了一些急救手术。"
	device = /obj/item/surgical_processor/mod/emergency

/obj/item/surgical_processor/mod/emergency
	loaded_surgeries = list(
		/datum/surgery_operation/basic/tend_wounds/combo/upgraded/master,
		/datum/surgery_operation/organ/fix_wings,
	)
