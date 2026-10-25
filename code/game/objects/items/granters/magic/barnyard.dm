/obj/item/book/granter/action/spell/barnyard
	granted_action = /datum/action/cooldown/spell/pointed/barnyardcurse
	action_name = "畜栏诅咒"
	icon_state ="bookhorses"
	desc = "这本书的含马量超出了你大脑所能容纳的极限。"
	remarks = list(
		"哞——！",
		"哞！",
		"哞——哞！",
		"咴——咴——！",
		"咴咴——！",
		"咴——！",
		"啊昂——！",
		"啊——昂！",
		"哼！",
		"咿——！",
		"哼哼！",
		"咿！！",
		"咿咿！！",
		"咿——！！",
		"咿——咿——！！",
	)

/obj/item/book/granter/action/spell/barnyard/recoil(mob/living/user)
	if(ishuman(user))
		to_chat(user, "<font size='15' color='red'><b>小马觉醒了</b></font>")
		var/obj/item/clothing/magic_mask = new /obj/item/clothing/mask/animal/horsehead/cursed(user.drop_location())
		var/mob/living/carbon/human/human_user = user
		if(!user.dropItemToGround(human_user.wear_mask))
			qdel(human_user.wear_mask)
		user.equip_to_slot_if_possible(magic_mask, ITEM_SLOT_MASK, TRUE, TRUE)
		qdel(src)
	else
		to_chat(user,span_notice("我向你道一声咴！")) //It still lives here
