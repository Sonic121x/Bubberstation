//Not to be confused with /obj/item/reagent_containers/cup/glass/bottle

/obj/item/reagent_containers/cup/bottle
	name = "小瓶"
	desc = "一个小瓶子。"
	icon_state = "bottle"
	fill_icon_state = "bottle"
	inhand_icon_state = "atoxinbottle"
	worn_icon_state = "bottle"
	obj_flags = UNIQUE_RENAME | RENAME_NO_DESC
	possible_transfer_amounts = list(5, 10, 15, 25, 50)
	volume = 50
	fill_icon_thresholds = list(0, 1, 20, 40, 60, 80, 100)
	can_lid = TRUE
	assembly_pixel_y = 4

/obj/item/reagent_containers/cup/bottle/Initialize(mapload)
	. = ..()
	if(!icon_state)
		icon_state = "bottle"
	update_appearance()

/obj/item/reagent_containers/cup/bottle/epinephrine
	name = "肾上腺素瓶"
	desc = "一个小瓶子。内含肾上腺素，用于稳定病人状况。"
	list_reagents = list(/datum/reagent/medicine/epinephrine = 30)

/obj/item/reagent_containers/cup/bottle/toxin
	name = "毒素瓶"
	desc = "一小瓶毒素。别喝，有毒。"
	list_reagents = list(/datum/reagent/toxin = 30)

/obj/item/reagent_containers/cup/bottle/cyanide
	name = "氰化物瓶"
	desc = "一小瓶氰化物。苦杏仁味？"
	list_reagents = list(/datum/reagent/toxin/cyanide = 30)

/obj/item/reagent_containers/cup/bottle/anacea
	name = "阿纳塞亚瓶"
	desc = "一小瓶阿纳塞亚。"
	list_reagents = list(/datum/reagent/toxin/anacea = 30)

/obj/item/reagent_containers/cup/bottle/spewium
	name = "喷吐素瓶"
	desc = "一小瓶喷吐素。"
	list_reagents = list(/datum/reagent/toxin/spewium = 30)

/obj/item/reagent_containers/cup/bottle/syndol
	name = "Syndol 瓶"
	desc = "一小瓶 Syndol。"
	list_reagents = list(/datum/reagent/drug/syndol = 30)

/obj/item/reagent_containers/cup/bottle/morphine
	name = "吗啡瓶"
	desc = "一小瓶吗啡。"
	icon = 'icons/obj/medical/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/morphine = 30)

/obj/item/reagent_containers/cup/bottle/chloralhydrate
	name = "水合氯醛瓶"
	desc = "一小瓶水合氯醛。米奇的最爱！"
	icon_state = "bottle20"
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 15)

/obj/item/reagent_containers/cup/bottle/mannitol
	name = "甘露醇瓶"
	desc = "一小瓶甘露醇。用于治疗脑损伤。"
	list_reagents = list(/datum/reagent/medicine/mannitol = 30)

/obj/item/reagent_containers/cup/bottle/multiver
	name = "穆尔提弗瓶"
	desc = "一小瓶穆尔提弗，可清除血液中的毒素及其他化学物质，但会导致呼吸急促。所有效果都会随患者体内试剂总量而增强。"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 30)

/obj/item/reagent_containers/cup/bottle/calomel
	name = "甘汞瓶"
	desc = "一小瓶甘汞，一种能迅速清除血液中化学物质的有毒药物。对伤势严重的人不会造成额外伤害。"
	list_reagents = list(/datum/reagent/medicine/calomel = 30)

/obj/item/reagent_containers/cup/bottle/phlogiston
	name = "燃素瓶"
	desc = "一小瓶燃素，使用后会让你烧起来。"
	list_reagents = list(/datum/reagent/phlogiston = 30)

/obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	name = "氨化汞瓶"
	desc = "能迅速清除体内的有毒化学物质。当对象状态良好、没有钝击伤和烧伤时，\
		可治疗毒素伤害。当对象带有钝击伤或烧伤时，它可能造成大量毒素伤害。 \
		当体内没有毒素时，它会开始缓慢地自我清除。"
	list_reagents = list(/datum/reagent/medicine/ammoniated_mercury = 30)

/obj/item/reagent_containers/cup/bottle/syriniver
	name = "赛林尼弗瓶"
	desc = "一小瓶赛林尼弗。"
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 30)

/obj/item/reagent_containers/cup/bottle/mutagen
	name = "不稳定诱变剂瓶"
	desc = "一小瓶不稳定诱变剂。会随机改变接触者的 DNA 结构。"
	list_reagents = list(/datum/reagent/toxin/mutagen = 30)

/obj/item/reagent_containers/cup/bottle/plasma
	name = "液态等离子体瓶"
	desc = "一小瓶液态等离子体。剧毒，并会与血液中的微生物发生反应。"
	list_reagents = list(/datum/reagent/toxin/plasma = 30)

/obj/item/reagent_containers/cup/bottle/synaptizine
	name = "突触嗪瓶"
	desc = "一小瓶突触嗪。"
	list_reagents = list(/datum/reagent/medicine/synaptizine = 30)

/obj/item/reagent_containers/cup/bottle/ammonia
	name = "氨水瓶"
	desc = "一小瓶氨水。"
	list_reagents = list(/datum/reagent/ammonia = 30)

/obj/item/reagent_containers/cup/bottle/diethylamine
	name = "Diethylamine 瓶"
	desc = "一小瓶 Diethylamine。"
	list_reagents = list(/datum/reagent/diethylamine = 30)

/obj/item/reagent_containers/cup/bottle/facid
	name = "氟硫酸瓶"
	desc = "一个小瓶子。内含少量氟硫酸。"
	list_reagents = list(/datum/reagent/toxin/acid/fluacid = 30)

/obj/item/reagent_containers/cup/bottle/adminordrazine
	name = "Adminordrazine 瓶"
	desc = "一个小瓶子。内含众神的液态精华。"
	icon = 'icons/obj/drinks/bottles.dmi'
	icon_state = "holyflask"
	worn_icon_state = "holyflask"
	inhand_icon_state = "holyflask"
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 30)

/obj/item/reagent_containers/cup/bottle/capsaicin
	name = "辣椒素瓶"
	desc = "一个小瓶子。内含辣酱。"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 30)

/obj/item/reagent_containers/cup/bottle/frostoil
	name = "冰霜油瓶"
	desc = "一个小瓶子。内含冰酱。"
	list_reagents = list(/datum/reagent/consumable/frostoil = 30)

/obj/item/reagent_containers/cup/bottle/strange_reagent
	name = "奇异试剂瓶"
	desc = "一个小瓶子。可用于复活死者。"
	list_reagents = list(/datum/reagent/medicine/strange_reagent = 30)

/obj/item/reagent_containers/cup/bottle/fishy_reagent
	name = "鱼类试剂瓶"
	desc = "一个小瓶子。可用于复活鱼类。"
	list_reagents = list(/datum/reagent/medicine/strange_reagent/fishy_reagent = 30)

/obj/item/reagent_containers/cup/bottle/traitor
	name = "辛迪加瓶"
	desc = "一个小瓶子。内含某种随机的恶心化学品。"
	icon = 'icons/obj/medical/chemical.dmi'
	var/extra_reagent = null

/obj/item/reagent_containers/cup/bottle/traitor/Initialize(mapload)
	. = ..()
	extra_reagent = pick(/datum/reagent/toxin/polonium, /datum/reagent/toxin/histamine, /datum/reagent/toxin/formaldehyde, /datum/reagent/toxin/venom, /datum/reagent/toxin/fentanyl, /datum/reagent/toxin/cyanide)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/reagent_containers/cup/bottle/polonium
	name = "钋瓶"
	desc = "一个小瓶子。内含钋。"
	list_reagents = list(/datum/reagent/toxin/polonium = 30)

