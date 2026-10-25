/datum/supply_pack/medical
	group = "Medical"
	access_view = ACCESS_MEDICAL
	crate_type = /obj/structure/closet/crate/medical/department

/datum/supply_pack/medical/bloodpacks
	name = "血液袋什锦箱"
	desc = "包含十种不同的血液袋，用于为患者补充血液。"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(
		/obj/item/reagent_containers/blood = 2,
		/obj/item/reagent_containers/blood/a_plus,
		/obj/item/reagent_containers/blood/a_minus,
		/obj/item/reagent_containers/blood/b_plus,
		/obj/item/reagent_containers/blood/b_minus,
		/obj/item/reagent_containers/blood/o_plus,
		/obj/item/reagent_containers/blood/o_minus,
		/obj/item/reagent_containers/blood/lizard,
		/obj/item/reagent_containers/blood/ethereal,
		/obj/item/paper/fluff/jobs/medical/blood_types,
	)
	crate_name = "血液冷冻箱"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/medical/medipen_variety
	name = "医疗注射笔什锦包"
	desc = "包含三种类型共八支不同的医疗注射笔， \
		用于快速救治重伤患者。"
	cost = CARGO_CRATE_VALUE * 3.5
	contains = list(/obj/item/reagent_containers/hypospray/medipen = 2,
					/obj/item/reagent_containers/hypospray/medipen/ekit = 3,
					/obj/item/reagent_containers/hypospray/medipen/blood_loss = 3)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest

/datum/supply_pack/medical/coroner_crate
	name = "尸检套件"
	desc = "包含一台尸检扫描仪，适用于你弄丢了自己的那台、又真的 \
		需要完成解剖实验的时候。"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(
		/obj/item/autopsy_scanner = 1,
		/obj/item/storage/medkit/coroner = 1,
	)
	crate_name = "尸检套件箱"

/datum/supply_pack/medical/chemical
	name = "化学入门套件箱"
	desc = "包含十三种不同的化学物质，够你做各种有趣的实验了。"
	cost = CARGO_CRATE_VALUE * 2.6
	contains = list(
		/obj/item/reagent_containers/cup/bottle/hydrogen,
		/obj/item/reagent_containers/cup/bottle/carbon,
		/obj/item/reagent_containers/cup/bottle/nitrogen,
		/obj/item/reagent_containers/cup/bottle/oxygen,
		/obj/item/reagent_containers/cup/bottle/fluorine,
		/obj/item/reagent_containers/cup/bottle/phosphorus,
		/obj/item/reagent_containers/cup/bottle/silicon,
		/obj/item/reagent_containers/cup/bottle/chlorine,
		/obj/item/reagent_containers/cup/bottle/radium,
		/obj/item/reagent_containers/cup/bottle/sacid,
		/obj/item/reagent_containers/cup/bottle/ethanol,
		/obj/item/reagent_containers/cup/bottle/potassium,
		/obj/item/reagent_containers/cup/bottle/sugar,
		/obj/item/clothing/glasses/science,
		/obj/item/reagent_containers/dropper,
		/obj/item/storage/box/beakers,
	)
	crate_name = "化学品箱"

/datum/supply_pack/medical/defibs
	name = "除颤器箱"
	desc = "包含两台除颤器，用于让刚去世的人重获生命。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/defibrillator/loaded = 2)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest

/datum/supply_pack/medical/iv_drip
	name = "输液架箱"
	desc = "包含一台输液架，用于为患者输注血液。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/machinery/iv_drip)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest

/datum/supply_pack/medical/supplies
	name = "医疗用品箱"
	desc = "包含随机搭配的医疗用品。不包含德国医生。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/obj/item/reagent_containers/cup/bottle/multiver,
		/obj/item/reagent_containers/cup/bottle/epinephrine,
		/obj/item/reagent_containers/cup/bottle/morphine,
		/obj/item/reagent_containers/cup/bottle/toxin,
		/obj/item/reagent_containers/cup/beaker/large,
		/obj/item/reagent_containers/applicator/pill/insulin,
		/obj/item/stack/medical/wrap/gauze,
		/obj/item/storage/box/bandages,
		/obj/item/storage/box/beakers,
		/obj/item/storage/box/medigels,
		/obj/item/storage/box/syringes,
		/obj/item/storage/box/bodybags,
		/obj/item/storage/medkit/regular,
		/obj/item/storage/medkit/o2,
		/obj/item/storage/medkit/toxin,
		/obj/item/storage/medkit/brute,
		/obj/item/storage/medkit/fire,
		/obj/item/defibrillator/loaded,
		/obj/item/reagent_containers/blood/o_minus,
		/obj/item/storage/pill_bottle/mining,
		/obj/item/reagent_containers/applicator/pill/neurine,
		/obj/item/stack/medical/bone_gel = 2,
		/obj/item/vending_refill/medical,
		/obj/item/vending_refill/drugs,
	)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest
	test_ignored = TRUE

/datum/supply_pack/medical/supplies/fill(obj/container)
	for(var/i in 1 to 10)
		var/item = pick(contains)
		new item(container)

/datum/supply_pack/medical/experimentalmedicine
	name = "实验性药物箱"
	desc = "一箱装有与遗传性流形病共存所需的药物——桑苏芬太尼。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/pill_bottle/sansufentanyl = 2)
	crate_name = null
	crate_type = /obj/structure/closet/crate/interdyne_normal

