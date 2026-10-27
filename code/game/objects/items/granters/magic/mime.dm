/obj/item/book/granter/action/spell/mime
	name = "默剧指南第零卷"
	desc = "传奇系列遗失的一卷。可惜它什么也教不了你。"
	icon_state ="bookmime"
	remarks = list("...")
	book_sounds = list('sound/effects/space_wind.ogg')

/obj/item/book/granter/action/spell/mime/attack_self(mob/user)
	. = ..()
	if(!.)
		return

	// Gives the user a vow ability if they don't have one
	var/datum/action/cooldown/spell/vow_of_silence/vow = locate() in user.actions
	if(!vow && user.mind)
		vow = new(user.mind)
		vow.Grant(user)

/obj/item/book/granter/action/spell/mime/mimery_blockade
	granted_action = /datum/action/cooldown/spell/forcewall/mime
	action_name = "隐形屏障"
	name = "高阶默剧指南第一卷"
	desc = "翻动书页时不会发出任何声音。"

/obj/item/book/granter/action/spell/mime/mimery_guns
	granted_action = /datum/action/cooldown/spell/pointed/projectile/finger_guns
	action_name = "手指枪"
	name = "高阶默剧指南第二卷"
	desc = "里面一个字也没有……"
