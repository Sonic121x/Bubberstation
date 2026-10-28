// Tapes containing music.
/obj/item/music_tape
	name = "音乐磁带"
	desc = "一盘录有音乐的特殊磁带。"
	icon_state = "tape_white"
	icon = 'icons/obj/devices/circuitry_n_data.dmi'
	inhand_icon_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 0.2, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.2)
	force = 1
	throwforce = 0
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/tape_drop.ogg'
	pickup_sound = 'sound/items/handling/tape_pickup.ogg'
	var/datum/looping_sound/song_inside = /datum/looping_sound/boombox
	/// Song name to append to the examine text.
	var/song_name = "工业碾压"

/obj/item/music_tape/examine(mob/user)
	. = ..()
	. += span_notice("你应该可以用纳米传讯品牌[span_smallnoticeital("™")]的\
		纳米音乐[span_smallnoticeital("™")]手提音响播放它，至少在他们连手提音响这个概念也注册成商标之前可以。")
	if(song_name && song_inside)
		. += span_notice("曲目标为《[span_boldnotice(song_name)]》。")

/obj/item/music_tape/Initialize(mapload)
	. = ..()
	if(!song_inside)
		CRASH("We spawned a tape deck without any looping audio inside.")
	song_inside = new song_inside(src)

/obj/item/music_tape/rock
	icon_state = "tape_red"
	song_inside = /datum/looping_sound/boombox/rock
	song_name = "贝恩麦克"

/obj/item/music_tape/hiphop
	icon_state = "tape_purple"
	song_inside = /datum/looping_sound/boombox/hiphop
	song_name = "律动板"

/obj/item/music_tape/jazz
	desc = "一盘录有音乐的特殊磁带。等等，这里面是爵士乐？现在可不常见了……"
	icon_state = "tape_yellow"
	song_inside = /datum/looping_sound/boombox/jazz
	song_name = "弗兰基要炸场了"

/obj/item/music_tape/jazz/Initialize(mapload)
	. = ..()
	add_deep_lore()

/obj/item/music_tape/jazz/proc/add_deep_lore()
	AddElement(/datum/element/examine_lore, \
		lore = "从任何定义来说，爵士乐在顺旋星区都是完全合法的。毕竟，声音\
			通常不是大企业能够有效管制的东西。\
			但自由爵士乐却在 2590 年代末声名狼藉，起因是\
			自由爵士乐手兼犯罪策划大师[span_bold("雷兹·“妙手”·克索尼")]留下的那场传奇犯罪狂潮。\
			为了防止人人都记得的阿尔法罗兹事件重演，\
			地球政府与一个多国行星联盟将自由爵士乐认定为对公共安全的现实威胁。\
			爵士越自由，罪行就越严重。"\
	)

/obj/item/music_tape/pop
	icon_state = "tape_blue"
	song_inside = /datum/looping_sound/boombox/pop
	song_name = "泡泡糖"

/obj/item/music_tape/robocop
	song_inside = /datum/looping_sound/boombox/robocop
	song_name = "纳米传讯公司认证氛围音乐"
	custom_premium_price = PAYCHECK_COMMAND * 2.5

// This exists mostly for testing
/obj/item/storage/box/music_tapes
	name = "音乐磁带盒"
	desc = "装有数首公司认证的专有歌曲，供你用自己的音响播放并举过头顶摇摆。"
	illustration = "music"

/obj/item/storage/box/music_tapes/PopulateContents()
	var/list/items_inside = list(
		/obj/item/music_tape = 1,
		/obj/item/music_tape/rock = 1,
		/obj/item/music_tape/hiphop = 1,
		/obj/item/music_tape/pop = 1,
		/obj/item/music_tape/robocop = 1,
	)
	generate_items_inside(items_inside, src)
