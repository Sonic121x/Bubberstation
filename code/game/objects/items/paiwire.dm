/obj/item/pai_cable
	desc = "一根柔韧的包覆线缆，一端配有通用插头。"
	name = "数据线缆"
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "wire1"
	item_flags = NOBLUDGEON
	///The current machine being hacked by the pAI cable.
	var/obj/machinery/hacking_machine

/obj/item/pai_cable/Destroy()
	hacking_machine = null
	return ..()

/obj/item/pai_cable/proc/plugin(obj/machinery/M, mob/living/user)
	if(!user.transferItemToLoc(src, M))
		return
	user.visible_message(span_notice("[user]将[src]插入了[M]上的数据端口。"), span_notice("你将[src]插入了[M]上的数据端口。"), span_hear("你听到线缆插头咔哒一声扣入到位的悦耳声响。"))
	hacking_machine = M
