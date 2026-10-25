/datum/heretic_knowledge_tree_column/ash
	route = PATH_ASH
	ui_bgr = "node_ash"
	complexity = "简单"
	complexity_color = COLOR_GREEN
	icon = list(
		"icon" = 'icons/obj/weapons/khopesh.dmi',
		"state" = "ash_blade",
		"frame" = 1,
		"dir" = SOUTH,
		"moving" = FALSE,
	)
	description = list(
		"灰烬之道围绕火焰、机动性以及对单一对手残暴的群体控制展开。",
		"如果你是异教徒新手，或者真的很喜欢打了就跑的玩法，不妨试试这条道途。",
	)
	pros = list(
		"即使在这条道途的起点阶段也十分强力。",
		"能轻松获得机动法术和扩展视野。",
		"标记效果非常强大。",
	)
	cons = list(
		"在初始能力之外，力量不如大多数异教徒。",
		"在持久冲突中缺乏耐久。",
		"依赖在对手来得及组织有效反制之前快速且猛烈地打击。",
	)
	tips = list(
		"你的漫宿之握会附加短暂的目盲效果，以及一个由你的刀刃触发时能让对手陷入耐力重创的标记。该标记可以传播到附近的对手身上。",
		"选择这条道途会使你对高温伤害免疫。但请记住，你的衣物仍然会燃烧！如果你想保护自己免受自身火焰的伤害，请穿上焦灼斗篷。",
		"你的焦灼斗篷会让你保持燃烧，同时保护你免受其恶果。利用这一点，冲进敌群，把火焰播撒到四面八方。",
		"不要忽视疯狂面具。它会缓慢抽干敌人的耐力，并让他们产生幻象。",
		"尽可能点燃更多的敌人！守夜者的重生会治疗你，其冷却时间会根据你汲取的生物数量而缩短。",
		"你的登神会赋予你对环境危害的完全免疫，包括炸弹！但你对更常规的武器依然脆弱。不要过度自信。",
	)

	start = /datum/heretic_knowledge/limited_amount/starting/base_ash
	knowledge_tier1 = /datum/heretic_knowledge/spell/ash_passage
	guaranteed_side_tier1 = /datum/heretic_knowledge/medallion
	knowledge_tier2 = /datum/heretic_knowledge/spell/fire_blast
	guaranteed_side_tier2 = /datum/heretic_knowledge/rifle
	robes = /datum/heretic_knowledge/armor/ash
	knowledge_tier3 = /datum/heretic_knowledge/nightwatchers_lantern
	guaranteed_side_tier3 = /datum/heretic_knowledge/summon/ashy
	blade = /datum/heretic_knowledge/blade_upgrade/ash
	knowledge_tier4 = /datum/heretic_knowledge/spell/flame_birth
	ascension = /datum/heretic_knowledge/ultimate/ash_final

/datum/heretic_knowledge/limited_amount/starting/base_ash
	name = "守夜者之秘"
	desc = "为你开启灰烬之道。<br>\
		允许你创造灰烬之刃。\
		你同时最多只能创造两把。"
	transmute_text = "转化一根火柴和一把刀。"
	gain_text = "城卫队深知自己的值守。若你在夜里向他们打听，他们或许会告诉你那盏灰烬灯笼的事。"
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/match = 1,
	)
	result_atoms = list(/obj/item/melee/sickly_blade/ash)
	research_tree_icon_path = 'icons/obj/weapons/khopesh.dmi'
	research_tree_icon_state = "ash_blade"
	mark_type = /datum/status_effect/eldritch/ash
	eldritch_passive = /datum/status_effect/heretic_passive/ash

/datum/heretic_knowledge/limited_amount/starting/base_ash/on_mansus_grasp(mob/living/source, mob/living/target)
	. = ..()

	if(target.is_blind())
		return

	if(!target.get_organ_slot(ORGAN_SLOT_EYES))
		return

	to_chat(target, span_danger("一道亮绿的光在你眼中灼烧，痛得可怕！"))
	target.adjust_organ_loss(ORGAN_SLOT_EYES, 15)
	target.set_eye_blur_if_lower(20 SECONDS)

