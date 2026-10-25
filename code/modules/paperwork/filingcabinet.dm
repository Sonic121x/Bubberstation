/* Filing cabinets!
 * Contains:
 * Filing Cabinets
 * Security Record Cabinets
 * Medical Record Cabinets
 * Employment Contract Cabinets
 */


/*
 * Filing Cabinets
 */
/obj/structure/filingcabinet
	name = "档案柜"
	desc = "一个带抽屉的大柜子。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2)

/obj/structure/filingcabinet/chestdrawer
	name = "抽屉柜"
	icon_state = "chestdrawer"

/obj/structure/filingcabinet/chestdrawer/wheeled
	name = "带轮抽屉柜"
	desc = "一个带抽屉的小柜子。这个还装了轮子！"
	anchored = FALSE

/obj/structure/filingcabinet/white
	icon_state = "tallcabinet"

/obj/structure/filingcabinet/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/obj/item/I in loc)
			if(I.w_class < WEIGHT_CLASS_NORMAL) //there probably shouldn't be anything placed ontop of filing cabinets in a map that isn't meant to go in them
				I.forceMove(src)

/obj/structure/filingcabinet/atom_deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/iron(loc, 2)
	for(var/obj/item/obj in src)
		obj.forceMove(loc)

/obj/structure/filingcabinet/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(tool.w_class < WEIGHT_CLASS_NORMAL)
		if(!user.transferItemToLoc(tool, src))
			return ITEM_INTERACT_BLOCKING
		to_chat(user, span_notice("你把 [tool] 放进 [src]。"))
		icon_state = "[initial(icon_state)]-open"
		sleep(0.5 SECONDS)
		icon_state = initial(icon_state)
		return ITEM_INTERACT_SUCCESS
	if(!user.combat_mode || (tool.item_flags & NOBLUDGEON))
		to_chat(user, span_warning("你不能把 [tool] 放进 [src]！"))
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/structure/filingcabinet/wrench_act_secondary(mob/living/user, obj/item/tool)
	to_chat(user, span_notice("你开始[anchored ? "松开" : "拧紧"] [src] 的螺栓。"))
	if(!tool.use_tool(src, user, 20, volume=50))
		return ITEM_INTERACT_BLOCKING
	to_chat(user, span_notice("你成功[anchored ? "松开" : "拧紧"]了 [src] 的螺栓。"))
	set_anchored(!anchored)
	return ITEM_INTERACT_SUCCESS

/obj/structure/filingcabinet/attack_hand(mob/living/carbon/user, list/modifiers)
	. = ..()
	ui_interact(user)

/obj/structure/filingcabinet/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FilingCabinet")
		ui.open()

/obj/structure/filingcabinet/ui_data(mob/user)
	var/list/data = list()

	data["cabinet_name"] = "[name]"
	data["contents"] = list()
	data["contents_ref"] = list()
	for(var/obj/item/content in src)
		data["contents"] += "[content]"
		data["contents_ref"] += "[REF(content)]"

	return data

/obj/structure/filingcabinet/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		// Take the object out
		if("remove_object")
			var/obj/item/content = locate(params["ref"]) in src
			if(istype(content) && in_range(src, usr))
				usr.put_in_hands(content)
				icon_state = "[initial(icon_state)]-open"
				addtimer(VARSET_CALLBACK(src, icon_state, initial(icon_state)), 0.5 SECONDS)
				return TRUE

/obj/structure/filingcabinet/attack_tk(mob/user)
	if(anchored)
		return attack_self_tk(user)
	return ..()

/obj/structure/filingcabinet/attack_self_tk(mob/user)
	. = ITEM_INTERACT_BLOCKING
	if(contents.len)
		if(prob(40 + contents.len * 5))
			var/obj/item/I = pick(contents)
			I.forceMove(loc)
			if(prob(25))
				step_rand(I)
			to_chat(user, span_notice("你随机从 [src] 中抽出了 \a [I]。"))
			return
	to_chat(user, span_notice("你在 [src] 里什么也没找到。"))

