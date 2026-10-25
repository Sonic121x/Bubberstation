/datum/experiment/scanning/points/slime
	name = "基础史莱姆实验"
	required_points = 1

/datum/experiment/scanning/points/slime/hard
	name = "挑战性史莱姆调查"
	description = "另一个空间站向你的研究团队发起挑战，要求收集数种具有挑战性的史莱姆核心， \
		你能胜任吗？"
	required_points = 10
	required_atoms = list(/obj/item/slime_extract/bluespace = 1,
		/obj/item/slime_extract/sepia = 1,
		/obj/item/slime_extract/cerulean = 1,
		/obj/item/slime_extract/pyrite = 1,
		/obj/item/slime_extract/red = 2,
		/obj/item/slime_extract/green = 2,
		/obj/item/slime_extract/pink = 2,
		/obj/item/slime_extract/gold = 2)

/datum/experiment/scanning/points/slime/expert
	name = "专家级史莱姆调查"
	description = "星际异种生物学会目前正在寻找最复杂史莱姆核心的样本， \
		我们委托你的空间站为他们提供所需的一切。"
	required_points = 10
	required_atoms = list(/obj/item/slime_extract/adamantine = 1,
		/obj/item/slime_extract/oil = 1,
		/obj/item/slime_extract/black = 1,
		/obj/item/slime_extract/lightpink = 1,
		/obj/item/slime_extract/rainbow = 10)

/datum/experiment/scanning/random/cytology/easy
	name = "基础细胞学扫描实验"
	description = "一位科学家需要害虫来做实验，用细胞学设备培育一些这种简单的小生物吧！"
	total_requirement = 3
	max_requirement_per_type = 2
	possible_types = list(/mob/living/basic/cockroach, /mob/living/basic/mouse, /mob/living/basic/snail)

/datum/experiment/scanning/random/cytology/medium
	name = "高级细胞学扫描实验"
	description = "我们需要了解身体从最早期阶段是如何运作的。一些细胞学实验能帮我们获得这种认识。"
	total_requirement = 3
	max_requirement_per_type = 2
	possible_types = list(
		/mob/living/basic/pet/cat,
		/mob/living/basic/carp,
		/mob/living/basic/chicken,
		/mob/living/basic/cow,
		/mob/living/basic/pet/dog/corgi,
		/mob/living/basic/snake,
	)

/datum/experiment/scanning/random/cytology/medium/one
	name = "高级细胞学扫描实验 一"

/datum/experiment/scanning/random/cytology/medium/two
	name = "高级细胞学扫描实验 二"

/datum/experiment/scanning/random/janitor_trash
	name = "空间站卫生检查"
	description = "要学会清洁，首先得了解何谓污秽。我们需要你扫描空间站周围的一些污物。"
	possible_types = list(/obj/effect/decal/cleanable/vomit,
	/obj/effect/decal/cleanable/blood)
	total_requirement = 3

/datum/experiment/ordnance/explosive/lowyieldbomb
	name = "低当量炸药"
	description = "低当量炸药或许对我们的资产保护团队有用。用多普勒阵列记录一次小型爆炸，并把数据发表成论文。"
	gain = list(10,15,20)
	target_amount = list(5,10,20)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = FALSE
	allow_any_source = TRUE

/datum/experiment/ordnance/explosive/highyieldbomb
	name = "高当量炸药"
	description =  "有些反应会释放极大的能量，可用于制造更大的炸药。用多普勒阵列记录任意气罐爆炸，并把数据发表成论文。任何气体反应均可。"
	gain = list(10,50,100)
	target_amount = list(50,100,300)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = FALSE

/datum/experiment/ordnance/explosive/hydrogenbomb
	name = "氢气炸药"
	description = "氢气及其衍生物的燃烧可以非常猛烈。用多普勒阵列记录任意气罐爆炸，并把数据发表成论文。只允许氢气火或氚气火。"
	gain = list(15,40,60)
	target_amount = list(50,75,150)
	experiment_proper = TRUE
	sanitized_misc = TRUE
	sanitized_reactions = TRUE
	require_all = FALSE
	required_reactions = list(/datum/gas_reaction/h2fire, /datum/gas_reaction/tritfire)

