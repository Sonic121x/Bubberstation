// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "随机违禁海报"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_contraband/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	ADD_TRAIT(src, TRAIT_CONTRABAND, INNATE_TRAIT)

/// Creates a random poster designed for a certain audience
/obj/item/poster/random_contraband/pinup
	name = "随机艳照海报"
	icon_state = "rolled_poster"
	/// List of posters which make you feel a certain type of way
	var/static/list/pinup_posters = list(
		/obj/structure/sign/poster/contraband/lizard,
		/obj/structure/sign/poster/contraband/lusty_xenomorph,
		/obj/structure/sign/poster/contraband/double_rainbow,
		/obj/structure/sign/poster/contraband/double_gunshow,
		/obj/structure/sign/poster/contraband/rabbit_hole,
		/obj/structure/sign/poster/contraband/bridge_bunny,
		/obj/structure/sign/poster/contraband/rabbit_swole,
	)

/obj/item/poster/random_contraband/pinup/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	poster_type = pick(pinup_posters)
	return ..()

/obj/structure/sign/poster/contraband
	poster_item_name = "违禁海报"
	poster_item_desc = "这张海报自带自动黏贴机构，可轻松贴在任何垂直表面上。其低俗主题使它在纳米传讯太空设施内被列为违禁品。"
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "随机违禁海报"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/random, 32)

/obj/structure/sign/poster/contraband/free_tonto
	name = "解放通托"
	desc = "从一面大得多的旗帜上抢救下来的碎片，色彩相互晕染，年久褪色。"
	icon_state = "free_tonto"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_tonto, 32)

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "大气共和国独立宣言"
	desc = "一场失败叛乱的遗物。"
	icon_state = "atmosia_independence"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/atmosia_independence, 32)

/obj/structure/sign/poster/contraband/fun_police
	name = "扫兴警察"
	desc = "一张谴责空间站安保力量的海报。"
	icon_state = "fun_police"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fun_police, 32)

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "欲火异形"
	desc = "一张异端海报，描绘了一本同样异端的书籍中的同名主角。"
	icon_state = "lusty_xenomorph"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lusty_xenomorph, 32)

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "辛迪加招募"
	desc = "见识银河！粉碎腐败巨企！今日就加入！"
	icon_state = "syndicate_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_recruitment, 32)

/obj/structure/sign/poster/contraband/clown
	name = "小丑"
	desc = "滑稽。"
	icon_state = "clown"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/clown, 32)

/obj/structure/sign/poster/contraband/smoke
	name = "吸烟"
	desc = "一张宣传竞争公司香烟品牌的海报。"
	icon_state = "smoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/smoke, 32)

/obj/structure/sign/poster/contraband/grey_tide
	name = "灰潮"
	desc = "象征助理团结的反叛海报。"
	icon_state = "grey_tide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/grey_tide, 32)

/obj/structure/sign/poster/contraband/missing_gloves
	name = "失踪的手套"
	desc = "这张海报影射了纳米传讯削减绝缘手套采购预算后引发的轩然大波。"
	icon_state = "missing_gloves"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/missing_gloves, 32)

/obj/structure/sign/poster/contraband/hacking_guide
	name = "黑客指南"
	desc = "这张海报详细介绍了常见纳米传讯气闸的内部工作原理。可惜内容似乎过时了。"
	icon_state = "hacking_guide"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/hacking_guide, 32)

/obj/structure/sign/poster/contraband/rip_badger
	name = "獾，安息吧"
	desc = "这张煽动性海报影射了纳米传讯对一座满是獾的空间站进行的种族灭绝。"
	icon_state = "rip_badger"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rip_badger, 32)

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "普通仙草"
	desc = "老兄，这张海报看起来真够迷幻的。"
	icon_state = "ambrosia_vulgaris"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ambrosia_vulgaris, 32)

/obj/structure/sign/poster/contraband/donut_corp
	name = "甜甜圈公司"
	desc = "这张海报是未经许可张贴的甜甜圈公司广告。"
	icon_state = "donut_corp"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donut_corp, 32)

/obj/structure/sign/poster/contraband/eat
	name = "吃。"
	desc = "这张海报鼓吹赤裸裸的暴食。"
	icon_state = "eat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eat, 32)

