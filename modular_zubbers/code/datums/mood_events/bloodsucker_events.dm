/datum/mood_event/drankblood
	description = "<span class='nicegreen'>我贪婪地饱饮了滋养我的鲜血。</span>\n"
	mood_change = 10
	timeout = 8 MINUTES

/datum/mood_event/drankblood_bad
	description = "<span class='boldwarning'>我喝了低等生物的血。真恶心。</span>\n"
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/drankblood_dead
	description = "<span class='boldwarning'>我喝了死血。我本不该如此堕落。</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankblood_synth
	description = "<span class='boldwarning'>我喝了合成血。我到底怎么了？</span>\n"
	mood_change = -7
	timeout = 8 MINUTES

/datum/mood_event/drankkilled
	description = "<span class='boldwarning'>我吸食了死人的血。我感觉……自己更不像人了。</span>\n"
	mood_change = -15
	timeout = 10 MINUTES

/datum/mood_event/madevamp
	description = "<span class='boldwarning'>一个凡人在我的手中升华为不死之身。</span>\n"
	mood_change = 15
	timeout = 20 MINUTES

/datum/mood_event/coffinsleep
	description = "<span class='nicegreen'>我白天睡在棺材里。我又恢复了完整的状态。</span>\n"
	mood_change = 10
	timeout = 6 MINUTES

/datum/mood_event/coffinsleep/quirk
	mood_change = 4

/datum/mood_event/daylight_bad_sleep
	description = "<span class='boldwarning'>我白天睡在简陋的棺材里，没能睡好。</span>\n"
	mood_change = -3
	timeout = 6 MINUTES

/datum/mood_event/daylight_sun_scorched
	description = "<span class='boldwarning'>我遭到了无情阳光的灼烧。</span>\n"
	mood_change = -6
	timeout = 6 MINUTES

///Candelabrum's mood event to non Bloodsucker/Ghouls
/datum/mood_event/vampcandle
	description = "<span class='boldwarning'>有什么东西让你的心智变得……松散。</span>\n"
	mood_change = -15
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined
	mood_change = -10
	timeout = 5 MINUTES

/datum/mood_event/nosferatu_examined/add_effects(target, level = 0)
	description = span_danger("看见[target]令你感到深深的厌恶。")
	mood_change = level * -5
