/obj/item
	/// If this collar counts as a pet collar for kink purposes, such as with MKUltra
	var/kink_collar = FALSE

/obj/item/clothing/neck/petcollar
	kink_collar = TRUE

/datum/storage/pockets/small/collar
	max_slots = 1

/datum/storage/pockets/small/collar/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie))

/datum/storage/pockets/small/collar/locked/New()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/key/collar))

/obj/item/clothing/neck/human_petcollar
	name = "宠物项圈"
	desc = "这是给宠物用的。你大概也能自己戴上，但无疑会沦为笑柄。"
	icon = 'icons/map_icons/clothing/neck.dmi'
	icon_state = "/obj/item/clothing/neck/human_petcollar"
	post_init_icon_state = "pet"
	greyscale_config = /datum/greyscale_config/collar/pet
	greyscale_config_worn = /datum/greyscale_config/collar/pet/worn
	greyscale_colors = "#44BBEE#FFCC00"
	flags_1 = IS_PLAYER_COLORABLE_1
	alternate_worn_layer = UNDER_SUIT_LAYER
	kink_collar = TRUE
	/// What's the name on the tag, if any?
	var/tagname = null
	/// What treat item spawns inside the collar?
	var/treat_path = /obj/item/food/cookie

/obj/item/clothing/neck/human_petcollar/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/small/collar)
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/human_petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "你想更改铭牌上的名字吗？", "给你的新宠物取名", "小斑点", MAX_NAME_LEN)
	if(tagname)
		name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/human_petcollar/leather
	name = "皮革宠物项圈"
	icon_state = "/obj/item/clothing/neck/human_petcollar/leather"
	post_init_icon_state = "leather"
	greyscale_config = /datum/greyscale_config/collar/leather
	greyscale_config_worn = /datum/greyscale_config/collar/leather/worn
	greyscale_colors = "#222222#888888#888888"

/obj/item/clothing/neck/human_petcollar/choker
	name = "颈圈"
	desc = "相当时髦……前提是你刚读完人生中第一部 BDSM 题材的情色小说。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/choker"
	post_init_icon_state = "choker"
	greyscale_config = /datum/greyscale_config/collar/choker
	greyscale_config_worn = /datum/greyscale_config/collar/choker/worn
	greyscale_colors = "#222222"

/obj/item/clothing/neck/human_petcollar/thinchoker
	name = "细颈圈"
	desc = "和普通的那个一样，只是更细！"
	icon_state = "/obj/item/clothing/neck/human_petcollar/thinchoker"
	post_init_icon_state = "thinchoker"
	greyscale_config = /datum/greyscale_config/collar/thinchoker
	greyscale_config_worn = /datum/greyscale_config/collar/thinchoker/worn
	greyscale_colors = "#222222"

/obj/item/key/collar
	name = "项圈钥匙"
	desc = "用来打开项圈或包上小锁的钥匙。"

/obj/item/clothing/neck/human_petcollar/locked
	name = "上锁项圈"
	desc = "一个带小锁、防止被取下的项圈。"
	treat_path = /obj/item/key/collar
	/// Is the collar currently locked?
	var/locked = FALSE

/obj/item/clothing/neck/human_petcollar/locked/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ITEM_INTERACTION, PROC_REF(try_lock))
	create_storage(storage_type = /datum/storage/pockets/small/collar/locked)

/obj/item/clothing/neck/human_petcollar/locked/proc/try_lock(atom/source, mob/user, obj/item/attacking_item, params)
	if(istype(attacking_item, /obj/item/key/collar))
		to_chat(user, span_warning("咔哒一声，项圈[locked ? "解锁" : "上锁"]了！"))
		locked = !locked
	return TRUE

/obj/item/clothing/neck/human_petcollar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && locked)
		to_chat(user, span_warning("项圈锁上了！你需要先解锁项圈才能把它取下来！"))
		return
	..()

/obj/item/clothing/neck/human_petcollar/locked/examine(mob/user)
	. = ..()
	. += "它似乎是[locked ? "锁着的" : "未上锁"]。"

/obj/item/clothing/neck/human_petcollar/locked/bell
	name = "铃铛项圈"
	desc = "一个又吵又烦人的项圈，给你家小猫咪戴！"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/bell"
	post_init_icon_state = "bell"
	greyscale_config = /datum/greyscale_config/collar/bell
	greyscale_config_worn = /datum/greyscale_config/collar/bell/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/choker
	name = "颈圈"
	desc = "相当时髦……前提是你刚读完人生中第一部 BDSM 题材的情色小说。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/choker"
	post_init_icon_state = "choker"
	greyscale_config = /datum/greyscale_config/collar/choker
	greyscale_config_worn = /datum/greyscale_config/collar/choker/worn
	greyscale_colors = "#222222"

/obj/item/clothing/neck/human_petcollar/locked/cow
	name = "牛铃项圈"
	desc = "别怕死神，现在你的宠物也不用怕了。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/cow"
	post_init_icon_state = "cow"
	greyscale_config = /datum/greyscale_config/collar/cow
	greyscale_config_worn = /datum/greyscale_config/collar/cow/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/cross
	name = "十字架项圈"
	desc = "大概是一种宗教惩罚。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/cross"
	post_init_icon_state = "cross"
	greyscale_config = /datum/greyscale_config/collar/cross
	greyscale_config_worn = /datum/greyscale_config/collar/cross/worn
	greyscale_colors = "#663300#FFCC00"

/obj/item/clothing/neck/human_petcollar/locked/holo
	name = "全息项圈"
	desc = "带有全息信息的项圈。就像微芯片，只不过戴在脖子上。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/holo"
	post_init_icon_state = "holo"
	greyscale_config = /datum/greyscale_config/collar/holo
	greyscale_config_worn = /datum/greyscale_config/collar/holo/worn
	greyscale_colors = "#292929#3399FF"

/obj/item/clothing/neck/human_petcollar/locked/leather
	name = "皮革宠物项圈"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/leather"
	post_init_icon_state = "leather"
	greyscale_config = /datum/greyscale_config/collar/leather
	greyscale_config_worn = /datum/greyscale_config/collar/leather/worn
	greyscale_colors = "#222222#888888#888888"

/obj/item/clothing/neck/human_petcollar/locked/spike
	name = "尖刺项圈"
	desc = "给脾气暴躁的宠物戴的项圈。或者给比特犬。"
	icon_state = "/obj/item/clothing/neck/human_petcollar/locked/spike"
	post_init_icon_state = "spike"
	greyscale_config = /datum/greyscale_config/collar/spike
	greyscale_config_worn = /datum/greyscale_config/collar/spike/worn
	greyscale_colors = "#292929#C0C0C0"
