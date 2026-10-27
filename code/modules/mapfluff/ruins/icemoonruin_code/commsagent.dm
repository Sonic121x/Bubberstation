/obj/item/tape/frozen
	name = "冻结的磁带"
	desc = "一盘冻结的旧磁带。低温多少保住了里面的录音。"
	icon_state = "tape_white"
	used_capacity = 10 MINUTES
	storedinfo = list(
		"\[00:04\]三。",
		"\[00:05\]年。",
		"\[00:07\]在这该死的冰窟窿里整整他妈的三年",
		"\[00:11\]我的任务早该结束了！",
		"\[00:15\]纳米传讯丢下他们的设施任其腐烂，大概有，",
		"\[00:20\]8、9、10 个月了吧？我都记不清了",
		"\[00:25\]这本来应该是两个人的任务，",
		"\[00:29\]但另一名特工连一点要醒来的迹象都没有……",
		//long silence
		"\[02:00\]我再也撑不下去了，老兄。",
		"\[02:03\]我得离开这里，",
		"\[02:06\]也许用大猩猩手套，我就能……",
		"\[02:11\]唔。",
		//shorter silence
		"\[02:34\]我决定拼一把。",
		"\[02:37\]如果有人找到这盘磁带，",
		"\[02:40\]不管结果如何，",
		"\[02:43\]只要知道我不后悔。"
	)
	timestamp = list (
		4 SECONDS,
		5 SECONDS,
		7 SECONDS,
		11 SECONDS,
		15 SECONDS,
		20 SECONDS,
		25 SECONDS,
		29 SECONDS,
		2 MINUTES,
		2 MINUTES + 3 SECONDS,
		2 MINUTES + 6 SECONDS,
		2 MINUTES + 11 SECONDS,
		2 MINUTES + 34 SECONDS,
		2 MINUTES + 37 SECONDS,
		2 MINUTES + 40 SECONDS,
		2 MINUTES + 43 SECONDS
	)

/obj/item/tape/frozen/Initialize(mapload)
	. = ..()
	unspool() // the tape spawns damaged

/obj/item/tape/comms_wall
	icon_state = "tape_red"
	used_capacity = 10 MINUTES
	storedinfo = list(
		"\[00:01\]"
	)