/datum/experiment/ordnance/explosive/nobliumbomb
	name = "惰性气体炸药"
	description = "超惰性气体的生成过程能量极高，可用于炸药。用多普勒阵列记录任意气罐爆炸，并把数据发表成论文。只允许超惰性气体冷凝反应。"
	gain = list(15,60,120)
	target_amount = list(50,100,300)
	experiment_proper = TRUE
	sanitized_misc = TRUE
	sanitized_reactions = TRUE
	required_reactions = list(/datum/gas_reaction/nobliumformation)

/datum/experiment/ordnance/explosive/pressurebomb
	name = "无反应炸药"
	description = "比热容高的气体能加热比热容低的气体，从而产生巨大压力。用多普勒阵列记录任意气罐爆炸，并把数据发表成论文。不允许任何气体反应。"
	gain = list(10,50,100)
	target_amount = list(20,50,100)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = TRUE

/datum/experiment/ordnance/gaseous/nitrous_oxide
	name = "一氧化二氮气体弹"
	description = "将一氧化二氮投放至行动区域或许很有用。把指定气体装入气罐，再用气罐压缩机将其爆开。把数据发表成论文。"
	gain = list(10,40)
	target_amount = list(200,600)
	experiment_proper = TRUE
	required_gas = /datum/gas/nitrous_oxide

/datum/experiment/ordnance/gaseous/plasma
	name = "等离子气体弹"
	description = "将等离子气体投放至行动区域或许很有用。把指定气体装入气罐，再用气罐压缩机将其爆开。把数据发表成论文。"
	gain = list(10,40)
	target_amount = list(200,600)
	experiment_proper = TRUE
	required_gas = /datum/gas/plasma

/datum/experiment/ordnance/gaseous/bz
	name = "BZ 气体弹"
	description = "将 BZ 气体投放至行动区域或许很有用。把指定气体装入气罐，再用气罐压缩机将其爆开。把数据发表成论文。"
	gain = list(10,30,60)
	target_amount = list(50,125,400)
	experiment_proper = TRUE
	required_gas = /datum/gas/bz

/datum/experiment/ordnance/gaseous/noblium
	name = "超惰性气体弹"
	description = "将超惰性气体投放至行动区域或许很有用。把指定气体装入气罐，再用气罐压缩机将其爆开。把数据发表成论文。"
	gain = list(10,40,80)
	target_amount = list(15,55,250)
	experiment_proper = TRUE
	required_gas = /datum/gas/hypernoblium

/datum/experiment/scanning/random/material/meat
	name = "生物材料扫描实验"
	description = "他们说过我们没法用世上所有材料做椅子。你就是来证明那些唱反调的人错了。"
	possible_material_types = list(/datum/material/meat)

/datum/experiment/scanning/random/material/easy
	name = "低等级材料扫描实验"
	description = "材料科学的核心在于对宇宙及其构成的基本理解。为此，先做点基础的东西，我们来教你怎么把它弄坏。"
	total_requirement = 6
	possible_types = list(/obj/structure/chair, /obj/structure/toilet, /obj/structure/table)
	possible_material_types = list(/datum/material/iron, /datum/material/glass)

/datum/experiment/scanning/random/material/medium
	name = "中等级材料扫描实验"
	description = "并非所有材料都足够坚固，能撑起一座空间站。以这些材料为例，看看它们为何适用于我们的电子设备与装备。"
	possible_material_types = list(/datum/material/silver, /datum/material/gold, /datum/material/plastic, /datum/material/titanium)

/datum/experiment/scanning/random/material/medium/one
	name = "中等级材料扫描实验 一"

/datum/experiment/scanning/random/material/medium/two
	name = "中等级材料扫描实验 二"

