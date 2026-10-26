/datum/action/cooldown/spell/basic_projectile/juggernaut
	name = "拳套回响"
	desc = "将能量导入你的拳套——把它的精华向前发射出去，化为缓慢却毁灭性的一击。"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "cultfist"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"

	sound = 'sound/items/weapons/resonator_blast.ogg'

	cooldown_time = 35 SECONDS
	spell_requirements = NONE

	projectile_type = /obj/projectile/magic/aoe/juggernaut

/datum/action/cooldown/spell/basic_projectile/juggernaut/fire_projectile(atom/target, mob/caster)
	var/obj/projectile/magic/aoe/juggernaut/to_fire = ..()
	SET_FACTION_AND_ALLIES_FROM(to_fire, caster)
	return to_fire
