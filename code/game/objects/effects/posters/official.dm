/obj/item/poster/random_official
	name = "随机官方海报"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

/obj/structure/sign/poster/official
	poster_item_name = "励志海报"
	poster_item_desc = "纳米传讯官方发行的海报，旨在培养顺从听话的员工。配备先进的黏性背衬，可轻松贴在任何垂直表面上。"
	poster_item_icon_state = "rolled_legit"
	printable = TRUE

/obj/structure/sign/poster/official/random
	name = "随机官方海报（ROP）"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/random, 32)
//This is being hardcoded here to ensure we don't print directionals from the library management computer because they act wierd as a poster item
/obj/structure/sign/poster/official/random/directional
	printable = FALSE

/obj/structure/sign/poster/official/here_for_your_safety
	name = "为您的安全而来"
	desc = "一张赞颂空间站安保力量的海报。"
	icon_state = "here_for_your_safety"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/here_for_your_safety, 32)

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "\improper 纳米传讯标志"
	desc = "一张画着纳米传讯标志的海报。"
	icon_state = "nanotrasen_logo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanotrasen_logo, 32)

/obj/structure/sign/poster/official/cleanliness
	name = "清洁卫生"
	desc = "一张警示卫生不良危害的海报。"
	icon_state = "cleanliness"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cleanliness, 32)

/obj/structure/sign/poster/official/help_others
	name = "帮助他人"
	desc = "一张鼓励你帮助其他船员的海报。"
	icon_state = "help_others"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/help_others, 32)

/obj/structure/sign/poster/official/build
	name = "建设"
	desc = "一张赞颂工程团队的海报。"
	icon_state = "build"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/build, 32)

/obj/structure/sign/poster/official/bless_this_spess
	name = "保佑这片太空"
	desc = "一张为此地祈福的海报。"
	icon_state = "bless_this_spess"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/bless_this_spess, 32)

/obj/structure/sign/poster/official/science
	name = "科学"
	desc = "一张画着原子的海报。"
	icon_state = "science"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/science, 32)

/obj/structure/sign/poster/official/ian
	name = "伊恩"
	desc = "汪汪。嗷。"
	icon_state = "ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ian, 32)

/obj/structure/sign/poster/official/obey
	name = "服从"
	desc = "一张要求观看者服从权威的海报。"
	icon_state = "obey"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/obey, 32)

/obj/structure/sign/poster/official/walk
	name = "慢行"
	desc = "一张要求观看者步行而非奔跑的海报。"
	icon_state = "walk"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/walk, 32)

/obj/structure/sign/poster/official/state_laws
	name = "陈述法则"
	desc = "一张要求半机械人陈述自身法则的海报。"
	icon_state = "state_laws"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/state_laws, 32)

/obj/structure/sign/poster/official/love_ian
	name = "关爱伊恩"
	desc = "伊恩就是爱，伊恩就是生活。"
	icon_state = "love_ian"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/love_ian, 32)

/obj/structure/sign/poster/official/space_cops
	name = "太空警察。"
	desc = "一张宣传电视节目《太空警察》的海报。"
	icon_state = "space_cops"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/space_cops, 32)

/obj/structure/sign/poster/official/ue_no
	name = "上野。"
	desc = "这东西全是日语。"
	icon_state = "ue_no"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ue_no, 32)

/obj/structure/sign/poster/official/get_your_legs
	name = "拥有你的 LEGS"
	desc = "LEGS：领导力、经验、才智、服从。"
	icon_state = "get_your_legs"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/get_your_legs, 32)

/obj/structure/sign/poster/official/do_not_question
	name = "不要质疑"
	desc = "一张要求观看者不要打听不该知道之事的海报。"
	icon_state = "do_not_question"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/do_not_question, 32)

/obj/structure/sign/poster/official/work_for_a_future
	name = "为未来工作"
	desc = "一张鼓励你为自己的未来工作的海报。"
	icon_state = "work_for_a_future"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/work_for_a_future, 32)

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "软帽波普艺术"
	desc = "廉价波普艺术的海报复刻品。"
	icon_state = "soft_cap_pop_art"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/soft_cap_pop_art, 32)

