/mob/living/basic/snake/banded
	name = "环带蛇"
	desc = "一条色彩斑斓的条纹蛇。它要么是无害的小行星王蛇，要么是剧毒又好斗的星云蝰蛇。有口诀能区分两者，你只要看清颜色，再凑近检查一下就行……"
	icon_state = "bandedsnake"
	icon_living = "bandedsnake"
	icon_dead = "bandedsnake_dead"
	venom_dose = 2
	var/poison_reagent = /datum/reagent/toxin/cyanide
	health = 30
	maxHealth = 30
	melee_damage_upper = 10
	gold_core_spawnable = HOSTILE_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/snake/banded
	var/list/rhymes_dangerous = list(
		"红上带黄，送你上天堂。",
		"黄上带黑，阴毒的小东西。",
		"黑上带黄，赶紧躲远点。",
		"黑上带黄，必定要来咬。",
		)
	var/list/rhymes_harmless = list(
		"黄上带红，友善的老朋友。",
		"红上带黄，这条挺不错。等等，这也不押韵啊……",
		"黑上带黄，不会来攻击。",
		"黄上带黑，慵懒又温和。",
		)

/mob/living/basic/snake/banded/Initialize(mapload, special_reagent)
	special_reagent = src.poison_reagent
	AddComponent(/datum/component/swarming)
	return ..()

/mob/living/basic/snake/banded/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你非常仔细地端详蛇身上的环带……</i>")
	if(src.poison_reagent == (/datum/reagent/consumable/milk))
		. += span_info("[pick(src.rhymes_harmless)]")
		. += span_notice("这条蛇没有危险！")
	else
		. += span_info("[pick(src.rhymes_dangerous)]")
		. += span_notice("这条蛇很危险！")
	return .

/datum/ai_controller/basic_controller/snake/banded
	behavior_tree_json = "code/modules/mob/living/basic/space_fauna/snake/banded.bt.json"
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_BASIC_MOB_SPEAK_LINES = list(
			BB_EMOTE_SAY = list("嘶嘶嘶", "嘶——嘶嘶嘶……", "嘶——"),
			BB_EMOTE_HEAR = list("发出嘶嘶声。"),
			BB_EMOTE_SEE = list("四处滑行。", "瞥了一眼。", "盯着看。"),
			BB_EMOTE_SOUND = list('sound/mobs/non-humanoids/snake/snake_hissing1.ogg', 'sound/mobs/non-humanoids/snake/snake_hissing2.ogg'),
			BB_SPEAK_CHANCE = 5,
		),
	)
	ai_movement = /datum/ai_movement/basic_avoidance

/mob/living/basic/snake/banded/harmless
	venom_dose = 0.4
	poison_reagent = /datum/reagent/consumable/milk
	melee_damage_lower = 1
	melee_damage_upper = 1
	gold_core_spawnable = FRIENDLY_SPAWN
	ai_controller = /datum/ai_controller/basic_controller/snake