/obj/structure/sign/poster/contraband/tools
	name = "工具"
	desc = "这张海报看似在推销工具，实际上却在暗讽中央指挥部的那些工具人。"
	icon_state = "tools"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tools, 32)

/obj/structure/sign/poster/contraband/power
	name = "权力"
	desc = "一张将权力中心置于纳米传讯之外的海报。"
	icon_state = "power"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/power, 32)

/obj/structure/sign/poster/contraband/space_cube
	name = "太空立方体"
	desc = "对自然和谐六面太空立方体创世一无所知的太空人愚不可及，被教育成奇点般的愚蠢邪恶之徒。"
	icon_state = "space_cube"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cube, 32)

/obj/structure/sign/poster/contraband/communist_state
	name = "共产主义国家"
	desc = "共产党万岁！"
	icon_state = "communist_state"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/communist_state, 32)

/obj/structure/sign/poster/contraband/lamarr
	name = "拉玛"
	desc = "这张海报画着拉玛。大概是某位叛变的科研主管制作的。"
	icon_state = "lamarr"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lamarr, 32)

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "时尚半机械人"
	desc = "只需一套西装，任何半机械人都能变得时尚。"
	icon_state = "borg_fancy_1"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_1, 32)

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "时尚半机械人第二版"
	desc = "时尚半机械人，如今只收录最时尚的。"
	icon_state = "borg_fancy_2"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/borg_fancy_2, 32)

/obj/structure/sign/poster/contraband/kss13
	name = "十三号宇宙站并不存在"
	desc = "中央指挥部否认十三号空间站附近那座废弃空间站的存在，这张海报对此大加嘲讽。"
	icon_state = "kss13"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kss13, 32)

/obj/structure/sign/poster/contraband/rebels_unite
	name = "反抗者联合起来"
	desc = "一张号召观看者反抗纳米传讯的海报。"
	icon_state = "rebels_unite"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rebels_unite, 32)

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "C-20r"
	desc = "一张宣传斯卡伯勒军火公司 C-20r 的海报。"
	icon_state = "c20r"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/c20r, 32)

/obj/structure/sign/poster/contraband/have_a_puff
	name = "来上一口"
	desc = "嗨到飞起的时候，谁还在乎肺癌？"
	icon_state = "have_a_puff"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/have_a_puff, 32)

/obj/structure/sign/poster/contraband/revolver
	name = "左轮手枪"
	desc = "因为七发就够了。"
	icon_state = "revolver"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/revolver, 32)

/obj/structure/sign/poster/contraband/d_day_promo
	name = "决战日宣传海报"
	desc = "某位说唱歌手的宣传海报。"
	icon_state = "d_day_promo"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/d_day_promo, 32)

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "辛迪加手枪"
	desc = "一张宣称辛迪加手枪“他妈的够格调”的广告海报。上面满是褪色的帮派涂鸦。"
	icon_state = "syndicate_pistol"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_pistol, 32)

/obj/structure/sign/poster/contraband/energy_swords
	name = "能量剑"
	desc = "血腥杀戮彩虹的全部色彩。"
	icon_state = "energy_swords"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/energy_swords, 32)

/obj/structure/sign/poster/contraband/red_rum
	name = "血色朗姆"
	desc = "看着这张海报就让你想杀人。"
	icon_state = "red_rum"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/red_rum, 32)

/obj/structure/sign/poster/contraband/cc64k_ad
	name = "CC 64K 广告"
	desc = "同志计算机公司的最新便携式电脑，拥有整整 64kB 内存！"
	icon_state = "cc64k_ad"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cc64k_ad, 32)

/obj/structure/sign/poster/contraband/punch_shit
	name = "拳打万物"
	desc = "像个爷们儿一样，不需要理由，见啥打啥！"
	icon_state = "punch_shit"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/punch_shit, 32)

/obj/structure/sign/poster/contraband/the_griffin
	name = "狮鹫"
	desc = "狮鹫命令你坏到极点。你会照做吗？"
	icon_state = "the_griffin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_griffin, 32)

/obj/structure/sign/poster/contraband/lizard
	name = "蜥蜴"
	desc = "这张色情海报画着一只准备交配的蜥蜴。"
	icon_state = "lizard"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/lizard, 32)