/obj/structure/sign/poster/official/safety_internals
	name = "安全须知：供气设备"
	desc = "一张要求观看者在罕见的缺氧或空气有毒环境中使用供气设备的海报。"
	icon_state = "safety_internals"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_internals, 32)

/obj/structure/sign/poster/official/safety_eye_protection
	name = "安全须知：眼部防护"
	desc = "一张要求观看者在接触化学品、烟雾或强光时佩戴眼部防护用品的海报。"
	icon_state = "safety_eye_protection"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_eye_protection, 32)

/obj/structure/sign/poster/official/safety_report
	name = "安全须知：报告"
	desc = "一张要求观看者向安保报告可疑活动的海报。"
	icon_state = "safety_report"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/safety_report, 32)

/obj/structure/sign/poster/official/report_crimes
	name = "举报犯罪"
	desc = "一张鼓励及时向空间站安保报告犯罪或煽动行为的海报。"
	icon_state = "report_crimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/report_crimes, 32)

/obj/structure/sign/poster/official/ion_rifle
	name = "离子步枪"
	desc = "一张展示离子步枪的海报。"
	icon_state = "ion_rifle"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/ion_rifle, 32)

/obj/structure/sign/poster/official/foam_force_ad
	name = "泡沫部队广告"
	desc = "泡沫部队，不是你射人，就是人射你！"
	icon_state = "foam_force_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/foam_force_ad, 32)

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "高希霸罗布图广告"
	desc = "高希霸罗布图，有格调的雪茄。"
	icon_state = "cohiba_robusto_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/cohiba_robusto_ad, 32)

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "五十周年复古海报复刻版"
	desc = "一张 2505 年海报的复刻版，纪念纳米传讯子公司纳米海报制造成立五十周年。"
	icon_state = "anniversary_vintage_reprint"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/anniversary_vintage_reprint, 32)

/obj/structure/sign/poster/official/fruit_bowl
	name = "果盘"
	desc = "简洁，却令人赞叹。"
	icon_state = "fruit_bowl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/fruit_bowl, 32)

/obj/structure/sign/poster/official/pda_ad
	name = "PDA 广告"
	desc = "一张宣传纳米传讯供应商最新 PDA 的海报。"
	icon_state = "pda_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/pda_ad, 32)

/obj/structure/sign/poster/official/enlist
	name = "参军" // but I thought deathsquad was never acknowledged
	desc = "今日加入纳米传讯死亡小队预备役！"
	icon_state = "enlist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/enlist, 32)

/obj/structure/sign/poster/official/nanomichi_ad
	name = "纳米道广告"
	desc = "一张宣传纳米道牌录音带的海报。"
	icon_state = "nanomichi_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/nanomichi_ad, 32)

/obj/structure/sign/poster/official/twelve_gauge
	name = "12 号口径"
	desc = "一张夸耀 12 号霰弹优越性的海报。"
	icon_state = "twelve_gauge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twelve_gauge, 32)

/obj/structure/sign/poster/official/high_class_martini
	name = "高级马天尼"
	desc = "我说过了，要摇匀，不要搅拌。"
	icon_state = "high_class_martini"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/high_class_martini, 32)

/obj/structure/sign/poster/official/the_owl
	name = "猫头鹰"
	desc = "猫头鹰会竭尽全力保护空间站。你会吗？"
	icon_state = "the_owl"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/the_owl, 32)

/obj/structure/sign/poster/official/no_erp
	name = "禁止 ERP"
	desc = "这张海报提醒船员，根据顺旋政府对巨型企业的规定，公司政策禁止企业资源规划。"
	icon_state = "no_erp"
	/// Tracks poster state for the hidden interaction
	VAR_PRIVATE/corrupted = FALSE

/obj/structure/sign/poster/official/no_erp/tear_poster(mob/user)
	if(prob(99) && !check_holidays(APRIL_FOOLS))
		return ..()

	visible_message(span_notice("[user] rips [src] in a single, decisive motion... revealing another poster?"))
	playsound(src, 'sound/items/poster/poster_ripped.ogg', 100, TRUE)
	if(corrupted)
		name = initial(name)
		desc = initial(desc)
		icon_state = initial(icon_state)
		corrupted = FALSE
	else
		name = "支持 ERP"
		desc = "这张海报提醒船员，企业资源规划既高效，又对空间站运行至关重要。"
		icon_state = "yes_erp"
		corrupted = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/no_erp, 32)

