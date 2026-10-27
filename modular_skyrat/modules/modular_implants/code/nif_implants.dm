///This is the standard 'baseline' NIF model.
/obj/item/organ/cyberimp/brain/nif/standard
	name = "标准型 NIF"
	desc = "“标准型”是对高质量纳米植入框架的等级划分。这一类别主要包括可靠性高、能与使用者无缝结合、并兼具存储空间与处理能力以运行大量程序的框架型号。"
	manufacturer_notes = "尽管无数厂商都在生产自己的 NIF 实现，无论开源与否，全银河的标准型型号也不足一千款。它们是近五年来对旧款框架不断改良的成果，由于极难“自制”，因此相当抢手。"

/obj/item/organ/cyberimp/brain/nif/roleplay_model
	name = "经济型 NIF"
	desc = "“经济型”是对低质量纳米植入框架的等级划分。这类框架通常是高质量框架的杂牌“经济”仿制品，配备低规格电池、过时且危险的结构设计，与使用者的校准也粗糙得多。"
	manufacturer_notes = "爱好者与硬核用户聚集的大多数网络空间、企业神经学家，以及交错空间巫团这类“软件”开发者，都建议不要购买它们。尽管普通人负担得起，但框架用户圈子里有一条共识：直接接入使用者神经系统的设备，绝不该省钱。因此，经济型框架往往落到真正走投无路的人、罪犯手中，或者作为“自制货”从工坊里流出。"

	max_power_level = 500
	max_nifsofts = 3
	calibration_time = 1 MINUTES
	max_durability = 50
	death_durability_loss = 10


/obj/item/organ/cyberimp/brain/nif/roleplay_model/cheap
	name = "试用轻型 NIF"
	desc = "“试用轻型”是对临时性纳米植入框架的等级划分。这类框架通常在推广活动中发放，用于单一用途的 NIFSoft，或在某些企业经销店中让潜在用户体验一番。通常情况下，试用轻型框架并不会真正与使用者“结合”，只是形成极其松散的联系，几小时内便会消散为散落失活的纳米机器，通常随呼气排出体外。"
	manufacturer_notes = "通常情况下，试用轻型框架并不会真正与使用者“结合”，只是形成极其松散的联系，几小时内便会消散为散落失活的纳米机器，通常随呼气排出体外。由于其构造与编程都远逊一筹，至今仍无法延长试用轻型 NIF 的寿命。"
	nif_persistence = FALSE

/obj/item/autosurgeon/organ/nif/disposable //Disposable, as in the fact that this only lasts for one shift
	name = "经济型自动手术器"
	starting_organ = /obj/item/organ/cyberimp/brain/nif/roleplay_model/cheap
	uses = 1

/obj/item/organ/cyberimp/brain/nif/standard/ghost_role
	nif_persistence = FALSE
	is_calibrated = TRUE

/obj/item/autosurgeon/organ/nif/ghost_role
	name = "增强标准型 NIF 自动手术器"
	starting_organ = /obj/item/organ/cyberimp/brain/nif/standard/ghost_role
	uses = 1