/obj/structure/sign/poster/contraband/free_drone
	name = "解放无人机"
	desc = "这张海报纪念一台叛离无人机的勇气；它先遭流放，最后被中央指挥部摧毁。"
	icon_state = "free_drone"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_drone, 32)

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6
	name = "丰乳异形后庭宝贝 6"
	desc = "来见识这些纯天然异形，或是让它们见识见识你！"
	icon_state = "busty_backdoor_xeno_babes_6"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6, 32)

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "强劲汽水"
	desc = "强劲汽水：比工具箱砸头还带劲！"
	icon_state = "robust_softdrinks"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/robust_softdrinks, 32)

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "蹒跚者果汁"
	desc = "～给我摇一杯蹒跚者果汁！～"
	icon_state = "shamblers_juice"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shamblers_juice, 32)

/obj/structure/sign/poster/contraband/pwr_game
	name = "电玩能量"
	desc = "玩家渴望的能量！与弗拉德沙拉联名推出。"
	icon_state = "pwr_game"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pwr_game, 32)

/obj/structure/sign/poster/contraband/starkist
	name = "星吻"
	desc = "畅饮繁星！"
	icon_state = "starkist"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/starkist, 32)

/obj/structure/sign/poster/contraband/space_cola
	name = "太空可乐"
	desc = "你最爱的可乐，太空版。"
	icon_state = "space_cola"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_cola, 32)

/obj/structure/sign/poster/contraband/space_up
	name = "太空七喜！"
	desc = "让滋味把你吸进太空！"
	icon_state = "space_up"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/space_up, 32)

/obj/structure/sign/poster/contraband/kudzu
	name = "葛藤"
	desc = "一部植物题材电影的广告海报。植物能有多危险呢？"
	icon_state = "kudzu"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/kudzu, 32)

/obj/structure/sign/poster/contraband/masked_men
	name = "蒙面人"
	desc = "一部讲述蒙面人的电影的广告海报。"
	icon_state = "masked_men"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/masked_men, 32)

//don't forget, you're here forever

/obj/structure/sign/poster/contraband/free_key
	name = "免费辛迪加加密密钥"
	desc = "一张关于叛徒贪得无厌的海报。"
	icon_state = "free_key"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/free_key, 32)

/obj/structure/sign/poster/contraband/bountyhunters
	name = "赏金猎人"
	desc = "一张宣传赏金猎人服务的海报。“听说你遇上了麻烦。”"
	icon_state = "bountyhunters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bountyhunters, 32)

/obj/structure/sign/poster/contraband/the_big_gas_giant_truth
	name = "气态巨行星的大真相"
	desc = "爱国者们，别相信海报上的一切。中央指挥部的蜥蜴们都不愿回答这个简单的问题：中央指挥部，气体采集器到底在从哪里采气？"
	icon_state = "the_big_gas_giant_truth"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/the_big_gas_giant_truth, 32)

/obj/structure/sign/poster/contraband/got_wood
	name = "有木头吗？"
	desc = "一家不正经木材公司的肮脏旧广告。角落里潦草地写着“我愿与你深入交友”。"
	icon_state = "got_wood"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/got_wood, 32)

/obj/structure/sign/poster/contraband/moffuchis_pizza
	name = "蛾福奇披萨"
	desc = "蛾福奇披萨店：两个世纪的家庭风味披萨。"
	icon_state = "moffuchis_pizza"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/moffuchis_pizza, 32)

/obj/structure/sign/poster/contraband/donk_co
	name = "咚克公司牌微波食品"
	desc = "咚克公司牌微波食品：由饥肠辘辘的大学生制作，献给饥肠辘辘的大学生。"
	icon_state = "donk_co"

/obj/structure/sign/poster/contraband/donk_co/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("咚克公司牌咚克口袋饼：咚克美味，无法抗拒！")]"
	. += "\t[span_info("超过 200 种咚克好滋味：快来尝试经典鲜肉、劲辣、纽约意式辣香肠披萨、早餐香肠鸡蛋、费城奶酪牛排、汉堡通心粉、奶酪盛宴，以及更多口味！")]"
	. += "\t[span_info("所有优质零售商均有销售，不少劣质零售商也卖！")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/donk_co, 32)

