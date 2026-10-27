/obj/structure/billboard
	name = "空白广告牌"
	desc = "一块空白的广告牌，还有空间登各种广告。"
	icon = 'icons/obj/fluff/billboard.dmi'
	icon_state = "billboard_blank"
	plane = ABOVE_GAME_PLANE
	max_integrity = 1000
	bound_width = 96
	bound_height = 32
	density = TRUE
	anchored = TRUE

/obj/structure/billboard/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/seethrough, SEE_THROUGH_MAP_BILLBOARD)

/obj/structure/billboard/donk_n_go
	name = "\improper 咚克即走广告牌"
	desc = "一块宣传咚克即走的广告牌，这是咚克公司那家无处不在、也永远不健康的快餐生意：进来，吃饱，走人！"
	icon_state = "billboard_donk_n_go"

/obj/structure/billboard/space_cola
	name = "\improper 太空可乐广告牌"
	desc = "一块宣传太空可乐的广告牌：放松一下，来瓶太空可乐。"
	icon_state = "billboard_space_cola"

/obj/structure/billboard/nanotrasen
	name = "\improper 纳米传讯广告牌"
	desc = "一块宣传纳米传讯的广告牌：更美好的明天，就在今天。"
	icon_state = "billboard_nanotrasen"

/obj/structure/billboard/nanotrasen/defaced
	name = "被涂污的纳米传讯广告牌"
	desc = "一块宣传纳米传讯的广告牌。有人在上面喷了一行字：去你妈的公司猪。"
	icon_state = "billboard_fuck_corps"

/obj/structure/billboard/azik
	name = "\improper 阿兹克星际广告牌"
	desc = "一块宣传阿兹克星际及其最新型号“独裁者级太阳帆船”的广告牌。阿兹克星际：提兹拉精工，满足银河所需。"
	icon_state = "billboard_azik"

/obj/structure/billboard/cvr
	name = "\improper 查理曼·冯·莱茵兰广告牌"
	desc = "一块宣传查理曼·冯·莱茵兰旗下日耳曼尼亚级超级游艇的广告牌。查理曼·冯·莱茵兰：Die Werft der Könige。"
	icon_state = "billboard_cvr"

/obj/structure/billboard/twenty_four_seven
	name = "\improper 全天候广告牌"
	desc = "一块宣传全天候新款限定冰沙口味的广告牌。全天候：全天候，每一天。"
	icon_state = "billboard_twenty_four_seven"

/obj/structure/billboard/starway
	name = "\improper 星路客运广告牌"
	desc = "一块宣传星路客运从新莫斯科直飞纽约航线的广告牌：经济舱座位仅需 2000 信用点。星路：通往群星的机票。"
	icon_state = "billboard_starway"

/obj/structure/billboard/lizards_gas
	name = "\improper 蜥蜴加油站广告牌"
	desc = "一块标出名为“蜥蜴加油站”的加油站的广告牌。它早已湮没于时光，这是已知唯一一座这类加油站。就这块广告牌的水平来看，很难理解它当年为什么会失败。"
	icon_state = "billboard_lizards_gas"

/obj/structure/billboard/lizards_gas/defaced
	desc = "一块标出名为“蜥蜴加油站”的加油站的广告牌。这块用心绘制的广告牌被人涂鸦过，又有位好心的陌生人把那些恶毒的涂鸦盖掉了。"
	icon_state = "billboard_lizards_gas_defaced"

/obj/structure/billboard/roadsign
	name = "\improper 路牌广告牌"
	desc = "一块告诉读者距加油站还有多少英里的广告牌。不过这块上似乎是空白的。"
	icon_state = "billboard_roadsign_blank"

/obj/structure/billboard/roadsign/two
	desc = "一块告诉读者距下一个加油站还有多少英里的广告牌。实在看不出这块牌子有什么用。"
	icon_state = "billboard_roadsign_two"

/obj/structure/billboard/roadsign/twothousand
	desc = "一块告诉读者距下一个加油站还有多少英里的广告牌。看到这种牌子，你大概该开始囤粮囤油了。"
	icon_state = "billboard_roadsign_twothousand"

/obj/structure/billboard/roadsign/twomillion
	desc = "一块告诉读者距下一个加油站还有多少英里的广告牌。如果你能完成数百万英里的行程，这根本不算什么！如果你不能……"
	icon_state = "billboard_roadsign_twomillion"

/obj/structure/billboard/roadsign/error
	desc = "一块告诉读者距下一个加油站还有多少英里的广告牌。这是一块固定标牌，所以你不禁要问，究竟什么样的人会把它印出来还挂上去。"
	icon_state = "billboard_roadsign_error"

/obj/structure/billboard/smoothies
	name = "\improper 顺旋冰沙广告牌"
	desc = "一块宣传顺旋冰沙的广告牌。"
	icon_state = "billboard_smoothies"

/obj/structure/billboard/fortune_telling
	name = "\improper 算命广告牌"
	desc = "一块宣传算命的广告牌。据说还是真灵能者来算的！"
	icon_state = "billboard_fortune_tell"

/obj/structure/billboard/Phone_booth
	name = "\improper 全息电话广告牌"
	desc = "一块宣传全息电话的广告牌。星际通话只要 49.99 信用点，还附赠免税零食！"
	icon_state = "billboard_phone"

/obj/structure/billboard/american_diner
	name = "\improper 全美餐馆广告牌"
	desc = "一块宣传老派 1950 年代主题连锁餐厅“全美餐馆”的广告牌"
	icon_state = "billboard_american_diner"

/obj/structure/billboard/gloves
	name = "\improper 罗罗公司手套广告牌"
	desc = "一块宣传罗罗公司的广告牌，这家公司生产绝缘手套及绝缘手套配件。牌上画着该公司惹人喜爱的吉祥物罗罗。"
	icon_state = "billboard_gloves"
