//departmental signs

/obj/structure/sign/departments
	is_editable = TRUE

///////MEDBAY

/obj/structure/sign/departments/med
	name = "\improper 医疗区标牌"
	sign_change_name = "Department - Medbay"
	desc = "标示医疗部区域的标牌。"
	icon_state = "med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/med, 32)

/obj/structure/sign/departments/med_alt
	name = "\improper 医疗区标牌"
	sign_change_name = "Department - Medbay Alt"
	icon_state = "medbay"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/med_alt, 32)

/obj/structure/sign/departments/medbay
	name = "\improper 医疗区标牌"
	sign_change_name = "Generic Medical"
	desc = "医疗机构的星际通用标志。你大概能在这里得到帮助。"
	icon_state = "bluecross"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/medbay, 32)

/obj/structure/sign/departments/medbay/alt
	name = "\improper 医疗区标牌"
	sign_change_name = "Generic Medical Alt"
	icon_state = "bluecross2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/medbay/alt, 32)

/obj/structure/sign/departments/exam_room
	name = "\improper 检查室标牌"
	sign_change_name = "Department - Medbay: Exam Room"
	desc = "一块写着“检查室”的导引标牌。"
	icon_state = "examroom"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/exam_room, 32)

/obj/structure/sign/departments/chemistry
	name = "\improper 化学室标牌"
	sign_change_name = "Department - Medbay: Chemistry"
	desc = "标示存放化学设备区域的标牌。"
	icon_state = "chemistry1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry, 32)

/obj/structure/sign/departments/chemistry/alt
	sign_change_name = "Department - Medbay: Chemistry Alt"
	icon_state = "chemistry2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry/alt, 32)

/obj/structure/sign/departments/chemistry/pharmacy
	name = "\improper 药房标牌"
	sign_change_name = "Department - Medbay: Pharmacy"
	desc = "标示存放药房设备区域的标牌。"
	icon_state = "pharmacy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/chemistry/pharmacy, 32)

/obj/structure/sign/departments/psychology
	name = "\improper 心理科标牌"
	sign_change_name = "Department - Medbay: Psychology"
	desc = "标示心理医生工作区域的标牌，他们大概能帮你把脑子理顺。"
	icon_state = "psychology"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/psychology, 32)

/obj/structure/sign/departments/virology
	name = "\improper 病毒学标牌"
	sign_change_name = "Department - Medbay: Virology"
	desc = "标示病毒学家实验室所在区域的标牌。"
	icon_state = "pharmacy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/virology, 32)

/obj/structure/sign/departments/morgue
	name = "\improper 太平间标牌"
	sign_change_name = "Department - Medbay: Morgue"
	desc = "标示空间站存放不断堆积的尸体区域的标牌。"
	icon_state = "morgue"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/morgue, 32)

///////ENGINEERING

/obj/structure/sign/departments/engineering
	name = "\improper 工程标牌"
	sign_change_name = "Department - Engineering"
	desc = "标示工程师工作区域的标牌。"
	icon_state = "engine"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/engineering, 32)

/obj/structure/sign/departments/atmospherics
	name = "\improper 大气标牌"
	sign_change_name = "Department - Engineering: Atmospherics"
	desc = "标示赋予你生命的大气来源区域的标牌。"
	icon_state = "atmos"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/engineering, 32)

///////SCIENCE

/obj/structure/sign/departments/science
	name = "\improper 科研标牌"
	sign_change_name = "Department - Science"
	desc = "标示开展研究与科研工作区域的标牌。"
	icon_state = "science1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/science, 32)

/obj/structure/sign/departments/science/alt
	sign_change_name = "Department - Science Alt"
	icon_state = "science2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/science/alt, 32)

/obj/structure/sign/departments/xenobio
	name = "\improper 异种生物学标牌"
	sign_change_name = "Department - Science: Xenobiology"
	desc = "标示研究异种生物学实体区域的标牌。"
	icon_state = "xenobio1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/xenobio, 32)

/obj/structure/sign/departments/xenobio/alt
	sign_change_name = "Department - Science: Xenobiology Alt"
	icon_state = "xenobio2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/xenobio/alt, 32)

/obj/structure/sign/departments/genetics
	name = "\improper 遗传学标牌"
	sign_change_name = "Department - Science: Genetics"
	desc = "标示研究遗传学领域区域的标牌。"
	icon_state = "gene"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/genetics, 32)

/obj/structure/sign/departments/rndserver
	name ="\improper 研发服务器标牌"
	sign_change_name = "Department - Science: R&D Server"
	desc = "标示存放科学数据区域的标牌。"
	icon_state = "rndserver"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/rndserver, 32)

///////SERVICE

/obj/structure/sign/departments/botany
	name = "\improper 植物学标牌"
	sign_change_name = "Department - Botany (Flower)"
	desc = "标示该区域为植物种植场所的标牌。"
	icon_state = "hydro1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany, 32)

/obj/structure/sign/departments/botany/alt1
	sign_change_name = "Department - Botany (Tray)"
	icon_state = "hydro2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt1, 32)

/obj/structure/sign/departments/botany/alt2
	sign_change_name = "Department - Botany (Watering Can)"
	icon_state = "hydro3"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt2, 32)

/obj/structure/sign/departments/botany/botany/alt3
	sign_change_name = "Department - Botany (Tray) Alt"
	icon_state = "botany"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/botany/alt3, 32)

/obj/structure/sign/departments/custodian
	name = "\improper 清洁工标牌"
	sign_change_name = "Department - Janitor"
	desc = "标示清洁工工作区域的标牌。"
	icon_state = "custodian1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/custodian, 32)

/obj/structure/sign/departments/custodian_alt
	name = "\improper 清洁工标牌"
	sign_change_name = "Department - Janitor Alt"
	desc = "标示清洁工工作区域的标牌。"
	icon_state = "custodian2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/custodian_alt, 32)

/obj/structure/sign/departments/holy
	name = "\improper 礼拜堂标牌"
	sign_change_name = "Department - Chapel"
	desc = "标示宗教区域的标牌。"
	icon_state = "holy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/holy, 32)

/obj/structure/sign/departments/holy_alt
	name = "\improper 礼拜堂标牌"
	sign_change_name = "Department - Chapel Alt"
	desc = "标示宗教区域的标牌。"
	icon_state = "chapel"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/holy, 32)

/obj/structure/sign/departments/lawyer
	name = "\improper 法务部标牌"
	sign_change_name = "Department - Legal"
	desc = "标示律师工作区域的标牌，如需申请抵达穿梭机颈椎甩伤赔偿，请在此办理。"
	icon_state = "lawyer"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/lawyer, 32)

/obj/structure/sign/departments/restaurant
	name = "\improper 餐厅标牌"
	sign_change_name = "Department - Restaurant"
	desc = "标示供应餐食区域的标牌。"
	icon_state = "restaurant"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/restaurant, 32)

/obj/structure/sign/departments/bar
	name = "\improper 酒吧标牌"
	sign_change_name = "Department - Bar"
	desc = "标示调制饮品区域的标牌。"
	icon_state = "bar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/bar, 32)

///////SUPPLY

/obj/structure/sign/departments/cargo
	name = "\improper 货运标牌"
	sign_change_name = "Department - Cargo"
	desc = "标示货运飞船停靠区域的标牌。"
	icon_state = "cargo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/cargo, 32)

/obj/structure/sign/departments/exodrone
	name = "\improper 外勤无人机标牌"
	sign_change_name = "Department - Cargo: exodrone"
	desc = "标示使用外勤无人机区域的标牌。"
	icon_state = "exodrone"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/exodrone, 32)

///////SECURITY

/obj/structure/sign/departments/security
	name = "\improper 安保标牌"
	sign_change_name = "Department - Security"
	desc = "标示法纪严明区域的标牌。"
	icon_state = "security"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/security, 32)

////MISC LOCATIONS

/obj/structure/sign/departments/restroom
	name = "\improper 洗手间标牌"
	sign_change_name = "Location - Restroom"
	desc = "标示洗手间的标牌。"
	icon_state = "restroom"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/restroom, 32)

/obj/structure/sign/departments/maint
	name = "\improper 维护隧道标牌"
	sign_change_name = "Location - Maintenance"
	desc = "标示连接空间站各部门区域的标牌。"
	icon_state = "mait1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/maint, 32)

/obj/structure/sign/departments/maint/alt
	name = "\improper 维护隧道标牌"
	sign_change_name = "Location - Maintenance Alt"
	desc = "标示连接空间站各部门区域的标牌。"
	icon_state = "mait2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/maint/alt, 32)

/obj/structure/sign/departments/evac
	name = "\improper 撤离标牌"
	sign_change_name = "Location - Evacuation"
	desc = "标示执行撤离程序区域的标牌。"
	icon_state = "evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/evac, 32)

/obj/structure/sign/departments/drop
	name = "\improper 空投舱标牌"
	sign_change_name = "Location - Drop Pods"
	desc = "标示进行空投舱装载程序区域的标牌。"
	icon_state = "drop"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/drop, 32)

/obj/structure/sign/departments/court
	name = "\improper 法庭标牌"
	sign_change_name = "Location - Courtroom"
	desc = "标示法庭的标牌，神圣不可侵犯的太空法在此得到维护。"
	icon_state = "court"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/court, 32)

/obj/structure/sign/departments/telecomms
	name = "\improper 电信标牌"
	sign_change_name = "Location - Telecommunications"
	desc = "标示存放空间站无线电与 NTnet 服务器区域的标牌。"
	icon_state = "telecomms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/telecomms, 32)

/obj/structure/sign/departments/telecomms/alt
	icon_state = "telecomms2"
	sign_change_name = "Location - Telecommunications Alt"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/telecomms/alt, 32)

/obj/structure/sign/departments/aiupload
	name = "\improper AI 上传室标牌"
	sign_change_name = "Location - AI Upload"
	desc = "标示向空间站 AI 与半机械人上传法则区域的标牌。"
	icon_state = "aiupload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/aiupload, 32)

/obj/structure/sign/departments/aisat
	name = "\improper AI 卫星标牌"
	sign_change_name = "Location - AI Satellite"
	desc = "标示 AI 重兵设防的卫星的标牌。"
	icon_state = "aisat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/aisat, 32)

/obj/structure/sign/departments/vault
	name = "\improper 金库标牌"
	sign_change_name = "Location - Vault"
	desc = "标示空间站资源与自毁装置所在安全室的标牌。"
	icon_state = "vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/departments/vault, 32)
