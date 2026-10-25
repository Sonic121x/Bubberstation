/**
 * # Paperwork
 *
 * Paperwork documents that can be stamped by their associated stamp to provide a bonus to cargo.
 *
 * Paperwork documents are a cargo item meant to provide the opportunity to make money.
 * Each piece of paperwork has its own associated stamp it needs to be stamped with. Selling a
 * properly stamped piece of paperwork will provide a cash bonus to the cargo budget. If a document is
 * not properly stamped it will instead drain a small stipend from the cargo budget.
 *
 */

/obj/item/paperwork
	name = "公文文件"
	desc = "一堆杂乱无章的文件、研究结果与调查发现。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "docs_part"
	inhand_icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	layer = MOB_LAYER
	// Could use a more specific sound since it's a lot of paper (ditto with `/documents`).
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound = 'sound/items/handling/paper_pickup.ogg'
	///The stamp overlay, used to show that the paperwork is complete without making a bunch of sprites
	var/mutable_appearance/stamp_overlay
	///The specific stamp icon to be overlaid on the paperwork
	var/stamp_icon = "paper_stamp-void"
	///The stamp needed to "complete" this form.
	var/stamp_requested = /obj/item/stamp/void
	///Has the paperwork been properly stamped
	var/stamped = FALSE
	///The path to the job of the associated paperwork form
	var/stamp_job
	///Used to store the bonus text that displays when the paperwork's associated role reads it
	var/detailed_desc

/obj/item/paperwork/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("<i>当你翻阅这些文件时，你慢慢开始拼凑出自己正在读的内容。</i>")

/obj/item/paperwork/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stamp))
		return NONE

	if(stamped)
		return ITEM_INTERACT_BLOCKING

	if(istype(tool, stamp_requested))
		add_stamp()
		to_chat(user, span_notice("你快速翻阅文件，直到找到一处写着“此处盖章”的栏位，然后把这份公文填完了。"))
		return ITEM_INTERACT_SUCCESS

	var/datum/action/item_action/chameleon/change/stamp/stamp_action = locate() in tool.actions
	if(isnull(stamp_action))
		to_chat(user, span_warning("你在文件堆里翻找可以盖 [tool] 的地方，却什么也没找到。"))
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_notice("[tool] 变成了合适的印章，你用它把公文盖完了。"))
	stamp_action.update_look(stamp_requested)
	add_stamp()
	return ITEM_INTERACT_SUCCESS

/obj/item/paperwork/examine_more(mob/user)
	. = ..()

	if(ishuman(user))
		var/mob/living/carbon/human/viewer = user
		if(istype(viewer.mind?.assigned_role, stamp_job)) //Examining the paperwork as the proper job gets you some bonus details
			. += detailed_desc
		else
			if(stamped)
				. += span_info("这些文件似乎已经盖过章了。现在可以把它们交回中央指挥部了。")
			else
				var/datum/job/stamp_title = stamp_job
				var/title = initial(stamp_title.title)
				. += span_info("想读懂它让你头晕目眩。从勉强能辨认的几个词来看，这似乎是 [title] 的活儿。")

/obj/item/paperwork/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] 开始痛骂公文与官僚制度的低效。看起来 [user.p_theyre()] 想自杀！"))

	var/obj/item/paper/new_paper = new /obj/item/paper(get_turf(src))
	var/turf/turf_to_throw_at = get_ranged_target_turf(get_turf(src), pick(GLOB.alldirs))
	new_paper.throw_at(turf_to_throw_at, 2)

	var/obj/item/bodypart/BP = user.get_bodypart(pick(BODY_ZONE_HEAD))
	if(BP?.dismember())
		new_paper.visible_message(span_alert("[src] 射出一张纸，瞬间削掉了 [user] 的头！"))
	else
		user.visible_message(span_suicide("[user] 惊慌失措，开始窒息而亡！"))
		return OXYLOSS

	return MANUAL_SUICIDE

/**
 * Adds the stamp overlay and sets "stamped" to true
 *
 * Adds the stamp overlay to a piece of paperwork, and sets "stamped" to true.
 * Handled as a proc so that an object may be marked as "stamped" even when a stamp isn't present (like the photocopier)
 */
