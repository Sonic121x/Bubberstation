/area/ruin/shoe_factory
	name = "\improper 鞋厂"

/obj/effect/spawner/random/mining_loot/shoe_factory
	name = "随机鞋厂战利品"
	desc = "从战利品列表中生成鞋子。鞋子的减速系数是随机的。"
	icon = 'icons/obj/clothing/shoes.dmi'
	icon_state = "sneakers"
	loot = list()
	loot_subtype_path = /obj/item/clothing/shoes
	spawn_loot_count = 5
	spawn_scatter_radius = 2
	spawn_random_offset = TRUE

/obj/effect/spawner/random/mining_loot/shoe_factory/make_item(spawn_loc, type_path_to_make)
	var/obj/item/clothing/shoes/shoe = ..()
	if(istype(shoe))
		// shoes will spawn anywhere from -0.5 speed modifer (fast) to +0.5 speed (slow)
		// See https://tadeohepperle.com/dice-calculator-frontend/?d1=%2B5d3 to view dice chances for rolls (higher rolls == faster shoes)
		var/dice_result = roll("5d3")
		var/slowdown_modifier = (1 - (dice_result * 0.1))
		shoe.slowdown += slowdown_modifier

	return shoe

/obj/item/paper/fluff/ruins/shoe_factory/osha_shutdown
	name = "太空职业安全与健康管理局正式封闭通知"
	desc = "一份盖满印章的文件，上面有鲜红的“已封闭”水印。"
	default_raw_text = "<b>太空职业安全与健康管理局</b><br><br> \
	<b>立即封闭令</b><br><br> \
	44-S 设施（制鞋分部）现被勒令无限期停止一切运营，直至 A 级动能异常调查完成。<br><br> \
	<b>违规事项：</b><br> \
	<ul> \
	<li><b>违规 882.A：</b>产品密度出现极端偏差。随机抽检发现，约 99% 的“疾驰伴侣”牌鞋类产品带有局部重力异常。使用者报告称体力消耗极大，普通步行被形容为“拖着一颗小行星穿过湿水泥”。</li> \
	<li><b>违规 882.B：</b>致命动能加速。生产线上剩余 1% 的产品具有零摩擦蓝空间特性。一名职业安全局检查员试穿一双后被加速至 150 km/h，撞上强化等离子玻璃窗，造成重伤并导致局部船体破损。</li> \
	</ul><br> \
	所有资产均已冻结。请勿尝试运输剩余库存。如必须搬运板条箱，切勿穿上箱内的东西。"


/obj/item/paper/fluff/shoe_factory_osha
	name = "太空职业安全局检查通知"
	default_raw_text = {"
		<center><b>纳米传讯职业安全与危害管理局</b><br>
		<i>表格 77-B：强制设施封闭令</i></center><br>
		<hr>
		<b>设施：</b> 科布尔顿父子制鞋有限公司<br>
		<b>检查员：</b> H·布茨沃斯，高级现场审计员<br>
		<b>检查日期：</b> ██/██/25██<br>
		<b>结果：</b> <font color='red'><b>已下令立即封闭</b></font><br>
		<hr>
		<b>违规摘要：</b><br>
		<br>
		在例行工作场所安全审计后，以下严重违规
		于工厂车间内被发现：<br>
		<br>
		1. 多双成品鞋被查出具有与标准鞋类行为不符的
		异常危险特性。产品被观察到（已隐去），散发出未经许可的
		能量信号，其中一双甚至主动抗拒
		从受试者脚上取下。<br>
		<br>
		2. 现场未发现任何质量保证记录。当被问及质量保证
		流程时，车间经理含糊地朝一个小丑比了比，说道
		“他有时候会试穿。”<br>
		<br>
		3. 生产线完全缺乏任何形式的异常材料处理
		规程，尽管成品明显超出基准
		安全参数。<br>
		<br>
		<b>结束语：</b><br>
		<br>
		我做了 15 年安全审计员，跨越 3 个星区。我关停过
		等离子精炼厂。我处罚过奇点引擎室。我还为超出最大载员
		十一倍的小丑车写过违规报告。<br>
		<br>
		我从没见过鞋子能做出这些鞋子做的事。<br>
		<br>
		本设施将被封存，直至完整的异常物品
		审查委员会能够评估该产品线为止。任何剩余库存
		均不得从厂区内移出。<br>
		<br>
		<i>（附注：如果公司里有人在读这个——不行，你们不能
		卖这些鞋。我不管利润率有多高。别再问了。）</i><br>
		<hr>
		<i>本通知为太空职业安全局财产。撕除或涂污本
		通知者，将依纳米传讯工作场所安全法 § 4.77.2 处罚</i>
	"}

/obj/item/paper/fluff/shoe_factory_closure
	name = "封闭通知"
	desc = "一份盖着太空职业安全局印章、看起来很正式的文件。有人在角落画了一个小小的生气表情。"
	default_raw_text = {"<center><b>太空职业安全与危害管理局</b></center>
<center><b>设施封闭正式通知</b></center>
<hr>
<b>设施：</b> 无名靴类制造厂，第（已隐去）星区<br>
<b>检查官：</b> 高级特工格里夫斯，第七处<br>
<b>状态：</b> <b>永久关闭</b>，等待业主回应（业主已 14 个标准月未作回应）。<br>
<hr>

致相关人士：<br><br>

在例行合规审计后，本设施被认定严重违反了不少于<i>三十二</i>项太空职业安全局规定。完整清单见附件 B。就本摘要通知而言，以下为最恶劣的几项：<br><br>

<b>1.</b> 完全没有任何运转中的质量保证流程。面对质询，工头声称前任质量保证官是从天花板上一个未修补的洞里“匆忙离开”的。该洞已得到独立核实。那位质量保证官则没有。<br><br>

<b>2.</b> 生产含有<i>未申报活性成分</i>的鞋类。本办公室已回收多件成品，其表现与任何理性生物所称的“鞋”都大相径庭。业主坚称这些是给“有品位的冒险者”准备的“高级功能”。本办公室坚称这些是官司。<br><br>

<b>3.</b> 未对危险库存进行妥善标识。如果你正在读这份通知，而你正站在设施内，并且你正考虑穿上地板上的一双鞋：<b>请不要。</b> 或者穿吧。无论哪种，我们都不再承担责任。<br><br>

<b>4.</b> 没有消防出口。没有灭火器。大量易燃皮革。我们甚至不知道从哪儿说起。<br><br>

依据本办公室所获授权，一切运营须立即停止。任何剩余库存均归王室和/或最先赶到者所有。<br><br>

在外注意安全。<br><br>

— <i>高级特工格里夫斯，太空职业安全局</i><br>
<i>“看起来不安全，那多半就不安全。看起来安全，那多半还是不安全。”</i>"}
