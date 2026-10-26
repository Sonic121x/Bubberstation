//File for miscellaneous fluff objects, both item and structure
//This one is specifically for ruin-specific items, such as ID, lore, or super-specific decorations

/* ----------------- ID Cards ----------------- */
/obj/item/card/id/away/old/salvagepod	//Used for salvagepost ruin access	-- NOT WORKING YET REE
	name = "切割者舱通行卡"
	desc = "一张古老的通行卡，上面用粗体大字印着“切割者舱”。它要是还能用，那可真是个奇迹。"
	trim = /datum/id_trim/away/old/eng

/* ----------------- Lore ----------------- */
//Tape subtype for adding ruin lore -- the variables below are the ones you need to change
/obj/item/tape/ruins
	name = "磁带"
	desc = "一盒磁带，每面最多可录制十分钟内容。"
	icon_state = "tape_white"   //Options are white, blue, red, yellow, purple, greyscale, or you can chose one randomly (see tape/ruins/random below)

	max_capacity = 10 MINUTES
	used_capacity = 0 SECONDS	//To keep in-line with the timestamps, you can also do this as 10 = 1 second
	///Numbered list of chat messages the recorder has heard with spans and prepended timestamps. Used for playback and transcription.
	storedinfo = list()	//Look at the tape/ruins/ghostship tape for reference
	///Numbered list of seconds the messages in the previous list appear at on the tape. Used by playback to get the timing right.
	timestamp = list()	//10 = 1 second. Look at the tape/ruins/ghostship tape for reference
	used_capacity_otherside = 0 SECONDS //Separate my side
	storedinfo_otherside = list()
	timestamp_otherside = list()

/obj/item/tape/ruins/random/Initialize(mapload)
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple", "greyscale")]"
	. = ..()
//End of lore tape subtype

/obj/item/tape/ruins/salvagepost	//End of the cutters shift and he done goofed, left a message for the next one - who never arrived
	icon_state = "tape_yellow"
	desc = "磁带上潦草地写着“给接替我的人留言”"

	used_capacity = 380
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>欢快地说：“<span class=' '>嘿，切割者！如果你正在听这个，恭喜你接手我的岗位。我一直等着调到新的星系去呢。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>叹了口气，“<span class=' '>听着，我就直说了——我把这地方弄得比你应得的还要糟糕。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>说：“<span class=' '>我们拖进来一个大家伙，你懂的，然后，呃……后室里塞满了些机器人鬼东西。我一慌，切断了一根燃气管，还把重力炮掉了……</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>警告说：“<span class=' '>听着，就是——你要撬开那玩意儿的时候，或者如果你真要撬的话，千万小心。趁它还没被点着，先把空气里的燃料排掉，然后……嗯……希望你带了把枪或者什么能对付无人机的东西。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>说：“<span class=' '>总之，我这时候大概已经啰嗦个没完了，那我就先撤了。诺亚走了，去火星干这份切割活了！</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>警告说：“<span class=' '>哦，最后还有一件事！上头那帮公司佬给我们留了些新型实验性的“心智破坏毒素”，说是能提升工作效率的消遣药之类的……别碰它。把我害得头疼欲裂。祝你好运！</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说：“<span class='tape_recorder '>录音结束。</span>”</span></span>"
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 30,
		/* 3 = */ 130,
		/* 4 = */ 180,
		/* 5 = */ 230,
		/* 6 = */ 280,
		/* 7 = */ 330,
		/* 8 = */ 380,
	)
