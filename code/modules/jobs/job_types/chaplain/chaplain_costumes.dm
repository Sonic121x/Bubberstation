//Chaplain Suit Subtypes
//If any new staple chaplain items get added, put them in these lists
/obj/item/clothing/suit/chaplainsuit
	allowed = null
	icon = 'icons/obj/clothing/suits/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/suits/chaplain.dmi'

/obj/item/clothing/suit/chaplainsuit/Initialize(mapload)
	. = ..()
	allowed = GLOB.chaplain_suit_allowed

/obj/item/clothing/suit/chaplainsuit/armor
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/chaplainsuit_armor
	strip_delay = 8 SECONDS
	equip_delay_other = 6 SECONDS

/datum/armor/chaplainsuit_armor
	melee = 50
	bullet = 10
	laser = 10
	energy = 10
	fire = 80
	acid = 80
	wound = 20

/obj/item/clothing/suit/hooded/chaplainsuit
	allowed = null

/obj/item/clothing/suit/hooded/chaplainsuit/Initialize(mapload)
	. = ..()
	allowed = GLOB.chaplain_suit_allowed

//Suits
/obj/item/clothing/suit/chaplainsuit/holidaypriest
	name = "节日牧师"
	desc = "这是一个美好的节日，我的孩子。"
	icon_state = "holidaypriest"
	inhand_icon_state = "w_suit"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/chaplainsuit/nun
	name = "修女长袍"
	desc = "本星系虔诚之最。"
	icon_state = "nun"
	inhand_icon_state = "nun"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/chaplainsuit/habit
	name = "修行袍"
	desc = "毫无胡闹成分的修女装。"
	icon_state = "habit"
	inhand_icon_state = "habit"
	alternate_worn_layer = GLOVES_LAYER // since the sleeves cover a part of the hands, this way it looks better while retaining glove overlay correctly.
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/chaplainsuit/bishoprobe
	name = "主教长袍"
	desc = "很高兴看到你收的什一税没有白花。"
	icon_state = "bishoprobe"
	inhand_icon_state = "bishoprobe"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/chaplainsuit/armor/studentuni
	name = "学生长袍"
	desc = "一所已消亡学府的制服。"
	icon_state = "studentuni"
	inhand_icon_state = null
	body_parts_covered = ARMS|CHEST

/obj/item/clothing/suit/chaplainsuit/armor/witchhunter
	name = "猎巫人装束"
	desc = "这套破旧的行头当年可是大派用场。"
	icon_state = "witchhunter"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/hooded/chaplainsuit/monkhabit
	name = "修士袍"
	desc = "比撕烂的粗麻布强上那么一点。"
	icon_state = "monkfrock"
	icon = 'icons/obj/clothing/suits/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/suits/chaplain.dmi'
	inhand_icon_state = "monkfrock"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/monkhabit

/obj/item/clothing/head/hooded/monkhabit
	name = "修士兜帽"
	desc = "专为想遮住自己剃发的人准备。"
	icon = 'icons/obj/clothing/head/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/head/chaplain.dmi'
	icon_state = "monkhood"
	inhand_icon_state = null
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/chaplainsuit/monkrobeeast
	name = "东方修士长袍"
	desc = "最好搭配光头一起穿。"
	icon_state = "monkrobeeast"
	inhand_icon_state = null
	body_parts_covered = GROIN|LEGS
	flags_inv = HIDEJUMPSUIT|HIDEBELT
	clothing_flags = parent_type::clothing_flags | CARP_STYLE_FACTOR

/obj/item/clothing/suit/chaplainsuit/whiterobe
	name = "白色长袍"
	desc = "神职人员和犯困的船员都很适合。"
	icon_state = "whiterobe"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEBELT

/obj/item/clothing/suit/chaplainsuit/clownpriest
	name = "洪克之母长袍"
	desc = "专为穿袍子的小丑准备。"
	icon_state = "clownpriest"
	inhand_icon_state = "clownpriest"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEBELT
	allowed = list(/obj/item/megaphone/clown, /obj/item/soap, /obj/item/food/pie/cream, /obj/item/bikehorn, /obj/item/bikehorn/golden, /obj/item/bikehorn/airhorn, /obj/item/instrument/bikehorn, /obj/item/reagent_containers/cup/soda_cans/canned_laughter, /obj/item/toy/crayon, /obj/item/toy/crayon/spraycan, /obj/item/toy/crayon/spraycan/lubecan, /obj/item/grown/bananapeel, /obj/item/food/grown/banana)

/obj/item/clothing/head/helmet/chaplain/clock
	name = "被遗忘的头盔"
	desc = "它带着一位被永远遗忘的神祇那不屈的目光。"
	icon_state = "clockwork_helmet"
	inhand_icon_state = null
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	dog_fashion = null

/obj/item/clothing/suit/chaplainsuit/armor/clock
	name = "被遗忘的护甲"
	desc = "听来像蒸汽嘶鸣、齿轮咔哒，如今都已沉寂；看来像一台死去的机器，仍试图带着生命滴答转动。"
	icon_state = "clockwork_cuirass"
	inhand_icon_state = null
	slowdown = 0

/obj/item/clothing/suit/chaplainsuit/armor/clock/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, /datum/bodypart_texture/mesh/drake)