/datum/experiment/scanning/random/material/medium/three
	name = "中等级材料扫描实验 三"

/datum/experiment/scanning/random/material/hard
	name = "高等级材料扫描实验"
	description = "纳米传讯不惜成本，连最昂贵的材料也要测试其作为建材的品质。去给我们造一些这种奇特造物，并收集数据。"
	possible_material_types = list(/datum/material/diamond, /datum/material/plasma, /datum/material/uranium)

/datum/experiment/scanning/random/material/hard/one
	name = "高等级材料扫描实验 一"

/datum/experiment/scanning/random/material/hard/two
	name = "高等级材料扫描实验 二"

/datum/experiment/scanning/random/material/hard/three
	name = "高等级材料扫描实验 三"

/datum/experiment/scanning/random/plants/wild
	name = "野生生物质突变样本"
	description = "由于种种原因（太阳射线、只以不稳定突变原为食、熵增），不稳定性较低的植物有时也会在收获时突变。替我们扫描一份这样的样本。"
	performance_hint = "记录显示，“野生”突变会在不稳定性超过 30 点时发生，而物种突变则在超过 60 点时发生。"
	total_requirement = 1

/datum/experiment/scanning/random/plants/traits
	name = "独特生物质突变样本"
	description = "我们中央指挥部正在寻找具有独特性质的稀有异域植物，好在股东面前炫耀。目前我们需要的是一份带有非常特定基因的样本。"
	performance_hint = "空间站上的植物种类繁多，各自携带不同性状，有些还是其独有。去找找可能突变成我们所需目标的植物。"
	total_requirement = 3
	possible_plant_genes = list(/datum/plant_gene/trait/squash, /datum/plant_gene/trait/cell_charge, /datum/plant_gene/trait/glow/shadow, /datum/plant_gene/trait/teleport, /datum/plant_gene/trait/brewing, /datum/plant_gene/trait/juicing, /datum/plant_gene/trait/eyes, /datum/plant_gene/trait/sticky)

