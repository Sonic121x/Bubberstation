/datum/map_template/shuttle/emergency/vitezstvi_mercs
	prefix = "_maps/shuttles/zubbers/"
	suffix = "merc"
	name = "VARS-7“向导”号承包商穿梭机"
	description = "向胜利军械讨一笔旧人情，召来 VARS-7“向导”号——一艘全副武装的贩枪货船，船员尽是些友善的承包商，手里的枪比脑子还多。在无线电里和这帮人通话时听到的那口极其含糊的说话声，会让你怀疑这是不是个好主意……"
	admin_notes = "生成四个试图营救船员的醉鬼，然后一头撞进空间站的随机房间。嘿嘿。"
	credit_cost = CARGO_CRATE_VALUE * 500
	occupancy_limit = "45 + 4 名承包商"
	prerequisites = "本轮在空间站赏金板上完成任意一项胜利军械赏金。"

/datum/map_template/shuttle/emergency/vitezstvi_mercs/prerequisites_met()
	return SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_VITEZSTVI]
