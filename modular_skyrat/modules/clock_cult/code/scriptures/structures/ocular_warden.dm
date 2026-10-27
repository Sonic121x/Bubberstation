#define OCULAR_WARDEN_PLACE_RANGE 3

/datum/scripture/create_structure/ocular_warden
	name = "眼目守卫"
	desc = "一座会向附近目标开火的眼球炮塔。"
	tip = "将它们布置在四周，以阻止船员冲过你的防线。"
	button_icon_state = "Ocular Warden"
	power_cost = 400
	invocation_time = 5 SECONDS
	invocation_text = list("Summon thee to defend our temple")
	summoned_structure = /obj/structure/destructible/clockwork/gear_base/powered/ocular_warden
	cogs_required = 3
	category = SPELLTYPE_STRUCTURES

/datum/scripture/create_structure/ocular_warden/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	if(locate(/obj/structure/destructible/clockwork/gear_base/powered/ocular_warden) in range(OCULAR_WARDEN_PLACE_RANGE))
		user.balloon_alert(user, "离另一名守卫太近了！")
		return FALSE

	return TRUE

#undef OCULAR_WARDEN_PLACE_RANGE