/datum/experiment/scanning/points/machinery_tiered_scan/tier2_lathes
	name = "高级标准部件基准测试"
	description = "我们新设计的高级机械部件需要实际应用测试，以寻找进一步改进的线索，同时也顺便确认我们没把部件设计得更糟。"
	required_points = 6
	required_atoms = list(
		/obj/machinery/rnd/production/protolathe/department/science = 1,
		/obj/machinery/rnd/production/protolathe/department/engineering = 1,
		/obj/machinery/rnd/production/techfab/department/cargo = 1,
		/obj/machinery/rnd/production/techfab/department/medical = 1,
		/obj/machinery/rnd/production/techfab/department/security = 1,
		/obj/machinery/rnd/production/techfab/department/service = 1
	)
	required_tier = 2

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_bluespacemachines
	name = "蓝空间机械调谐"
	description = "利用蓝空间能力的传送技术是我们公司的一大卖点，但我们没料到校准流程中会出现严重故障的威胁。既然我们的研发部门已经引发了一场蝇人种族骚乱，也许你们在标准部件上的进展能帮助缓解这个嗡嗡作响的问题。"
	required_points = 4
	required_atoms = list(
		/obj/machinery/teleport/hub = 1,
		/obj/machinery/teleport/station = 1
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_variety
	name = "高效部件应用测试"
	description = "我们需要对标准部件设计进行进一步测试，以把其效率和市场价格推得更高。"
	required_points = 15
	required_atoms = list(
		/obj/machinery/autolathe = 1,
		/obj/machinery/rnd/production/circuit_imprinter/department/science = 1,
		/obj/machinery/monkey_recycler = 1,
		/obj/machinery/processor/slime = 1,
		/obj/machinery/processor = 2,
		/obj/machinery/reagentgrinder = 2,
		/obj/machinery/hydroponics = 2,
		/obj/machinery/biogenerator = 3,
		/obj/machinery/gibber = 3,
		/obj/machinery/chem_master = 3,
		/obj/machinery/cryo_cell = 3,
		/obj/machinery/harvester = 5,
		/obj/machinery/quantumpad = 5
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_mechbay
	name = "军用级机甲库配置"
	description = "制造战斗用途的外骨骼是一笔昂贵投入。确保你有一套高效的生产配置，我们就寄一些设计文件给你。"
	required_points = 6
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/mech_bay_recharge_port = 1,
		/obj/machinery/recharge_station = 1
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_microlaser
	name = "高功率微型激光器校准"
	description = "我们的纳米传讯高功率办公级激光笔 ™ 还不够强，打不下空中的辛迪加无人机。给我们找些二极管应用，好从中找到改进它们的线索！"
	required_points = 10
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/dna_scannernew = 1,
		/obj/machinery/microwave = 2,
		/obj/machinery/deepfryer = 2,
		/obj/machinery/chem_heater = 3,
		/obj/machinery/power/emitter = 3
	)
	required_stock_part = /obj/item/stock_parts/micro_laser/high

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_capacitors
	name = "高级电容器基准测试"
	description = "进一步提升全站设备的电容量，是通往被标记为“关键”的重要项目的下一步：以蓝空间约束核能驱动的电动轮椅。"
	required_points = 12
	required_atoms = list(
		/obj/machinery/recharge_station = 1,
		/obj/machinery/cell_charger = 1,
		/obj/machinery/mech_bay_recharge_port = 1,
		/obj/machinery/recharger = 2,
		/obj/machinery/power/smes = 2,
		/obj/machinery/chem_dispenser = 3,
		/obj/machinery/chem_dispenser/drinks = 3, /*actually having only the chem dispenser works for scanning soda/booze dispensers but im not quite sure how would i go about actually pointing that out w/o these two lines*/
		/obj/machinery/chem_dispenser/drinks/beer = 3
	)
	required_stock_part = /obj/item/stock_parts/capacitor/adv

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_scanmodules
	name = "高级扫描模块校准"
	description = "尽管我们空间站上的扫描模块显然没什么用处，我们仍希望你对其进行性能测试，以防我们哪天想出能把 6 个扫描模块塞进外骨骼的突破性方案。"
	required_points = 6
	required_atoms = list(
		/obj/machinery/dna_scannernew = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/medical_kiosk = 2,
		/obj/machinery/piratepad/civilian = 2,
	)
	required_stock_part = /obj/item/stock_parts/scanning_module/adv

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier3_cells
	name = "电池容量测试"
	description = "纳米传讯的新仓鼠动力发电阵列有两个大问题：产能过剩，以及动物权利联盟的活动人士因我们用浩克基因改造仓鼠而发起的激烈抗议。后者就交给我们来处理吧！"
	required_points = 8
	required_atoms = list(
		/obj/machinery/recharge_station = 1,
		/obj/machinery/chem_dispenser = 1,
		/obj/machinery/chem_dispenser/drinks = 1,
		/obj/machinery/chem_dispenser/drinks/beer = 1,
		/obj/machinery/power/smes = 2
	)
	required_stock_part = /obj/item/stock_parts/power_store/cell/hyper

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier3_microlaser
	name = "超高功率微型激光器校准"
	description = "我们即将凭借精确到能在葡萄上做手术的激光工具，超越过去的外科医生。帮我们把二极管微调到完美吧！"
	required_points = 10
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/microwave = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/atmospherics/components/unary/thermomachine/freezer = 2,
		/obj/machinery/power/emitter = 2,
		/obj/machinery/chem_heater = 2,
		/obj/machinery/chem_mass_spec = 3
	)
	required_stock_part = /obj/item/stock_parts/micro_laser/ultra

/datum/experiment/scanning/random/mecha_damage_scan
	name = "外骨骼材料：应力失效测试"
	description = "你们的外骨骼制造机可以小规模快速生产，但造出部件的结构强度不如更传统的方式。"
	exp_tag = "扫描"
	total_requirement = 2
	possible_types = list(/obj/vehicle/sealed/mecha)
	///Damage percent that each mech needs to be at for a scan to work.
	var/damage_percent

