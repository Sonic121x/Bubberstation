//Posters//

//Custom Posters Below//
/obj/structure/sign/poster/contraband/syndicate_medical
	name = "辛迪加医疗"
	desc = "这张海报庆祝辛迪加特工成功将一支已死亡一小时、共六人的采矿小队完整复活。角落里写着一句简单的话：“继续赢下去。”"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_syndiemed"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/syndicate_medical, 32)

/obj/structure/sign/poster/contraband/crocin_pool
	name = "游泳"
	desc = "这张海报戏剧性地写着：“游泳”。它似乎在宣传把克罗辛用于“娱乐性”用途——在家中、在工作场所，以及最令人不安的“泳池”里。角落里印着一个“MamoTramsem”标志。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_crocin"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/crocin_pool, 32)

/obj/structure/sign/poster/contraband/icebox_moment
	name = "上如此，下亦然"
	desc = "这张海报似乎在宣扬这样的观念：“安保主管办公室正好位于一处辛迪加设施的正上方”实在再合适不过。上如此……下亦然。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_abovebelow"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/icebox_moment, 32)

/obj/structure/sign/poster/contraband/shipstation
	name = "飞行服务——应征入伍"
	desc = "这张海报描绘了早已被弃用的“船”级“空间站”在其鼎盛时期的模样。令人意外的是，这张海报似乎出自纳米传讯官方；不过考虑到他们对这个话题一直讳莫如深……" //A disaster as big as Ship deserves a scandalous coverup.
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_shipstation"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/shipstation, 32)

/obj/structure/sign/poster/contraband/dancing_honk
	name = "跳舞"
	desc = "这张海报描绘了一台“洪克”级机甲站在舞台上，旁边立着一根钢管。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_honkdance"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/dancing_honk, 32)

/obj/structure/sign/poster/contraband/operative_duffy
	name = "现金悬赏"
	desc = "这张海报上画着一个防毒面具，并写有如何就画中人下落的“转交情报”的说明……不过并未指明要转交给谁。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_duffy"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/operative_duffy, 32)

/obj/structure/sign/poster/contraband/ultra
	name = "ULTRA"
	desc = "这张海报上只有一个词：“ULTRA”；画面是一颗微笑的药丸，旁边放着一只烧杯。令人不安。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_ultra"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/ultra, 32)

/obj/structure/sign/poster/contraband/secborg_vale
	name = "被涂污的瓦尔博格广告"
	desc = "这张海报原本是为了宣传瓦尔博格型机体的流线型实用性——但它似乎早已被涂污。最上方压着一个词：“快跑。”——考虑到画面中展示的是安保型号，这倒也贴切。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_valeborg"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/secborg_vale, 32)

/obj/structure/sign/poster/contraband/killingjoke // I like Batman :)))
	name = "你不必是疯子才能在这里工作——但这确实有帮助！"
	desc = "一张大胆宣称在纳米传讯空间站上工作并不要求精神失常的海报。但有总比没有好！"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "poster_sr_killingjoke"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/killingjoke, 32)

/obj/structure/sign/poster/contraband/nri_text
	name = "新俄罗斯帝国主权宣言"
	desc = "这张海报引述了新俄罗斯帝国《主权宣言》译本的内容。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_texto"

/obj/structure/sign/poster/contraband/nri_text/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览了海报上的一些信息……</i>")
	. += "\t[span_info("新俄罗斯帝国第一次人民参议员大会……")]"
	. += "\t[span_info("……申明尊重属于……的一切民族的主权权利……")]"
	. += "\t[span_info("……庄严宣告新俄罗斯帝国对其全部领土拥有国家主权，并宣布决心建立一个法治的君主制国家……")]"
	. += "\t[span_info("……本宣言是新俄罗斯帝国新宪法制定、帝国条约缔结以及皇家立法完善的基础。")]"
	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_text, 32)

/obj/structure/sign/poster/contraband/nri_rations
	name = "泛斯拉夫联邦军用口粮广告"
	desc = "这张海报大概是某家私营公司依照国防部国家订单生产的军用口粮的广告。这位上将的得力助手看上去确实很兴奋。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_rations"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_rations, 32)

/obj/structure/sign/poster/contraband/nri_voskhod
	name = "VOSKHOD 作战护甲广告"
	desc = "一张展示新近研发的 VOSKHOD 作战护甲的海报，该护甲目前装备于泛斯拉夫联邦边境沿线的部队与步兵。左侧自上而下写着“DRIP”一词，大概是在夸耀这套防护服的出众设计。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_voskhod"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_voskhod, 32)

/obj/structure/sign/poster/contraband/nri_pistol
	name = "Szabo-Ivanek 制式手枪技术海报"
	desc = "这张海报似乎是 Szabo-Ivanek 制式手枪的技术文档，该枪装备于泛斯拉夫联邦大多数国家警察与军事机构。可惜全文都是用国际斯拉夫语写的。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_pistol"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_pistol, 32)

/obj/structure/sign/poster/contraband/nri_engineer
	name = "立即建造"
	desc = "这张海报上，一名帝国战斗工程师正盯着观察者左方某处。海报的顶部和底部都写着“立即建造”。"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_engineer"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_engineer, 32)

/obj/structure/sign/poster/contraband/nri_radar
	name = "帝国海军招募海报"
	desc = "今天就加入帝国海军！游历银河，射杀地球人，收获创伤后应激障碍！"
	icon = 'modular_skyrat/modules/aesthetics/posters/contraband.dmi'
	icon_state = "nri_radar"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/contraband/nri_radar, 32)
