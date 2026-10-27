/obj/item/toy/xmas_cracker
	name = "圣诞拉炮"
	icon = 'icons/obj/holiday/christmas.dmi'
	icon_state = "cracker"
	desc = "使用说明：需要两个人，各拉一端。"
	w_class = WEIGHT_CLASS_TINY
	/// The crack state of the toy. If set to TRUE, you can no longer crack it by attacking.
	var/cracked = FALSE

/obj/item/toy/xmas_cracker/attack(mob/target, mob/user)
	if( !cracked && ishuman(target) && (!IS_UNCONSCIOUS_OR_CRIT(target)) && !target.get_active_held_item() )
		target.visible_message(span_notice("[user] 和 [target] 拉开了 [src]！*啪*"), span_notice("你和 [target] 拉开了 [src]！*啪*"), span_hear("你听到一声爆响。"))
		var/obj/item/paper/joke_paper = new /obj/item/paper(user.loc)
		joke_paper.name = "[pick("糟糕","极烂","毫无笑点")]笑话"
		joke_paper.add_raw_text(pick("一个雪人对另一个雪人说了什么？\n\n<i>“是我出了问题，还是你闻到了胡萝卜味？”</i>",
			"雪人为什么没人要？\n\n<i>因为他太冷淡了！</i>",
			"圣诞老人的帮手在哪里上学？\n\n<i>哪里都不上，他们都是精灵自学的。</i>",
			"偷走降临节日历的人后来怎样了？\n\n<i>他得到了 25 天。</i>",
			"圣诞老人卡在烟囱里会得什么？\n\n<i>幽闭恐惧症（Claus-trophobia）。</i>",
			"你在哪里能找到辣椒豆？\n\n<i>北极。</i>",
			"吃了圣诞树装饰会得什么？\n\n<i>金属丝炎（Tinsilitis）！</i>",
			"雪人头上戴什么？\n\n<i>冰帽！</i>",
			"圣诞节为什么和空间站 13 上的生活一样？\n\n<i>活都是你干的，功劳全归那个胖子。</i>",
			"圣诞老人为什么没有孩子？\n\n<i>因为他只会从烟囱下来。</i>"))
		joke_paper.update_appearance()
		new /obj/item/clothing/head/costume/festive(target.loc)
		user.update_icons()
		cracked = TRUE
		icon_state = "cracker1"
		var/obj/item/toy/xmas_cracker/other_half = new /obj/item/toy/xmas_cracker(target)
		other_half.cracked = 1
		other_half.icon_state = "cracker2"
		target.put_in_active_hand(other_half)
		playsound(user, 'sound/effects/snap.ogg', 50, TRUE)
		return TRUE
	return ..()

/obj/item/clothing/head/costume/festive
	name = "节日纸帽"
	icon_state = "xmashat"
	desc = "一顶你必须戴着的破烂纸帽。"
	flags_inv = 0
	armor_type = /datum/armor/none
	dog_fashion = /datum/dog_fashion/head/festive

/obj/effect/spawner/xmastree
	name = "圣诞树生成器"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	layer = FLY_LAYER
	plane = ABOVE_GAME_PLANE

	/// Christmas tree, no presents included.
	var/festive_tree = /obj/structure/flora/tree/pine/xmas
	/// Christmas tree, presents included.
	var/christmas_tree = /obj/structure/flora/tree/pine/xmas/presents/safe // BUBBER EDIT - Previous: /obj/structure/flora/tree/pine/xmas/presents

/obj/effect/spawner/xmastree/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS) && christmas_tree)
		new christmas_tree(get_turf(src))
	else if(check_holidays(FESTIVE_SEASON) && festive_tree)
		new festive_tree(get_turf(src))

/obj/effect/spawner/xmastree/rdrod
	name = "节日杆生成器"
	festive_tree = /obj/structure/festivus
	christmas_tree = null

/datum/round_event_control/santa
	name = "圣诞老人来访"
	holidayID = CHRISTMAS
	typepath = /datum/round_event/ghost_role/santa
	weight = 20
	max_occurrences = 1
	earliest_start = 30 MINUTES
	category = EVENT_CATEGORY_HOLIDAY
	description = "生成圣诞老人，他会在站内四处游荡并派发礼物。"

/datum/round_event/ghost_role/santa
	role_name = "圣诞老人"
	var/mob/living/carbon/human/santa //who is our santa?

/datum/round_event/ghost_role/santa/announce(fake)
	priority_announce("圣诞老人进城了！", "未知传输")

/datum/round_event/ghost_role/santa/start()
	var/mob/chosen_one = SSpolling.poll_ghost_candidates("圣诞老人进城了！你想成为[span_notice("圣诞老人")]吗？", poll_time = 15 SECONDS, alert_pic = /obj/item/clothing/head/costume/santa, role_name_text = "圣诞老人", amount_to_pick = 1)
	if(isnull(chosen_one))
		return NOT_ENOUGH_PLAYERS
	santa = new /mob/living/carbon/human(pick(GLOB.blobstart))
	santa.PossessByPlayer(chosen_one.key)
	var/datum/antagonist/santa/A = new
	santa.mind.add_antag_datum(A)
