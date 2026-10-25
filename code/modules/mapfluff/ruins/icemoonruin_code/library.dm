/obj/machinery/door/puzzle/keycard/library
	name = "木门"
	desc = "一扇布满灰尘、满是划痕的门，上面挂着一把厚重的锁。"
	icon = 'icons/obj/doors/puzzledoor/wood.dmi'
	puzzle_id = "library"
	open_message = "门伴随着响亮的吱呀声打开了。"

/obj/machinery/door/puzzle/keycard/library/animation_length(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			return 1.2 SECONDS

/obj/machinery/door/puzzle/keycard/library/animation_segment_delay(animation)
	switch(animation)
		if(DOOR_OPENING_PASSABLE)
			return 1.0 SECONDS
		if(DOOR_OPENING_FINISHED)
			return 1.2 SECONDS

/obj/item/keycard/library
	name = "金钥匙"
	desc = "一把暗淡的金钥匙。"
	icon_state = "golden_key"
	puzzle_id = "library"

/obj/item/paper/crumpled/bloody/fluff/stations/lavaland/library/warning
	name = "古老便条"
	default_raw_text = "<b>此处安放着“知晓万物者”浩繁的藏书。愿那些为求力量而觊觎其知识者永受诅咒。</b>"

/obj/item/paper/crumpled/fluff/stations/lavaland/library/diary
	name = "日记第 13 篇"
	default_raw_text = "图书馆被掩埋已经一周了，从那以后我就再没见过那只猫头鹰。我饿得几乎连思考的力气都没有，更别说写字了。那些求知者似乎没受影响。"

/obj/item/paper/crumpled/fluff/stations/lavaland/library/diary2
	name = "日记第 18 篇"
	default_raw_text = "我已经记不清时间了。我连从书架上拿书的力气都没有。想想看，花了这么久寻找这座图书馆，我却要在窥见其知识深处之前就死去。"

/obj/item/feather
	name = "羽毛"
	desc = "一根深色、枯萎的羽毛。它看起来与时间本身一样古老。"
	icon = 'icons/obj/service/bureaucracy.dmi'
	icon_state = "feather"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
