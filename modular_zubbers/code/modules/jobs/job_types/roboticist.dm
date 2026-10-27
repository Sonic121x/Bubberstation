/datum/outfit/job/roboticist
	backpack = /obj/item/storage/backpack/science/robo
	satchel = /obj/item/storage/backpack/satchel/science/robo
	duffelbag = /obj/item/storage/backpack/duffelbag/science/robo

	glasses = /obj/item/clothing/glasses/hud/diagnostic
	gloves = /obj/item/clothing/gloves/color/black

	l_hand = /obj/item/storage/medkit/robotic_repair/preemo/stocked

/datum/job/roboticist
	description = "制造并维护半机械人、机甲与人工智能，为有需要的人打造 MOD 模块化外骨骼。还要设法提醒医疗部：\
	在处理合成人船员这方面，你其实比他们强得多。"
	required_languages = null
	akula_outfit = /datum/outfit/akula/scientist
	alt_titles = list(
		"Roboticist",
		"Biomechanical Engineer",
		"Cyberneticist",
		"Machinist",
		"Mechatronic Engineer",
		"Apprentice Roboticist",
	)

/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/clothing/head/utility/welding] = 1

/datum/job/roboticist/New()
	. = ..()

	mail_goodies += list(
		/obj/item/healthanalyzer/advanced = 15,
		/obj/item/screwdriver/power/science = 6,
		/obj/item/crowbar/power/science = 6,
		/obj/item/weldingtool/experimental = 2, // a lot rarer since its relatively powerful
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/storage/pill_bottle/liquid_solder = 6,
		/obj/item/storage/pill_bottle/system_cleaner = 6,
		/obj/item/storage/pill_bottle/nanite_slurry = 6,
		/obj/item/reagent_containers/spray/hercuri/chilled = 8,
		/obj/item/reagent_containers/spray/dinitrogen_plasmide = 8,
	)


/datum/outfit/job/roboticist/New()
	. = ..()

	LAZYINITLIST(backpack_contents)
	backpack_contents[/obj/item/paper/pamphlet/roboticist_reminder] = 1

/obj/item/paper/pamphlet/roboticist_reminder
	name = "合成人护理手册"
	default_raw_text = "你的职责包括处理站上的合成人与普罗蒂安生命体！这里有些入门小贴士……<hr><br> \n\
	你可以从自己的售货机购买<b>健康分析仪</b>，以及<b>烧伤治疗药剂</b>！一般来说，你会用到冷却液瓶。<br> \n\
	如果你对某种伤口感到困惑，记得<b>在手中使用健康分析仪</b>以开启<b>伤口模式</b>！<b>钝击伤</b>甚至会显示 \
	当前的治疗步骤！<br>\n\
	你的<b>部门订购控制台</b>里有合成人药物和普罗蒂安器官箱之类的东西！<br>\n\
	<b>肾上腺素笔</b>是治疗合成人切割/穿刺伤的有效手段！<br>\n\
	<b>纳米浆液</b>可治疗合成人轻微的<b>钝击</b>与<b>烧伤</b>伤害。 \
	过量阈值为<b>10u</b>。过量时会以过热与钝击伤害为代价，治疗合成人器官损伤。<br>\n\
	急救包里的<b>关键系统修复丸</b>可故意造成纳米浆液过量，每粒约可治疗<b>240 点器官损伤</b>。（你需要同时管好它们的钝击与烧伤！）<br>\n\
	<b>液态焊料</b>用于治疗<b>正电子损伤</b><br>\n\
	<b>系统清洁剂</b>用于治疗合成人的<b>毒素损伤</b><br>\n\
	<b>二氮等离子剂</b>可安全治疗合成人过热伤口。<br>\n\
	如果采矿部一直在收集资源，可以在机甲制造机处生产<b>空白合成人躯壳</b>用来练习。<br>\n\
	<b>油</b>相当于合成人的血液。可以从化学部获取，若你够机灵，也能从地板上舀。"
