/obj/item/organ/brain/cybernetic
	name = "控制论大脑"
	desc = "一种在仿生人体内发现的机械大脑。不要与正电子脑混淆。"
	icon_state = "brain-c"
	organ_flags = ORGAN_ROBOTIC | ORGAN_VITAL | ORGAN_PROMINENT //BUBBER EDIT - Added ORGAN_PROMINENT
	failing_desc = "似乎已经损坏，不修理就无法工作。"
	shade_color = null
	var/emp_dmg_mult = 1 //BUBBER EDIT - Variable multiplier for damage from EMPs. Note the base damage is 20/10.
	var/emp_dmg_max = 999 ///BUBBER EDIT - Threshold before the organ simply stops taking damage from EMPs. Defaults to kill

/* BUBBER EDIT - Reformatted this to change text based on flags
/obj/item/organ/brain/cybernetic/brain_damage_examine()
	if(suicided)
		return span_info("Its circuitry is smoking slightly. They must not have been able to handle the stress of it all.")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("It seems to still have a bit of energy within it, but it's rather damaged... You may be able to repair it with a <b>multitool</b>.")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("You can feel the small spark of life still left in this one, but it's got some dents. You may be able to restore it with a <b>multitool</b>.")
		else
			return span_info("You can feel the small spark of life still left in this one.")
	else
		return span_info("This one is completely devoid of life.")
*/
//BUBBER EDIT - See above
/obj/item/organ/brain/cybernetic/brain_damage_examine()

	var/is_organic = (organ_flags & ORGAN_ORGANIC) //this determines if it'll print the organic or cybernetic texts

	if(suicided)
		return span_info("它的电路微微冒着烟。他们一定是承受不住这一切的压力。")
	if(brainmob && (decoy_override || brainmob.client || brainmob.get_ghost()))
		if(organ_flags & ORGAN_FAILING)
			return span_info("它内部似乎还残留着一点能量，但受损相当严重……你也许可以用[is_organic ? "一些<b>甘露醇</b>或" : ""]一把<b>多功能工具</b>修好它。")
		else if(damage >= BRAIN_DAMAGE_DEATH*0.5)
			return span_info("你能感觉到这一颗里还残留着一丝生命火花，不过它有些凹陷。你也许可以用[is_organic ? "一些<b>甘露醇</b>或" : ""]一把<b>多功能工具</b>让它恢复。")
		else
			return span_info("你能感觉到这一颗里还残留着一丝生命火花。")
	else
		return span_info("这一颗已经完全没有任何生命迹象。")
// EDIT END

/* BUBBER EDIT - Expands this proc for hybrid brain_size.
ORIGINAL:
/obj/item/organ/brain/cybernetic/check_for_repair(obj/item/item, mob/user)

	if (item.tool_behaviour == TOOL_MULTITOOL) //attempt to repair the brain
		if (brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] is far too damaged, there's nothing else we can do for it!"))
			return TRUE
		if (DOING_INTERACTION(user, src))
			to_chat(user, span_warning("you're already repairing [src]!"))
			return TRUE
		user.visible_message(span_notice("[user] slowly starts to repair [src] with [item]."), span_notice("You slowly start to repair [src] with [item]."))
		var/did_repair = FALSE
		while(damage > 0)
			if(item.use_tool(src, user, 3 SECONDS, volume = 50))
				did_repair = TRUE
				set_organ_damage(max(0, damage - 20))
			else
				break
		if (did_repair)
			if (damage > 0)
				user.visible_message(span_notice("[user] partially repairs [src] with [item]."), span_notice("You partially repair [src] with [item]."))
			else
				user.visible_message(span_notice("[user] fully repairs [src] with [item], causing its warning light to stop flashing."), span_notice("You fully repair [src] with [item], causing its warning light to stop flashing."))
		else
			to_chat(user, span_warning("You failed to repair [src] with [item]!"))
		return TRUE
	return FALSE
EDIT END */

