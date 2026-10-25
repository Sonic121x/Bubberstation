/obj/item/grenade/empgrenade //SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "经典电磁脉冲手榴弹"
	desc = "专门用于破坏电子系统。"
	icon_state = "emp"
	inhand_icon_state = "emp"

/obj/item/grenade/empgrenade/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return
	update_mob()
	empulse(src, 4, 10, emp_source = src)
	qdel(src)
