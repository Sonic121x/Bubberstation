/// The size of the window that the wiki books open in.
#define BOOK_WINDOW_BROWSE_SIZE "970x710"

#define WIKI_PAGE_IFRAME(wikiurl, link_identifier) {"
	<html>
	<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<style>
		iframe {
			display: none;
		}
	</style>
	</head>
	<body>
	<script type="text/javascript">
		function pageloaded(myframe) {
			document.getElementById("loading").style.display = "none";
			myframe.style.display = "inline";
	}
	</script>
	<p id='loading'>你开始翻阅这本手册……</p>
	<iframe width='100%' height='97%' onload="pageloaded(this)" src="[##wikiurl]/[##link_identifier]&remove_links=1" frameborder="0" id="main_frame"></iframe>
	</body>
	</html>
	"}



/obj/item/book/manual/wiki/security_space_law
	name = "公司规章"
	desc = "一套纳米传讯规章，用于在其空间站内维持法律、秩序与程序。"
	starting_title = "公司规章"
	page_link = "index.php?title=Space_Law"

/obj/item/book/manual/wiki/security_space_law/attack_self(mob/user) // Was in /tg/ folder, moved it here, made it 100% chance to learn language since you can spam it inhand anyhow. Saves us all from carpal tunnel.
	if(user.can_read(src) && !user.has_language(/datum/language/legalese, SPOKEN_LANGUAGE))
		to_chat(user, span_notice("当你把书中内容吸进脑子里时，你觉得自己高雅了不少。只读了一遍太空法，你就觉得自己已经是个假装懂拉丁语的行家了。你现在会说联邦法律语了。"))
		user.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //can speak but not understand
	else
		.=..()

/obj/item/book/manual/wiki/security_space_law/display_content(mob/living/user)
	var/wiki_url = "http://wiki.bubberstation.org"
	if(!wiki_url)
		user.balloon_alert(user, "这本书是空的！")
		return
	credit_book_to_reader(user)
	if(user.client.byond_version < 516) //Remove this once 516 is stable
		if(tgui_alert(user, "本书页面将在你的浏览器中打开。你确定吗？", "打开 Wiki", list("是", "否")) != "是")
			return
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	else
		DIRECT_OUTPUT(user, browse(WIKI_PAGE_IFRAME(wiki_url, page_link), "window=manual;size=[BOOK_WINDOW_BROWSE_SIZE]")) // if you change this GUARANTEE that it works.

/obj/item/book/manual/wiki/security_space_law/weighted
	name = "公司规章：典藏版"
	desc = "一套纳米传讯指南，用于在其空间站上维持法律与秩序。这一本因为页数更多、封面包覆金属板而相当沉重。"
	icon = 'modular_zubbers/icons/obj/security_voucher.dmi'
	icon_state = "SpaceLawWeighted"
	force = 13
	throwforce = 13
	attack_verb_continuous = list("教育", "斥责", "起诉", "教训")
	attack_verb_simple = list("教育", "斥责", "起诉", "提醒", "教训")

/obj/item/book/manual/wiki/security_space_law/weighted/afterattack(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isliving(target))
		return

	var/mob/living/living_target = target

	if(user == living_target)
		return

	if(living_target.stat == DEAD)
		return

	if(prob(10))
		living_target.grant_language(/datum/language/legalese, SPOKEN_LANGUAGE) //IMMA TEACH YOU A LESSON

#undef BOOK_WINDOW_BROWSE_SIZE
#undef WIKI_PAGE_IFRAME
