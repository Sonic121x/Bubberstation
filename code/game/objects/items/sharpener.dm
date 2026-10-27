/**
* # Whetstone
*
* Items used for sharpening stuff
*
* Whetstones can be used to increase an item's force, throw_force and wound_bonus and it changes its sharpness to SHARP_EDGED. Whetstones do not work with energy weapons. Two-handed weapons will only get the throw_force bonus. A whetstone can only be used once.
*
*/
/obj/item/sharpener
	name = "磨刀石"
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "sharpener"
	desc = "一块能让东西变锋利的石头。"
	force = 5
	///Amount of uses the whetstone has. Set to -1 for functionally infinite uses.
	var/uses = 1
	///How much force the whetstone can add to an item.
	var/increment = 4
	///Maximum force sharpening items with the whetstone can result in
	var/max = 30
	///The prefix a whetstone applies when an item is sharpened with it
	var/prefix = "磨利的"
	///If TRUE, the whetstone will only sharpen already sharp items
	var/requires_sharpness = TRUE

/obj/item/sharpener/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(uses == 0)
		to_chat(user, span_warning("这块磨刀石磨损得太厉害，无法再次使用了！"))
		return ITEM_INTERACT_BLOCKING
	if(tool.force >= max || tool.throwforce >= max) //So the whetstone never reduces force or throw_force
		to_chat(user, span_warning("[tool]已经太强力了，无法再磨利！"))
		return ITEM_INTERACT_BLOCKING
	if(requires_sharpness && !tool.get_sharpness())
		to_chat(user, span_warning("你只能磨利本就锋利的物品，比如刀具！"))
		return ITEM_INTERACT_BLOCKING
	if(is_type_in_list(tool, list(/obj/item/melee/energy, /obj/item/dualsaber))) //You can't sharpen the photons in energy meelee weapons
		to_chat(user, span_warning("你觉得在[src]上使用[tool]，被改造的恐怕不会是[tool]！"))
		return ITEM_INTERACT_BLOCKING

	//This block is used to check more things if the item has a relevant component.
	var/signal_out = SEND_SIGNAL(tool, COMSIG_ITEM_SHARPEN_ACT, increment, max) //Stores the bitflags returned by SEND_SIGNAL
	if(signal_out & COMPONENT_BLOCK_SHARPEN_MAXED) //If the item's components enforce more limits on maximum power from sharpening,  we fail
		to_chat(user, span_warning("[tool]已经太强力了，无法再磨利！"))
		return ITEM_INTERACT_BLOCKING
	if(signal_out & COMPONENT_BLOCK_SHARPEN_BLOCKED)
		to_chat(user, span_warning("[tool]目前无法被磨利！"))
		return ITEM_INTERACT_BLOCKING
	if((signal_out & COMPONENT_BLOCK_SHARPEN_ALREADY) || (tool.force > initial(tool.force) && !signal_out)) //No sharpening stuff twice
		to_chat(user, span_warning("[tool]之前已经强化过了，无法再磨利！"))
		return ITEM_INTERACT_BLOCKING
	if(!(signal_out & COMPONENT_BLOCK_SHARPEN_APPLIED)) //If the item has a relevant component and COMPONENT_BLOCK_SHARPEN_APPLIED is returned, the item only gets the throw force increase
		tool.force = clamp(tool.force + increment, 0, max)
		tool.wound_bonus = tool.wound_bonus + increment //wound_bonus has no cap
	user.visible_message(span_notice("[user]用[src]磨利了[tool]！"), span_notice("你磨利了[tool]，让它比之前致命得多。"))
	playsound(src, 'sound/items/unsheath.ogg', 25, TRUE)
	if(!(signal_out & COMPONENT_BLOCK_SHARPEN_SHARPNESS))
		tool.sharpness = SHARP_EDGED //When you whetstone something, it becomes an edged weapon, even if it was previously dull or pointy
	tool.throwforce = clamp(tool.throwforce + increment, 0, max)
	tool.name = "[prefix] [tool.name]" //This adds a prefix and a space to the item's name regardless of what the prefix is
	desc = "[desc] 至少以前是这样。"
	uses-- //this doesn't cause issues because we check if uses == 0 earlier in this proc
	if(uses == 0)
		name = "磨损的[name]" //whetstone becomes used whetstone
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/sharpener/update_name()
	name = "[!uses ? "磨损的" : null][initial(name)]"
	return ..()

/**
* # Super whetstone
*
* Extremely powerful admin-only whetstone
*
* Whetstone that adds 200 damage to an item, with the maximum force and throw_force reachable with it being 200. As with normal whetstones, energy weapons cannot be sharpened with it and two-handed weapons will only get the throw_force bonus.
*
*/
/obj/item/sharpener/super
	name = "超级磨刀石"
	desc = "一块能让你的武器比嗑了阿德拉的爱因斯坦还锋利的石头。"
	increment = 200
	max = 200
	prefix = "超级磨利的"
	requires_sharpness = FALSE //Super whetstones can sharpen even tooboxes
