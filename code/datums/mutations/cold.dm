/datum/mutation/geladikinesis
	name = "凝雪术"
	desc = "受试者能够随意将空气中的水分凝结成雪。"
	quality = POSITIVE
	text_gain_indication = span_notice("你的手感觉冰凉。")
	instability = POSITIVE_INSTABILITY_MINOR
	difficulty = 10
	synchronizer_coeff = 1
	power_path = /datum/action/cooldown/spell/conjure_item/snow

/datum/action/cooldown/spell/conjure_item/snow
	name = "制造积雪"
	desc = "集中控冰之力制造积雪，可用于建造雪制物品。"
	button_icon_state = "snow"

	cooldown_time = 5 SECONDS
	spell_requirements = NONE

	item_type = /obj/item/stack/sheet/mineral/snow
	delete_old = FALSE
	delete_on_failure = FALSE

/datum/mutation/cryokinesis
	name = "控冰术"
	desc = "受试者能够从虚空中汲取负能量，随意发射冰冻能量束。"
	quality = POSITIVE //upsides and downsides
	text_gain_indication = span_notice("你的手感觉冰凉。")
	instability = POSITIVE_INSTABILITY_MODERATE
	difficulty = 12
	synchronizer_coeff = 1
	energy_coeff = 1
	power_path = /datum/action/cooldown/spell/pointed/projectile/cryo

/datum/action/cooldown/spell/pointed/projectile/cryo
	name = "冰冻射线"
	desc = "向目标发射一道冰冻能量束。"
	button_icon_state = "icebeam"
	base_icon_state = "icebeam"
	active_overlay_icon_state = "bg_spell_border_active_blue"
	cast_range = 9
	cooldown_time = 16 SECONDS
	spell_requirements = NONE
	antimagic_flags = NONE

	active_msg = "你集中控冰之力！"
	deactive_msg = "你放松了下来。"
	projectile_type = /obj/projectile/temp/cryo
