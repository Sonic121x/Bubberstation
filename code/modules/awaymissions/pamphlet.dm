/obj/item/paper/pamphlet
	name = "小册子"
	icon_state = "pamphlet"
	show_written_words = FALSE

/obj/item/paper/pamphlet/radstorm
	name = "小册子 - \'辐射风暴安全措施与如何避免变成猴子\'"
	default_raw_text = "站上的辐射风暴预先安全警报响了，你却找不到附近可以逃进去的维护舱口？别怕，纳米传讯真的什么都想到了！ \
		站内上层各处已安装了数座公共避难点，专门用于保护你那脆弱的肉身，不让它成为下一场医疗灾难！ \
		如果你没能及时赶到避难点，请查阅员工手册第 4.3 V2-3 小节，了解处理过量辐射损伤的适当流程。"


/obj/item/paper/pamphlet/violent_video_games
	name = "小册子 - \'暴力电子游戏与你\'"
	desc = "一本鼓励读者保持均衡的生活方式、照顾心理健康，同时以健康的方式享受电子游戏的小册子。你大概用不上这个……"
	default_raw_text = "它们不会让你去杀人。好了，我们说了。现在回去工作！"

/obj/item/paper/pamphlet/gateway
	default_raw_text = "<b>欢迎参与纳米传讯传送门项目……</b><br>\
			恭喜！如果你正在读这段话，说明你和你的上级已经认定，你 \
			已准备好投身于在遥远世界的连绵丘陵上殖民的一生。你 \
			必须准备好迎接一生的冒险、一点点辛苦工作，以及一份获奖 \
			级别的牙科保险——但这还不是纳米传讯传送门项目的全部。<br>\
			<br>因为我们关心你，我们认为让你在加入纳米传讯传送门项目 \
			之前了解风险才是公平的。所有外派目的地都 \
			已由纳米传讯远征队完成全面扫描，并认证为 100% 安全。 \
			我们甚至还留下了一箱太空啤酒，以及扩展纳米传讯 \
			作业区域、开启新生活所需的基础材料。<br><br>\
			<b>传送门操作基础</b><br>\
			所有经纳米传讯批准的传送门都遵循相同的基本原理。它们依靠 \
			区域设备电力运行，如你所料，没有这份供电，它便无法安全运作， \
			并会因此拒绝所有操作尝试。<br><br>\
			一旦正确设置，并拥有足够的运行电力，传送门便会开始 \
			搜索输出地点。所需时间并不固定，但传送门 \
			界面会给出精确到分钟的估计。断电不会中断 \
			搜索过程。流感不会中断搜索过程。时间异常 \
			可能导致估计不准确，但不会中断搜索过程。<br><br> \
			<b>彼端的生活</b><br>\
			穿过传送门后，你可能会感到有些迷失方向。不要惊慌。 \
			这是在短时间内跨越遥远距离的正常副作用。你应当 \
			勘察周边区域，并试着找到赠送的那箱太空啤酒。我们的 \
			远征队已确保所有外派地点的绝对安全，但在少数 \
			情况下，他们建立的传送门可能不会立刻显现。 \
			如果找不到返回的传送门，也不要惊慌。开始殖民目的地吧。 \
			<br><br><b>新世界</b><br>\
			作为纳米传讯传送门项目的参与者，你将身处太空边疆。 \
			虽然已确保绝对安全，但仍建议参与者为恶劣的 \
			环境做好准备。"

/obj/item/paper/pamphlet/cybernetics
	name = "小册子 - '合成人公司赛博义体入门装备！'"
	default_raw_text = "今天就来加入身体改造革命！在这份难得一见的专属优惠中，我们要向你送出最新最棒的 \
		合成人公司赛博义体增强装置免费样品！随信附赠一件 \
		特别限量版自选 NTSDA 认证 A 级赛博植入体，完全免费！用合成人公司全新独家的 \
		赛博产品系列把你的身体推向伟大！今天就变得更伟大、更强壮、更优秀！"
	var/obj/item/organ/heart/cybernetic/sample

/obj/item/paper/pamphlet/cybernetics/Initialize(mapload)
	. = ..()
	sample = new(src)
	update_desc()

/obj/item/paper/pamphlet/cybernetics/update_desc(updates)
	. = ..()
	desc = "一本鼓励读者给自己植入义体的小册子。[sample ? " 附有一份\"样品\"……" : ""]"

/obj/item/paper/pamphlet/cybernetics/Destroy()
	QDEL_NULL(sample)
	return ..()

/obj/item/paper/pamphlet/cybernetics/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == sample)
		sample = null
		update_desc()

/obj/item/paper/pamphlet/cybernetics/attack_self(mob/user, modifiers)
	. = ..()
	to_chat(user, span_notice("当你阅读小册子时，一份免费样品掉了出来！"))
	sample.forceMove(drop_location())
	playsound(sample, 'sound/misc/splort.ogg', 50, vary = TRUE)
