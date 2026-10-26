/datum/action/cooldown/spell/pointed/terrorize
	name = "恐吓"
	desc = "将自己的意识投射进受害者的脑海，使其恐惧不断累积。\
		猎物会越来越惊恐。用空手拍打惊恐的猎物，会让它\
		受到惊吓并陷入慌乱。"
	button_icon_state = "terrify"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	antimagic_flags = MAGIC_RESISTANCE_MIND
	spell_requirements = NONE
	cooldown_time = 25 SECONDS
	cast_range = 9
	active_msg = "你准备盯紧一个目标……"
	deactive_msg = "你重新聚焦目光……"

/datum/action/cooldown/spell/pointed/terrorize/is_valid_target(atom/cast_on)
	. = ..()
	if(!ishuman(cast_on))
		cast_on.balloon_alert(owner, "无法被恐吓！")
		return FALSE

	var/lit_tiles = 0
	var/unlit_tiles = 0

	for(var/turf/open/turf_to_check in range(1, cast_on)) //We have to use range for this because fully darkened tiles get blocked by view()'s visibility checks
		if(turf_to_check.check_lumcount_above(0.2))
			lit_tiles++
		else
			unlit_tiles++

	if(lit_tiles > unlit_tiles)
		cast_on.balloon_alert(owner, "必须在黑暗中！")
		return FALSE //Having a light on you will usually block this, meaning you'll probably need to get an initial hit on the victim with the light eater

/datum/action/cooldown/spell/pointed/terrorize/cast(mob/living/carbon/human/cast_on)
	. = ..()
	cast_on.apply_status_effect(/datum/status_effect/terrified) //Effect stacks, adding bonus terror to the victim if cast again