/obj/structure/sign/poster/official/wtf_is_co2
	name = "二氧化碳"
	desc = "这张知识海报介绍了什么是二氧化碳。"
	icon_state = "wtf_is_co2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/wtf_is_co2, 32)

/obj/structure/sign/poster/official/dick_gum
	name = "迪克·甘舒"
	desc = "一张宣传老鼠侦探迪克·甘舒冒险故事的海报，鼓励船员用正义的力量惩治电线破坏者。"
	icon_state = "dick_gum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/dick_gum, 32)

/obj/structure/sign/poster/official/there_is_no_gas_giant
	name = "不存在气态巨行星"
	desc = "纳米传讯向所有空间站发放了这样的海报，提醒大家关于气态巨行星的传言并不属实。"
	// And yet people still believe...
	icon_state = "there_is_no_gas_giant"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/there_is_no_gas_giant, 32)

/obj/structure/sign/poster/official/periodic_table
	name = "元素周期表"
	desc = "一张从氢到鿫、涵盖其中全部元素的周期表。"
	icon_state = "periodic_table"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/periodic_table, 32)

/obj/structure/sign/poster/official/plasma_effects
	name = "等离子体与人体"
	desc = "这张知识海报介绍了长期接触等离子体对大脑的影响。"
	icon_state = "plasma_effects"

/obj/structure/sign/poster/official/plasma_effects/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("等离子体（学名阿门汀）被地球政府列为一级健康危害物，长期接触会带来严重健康风险。")]"
	. += "\t[span_info("已知等离子体能穿过血脑屏障，在脑组织内积聚并导致脑功能退化。其致病机制尚未完全明确，因此除了正确使用个人防护装备（手套、防护连身服和呼吸器）外，暂无明确的预防建议。")]"
	. += "\t[span_info("小剂量等离子体会导致意识混乱、短期失忆和攻击性增强。持续接触会使这些症状延续。")]"
	. += "\t[span_info("长期接触者已出现严重后果，包括攻击性进一步增强、长期失忆、阿尔茨海默病症状、精神分裂症、黄斑变性、动脉瘤、中风风险上升和帕金森病症状。")]"
	. += "\t[span_info("建议所有未采取防护便接触原始等离子体的人员定期接受公司卫生人员检查。")]"
	. += "\t[span_info("更多信息请访问地球政府关于阿门汀的星际网站 www.terra.gov/health_and_safety/amenthium/，或查阅内部风险评估文件（#47582-b《等离子体安全数据表》，以及 #64210 至 #64225《等离子体作业个人防护装备规定》，所有员工均可通过纳米文档查阅）。")]"
	. += "\t[span_info("纳米传讯：始终关爱您的健康。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/plasma_effects, 32)

/obj/structure/sign/poster/official/terragov
	name = "地球政府：为人类团结一致"
	desc = "一张展示地球政府标志和格言的海报，提醒观看者是谁在守护人类。"
	icon_state = "terragov"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/terragov, 32)

/obj/structure/sign/poster/official/corporate_perks_vacation
	name = "纳米传讯企业福利：度假"
	desc = "这张海报介绍了纳米传讯企业福利计划提供的部分奖励，包括前往度假星球伊迪勒斯的双人两周假期。"
	icon_state = "corporate_perks_vacation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/corporate_perks_vacation, 32)

/obj/structure/sign/poster/official/jim_nortons
	name = "吉姆·诺顿魁北克咖啡"
	desc = "风靡银河的魁北克咖啡店——吉姆·诺顿的广告。"
	icon_state = "jim_nortons"

/obj/structure/sign/poster/official/jim_nortons/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("自 1965 年扎根三河市以来，我们始终致力于提供物有所值的上好咖啡。")]"
	. += "\t[span_info("今天就到吉姆店里坐坐，来杯热咖啡和一个甜甜圈，体验魁北克人的生活。")]"
	. += "\t[span_info("吉姆·诺顿魁北克咖啡：永远欢迎您。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/jim_nortons, 32)

