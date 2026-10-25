
/datum/map_template/holodeck
	/// id
	var/template_id
	/// Is this an emag program
	var/restricted = FALSE

	should_place_on_top = FALSE
	returns_created_atoms = TRUE
	keep_cached_map = TRUE

/datum/map_template/holodeck/offline
	name = "全息甲板 - 离线"
	template_id = "holodeck_offline"
	mappath = "_maps/templates/holodeck_offline.dmm"

/datum/map_template/holodeck/emptycourt
	name = "全息甲板 - 空场地"
	template_id = "holodeck_emptycourt"
	mappath = "_maps/templates/holodeck_emptycourt.dmm"

/datum/map_template/holodeck/dodgeball
	name = "全息甲板 - 躲避球场地"
	template_id = "holodeck_dodgeball"
	mappath = "_maps/templates/holodeck_dodgeball.dmm"

/datum/map_template/holodeck/basketball
	name = "全息甲板 - 篮球场"
	template_id = "holodeck_basketball"
	mappath = "_maps/templates/holodeck_basketball.dmm"

/datum/map_template/holodeck/thunderdome
	name = "全息甲板 - 雷霆竞技场"
	template_id = "holodeck_thunderdome"
	mappath = "_maps/templates/holodeck_thunderdome.dmm"

/datum/map_template/holodeck/beach
	name = "全息甲板 - 海滩"
	template_id = "holodeck_beach"
	mappath = "_maps/templates/holodeck_beach.dmm"

/datum/map_template/holodeck/lounge
	name = "全息甲板 - 休息室"
	template_id = "holodeck_lounge"
	mappath = "_maps/templates/holodeck_lounge.dmm"

/datum/map_template/holodeck/petpark
	name = "全息甲板 - 宠物公园"
	template_id = "holodeck_petpark"
	mappath = "_maps/templates/holodeck_petpark.dmm"

/datum/map_template/holodeck/firingrange
	name = "全息甲板 - 射击场"
	template_id = "holodeck_firingrange"
	mappath = "_maps/templates/holodeck_firingrange.dmm"

/datum/map_template/holodeck/anime_school
	name = "全息甲板 - 动漫学校"
	template_id = "holodeck_animeschool"
	mappath = "_maps/templates/holodeck_animeschool.dmm"

/datum/map_template/holodeck/chapelcourt
	name = "全息甲板 - 礼拜堂法庭"
	template_id = "holodeck_chapelcourt"
	mappath = "_maps/templates/holodeck_chapelcourt.dmm"

/datum/map_template/holodeck/spacechess
	name = "全息甲板 - 太空国际象棋"
	template_id = "holodeck_spacechess"
	mappath = "_maps/templates/holodeck_spacechess.dmm"

/datum/map_template/holodeck/spacecheckers
	name = "全息甲板 - 太空跳棋"
	template_id = "holodeck_spacecheckers"
	mappath = "_maps/templates/holodeck_spacecheckers.dmm"

/datum/map_template/holodeck/kobayashi
	name = "全息甲板 - 小林丸"
	template_id = "holodeck_kobayashi"
	mappath = "_maps/templates/holodeck_kobayashi.dmm"

/datum/map_template/holodeck/winterwonderland
	name = "全息甲板 - 冬日仙境"
	template_id = "holodeck_winterwonderland"
	mappath = "_maps/templates/holodeck_winterwonderland.dmm"

/datum/map_template/holodeck/photobooth
	name = "全息甲板 - 照相亭"
	template_id = "holodeck_photobooth"
	mappath = "_maps/templates/holodeck_photobooth.dmm"

/datum/map_template/holodeck/skatepark
	name = "全息甲板 - 滑板公园"
	template_id = "holodeck_skatepark"
	mappath = "_maps/templates/holodeck_skatepark.dmm"

/datum/map_template/holodeck/microwave
	name = "全息甲板 - 微波炉天堂"
	template_id = "holodeck_microwave"
	mappath = "_maps/templates/holodeck_microwave.dmm"

/datum/map_template/holodeck/baseball
	name = "全息甲板 - 棒球场"
	template_id = "holodeck_baseball"
	mappath = "_maps/templates/holodeck_baseball.dmm"

/datum/map_template/holodeck/card_battle
	name = "全息甲板 - TGC 对战竞技场"
	template_id = "holodeck_card_battle"
	mappath = "_maps/templates/holodeck_card_battle.dmm"

/datum/map_template/holodeck/fitness
	name = "全息甲板 - 健身房"
	template_id = "holodeck_fitness"
	mappath = "_maps/templates/holodeck_fitness.dmm"

//bad evil no good programs

/datum/map_template/holodeck/medicalsim
	name = "全息甲板 - 紧急医疗"
	template_id = "holodeck_medicalsim"
	mappath = "_maps/templates/holodeck_medicalsim.dmm"
	restricted = TRUE

/datum/map_template/holodeck/thunderdome1218
	name = "全息甲板 - 公元 1218 年"
	template_id = "holodeck_thunderdome1218"
	mappath = "_maps/templates/holodeck_thunderdome1218.dmm"
	restricted = TRUE

/datum/map_template/holodeck/burntest
	name = "全息甲板 - 大气燃烧测试"
	template_id = "holodeck_burntest"
	mappath = "_maps/templates/holodeck_burntest.dmm"
	restricted = TRUE

/datum/map_template/holodeck/wildlifesim
	name = "全息甲板 - 野生动物模拟"
	template_id = "holodeck_wildlifesim"
	mappath = "_maps/templates/holodeck_wildlifesim.dmm"
	restricted = TRUE

/datum/map_template/holodeck/holdoutbunker
	name = "全息甲板 - 坚守地堡"
	template_id = "holodeck_holdoutbunker"
	mappath = "_maps/templates/holodeck_holdoutbunker.dmm"
	restricted = TRUE

/datum/map_template/holodeck/anthophillia
	name = "全息甲板 - 恋花"
	template_id = "holodeck_anthophillia"
	mappath = "_maps/templates/holodeck_anthophillia.dmm"
	restricted = TRUE

/datum/map_template/holodeck/refuelingstation
	name = "全息甲板 - 燃料补给站"
	template_id = "holodeck_refuelingstation"
	mappath = "_maps/templates/holodeck_refuelingstation.dmm"
	restricted = TRUE

/datum/map_template/holodeck/prison
	name = "全息甲板 - 监狱区"
	template_id = "holodeck_prison"
	mappath = "_maps/templates/holodeck_prison.dmm"
	restricted = TRUE