/datum/heretic_knowledge/limited_amount/starting/base_ash/trigger_mark(mob/living/source, mob/living/target)
	. = ..()
	if(!.)
		return

	// Also refunds 75% of charge!
	var/datum/action/cooldown/spell/touch/mansus_grasp/grasp = locate() in source.actions
	if(grasp)
		grasp.next_use_time -= round(grasp.cooldown_time*0.75)
		grasp.build_all_button_icons()

/datum/heretic_knowledge/spell/ash_passage
	name = "灰烬之径"
	desc = "授予你灰烬之径，这道法术能让你脱离现实，\
		使你能够穿行一小段距离，并穿过任何墙壁。"
	gain_text = "他懂得如何在位面之间行走。"
	action_to_add = /datum/action/cooldown/spell/jaunt/ethereal_jaunt/ash
	cost = 2
	// drafting_tier = 5 BUBBER REMOVAL
	max_charges = 6
	focus_recharge_amount = 0.15
	holywater_drain_amount = 0.15

/datum/heretic_knowledge/spell/fire_blast
	name = "火山爆裂"
	desc = "授予你火山爆裂，这道法术会在短暂蓄力后，向附近的敌人\
		射出一道能量束，将其点燃并灼烧。如果他们不熄灭自己，\
		这道光束就会继续射向另一个目标。"
	gain_text = "没有火焰热到足以让他们重生。没有火焰亮到足以拯救他们。没有火焰是永恒的。"
	action_to_add = /datum/action/cooldown/spell/charged/beam/fire_blast
	cost = 2
	research_tree_icon_frame = 7
	max_charges = 3
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.16

/datum/heretic_knowledge/armor/ash
	desc = "创造一件焦灼斗篷。<br>\
		它能提供对火焰的完全防护，并能被动地产生更多火焰。"
	transmute_text = "转化一张桌子（或一件套装）、一个面具和一根火柴。"
	gain_text = "守夜者倒下时仍保持原样，任其渐渐风化消逝。\
		然而吹过城中的风将他们唤回岗位，尘埃扬起，是被遗落者飘荡的侧影。"
	result_atoms = list(/obj/item/clothing/suit/hooded/cultrobes/eldritch/ash)
	research_tree_icon_state = "ash_armor"
	required_atoms = list(
		list(/obj/structure/table, /obj/item/clothing/suit) = 1,
		/obj/item/clothing/mask = 1,
		/obj/item/match = 1,
	)

/datum/heretic_knowledge/nightwatchers_lantern
	name = "守夜者的提灯"
	desc = "创造一盏燃烧的提灯。<br>\
		燃烧的提灯是一团明亮的光源，会伤害目睹者的眼睛，并最终使久视者神志混乱。\
		对于佩戴护目装备的人，效果会减弱；若燃烧的提灯是附近唯一的光源，效果则会增强。"
	transmute_text = "转化一盏台灯、提灯或安保手电筒，一对眼睛，一枚闪光装置，以及四根点燃的蜡烛。"
	gain_text = "守夜者从不在黑暗中外出。那是愚蠢的做法，连守夜队都明白这一点。\
		他的提灯燃烧着足以灼伤太阳的光芒。"
	cost = 2
	result_atoms = list(/obj/item/flashlight/lantern/heretic)
	required_atoms = list(
		list(/obj/item/flashlight/lamp, /obj/item/flashlight/lantern, /obj/item/flashlight/seclite) = 1,
		/obj/item/organ/eyes = 1,
		/obj/item/assembly/flash = 1,
		/obj/item/flashlight/flare/candle = 4,
	)
	research_tree_icon_path = 'icons/obj/lighting.dmi'
	research_tree_icon_state = "lantern"

/datum/heretic_knowledge/nightwatchers_lantern/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	for(var/obj/item/flashlight/flare/candle/candle in atoms)
		if(!candle.light_on)
			atoms -= candle

/datum/heretic_knowledge/nightwatchers_lantern/prepare_atom_for_ritual_test(atom/what)
	. = ..()
	if(istype(what, /obj/item/flashlight/flare/candle))
		what.set_light_on(TRUE)

