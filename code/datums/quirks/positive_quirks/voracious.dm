/datum/quirk/voracious
	name = "Voracious"
	desc = "没有什么能阻止你吃东西。你吃得更快，还能大吃垃圾食品！胖一点也很适合你。"
	icon = FA_ICON_DRUMSTICK_BITE
	value = 4
	mob_trait = TRAIT_VORACIOUS
	gain_text = span_notice("你感觉饿——死——了。")
	lose_text = span_danger("你不再饿得发慌了。")
	medical_record_text = "患者对美食美酒的喜爱超乎常人。"
	mail_goodies = list(/obj/effect/spawner/random/food_or_drink/dinner)
