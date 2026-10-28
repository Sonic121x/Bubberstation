/// The abstract type for all the different effects that can be given
/// via magical lights
/datum/status_effect/magical_light
	id = "magical_light"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_UNIQUE
	show_duration = TRUE
	alert_type = /atom/movable/screen/alert/status_effect/magical_light
	/// A description shown when the magical light is examined by someone
	/// knowledgeable (Chaplains, Wizards)
	///
	/// "It's charged with magic that has [special_description]"
	var/special_description = "没有特殊效果"

/datum/status_effect/magical_light/on_creation(mob/living/new_owner, potency, ...)
	. = ..()

/atom/movable/screen/alert/status_effect/magical_light
	name = "魔法光环"
	desc = "你感觉自己被魔法光环笼罩着。"
	icon = 'modular_zubbers/icons/hud/screen_alert.dmi'
	icon_state = "magic_aura"

/atom/movable/screen/alert/status_effect/magical_light/good
	name = "魔法赐福" // Take away my thesaurus, I dare you
	desc = "一道善意的魔法光环正环绕着你。"
	icon_state = "magic_boon"

/atom/movable/screen/alert/status_effect/magical_light/bad
	name = "魔法灾厄"
	desc = "一道恶意的魔法光环正环绕着你。"
	icon_state = "magic_malady"
