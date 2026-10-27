/obj/item/instrument/violin/festival
	name = "科吉坦迪·菲迪斯"
	desc = "一把对从其琴弦上奏出的歌曲怀有特殊兴趣的小提琴。"
	icon_state = "holy_violin"
	inhand_icon_state = "holy_violin"

/obj/item/instrument/violin/festival/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_INSTRUMENT_START, PROC_REF(on_instrument_start))

/// signal fired when the festival instrument starts to play.
/obj/item/instrument/violin/festival/proc/on_instrument_start(datum/source, datum/song/starting_song, atom/player)
	SIGNAL_HANDLER

	if(!starting_song || !isliving(player))
		return
	analyze_song(starting_song, player)

///Reports some relevant information when the song begins playing.
/obj/item/instrument/violin/festival/proc/analyze_song(datum/song/song, mob/living/playing_song)
	var/list/analysis = list()
	//check tempo and lines
	var/song_length = song.lines.len * song.tempo
	analysis += span_revenbignotice("[src] 对你说话……")
	analysis += span_revennotice("“这首歌有 <b>[song.lines.len]</b> 句，节拍为 <b>[song.tempo]</b>。”")
	analysis += span_revennotice("“将这些相乘，得到歌曲长度为 <b>[song_length]</b>。”")
	analysis += span_revennotice("“若想获得 [GLOB.deity] 的终曲效果，你的歌曲结束时长度必须达到 <b>[FESTIVAL_SONG_LONG_ENOUGH]</b>。”")

	to_chat(playing_song, analysis.Join("\n"))
