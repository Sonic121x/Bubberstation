// The idea here is to give heretics something to restore things they would need medbay for but not a cure-all
// A bubber edit changes the heal flag in eldritch_flask.dm
/datum/heretic_knowledge/ether
	desc = "将一滩呕吐物和一块玻璃碎片转化为一次性药剂。饮用后会清除身体的各种异常，包括疾病和脑损伤（但不移除植入物），\
		不会恢复生命值，代价是昏迷整整一分钟。"
	drafting_tier = 2 // very strong, even with the nerf

/obj/item/ether
	desc = "一瓶令人作呕的浓稠绿色液体。可修复身体的附带伤病（缺失部位、失血、创伤、疾病），随后让你陷入长达一分钟的深度睡眠。"

/obj/item/ether/examine(mob/user)
	. = ..()

	. += span_notice("饮用后可再生肢体和器官，并清除基因突变和疾病。")