/datum/experiment/scanning/random/mecha_equipped_scan
	name = "外骨骼材料：负载应变测试"
	description = "外骨骼装备会对载具结构施加独特的应力。扫描你用外骨骼制造机装配并全副武装的外骨骼，以加速我们的结构应力模拟。"
	possible_types = list(/obj/vehicle/sealed/mecha)
	total_requirement = 1

/// Scan a person with any mutation
/datum/experiment/scanning/people/mutant
	name = "人体实地研究：基因突变"
	description = "我们的新研究助理为了科学一直在喝各种乱七八糟的化学品，结果其中一人掌握了念力，另一人开始从眼睛里射出激光。这对我们的研究可能有用。让助理喝下不稳定突变原，重复这项实验，扫描他们并报告结果。"
	performance_hint = "扫描一名带有随机突变的人。"
	required_traits_desc = "随机突变"

/datum/experiment/scanning/people/mutant/is_valid_scan_target(mob/living/carbon/human/check, datum/component/experiment_handler/experiment_handler)
	. = ..()
	if (!.)
		return
	if(!LAZYLEN(check.dna.mutations))
		return FALSE
	return TRUE

/// Scan for organs you didn't start the round with
/datum/experiment/scanning/people/novel_organs
	name = "人体实地研究：分化生物学"
	description = "我们需要关于物种间有机兼容性的数据。扫描一些拥有人形生物通常不具备的器官的样本。 \
		机械器官的数据对我们毫无用处。"
	performance_hint = "异常器官可以通过移植、基因注入手动引入，或者借由生物扰乱异常效应极快地产生。"
	required_traits_desc = "其物种通常不具备的非合成器官"
	/// Disallow prosthetic organs
	var/organic_only = TRUE

/datum/experiment/scanning/people/novel_organs/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return
	// Organs which are valid for get_mutant_organ_type_for_slot
	var/static/list/vital_organ_slots = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_APPENDIX,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

	for (var/obj/item/organ/organ as anything in check.organs)
		if (organic_only && !IS_ORGANIC_ORGAN(organ))
			continue
		var/datum/species/target_species = check.dna.species
		if (organ.slot in vital_organ_slots)
			if (organ.type == target_species.get_mutant_organ_type_for_slot(organ.slot))
				continue
		else
			if ((organ.type in target_species.mutant_organs))
				continue
		return TRUE
	return FALSE

/// Scan for cybernetic organs
/datum/experiment/scanning/people/augmented_organs
	name = "人体实地研究：强化器官"
	description = "我们需要收集关于控制论重要器官如何与人体生物学结合的数据。扫描一名植入这些器官的人，帮助我们了解其兼容性。"
	performance_hint = "实施器官操纵手术，把其中一个重要器官替换为控制论版本。"
	required_traits_desc = "强化重要器官"
	required_count = 1

