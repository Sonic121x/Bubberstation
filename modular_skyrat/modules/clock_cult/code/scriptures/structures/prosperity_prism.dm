/datum/scripture/create_structure/prosperity_prism
	name = "繁荣棱镜"
	desc = "创造一座棱镜，会随时间治愈附近仆从受到的各种伤害，并清除毒素。需要传输符文提供能量。"
	tip = "创造繁荣棱镜，在守卫基地的同时治疗仆从。"
	button_icon_state = "Prolonging Prism"
	power_cost = 300
	invocation_time = 8 SECONDS
	invocation_text = list("Your light shall heal the wounds beneath my skin.")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism
	cogs_required = 2
	category = SPELLTYPE_STRUCTURES


/datum/scripture/create_structure/prosperity_prism/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(locate(/obj/structure/destructible/clockwork/gear_base/powered/prosperity_prism) in range(3)) // No stacking heals for you
		user.balloon_alert(user, "离另一座棱镜太近了！")
		return FALSE

	return TRUE