/obj/item/paperwork/proc/add_stamp()
	stamp_overlay = mutable_appearance('icons/obj/service/bureaucracy.dmi', stamp_icon)
	add_overlay(stamp_overlay)
	stamped = TRUE

/**
 * Copies the requested stamp, associated job, and associated icon of a given paperwork type
 *
 * Copies the stamp/job related info of a given paperwork type to the object
 * Used to mutate photocopied/ancient paperwork into behaving like their subtype counterparts without the extra details
 */
/obj/item/paperwork/proc/copy_stamp_info(obj/item/paperwork/paperwork_type)
	stamp_requested = initial(paperwork_type.stamp_requested)
	stamp_job = initial(paperwork_type.stamp_job)
	stamp_icon = initial(paperwork_type.stamp_icon)

//HEAD OF STAFF DOCUMENTS

/obj/item/paperwork/cargo
	stamp_requested = /obj/item/stamp/head/qm
	stamp_job = /datum/job/quartermaster
	stamp_icon = "paper_stamp-qm"

/obj/item/paperwork/cargo/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 这些文件是一堆乱七八糟的货运订单。这些文件的排序完全毫无道理可言。")
	detailed_desc += span_info(" 从表面看，除了一份要求追加第二台引擎的高优先级申请外，这里没什么不寻常的。")
	detailed_desc += span_info(" “优先申请理由”一栏被涂掉了，但页边空白处有一行字：“我们就是想试试两台引擎，别担心”。")
	detailed_desc += span_info(" 尽管文件杂乱无章，但都填写得当。你大概该给它盖个章。")

/obj/item/paperwork/security
	stamp_requested = /obj/item/stamp/head/hos
	stamp_job = /datum/job/head_of_security
	stamp_icon = "paper_stamp-hos"

/obj/item/paperwork/security/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 这叠文件与邻站正在处理的一起民事案件有关。")
	detailed_desc += span_info(" 文件中要求你审阅一份由该站律师提交的行为报告。")
	detailed_desc += span_info(" 案卷详细列出了对该站安保部的指控，包括失职、骚扰，以——")
	detailed_desc += span_info(" 简直胡说八道，安保队显然只是在做必须做的事。你大概该给它盖个章。")

/obj/item/paperwork/service
	stamp_requested = /obj/item/stamp/head/hop
	stamp_job = /datum/job/head_of_personnel
	stamp_icon = "paper_stamp-hop"

/obj/item/paperwork/service/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 你开始浏览这份文件。这是纳米传讯标准的 NT-435Z3 表格，用于向中央指挥部提出申请。")
	detailed_desc += span_info(" 看来附近某站提交了一份最高优先级的煤炭申请，数量大得离谱。")
	detailed_desc += span_info(" 申请列出的理由似乎填得很匆忙——“正在寻找为空间站供能的其他方法。”")
	detailed_desc += span_info(" 这种最高优先级的申请可不能等闲视之。你大概该给它盖个章。")

/obj/item/paperwork/medical
	stamp_requested = /obj/item/stamp/head/cmo
	stamp_job = /datum/job/chief_medical_officer
	stamp_icon = "paper_stamp-cmo"

/obj/item/paperwork/medical/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 这叠文件似乎是邻站的一份医疗报告，详细记录了对一种未知异星动物的尸检。")
	detailed_desc += span_info(" 直接翻到报告末尾才发现，该样本原来是该站酒保的宠物猴子。")
	detailed_desc += span_info(" 该样本曾在“一次与引擎无关的事故”中受到辐射，因而发生了变异。")
	detailed_desc += span_info(" 不管怎样，尸检结果看起来挺有用。你大概该给它盖个章。")


/obj/item/paperwork/engineering
	stamp_requested = /obj/item/stamp/head/ce
	stamp_job = /datum/job/chief_engineer
	stamp_icon = "paper_stamp-ce"

/obj/item/paperwork/engineering/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 这些是邻站的一份功率输出报告。它详细记录了该站在一个普通班次期间的功率输出及其他工程数据。")
	detailed_desc += span_info(" 查看日志时，你发现能量输出与引擎温度都急剧飙升，而不久之后，周边部门似乎被某种未知力量抽成了真空。")
	detailed_desc += span_info(" 显然该站工程部当时正在测试一套实验性引擎配置，只好用附近房间的空气来帮助冷却引擎。绝对的。")
	detailed_desc += span_info(" 哇，这可真够厉害的。你大概该给它盖个章。")

