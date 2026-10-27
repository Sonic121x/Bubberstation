GLOBAL_DATUM_INIT(steal_item_handler, /datum/objective_item_handler, new())

/proc/add_item_to_steal(source, type)
	GLOB.steal_item_handler.objectives_by_path[type] += source
	return type

/// Holds references to information about all of the items you might need to steal for objectives
/datum/objective_item_handler
	var/list/list/objectives_by_path
	var/generated_items = FALSE

/datum/objective_item_handler/New()
	. = ..()
	objectives_by_path = list()
	for(var/datum/objective_item/item as anything in subtypesof(/datum/objective_item))
		objectives_by_path[initial(item.targetitem)] = list()
	RegisterSignal(SSatoms, COMSIG_SUBSYSTEM_POST_INITIALIZE, PROC_REF(save_items))
	RegisterSignal(SSdcs, COMSIG_GLOB_NEW_ITEM, PROC_REF(new_item_created))

/datum/objective_item_handler/proc/new_item_created(datum/source, obj/item/item)
	SIGNAL_HANDLER
	if(HAS_TRAIT(item, TRAIT_ITEM_OBJECTIVE_BLOCKED))
		return
	if(!generated_items)
		item.add_stealing_item_objective()
		return
	var/typepath = item.add_stealing_item_objective()
	if(typepath != null)
		register_item(item, typepath)

/// Registers all items that are potentially stealable and removes ones that aren't.
/// We still need to do things this way because on mapload, items may not be on the station until everything has finished loading.
/datum/objective_item_handler/proc/save_items()
	SIGNAL_HANDLER
	for(var/obj/item/typepath as anything in objectives_by_path)
		var/list/obj_by_path_cache = objectives_by_path[typepath].Copy()
		for(var/obj/item/object as anything in obj_by_path_cache)
			register_item(object, typepath)
	generated_items = TRUE

/datum/objective_item_handler/proc/register_item(atom/object, typepath)
	var/turf/place = get_turf(object)
	if(!place || !is_station_level(place.z))
		objectives_by_path[typepath] -= object
		return
	RegisterSignal(object, COMSIG_QDELETING, PROC_REF(remove_item))

/datum/objective_item_handler/proc/remove_item(atom/source)
	SIGNAL_HANDLER
	for(var/typepath in objectives_by_path)
		objectives_by_path[typepath] -= source

//Contains the target item datums for Steal objectives.
/datum/objective_item
	/// How the item is described in the objective
	var/name = "一个滑稽的自行车喇叭！滑稽！"
	/// Typepath of item
	var/targetitem = /obj/item/bikehorn
	/// Valid containers that the target item can be in.
	var/list/valid_containers = list()
	/// Who CARES if this item goes missing (no stealing unguarded items), often similar but not identical to the next list
	var/list/item_owner = list()
	/// Jobs which cannot generate this objective (no stealing your own stuff)
	var/list/excludefromjob = list()
	/// List of additional items which also count, for things like blueprints
	var/list/altitems = list()
	/// Items to provide to people in order to allow them to acquire the target
	var/list/special_equipment = list()
	/// Defines in which contexts the item can be given as an objective
	var/objective_type = OBJECTIVE_ITEM_TYPE_NORMAL
	/// Whether this item exists on the station map at the start of a round.
	var/exists_on_map = FALSE
	/**
	 * How hard it is to steal this item given normal circumstances, ranked on a scale of 1 to 5.
	 *
	 * 1 - Probably found in a public area
	 * 2 - Likely on someone's person, or in a less-than-public but otherwise unguarded area
	 * 3 - Usually on someone's person, or in a locked locker or otherwise secure area
	 * 4 - Always on someone's person, or in a secure area
	 * 5 - You know it when you see it. Things like the Nuke Disc which have a pointer to it at all times.
	 *
	 * Also accepts 0 as "extremely easy to steal" and >5 as "almost impossible to steal"
	 */
	var/difficulty = 0
	/// A hint explaining how one may find the target item.
	var/steal_hint = "小丑可能有一个。"

	///If the item takes special steps to destroy for an objective (e.g. blackbox)
	var/destruction_method = null

/// For objectives with special checks (does that intellicard have an ai in it? etcetc)
/datum/objective_item/proc/check_special_completion(obj/item/thing)
	return TRUE