/obj/structure/sign/poster/official/twenty_four_seven
	name = "全天候超市"
	desc = "全天候超市的广告，宣传其与纳米传讯合作推出的全新全天候便利站。"
	icon_state = "twenty_four_seven"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/twenty_four_seven, 32)

/obj/structure/sign/poster/official/tactical_game_cards
	name = "纳米传讯战术卡牌"
	desc = "纳米传讯 TCG 卡牌广告：多买卡牌。"
	icon_state = "tactical_game_cards"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/tactical_game_cards, 32)

/obj/structure/sign/poster/official/midtown_slice
	name = "中城切片披萨"
	desc = "纳米传讯官方披萨合作伙伴中城切片披萨的广告。中城切片：无论身在何处，都有一片家的味道。"
	icon_state = "midtown_slice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/midtown_slice, 32)

//SafetyMoth Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982)
//SafetyMoth art credit goes to AspEv
/obj/structure/sign/poster/official/moth_hardhat
	name = "安全蛾——安全帽"
	desc = "这张知识海报通过安全蛾™提醒观看者在危险区域佩戴安全帽。“就像给脑袋戴了盏灯！”"
	icon_state = "aspev_hardhat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_hardhat, 32)

/obj/structure/sign/poster/official/moth_piping
	name = "安全蛾——管道"
	desc = "这张知识海报通过安全蛾™教大气技师选用正确的管道类型。“用管道，别用泵！正确铺管，性能不减！”"
	icon_state = "aspev_piping"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_piping, 32)

/obj/structure/sign/poster/official/moth_meth
	name = "安全蛾——甲基苯丙胺"
	desc = "这张知识海报通过安全蛾™提醒观看者，制备甲基苯丙胺前须获得首席医疗官批准。“接近目标温度，千万别超温！”……你本来就不该制作这个。"
	icon_state = "aspev_meth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_meth, 32)

/obj/structure/sign/poster/official/moth_epi
	name = "安全蛾——肾上腺素"
	desc = "这张知识海报通过安全蛾™提醒观看者，用肾上腺素注射器帮助受伤或已死亡的船员。“简单一招，防止器官腐烂！”"
	icon_state = "aspev_epi"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_epi, 32)

/obj/structure/sign/poster/official/moth_delam
	name = "安全蛾——崩解安全措施"
	desc = "这张知识海报通过安全蛾™告诉观看者，超物质晶体崩解时应躲进柜子以防产生幻觉。撤离可能才是更好的办法。"
	icon_state = "aspev_delam"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/moth_delam, 32)

//End of AspEv posters

/obj/structure/sign/poster/fluff/lizards_gas_payment
	name = "请付款"
	desc = "一张粗制海报，要求读者为想带离空间站的物品付款。"
	icon_state = "gas_payment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_payment, 32)

/obj/structure/sign/poster/fluff/lizards_gas_power
	name = "节约用电"
	desc = "一张粗制海报，要求读者离开前关闭电源。希望重新营业时记得打开。"
	icon_state = "gas_power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/fluff/lizards_gas_power, 32)

/obj/structure/sign/poster/official/festive
	name = "节日通知海报"
	desc = "一张通知当前节日的海报。今天没有节日，所以你该回去工作了。"
	icon_state = "holiday_none"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/festive, 32)

/obj/structure/sign/poster/official/boombox
	name = "手提音响"
	desc = "一张过时海报，列出了所谓的“致死词”和暗语，声称竞争公司用它们远程停用自己的特工。"
	icon_state = "boombox"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/boombox, 32)

/obj/structure/sign/poster/official/download
	name = "你不会下载一把枪"
	desc = "一张提醒船员公司机密应留在工作场所的海报。"
	icon_state = "download_gun"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/download, 32)

/obj/structure/sign/poster/official/mining
	name = "未知物种"
	desc = "一张展示灰行者族群成员的海报。我们对它们仍知之甚少，成为先驱吧！\
	人们阅读这张海报后会心情更好！"
	icon_state = "ashwalkers"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/mining, 32)