/obj/item/reagent_containers/cup/bottle/magillitis
	name = "Magillitis 瓶"
	desc = "一个小瓶子。内含一种只被称为“Magillitis”的血清。"
	list_reagents = list(/datum/reagent/magillitis = 5)

/obj/item/reagent_containers/cup/bottle/venom
	name = "毒液瓶"
	desc = "一个小瓶子。内含毒液。"
	list_reagents = list(/datum/reagent/toxin/venom = 30)

/obj/item/reagent_containers/cup/bottle/fentanyl
	name = "芬太尼瓶"
	desc = "一个小瓶子。内含芬太尼。"
	list_reagents = list(/datum/reagent/toxin/fentanyl = 30)

/obj/item/reagent_containers/cup/bottle/formaldehyde
	name = "甲醛瓶"
	desc = "一个小瓶子。内含甲醛，一种能防止器官腐烂的化学物质。"
	list_reagents = list(/datum/reagent/toxin/formaldehyde = 30)

/obj/item/reagent_containers/cup/bottle/initropidril
	name = "伊尼托匹德瓶"
	desc = "一个小瓶子。内含伊尼托匹德。"
	list_reagents = list(/datum/reagent/toxin/initropidril = 30)

/obj/item/reagent_containers/cup/bottle/pancuronium
	name = "泮库溴铵瓶"
	desc = "一个小瓶子。内含泮库溴铵。"
	list_reagents = list(/datum/reagent/toxin/pancuronium = 30)

/obj/item/reagent_containers/cup/bottle/sodium_thiopental
	name = "硫喷妥钠瓶"
	desc = "一个小瓶子。内含硫喷妥钠。"
	list_reagents = list(/datum/reagent/toxin/sodium_thiopental = 30)

/obj/item/reagent_containers/cup/bottle/coniine
	name = "毒芹碱瓶"
	desc = "一个小瓶子。内含毒芹碱。"
	list_reagents = list(/datum/reagent/toxin/coniine = 30)

/obj/item/reagent_containers/cup/bottle/curare
	name = "箭毒瓶"
	desc = "一个小瓶子。内含箭毒。"
	list_reagents = list(/datum/reagent/toxin/curare = 30)

/obj/item/reagent_containers/cup/bottle/amanitin
	name = "鹅膏蕈碱瓶"
	desc = "一个小瓶子。内含鹅膏蕈碱。"
	list_reagents = list(/datum/reagent/toxin/amanitin = 30)

/obj/item/reagent_containers/cup/bottle/histamine
	name = "组胺瓶"
	desc = "一个小瓶子。内含组胺。"
	list_reagents = list(/datum/reagent/toxin/histamine = 30)

/obj/item/reagent_containers/cup/bottle/carnivorous_blood
	name = "食血生物剂瓶"
	desc = "一个小瓶子。内含食血生物剂。"
	list_reagents = list(/datum/reagent/toxin/carnivorousblood = 30)

/obj/item/reagent_containers/cup/bottle/diphenhydramine
	name = "抗组胺药瓶"
	desc = "一小瓶苯海拉明。"
	list_reagents = list(/datum/reagent/medicine/diphenhydramine = 30)

/obj/item/reagent_containers/cup/bottle/potass_iodide
	name = "抗辐射药瓶"
	desc = "一小瓶碘化钾。"
	list_reagents = list(/datum/reagent/medicine/potass_iodide = 30)

/obj/item/reagent_containers/cup/bottle/salglu_solution
	name = "葡萄糖盐水瓶"
	desc = "一小瓶葡萄糖盐水。"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 30)

/obj/item/reagent_containers/cup/bottle/atropine
	name = "阿托品瓶"
	desc = "一小瓶阿托品。"
	list_reagents = list(/datum/reagent/medicine/atropine = 30)