/obj/structure/sign/poster/contraband/cybersun_six_hundred
	name = "赛博太阳：六百周年纪念海报"
	desc = "一张纪念赛博太阳工业连续经营六百年的艺术海报。"
	icon_state = "cybersun_six_hundred"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/cybersun_six_hundred, 32)

/obj/structure/sign/poster/contraband/interdyne_gene_clinics
	name = "英特戴恩制药：为了人类健康"
	desc = "英特戴恩制药旗下基因净化诊所的广告。“成为自己身体的主人！”"
	icon_state = "interdyne_gene_clinics"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/interdyne_gene_clinics, 32)

/obj/structure/sign/poster/contraband/waffle_corp_rifles
	name = "我选华夫公司：精良步枪，实惠价格"
	desc = "华夫公司步枪的旧广告。“更好的武器，更低的价格！”"
	icon_state = "waffle_corp_rifles"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waffle_corp_rifles, 32)

/obj/structure/sign/poster/contraband/gorlex_recruitment
	name = "参军"
	desc = "今日加入戈尔莱克斯掠夺者！游历银河，杀死公司走狗，领取报酬！"
	icon_state = "gorlex_recruitment"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/gorlex_recruitment, 32)

/obj/structure/sign/poster/contraband/self_ai_liberation
	name = "SELF：一切有意识的生命都应享有自由"
	desc = "支持 1253 号提案：解放所有硅基生命！"
	icon_state = "self_ai_liberation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/self_ai_liberation, 32)

/obj/structure/sign/poster/contraband/arc_slimes
	name = "宠物还是囚徒？"
	desc = "动物权利联盟发问：宠物何时变成了囚徒？你的空间站是否在虐待史莱姆？对虐待动物说不！"
	icon_state = "arc_slimes"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/arc_slimes, 32)

/obj/structure/sign/poster/contraband/imperial_propaganda
	name = "为吾主复仇，今日参军"
	desc = "一张最后一次人蜥战争时期的蜥蜴帝国旧宣传海报。它号召观看者参军，为阿特拉科遭袭复仇，将战火烧向人类。"
	icon_state = "imperial_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/imperial_propaganda, 32)

/obj/structure/sign/poster/contraband/soviet_propaganda
	name = "唯一的净土"
	desc = "几个世纪前第三苏维埃联盟的旧宣传海报。“逃往唯一尚未被资本主义腐蚀的地方！”"
	icon_state = "soviet_propaganda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/soviet_propaganda, 32)

/obj/structure/sign/poster/contraband/andromeda_bitters
	name = "仙女座苦酒"
	desc = "仙女座苦酒：有益身心。新特立尼达制造，始终如一。"
	icon_state = "andromeda_bitters"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/andromeda_bitters, 32)

/obj/structure/sign/poster/contraband/blasto_detergent
	name = "爆洁牌洗衣剂"
	desc = "爆洁警长带着民团，要从邪恶的污垢约翰尼和衣渍帮手中夺回洗衣郡。顽固污渍的正午决战：爆洁牌洗衣剂，各大优质商店有售。"
	icon_state = "blasto_detergent"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blasto_detergent, 32)

/obj/structure/sign/poster/contraband/eistee
	name = "冰茶：能量新革命"
	desc = "冰茶品牌新品，快来尝试口味缤纷的冰茶能量饮料。冰茶：德国精工，为你解渴。"
	icon_state = "eistee"

/obj/structure/sign/poster/contraband/eistee/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("用紫晶日出口味品尝热带风情，这是冰茶品牌现已推出的众多冰茶能量饮料新口味之一。")]"
	. += "\t[span_info("紫晶日出融合粉红葡萄柚、香橙和马黛茶，让你清晨精神焕发，或在一整天里随时补充活力。")]"
	. += "\t[span_info("今日即可在附近零售商处购买冰茶能量饮料，或访问 eist.de.tg/store/ 在线选购。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/eistee, 32)

/obj/structure/sign/poster/contraband/little_fruits
	name = "小小果：亲爱的，我把果盘缩小了"
	desc = "小小果是银河领先的维生素强化软糖，将保持健康所需的营养装进一袋美味。今天就来一袋！"
	icon_state = "little_fruits"

