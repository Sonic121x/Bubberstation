/mob/living/silicon/ai/examine(mob/user)
	. = list("<span class='info'>这是 [icon2html(src, user)] <EM>[src]</EM>！", EXAMINE_SECTION_BREAK) //SKYRAT EDIT CHANGE
	if(stat == DEAD)
		. += span_warning("看起来已无法运作。")
	. += span_notice("地板<b>螺栓</b>已[is_anchored ? "拧紧" : "松开"]。")
	if(is_anchored)
		if(!opened)
			if(!emagged)
				. += span_notice("访问面板[stat == DEAD ? "已损坏" : "已关闭并上锁"]，但可以被<b>撬开</b>。")
			else
				. += span_warning("访问面板锁正在冒火花，盖板可以被<b>撬开</b>。")
		else
			. += span_notice("神经网络连接可以被<b>切断</b>，访问面板盖可以被<b>撬</b>回原位。")
	if(stat != DEAD)
		if (get_brute_loss())
			if (get_brute_loss() < 30)
				. += span_warning("看起来略有凹陷。")
			else
				. += span_warning("<B>看起来凹陷严重！</B>")
		if (get_fire_loss())
			if (get_fire_loss() < 30)
				. += span_warning("看起来略有烧焦。")
			else
				. += span_warning("<B>外壳已熔化，并被高温扭曲！</B>")
		if(deployed_shell)
			. += "无线网络指示灯正在闪烁。"
		else if (!shunted && !client)
			. += "[src]Core.exe 已停止响应！NTOS 正在寻找该问题的解决方案……"
	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	. += get_silicon_flavortext()
	//SKYRAT EDIT ADDITION END
	. += "</span>"

	. += ..()
