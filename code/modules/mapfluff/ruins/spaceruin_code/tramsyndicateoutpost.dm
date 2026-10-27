// Fluff for the Syndicate outpost which appears on tramstation's z-levels

/obj/item/paper/fluff/ruins/tram_syndicate/initiation
	name = "入会文件"
	default_raw_text = {"<h1>恭喜你，特工 <i>在此处填写名字</i>！</h1>
	你被指派到因德西菲瑞斯周围的轨道岩石群中执行侦察任务！由于此地此前被勘察为纳米传讯设施的潜在建设地点，我们的一位资助者趁机抢先建起了一座监听前哨站！你的任务是监视未来可能到来的船员，并记录站内发生的一切事件。如果你是纳米传讯的员工，在这座前哨站尚未正式建立前偶然发现了它：<b>请忽略这份文件</b>。"}

/obj/item/paper/fluff/ruins/tram_syndicate/blueprints
	name = "空间站布局"
	icon = 'icons/obj/scrolls.dmi'
	icon_state = "blueprints"
	inhand_icon_state = "blueprints"
	default_raw_text = {"依据泄露的内部文件和施工期间拍摄的轨道快照绘制的粗略空间站布局图。
	<br><i>你也不确定这东西还有几分准确……</i>"}
	show_written_words = FALSE // Blueprints don't have a "blueprints_words" icon state.