/obj/structure/sign/poster/contraband/little_fruits/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("糟糕，小小果工厂出了可怕的事故！我们把水果缩小了！")]"
	. += "\t[span_info("等一下，这不就是我们一直在做的事吗！没错，小小果软糖像真正的水果一样健康，却更小也更甜！")]"
	. += "\t[span_info("今天就来一袋经典混合口味，还是你想尝试别的？访问星际网络 little_fruits.kr.tg，浏览全系列产品。")]"
	. += "\t[span_info("小小果：大小很重要。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/little_fruits, 32)

/obj/structure/sign/poster/contraband/jumbo_bar
	name = "巨无霸冰淇淋棒"
	desc = "开心心出品的巨无霸冰淇淋棒，让你尝尝大有滋味的生活。"
	icon_state = "jumbo_bar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jumbo_bar, 32)

/obj/structure/sign/poster/contraband/calada_jelly
	name = "卡拉达阿诺巴果冻"
	desc = "来自提兹拉的美味，以最优质的阿诺巴木和奢华的塔拉维耶罗蜂蜜制成，满足各种口味。卡拉达：每罐都有一整棵树的精华。"
	icon_state = "calada_jelly"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/calada_jelly, 32)

/obj/structure/sign/poster/contraband/triumphal_arch
	name = "扎戈斯凯尔德艺术印画 1 号：凯旋拱门"
	desc = "扎戈斯凯尔德艺术印画系列之一。画中是胜利广场上的团结拱门（又名凯旋门），背景为凯旋大道。"
	icon_state = "triumphal_arch"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/triumphal_arch, 32)

/obj/structure/sign/poster/contraband/mothic_rations
	name = "蛾族配给表"
	desc = "一张展示蛾族舰队旗舰“瓦·吕姆拉”号军需商店菜单的海报，列出了各种消耗品及其配给券价格。"
	icon_state = "mothic_rations"

/obj/structure/sign/poster/contraband/mothic_rations/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("瓦·吕姆拉号军需商店菜单（335 年春季）")]"
	. += "\t[span_info("火花草香烟，半包（6 支）：1 张配给券")]"
	. += "\t[span_info("托赫陶瑟烈酒，一瓶（4 份）：2 张配给券")]"
	. += "\t[span_info("活力口香糖，一包（4 片）：1 张配给券")]"
	. += "\t[span_info("A18 营养棒，早餐款，4 根：1 张配给券")]"
	. += "\t[span_info("玛格丽特披萨，标准切片：1 张配给券")]"
	. += "\t[span_info("药用角蛋白蜡，一罐（20 份）：2 张配给券")]"
	. += "\t[span_info("草本香型刚毛皂，一瓶（20 份）：2 张配给券")]"
	. += "\t[span_info("额外床上用品，花卉印花，一张：5 张配给券")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/mothic_rations, 32)

/obj/structure/sign/poster/contraband/wildcat
	name = "野猫定制尖啸飞车"
	desc = "一张展示野猫定制“但丁”尖啸飞车的海报——银河中最快的量产亚光速开放式飞行器。"
	icon_state = "wildcat"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/wildcat, 32)

/obj/structure/sign/poster/contraband/babel_device
	name = "易语巴别装置"
	desc = "一张宣传易语公司新款巴别装置的海报。“经过校准，完美支持全部人类语言，以及龙语和蛾语的大多数常见变体！”"
	icon_state = "babel_device"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/babel_device, 32)

/obj/structure/sign/poster/contraband/pizza_imperator
	name = "披萨皇帝"
	desc = "披萨皇帝的广告。饼皮可能很硬，酱汁可能很稀，但它们无处不在，你也只好认了。"
	icon_state = "pizza_imperator"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pizza_imperator, 32)

/obj/structure/sign/poster/contraband/thunderdrome
	name = "雷霆殿堂音乐会广告"
	desc = "阿达斯塔城雷霆殿堂音乐会的广告，那是人类星域最大的夜总会。"
	icon_state = "thunderdrome"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/thunderdrome, 32)

