/mob/living/silicon/robot/examine(mob/user)
	. = list()
	if(desc)
		. += "[desc]"

	var/model_name = model ? "\improper [model.name]" : "\improper 默认"
	. += "目前是一具 <b>[model_name] 型</b>半机械人。"

	var/obj/act_module = get_active_held_item()
	if(act_module)
		. += "正拿着 [icon2html(act_module, user)] [act_module]。"
	. += get_status_effect_examinations(user)
	if (get_brute_loss())
		if (get_brute_loss() < maxHealth*0.5)
			. += span_warning("看起来略有凹陷。")
		else
			. += span_boldwarning("看起来凹陷严重！")
	if (get_fire_loss() || get_tox_loss())
		var/overall_fireloss = get_fire_loss() + get_tox_loss()
		if (overall_fireloss < maxHealth * 0.5)
			. += span_warning("看起来略有烧焦。")
		else
			. += span_boldwarning("看起来严重烧焦，并被高温扭曲！")
	if (health < -maxHealth*0.5)
		. += span_warning("看起来几乎无法运作。")
	if (fire_stacks < 0)
		. += span_warning("身上沾满了水。")
	else if (fire_stacks > 0)
		. += span_warning("表面覆着一层可燃物。")

	if(opened)
		. += span_warning("盖板已打开，电池[cell ? "已安装" : "缺失"]。")
	else
		var/cover_message = "盖板已关闭"
		if(locked)
			if(user == src)
				cover_message += "，但<a href='byond://?src=[REF(src)];unlock_self=1'>你可以将其解锁</a>"
		else
			cover_message += "，而且看起来没有上锁"
		. += span_notice("[cover_message]。")

	if(cell && cell.charge <= 0)
		. += span_warning("电池指示灯正在闪红光！")

	if(IS_UNCONSCIOUS_AND_ALIVE(src))
		. += span_warning("似乎没有响应。")

	switch(stat)
		if(STABLE)
			if(shell)
				. += "看起来是一具[deployed ? "已激活" : "空的"] AI 外壳。"
			else if(!client)
				. += "看起来处于待机模式。" //afk
		if(DEAD)
			. += span_deadsay("看起来其系统已损坏，需要重置。")
	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	. += get_silicon_flavortext()
	//SKYRAT EDIT ADDITION END
	. += "</span>"

	. += ..()

/mob/living/silicon/robot/examine_descriptor(mob/user)
	return "半机械人"