/obj/item/paperwork/research
	stamp_requested = /obj/item/stamp/head/rd
	stamp_job = /datum/job/research_director
	stamp_icon = "paper_stamp-rd"

/obj/item/paperwork/research/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 文件详细记录了邻站进行的一次标准军械测试的结果。")
	detailed_desc += span_info(" 继续往下读，你发现结果有些古怪——爆炸中心的位置似乎不对。")
	detailed_desc += span_info(" 如果你的计算没错，这次爆炸并非发生在该站的军械场，而是发生在该站的引擎室。")
	detailed_desc += span_info(" 不管怎样，这些仍是完全可用的测试结果。你大概该给它盖个章。")

/obj/item/paperwork/captain
	stamp_requested = /obj/item/stamp/head/captain
	stamp_job = /datum/job/captain
	stamp_icon = "paper_stamp-cap"

/obj/item/paperwork/captain/Initialize(mapload)
	. = ..()

	detailed_desc += span_info(" 这些文件是邻站舰长办公桌发来的一份未署名通讯。")
	detailed_desc += span_info(" 看起来是一份例行报到消息，报告该站正以最佳效率运转。")
	detailed_desc += span_info(" 消息反复强调引擎运转“完全正常”，并且正输出“成堆的”电力。")
	detailed_desc += span_info(" 一切都没问题。你大概该给它盖个章。")

//Photocopied paperwork. These are created when paperwork, whether stamped or otherwise, is printed. If it is stamped, it can be sold to cargo at the risk of the paperwork not being accepted (which takes a small fee from cargo).
//If it is unstamped it will lose you money like normal, unless it has been marked with a VOID stamp
/obj/item/paperwork/photocopy
	name = "复印公文文件"
	desc = "一堆更加杂乱的复印文件与公文。这些到底有没有按正确顺序复印啊？"
	stamp_icon = "paper_stamp-pc"
	/// Has the photocopy been marked with a "void" stamp. Used to prevent documents from draining money if they somehow make their way to cargo.
	var/voided = FALSE

/obj/item/paperwork/photocopy/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("这份公文的打印质量让它几乎完全无法辨认。")

/obj/item/paperwork/photocopy/examine_more(mob/user)
	. = ..()

	if(stamped)
		if(voided)
			. += span_notice("正面似乎被标上了“作废”。现在恐怕没人会接受这些了。")
		else
			. += span_notice("正面的印章似乎模糊褪色了。中央指挥部大概还是会接受这些吧？")
	else
		. += span_notice("这些看起来只是原始文件的复印件。")

/obj/item/paperwork/photocopy/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/stamp/void) || stamped || voided)
		return ..()
	to_chat(user, span_notice("你把 [tool] 牢牢盖在文件的正面。"))
	stamp_overlay = mutable_appearance('icons/obj/service/bureaucracy.dmi', "paper_stamp-void")
	add_overlay(stamp_overlay)
	voided = TRUE
	stamped = TRUE //It won't get you any money, but it also can't LOSE you money now.
	return ITEM_INTERACT_SUCCESS

//Ancient paperwork is a subtype of paperwork, meant to be used for any paperwork not spawned by the event.
//It doesn't have any of the flavor text that the event ones spawn with.

/obj/item/paperwork/ancient
	name = "古老公文"
	desc = "一堆积满灰尘、难看的碎纸片。里面的名字、日期和话题你一个也认不出来。这些到底有多古老？"

/obj/item/paperwork/ancient/Initialize(mapload)
	. = ..()

	detailed_desc = span_notice("很难说清这些有多古老、又是做什么用的，但中央指挥部或许还是乐意收下。")

	var/static/list/paperwork_to_use //Make the ancient paperwork function like one of the main types
	if(!paperwork_to_use)
		paperwork_to_use = subtypesof(/obj/item/paperwork)
		paperwork_to_use -= (list(/obj/item/paperwork/ancient, /obj/item/paperwork/photocopy)) //Get rid of the uncopiable paperwork types

	var/obj/item/paperwork/paperwork_type = pick(paperwork_to_use)
	copy_stamp_info(paperwork_type)
