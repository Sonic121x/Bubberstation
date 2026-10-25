/datum/bounty/item/medical/heart
	name = "心脏"
	description = "约翰逊指挥官又一次心脏病发作后生命垂危。医生说必须尽快换一颗新心脏。立刻送一颗过来！如果需要，我们也可以接受赛博心脏，但必须是升级过的。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/organ/heart = TRUE,
		/obj/item/organ/heart/cybernetic = FALSE,
		/obj/item/organ/heart/cybernetic/tier2 = TRUE,
		/obj/item/organ/heart/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/lung
	name = "肺"
	description = "中央指挥部最近发生了一起爆炸，多名职员肺部被刺穿。请运送备用肺，将获得报酬。必要时我们也接受赛博肺，但必须是升级过的。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/lungs = TRUE,
		/obj/item/organ/lungs/cybernetic = FALSE,
		/obj/item/organ/lungs/cybernetic/tier2 = TRUE,
		/obj/item/organ/lungs/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/appendix
	name = "阑尾"
	description = "中央指挥部的厨师吉布想用一样非常特别的食材做一道菜：阑尾。如果你送来一根，他会付钱。"
	reward = CARGO_CRATE_VALUE * 5 //there are no synthetic appendixes
	wanted_types = list(/obj/item/organ/appendix = TRUE)

/datum/bounty/item/medical/ears
	name = "耳朵"
	description = "12 号空间站的多名职员因违规的小丑恶作剧而失聪。请送来新的耳朵。必要时我们也接受赛博耳朵，但必须是升级过的。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/ears = TRUE,
		/obj/item/organ/ears/cybernetic = FALSE,
		/obj/item/organ/ears/cybernetic/upgraded = TRUE,
		/obj/item/organ/ears/cybernetic/whisper = TRUE,
		/obj/item/organ/ears/cybernetic/xray = TRUE,
		/obj/item/organ/ears/cybernetic/volume = TRUE,
	)

/datum/bounty/item/medical/liver
	name = "肝脏"
	description = "几名高级中央指挥部外交官在最近与第三苏联大使会面后因肝衰竭住院。帮帮我们，好吗？必要时我们也接受赛博肝脏，但必须是升级过的。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/liver = TRUE,
		/obj/item/organ/liver/cybernetic = FALSE,
		/obj/item/organ/liver/cybernetic/tier2 = TRUE,
		/obj/item/organ/liver/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/eye
	name = "有机眼睛"
	description = "5 号空间站的科研主管威廉需要几双非机械眼睛。别问问题，送来就是。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/eyes = TRUE,
		/obj/item/organ/eyes/robotic = FALSE,
	)

/datum/bounty/item/medical/tongue
	name = "舌头"
	description = "默剧极端分子最近的袭击让 23 号空间站的职员们哑口无言。请运送一些备用舌头。"
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(/obj/item/organ/tongue = TRUE)

/datum/bounty/item/medical/lizard_tail
	name = "蜥蜴尾巴"
	description = "巫师联邦抢走了纳米传讯的蜥蜴尾巴储备。在中央指挥部处理巫师期间，空间站能不能匀出一条自己的尾巴？"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/tail/lizard = TRUE)

/datum/bounty/item/medical/cat_tail
	name = "猫尾巴"
	description = "中央指挥部的重型管道清洁器用完了。你能送一条猫尾巴过来帮我们吗？"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/item/organ/tail/cat = TRUE)

/datum/bounty/item/medical/chainsaw
	name = "电锯"
	description = "中央指挥部的一位首席医疗官在给魔像做手术时遇到了麻烦。她请求送一把电锯。"
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(/obj/item/chainsaw = TRUE)

/datum/bounty/item/medical/tail_whip //Like the cat tail bounties, with more processing.
	name = "九尾鞭"
	description = "杰克逊指挥官正在为她的异国武器收藏寻找一件精美的补充。无论是猫尾还是蜥蜴尾的九尾鞭，她都会慷慨付酬。"
	reward = CARGO_CRATE_VALUE * 8
	wanted_types = list(/obj/item/melee/chainofcommand/tailwhip = TRUE)

/datum/bounty/item/medical/surgerycomp
	name = "手术电脑"
	description = "在我们于中央指挥部举办的年度奶酪节上又发生了一起离奇爆炸事件后，我们这边堆满了受伤的船员。如有可能，请给我们送一台新的手术电脑。"
	reward = CARGO_CRATE_VALUE * 12
	wanted_types = list(/obj/machinery/computer/operating = TRUE)

/datum/bounty/item/medical/surgerytable
	name = "手术台"
	description = "最近感染船员大量涌入，我们发现仅靠口罩已经不够了。银制手术台或许正好能解决问题，请送一张给我们使用。"
	reward = CARGO_CRATE_VALUE * 6
	wanted_types = list(/obj/structure/table/optable = TRUE)

/datum/bounty/item/medical/scanning
	name = "船员医疗扫描"
	description = "使用任意健康分析仪对一名健康状况近乎完美或更好的船员进行常规医疗扫描，以确保船员认真对待自己的医疗护理。然后打印医疗报告并寄回给我们。"
	reward = CARGO_CRATE_VALUE * 8
	required_count = 2
	wanted_types = list(/obj/item/paper/medical_report = TRUE)

/datum/bounty/item/medical/scanning/applies_to(obj/shipped)
	. = ..()
	if(!istype(shipped, /obj/item/paper/medical_report))
		return FALSE
	var/obj/item/paper/medical_report/report = shipped
	if(!report)
		return FALSE

	var/mob/living/patient = report.last_healthy_scanned_mob?.resolve()
	if(patient)
		return TRUE
	return FALSE
