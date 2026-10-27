// Wiki books that are linked to the configured wiki link.

/// The size of the window that the wiki books open in.
#define BOOK_WINDOW_BROWSE_SIZE "970x710"
/// This macro will resolve to code that will open up the associated wiki page in the window.
#define WIKI_PAGE_IFRAME(title, wikiurl, link_identifier) {"
<html>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<title>[html_encode(title)]</title>
		<style>
			body {
				margin: 0;
			}
			p {
				margin: 8px;
			}
			iframe {
				border: 0;
				margin-left: -177px;
				margin-top: -80px;
				width: calc(100% + 177px);
				height: calc(100% + 80px);
				display: none;
			}
			body.loaded p {
				display: none;
			}
			body.loaded iframe {
				display: inline;
			}
		</style>
	</head>
	<body>
		<p>你开始翻阅手册……</p>
		<iframe src="[wikiurl]/[link_identifier]?useskin=vector" onload="document.body.classList.add('loaded')"></iframe>
	</body>
</html>
"}

// A book that links to the wiki
/obj/item/book/manual/wiki
	starting_content = "纳米传讯目前没有关于此主题的任何资料。 \
		如需了解更多，请联系您当地的中央指挥部代表。" // safety
	abstract_type = /obj/item/book/manual/wiki
	/// The ending URL of the page that we link to.
	var/page_link = ""

/obj/item/book/manual/wiki/display_content(mob/living/user)
	var/wiki_url = CONFIG_GET(string/wikiurl)
	if(!wiki_url)
		user.balloon_alert(user, "这本书是空的！")
		return
	credit_book_to_reader(user)
	if(user.client.byond_version < 516) //Remove this once 516 is stable
		if(tgui_alert(user, "本书的页面将在你的浏览器中打开。你确定吗？", "打开 Wiki", list("Yes", "No")) != "Yes")
			return
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	else
		DIRECT_OUTPUT(user, browse(WIKI_PAGE_IFRAME(name, wiki_url, page_link), "window=manual;size=[BOOK_WINDOW_BROWSE_SIZE]")) // if you change this GUARANTEE that it works.

/obj/item/book/manual/wiki/chemistry
	name = "化学教科书"
	icon_state ="chemistrybook"
	starting_author = "纳米传讯"
	starting_title = "化学教科书"
	page_link = "Guide_to_chemistry"

/obj/item/book/manual/wiki/engineering_construction
	name = "空间站维修与建造"
	icon_state ="bookEngineering"
	starting_author = "工程学百科全书"
	starting_title = "空间站维修与建造"
	page_link = "Guide_to_construction"

/obj/item/book/manual/wiki/engineering_guide
	name = "工程学教科书"
	icon_state ="bookEngineering2"
	starting_author = "工程学百科全书"
	starting_title = "工程学教科书"
	page_link = "Guide_to_engineering"

/obj/item/book/manual/wiki/security_space_law
	name = "太空法"
	desc = "一套由纳米传讯制定的、用于在其空间站上维持法律与秩序的准则。"
	icon_state = "bookSpaceLaw"
	starting_author = "纳米传讯"
	starting_title = "太空法"
	page_link = "Space_Law"

/obj/item/book/manual/wiki/security_space_law/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]假装认真地读着[src]……随后当场笑死了！"))
	return OXYLOSS

/obj/item/book/manual/wiki/infections
	name = "感染病——打造你自己的大流行！"
	icon_state = "bookInfections"
	starting_author = "感染病百科全书"
	starting_title = "感染病——打造你自己的大流行！"
	page_link = "Infections"

/obj/item/book/manual/wiki/telescience
	name = "传送科学——给傻瓜看的蓝空间！"
	icon_state = "book7"
	starting_author = "蓝空间大学"
	starting_title = "传送科学——给傻瓜看的蓝空间！"
	page_link = "Guide_to_telescience"

/obj/item/book/manual/wiki/engineering_hacking
	name = "黑客技术"
	icon_state ="bookHacking"
	starting_author = "工程学百科全书"
	starting_title = "黑客技术"
	page_link = "Hacking"

/obj/item/book/manual/wiki/detective
	name = "黑色电影：调查的正确流程"
	icon_state ="bookDetective"
	starting_author = "纳米传讯"
	starting_title = "黑色电影：调查的正确流程"
	page_link = "Detective"

/obj/item/book/manual/wiki/barman_recipes
	name = "酒保配方：调制饮品，改变人生"
	icon_state = "barbook"
	starting_author = "约翰·罗斯爵士"
	starting_title = "酒保配方：调制饮品，改变人生"
	page_link = "Guide_to_drinks"

