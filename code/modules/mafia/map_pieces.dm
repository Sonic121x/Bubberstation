/obj/effect/landmark/mafia_game_area //locations where mafia will be loaded by the datum
	name = "黑手党区域生成点"

/obj/effect/landmark/mafia
	name = "黑手党玩家生成点"

/obj/effect/landmark/mafia/town_center
	name = "黑手党镇中心"

//for ghosts/admins
/obj/mafia_game_board
	name = "黑手党游戏板"
	icon = 'icons/obj/mafia.dmi'
	icon_state = "board"
	anchored = TRUE
	var/datum/mafia_controller/MF

/obj/mafia_game_board/attack_ghost(mob/user)
	. = ..()
	if(!MF)
		MF = GLOB.mafia_game
	if(!MF)
		MF = create_mafia_game()
	MF.ui_interact(user)

/datum/map_template/mafia
	should_place_on_top = FALSE
	///The map suffix to put onto the mappath.
	var/map_suffix
	///A brief background tidbit
	var/description = ""
	///What costume will this map force players to start with?
	var/custom_outfit

/datum/map_template/mafia/New(path = null, rename = null, cache = FALSE)
	path = "_maps/minigame/mafia/" + map_suffix
	return ..()

//we only have one map in unit tests for consistency.
#ifdef UNIT_TESTS
/datum/map_template/mafia/unit_test
	name = "黑手党单元测试"
	description = "专为单元测试设计的地图，用于确保游戏正常运行。"
	map_suffix = "mafia_unit_test.dmm"

#else

/datum/map_template/mafia/summerball
	name = "2020 夏日舞会"
	description = "最原汁原味的一版。黑手党游戏正是随这张地图在 2020 年夏日舞会上诞生的。"
	map_suffix = "mafia_ball.dmm"

/datum/map_template/mafia/ufo
	name = "外星母舰"
	description = "闹鬼幽灵 UFO 之旅出了岔子，现在得靠我们优秀的镇民和寻恐者去杀掉那些货真价实的外星变形怪……"
	map_suffix = "mafia_ayylmao.dmm"
	custom_outfit = /datum/outfit/mafia/abductee

/datum/map_template/mafia/spider_clan
	name = "蜘蛛氏族绑架案"
	description = "经过全新升级的蜘蛛氏族绑架案一点也不无聊了，处决场面也多了不少。这群该死的西洋迷！"
	map_suffix = "mafia_spiderclan.dmm"
	custom_outfit = /datum/outfit/mafia/ninja

/datum/map_template/mafia/gothic
	name = "吸血鬼城堡"
	description = "在这张阴森的城堡地图里，吸血鬼与变形怪正面交锋，看谁才是更胜一筹的吸血怪物。"
	map_suffix = "mafia_gothic.dmm"
	custom_outfit = /datum/outfit/mafia/gothic

/datum/map_template/mafia/syndicate
	name = "辛迪加巨型站"
	description = "没错，巨型站上今天乱成一团。辛迪加的冲突调解特工能成功吗？"
	map_suffix = "mafia_syndie.dmm"
	custom_outfit = /datum/outfit/mafia/syndie

/datum/map_template/mafia/snowy
	name = "雪镇"
	description = "以同名的冰封卫星地图为基础，重制它的人干得相当出色，甚至配得上得到一张由此改编的作品。酷！"
	map_suffix = "mafia_snow.dmm"
	custom_outfit = /datum/outfit/mafia/snowy

/datum/map_template/mafia/lavaland
	name = "熔岩地带远足"
	description = "空间站完全不知道熔岩地带此刻正在发生什么：我们有变形怪……还有叛徒，而最糟的是……律师每晚都在封锁你的行动。"
	map_suffix = "mafia_lavaland.dmm"
	custom_outfit = /datum/outfit/mafia/lavaland

#endif