/obj/item/clothing/head/helmet/chaplain
	name = "十字军头盔"
	desc = "神的旨意。"
	icon = 'icons/obj/clothing/head/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/head/chaplain.dmi'
	icon_state = "knight_templar"
	inhand_icon_state = null
	armor_type = /datum/armor/chaplainsuit_armor
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 8 SECONDS
	dog_fashion = null

/obj/item/clothing/suit/chaplainsuit/armor/templar
	name = "十字军护甲"
	desc = "上帝的旨意！"
	icon_state = "knight_templar"
	inhand_icon_state = null
	slowdown = 0

/obj/item/clothing/suit/chaplainsuit/armor/templar/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, /datum/bodypart_texture/mesh/biosuit_dark)

/obj/item/clothing/head/helmet/chaplain/cage
	name = "铁笼"
	desc = "一只束缚自我意志的笼子，让人得以看清这世俗世界的真面目。"
	flags_inv = NONE
	icon_state = "cage"
	inhand_icon_state = null
	worn_y_offset = 7

/obj/item/clothing/head/helmet/chaplain/ancient
	name = "远古头盔"
	desc = "无人可过！"
	icon_state = "knight_ancient"
	inhand_icon_state = null

/obj/item/clothing/head/helmet/chaplain/ancient/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_HEAD, /datum/bodypart_texture/mesh/biosuit_dark)

/obj/item/clothing/suit/chaplainsuit/armor/ancient
	name = "远古护甲"
	desc = "守护宝藏……"
	icon_state = "knight_ancient"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/chaplainsuit/armor/ancient/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, /datum/bodypart_texture/mesh/biosuit_dark)

/obj/item/clothing/head/helmet/chaplain/witchunter_hat
	name = "猎巫人帽子"
	desc = "这顶帽子当年也是大派用场。"
	icon_state = "witchhunterhat"
	inhand_icon_state = null
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEYES

/obj/item/clothing/head/helmet/chaplain/adept
	name = "秘修兜帽"
	desc = "只有别人这么做才算异端。"
	icon_state = "crusader"
	inhand_icon_state = null
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/chaplainsuit/armor/adept
	name = "秘修长袍"
	desc = "焚烧不忠者时的理想装扮。"
	icon_state = "crusader"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/chaplainsuit/armor/crusader
	name = "十字军铠甲"
	desc = "由金属与布料制成的护甲。"
	icon_state = "crusader"
	w_class = WEIGHT_CLASS_BULKY
	slowdown = 2.0 //gotta pretend we're balanced.
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor_type = /datum/armor/armor_crusader

/obj/item/clothing/suit/chaplainsuit/armor/crusader/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, SFX_PLATE_ARMOR_RUSTLE, 8)


/datum/armor/armor_crusader
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 60
	fire = 60
	acid = 60

/obj/item/clothing/suit/chaplainsuit/armor/crusader/red
	icon_state = "crusader-red"

/obj/item/clothing/suit/chaplainsuit/armor/crusader/blue
	icon_state = "crusader-blue"

/obj/item/clothing/head/helmet/chaplain/heretic
	name = "神秘学家兜帽"
	desc = "把你的面容从那些回望你的东西眼中隐藏起来。"
	icon_state = "heretichood"
	inhand_icon_state = null
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/head/helmet/chaplain/heretic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_HEAD, /datum/bodypart_texture/mesh/heretic)

/obj/item/clothing/suit/chaplainsuit/armor/heretic
	name = "神秘学家长袍"
	desc = "保护你的身体免受他人未曾察觉之物的侵扰。"
	icon_state = "hereticrobe"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/chaplainsuit/armor/heretic/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/equipment_bodypart_texture, BODY_ZONE_CHEST, /datum/bodypart_texture/mesh/heretic)

/obj/item/clothing/suit/hooded/chaplain_hoodie
	name = "信徒连帽衫"
	desc = "为牧师侍僧制作的连帽衫。"
	icon_state = "chaplain_hoodie"
	icon = 'icons/obj/clothing/suits/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/suits/chaplain.dmi'
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = null
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood

/obj/item/clothing/suit/hooded/chaplain_hoodie/Initialize(mapload)
	. = ..()
	allowed = GLOB.chaplain_suit_allowed

/obj/item/clothing/head/hooded/chaplain_hood
	name = "信徒兜帽"
	desc = "为牧师侍僧制作的兜帽。"
	icon = 'icons/obj/clothing/head/chaplain.dmi'
	worn_icon = 'icons/mob/clothing/head/chaplain.dmi'
	icon_state = "chaplain_hood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/hooded/chaplain_hoodie/leader
	name = "领袖连帽衫"
	desc = "现在你准备好享用 50 美元一瓶的闪亮圣水了。"
	icon_state = "chaplain_hoodie_leader"
	inhand_icon_state = null
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood/leader

/obj/item/clothing/head/hooded/chaplain_hood/leader
	name = "领袖兜帽"
	desc = "我是说，你并不是/非得/去找闪亮圣水。我只是觉得你该去。"
	icon_state = "chaplain_hood_leader"

/obj/item/clothing/suit/chaplainsuit/shrinehand
	name = "神祠侍者长袍"
	desc = "它帮不了你和亡灵沟通，但看起来绝对像那么回事。"
	icon_state = "shrinehand"
	inhand_icon_state = "shrinehand"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDEBELT
