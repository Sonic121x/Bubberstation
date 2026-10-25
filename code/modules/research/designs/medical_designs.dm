/////////////////////////////////////////
////////////Medical Tools////////////////
/////////////////////////////////////////

/datum/design/healthanalyzer
	name = "健康分析仪"
	id = "healthanalyzer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/healthanalyzer
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/autopsy_scanner
	name = "尸检扫描仪"
	id = "autopsyscanner"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/autopsy_scanner
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/bluespacebeaker
	name = "蓝空间烧杯"
	desc = "一个蓝空间烧杯，由实验性蓝空间技术驱动，结合了古巴元素与皮特化合物。最多可容纳 300 单位。"
	id = "bluespacebeaker"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =HALF_SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	build_path = /obj/item/reagent_containers/cup/beaker/bluespace
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/noreactbeaker
	name = "低温休眠烧杯"
	desc = "一个低温休眠烧杯，可储存化学品而不发生反应。最多可容纳 50 单位。"
	id = "splitbeaker"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	build_path = /obj/item/reagent_containers/cup/beaker/noreact
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/xlarge_beaker
	name = "特大烧杯"
	id = "xlarge_beaker"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	build_path = /obj/item/reagent_containers/cup/beaker/plastic
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/organ_jar
	name = "器官罐"
	id = "organ_jar"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	build_path = /obj/item/reagent_containers/cup/beaker/organ_jar
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/meta_beaker
	name = "超材料烧杯"
	id = "meta_beaker"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/plastic =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	build_path = /obj/item/reagent_containers/cup/beaker/meta
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/ph_meter
	name = "化学分析仪"
	id = "ph_meter"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT*2.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ph_meter
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/bluespacesyringe
	name = "蓝空间注射器"
	desc = "一支可容纳 60 单位化学品的先进注射器。"
	id = "bluespacesyringe"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/reagent_containers/syringe/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/dna_disk
	name = "基因数据磁盘"
	desc = "用于制作更多储存基因数据的磁盘。"
	id = "dna_disk"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass =SMALL_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/disk/data
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/piercesyringe
	name = "穿甲注射器"
	desc = "一支金刚石针尖的注射器，高速发射时可穿透护甲。最多可容纳 10 单位。"
	id = "piercesyringe"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/syringe/piercing
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/inhaler
	name = "吸入器"
	desc = "一种小型装置，可短促喷出雾化化学品。需要装入气罐才能工作。"
	id = "inhaler"
	build_path = /obj/item/inhaler/medical
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT * 0.1)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/inhaler_canister
	name = "吸入器气罐"
	desc = "一只小型气罐，装满供吸入器使用的雾化试剂。"
	id = "inhaler_canister"
	build_path = /obj/item/reagent_containers/inhaler_canister
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 0.2)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/bluespacebodybag
	name = "蓝空间裹尸袋"
	desc = "一只由实验性蓝空间技术驱动的蓝空间裹尸袋。可装下大量尸体以及体型最大的生物。"
	id = "bluespacebodybag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SHEET_MATERIAL_AMOUNT, /datum/material/diamond =SMALL_MATERIAL_AMOUNT*5, /datum/material/bluespace =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/bodybag/bluespace
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/stasis_bag
	name = "停滞裹尸袋"
	desc = "一种一次性裹尸袋，用于在战场上稳定情况危急的患者。 \
		袋子本身无法长时间维持停滞状态，最终会散架。"
	id = "stasis_bodybag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/plastic = 10 * SHEET_MATERIAL_AMOUNT, // Very plastic expensive (but only because cloth cannot be put in the lathe)
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/bodybag/stasis
	category = list(RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/plasmarefiller
	name = "等离子人连体服补充装"
	desc = "一种用于等离子人套装自动灭火器的补充包。"
	id = "plasmarefiller" //Why did this have no plasmatech
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/extinguisher_refill
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS_EQUIPMENT
	)
	departmental_flags = ALL

/datum/design/crewpinpointer
	name = "船员定位仪"
	desc = "当目标套装传感器调至追踪信标时，可追踪其位置。"
	id = "crewpinpointer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/gold =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/pinpointer/crew
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/defibrillator_mount
	name = "除颤器壁挂架"
	desc = "用于安放除颤器的壁挂框架，取用方便又稳妥。"
	id = "defibmountdefault"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/wallframe/defib_mount
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/defibrillator_mount_charging
	name = "PENLITE 除颤器壁挂架"
	desc = "一款一体式除颤器壁挂框架，配有 ID 锁定夹与充电线缆。PENLITE 版本还能为除颤器电池缓慢充电。"
	id = "defibmount"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/wallframe/defib_mount/charging
	category = list(
		RND_CATEGORY_CONSTRUCTION + RND_SUBCATEGORY_CONSTRUCTION_MOUNTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/genescanner
	name = "基因序列扫描仪"
	desc = "一台便捷的手持分析仪，可快速判定突变并收集完整基因序列。"
	id = "genescanner"
	build_path = /obj/item/sequence_scanner
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GENETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/healthanalyzer_advanced
	name = "高级健康分析仪"
	desc = "一台手持身体扫描仪，能高精度分辨受试者的生命体征。"
	id = "healthanalyzer_advanced"
	build_path = /obj/item/healthanalyzer/advanced
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/glass = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/medigel
	name = "医疗凝胶"
	desc = "一瓶医疗凝胶涂抹瓶，专为精准涂抹设计，瓶盖可拧下。"
	id = "medigel"
	build_path = /obj/item/reagent_containers/medigel
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*1.25, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/surgical_drapes
	name = "手术铺巾"
	id = "surgical_drapes"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/surgical_drapes
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/datum/design/laserscalpel
	name = "激光手术刀"
	desc = "一把用于精确切割的激光手术刀。"
	id = "laserscalpel"
	build_path = /obj/item/scalpel/advanced
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*3, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/silver =SHEET_MATERIAL_AMOUNT, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/diamond =SMALL_MATERIAL_AMOUNT * 2, /datum/material/titanium = SHEET_MATERIAL_AMOUNT*2)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/mechanicalpinches
	name = "机械钳"
	desc = "这些钳子既可用作牵开器，也可用作止血钳。"
	id = "mechanicalpinches"
	build_path = /obj/item/retractor/advanced
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/searingtool
	name = "灼烧工具"
	desc = "用于把组织灼合在一起，或者把组织烧掉。"
	id = "searingtool"
	build_path = /obj/item/cautery/advanced
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*2, /datum/material/glass =SHEET_MATERIAL_AMOUNT, /datum/material/plasma =SHEET_MATERIAL_AMOUNT, /datum/material/uranium =SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/medical_spray_bottle
	name = "医用喷雾瓶"
	desc = "一只传统的喷雾瓶，可喷出细密水雾。别和医用喷雾剂搞混。"
	id = "med_spray_bottle"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/spray/medical
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/chem_pack
	name = "静脉药物袋"
	desc = "一只用于静脉给药的塑料加压袋。"
	id = "chem_pack"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/chem_pack
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/blood_pack
	name = "血袋"
	desc = "用于盛装输血用血液。必须连接到输液架上。"
	id = "blood_pack"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	materials = list(/datum/material/plastic =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/reagent_containers/blood
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/portable_chem_mixer
	name = "便携式化学混合器"
	desc = "一台可分配并混合化学品的便携设备。试剂需用烧杯提供。"
	id = "portable_chem_mixer"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	materials = list(/datum/material/plastic =SHEET_MATERIAL_AMOUNT * 2.5, /datum/material/iron = SHEET_MATERIAL_AMOUNT*5, /datum/material/glass =SHEET_MATERIAL_AMOUNT * 1.5)
	build_path = /obj/item/storage/portable_chem_mixer
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_CHEMISTRY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/medical_bed
	name = "医疗床"
	desc = "一张由无菌材料制成、非常适合医疗领域的床。无论是照顾病人还是推着兜风，它都能胜任！"
	id = "medicalbed"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.7, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.7)
	build_path = /obj/structure/bed/medical
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/emergency_bed
	name = "医疗床（应急）"
	desc = "医疗床的便携折叠版本。非常适合急救员，也适合应对大规模伤亡！"
	id = "medicalbed_emergency"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2.7, /datum/material/plastic = SHEET_MATERIAL_AMOUNT * 1.7)
	build_path = /obj/item/emergency_bed
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/penlight
	name = "笔灯"
	id = "penlight"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*0.5)
	build_path = /obj/item/flashlight/pen
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/penlight_paramedic
	name = "急救员笔灯"
	id = "penlight_paramedic"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass = SMALL_MATERIAL_AMOUNT)
	build_path = /obj/item/flashlight/pen/paramedic
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/flesh_reshapers
	name = "血肉重塑器"
	desc = "重塑那些外部特征！"
	id = "fleshreshaper"
	build_path = /obj/item/flesh_shears
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1, /datum/material/silver =SHEET_MATERIAL_AMOUNT * 1)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/flesh_reshapers/medical // slight variant with different color palette
	name = "医疗血肉重塑器"
	id = "fleshreshapermed"
	build_path = /obj/item/flesh_shears/medical
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/////////////////////////////////////////
//////////Cybernetic Implants////////////
/////////////////////////////////////////

/datum/design/cyberimp_breather
	name = "呼吸管植入体"
	desc = "这种简单的植入体在你的背部增加了一个内置气源接口，让你无需佩戴面具即可使用内置气源，并保护你免遭掐脖。"
	id = "ci-breather"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 3.5 SECONDS
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*6, /datum/material/glass = SMALL_MATERIAL_AMOUNT*2.5)
	build_path = /obj/item/organ/cyberimp/mouth/breathing_tube
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_surgical
	name = "手术臂植入体"
	desc = "一套隐藏在手臂暗格中的手术工具。"
	id = "ci-surgery"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	construction_time = 2 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/surgery
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_toolset
	name = "工具组臂植入体"
	desc = "精简版的工程半机械人工具组，设计用于安装在使用者手臂上。"
	id = "ci-toolset"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.25,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)
	construction_time = 2 SECONDS
	build_path = /obj/item/organ/cyberimp/arm/toolkit/toolset
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_medical_hud
	name = "医疗 HUD 植入体"
	desc = "这些义眼会在你看到的一切事物上显示医疗 HUD。扭动眼睛即可操控。"
	id = "ci-medhud"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/cyberimp/eyes/hud/medical
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_security_hud
	name = "安保 HUD 植入体"
	desc = "这些义眼会在你看到的一切事物上显示安保 HUD。扭动眼睛即可操控。"
	id = "ci-sechud"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*7.5,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*7.5,
	)
	build_path = /obj/item/organ/cyberimp/eyes/hud/security
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_diagnostic_hud
	name = "诊断 HUD 植入体"
	desc = "这些义眼会在你看到的一切事物上显示诊断 HUD。扭动眼睛即可操控。"
	id = "ci-diaghud"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*6,
	)
	build_path = /obj/item/organ/cyberimp/eyes/hud/diagnostic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_xray
	name = "X 光眼"
	desc = "这些义眼能赋予你 X 光视力。眨眼是徒劳的。"
	id = "ci-xray"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/eyes/robotic/xray
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_xray/moth
	name = "蛾人 X 光眼"
	id = "ci-xray-moth"
	build_path = /obj/item/organ/eyes/robotic/xray/moth

/datum/design/cyberimp_thermals
	name = "热成像眼"
	desc = "这些义眼能赋予你热成像视觉。还附带竖缝状瞳孔。"
	id = "ci-thermals"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/eyes/robotic/thermals
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_thermals/moth
	name = "蛾人热成像眼"
	id = "ci-thermals-moth"
	build_path = /obj/item/organ/eyes/robotic/thermals/moth

/datum/design/cyberimp_tacvisor
	name = "战术敌我识别目镜"
	desc = "一副带内置 LED 显示屏的酷炫敌我识别目镜。可能会严重过载使用者的前额叶皮层。"
	id = "ci-tacvisor"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 4,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/eyes/robotic/tacvisor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_antidrop
	name = "防脱落植入体"
	desc = "这种义体脑植入体可让你强制手部肌肉收缩，防止物品掉落。抽动耳朵即可开关。"
	id = "ci-antidrop"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*4,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT*4,
	)
	build_path = /obj/item/organ/cyberimp/brain/anti_drop
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_antistun
	name = "中枢神经重启植入体"
	desc = "这种植入体会自动将中枢神经系统的控制权交还给你，缩短被击晕后的失控时间。"
	id = "ci-antistun"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/silver =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/cyberimp/brain/anti_stun
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_herculean
	name = "海格力斯重力脊椎植入体"
	desc = "这种重力脊椎接口可让使用者减轻重力对身体的影响，从而有效提升运动能力。"
	id = "ci-herculean"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/titanium=SMALL_MATERIAL_AMOUNT*3,
		/datum/material/gold=SMALL_MATERIAL_AMOUNT*3,
		/datum/material/diamond =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/cyberimp/chest/spine
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT // BUBBER EDIT - CHANGE - PREVIOUS: RND_CATEGORY_CYBERNETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_connector
	name = "中枢神经技能芯片接口植入体"
	desc = "这种义体会在你的后脑增加一个接口，你可以随意取出或装入技能芯片。"
	id = "ci-connector"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/titanium = SMALL_MATERIAL_AMOUNT*3,
	)
	build_path = /obj/item/organ/cyberimp/brain/connector
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_nutriment
	name = "营养泵植入体"
	desc = "这种植入体会在你饿肚子时合成少量营养并注入你的血液。"
	id = "ci-nutriment"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/cyberimp/chest/nutriment
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_nutriment_plus
	name = "营养泵植入体加强版"
	desc = "这种植入体会在你感到饥饿时合成少量营养并注入你的血液。"
	id = "ci-nutrimentplus"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 5 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*6,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT*5,
		/datum/material/uranium = SMALL_MATERIAL_AMOUNT*7.5,
	)
	build_path = /obj/item/organ/cyberimp/chest/nutriment/plus
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_reviver
	name = "复活植入体"
	desc = "这种植入体会在你失去意识时尝试复苏你。专为胆小者准备！"
	id = "ci-reviver"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 6 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*8,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*8,
		/datum/material/gold =SMALL_MATERIAL_AMOUNT * 3,
		/datum/material/uranium =SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/cyberimp/chest/reviver
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH // BUBBER EDIT - CHANGE - PREVIOUS: RND_CATEGORY_CYBERNETICS
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_thrusters
	name = "推进器组植入体"
	desc = "这种植入体可让你在零重力区域利用环境气体或内置气源推进移动。"
	id = "ci-thrusters"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 8 SECONDS
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT*2,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT,
		/datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond =HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/cyberimp/chest/thrusters
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_surgery_brain
	name = "手术处理器植入体"
	desc = "一种义体脑植入体，可让你进行高级手术。"
	id = "ci-surgery-brain"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 0.25,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.75,
	)
	build_path = /obj/item/organ/cyberimp/brain/surgical_processor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/////////////////////////////////////////
////////////Regular Implants/////////////
/////////////////////////////////////////

/datum/design/implanter
	name = "植入器"
	desc = "一支无菌的自动植入注射器。"
	id = "implanter"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*6, /datum/material/glass =SMALL_MATERIAL_AMOUNT * 2)
	build_path = /obj/item/implanter
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implantcase
	name = "植入体盒"
	desc = "一只用于存放植入体的玻璃盒。"
	id = "implantcase"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/implantcase
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_sadtrombone
	name = "悲伤长号植入体盒"
	desc = "让死亡变得滑稽。"
	id = "implant_trombone"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bananium = HALF_SHEET_MATERIAL_AMOUNT)
	transfered_materials = list(
		/obj/item/implantcase/sad_trombone = /datum/design/implantcase::materials,
		/obj/item/implant/sad_trombone = list(/datum/material/bananium = HALF_SHEET_MATERIAL_AMOUNT),
	)
	build_path = /obj/item/implantcase/sad_trombone
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_chem
	name = "化学植入体盒"
	desc = "一只装有化学植入体的玻璃盒。"
	id = "implant_chem"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/glass = SHEET_MATERIAL_AMOUNT * 0.7)
	transfered_materials = list(
		/obj/item/implantcase/chem = /datum/design/implantcase::materials,
		/obj/item/implant/chem = list(/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2),
	)
	build_path = /obj/item/implantcase/chem
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_tracking
	name = "追踪植入体盒"
	desc = "一只装有追踪植入体的玻璃盒。"
	id = "implant_tracking"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 5)
	transfered_materials = list(
		/obj/item/implantcase/tracking = /datum/design/implantcase::materials,
		/obj/item/implant/tracking = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT),
	)
	build_path = /obj/item/implantcase/tracking
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY | DEPARTMENT_BITFLAG_MEDICAL

/datum/design/implant_beacon
	name = "信标植入体盒"
	desc = "一只装有信标植入体的玻璃盒。"
	id = "implant_beacon"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	transfered_materials = list(
		/obj/item/implantcase/beacon = /datum/design/implantcase::materials,
		/obj/item/implant/beacon = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3),
	)
	build_path = /obj/item/implantcase/beacon
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/implant_bluespace
	name = "蓝空间接地植入体盒"
	desc = "一只装有传送阻断植入体的玻璃盒。"
	id = "implant_bluespace"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	transfered_materials = list(
		/obj/item/implantcase/teleport_blocker = /datum/design/implantcase::materials,
		/obj/item/implant/teleport_blocker = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3),
	)
	build_path = /obj/item/implantcase/teleport_blocker
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/implant_exile
	name = "流放植入体盒"
	desc = "一只装有流放植入体的玻璃盒。"
	id = "implant_exile"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3)
	transfered_materials = list(
		/obj/item/implantcase/exile = /datum/design/implantcase::materials,
		/obj/item/implant/exile = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3),
	)
	build_path = /obj/item/implantcase/exile
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_SECURITY
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

//Cybernetic organs

/datum/design/cybernetic_liver
	name = "基础义体肝脏"
	desc = "一块基础的义体肝脏。"
	id = "cybernetic_liver"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/liver/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_liver/tier2
	name = "义体肝脏"
	desc = "一块义体肝脏。"
	id = "cybernetic_liver_tier2"
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/liver/cybernetic/tier2
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_liver/tier3
	name = "升级版义体肝脏"
	desc = "一块升级版义体肝脏。"
	id = "cybernetic_liver_tier3"
	construction_time = 5 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver=SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/liver/cybernetic/tier3
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_heart
	name = "基础义体心脏"
	desc = "一颗基础的义体心脏。"
	id = "cybernetic_heart"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/heart/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_heart/tier2
	name = "义体心脏"
	desc = "一颗义体心脏。"
	id = "cybernetic_heart_tier2"
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/heart/cybernetic/tier2
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_heart/tier3
	name = "升级版义体心脏"
	desc = "一颗升级版义体心脏。"
	id = "cybernetic_heart_tier3"
	construction_time = 5 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver=SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/heart/cybernetic/tier3
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_heart/anomalock
	name = "伏打战斗义体心脏"
	desc = /obj/item/organ/heart/cybernetic/anomalock::desc
	id = "cybernetic_heart_anomalock"
	construction_time = 5 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/diamond = SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/heart/cybernetic/anomalock
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT // BUBBER EDIT - CHANGE - PREVIOUS: RND_CATEGORY_EQUIPMENT
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/cybernetic_lungs
	name = "基础义体肺"
	desc = "一对基础的义体肺。"
	id = "cybernetic_lungs"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/lungs/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_lungs/tier2
	name = "义体肺"
	desc = "一对义体肺。"
	id = "cybernetic_lungs_tier2"
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/lungs/cybernetic/tier2
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_lungs/tier3
	name = "升级版义体肺"
	desc = "一对升级版义体肺。"
	id = "cybernetic_lungs_tier3"
	construction_time = 5 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/lungs/cybernetic/tier3
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_stomach
	name = "基础义体胃"
	desc = "一个基础的义体胃。"
	id = "cybernetic_stomach"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/stomach/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_stomach/tier2
	name = "义体胃"
	desc = "一个义体胃。"
	id = "cybernetic_stomach_tier2"
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/stomach/cybernetic/tier2
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_stomach/tier3
	name = "升级版义体胃"
	desc = "一个升级版义体胃。"
	id = "cybernetic_stomach_tier3"
	construction_time = 5 SECONDS
	materials = list(/datum/material/iron =SMALL_MATERIAL_AMOUNT*5, /datum/material/glass =SMALL_MATERIAL_AMOUNT*5, /datum/material/silver =SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/organ/stomach/cybernetic/tier3
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears
	name = "基础义体耳朵"
	desc = "一对基础的义体耳朵。"
	id = "cybernetic_ears"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 3 SECONDS
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*4)
	build_path = /obj/item/organ/ears/cybernetic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears_u
	name = "义体耳朵"
	desc = "一对义体耳朵。"
	id = "cybernetic_ears_u"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/ears/cybernetic/upgraded
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears_whisper
	name = "低语感知义体耳朵"
	desc = "一对低语感知义体耳朵。"
	id = "cybernetic_ears_whisper"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/ears/cybernetic/whisper
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears_volume
	name = "音量调节义体耳朵"
	desc = "一对音量调节义体耳朵"
	id = "cybernetic_ears_volume"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
			/datum/material/iron = SMALL_MATERIAL_AMOUNT*5,
			/datum/material/glass = SMALL_MATERIAL_AMOUNT*5,
			/datum/material/silver = SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/ears/cybernetic/volume
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears_xray
	name = "穿墙义体耳朵"
	desc = "一对穿墙义体耳朵。"
	id = "cybernetic_ears_xray"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT*5,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT*5,
	)
	build_path = /obj/item/organ/ears/cybernetic/xray
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_ears/cat
	name = "基础义体猫耳"
	desc = "一对基础的义体猫耳"
	id = "cybernetic_ears_cat"
	build_path = /obj/item/organ/ears/cat/cybernetic

/datum/design/cybernetic_ears_u/cat
	name = "义体猫耳"
	desc = "一对义体猫耳"
	id = "cybernetic_ears_u_cat"
	build_path = /obj/item/organ/ears/cat/cybernetic/upgraded

/datum/design/cybernetic_ears_whisper/cat
	name = "低语感知义体猫耳"
	desc = "一对低语感知义体猫耳"
	id = "cybernetic_ears_whisper_cat"
	build_path = /obj/item/organ/ears/cat/cybernetic/whisper

/datum/design/cybernetic_ears_volume/cat
	name = "音量调节义体猫耳"
	desc = "一对音量调节义体猫耳"
	id = "cybernetic_ears_volume_cat"
	build_path = /obj/item/organ/ears/cat/cybernetic/volume

/datum/design/cybernetic_ears_xray/cat
	name = "穿墙义体猫耳"
	desc = "一对穿墙义体猫耳"
	id = "cybernetic_ears_xray_cat"
	build_path = /obj/item/organ/ears/cat/cybernetic/xray

/datum/design/cybernetic_eyes
	name = "基础义体眼睛"
	desc = "一对基础的义体眼睛。"
	id = "cybernetic_eyes"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 3 SECONDS
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*2.5, /datum/material/glass = SMALL_MATERIAL_AMOUNT*4)
	build_path = /obj/item/organ/eyes/robotic/basic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_1
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_eyes/moth
	name = "基础蛾人义体眼"
	id = "cybernetic_eyes_moth"
	build_path = /obj/item/organ/eyes/robotic/basic/moth

/datum/design/cybernetic_eyes/improved
	name = "义体眼睛"
	desc = "一对义体眼睛。"
	id = "cybernetic_eyes_improved"
	build_path = /obj/item/organ/eyes/robotic
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_2
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cybernetic_eyes/improved/moth
	name = "蛾人义体眼"
	id = "cybernetic_eyes_improved_moth"
	build_path = /obj/item/organ/eyes/robotic/moth

/datum/design/cyberimp_welding
	name = "焊接护盾眼"
	desc = "这些反应式微型护盾能保护你免受焊接器与闪光弹的伤害，同时不会遮挡视线。"
	id = "ci-welding"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*6, /datum/material/glass = SMALL_MATERIAL_AMOUNT*4)
	build_path = /obj/item/organ/eyes/robotic/shield
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_welding/moth
	name = "蛾人焊接护盾眼"
	id = "ci-welding-moth"
	build_path = /obj/item/organ/eyes/robotic/shield/moth

/datum/design/cyberimp_gloweyes
	name = "发光眼"
	desc = "一对可发出多彩光线的义体眼睛"
	id = "ci-gloweyes"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*6, /datum/material/glass =HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/organ/eyes/robotic/glow
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ORGANS_3
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_gloweyes/moth
	name = "蛾人发光眼"
	id = "ci-gloweyes-moth"
	build_path = /obj/item/organ/eyes/robotic/glow/moth

/datum/design/medibot_upgrade
	name = "医疗机器人升级"
	desc = "自动提升所有连接研究网络的医疗机器人的效能。"
	id = "medibot_upgrade"
	research_icon = 'icons/mob/silicon/aibots.dmi'
	research_icon_state = "medbot_generic_idle"
	/// Medibot healing starts at a 1x multiplier. For every tech researched, it goes up by this amount additively.
	var/additive_multiplier = 1

/datum/design/medibot_upgrade/tier_two
	id = "medibot_upgrade_two"
	research_icon_state = "medbot_adv_idle"

/datum/design/medibot_upgrade/tier_three
	id = "medibot_upgrade_three"
	research_icon_state = "medbot_adv_idle"

/datum/design/medibot_upgrade/tier_four
	id = "medibot_upgrade_four"
	research_icon_state = "medbot_bezerk_idle" // alien tech

/////////////////////
///Surgery Designs///
/////////////////////

/datum/design/surgery
	abstract_type = /datum/design/surgery
	id = DESIGN_ID_IGNORE
	name = null
	desc = null
	research_icon = 'icons/obj/medical/surgery_ui.dmi'
	research_icon_state = "surgery_any"
	/// Typepath of what operation this design unlocks
	var/datum/surgery_operation/surgery

/datum/design/surgery/New()
	. = ..()
	if(isnull(name))
		name = surgery::rnd_name || capitalize(surgery::name)
	if(isnull(desc))
		desc = surgery::rnd_desc || surgery::desc

/datum/design/surgery/lobotomy
	id = "surgery_lobotomy"
	surgery = /datum/surgery_operation/organ/lobotomy
	research_icon_state = "surgery_head"

/datum/design/surgery/lobotomy/mechanic
	id = "surgery_lobotomy_mechanic"
	surgery = /datum/surgery_operation/organ/lobotomy/mechanic

/datum/design/surgery/pacify
	id = "surgery_pacify"
	surgery = /datum/surgery_operation/organ/pacify
	research_icon_state = "surgery_head"

/datum/design/surgery/pacify/mechanic
	id = "surgery_pacify_mechanic"
	surgery = /datum/surgery_operation/organ/pacify/mechanic

/datum/design/surgery/viral_bonding
	id = "surgery_viral_bond"
	surgery = /datum/surgery_operation/basic/viral_bonding
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_upgrade
	name = "Tend Wounds Upgrade"
	desc = "Upgrade the efficiency of the individual tend wound operations."
	id = "surgery_heal_upgrade"
	surgery = /datum/surgery_operation/basic/tend_wounds/upgraded
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_upgrade/femto
	name = "Tend Wounds Upgrade"
	surgery = /datum/surgery_operation/basic/tend_wounds/upgraded/master
	id = "surgery_heal_upgrade_femto"

/datum/design/surgery/tend_wounds_combo
	name = "Tend Wounds Combo"
	desc = "An alternative wound treatment operation that treats both bruises and burns at the same time, albeit less effectively than their individual counterparts."
	surgery = /datum/surgery_operation/basic/tend_wounds/combo
	id = "surgery_heal_combo"
	research_icon_state = "surgery_chest"

/datum/design/surgery/tend_wounds_combo/upgrade
	name = "Tend Wounds Combo Upgrade"
	surgery = /datum/surgery_operation/basic/tend_wounds/combo/upgraded
	id = "surgery_heal_combo_upgrade"

/datum/design/surgery/tend_wounds_combo/upgrade/femto
	name = "Tend Wounds Combo Upgrade"
	desc = "The ultimate in wound treatment operations, treating both bruises and burns simultaneous and faster than their individual counterparts."
	surgery = /datum/surgery_operation/basic/tend_wounds/combo/upgraded/master
	id = "surgery_heal_combo_upgrade_femto"

/datum/design/surgery/brainwashing
	id = "surgery_brainwashing"
	surgery = /datum/surgery_operation/organ/brainwash
	research_icon_state = "surgery_head"

/datum/design/surgery/brainwashing/mechanic
	id = "surgery_brainwashing_mechanic"
	surgery = /datum/surgery_operation/organ/brainwash/mechanic

/datum/design/surgery/nerve_splicing
	desc = "A surgical procedure which splices the patient's nerves, making them more resistant to stuns."
	id = "surgery_nerve_splice"
	surgery = /datum/surgery_operation/limb/bioware/nerve_splicing
	research_icon_state = "surgery_chest"

/datum/design/surgery/nerve_splicing/mechanic
	desc = "A robotic upgrade which upgrades a robotic patient's automatic systems, making them more resistant to stuns."
	id = "surgery_nerve_splice_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/nerve_splicing/mechanic

/datum/design/surgery/nerve_grounding
	desc = "A surgical procedure which makes the patient's nerves act as grounding rods, protecting them from electrical shocks."
	id = "surgery_nerve_ground"
	surgery = /datum/surgery_operation/limb/bioware/nerve_grounding
	research_icon_state = "surgery_chest"

/datum/design/surgery/nerve_grounding/mechanic
	desc = "A robotic upgrade which installs grounding rods into the robotic patient's system, protecting them from electrical shocks."
	id = "surgery_nerve_ground_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/nerve_grounding/mechanic

/datum/design/surgery/vein_threading
	desc = "A surgical procedure which severely reduces the amount of blood lost in case of injury."
	id = "surgery_vein_thread"
	surgery = /datum/surgery_operation/limb/bioware/vein_threading
	research_icon_state = "surgery_chest"

/datum/design/surgery/vein_threading/mechanic
	desc = "A robotic upgrade which severely reduces the amount of hydraulic fluid lost in case of injury."
	id = "surgery_vein_thread_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/vein_threading/mechanic

/datum/design/surgery/muscled_veins
	desc = "A surgical procedure which adds a muscled membrane to blood vessels, allowing a patient to pump blood without a heart."
	id = "surgery_muscled_veins"
	surgery = /datum/surgery_operation/limb/bioware/muscled_veins
	research_icon_state = "surgery_chest"

/datum/design/surgery/muscled_veins/mechanic
	desc = "A robotic upgrade which adds sophisticated hydraulics redundancies, allowing a patient to pump hydraulic fluid without an engine."
	id = "surgery_muscled_veins_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/muscled_veins/mechanic

/datum/design/surgery/ligament_hook
	desc = "A surgical procedure which reshapes the connections between torso and limbs, making it so limbs can be attached manually if severed. \
		However, this weakens the connection, making them easier to detach as well."
	id = "surgery_ligament_hook"
	surgery = /datum/surgery_operation/limb/bioware/ligament_hook
	research_icon_state = "surgery_chest"

/datum/design/surgery/ligament_hook/mechanic
	desc = "A robotic upgrade which installs rapid detachment anchor points, making it so limbs can be attached manually if detached. \
		However, this weakens the connection, making them easier to detach as well."
	id = "surgery_ligament_hook_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/ligament_hook/mechanic

/datum/design/surgery/ligament_reinforcement
	desc = "A surgical procedure which adds a protective tissue and bone cage around the connections between the torso and limbs, preventing dismemberment. \
		However, the nerve connections as a result are more easily interrupted, making it easier to disable limbs with damage."
	id = "surgery_ligament_reinforcement"
	surgery = /datum/surgery_operation/limb/bioware/ligament_reinforcement
	research_icon_state = "surgery_chest"

/datum/design/surgery/ligament_reinforcement/mechanic
	desc = "A surgical procedure which adds reinforced limb anchor points to the patient's chassis, preventing dismemberment. \
		However, the nerve connections as a result are more easily interrupted, making it easier to disable limbs with damage."
	id = "surgery_ligament_reinforcement_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/ligament_reinforcement/mechanic

/datum/design/surgery/cortex_imprint
	desc = "A surgical procedure which modifies the cerebral cortex into a redundant neural pattern, making the brain able to bypass damage caused by minor brain traumas."
	id = "surgery_cortex_imprint"
	surgery = /datum/surgery_operation/limb/bioware/cortex_imprint
	research_icon_state = "surgery_head"

/datum/design/surgery/cortex_imprint/mechanic
	desc = "A surgical procedure which updates the patient's operating system to the 'latest version', whatever that means, making the brain able to bypass damage caused by minor brain traumas."
	id = "surgery_cortex_imprint_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/cortex_imprint/mechanic

/datum/design/surgery/cortex_folding
	desc = "A surgical procedure which modifies the cerebral cortex into a complex fold, giving space to non-standard neural patterns."
	id = "surgery_cortex_folding"
	surgery = /datum/surgery_operation/limb/bioware/cortex_folding
	research_icon_state = "surgery_head"

/datum/design/surgery/cortex_folding/mechanic
	desc = "A robotic upgrade which reprograms the patient's neural network in a downright eldritch programming language, giving space to non-standard neural patterns."
	id = "surgery_cortex_folding_mechanic"
	surgery = /datum/surgery_operation/limb/bioware/cortex_folding/mechanic

/datum/design/surgery/necrotic_revival
	id = "surgery_zombie"
	surgery = /datum/surgery_operation/limb/bionecrosis
	research_icon_state = "surgery_head"

/datum/design/surgery/wing_reconstruction
	id = "surgery_wing_reconstruction"
	surgery = /datum/surgery_operation/organ/fix_wings
	research_icon_state = "surgery_chest"

/datum/design/surgery/experimental_dissection
	id = "surgery_oldstation_dissection"
	surgery = /datum/surgery_operation/basic/dissection
	research_icon_state = "surgery_chest"

/datum/design/vitals_monitor
	name = "生命体征监测仪"
	desc = "一台壁挂式计算机，可显示附近患者的生命体征。 \
		它可连接停滞床、手术台以及其他能容纳患者的设备， \
		例如低温舱、休眠舱等。"
	id = "vitals_monitor"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/wallframe/status_display/vitals
	category = list(RND_CATEGORY_COMPUTER + RND_SUBCATEGORY_COMPUTER_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/vitals_monitor/advanced
	name = "高级生命体征监测仪"
	desc = "一款升级版生命体征显示器，对患者的扫描比基础型号更详细。"
	id = "vitals_monitor_advanced"
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 0.5,
	)
	build_path = /obj/item/wallframe/status_display/vitals/advanced