/datum/supply_pack/medical/surgery
	name = "手术用品箱"
	desc = "想动手术，却没有那种花里胡哨的 \
		学位？从这个装有德福雷斯特手术托盘、 \
		消毒灵喷雾和可折叠滚动床的箱子开始吧。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/surgery_tray/full,
		/obj/item/reagent_containers/medigel/sterilizine,
		/obj/item/emergency_bed,
	)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest

/datum/supply_pack/medical/salglucanister
	name = "重型生理盐水罐"
	desc = "包含一大罐浓缩的生理盐水-葡萄糖，够用好几天， \
		并配有一台大型泵可为容器加注。直接注射 \
		生理盐水应交给医疗专业人员，因为这台泵有可能使 \
		患者过量。"
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_MEDICAL
	contains = list(/obj/machinery/iv_drip/saline)
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/medical/virus
	name = "病毒箱"
	desc = "包含十二瓶用于病毒学研究的数种病毒样本。 \
		还附有七个烧杯和注射器。不包含团成一团的牛仔裤。"
	cost = CARGO_CRATE_VALUE * 5
	access = ACCESS_CMO
	access_view = ACCESS_VIROLOGY
	contains = list(
		/obj/item/reagent_containers/cup/bottle/flu_virion,
		/obj/item/reagent_containers/cup/bottle/cold,
		/obj/item/reagent_containers/cup/bottle/random_virus = 4,
		/obj/item/reagent_containers/cup/bottle/fake_gbs,
		/obj/item/reagent_containers/cup/bottle/magnitis,
		/obj/item/reagent_containers/cup/bottle/pierrot_throat,
		/obj/item/reagent_containers/cup/bottle/brainrot,
		/obj/item/reagent_containers/cup/bottle/anxiety,
		/obj/item/reagent_containers/cup/bottle/beesease,
		/obj/item/storage/box/syringes,
		/obj/item/storage/box/beakers,
		/obj/item/reagent_containers/cup/bottle/mutagen,
	)
	crate_name = "病毒箱"
	crate_type = /obj/structure/closet/crate/secure/plasma
	order_flags = ORDER_DANGEROUS

/datum/supply_pack/medical/cmoturtlenecks
	name = "首席医疗官高领衫"
	desc = "包含首席医疗官的高领衫与高领裙。"
	cost = CARGO_CRATE_VALUE * 2
	access = ACCESS_CMO
	contains = list(
		/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck,
		/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck/skirt,
	)

/datum/supply_pack/medical/arm_implants
	name = "强力手臂植入体套装"
	desc = "一箱包含两个植入体，可通过手术植入以增强人形手臂的力量。暴露于电磁脉冲下将导致保修失效。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/organ/cyberimp/arm/strongarm = 2)
	crate_name = "\improper 强力手臂植入体箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/medical/paperwork_implants
	name = "文书植入体套装"
	desc = "一箱包含两个植入体，可通过手术植入以提高船员处理文书工作的效率。暴露于电磁脉冲下将导致保修失效。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/organ/cyberimp/arm/toolkit/paperwork = 2)
	crate_name = "文书植入体箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/medical/lost_crew
	name = "回收的纳米传讯员工遗体"
	desc = "我们没有让他们复生的条件，能把他们送到你们那里吗？请将其复活并录用。 \
	这个价格是定金，等我们的员工复活一段时间后，我们会报销医疗预算。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/structure/closet/body_bag/lost_crew/with_body)
	crate_name = "遗体冷冻箱"
	crate_type = /obj/structure/closet/crate/secure/freezer

/datum/supply_pack/medical/organ_growing
	name = "器官培育套件"
	desc = "在家里培育器官所需的全部工具！除了能用组织样本培育标准器官外， \
	你还可能发现变异细胞，它们可以进一步增殖以培育出奇特的特性。"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(
		/obj/machinery/vatgrower/small/unanchored,
		/obj/item/biopsy_tool/organ,
		/obj/item/storage/box/petridish,
		/obj/structure/microscope/unanchored,
		/obj/item/reagent_containers/cup/mortar,
		/obj/item/pestle,
	)
	crate_name = "器官培育套件"

/datum/supply_pack/medical/chiral_inversing_buffer
	name = "手性反转缓冲剂箱"
	desc = "一箱装有稀有的反转缓冲剂样本。 \
		在满足适当条件时，它可以将不纯的试剂转化为其反转对应物。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/reagent_containers/cup/bottle/inversing_buffer)
	crate_name = "手性反转缓冲剂箱"

/datum/supply_pack/medical/handheld_crew_monitor
	name = "手持船员监控器箱"
	desc = "包含三台手持船员监控器"
	cost = (CARGO_CRATE_VALUE * /obj/item/sensor_device::custom_premium_price * 3 * 0.8) / 280 // Bulk discount .8X base /tg/ vending machine value with the CARGO_CRATE_VALUE modifier
	contains = list(
		/obj/item/sensor_device,
		/obj/item/sensor_device,
		/obj/item/sensor_device,
	)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest

/datum/supply_pack/medical/first_aid_board
	name = "德福雷斯特急救站"
	desc = "一箱包含一块用于建造德福雷斯特急救站的电路板—— \
		一台用于治疗轻伤与小病的机器。不含其他组件。"
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/circuitboard/machine/wall_healer)
	crate_name = null
	crate_type = /obj/structure/closet/crate/deforest