/// Takes a list of minds and returns true if this is a valid objective to give to a team of these minds
/datum/objective_item/proc/valid_objective_for(list/potential_thieves, require_owner = FALSE)
	if(!target_exists() || (require_owner && !owner_exists()))
		return FALSE
	for (var/datum/mind/possible_thief as anything in potential_thieves)
		var/datum/job/role = possible_thief.assigned_role
		if(role.title in excludefromjob)
			return FALSE
	return TRUE

/// Returns true if the target item exists
/datum/objective_item/proc/target_exists()
	return (exists_on_map) ? length(GLOB.steal_item_handler.objectives_by_path[targetitem]) : TRUE

/// Returns true if one of the item's owners exists somewhere
/datum/objective_item/proc/owner_exists()
	if (!length(item_owner))
		return TRUE
	for (var/mob/living/player as anything in GLOB.player_list)
		if ((player.mind?.assigned_role.title in item_owner) && player.stat != DEAD && !is_centcom_level(player.z))
			return TRUE
	return FALSE

/datum/objective_item/steal/New()
	. = ..()
	if(target_exists())
		GLOB.possible_items += src
	else
		qdel(src)

/datum/objective_item/steal/Destroy()
	GLOB.possible_items -= src
	return ..()

// Low risk steal objectives
/datum/objective_item/steal/traitor
	objective_type = OBJECTIVE_ITEM_TYPE_TRAITOR

// Unique-ish low risk objectives
/datum/objective_item/steal/traitor/bartender_shotgun
	name = "酒保的霰弹枪"
	targetitem = /obj/item/gun/ballistic/shotgun/doublebarrel
	excludefromjob = list(JOB_BARTENDER)
	item_owner = list(JOB_BARTENDER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一把双管霰弹枪，通常由酒保随身携带；若没有酒保，则放在酒吧后室。"

/obj/item/gun/ballistic/shotgun/doublebarrel/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/ballistic/shotgun/doublebarrel)

/datum/objective_item/steal/traitor/fireaxe
	name = "一把消防斧"
	targetitem = /obj/item/fireaxe
	excludefromjob = list(
		JOB_ATMOSPHERIC_TECHNICIAN,
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
		JOB_STATION_ENGINEER,
	)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "空间站上只有两把，一把在舰桥，另一把在大气部。\
		你可以用多功能工具破解展示柜，也可以直接砸开。"

/obj/item/fireaxe/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/fireaxe)

/datum/objective_item/steal/traitor/big_crowbar
	name = "一把机甲拆卸工具"
	targetitem = /obj/item/crowbar/mechremoval
	excludefromjob = list(
		JOB_RESEARCH_DIRECTOR,
		JOB_SCIENTIST,
		JOB_ROBOTICIST,
	)
	item_owner = list(JOB_ROBOTICIST)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "机器人专家实验室中的专用工具。你可以用多功能工具破解展示柜，也可以直接砸开。"

/obj/item/crowbar/mechremoval/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/crowbar/mechremoval)

/datum/objective_item/steal/traitor/nullrod
	name = "牧师的虚无法杖"
	targetitem = /obj/item/nullrod
	excludefromjob = list(JOB_CHAPLAIN)
	item_owner = list(JOB_CHAPLAIN)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一件圣物，通常由牧师随身携带；若没有牧师，则放在教堂的圣物柜中。\
		如果站上有牧师，它可能已经变成了某种神圣武器——其中有些……很难从牧师身上取下来。"

/obj/item/nullrod/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/nullrod)

/datum/objective_item/steal/traitor/clown_shoes
	name = "小丑的鞋子"
	targetitem = /obj/item/clothing/shoes/clown_shoes
	excludefromjob = list(JOB_CLOWN, JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	item_owner = list(JOB_CLOWN)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "小丑那双巨大而鲜艳的鞋子，应该一直穿在小丑脚上。"

/obj/item/clothing/shoes/clown_shoes/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/shoes/clown_shoes)

/datum/objective_item/steal/traitor/mime_mask
	name = "默剧演员的面具"
	targetitem = /obj/item/clothing/mask/gas/mime
	excludefromjob = list(JOB_MIME, JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	item_owner = list(JOB_MIME)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "默剧演员的面具，应该一直戴在默剧演员脸上。"

/obj/item/clothing/mask/gas/mime/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/mask/gas/mime)

