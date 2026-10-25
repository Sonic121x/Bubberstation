/obj/item/organ/heart/gland/spiderman
	abductor_hint = "蛛形隐居加速器。被绑架者会偶尔呼出蜘蛛信息素并产下幼蛛。"
	cooldown_low = 450
	cooldown_high = 900
	uses = -1
	icon_state = "spider"
	mind_control_uses = 2
	mind_control_duration = 2400

/obj/item/organ/heart/gland/spiderman/activate()
	to_chat(owner, span_warning("你感觉有东西在皮肤下爬动。"))
	owner.add_faction(FACTION_SPIDER)
	var/mob/living/basic/spider/growing/spiderling/spider = new(owner.drop_location())
	spider.directive = "保护你位于[owner.real_name]体内的巢穴。"