/*
 * Security Record Cabinets
 */
/obj/structure/filingcabinet/security
	var/virgin = TRUE

/obj/structure/filingcabinet/security/proc/populate()
	if(!virgin)
		return
	for(var/datum/record/crew/target in GLOB.manifest.general)
		var/obj/item/paper/rapsheet = target.get_rapsheet()
		rapsheet.forceMove(src)
		virgin = FALSE //tabbing here is correct- it's possible for people to try and use it
					//before the records have been generated, so we do this inside the loop.

/obj/structure/filingcabinet/security/attack_hand(mob/user, list/modifiers)
	populate()
	return ..()

/obj/structure/filingcabinet/security/attack_tk()
	populate()
	return ..()

/*
 * Medical Record Cabinets
 */
/obj/structure/filingcabinet/medical
	///This var is so that its filled on crew interaction to be as accurate (including latejoins) as possible, true until first interact
	var/virgin = TRUE

/obj/structure/filingcabinet/medical/proc/populate()
	if(!virgin)
		return
	for(var/datum/record/crew/record in GLOB.manifest.general)
		var/obj/item/paper/med_record_paper = new /obj/item/paper(src)
		var/med_record_text = "<CENTER><B>医疗记录</B></CENTER><BR>"
		med_record_text += "姓名：[record.name] 职衔：[record.rank]<BR>\n性别：[record.gender]<BR>\n年龄：[record.age]<BR>"
		var/list/note_texts = list()
		for(var/datum/medical_note/note as anything in record.medical_notes)
			note_texts += note.content
		med_record_text += "<BR>\n<CENTER><B>医疗数据</B></CENTER><BR>\n血型：[record.blood_type]<BR>\nDNA：[record.dna_string]<BR>\n<BR>\n身体状态：[record.physical_status]<BR>\n精神状态：[record.mental_status]<BR>\n轻微残疾：[record.minor_disabilities]<BR>\n详情：[record.minor_disabilities_desc]<BR>\n<BR>\n重大残疾：[record.major_disabilities]<BR>\n详情：[record.major_disabilities_desc]<BR>\n<BR>\n重要备注：<BR>\n\t[jointext(note_texts, "<BR>\n\t")]<BR>\n<BR>\n<CENTER><B>评论/日志</B></CENTER><BR>"
		med_record_text += "</TT>"
		med_record_paper.add_raw_text(med_record_text)
		med_record_paper.name = "纸张 - '[record.name]'"
		med_record_paper.update_appearance()
		virgin = FALSE //tabbing here is correct- it's possible for people to try and use it
						//before the records have been generated, so we do this inside the loop.

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/filingcabinet/medical/attack_hand(mob/user, list/modifiers)
	populate()
	return ..()

/obj/structure/filingcabinet/medical/attack_tk()
	populate()
	return ..()

/*
 * Employment contract Cabinets
 */

GLOBAL_LIST_EMPTY(employmentCabinets)

/obj/structure/filingcabinet/employment
	icon_state = "employmentcabinet"
	///This var is so that its filled on crew interaction to be as accurate (including latejoins) as possible, true until first interact
	var/virgin = TRUE

/obj/structure/filingcabinet/employment/Initialize(mapload)
	. = ..()
	GLOB.employmentCabinets += src

/obj/structure/filingcabinet/employment/Destroy()
	GLOB.employmentCabinets -= src
	return ..()

/obj/structure/filingcabinet/employment/proc/fillCurrent()
	//This proc fills the cabinet with the current crew.
	for(var/datum/record/locked/target in GLOB.manifest.locked)
		var/datum/mind/filed_mind = target.mind_ref.resolve()
		if(filed_mind && ishuman(filed_mind.current))
			addFile(filed_mind.current)

/obj/structure/filingcabinet/employment/proc/addFile(mob/living/carbon/human/employee)
	new /obj/item/paper/employment_contract(src, employee.mind.name)

/obj/structure/filingcabinet/employment/interact(mob/user)
	if(virgin)
		fillCurrent()
		virgin = FALSE
	return ..()