/datum/objective_item/steal/traitor/pka
	name = "一把原型动能加速器"
	targetitem = /obj/item/gun/energy/recharge/kinetic_accelerator
	excludefromjob = list(JOB_SHAFT_MINER, JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	item_owner = list(JOB_SHAFT_MINER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "主要供矿工采矿的工具。大多数矿工会随身携带一把或多把，\
		也可以在采矿站、采矿办公室或空间站上的辅助采矿基地找到。"

/obj/item/gun/energy/recharge/kinetic_accelerator/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/recharge/kinetic_accelerator)

/datum/objective_item/steal/traitor/chef_moustache
	name = "一副精致的假胡须"
	targetitem = /obj/item/clothing/mask/fakemoustache/italian
	excludefromjob = list(JOB_COOK, JOB_HEAD_OF_PERSONNEL, JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	item_owner = list(JOB_COOK)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "厨师的意大利式假胡须。它可能戴在厨师脸上，也可能被扔进垃圾桶，取决于当班的是谁。"

/obj/item/clothing/mask/fakemoustache/italian/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/mask/fakemoustache/italian)

/datum/objective_item/steal/traitor/det_revolver
	name = "侦探的左轮手枪"
	targetitem = /obj/item/gun/ballistic/revolver/c38/detective
	excludefromjob = list(JOB_DETECTIVE)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "侦探枪套中的 .38 Special 左轮手枪。\
		通常由侦探随身携带；若没有侦探，则放在侦探办公室的储物柜里。"

/obj/item/gun/ballistic/revolver/c38/detective/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/ballistic/revolver/c38/detective)

/datum/objective_item/steal/traitor/lawyers_badge
	name = "律师的徽章"
	targetitem = /obj/item/clothing/accessory/lawyers_badge
	excludefromjob = list(JOB_LAWYER)
	item_owner = list(JOB_LAWYER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "律师的徽章。通常别在胸前，也可以从律师服装售货机取得备用徽章。"

/obj/item/clothing/accessory/lawyers_badge/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/accessory/lawyers_badge)

/datum/objective_item/steal/traitor/chief_engineer_belt
	name = "总工程师的腰带"
	targetitem = /obj/item/storage/belt/utility/chief
	excludefromjob = list(JOB_CHIEF_ENGINEER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "总工程师的工具腰带，一直系在其腰间。"

/obj/item/storage/belt/utility/chief/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/storage/belt/utility/chief)

/datum/objective_item/steal/traitor/telebaton
	name = "一名部门主管的伸缩警棍"
	targetitem = /obj/item/melee/baton/telescopic
	excludefromjob = list(
		JOB_RESEARCH_DIRECTOR,
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_PERSONNEL,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "除安保主管外，所有部门主管标配的防身武器。他们很少让它离身。"

/datum/objective_item/steal/traitor/telebaton/check_special_completion(obj/item/thing)
	return !istype(thing, /obj/item/melee/baton/telescopic/contractor_baton)

/obj/item/melee/baton/telescopic/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/melee/baton/telescopic)

/datum/objective_item/steal/traitor/cargo_budget
	name = "货运部的部门预算卡"
	targetitem = /obj/item/card/id/departmental_budget/car
	excludefromjob = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN)
	item_owner = list(JOB_QUARTERMASTER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一张可以支取货运部资金的卡片。\
		通常放在货运主管的储物柜里，不过警觉的主管可能会随身携带或收进钱包。"

/obj/item/card/id/departmental_budget/car/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/card/id/departmental_budget/car)

/datum/objective_item/steal/traitor/captain_modsuit
	name = "舰长的巨头型 MOD 控制单元"
	targetitem = /obj/item/mod/control/pre_equipped/magnate
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "为舰长手工打造的昂贵 MOD 单元。\
		如果舰长没有穿戴，它会放在舰长宿舍的防护服储存单元中。"

/obj/item/mod/control/pre_equipped/magnate/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/mod/control/pre_equipped/magnate)

/datum/objective_item/steal/traitor/captain_spare
	name = "舰长的备用身份卡"
	targetitem = /obj/item/card/id/advanced/gold/captains_spare
	excludefromjob = list(
		JOB_RESEARCH_DIRECTOR,
		JOB_CAPTAIN,
		JOB_HEAD_OF_SECURITY,
		JOB_HEAD_OF_PERSONNEL,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_QUARTERMASTER,
	)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "最高领导本人的备用身份卡。\
		如果没有正式舰长，它可能别在代理舰长——某位部门主管——的胸前。\
		否则，你得用酸液或炸药打开舰桥上的金色保险箱才能拿到它。"