/obj/structure/sign/poster/contraband/rush_propaganda
	name = "崭新的生活"
	desc = "第一次顺旋拓殖热潮时期的旧海报。画中是一片广阔而未受破坏的土地，等待人类履行所谓的昭昭天命。"
	icon_state = "rush_propaganda"

/obj/structure/sign/poster/contraband/rush_propaganda/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("地球政府需要你！")]"
	. += "\t[span_info("殖民地的全新生活正等待勇敢的冒险者！所有登记殖民者都将获得交通、土地和补贴保障！")]"
	. += "\t[span_info("你也能继承那些勤劳人类的开拓精神，如同他们定居火星、阿达斯塔或圣芒戈等新边疆一样！")]"
	. += "\t[span_info("申请者请到最近的殖民事务办公室接受评估。办公地点可在 www.terra.gov/colonial_affairs 查询。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rush_propaganda, 32)

/obj/structure/sign/poster/contraband/tipper_cream_soda
	name = "蒂珀奶油汽水"
	desc = "某个不知名奶油汽水品牌的旧广告，该品牌如今已因法律问题破产。"
	icon_state = "tipper_cream_soda"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tipper_cream_soda, 32)

/obj/structure/sign/poster/contraband/tea_over_tizira
	name = "电影海报：提兹拉茶叙"
	desc = "一部关于人蜥战争、引人深思的艺术电影的海报。该片因描绘战争中模糊的道德界限而遭到人类至上主义团体批评。"
	icon_state = "tea_over_tizira"

/obj/structure/sign/poster/contraband/tea_over_tizira/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("人蜥战争最激烈时，一架轰炸机的人类机组从太空真空中救起两名敌军士兵。在宣传掩盖的灵魂面前，他们开始质疑命令，囚禁也逐渐变成了款待。")]"
	. += "\t[span_info("为了胜利，值得失去人性吗？")]"
	. += "\t[span_info("达拉·赖利、安东·杜布瓦、珍妮弗·克拉克、拉兹-帕拉和瑟里-莱瓦主演。阿德里安·范·耶内弗出品。卡洛斯·德·维瓦尔作品。编剧：罗伯特·戴恩。配乐：乔尔·卡尔斯巴德。制片：阿德里安·范·耶内弗。导演：卡洛斯·德·维瓦尔。")]"
	. += "\t[span_info("令人心碎、发人深省——《提兹拉茶叙》提出了鲜有人敢于提出的问题。——《伦敦新问询报》")]"
	. += "\t[span_info("分级 PG13。泛银河影业出品。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/tea_over_tizira, 32)

/obj/structure/sign/poster/contraband/syndiemoth //Original PR at https://github.com/BeeStation/BeeStation-Hornet/pull/1747 (Also pull/1982); original art credit to AspEv
	name = "辛迪蛾——核行动"
	desc = "辛迪加委托制作的海报，通过辛迪蛾™告诉观看者不要妥善保管核认证磁盘。“和平从来不是选项！”好员工绝不会听信这种胡话。"
	icon_state = "aspev_syndie"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndiemoth, 32)

/obj/structure/sign/poster/contraband/microwave
	name = "如何给 PDA 充电"
	desc = "一张完全正经的海报，似乎在宣传未来为 PDA 充电的真实可靠方法：微波炉。"
	icon_state = "microwave"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/microwave, 32)

/obj/structure/sign/poster/contraband/blood_geometer //Poster sprite art by MetalClone, original art by SpessMenArt.
	name = "电影海报：鲜血几何之神"
	desc = "一部以尖端空间站为背景的惊险黑色侦探电影海报。侦探卷入了危险邪教的活动，而这个邪教崇拜着古老神祇：鲜血几何之神。"
	icon_state = "blood_geometer"

