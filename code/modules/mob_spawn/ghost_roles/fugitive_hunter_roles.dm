
/obj/effect/mob_spawn/ghost_role/human/fugitive
	spawner_job_path = /datum/job/fugitive_hunter
	prompt_name = "快给我写个该死的提示名！"
	you_are_text = "快给我写点该死的“你是谁”文本！"
	flavour_text = "快给我写点该死的风味文本！" //the flavor text will be the backstory argument called on the antagonist's greet, see hunter.dm for details
	show_flavor = FALSE
	var/back_story = "error"
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE

/obj/effect/mob_spawn/ghost_role/human/fugitive/special(mob/living/carbon/human/spawned_human, mob/mob_possessor, apply_prefs)
	. = ..()
	var/datum/antagonist/fugitive_hunter/fughunter = new
	fughunter.backstory = back_story
	spawned_human.mind.add_antag_datum(fughunter)
	fughunter.greet()
	message_admins("[ADMIN_LOOKUPFLW(spawned_human)] 已被某个事件转化为逃犯猎人。")
	spawned_human.log_message("由某个事件作为逃犯猎人生成。", LOG_GAME)

/obj/effect/mob_spawn/ghost_role/human/fugitive/spacepol
	name = "警用休眠舱"
	desc = "一台小型休眠舱，通常用于让人入睡，并在任务前进行简报。"
	prompt_name = "一名太空警察"
	you_are_text = "我是太空警察的一员！"
	flavour_text = "正义已经降临。我们必须抓获那些潜伏在空间站上的逃犯！"
	back_story = HUNTER_PACK_COPS
	outfit = /datum/outfit/spacepol
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/russian
	name = "俄罗斯人休眠舱"
	desc = "一台小型休眠舱，通常用于让长途旅行稍微好受一些。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	faction = list(FACTION_RUSSIAN)
	prompt_name = "一名俄罗斯人"
	you_are_text = "哎呀，妈的。我是太空俄罗斯走私犯！"
	flavour_text = "我们正在飞行途中，货物却被人从船上传送走了！肯定在空间站上的某个地方？\
		我们必须想尽一切办法把它“合法”弄回来——毕竟那是我们的财产！"
	back_story = HUNTER_PACK_RUSSIAN
	outfit = /datum/outfit/russian_hunter

/obj/effect/mob_spawn/ghost_role/human/fugitive/russian/leader
	name = "俄罗斯司令官休眠舱"
	you_are_text = "哎呀，妈的。我是太空俄罗斯走私团伙的司令官！"
	outfit = /datum/outfit/russian_hunter/leader

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty
	name = "赏金猎人休眠舱"
	prompt_name = "一名赏金猎人"
	you_are_text = "我是赏金猎人。"
	flavour_text = "我们接到了一份新的悬赏，目标是几个逃犯，死活不论。"
	back_story = HUNTER_PACK_BOUNTY
	desc = "一台小型休眠舱，通常用于让长途旅行稍微好受一些。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/Destroy()
	var/obj/structure/fluff/empty_sleeper/S = new(drop_location())
	S.setDir(dir)
	return ..()

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/armor
	outfit = /datum/outfit/bountyarmor

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/hook
	outfit = /datum/outfit/bountyhook

/obj/effect/mob_spawn/ghost_role/human/fugitive/bounty/synth
	outfit = /datum/outfit/bountysynth

/obj/effect/mob_spawn/ghost_role/human/fugitive/psyker
	name = "精神激能舱"
	desc = "一台经过改装、能让使用者保持思维敏锐的低温休眠舱。不管它是怎么做到的吧……"
	icon_state = "psykerpod"
	prompt_name = "一名灵能者"
	you_are_text = "啊哈哈！我是灵能者猎手！"
	flavour_text = "唉，每次从“血觉”里醒来都难受得要命。在这片星区里找供货商总是很难，但\
		我们接到了一笔能让我们一辈子不愁的买卖！绑几个逃犯回来，就能白拿新鲜血肉！"
	back_story = HUNTER_PACK_PSYKER
	outfit = /datum/outfit/psyker

/obj/effect/mob_spawn/ghost_role/human/fugitive/psyker/captain
	prompt_name = "一名灵能者舰长"
	back_story = HUNTER_PACK_PSYKER
	outfit = /datum/outfit/psyker/captain

/obj/effect/mob_spawn/ghost_role/human/fugitive/psyker/seer
	name = "低温休眠舱"
	desc = "一台昏暗、缺乏维护，但还算普通的低温休眠舱。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	prompt_name = "一名灵能先知"
	you_are_text = "唉，我就是那个灵能先知。"
	flavour_text = "哦，好啊，那帮算命的又要我帮忙了。他们在我太空搭便车时收留了我，说只要我用“血肉之视”帮他们，就带我去任何地方。\
		他们是一群怪胎，但至少帮完忙之后他们就不来烦我了……"
	back_story = HUNTER_PACK_PSYKER
	outfit = /datum/outfit/psyker_seer

/obj/effect/mob_spawn/ghost_role/human/fugitive/mi13
	name = "绝密休眠舱"
	desc = "你的权限等级不足以知晓这个舱里装着什么，也不知道它有什么用途。"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	prompt_name = "一名军情十三处特工"
	you_are_text = "我是军情十三处派来的特工。"
	flavour_text = "你的任务是潜入 SS13 周边空域，抓获船上的逃犯，死活不论。你的穿梭机已被伪装成一辆普通餐车，以帮助你保持隐蔽。\
		这是在敌方领土上的一次隐秘行动。不会有人派增援来救你。你体内已植入微型炸弹，以防被俘。别让我们失望。"
	back_story = HUNTER_PACK_MI13
	outfit = /datum/outfit/mi13_hunter

/obj/effect/mob_spawn/ghost_role/human/fugitive/mi13/chef
	outfit = /datum/outfit/mi13_hunter/chef