/datum/experiment/scanning/people/augmented_organs/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return
	var/static/list/vital_organ_slots = list(
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

	for (var/obj/item/organ/organ as anything in check.organs)
		if ((organ.slot in vital_organ_slots) && IS_ROBOTIC_ORGAN(organ))
			return TRUE
	return FALSE

/// Scan for skillchips
/datum/experiment/scanning/people/skillchip
	name = "人体实地研究：技能芯片植入体"
	description = "在把编程电路塞进人脑之前，我们需要了解大脑如何处理简单的电路。扫描一名脑内植有技能芯片的活人。"
	performance_hint = "使用技能站进行技能芯片植入。"
	required_traits_desc = "技能芯片植入体"

/datum/experiment/scanning/people/skillchip/is_valid_scan_target(mob/living/carbon/human/check, datum/component/experiment_handler/experiment_handler)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/brain/scanned_brain = check.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (isnull(scanned_brain))
		experiment_handler.announce_message("受试者没有大脑！")
		return FALSE
	if (scanned_brain.get_used_skillchip_slots() == 0)
		experiment_handler.announce_message("未发现技能芯片！")
		return FALSE
	return TRUE

/// Scan an android
/datum/experiment/scanning/people/android
	name = "人体实地研究：全身强化"
	description = "对一名船员进行全身控制论强化，然后扫描他们，以测试其新获得的能力以及新的感觉与认知功能。"
	performance_hint = "通过一系列手术实现全身强化。"
	required_traits_desc = "完全强化的仿生人"
	required_count = 1

/datum/experiment/scanning/people/android/is_valid_scan_target(mob/living/carbon/human/check, datum/component/experiment_handler/experiment_handler)
	. = ..()
	if (!.)
		return
	if (length(check.get_missing_limbs()) > 1)
		return FALSE

	var/static/list/augmented_organ_slots = list(
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

	// some species don't need a stomach, lungs, heart or liver. This is the case for androids, which are fully augged humies with a few extra quirks.
	var/organs_left_to_check = length(augmented_organ_slots)
	for(var/skip_organ_trait in list(TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_NOBLOOD, TRAIT_LIVERLESS_METABOLISM))
		if(HAS_TRAIT(check, skip_organ_trait))
			organs_left_to_check--

	for (var/obj/item/organ/organ as anything in check.organs)
		if (!(organ.slot in augmented_organ_slots))
			continue
		if (!IS_ROBOTIC_ORGAN(organ))
			return FALSE
		organs_left_to_check--

	if(organs_left_to_check > 0) //we're missing some organs like ears, eyes, liver etc.
		return FALSE

	for (var/obj/item/bodypart/bodypart as anything in check.get_bodyparts())
		if (!IS_ROBOTIC_LIMB(bodypart))
			return FALSE
	return TRUE

/datum/experiment/scanning/reagent/cryostylane
	name = "纯净低温苯扫描"
	description = "低温苯试剂似乎有可能中止人体内所有生理过程。制备纯度至少 99% 的低温苯，并扫描烧杯。"
	performance_hint = "在反应过程中尽可能保持高温。"
	required_reagent = /datum/reagent/cryostylane
	min_purity = 0.99

/datum/experiment/scanning/reagent/haloperidol
	name = "纯净氟哌啶醇扫描"
	description = "我们需要与慢性精神疾病长期治疗相关的测试。制备纯度至少 98% 的氟哌啶醇，并扫描烧杯。"
	performance_hint = "反应放热并消耗氢气。"
	required_reagent = /datum/reagent/medicine/haloperidol
	min_purity = 0.98

/datum/experiment/scanning/points/bluespace_crystal
	name = "蓝空间晶体采样"
	description = "通过扫描人造或天然生成的蓝空间晶体来研究其性质。这将帮助我们加深对蓝空间现象的理解。"
	required_points = 1
	required_atoms = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/sheet/bluespace_crystal = 1
	)

/datum/experiment/scanning/points/anomalies
	name = "已中和异常分析"
	description = "我们现在有能力处理异常了。用异常中和器将其中和，或在精炼厂精炼原始核心，然后扫描产物。"
	required_points = 4
	required_atoms = list(/obj/item/assembly/signaler/anomaly = 1)

/datum/experiment/scanning/points/machinery_tiered_scan/tier2_any
	name = "升级标准部件基准测试"
	description = "我们新设计的机械部件需要实际应用测试，以寻找进一步改进的线索，同时也顺便确认我们没把部件设计得更糟。扫描任意装有升级部件的机械，并报告结果。"
	required_points = 6
	required_atoms = list(
		/obj/machinery = 1
	)
	required_tier = 2

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_any
	name = "高级标准部件基准测试"
	description = "我们新设计的高级机械部件需要实际应用测试，以寻找进一步改进的线索，同时也顺便确认我们没把部件设计得更糟。扫描任意装有高级部件的机械，并报告结果。"
	required_points = 6
	required_atoms = list(
		/obj/machinery = 1
	)
	required_tier = 3
