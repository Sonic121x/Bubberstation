/mob/living/brain/death(gibbed)
	if(stat == DEAD)
		return
	set_stat(DEAD)

	if(!gibbed && container)//If not gibbed but in a container.
		var/obj/item/brain_processor/mmi = container
		mmi.visible_message(span_warning("[src] 的人机接口失去信号了！"), \
					span_hear("你听到某个东西的生命信号中断了。"))
		mmi.update_appearance()

	return ..()

/mob/living/brain/gib()
	if(container)
		qdel(container)//Gets rid of the MMI if there is one
	if(loc)
		if(istype(loc, /obj/item/organ/brain))
			qdel(loc)//Gets rid of the brain item
	..()
