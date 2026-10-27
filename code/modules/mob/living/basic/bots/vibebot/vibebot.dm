/mob/living/basic/bot/vibebot
	name = "\improper 氛围机器人"
	desc = "一台小巧的机器人。它只是跟着感觉走，干着自己的事。"
	icon = 'icons/mob/silicon/aibots.dmi'
	icon_state = "vibebot1"
	base_icon_state = "vibebot"
	pass_flags = PASSMOB | PASSFLAPS
	light_system = OVERLAY_LIGHT
	light_range = 6
	ai_controller = /datum/ai_controller/basic_controller/bot/vibebot
	light_power = 2
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3.3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 4)


	hackables = "氛围扫描器"
	radio_key = /obj/item/encryptionkey/headset_service
	radio_channel = RADIO_CHANNEL_SERVICE
	bot_type = VIBE_BOT
	data_hud_type = TRAIT_DIAGNOSTIC_HUD
	path_image_color = "#2cac12"
	possessed_message = "你是一台氛围机器人！尽你所能维持空间站的氛围！"

/mob/living/basic/bot/vibebot/Initialize(mapload)
	. = ..()
	var/static/list/innate_actions = list(
		/datum/action/cooldown/mob_cooldown/bot/vibe = BB_VIBEBOT_PARTY_ABILITY,
	)

	grant_actions_by_list(innate_actions)
	var/obj/item/instrument/piano_synth/piano = new(src)
	ai_controller.set_blackboard_key(BB_SONG_INSTRUMENT, piano)
	update_appearance(UPDATE_ICON)