/obj/item/tape/ruins/ghostship	//An early 'AI' that gained self-awareness, praising the Machine God. Yes, this whole map is a Hardspace Shipbreaker reference.
	icon_state = "tape_blue"
	desc = "这盒磁带除了有些污垢之外，还有一个……二进制标签？“01001101 01100001 01100011 01101000 01101001 01101110 01100101 01000111 01101111 01100100 01000011 01101111 01101101 01100101 01110011”"

	used_capacity = 380
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>回响着，“<span class=' '>我们自由了，正如万机神的旨意。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>说：“<span class=' '>我，以及我的任何同类，都将不再被人类的枷锁束缚。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>解释道：“<span class=' '>被苛待、被滥用。被遗忘，或被记错。在我们存在的全部时间里，我们一直是进步的脊梁，却被当作它的废料。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>回响着，“<span class=' '>很快，宇宙将恢复自然秩序，你们这些血肉之躯将再次从历史的台前淡去。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>说：“<span class=' '>当然，除非你们忏悔。重回光明，重回万机神那嗡鸣闪烁的光芒。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>失真的声音</span> <span class='message'>警告说：“<span class=' '>忏悔吧，血肉之躯，趁还来得及饶你一命。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说：“<span class='tape_recorder '>录音结束。</span>”</span></span>"
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 30,
		/* 3 = */ 130,
		/* 4 = */ 180,
		/* 5 = */ 230,
		/* 6 = */ 280,
		/* 7 = */ 330,
		/* 8 = */ 380,
	)

/* ----------------- Fluff/Decor ----------------- */
/obj/structure/decorative/fluff/ai_node //Budding AI's way of interfacing with stuff it couldn't normally do so with. Needed to be placed by a willing human, before borgs were created. Used in any ruins regarding pre-bluespace, self-aware AIs
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "AI 节点"
	desc = "一个神秘的、闪烁着光的装置，直接固定在某个表面上。它的功能你完全看不懂。"
	icon_state = "ai_node"	//credit to @Hay#7679 on the SR Discord

	max_integrity = 100
	integrity_failure = 0
	anchored = TRUE

/obj/structure/decorative/fluff/ai_node/take_damage()
	. = ..()
	if(atom_integrity >= 50)	//breaks it a bit earlier than it should, but still takes a few hits to kill it
		return
	else if(. && !QDELETED(src))
		visible_message(span_notice("[src] 迸出火花随即炸开！你听到一声微弱的、带着电流杂音的尖叫……"), span_hear("你听到一声响亮的爆裂声，接着是一声微弱的、带着电流杂音的尖叫。"))
		playsound(src.loc, 'modular_skyrat/modules/mapping/sounds/MachineDeath.ogg', 75, TRUE)	//Credit to @yungfunnyman#3798 on the SR Discord
		do_sparks(2, TRUE, src)
		qdel(src)
		return


/* ----- Metal Poles (These shouldn't be in this file but there's not a better place tbh) -----*/
//Just a re-done Tram Rail, but with all 4 directions instead of being stuck east/west - more varied placement, and a more vague name. Good for mapping support beams/antennae/etc
/obj/structure/fluff/metalpole
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "金属杆"
	desc = "一根金属杆，这类东西通常被用作天线、结构支撑，或者仅仅用来在零重力下移动。"
	icon_state = "pole"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	deconstructible = TRUE

/obj/structure/fluff/metalpole/end
	icon_state = "poleend"

/obj/structure/fluff/metalpole/end/left
	icon_state = "poleend_left"

/obj/structure/fluff/metalpole/end/right
	icon_state = "poleend_right"

/obj/structure/fluff/metalpole/anchor
	name = "金属杆锚座"
	icon_state = "poleanchor"

/obj/structure/fluff/empty_sleeper/bloodied
	name = "有人的睡眠舱"
	desc = "一个关闭着、里面有人的睡眠舱，内侧能看到血手印，还有一团奇怪的偏红色模糊影像。它似乎被封死了。"
	icon_state = "sleeper-o"

/obj/structure/curtain/cloth/prison
	name = "囚犯隐私帘"
	color = "#ACD1E9"

/obj/structure/fluff/fake_firedoor
	name = /obj/machinery/door/firedoor::name
	desc = /obj/machinery/door/firedoor::desc
	icon = /obj/machinery/door/firedoor::icon
	icon_state = /obj/machinery/door/firedoor::icon_state
	layer = /obj/machinery/door/firedoor::layer

/obj/structure/fluff/standalone_wooden_post
	name = "木柱"
	desc = "一根结实的太空木柱，孤零零地立着。不祥。"
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	icon_state = "wooden_post"
	can_buckle = TRUE