/obj/item/card/id/advanced/gold/captains_spare/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/card/id/advanced/gold/captains_spare)

// High risk steal objectives

// Will always generate even with no Captain due to its security and temptation to use it
/datum/objective_item/steal/caplaser
	name = "舰长的古董激光枪"
	targetitem = /obj/item/gun/energy/laser/captain
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "舰长宿舍展示柜中的自充能激光枪。\
		打破展示柜可能会触发安保警报，请小心。"

/obj/item/gun/energy/laser/captain/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/laser/captain)

/datum/objective_item/steal/hoslaser
	name = "安保主管的私人激光枪"
	targetitem = /obj/item/gun/energy/e_gun/hos
	excludefromjob = list(JOB_HEAD_OF_SECURITY)
	item_owner = list(JOB_HEAD_OF_SECURITY)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "安保主管独有的三模式激光枪。\
		只要主管还活着，就一定随身携带；否则可能放在其储物柜中。"

/obj/item/gun/energy/e_gun/hos/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/e_gun/hos)

/datum/objective_item/steal/compactshotty
	name = "典狱长的私人紧凑型霰弹枪"
	targetitem = /obj/item/gun/ballistic/shotgun/automatic/combat/compact
	excludefromjob = list(JOB_WARDEN)
	item_owner = list(JOB_WARDEN)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "一把小型战斗霰弹枪，可能在安保主管的储物柜中，也可能背在其背上。"

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/ballistic/shotgun/automatic/combat/compact)

/datum/objective_item/steal/handtele
	name = "一台手持传送器"
	targetitem = /obj/item/hand_tele
	excludefromjob = list(JOB_CAPTAIN, JOB_RESEARCH_DIRECTOR, JOB_HEAD_OF_PERSONNEL)
	item_owner = list(JOB_CAPTAIN, JOB_RESEARCH_DIRECTOR)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "空间站上只有两台这种装置，一台放在传送室中\
		用于应急，另一台放在舰长宿舍供舰长私人使用。"

/obj/item/hand_tele/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/hand_tele)

/datum/objective_item/steal/jetpack
	name = "舰长的喷气背包"
	targetitem = /obj/item/tank/jetpack/captain
	excludefromjob = list(JOB_CAPTAIN)
	item_owner = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "舰长宿舍防护服储存单元中的特制黄色喷气背包。"

/obj/item/tank/jetpack/captain/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/tank/jetpack/captain)

/datum/objective_item/steal/magboots
	name = "总工程师的高级磁力靴"
	targetitem = /obj/item/clothing/shoes/magboots/advance
	excludefromjob = list(JOB_CHIEF_ENGINEER)
	item_owner = list(JOB_CHIEF_ENGINEER)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "总工程师防护服储存单元中的一双磁力靴。\
		也可能正穿在其脚上，藏在 MOD 模块化外骨骼下面。"

/obj/item/clothing/shoes/magboots/advance/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/shoes/magboots/advance)

/datum/objective_item/steal/capmedal
	name = "舰长勋章"
	targetitem = /obj/item/clothing/accessory/medal/gold/captain
	excludefromjob = list(JOB_CAPTAIN)
	item_owner = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "舰长宿舍勋章盒中的一枚金质勋章。\
		舰长通常也会在制服上别一枚。"

/obj/item/clothing/accessory/medal/gold/captain/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/accessory/medal/gold/captain)

/datum/objective_item/steal/hypo
	//name = "the hypospray" // ORIGINAL
	name = "首席医疗官的无针注射器" // SKYRAT EDIT CHANGE
	//targetitem = /obj/item/reagent_containers/hypospray/cmo // ORIGINAL
	targetitem = /obj/item/hypospray/mkii/deluxe/cmo // SKYRAT EDIT CHANGE
	excludefromjob = list(JOB_CHIEF_MEDICAL_OFFICER)
	item_owner = list(JOB_CHIEF_MEDICAL_OFFICER)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "首席医疗官的私人医疗注射器。\
		通常放在其随身或腰带里的医疗用品中，也可能存放在其储物柜中。"

/obj/item/hypospray/mkii/deluxe/cmo/add_stealing_item_objective() // SKYRAT EDIT CHANGE
	return add_item_to_steal(src, /obj/item/hypospray/mkii/deluxe/cmo) // SKYRAT EDIT CHANGE

