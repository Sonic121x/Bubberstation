/obj/item/disk/nifsoft_uploader/soulcatcher
	name = "灵魂捕手"
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "灵魂捕手"
	program_desc = "“灵魂捕手”核心固件是对 NIF 内纳米机器系统的近乎完全的升级，据称其唯一用途是引导亡者。而实际上，这项升级的功能相当于一台共鸣模拟装置（Resonance Simulation Device，简称 RSD），一种能够承载他人意识（无论是否有上下文）的仪器。“共鸣”是一个术语，指那种产生某人意识的特定神经活动模式，由研究人员 Yun-Seo Jin 与 Kamakshi Padmanabhan 在 2500 年代初发现，并提出了如今被称为“金-帕德曼纳班共鸣”或“JP/灵魂共鸣”的概念。这种“共鸣”承载着智慧生命的意识、他们持续存在的感受，以及他们“我就是我”的自我认知。共鸣在结构与“强度”上因人而异，甚至会在一个人的一生中发生变化。当智慧生命的大脑死亡并停止神经活动时，共鸣便会彻底消散，残存的意识基本上只剩一道回声，随时间迅速消退。\n\n最早的 RSD 是庞大的机器，耗能惊人，使用最前沿却笨重的软件，以与原大脑 1:1 的精度“播放”某人的共鸣。然而随之而来的种种并发症至今仍在研究之中。共鸣是可复制的，也能够人工重建；然而就像复制遗传密码一样，捕获过程必须极其精确，并且要迅速完成。像 RSD 这样的仪器能够在共鸣终结之后捕捉到残存的意识，而通过人工神经活动将其恢复，可以赋予它再次延续的力量。灵魂捕手这类 RSD 只能在有限的距离内运作，否则就会因为信号不良而面临共鸣本质性损坏的风险。\n\n目前不可能同时在两处运行同一段共鸣，因为同一段共鸣出现在两处会产生干扰，就像降噪耳机一样。史莱姆以及其他群体意识能在一定程度上调节自身的谐波，承受部分失谐，并使自己与相近的谐波特征形成相长干涉。必须对当事人的大脑进行深度扫描，才能为其意识提供“上下文”；仅运行其共鸣并捕获意识，得到的人会拥有与原本相同的智力，却没有任何记忆或身份。由于大脑会不断生长，这些扫描会迅速过时，而要将它们完整保存下来又极其复杂。\n\n第一台便携式 RSD，也就是灵魂捕手，由蜘蛛氏族开发。它们最初的设计用途是：在不必担心目标身体挣扎的情况下，对其意识进行囚禁式审讯；以及让这个神秘轨道忍者团体中已故或年迈的成员能够指导外勤特工。这些灵魂捕手是播放共鸣的主要仪器，但医学科学的近期进展正在催生更多手段。偶尔，被称为“幻影”的“野生”共鸣会从异常来源进入最近的灵魂捕手中，正好像一把钥匙找到了自己的锁；关于这些幻影如何产生，存在着各种各样的理论。正如有些人（例如交错空间巫团的巫师们）会有意成为稳定的印痕以实现数字永生，其他人也有可能通过入侵的方式强行进入灵魂捕手，充当某种幻影。"
	purchase_price = 150 //RP tool
	persistence = TRUE
	able_to_keep = TRUE
	ui_icon = "ghost"

	/// What is the linked soulcatcher datum used by this NIFSoft?
	var/datum/weakref/linked_soulcatcher
	/// What action to bring up the soulcatcher is linked with this NIFSoft?
	var/datum/action/innate/soulcatcher/soulcatcher_action
	/// a list containing saved soulcatcher rooms
	var/list/saved_carrier_rooms = list()
	/// The item we are using to store the souls
	var/obj/item/carrier_holder/holder

/datum/nifsoft/soulcatcher/New()
	. = ..()
	soulcatcher_action = new(linked_mob)
	soulcatcher_action.Grant(linked_mob)
	soulcatcher_action.parent_nifsoft = WEAKREF(src)

	holder = new(linked_mob)
	var/datum/component/carrier/soulcatcher/new_soulcatcher = holder.AddComponent(/datum/component/carrier/soulcatcher/nifsoft)
	holder.name = "[linked_mob.name] 的灵魂捕手"

	for(var/room in saved_carrier_rooms)
		new_soulcatcher.create_room(room, saved_carrier_rooms[room])

	if(length(new_soulcatcher.carrier_rooms) > 1) //We don't need the default room anymore.
		new_soulcatcher.carrier_rooms -= new_soulcatcher.carrier_rooms[1]

	new_soulcatcher.name = "[linked_mob]"

	RegisterSignal(new_soulcatcher, COMSIG_QDELETING, PROC_REF(no_soulcatcher_component))
	linked_soulcatcher = WEAKREF(new_soulcatcher)
	update_theme() // because we have to do this after the soulcatcher is linked

/datum/nifsoft/soulcatcher/activate()
	. = ..()
	if(!linked_soulcatcher)
		return FALSE

	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	if(!current_soulcatcher)
		return FALSE

	current_soulcatcher.ui_interact(linked_mob)
	return TRUE

/// If the linked soulcatcher is being deleted we want to set the current linked soulcatcher to `FALSE`
/datum/nifsoft/soulcatcher/proc/no_soulcatcher_component()
	SIGNAL_HANDLER

	linked_soulcatcher = null

/datum/nifsoft/soulcatcher/Destroy()
	if(soulcatcher_action)
		soulcatcher_action.Remove()
		qdel(soulcatcher_action)

	if(linked_soulcatcher)
		var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
		if(current_soulcatcher)
			qdel(current_soulcatcher)

	qdel(holder)

	return ..()

/datum/nifsoft/soulcatcher/load_persistence_data()
	. = ..()
	var/datum/modular_persistence/persistence = .
	if(!persistence)
		return FALSE

	saved_carrier_rooms = params2list(persistence.nif_carrier_rooms)
	return TRUE

/datum/nifsoft/soulcatcher/save_persistence_data(datum/modular_persistence/persistence)
	. = ..()
	if(!.)
		return FALSE

	var/list/room_list = list()
	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	for(var/datum/carrier_room/room in current_soulcatcher.carrier_rooms)
		room_list[room.name] = room.room_description

	persistence.nif_carrier_rooms = list2params(room_list)
	return TRUE

/datum/nifsoft/soulcatcher/update_theme()
	. = ..()
	if(!.)
		return FALSE // uhoh

	if(isnull(linked_soulcatcher))
		return FALSE

	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	if(!istype(current_soulcatcher))
		stack_trace("[src] ([REF(src)]) tried to update its theme when it was missing a linked_soulcatcher component!")
		return FALSE
	current_soulcatcher.ui_theme = ui_theme

/datum/modular_persistence
	///A param string containing soulcatcher rooms
	var/nif_carrier_rooms = ""

/datum/action/innate/soulcatcher
	name = "灵魂捕手"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher"
	/// The weakref of the parent NIFSoft we belong to.
	var/datum/weakref/parent_nifsoft

/datum/action/innate/soulcatcher/Activate()
	. = ..()
	var/datum/nifsoft/soulcatcher/soulcatcher_nifsoft = parent_nifsoft.resolve()
	if(!soulcatcher_nifsoft)
		return FALSE

	soulcatcher_nifsoft.activate()

/// This is the object we use if we give a mob soulcatcher. Having the souls directly parented could cause issues.
/obj/item/carrier_holder
	name = "灵魂容器"
	desc = "你大概不应该看到这个东西……"

