
/datum/bounty/item/science/relic
	name = "经 E.X.P.E.R.I-MENTOR 发现的装置"
	description = "嘘，嘿。别告诉那些助手，但我们正压价收购他们一直找到的那些“奇怪物体”。用 E.X.P.E.R.I-MENTOR 激活一个，然后把已发现的装置寄给我们。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/relic = TRUE)

/datum/bounty/item/science/relic/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/item/relic/experiment = O
	if(experiment.activated)
		return TRUE
	return

/datum/bounty/item/science/bepis_disc
	name = "重新格式化的科技磁盘"
	description = "原来 BEPIS 用来打印实验性节点的磁盘在空间利用上极为高效。你用完多余的磁盘后，寄一张给我们。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(
		/obj/item/disk/design_disk/bepis/remove_tech = TRUE,
		/obj/item/disk/design_disk/bepis = TRUE,
	)

/datum/bounty/item/science/genetics
	name = "基因缺陷诱变器"
	description = "理解类人基因组是治愈许多太空遗传缺陷、并突破我们最基础极限的第一步。"
	reward = CARGO_CRATE_VALUE * 2
	wanted_types = list(/obj/item/dnainjector = TRUE)
	///What's the instability
	var/desired_instability = 0

/datum/bounty/item/science/genetics/New()
	. = ..()
	desired_instability = rand(10,40)
	reward += desired_instability * (CARGO_CRATE_VALUE * 0.2)
	description += " 我们要一支总不稳定度高于 [desired_instability] 点的 DNA 注射器。"

/datum/bounty/item/science/genetics/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/item/dnainjector/mutator = O
	if(mutator.used)
		return FALSE
	var/inst_total = 0
	for(var/pot_mut in mutator.add_mutations)
		var/datum/mutation/mutation = pot_mut
		if(initial(mutation.quality) != POSITIVE)
			continue
		inst_total += mutation.instability
	if(inst_total >= desired_instability)
		return TRUE
	return FALSE

//******Modular Computer Bounties******
/datum/bounty/item/science/ntnet
	name = "模块化平板电脑"
	description = "原来 NTNet 并不是一时风潮，谁知道呢。寄几台功能完好的 PDA 来，帮我们跟上最新技术。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 4
	wanted_types = list(/obj/item/modular_computer/pda = TRUE)
	var/require_powered = TRUE

/datum/bounty/item/science/ntnet/applies_to(obj/O)
	if(!..())
		return FALSE
	if(require_powered)
		var/obj/item/modular_computer/computer = O
		if(!istype(computer) || !computer.enabled)
			return FALSE
	return TRUE

/datum/bounty/item/science/ntnet/laptops
	name = "模块化笔记本电脑"
	description = "中央指挥部的大人物们需要比平板更强、又比控制台更便携的东西。寄几台能用的笔记本电脑，帮这些老古董一把。寄的时候要开着机。"
	reward = CARGO_CRATE_VALUE * 3
	required_count = 2
	wanted_types = list(/obj/item/modular_computer/laptop = TRUE)

/datum/bounty/item/science/ntnet/console
	name = "模块化计算机控制台"
	description = "我们的大数据部门需要更强的硬件来玩《炸弹古巴皮特》——呃，是密切监控你们星区的威胁。寄一台可用的模块化计算机控制台给我们。"
	reward = CARGO_CRATE_VALUE * 6
	required_count = 1
	wanted_types = list(/obj/machinery/modular_computer = TRUE)
	require_powered = FALSE

/datum/bounty/item/science/ntnet/console/applies_to(obj/O)
	if(!..())
		return FALSE
	var/obj/machinery/modular_computer/computer = O
	if(!istype(computer) || !computer.cpu)
		return FALSE
	return TRUE


//******Anomaly Cores******
/datum/bounty/item/science/ref_anomaly
	name = "精炼蓝空间核心"
	description = "我们需要一个蓝空间核心来组装次元背包。请寄一个给我们。"
	reward = CARGO_CRATE_VALUE * 20
	wanted_types = list(/obj/item/assembly/signaler/anomaly/bluespace = TRUE)

/datum/bounty/item/science/ref_anomaly/can_get(obj/O)
	var/anomaly_type = wanted_types[1]
	if(SSresearch.created_anomaly_types[anomaly_type] >= SSresearch.anomaly_hard_limit_by_type[anomaly_type])
		return FALSE
	return TRUE

/datum/bounty/item/science/ref_anomaly/flux
	name = "精炼通量核心"
	description = "我们正试着造一门特斯拉炮来对付一些蛾子。请寄一个通量核心给我们。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/flux = TRUE)

/datum/bounty/item/science/ref_anomaly/pyro
	name = "精炼火山碎屑核心"
	description = "我们需要研究一个精炼火山碎屑核心，请寄一个来。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/pyro = TRUE)

/datum/bounty/item/science/ref_anomaly/grav
	name = "精炼重力核心"
	description = "中央研发部正试图找到让机甲悬浮的方法，寄一个重力核心过来。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/grav = TRUE)

/datum/bounty/item/science/ref_anomaly/vortex
	name = "精炼漩涡核心"
	description = "我们打算把一个漩涡核心扔进虫洞看看会发生什么。寄一个来。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/vortex = TRUE)

/datum/bounty/item/science/ref_anomaly/hallucination
	name = "精炼幻觉核心"
	description = "我们正在改良太空毒品，寄一个核心给我们，帮我们复制它的效果。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/hallucination = TRUE)

/datum/bounty/item/science/ref_anomaly/bioscrambler
	name = "精炼生物扰乱核心"
	description = "我们那只清洁工蜥蜴失去了所有肢体，寄一个生物扰乱核心来给它换上。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/bioscrambler = TRUE)

/datum/bounty/item/science/ref_anomaly/dimensional
	name = "精炼维度核心"
	description = "我们想省下中央指挥部年度翻修的开销。寄一个维度核心给我们。"
	wanted_types = list(/obj/item/assembly/signaler/anomaly/dimensional = TRUE)
