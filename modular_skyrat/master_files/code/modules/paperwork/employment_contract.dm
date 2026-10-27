/obj/item/paper/work_contract
	icon_state = "paper_words"
	throw_range = 3
	throw_speed = 3
	item_flags = NOBLUDGEON
	///Needed to get the spawned mob's name to display in the paper.
	var/employee_name = ""

/obj/item/paper/work_contract/Initialize(mapload, new_employee_name)
	if(!new_employee_name)
		return INITIALIZE_HINT_QDEL

	AddElement(/datum/element/update_icon_blocker)
	. = ..()
	employee_name = new_employee_name
	name = "paper- [employee_name] 的雇佣合同"
	add_raw_text("\
	<center><font size=3>雇佣条件</center><font size=2>\
	<br><hr><br>\
	本协议自下方最后签署之日起，由 [employee_name]（以下简称<i><u>雇员</u></i>）\
	与纳米传讯（以下简称<i><u>雇主</u></i>）共同订立并生效。\
	<br>\
	<br><font size=3>兹证明：<font size=2>\
	<br>\
	鉴于，<i><u>雇员</u></i>为自然出生的人类、可接受的人形生物，或已证明具备智识的合成人形生物，其所具备的技能可\
	协助<i><u>雇主</u></i>，且其有意受雇于<i><u>雇主</u></i>。\
	<br>鉴于，<i><u>雇主</u></i>同意根据当地情况尽力及时向<i><u>雇员</u></i>支付报酬，\
	以换取<i><u>雇员</u></i>完成其所分配岗位公告中所述的工作职责。\
	<br><br>因此，鉴于本协议所载相互约定及其他良好且有价值的对价，双方兹约定如下：\
	<br><br>作为固定工资的对价，<i><u>雇员</u></i>同意为<i><u>雇主</u></i>工作，标准合同期不少于四年。\
	<br><br>雇员同意对<i><u>雇主</u></i>的一切商业秘密、空间站或其他具战略价值物品的位置、\
	资产的价值或状况、未决诉讼的存在，以及任何可能影响<i><u>雇主</u></i>整体利润与健康的材料，予以保密。\
	<br><br>此外，<i><u>雇员</u></i>允许<i><u>雇主</u></i>查阅其医疗、安保与雇佣记录，用于公共关系、市场营销、\
	产品植入、实验，或本合同未详述的其他公司用途。上述用途包括但不限于<i><u>雇员</u></i>的声音、\
	外貌、DNA 序列与共鸣；其提供的犯罪记录及与任何相关团体的关联；其提供的一般背景信息\
	以及经核实的第三方调查员提供的补充信息；其提供的医疗记录等等。\
	<br><br>若在受雇前缺乏执行所需任务的必要技能，<i><u>雇员</u></i>同意接受技能芯片植入和/或\
	录入履行职务所需资质/技能程序的内存上传，并在合同结束后接受技能芯片取出和/或记忆清除。下列程序的\
	医疗费用以及技能芯片和/或记忆改造程序费用，将在合同结束时从<i><u>雇员</u></i>的报酬中扣除。\
	<br><br>就上述内容需说明的是，任何正在进行或待决的刑事调查，若源自地球政府，均应在合同期内暂停，\
	而在<i><u>雇主</u></i>设施内可能发生的任何犯罪行为，将由受雇的或公司的准军事与安保力量予以惩处。\
	<br>最后，<i><u>雇员</u></i>理解<i><u>雇主</u></i>不受与其相同的合同原则约束，并可在任何时候终止合同，\
	无论出于何种理由，必要时无需事先警告。<i><u>雇员</u></i>同意将一切雇佣纠纷提交给指定的\
	人事主管或纠纷发生时站内的中央指挥部代表处理。争议时可有<i><u>雇主</u></i>签约的律师在场，\
	前提是<i><u>雇员</u></i>提出请求。工资不可协商，站内任何人（包括舰长）都无权提高薪资，\
	因此<i><u>雇员</u></i>同意通过正当渠道处理薪资纠纷，否则将承担违约风险。\
	<br><br>签署：\
	<br><span style=\"color:black;font-family:'Segoe Script';\"><p><b>[employee_name]</b></p></span>\
	<br><br>\
	<hr><center>-----------------------------------<br>\
	<font size=3>❘❙❚❘❙❚|<span style=\"color:black;font-family:'Sitka Small Semibold';\">荣耀归于纳米传讯</span>™|❚❙❘❚❙❘</center></hr>\
	<br><br>\
	<font size=1>依据《公司法》第 201 条第 B.3 款，污损、公开或窃取本文件者，将受到记过或立即解除合同的处罚。\
	中央指挥部代表不对因执行任何命令行为而可能造成的人员伤亡、灭绝或蓝空间事件负责。"
	)

/obj/structure/filingcabinet/employment/addFile(mob/living/carbon/human/employee)
	if(!employee || !employee.mind)
		return
	new /obj/item/paper/work_contract(src, employee.mind.name)
