/datum/buildmode_mode/outfit
	key = "outfit"
	var/datum/outfit/dressuptime

/datum/buildmode_mode/outfit/Destroy()
	dressuptime = null
	return ..()

/datum/buildmode_mode/outfit/show_help(client/builder)
	to_chat(builder, span_purple(boxed_message(
		"[span_bold("选择要装备的套装")] -> 在建造模式按钮上单击右键\n\
		[span_bold("装备所选套装")] -> 在 mob/living/carbon/human 上单击左键\n\
		[span_bold("脱除并删除当前套装")] -> 在 mob/living/carbon/human 上单击右键"))
	)

/datum/buildmode_mode/outfit/Reset()
	. = ..()
	dressuptime = null

/datum/buildmode_mode/outfit/change_settings(client/c)
	dressuptime = c.robust_dress_shop()

/datum/buildmode_mode/outfit/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)

	if(!ishuman(object))
		return
	var/mob/living/carbon/human/dollie = object

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isnull(dressuptime))
			to_chat(c, span_warning("请先选择一个套装。"))
			return

		for (var/item in dollie.get_equipped_items(INCLUDE_POCKETS))
			qdel(item)
		if(dressuptime != "Naked")
			dollie.equipOutfit(dressuptime)

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		for (var/item in dollie.get_equipped_items(INCLUDE_POCKETS))
			qdel(item)
