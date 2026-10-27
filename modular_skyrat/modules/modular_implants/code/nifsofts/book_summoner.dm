/obj/item/disk/nifsoft_uploader/summoner/book
	name = "阿卡夏魔典"
	loaded_nifsoft = /datum/nifsoft/summoner/book

/datum/nifsoft/summoner/book
	name = "阿卡夏魔典"
	program_desc = "阿卡夏魔典是蔚蓝魔典 NIFSoft 的一个分支版本，其设计目的是让使用者获取各种教学用硬光书籍。\
	由于它的教育性质与极小的体积，阿卡夏魔典通常在大多数 NIFSoft 市场上免费提供。"
	summonable_items = list()
	purchase_price = 0 // This is a tool intended to help out newer players.
	max_summoned_items = 2
	buying_category = NIFSOFT_CATEGORY_INFORMATION
	ui_icon = "book"

/datum/nifsoft/summoner/book/New()
	. = ..()
	summonable_items += subtypesof(/obj/item/book/manual/wiki) //That's right! all of the manual books!

/datum/nifsoft/summoner/book/apply_custom_properties(obj/item/book/generated_book)
	if(!istype(generated_book))
		return FALSE

	generated_book.cannot_carve = TRUE
	return TRUE

// Need this code here so that we don't have people carving out the summoned books
/obj/item/book
	/// Is the parent book unable to be carved? TRUE prevents carving. By default this is unset
	var/cannot_carve

/obj/item/book/carving_act(mob/living/user, obj/item/tool)
	if(cannot_carve)
		balloon_alert(user, "无法雕刻！")
		return ITEM_INTERACT_BLOCKING

	return ..()