/datum/objective_item/steal/nukedisc
	name = "核弹认证磁盘"
	targetitem = /obj/item/disk/nuclear
	excludefromjob = list(JOB_CAPTAIN)
	difficulty = 5
	steal_hint = "就是那张磁盘——你知道是哪张。舰长会一直随身携带它（但愿如此）。\
		它十分显眼，但如果你找不到，安保主管和舰长都有能够追踪其准确位置的设备。"

/obj/item/disk/nuclear/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/disk/nuclear)

/datum/objective_item/steal/nukedisc/check_special_completion(obj/item/disk/nuclear/N)
	return !N.fake

/datum/objective_item/steal/ablative
	name = "一件烧蚀风衣"
	targetitem = /obj/item/clothing/suit/hooded/ablative
	excludefromjob = list(JOB_HEAD_OF_SECURITY, JOB_WARDEN)
	item_owner = list(JOB_HEAD_OF_SECURITY)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "军械库架子上的一件烧蚀风衣。"

/obj/item/clothing/suit/hooded/ablative/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/suit/hooded/ablative)

/datum/objective_item/steal/reactive
	name = "反应式传送装甲"
	targetitem = /obj/item/clothing/suit/armor/reactive/teleport
	excludefromjob = list(JOB_RESEARCH_DIRECTOR)
	item_owner = list(JOB_RESEARCH_DIRECTOR)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "科研主管持有的一套特殊装甲。\
		也可能放在其储物柜中。"

/obj/item/clothing/suit/armor/reactive/teleport/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/suit/armor/reactive/teleport)

/datum/objective_item/steal/documents
	name = "任意组织的一套秘密文件"
	valid_containers = list(/obj/item/folder)
	targetitem = /obj/item/documents
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "属于某个大型企业集团的一套文件。\
		纳米传讯的文件很容易在空间站金库中找到。\
		其他公司的文件则可能藏在奇怪而遥远的地方。\
		复印件也可以。"

/obj/item/documents/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/documents) //Any set of secret documents. Doesn't have to be NT's

/datum/objective_item/steal/nuke_core
	name = "站内自毁装置中具有强烈放射性的钚核心"
	valid_containers = list(/obj/item/nuke_core_container)
	targetitem = /obj/item/nuke_core
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "空间站自毁装置的核心，位于金库中。"

/obj/item/nuke_core/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/nuke_core)

/datum/objective_item/steal/nuke_core/New()
	special_equipment += /obj/item/storage/box/syndie_kit/nuke
	..()

/datum/objective_item/steal/hdd_extraction
	name = "研发主服务器大型主机中的暴徒计划源代码"
	targetitem = /obj/item/disk/computer/hdd_theft
	excludefromjob = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST)
	item_owner = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "主研究服务器的硬盘，位于研发部服务器机房中。"

/obj/item/disk/computer/hdd_theft/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/disk/computer/hdd_theft)

/datum/objective_item/steal/hdd_extraction/New()
	special_equipment += /obj/item/paper/guides/antag/hdd_extraction
	return ..()


/datum/objective_item/steal/supermatter
	name = "一小片超物质晶体"
	targetitem = /obj/item/nuke_core/supermatter_sliver
	valid_containers = list(/obj/item/nuke_core_container/supermatter)
	difficulty = 5
	steal_hint = "空间站超物质晶体引擎的一小块碎片。"

/datum/objective_item/steal/supermatter/New()
	special_equipment += /obj/item/storage/box/syndie_kit/supermatter
	..()

/datum/objective_item/steal/supermatter/target_exists()
	return GLOB.main_supermatter_engine != null

// Doesn't need item_owner = (JOB_AI) because this handily functions as a murder objective if there isn't one
/datum/objective_item/steal/functionalai
	name = "一台正常运作的 AI"
	targetitem = /obj/item/aicard
	difficulty = 5
	steal_hint = "一张智能卡或一套 MOD 模块化外骨骼，其中装有活跃且正常运作的 AI。"

/datum/objective_item/steal/functionalai/New()
	. = ..()
	altitems += typesof(/obj/item/mod/control) // only here so we can account for AIs tucked away in a MODsuit.

