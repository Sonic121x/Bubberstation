//Alt method of removing the cell
/mob/living/silicon/robot/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if(!opened)
		return ..()
	if(!wiresexposed)
		if(!cell)
			balloon_alert(user, "没有电池！")
			return TRUE
		balloon_alert(user, "正在取出电池……")
		tool.play_tool_sound(src, 100)
		if(!tool.use_tool(src, user, 3 SECONDS) || !opened)
			balloon_alert(user, "被打断！")
			return TRUE
		tool.play_tool_sound(src, 100)
		balloon_alert(user, "电池已取出")
		cell.forceMove(drop_location())
		diag_hud_set_borgcell()
	return TRUE
