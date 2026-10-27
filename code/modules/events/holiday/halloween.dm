/datum/round_event_control/spooky
	name = "2 惊魂！（万圣节）"
	holidayID = HALLOWEEN
	typepath = /datum/round_event/spooky
	weight = -1 //forces it to be called, regardless of weight
	max_occurrences = 1
	earliest_start = 0 MINUTES
	category = EVENT_CATEGORY_HOLIDAY
	description = "给每个人发放糖果，并把伊恩和波利变成它们的节日形态。"

/datum/round_event/spooky/start()
	..()
	for(var/i in GLOB.human_list)
		var/mob/living/carbon/human/H = i
		var/obj/item/storage/backpack/b = locate() in H.contents
		if(b)
			new /obj/item/storage/spooky(b)

	for(var/mob/living/basic/pet/dog/corgi/ian/Ian in GLOB.mob_living_list)
		Ian.place_on_head(new /obj/item/bedsheet(Ian))
	for(var/mob/living/basic/parrot/poly/bird in GLOB.mob_living_list)
		new /mob/living/basic/parrot/poly/ghost(bird.loc)
		qdel(bird)

/datum/round_event/spooky/announce(fake)
	priority_announce(pick("我的骨头咔咔作响！","这趟旅程永不结束！", "一具骷髅蹦了出来！", "毛骨悚然的骷髅！", "船员们当心，你们要大难临头了！") , "电话是从屋内打来的！")

//spooky foods (you can't actually make these when it's not halloween)
/obj/item/food/cookie/sugar/spookyskull
	name = "骷髅饼干"
	desc = "惊悚！带着美味的钙质风味！"
	icon = 'icons/obj/holiday/halloween_items.dmi'
	icon_state = "skeletoncookie"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/spookyskull/Initialize(mapload, seasonal_changes = FALSE)
	// Changes default parameter of seasonal_changes to FALSE, pass to parent
	return ..(mapload, seasonal_changes)

/obj/item/food/cookie/sugar/spookycoffin
	name = "棺材饼干"
	desc = "惊悚！带着美味的咖啡风味！"
	icon = 'icons/obj/holiday/halloween_items.dmi'
	icon_state = "coffincookie"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/spookycoffin/Initialize(mapload, seasonal_changes = FALSE)
	// Changes default parameter of seasonal_changes to FALSE, pass to parent
	return ..(mapload, seasonal_changes)

//spooky items

/obj/item/storage/spooky
	name = "不给糖就捣蛋袋"
	desc = "一个南瓜形状的袋子，里面装满了各种好东西！"
	icon = 'icons/obj/holiday/halloween_items.dmi'
	icon_state = "treatbag"

/obj/item/storage/spooky/Initialize(mapload)
	. = ..()
	for(var/distrobuteinbag in 0 to 5)
		var/type = pick(/obj/item/food/cookie/sugar/spookyskull,
		/obj/item/food/cookie/sugar/spookycoffin,
		/obj/item/food/candy_corn,
		/obj/item/food/candy,
		/obj/item/food/candiedapple,
		/obj/item/food/chocolatebar,
		/obj/item/organ/brain ) // OH GOD THIS ISN'T CANDY!
		new type(src)