/obj/item/reagent_containers/cup/bottle/random_buffer
	name = "缓冲液瓶"
	desc = "一小瓶化学缓冲液。"

/obj/item/reagent_containers/cup/bottle/random_buffer/Initialize(mapload)
	. = ..()
	if(prob(50))
		name = "强酸性缓冲液瓶"
		desc = "一小瓶强酸性缓冲液。"
		reagents.add_reagent(/datum/reagent/reaction_agent/acidic_buffer, 30)
	else
		name = "强碱性缓冲液瓶"
		desc = "一小瓶强碱性缓冲液。"
		reagents.add_reagent(/datum/reagent/reaction_agent/basic_buffer, 30)

/obj/item/reagent_containers/cup/bottle/acidic_buffer
	name = "强酸性缓冲液瓶"
	desc = "一小瓶强酸性缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/acidic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/basic_buffer
	name = "强碱性缓冲液瓶"
	desc = "一小瓶强碱性缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/basic_buffer = 30)

/obj/item/reagent_containers/cup/bottle/inversing_buffer
	name = "手性反转缓冲液瓶"
	desc = "一小瓶手性反转缓冲液。"
	list_reagents = list(/datum/reagent/reaction_agent/inversing_buffer = 30)

/obj/item/reagent_containers/cup/bottle/romerol
	name = "罗梅罗尔瓶"
	desc = "一小瓶罗梅罗尔。货真价实的僵尸粉。"
	list_reagents = list(/datum/reagent/romerol = 30)

/obj/item/reagent_containers/cup/bottle/moltobeso
	name = "Molt'Obeso 酱瓶"
	desc = "辛迪加烹饪专家推出的革命性新酱料，旨在瞬间重塑你的身材！ \
			这款产品之所以有效，关键在于其独特配方：它精心挑选原料，以刺激食欲并增强热量吸收。"
	list_reagents = list(/datum/reagent/consumable/moltobeso = 50)

/obj/item/reagent_containers/cup/bottle/random_virus
	name = "实验性疾病培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的未测试病毒培养物。"
	spawned_disease = /datum/disease/advance/random

/obj/item/reagent_containers/cup/bottle/pierrot_throat
	name = "皮埃罗之喉培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的 H0NI<42 病毒颗粒培养物。"
	spawned_disease = /datum/disease/pierrot_throat

/obj/item/reagent_containers/cup/bottle/cold
	name = "鼻病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的 XY 鼻病毒培养物。"
	spawned_disease = /datum/disease/advance/cold

/obj/item/reagent_containers/cup/bottle/flu_virion
	name = "流感病毒颗粒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的 H13N1 流感病毒颗粒培养物。"
	spawned_disease = /datum/disease/advance/flu

/obj/item/reagent_containers/cup/bottle/retrovirus
	name = "逆转录病毒培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的逆转录病毒培养物。"
	spawned_disease = /datum/disease/dna_retrovirus

/obj/item/reagent_containers/cup/bottle/gbs
	name = "GBS 培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的重力动能双势 SADS+ 培养物。"//Or simply - General BullShit
	amount_per_transfer_from_this = 5
	spawned_disease = /datum/disease/gbs

/obj/item/reagent_containers/cup/bottle/fake_gbs
	name = "GBS 培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的重力动能双势 SADS- 培养物。"//Or simply - General BullShit
	spawned_disease = /datum/disease/fake_gbs

/obj/item/reagent_containers/cup/bottle/brainrot
	name = "脑腐病培养瓶"
	desc = "一个小瓶子。内含培养于合成血液培养基中的宇宙隐球菌培养物。"
	icon_state = "bottle3"
	spawned_disease = /datum/disease/brainrot

/obj/item/reagent_containers/cup/bottle/magnitis
	name = "磁化症培养瓶"
	desc = "一个小瓶子。内含少量离奇神迹菌。"
	spawned_disease = /datum/disease/magnitis

