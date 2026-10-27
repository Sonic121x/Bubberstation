/datum/config_entry/string/pc_mob_text
	config_entry_value = "作为被玩家控制的生物，你应当尽可能扮演好自己的角色。 \
	也就是说，如果你是动物，就要像动物那样行动，不应表现出多少智力，如果有的话。 \
	这也意味着，参与战斗时你应当克制，不要把人彻底围杀。 \
	你的目标不是取胜，而是制造挑战。 \
	你是来替代 AI 的，也要让别人同样享受当下的局面。 \
	如果你的简单生物智力不高或是完全沉默，那么利用焊接罐、气罐、箱子之类的结构物来妨碍对手是绝对禁止的。 \
	不要这么做。"

/mob/living
	/// If set to TRUE, ghosts will be able to click on the simple mob and take control of it.
	var/ghost_controllable = FALSE

/mob/living/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(.)
		return
	if(ghost_controllable)
		take_control(user)

/mob/living/proc/take_control(mob/user)
	if(key || stat)
		return
	if(is_banned_from(user.ckey, BAN_MOB_CONTROL))
		to_chat(user, "错误：你已被禁止接管玩家控制的生物！")
		return
	var/query = tgui_alert(user, "接管 [src]？", "接管生物", list("是", "否"))
	if(!query || query == "否" || !src || QDELETED(src))
		return
	if(key)
		to_chat(user, span_warning("已经有别人接管了这只生物！"))
		return
	key = user.key
	var/string_to_send = CONFIG_GET(string/pc_mob_text)
	if(string_to_send)
		to_chat(src, string_to_send)
	log_game("[key_name(src)] 接管了 [name]。")