/datum/objective_item/steal/functionalai/check_special_completion(obj/item/potential_storage)
	var/mob/living/silicon/ai/being

	if(istype(potential_storage, /obj/item/aicard))
		var/obj/item/aicard/card = potential_storage
		being = card.AI // why is this one capitalized and the other one not? i wish i knew.
	// SKYRAT EDIT REMOVAL START - MOD PAI
	/*else if(istype(potential_storage, /obj/item/mod/control))
		var/obj/item/mod/control/suit = potential_storage
		if(isAI(suit.ai_assistant))
			being = suit.ai_assistant
	*/ // SKYRAT EDIT REMOVAL END
	else
		stack_trace("check_special_completion() called on [src] with [potential_storage] ([potential_storage.type])! That's not supposed to happen!")
		return FALSE

	if(isAI(being) && being.stat != DEAD)
		return TRUE

	return FALSE

/datum/objective_item/steal/blueprints
	name = "空间站蓝图"
	targetitem = /obj/item/blueprints
	excludefromjob = list(JOB_CHIEF_ENGINEER)
	item_owner = list(JOB_CHIEF_ENGINEER)
	altitems = list(/obj/item/photo)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "空间站的蓝图，在总工程师的储物柜中或由其随身携带。照片也可以。"

/obj/item/blueprints/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/blueprints)

/datum/objective_item/steal/blueprints/check_special_completion(obj/item/I)
	if(istype(I, /obj/item/blueprints))
		return TRUE
	if(istype(I, /obj/item/photo))
		var/obj/item/photo/P = I
		if(P.picture.has_blueprints) //if the blueprints are in frame
			return TRUE
	return FALSE

/datum/objective_item/steal/blackbox
	name = "黑匣子"
	targetitem = /obj/item/blackbox
	excludefromjob = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)
	exists_on_map = TRUE
	difficulty = 4
	steal_hint = "空间站的数据黑匣子，只存在于电信机房中。"
	destruction_method = "太坚固了，无法以常规手段摧毁。需要用超物质将其化为灰烬，或在教堂的焚化炉中烧毁。"

/obj/item/blackbox/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/blackbox)


// A number of special early-game steal objectives intended to be used with the steal-and-destroy objective.
// They're basically items of utility or emotional value that may be found on many players or lying around the station.
/datum/objective_item/steal/traitor/insuls
	name = "一双绝缘手套"
	targetitem = /obj/item/clothing/gloves/color/yellow
	excludefromjob = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)
	item_owner = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "一双基础绝缘手套，通常由助理、工程师或货运技术员佩戴。"

/obj/item/clothing/gloves/color/yellow/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/gloves/color/yellow)

/datum/objective_item/steal/traitor/moth_plush
	name = "一个可爱的蛾人毛绒玩偶"
	targetitem = /obj/item/toy/plush/moth
	excludefromjob = list(JOB_PSYCHOLOGIST, JOB_PARAMEDIC, JOB_CHEMIST, JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CORONER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "一个蛾人毛绒玩偶。心理医生有一个，用来安慰患者。"

/obj/item/toy/plush/moth/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/toy/plush/moth)

/datum/objective_item/steal/traitor/lizard_plush
	name = "一个可爱的蜥蜴人毛绒玩偶"
	targetitem = /obj/item/toy/plush/lizard_plushie
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "一个蜥蜴人毛绒玩偶，通常藏在维护隧道中。"

/obj/item/toy/plush/lizard_plushie/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/toy/plush/lizard_plushie)

/datum/objective_item/steal/traitor/denied_stamp
	name = "货运部的驳回印章"
	targetitem = /obj/item/stamp/denied
	excludefromjob = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER, JOB_SHAFT_MINER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "货运部通常有好几个这种红色印章，用来处理文书。"

/obj/item/stamp/denied/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/stamp/denied)

/datum/objective_item/steal/traitor/granted_stamp
	name = "货运部的批准印章"
	targetitem = /obj/item/stamp/granted
	excludefromjob = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER, JOB_SHAFT_MINER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "货运部通常有好几个这种绿色印章，用来处理文书。"

/obj/item/stamp/granted/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/stamp/granted)

/datum/objective_item/steal/traitor/space_law
	name = "一本太空法书籍"
	targetitem = /obj/item/book/manual/wiki/security_space_law
	excludefromjob = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_LAWYER, JOB_DETECTIVE)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "有时由安保人员或律师持有。\
		法庭和图书馆也值得找找。"