/obj/item/reagent_containers/cup/bottle/wizarditis
	name = "巫师症培养瓶"
	desc = "一个小瓶子。内含一份寻常灵思风病毒样本。"
	spawned_disease = /datum/disease/wizarditis

/obj/item/reagent_containers/cup/bottle/anxiety
	name = "严重焦虑培养瓶"
	desc = "一个小瓶子。内含一份鳞翅目杀虫剂样本。"
	spawned_disease = /datum/disease/anxiety

/obj/item/reagent_containers/cup/bottle/beesease
	name = "蜂患培养瓶"
	desc = "一个小瓶子。内含一份侵袭性蜜蜂科样本。"
	spawned_disease = /datum/disease/beesease

/obj/item/reagent_containers/cup/bottle/fluspanish
	name = "西班牙宗教裁判流感培养瓶"
	desc = "一个小瓶子。内含一份 1nqu1s1t10n 病毒样本。"
	spawned_disease = /datum/disease/fluspanish

/obj/item/reagent_containers/cup/bottle/tuberculosis
	name = "真菌性结核病培养瓶"
	desc = "一个小瓶子。内含一份真菌性结核杆菌样本。"
	spawned_disease = /datum/disease/tuberculosis

/obj/item/reagent_containers/cup/bottle/tuberculosiscure
	name = "BVAK 瓶"
	desc = "一个小瓶子，内装生物病毒解毒套装。"
	list_reagents = list(/datum/reagent/vaccine/fungal_tb = 30)

//Oldstation.dmm chemical storage bottles

/obj/item/reagent_containers/cup/bottle/hydrogen
	name = "氢气瓶"
	list_reagents = list(/datum/reagent/hydrogen = 30)

/obj/item/reagent_containers/cup/bottle/lithium
	name = "锂瓶"
	list_reagents = list(/datum/reagent/lithium = 30)

/obj/item/reagent_containers/cup/bottle/carbon
	name = "碳瓶"
	list_reagents = list(/datum/reagent/carbon = 30)

/obj/item/reagent_containers/cup/bottle/nitrogen
	name = "氮气瓶"
	list_reagents = list(/datum/reagent/nitrogen = 30)

/obj/item/reagent_containers/cup/bottle/oxygen
	name = "氧气瓶"
	list_reagents = list(/datum/reagent/oxygen = 30)

/obj/item/reagent_containers/cup/bottle/fluorine
	name = "氟气瓶"
	list_reagents = list(/datum/reagent/fluorine = 30)

/obj/item/reagent_containers/cup/bottle/sodium
	name = "钠瓶"
	list_reagents = list(/datum/reagent/sodium = 30)

/obj/item/reagent_containers/cup/bottle/aluminium
	name = "铝瓶"
	list_reagents = list(/datum/reagent/aluminium = 30)

/obj/item/reagent_containers/cup/bottle/silicon
	name = "硅瓶"
	list_reagents = list(/datum/reagent/silicon = 30)

/obj/item/reagent_containers/cup/bottle/phosphorus
	name = "磷瓶"
	list_reagents = list(/datum/reagent/phosphorus = 30)

/obj/item/reagent_containers/cup/bottle/sulfur
	name = "硫黄瓶"
	list_reagents = list(/datum/reagent/sulfur = 30)

/obj/item/reagent_containers/cup/bottle/chlorine
	name = "氯气瓶"
	list_reagents = list(/datum/reagent/chlorine = 30)

/obj/item/reagent_containers/cup/bottle/potassium
	name = "钾瓶"
	list_reagents = list(/datum/reagent/potassium = 30)

/obj/item/reagent_containers/cup/bottle/iron
	name = "铁瓶"
	list_reagents = list(/datum/reagent/iron = 30)

/obj/item/reagent_containers/cup/bottle/copper
	name = "铜瓶"
	list_reagents = list(/datum/reagent/copper = 30)

