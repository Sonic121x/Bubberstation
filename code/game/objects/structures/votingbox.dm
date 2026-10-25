#define VOTE_TEXT_LIMIT 255
#define MAX_VOTES 255

/obj/structure/votebox
	name = "投票箱"
	desc = "一台自动投票箱。"

	icon = 'icons/obj/storage/box.dmi'
	icon_state = "votebox_maint"

	anchored = TRUE
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 15)
	var/obj/item/card/id/owner //Slapping the box with this ID starts/ends the vote.

	var/voting_active = FALSE //Voting or Maintenance Mode
	var/id_auth = FALSE //One vote per ID.
	var/vote_description = ""

	var/list/voted //List of ID's that already voted.
	COOLDOWN_DECLARE(vote_print_cooldown)

/obj/structure/votebox/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/card/id))
		if(owner)
			return ITEM_INTERACT_BLOCKING

		register_owner(tool ,user)
		return ITEM_INTERACT_SUCCESS

	if(istype(tool, /obj/item/paper))
		if(!voting_active)
			to_chat(user,span_warning("[src]正处于维护模式。目前无法投票。"))
			return ITEM_INTERACT_BLOCKING
		apply_vote(tool ,user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/votebox/interact(mob/user)
	..()
	ui_interact(user)

/obj/structure/votebox/ui_interact(mob/user)
	. = ..()

	var/list/dat = list()
	if(!owner)
		dat += "<h1> 未注册。刷 ID 卡以注册为投票箱操作员 </h1>"
	dat += "<h1>[vote_description]</h1>"
	if(is_operator(user))
		dat += "投票开关：<a href='byond://?src=[REF(src)];act=toggle_vote'>[voting_active ? "进行中" : "维护模式"]</a><br>"
		dat += "设置描述：<a href='byond://?src=[REF(src)];act=set_desc'>设置描述</a><br>"
		dat += "每张 ID 限投一票：<a href='byond://?src=[REF(src)];act=toggle_auth'>[id_auth ? "是" : "否"]</a><br>"
		dat += "重置已投票 ID：<a href='byond://?src=[REF(src)];act=reset_voted'>重置</a><br>"
		dat += "随机抽取选票：<a href='byond://?src=[REF(src)];act=raffle'>抽签</a><br>"
		dat += "粉碎选票：<a href='byond://?src=[REF(src)];act=shred'>粉碎</a><br>"
		dat += "统计选票：<a href='byond://?src=[REF(src)];act=tally'>统计</a><br>"

	var/datum/browser/popup = new(user, "votebox", "投票箱", 300, 300)
	popup.set_content(dat.Join())
	popup.open()

/obj/structure/votebox/Topic(href, href_list)
	if(..())
		return

	var/mob/user = usr
	if(!can_interact(user))
		return
	if(!is_operator(user))
		to_chat(user,span_warning("需要投票箱操作员权限！"))
		return

	if(href_list["act"])
		switch(href_list["act"])
			if("toggle_vote")
				voting_active = !voting_active
				update_appearance()
			if("toggle_auth")
				id_auth = !id_auth
			if("reset_voted")
				if(voted)
					voted.Cut()
				to_chat(user,span_notice("你重置了投票者缓冲列表。所有人都可以重新投票了。"))
			if("raffle")
				raffle(user)
			if("shred")
				shred(user)
			if("tally")
				print_tally(user)
			if("set_desc")
				set_description(user)
		interact(user)

/obj/structure/votebox/proc/register_owner(obj/item/card/id/I,mob/living/user)
	owner = I
	to_chat(user,span_notice("你把[src]注册到了自己的 ID 卡上。"))
	ui_interact(user)

/obj/structure/votebox/proc/set_description(mob/user)
	var/new_description = tgui_input_text(user, "输入新的描述", "投票描述", vote_description, multiline = TRUE, max_length = MAX_DESC_LEN)
	if(new_description)
		vote_description = new_description

/obj/structure/votebox/proc/is_operator(mob/living/user)
	return (istype(user) && user?.get_idcard() == owner)

/obj/structure/votebox/proc/apply_vote(obj/item/paper/I,mob/living/user)
	var/obj/item/card/id/voter_card = user.get_idcard()
	if(id_auth)
		if(!voter_card)
			to_chat(user,span_warning("[src]需要有效的 ID 卡才能投票！"))
			return
		if(voted && (voter_card in voted))
			to_chat(user,span_warning("[src]每人只允许投一票。"))
			return
	if(user.transferItemToLoc(I,src))
		if(!voted)
			voted = list()
		voted += voter_card
		to_chat(user,span_notice("你投出了自己的一票。"))

/obj/structure/votebox/proc/valid_vote(obj/item/paper/voting_slip)
	if(voting_slip.get_total_length() > VOTE_TEXT_LIMIT)
		return FALSE

	for(var/datum/paper_input/text as anything in voting_slip.raw_text_inputs)
		if(findtext(text.raw_text, "<h1>Voting Results:</h1><hr><ol>"))
			return FALSE
	return TRUE

/obj/structure/votebox/proc/shred(mob/user)
	for(var/obj/item/paper/P in contents)
		qdel(P)
	to_chat(user,span_notice("你粉碎了当前的选票。"))

/obj/structure/votebox/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool, time = 4 SECONDS)
	return ITEM_INTERACT_SUCCESS