/obj/item/book/manual/wiki/security_space_law/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/book/manual/wiki/security_space_law)

/datum/objective_item/steal/traitor/rpd
	name = "一台快速管道铺设器"
	targetitem = /obj/item/pipe_dispenser
	excludefromjob = list(
		JOB_ATMOSPHERIC_TECHNICIAN,
		JOB_STATION_ENGINEER,
		JOB_CHIEF_ENGINEER,
		JOB_SCIENTIST,
		JOB_RESEARCH_DIRECTOR,
		JOB_GENETICIST,
		JOB_ROBOTICIST,
	)
	item_owner = list(JOB_CHIEF_ENGINEER)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "工程师、大气技术员和军械技术员常用的工具。"

/obj/item/pipe_dispenser/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/pipe_dispenser)

/datum/objective_item/steal/traitor/donut_box
	name = "一盒珍贵的甜甜圈"
	targetitem = /obj/item/storage/fancy/donut_box
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_QUARTERMASTER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
		JOB_LAWYER,
		JOB_DETECTIVE,
	)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "人人都有一盒甜甜圈。最常见的位置是舰桥、安保部和各部门的休息室。"

/obj/item/storage/fancy/donut_box/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/storage/fancy/donut_box)

/datum/objective_item/steal/spy
	objective_type = OBJECTIVE_ITEM_TYPE_SPY

/datum/objective_item/steal/spy/lamarr
	name = "科研主管的宠物猎头蟹"
	targetitem = /obj/item/clothing/mask/facehugger/lamarr
	excludefromjob = list(JOB_RESEARCH_DIRECTOR)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "科研主管的宠物猎头蟹拉玛，关在其办公室的安全笼中。"

/obj/item/clothing/mask/facehugger/lamarr/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/clothing/mask/facehugger/lamarr)

/datum/objective_item/steal/spy/disabler
	name = "一把制伏枪"
	targetitem = /obj/item/gun/energy/disabler
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	difficulty = 2
	steal_hint = "一把手持制伏枪，通常由安保员携带。"

/datum/objective_item/steal/spy/energy_gun
	name = "一把能量枪"
	targetitem = /obj/item/gun/energy/e_gun
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一把双模式能量枪，存放在空间站军械库中，部分部门主管也会携带以作防身。"

/datum/objective_item/steal/spy/energy_gun/check_special_completion(obj/item/thing)
	return thing.type == /obj/item/gun/energy/e_gun

/obj/item/gun/energy/e_gun/add_stealing_item_objective()
	if(type == /obj/item/gun/energy/e_gun)
		return add_item_to_steal(src, /obj/item/gun/energy/e_gun)

/datum/objective_item/steal/spy/laser_gun
	name = "一把激光枪"
	targetitem = /obj/item/gun/energy/laser
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "空间站军械库中的一把普通激光枪。"

/datum/objective_item/steal/spy/laser_gun/check_special_completion(obj/item/thing)
	return thing.type == /obj/item/gun/energy/laser

/obj/item/gun/energy/laser/add_stealing_item_objective()
	if(type == /obj/item/gun/energy/laser)
		return add_item_to_steal(src, /obj/item/gun/energy/laser)

/datum/objective_item/steal/spy/shotgun
	name = "一把防暴霰弹枪"
	targetitem = /obj/item/gun/ballistic/shotgun/riot
	excludefromjob = list(
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "空间站军械库中用于镇压暴乱的霰弹枪。弹无虚发。"

/obj/item/gun/ballistic/shotgun/riot/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/ballistic/shotgun/riot)

/datum/objective_item/steal/spy/temp_gun
	name = "安保部的温度枪"
	targetitem = /obj/item/gun/energy/temperature/security
	excludefromjob = list(
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	exists_on_map = TRUE
	difficulty = 2 // lowered for the meme
	steal_hint = "安保部那把“可靠”的温度枪，存放在空间站军械库中。"

/obj/item/gun/energy/temperature/security/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/gun/energy/temperature/security)

/datum/objective_item/steal/spy/stamp
	name = "一名部门主管的印章"
	targetitem = /obj/item/stamp/head
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
	)
	exists_on_map = TRUE
	difficulty = 1
	steal_hint = "某位部门主管的印章，放在其办公室中。"

/obj/item/stamp/head/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/stamp/head)