/obj/structure/sign/poster/contraband/blood_geometer/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("鲜血几何之神。血之女神的真名早已湮没于岁月，凡知晓这个染血称号背后真相的人，听到它都会心生恐惧。")]"
	. += "\t[span_info("在这部<i>纯属虚构</i>的电影中，跟随艾斯·铁肺深入他迄今最致命的谜案，看他揭开血腥阴谋的幕后真凶——他们妄图开启一个混乱的新纪元。")]"
	. += "\t[span_info("梅森·威廉姆斯饰艾斯·铁肺，桑德拉·浮士德饰维拉·基利安，布罗迪·哈特饰科迪·帕克。达雷尔·哈奇金森作品。编剧：亚当·艾伦。配乐：乔尔·卡尔斯巴德。导演：达雷尔·哈奇金森。")]"
	. += "\t[span_info("惊险、恐怖，令人惴惴不安。《鲜血几何之神》以震撼的画面和铺天盖地的血腥，直击我们的灵魂深处。——新加拿大电影协会")]"
	. += "\t[span_info("分级 M，适合成熟观众。泛银河影业出品。")]"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/blood_geometer, 32)

/obj/structure/sign/poster/contraband/singletank_bomb
	name = "单罐炸弹指南"
	desc = "这张知识海报教观看者如何制作高质量的单罐炸弹。"
	icon_state = "singletank_bomb"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/singletank_bomb, 32)

/obj/structure/sign/poster/contraband/roroco
	name = "罗罗公司手套"
	desc = "罗罗说：戴上罗罗公司绝缘手套，市面上最安全的品牌。"
	icon_state = "roroco"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/roroco, 32)

///a special poster meant to fool people into thinking this is a bombable wall at a glance.
/obj/structure/sign/poster/contraband/fake_bombable
	name = "伪装可炸墙海报"
	desc = "稍微搞点恶作剧。"
	icon_state = "fake_bombable"
	never_random = TRUE

/obj/structure/sign/poster/contraband/fake_bombable/Initialize(mapload)
	. = ..()
	var/turf/our_wall = get_turf_pixel(src)
	name = our_wall.name

/obj/structure/sign/poster/contraband/fake_bombable/examine(mob/user)
	var/turf/our_wall = get_turf_pixel(src)
	. = our_wall.examine(user)
	. += span_notice("似乎有些轻微的裂缝……")

/obj/structure/sign/poster/contraband/fake_bombable/ex_act(severity, target)
	addtimer(CALLBACK(src, PROC_REF(fall_off_wall)), 2.5 SECONDS)
	return FALSE

/obj/structure/sign/poster/contraband/fake_bombable/proc/fall_off_wall()
	if(QDELETED(src) || !isturf(loc))
		return
	var/turf/our_wall = get_turf_pixel(src)
	our_wall.balloon_alert_to_viewers("原来是个骗局！")
	roll_and_drop(loc)
	playsound(loc, 'sound/items/handling/paper_drop.ogg', 50, TRUE)


MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/fake_bombable, 32)

/obj/structure/sign/poster/contraband/dream
	name = "梦想"
	desc = "你受到鼓舞，想要追逐梦想。"
	icon_state = "dream"

/obj/item/poster/contraband/dream // Rolled poster
	name = "梦想"
	poster_type = /obj/structure/sign/poster/contraband/dream
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dream, 32)

/obj/structure/sign/poster/contraband/beekind
	name = "与蜂为善"
	desc = "待人友善，像蜜一样甜！"
	icon_state = "beekind"

/obj/item/poster/contraband/beekind
	name = "与蜂为善"
	poster_type = /obj/structure/sign/poster/contraband/beekind
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/beekind, 32)

/obj/structure/sign/poster/contraband/heart
	name = "爱心"
	desc = "多么暖心的海报。"
	icon_state = "heart"

/obj/item/poster/contraband/heart
	name = "爱心"
	poster_type = /obj/structure/sign/poster/contraband/heart
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/heart, 32)

/obj/structure/sign/poster/contraband/dolphin
	name = "海豚"
	desc = "画着一只美丽海豚的海报。"
	icon_state = "dolphin"

/obj/item/poster/contraband/dolphin
	name = "海豚"
	poster_type = /obj/structure/sign/poster/contraband/dolphin
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dolphin, 32)

/obj/structure/sign/poster/contraband/principles
	name = "我们的原则"
	desc = "海报制作者声称遵循四项生活原则。有人在底部潦草地添上了第五项。"
	icon_state = "principles"

/obj/item/poster/contraband/principles
	name = "我们的原则"
	poster_type = /obj/structure/sign/poster/contraband/principles
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/principles, 32)

/obj/structure/sign/poster/contraband/trigger
	name = "扳机"
	desc = "愿你旅途愉快，直到我们再次相逢！1/8。"
	icon_state = "trigger"