/obj/item/reagent_containers/cup/bottle/mercury
	name = "水银瓶"
	list_reagents = list(/datum/reagent/mercury = 30)

/obj/item/reagent_containers/cup/bottle/radium
	name = "镭瓶"
	list_reagents = list(/datum/reagent/uranium/radium = 30)

/obj/item/reagent_containers/cup/bottle/water
	name = "水瓶"
	list_reagents = list(/datum/reagent/water = 30)

/obj/item/reagent_containers/cup/bottle/ethanol
	name = "乙醇瓶"
	list_reagents = list(/datum/reagent/consumable/ethanol = 30)

/obj/item/reagent_containers/cup/bottle/sugar
	name = "糖瓶"
	list_reagents = list(/datum/reagent/consumable/sugar = 30)

/obj/item/reagent_containers/cup/bottle/sacid
	name = "硫酸瓶"
	list_reagents = list(/datum/reagent/toxin/acid = 30)

/obj/item/reagent_containers/cup/bottle/welding_fuel
	name = "焊接燃料瓶"
	list_reagents = list(/datum/reagent/fuel = 30)

/obj/item/reagent_containers/cup/bottle/silver
	name = "银瓶"
	list_reagents = list(/datum/reagent/silver = 30)

/obj/item/reagent_containers/cup/bottle/iodine
	name = "碘瓶"
	list_reagents = list(/datum/reagent/iodine = 30)

/obj/item/reagent_containers/cup/bottle/bromine
	name = "溴瓶"
	list_reagents = list(/datum/reagent/bromine = 30)

/obj/item/reagent_containers/cup/bottle/thermite
	name = "铝热剂瓶"
	list_reagents = list(/datum/reagent/thermite = 50)

// Bottles for mail goodies.

/obj/item/reagent_containers/cup/bottle/clownstears
	name = "蒸馏小丑之苦瓶"
	desc = "一个小瓶子。内含一种为卓越调酒师所用的神秘液体，取材于小丑的不幸。"
	list_reagents = list(/datum/reagent/consumable/nutriment/soup/clown_tears = 30)

/obj/item/reagent_containers/cup/bottle/saltpetre
	name = "硝石瓶"
	desc = "一个小瓶子。内含硝石。"
	list_reagents = list(/datum/reagent/saltpetre = 30)

/obj/item/reagent_containers/cup/bottle/flash_powder
	name = "闪光粉瓶"
	desc = "一个小瓶子。内含闪光粉。"
	list_reagents = list(/datum/reagent/flash_powder = 30)

/obj/item/reagent_containers/cup/bottle/exotic_stabilizer
	name = "异种稳定剂瓶"
	desc = "一个小瓶子。内含异种稳定剂。"
	list_reagents = list(/datum/reagent/exotic_stabilizer = 30)

/obj/item/reagent_containers/cup/bottle/leadacetate
	name = "醋酸铅瓶"
	desc = "一个小瓶子。内含醋酸铅。"
	list_reagents = list(/datum/reagent/toxin/leadacetate = 30)

/obj/item/reagent_containers/cup/bottle/caramel
	name = "焦糖瓶"
	desc = "一瓶焦糖化糖，也就是焦糖。别去舔它。"
	list_reagents = list(/datum/reagent/consumable/caramel = 30)

/*
 *	Syrup bottles, basically a unspillable cup that transfers reagents upon clicking on it with a cup
 */