/datum/objective_item/steal/spy/sunglasses
	name = "一副太阳镜"
	targetitem = /obj/item/clothing/glasses/sunglasses
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_CHIEF_ENGINEER,
		JOB_CHIEF_MEDICAL_OFFICER,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_LAWYER,
		JOB_QUARTERMASTER,
		JOB_RESEARCH_DIRECTOR,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	difficulty = 1
	steal_hint = "一副太阳镜。律师和部分部门主管通常有好几副。\
		你也可以通过拆解 HUD 眼镜获得。"

/datum/objective_item/steal/spy/ce_modsuit
	name = "总工程师的高级型 MOD 控制单元"
	targetitem = /obj/item/mod/control/pre_equipped/advanced
	excludefromjob = list(JOB_CHIEF_ENGINEER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "标准工程型 MOD 模块化外骨骼的高级版本，通常由总工程师穿戴。"

/obj/item/mod/control/pre_equipped/advanced/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/mod/control/pre_equipped/advanced)

/datum/objective_item/steal/spy/rd_modsuit
	name = "科研主管的研究型 MOD 控制单元"
	targetitem = /obj/item/mod/control/pre_equipped/research
	excludefromjob = list(JOB_RESEARCH_DIRECTOR)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一套笨重的 MOD 模块化外骨骼，科研主管通常穿着它来抵御工作中的危险。"

/obj/item/mod/control/pre_equipped/research/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/mod/control/pre_equipped/research)

/datum/objective_item/steal/spy/cmo_modsuit
	name = "首席医疗官的救援型 MOD 控制单元"
	targetitem = /obj/item/mod/control/pre_equipped/rescue
	excludefromjob = list(JOB_CHIEF_MEDICAL_OFFICER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "首席医疗官在危险环境中执行救援任务时有时会穿戴的 MOD 模块化外骨骼。"

/obj/item/mod/control/pre_equipped/rescue/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/mod/control/pre_equipped/rescue)

/datum/objective_item/steal/spy/cmo_defib
	name = "首席医疗官的紧凑型除颤器"
	targetitem = /obj/item/defibrillator/compact/loaded/cmo
	excludefromjob = list(JOB_CHIEF_MEDICAL_OFFICER)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "紧凑型除颤器，由首席医疗官随身携带或存放在其储物柜中。"

/obj/item/defibrillator/compact/loaded/cmo/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/defibrillator/compact/loaded/cmo)

/datum/objective_item/steal/spy/hos_modsuit
	name = "安保主管的卫护型 MOD 控制单元"
	targetitem = /obj/item/mod/control/pre_equipped/safeguard
	excludefromjob = list(JOB_HEAD_OF_SECURITY)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "一套高级 MOD 模块化外骨骼，安保主管在需要逮捕入侵空间站的敌人时有时会穿戴。"

/obj/item/mod/control/pre_equipped/safeguard/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/mod/control/pre_equipped/safeguard)

/datum/objective_item/steal/spy/stun_baton
	name = "一根电击警棍"
	targetitem = /obj/item/melee/baton/security
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	difficulty = 2
	steal_hint = "从安保部偷取任意一根电击警棍。"

/datum/objective_item/steal/spy/stun_baton/check_special_completion(obj/item/thing)
	return !istype(thing, /obj/item/melee/baton/security/cattleprod)

/datum/objective_item/steal/spy/det_baton
	name = "侦探的警棍"
	targetitem = /obj/item/melee/baton
	excludefromjob = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_PERSONNEL,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
		JOB_WARDEN,
	)
	exists_on_map = TRUE
	difficulty = 2
	steal_hint = "侦探的旧木警棍，通常由其随身携带以作防身。"

/datum/objective_item/steal/spy/det_baton/check_special_completion(obj/item/thing)
	return thing.type == /obj/item/melee/baton

/obj/item/melee/baton/add_stealing_item_objective()
	if(type == /obj/item/melee/baton)
		return add_item_to_steal(src, /obj/item/melee/baton)

/datum/objective_item/steal/spy/captain_sabre_sheathe
	name = "舰长的军刀鞘"
	targetitem = /obj/item/storage/belt/sheath/sabre
	excludefromjob = list(JOB_CAPTAIN)
	exists_on_map = TRUE
	difficulty = 3
	steal_hint = "舰长军刀的刀鞘，放在其储物柜中，或一直系在其腰间。"

/obj/item/storage/belt/sheath/sabre/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/storage/belt/sheath/sabre)
