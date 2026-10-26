// toggleable chameleon skin
/datum/mutation/chameleon
	power_path = /datum/action/cooldown/spell/chameleon_skin_activate

/datum/action/cooldown/spell/chameleon_skin_activate
	name = "激活变色龙皮肤"
	desc = "只要你保持静止，皮肤中的色素细胞就会随周围环境进行调整。"
	spell_requirements = NONE
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "ninja_cloak"

/datum/action/cooldown/spell/chameleon_skin_activate/cast(list/targets, mob/user = usr)
	. = ..()

	if(HAS_TRAIT(user,TRAIT_CHAMELEON_SKIN))
		chameleon_skin_deactivate(user)
		return

	ADD_TRAIT(user, TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION)
	to_chat(user, "你的皮肤色素开始流动，逐渐呈现出周围环境的颜色。")

/datum/action/cooldown/spell/chameleon_skin_activate/proc/chameleon_skin_deactivate(mob/user = usr)
	if(!HAS_TRAIT_FROM(user,TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION))
		return

	REMOVE_TRAIT(user, TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION)
	user.alpha = 255
	to_chat(user, text("你的皮肤一阵颤动，重新闪回原本的颜色。"))
