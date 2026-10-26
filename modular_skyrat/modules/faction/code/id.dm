/obj/item/card/id/faction_guest
	name = "访客卡"
	access = list(ACCESS_FACTION_PUBLIC)

/obj/item/card/id/faction_crew
	name = "船员卡"
	access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW)

/obj/item/card/id/faction_command
	name = "指挥卡"
	access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW, ACCESS_FACTION_COMMAND)
	icon_state = "card_silver"
	inhand_icon_state = "silver_id"

/obj/item/card/faction_access
	name = "派系权限卡"
	desc = "一张小卡片，用于任意 ID 卡时可添加派系权限。这张是空白的。"
	icon_state = "data_1"
	var/list/extra_access

/obj/item/card/faction_access/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/card/id/id = interacting_with
	if(!istype(id))
		return NONE
	if(extra_access)
		for(var/acs in extra_access)
			id.access |= acs
	to_chat(user, span_notice("你为 [id] 添加了额外权限。"))
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/item/card/faction_access/guest
	name = "派系访客权限卡"
	desc = "一张小卡片，用于任意 ID 卡时可添加访客权限，可进入大厅、生活区、厨房和酒吧。"
	extra_access = list(ACCESS_FACTION_PUBLIC)

/obj/item/card/faction_access/crew
	name = "派系船员权限卡"
	desc = "一张小卡片，用于任意 ID 卡时可添加船员权限，可进入大多数区域，指挥区除外。"
	extra_access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW)
	color = "#BA7"

/obj/item/card/faction_access/command
	name = "派系指挥权限卡"
	desc = "一张小卡片，用于任意 ID 卡时可添加所有派系权限。"
	extra_access = list(ACCESS_FACTION_PUBLIC, ACCESS_FACTION_CREW, ACCESS_FACTION_COMMAND)
	color = "#DDF"

/obj/item/storage/box/faction_access_cards
	name = "权限芯片盒"
	desc = "以备你想招募人员时使用。请妥善保管。"

/obj/item/storage/box/faction_access_cards/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/card/faction_access/guest(src)
	for(var/i in 1 to 3)
		new /obj/item/card/faction_access/crew(src)
	new /obj/item/card/faction_access/command(src)
	for(var/i in 1 to 4)
		new /obj/item/encryptionkey/headset_faction(src)
