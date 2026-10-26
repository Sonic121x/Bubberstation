/// Synthesizer port names remain stable blueprint keys.
/proc/chinese_batch_six_instrument_port_display(value)
	var/static/list/names
	if(!names)
		names = list("Song" = "歌曲", "Play" = "播放", "Stop" = "停止", "Repetitions" = "重复次数", "Selected Instrument" = "选定乐器", "Volume" = "音量", "Volume Dropoff Threshold" = "音量衰减阈值", "Note Shift" = "音高偏移", "Note Sustain Mode" = "音符延音模式", "Note Sustain Value" = "音符延音数值", "Held Note Decay" = "按住音符衰减", "Currently Playing" = "当前正在播放", "Started Playing" = "开始播放", "Stopped Playing" = "停止播放")
	return names[value] || value