/obj/item/book/manual/wiki/robotics_cyborgs
	name = "机器人学入门"
	icon_state = "borgbook"
	starting_author = "XISC"
	starting_title = "机器人学入门"
	page_link = "Guide_to_robotics"

/obj/item/book/manual/wiki/research_and_development
	name = "研发基础 101"
	icon_state = "rdbook"
	starting_author = "L. 伊特博士"
	starting_title = "研发基础 101"
	page_link = "Guide_to_Research_and_Development"

/obj/item/book/manual/wiki/experimentor
	name = "指导你的实验"
	icon_state = "rdbook"
	starting_author = "H.P. 克里茨博士"
	starting_title = "指导你的实验"
	page_link = "Experimentor"

/obj/item/book/manual/wiki/cooking_to_serve_man
	name = "为人类服务"
	desc = "这是一本食谱！"
	icon_state ="cooked_book"
	starting_author = "卡纳米坦帝国"
	starting_title = "为人类服务"
	page_link = "Guide_to_food"

/obj/item/book/manual/wiki/tcomms
	name = "子空间电信与你"
	icon_state = "book3"
	starting_author = "工程学百科全书"
	starting_title = "子空间电信与你"
	page_link = "Guide_to_Telecommunications"

/obj/item/book/manual/wiki/atmospherics
	name = "大气词汇集"
	icon_state = "book5"
	starting_author = "阿特莫西亚城邦"
	starting_title = "大气词汇集"
	page_link = "Guide_to_Atmospherics"

/obj/item/book/manual/wiki/medicine
	name = "太空医学汇编 第 638 卷"
	icon_state = "book8"
	starting_author = "医学期刊"
	starting_title = "太空医学汇编 第 638 卷"
	page_link = "Guide_to_medicine"

/obj/item/book/manual/wiki/surgery
	name = "脑外科入门"
	icon_state = "book4"
	starting_author = "F. 弗兰博士"
	starting_title = "脑外科入门"
	page_link = "Surgery"

/obj/item/book/manual/wiki/grenades
	name = "自制化学手榴弹"
	icon_state = "book2"
	starting_author = "W. 鲍威尔"
	starting_title = "自制化学手榴弹"
	page_link = "Grenade"

/obj/item/book/manual/wiki/ordnance
	name = "军械入门，或：我如何学会不再担忧并爱上最大当量"
	icon_state = "book6"
	starting_author = "古巴皮特"
	starting_title = "军械入门，或：我如何学会不再担忧并爱上最大当量"
	page_link = "Guide_to_toxins"

/obj/item/book/manual/wiki/ordnance/suicide_act(mob/living/user)
	var/mob/living/carbon/human/H = user
	user.visible_message(span_suicide("[user]开始跟着伦巴节奏跳起舞来！看起来是想自杀！"))
	playsound(loc, 'sound/effects/spray.ogg', 10, TRUE, -3)
	if(QDELETED(H))
		return
	H.emote("spin")
	sleep(2 SECONDS)
	for(var/obj/item/W in H)
		H.dropItemToGround(W)
		if(prob(50))
			step(W, pick(GLOB.alldirs))
	var/obj/item/bodypart/head = H.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		ADD_TRAIT(head, TRAIT_DISFIGURED, TRAIT_GENERIC)
	for(var/obj/item/bodypart/part as anything in H.get_bodyparts())
		part.adjustBleedStacks(5)
	H.gib_animation()
	sleep(0.3 SECONDS)
	H.adjust_brute_loss(1000) //to make the body super-bloody
	// if we use gib() then the body gets deleted
	H.spawn_gibs()
	H.spill_organs(DROP_ALL_REMAINS)
	H.spread_bodyparts(DROP_BRAIN)
	return BRUTELOSS

/obj/item/book/manual/wiki/plumbing
	name = "不含毒品的化学工厂"
	icon_state ="plumbingbook"
	starting_author = "纳米传讯"
	starting_title = "不含毒品的化学工厂"
	page_link = "Guide_to_plumbing"

/obj/item/book/manual/wiki/cytology
	name = "不道德的有机体培育"
	icon_state ="cytologybook"
	starting_author = "克莱森"
	starting_title = "不道德的有机体培育"
	page_link = "Guide_to_cytology"

/obj/item/book/manual/wiki/tgc
	name = "战术卡牌——玩家手册"
	icon_state = "tgcbook"
	starting_author = "纳米传讯教育娱乐部"
	starting_title = "战术卡牌——玩家手册"
	page_link = "Tactical_Game_Cards"

#undef BOOK_WINDOW_BROWSE_SIZE
#undef WIKI_PAGE_IFRAME