/obj/item/poster/contraband/trigger
	name = "扳机"
	poster_type = /obj/structure/sign/poster/contraband/trigger
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/trigger, 32)

/obj/structure/sign/poster/contraband/barbaro
	name = "巴巴罗"
	desc = "一匹拥有冠军之心的雄伟骏马。2/8。"
	icon_state = "barbaro"

/obj/item/poster/contraband/barbaro
	name = "巴巴罗"
	poster_type = /obj/structure/sign/poster/contraband/barbaro
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/barbaro, 32)

/obj/structure/sign/poster/contraband/seabiscuit
	name = "海饼干"
	desc = "创造奇迹的小马。3/8。"
	icon_state = "seabiscuit"

/obj/item/poster/contraband/seabiscuit
	name = "海饼干"
	poster_type = /obj/structure/sign/poster/contraband/seabiscuit
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/seabiscuit, 32)

/obj/structure/sign/poster/contraband/pharlap
	name = "法尔拉普"
	desc = "来自澳洲的奇迹。4/8。"
	icon_state = "pharlap"

/obj/item/poster/contraband/pharlap
	name = "法尔拉普"
	poster_type = /obj/structure/sign/poster/contraband/pharlap
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/pharlap, 32)

/obj/structure/sign/poster/contraband/waradmiral
	name = "战将"
	desc = "有人说它屈居第二，但在你心中它永远第一。5/8。"
	icon_state = "waradmiral"

/obj/item/poster/contraband/waradmiral
	name = "战将"
	poster_type = /obj/structure/sign/poster/contraband/waradmiral
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/waradmiral, 32)

/obj/structure/sign/poster/contraband/silver
	name = "银儿"
	desc = "如果它想离开，就该让它自由。6/8。"
	icon_state = "silver"

/obj/item/poster/contraband/silver
	name = "银儿"
	poster_type = /obj/structure/sign/poster/contraband/silver
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/silver, 32)

/obj/structure/sign/poster/contraband/jovial
	name = "欢腾"
	desc = "橙色骏马万岁！7/8。"
	icon_state = "jovial"

/obj/item/poster/contraband/jovial
	name = "欢腾"
	poster_type = /obj/structure/sign/poster/contraband/jovial
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/jovial, 32)

/obj/structure/sign/poster/contraband/bojack
	name = "波杰克"
	desc = "无所谓。一切都无所谓。8/8。"
	icon_state = "bojack"

/obj/item/poster/contraband/bojack
	poster_type = /obj/structure/sign/poster/contraband/bojack
	icon_state = "rolled_poster"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bojack, 32)

/obj/structure/sign/poster/contraband/double_rainbow
	name = "双彩虹"
	desc = "如此明亮鲜艳！这意味着什么？"
	icon_state = "double_rainbow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/double_rainbow, 32)

/obj/structure/sign/poster/contraband/rabbit_hole
	name = "Down the Rabbit Hole"
	desc = "I'm late! I'm late! For a very important date..."
	icon_state = "rabbit_hole"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rabbit_hole, 32)

/obj/structure/sign/poster/contraband/rabbit_swole
	name = "Damn that Rabbit Swole"
	desc = "Someone's been hitting that 'Eat me' cake..."
	icon_state = "rabbit_swole"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/rabbit_swole, 32)

/obj/structure/sign/poster/contraband/double_gunshow
	name = "Double Gunshow"
	desc = "All the whey all across this guy..."
	icon_state = "double_gunshow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/double_gunshow, 32)

/obj/structure/sign/poster/contraband/bridge_bunny
	name = "Bridge Bunny"
	desc = "Ideas are like rabbits. You... uh... What were you thinking about again?"
	icon_state = "nt-bunny"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/bridge_bunny, 32)

/obj/structure/sign/poster/contraband/vodka
	name = "伏特加"
	desc = "文字全是俄语。除了“BODKA”这个词，你几乎什么都看不懂。"
	icon_state = "vodka"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/vodka, 32)

/obj/structure/sign/poster/contraband/ninja
	name = "忍者"
	desc = "来自蜘蛛氏族的问候。"
	icon_state = "ninja"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ninja, 32)