/datum/heretic_knowledge/blade_upgrade/ash
	name = "炽焰之刃"
	desc = "你的刀刃如今在攻击时会使敌人燃起烈火。"
	gain_text = "他归来了，手握刀刃，当灰烬从天空落下时他挥了又挥。\
		他的城市，他发誓要守望的人们……而他确实守望了，看着他们尽数烧成焦炭。"

	research_tree_icon_path = 'icons/ui_icons/antags/heretic/knowledge.dmi'
	research_tree_icon_state = "blade_upgrade_ash"

/datum/heretic_knowledge/blade_upgrade/ash/do_melee_effects(mob/living/source, mob/living/target, obj/item/melee/sickly_blade/blade)
	if(source == target || !isliving(target))
		return

	target.adjust_fire_stacks(1)
	target.ignite_mob()

/datum/heretic_knowledge/spell/flame_birth
	name = "守夜者的重生"
	desc = "授予你守夜者的重生，这道法术会熄灭你身上的火焰，并\
		灼烧附近所有正在燃烧的异端，每有一名受害者被灼烧，你便会得到治疗。<br>\
		如果被灼烧的受害者处于危急状态，他们还会当场死亡。"
	gain_text = "那火焰无处可逃，然而他焦黑的躯体中仍存生命。\
		守夜者是个特别的人，永远在注视着。"
	action_to_add = /datum/action/cooldown/spell/aoe/fiery_rebirth
	cost = 2
	research_tree_icon_frame = 5
	is_final_knowledge = TRUE
	max_charges = 3
	focus_recharge_amount = 0.33
	holywater_drain_amount = 0.16

/datum/heretic_knowledge/ultimate/ash_final
	name = "灰烬之主仪式"
	desc = "灰烬之道的登神仪式。<br>\
		完成之后，你将成为烈焰的先行者，获得两项能力。<br>\
		“连锁”，在你周围引发一圈不断扩大、规模庞大的火环，\
		以及“烈焰誓约”，让你行走时被动地留下火环。<br>\
		你还将对火焰、太空及类似的环境危害免疫。"
	transmute_text = "转化 3 具正在燃烧的或已成焦尸的尸体。"
	gain_text = "守夜队已死，守夜者也随之焚尽。然而他的火焰燃烧得愈发炽烈，\
		因为守夜者将仪式带给了人类！他的凝视仍在延续，如今我已与烈焰合一，\
		见证我的登神吧，灰烬灯笼再度燃起！"

	ascension_achievement = /datum/award/achievement/misc/ash_ascension
	announcement_text = "%SPOOKY% 畏惧烈焰吧，灰烬之主 %NAME% 已然登神！火焰将吞噬一切！%SPOOKY%"
	announcement_sound = 'sound/music/antag/heretic/ascend_ash.ogg'
	/// A static list of all traits we apply on ascension.
	var/static/list/traits_to_apply = list(
		TRAIT_BOMBIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_NOFIRE,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHEAT,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
	)

/datum/heretic_knowledge/ultimate/ash_final/is_valid_sacrifice(mob/living/carbon/human/sacrifice)
	. = ..()
	if(!.)
		return

	if(sacrifice.on_fire)
		return TRUE
	if(HAS_TRAIT_FROM(sacrifice, TRAIT_HUSK, BURN))
		return TRUE
	return FALSE

/datum/heretic_knowledge/ultimate/ash_final/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	. = ..()
	var/datum/action/cooldown/spell/fire_sworn/circle_spell = new(user.mind)
	circle_spell.Grant(user)

	var/datum/action/cooldown/spell/fire_cascade/big/screen_wide_fire_spell = new(user.mind)
	screen_wide_fire_spell.Grant(user)

	var/datum/action/cooldown/spell/charged/beam/fire_blast/existing_beam_spell = locate() in user.actions
	if(existing_beam_spell)
		existing_beam_spell.max_beam_bounces *= 2 // Double beams
		existing_beam_spell.beam_duration *= 0.66 // Faster beams
		existing_beam_spell.cooldown_time *= 0.66 // Lower cooldown

	var/datum/action/cooldown/spell/aoe/fiery_rebirth/fiery_rebirth = locate() in user.actions
	fiery_rebirth?.cooldown_time *= 0.16

	user.add_traits(traits_to_apply, type)
