///Temporary modifies the speech using the /datum/component/speechmod
/datum/status_effect/food/speech

/datum/status_effect/food/speech/italian
	alert_type = /atom/movable/screen/alert/status_effect/italian_speech
	on_remove_on_mob_delete = TRUE
	/// Ref to the component so we can clear it
	var/datum/component/speechmod

/datum/status_effect/food/speech/italian/on_apply()
	. = ..()
	speechmod = AddComponent( \
		/datum/component/speechmod, \
		replacements = strings("italian_replacement.json", "italian"), \
		end_string = list(
			" 意饺意饺，秘方拿来！",
			" 妈妈咪呀！",
			" 妈妈咪呀！这肉丸真辣！",
			" 啦啦啦啦啦，乘缆车上山去！"
			), \
		end_string_chance = 3 \
		)

/datum/status_effect/food/speech/italian/on_remove()
	. = ..()
	QDEL_NULL(speechmod)

/atom/movable/screen/alert/status_effect/italian_speech
	name = "扁意面的拥抱"
	desc = "你突然很想夸张地比手画脚。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "food_italian"

/datum/status_effect/food/speech/french
	alert_type = /atom/movable/screen/alert/status_effect/french_speech
	on_remove_on_mob_delete = TRUE
	/// Ref to the component so we can clear it
	var/datum/component/speechmod

/datum/status_effect/food/speech/french/on_apply()
	. = ..()
	speechmod = owner.AddComponent( \
		/datum/component/speechmod, \
		replacements = strings("french_replacement.json", "french"), \
		end_string = list(
			" 哼哼哼！",
			" 哼！",
			" 岂有此理！"
			), \
		end_string_chance = 3, \
		)

/datum/status_effect/food/speech/french/on_remove()
	. = ..()
	QDEL_NULL(speechmod)

/atom/movable/screen/alert/status_effect/french_speech
	name = "法式咖啡风情"
	desc = "突然间，一切都值得热烈辩论一番。"
	use_user_hud_icon = USER_HUD_STYLE_INHERIT
	overlay_state = "food_french"