/obj/structure/votebox/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(voting_active)
		to_chat(user,span_warning("只有处于维护模式时才能取出选票！"))
		return FALSE
	dump_contents()
	to_chat(user,span_notice("你打开选票取出舱门，把所有选票都倒了出来。"))
	return TRUE

/obj/structure/votebox/dump_contents()
	var/atom/droppoint = drop_location()
	for(var/atom/movable/AM in contents)
		AM.forceMove(droppoint)

/obj/structure/votebox/atom_deconstruct(disassembled)
	dump_contents()

/obj/structure/votebox/proc/raffle(mob/user)
	var/list/options = list()
	for(var/obj/item/paper/P in contents)
		options += P
	if(!length(options))
		to_chat(user, span_warning("[src]是空的！"))
	else
		var/obj/item/paper/P = pick(options)
		user.put_in_hands(P)
		to_chat(user, span_notice("[src]弹出了一张随机选票。"))

/obj/structure/votebox/proc/print_tally(mob/user)
	var/list/results = list()
	var/i = 0
	for(var/obj/item/paper/paper_content in contents)
		if(i++ > MAX_VOTES)
			break
		if(!valid_vote(paper_content))
			continue

		var/full_vote_text = ""
		for(var/datum/paper_input/text as anything in paper_content.raw_text_inputs)
			full_vote_text += "[text.raw_text]"

		if(!results[full_vote_text])
			results[full_vote_text] = 1
		else
			results[full_vote_text] += 1

	sortTim(results, cmp=/proc/cmp_numeric_dsc, associative = TRUE)
	if(!COOLDOWN_FINISHED(src, vote_print_cooldown))
		return
	COOLDOWN_START(src, vote_print_cooldown, 60 SECONDS)
	var/obj/item/paper/vote_tally_paper = new(drop_location())
	var/list/tally = list()
	tally += {"
		<style>
			.vote_box_content{
				max-width:250px;
				display:inline-block;
				overflow:hidden;
				text-overflow:ellipsis;
				white-space:nowrap;
				vertical-align:bottom
			}
			.vote_box_content br {
				display: none;
			}
			.vote_box_content hr {
				display: none;
			}
		</style>"}

	tally += "<h1>投票结果：</h1><br/><h2>[vote_description]</h2><hr><ol>"
	for(var/option in results)
		tally += "<li>\"<span class='vote_box_content'>[option]</span>\" - [results[option]] 票。</li>"
	tally += "</ol>"

	vote_tally_paper.add_raw_text(tally.Join())
	vote_tally_paper.name = "投票结果"
	vote_tally_paper.update_appearance()
	user.put_in_hands(vote_tally_paper)
	to_chat(user,span_notice("[src]打印出了投票统计结果。"))

/obj/structure/votebox/update_icon_state()
	icon_state = "votebox_[voting_active ? "active" : "maint"]"
	return ..()

#undef VOTE_TEXT_LIMIT
#undef MAX_VOTES