/obj/item/reagent_containers/cup/bottle/syrup_bottle
	name = "糖浆瓶"
	desc = "带糖浆泵的瓶子，可以把美味液体直接泵进你的咖啡杯。"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "syrup"
	fill_icon_state = "syrup"
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100)
	possible_transfer_amounts = list(5, 10)
	amount_per_transfer_from_this = 5
	can_lid = FALSE
	custom_materials = list(/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/Initialize(mapload)
	. = ..()
	// this is not done via initial_reagent_flags because it represents state
	update_container_flags(SEALED_CONTAINER | TRANSPARENT)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/examine(mob/user)
	. = ..()
	. += span_notice("按住 Alt 点击可开合泵盖。")
	. += span_notice("用笔在上面书写可以重命名。")

/obj/item/reagent_containers/cup/bottle/syrup_bottle/add_context(atom/source, list/context, obj/item/held_item, mob/living/user)
	. = ..()

	context[SCREENTIP_CONTEXT_ALT_LMB] = (is_open_container() ? "装上泵盖" : "取下泵盖")
	if(IS_WRITING_UTENSIL(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "书写标签"
	else if(is_open_container() && held_item?.is_refillable())
		context[SCREENTIP_CONTEXT_LMB] = "使用糖浆泵"

	return CONTEXTUAL_SCREENTIP_SET

//when you attack the syrup bottle with a container it refills it
/obj/item/reagent_containers/cup/bottle/syrup_bottle/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(is_open_container() && tool.is_refillable())
		return refillable_act(user, tool)
	return ..()

/obj/item/reagent_containers/cup/bottle/syrup_bottle/nameformat(input, user)
	playsound(src, SFX_WRITING_PEN, 50, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT + 3, ignore_walls = FALSE)
	return "[input? "[input] " : null]瓶"


/obj/item/reagent_containers/cup/bottle/syrup_bottle/proc/refillable_act(mob/user, obj/item/tool)
	if(!reagents.total_volume)
		balloon_alert(user, "瓶子是空的！")
		return ITEM_INTERACT_BLOCKING
	if(tool.reagents.holder_full())
		balloon_alert(user, "容器已满！")
		return ITEM_INTERACT_BLOCKING

	var/transfer_amount = round(reagents.trans_to(tool, amount_per_transfer_from_this, transferred_by = user), CHEMICAL_VOLUME_ROUNDING)
	if(transfer_amount)
		balloon_alert(user, "已转移 [transfer_amount] 单位")
	flick("syrup_anim",src)
	tool.update_appearance()
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/reagent_containers/cup/bottle/syrup_bottle/update_icon_state()
	. = ..()
	if(is_open_container())
		icon_state = "syrup_open"
	else
		icon_state = "syrup"

/obj/item/reagent_containers/cup/bottle/syrup_bottle/click_alt(mob/user)
	if(is_open_container())
		balloon_alert(user, "已装上泵盖")
		update_container_flags(SEALED_CONTAINER | TRANSPARENT)
	else
		balloon_alert(user, "已取下泵盖")
		reset_container_flags()

	update_appearance()
	return CLICK_ACTION_SUCCESS

//types of syrups

/obj/item/reagent_containers/cup/bottle/syrup_bottle/caramel
	name = "焦糖糖浆瓶"
	desc = "一个泵瓶，内装焦糖化糖，也就是焦糖。别去舔它。"
	list_reagents = list(/datum/reagent/consumable/caramel = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/liqueur
	name = "咖啡利口酒糖浆瓶"
	desc = "一个泵瓶，内装墨西哥咖啡风味的利口酒糖浆。自 1936 年起生产，洪克。"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 50)

/obj/item/reagent_containers/cup/bottle/syrup_bottle/korta_nectar
	name = "科塔糖浆瓶"
	desc = "一个泵瓶，内装科塔糖浆。一种由甜科塔坚果压碎制成的甜蜜糖质。"
	list_reagents = list(/datum/reagent/consumable/korta_nectar = 50)

//secret syrup
/obj/item/reagent_containers/cup/bottle/syrup_bottle/laughsyrup
	name = "欢笑糖浆瓶"
	desc = "一个泵瓶，内装欢笑糖浆。由欢笑豆榨汁制成。带气泡，而且似乎会随着搭配的东西改变风味！"
	list_reagents = list(/datum/reagent/consumable/laughsyrup = 50)