// EDITED:
/obj/item/organ/brain/cybernetic/check_for_repair(obj/item/item, mob/user)
	if (item.tool_behaviour == TOOL_MULTITOOL && (organ_flags & ORGAN_ROBOTIC)) //robotic repair option
		if (brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] 受损太严重了，我们已经无能为力了！"))
			return TRUE

		if (DOING_INTERACTION(user, src))
			to_chat(user, span_warning("你已经在修理 [src] 了！"))
			return TRUE

		user.visible_message(span_notice("[user] 开始慢慢地用 [item] 修理 [src]。"), span_notice("你开始慢慢地用 [item] 修理 [src]。"))
		var/did_repair = FALSE
		while(damage > 0)
			if(item.use_tool(src, user, 3 SECONDS, volume = 50))
				did_repair = TRUE
				set_organ_damage(max(0, damage - 20))
			else
				break

		if (did_repair)
			if (damage > 0)
				user.visible_message(span_notice("[user] 用 [item] 部分修复了 [src]。"), span_notice("你用 [item] 部分修复了 [src]。"))
			else
				user.visible_message(span_notice("[user] 用 [item] 完全修复了 [src]，它的警示灯停止了闪烁。"), span_notice("你用 [item] 完全修复了 [src]，它的警示灯停止了闪烁。"))
		else
			to_chat(user, span_warning("你没能用 [item] 修好 [src]！"))

		return TRUE
	else if(damage && item.is_drainable() && item.reagents.has_reagent(/datum/reagent/medicine/mannitol) && (organ_flags & ORGAN_ORGANIC)) //ganic repair option (this is for the cortical children)
		if(brainmob?.health <= HEALTH_THRESHOLD_DEAD) //if the brain is fucked anyway, do nothing
			to_chat(user, span_warning("[src] 受损太严重了，我们已经无能为力了！"))
			return TRUE

		user.visible_message(span_notice("[user] 开始慢慢把 [item] 里的东西倒在 [src] 上。"), span_notice("你开始慢慢把 [item] 里的东西倒在 [src] 上。"))
		if(!do_after(user, 3 SECONDS, src))
			to_chat(user, span_warning("你没能把 [item] 里的东西倒在 [src] 上！"))
			return TRUE
		var/and_bright_shade = !shade_color ? "" : "，并泛出更明亮的[shade_color]色调"
		user.visible_message(span_notice("[user] 把 [item] 里的东西倒在 [src] 上，使它恢复原本的形状[and_bright_shade]。"), span_notice("你把 [item] 里的东西倒在 [src] 上，使它恢复原本的形状[and_bright_shade]。"))
		var/amount = item.reagents.get_reagent_amount(/datum/reagent/medicine/mannitol)
		var/healto = max(0, damage - amount * 2)
		item.reagents.remove_all(ROUND_UP(item.reagents.total_volume / amount * (damage - healto) * 0.5)) //only removes however much solution is needed while also taking into account how much of the solution is mannitol
		set_organ_damage(healto) //heals 2 damage per unit of mannitol, and by using "set_organ_damage", we clear the failing variable if that was up
		return TRUE

	return FALSE

/obj/item/organ/brain/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
//BUBBER EDIT BEGIN - can't be emp'd if dead
	if(owner.stat == DEAD)
		return
//BUBBER EDIT END
	switch(severity)
		if (EMP_HEAVY)
			to_chat(owner, span_boldwarning("你感觉[pick("脑子像被烤过一样", "头部一阵剧痛")]！")) //BUBBER EDIT - added alert text for getting EMP'd.
			owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, (20*emp_dmg_mult), emp_dmg_max) //BUBBER EDIT - cap implemented
		if (EMP_LIGHT)
			to_chat(owner, span_warning("你感到[pick("失去方向感", "困惑", "眩晕")]。")) //BUBBER EDIT - added alert text for getting EMP'd.
			owner.adjust_organ_loss(ORGAN_SLOT_BRAIN, (10*emp_dmg_mult), emp_dmg_max) //BUBBER EDIT - cap implemented

