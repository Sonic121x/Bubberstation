/datum/supply_pack/critter
	group = "Livestock"
	crate_type = /obj/structure/closet/crate/critter

/datum/supply_pack/critter/stasis
	crate_type = /obj/structure/closet/crate/critter/stasis

/datum/supply_pack/critter/stasis/fill(obj/container)
	. = ..()
	for(var/mob/living/stasis_mob in container)
		stasis_mob.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_CRATE_EFFECT)

/datum/supply_pack/critter/parrot
	name = "鸟类板条箱"
	desc = "内含五只专业的电信鸟类。"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/parrot)
	crate_name = "鹦鹉板条箱"

/datum/supply_pack/critter/parrot/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	for(var/i in 1 to 4)
		new /mob/living/basic/parrot(.)

/datum/supply_pack/critter/butterfly
	name = "蝴蝶板条箱"
	desc = "算不上很危险的昆虫，但比苍蝇或蟑螂之流能给人更好的印象。"//is that a motherfucking worm reference
	order_flags = ORDER_CONTRABAND
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/mob/living/basic/butterfly)
	crate_name = "昆虫学样本板条箱"

/datum/supply_pack/critter/butterfly/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/basic/butterfly(.)

/datum/supply_pack/critter/cat
	name = "猫板条箱"
	desc = "猫咪喵喵叫！附赠一个项圈和一件漂亮的猫玩具！不含芝士汉堡。"//i can't believe im making this reference
	cost = CARGO_CRATE_VALUE * 4 //Cats are worth as much as corgis.
	contains = list(
		/mob/living/basic/pet/cat,
		/obj/item/clothing/neck/petcollar,
		/obj/item/toy/cattoy,
	)
	crate_name = "猫板条箱"

/datum/supply_pack/critter/cat/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	if(!prob(50))
		return
	var/mob/living/basic/pet/cat/delete_cat = locate() in .
	if(isnull(delete_cat))
		return
	qdel(delete_cat)
	new /mob/living/basic/pet/cat/_proc(.)

/datum/supply_pack/critter/chick
	name = "鸡板条箱"
	desc = "母鸡咯咯叫！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/mob/living/basic/chick)
	crate_name = "鸡板条箱"

/datum/supply_pack/critter/corgi
	name = "柯基板条箱"
	desc = "数千名科研人员公认的最优犬种，这只柯基只是伊恩高贵血统 \
		数百万后代中的一只。附赠一个可爱项圈！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/pet/dog/corgi,
					/obj/item/clothing/neck/petcollar,
				)
	crate_name = "柯基板条箱"

/datum/supply_pack/critter/corgi/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	if(prob(50))
		var/mob/living/basic/pet/dog/corgi/D = locate() in .
		if(D.gender == FEMALE)
			qdel(D)
			new /mob/living/basic/pet/dog/corgi/lisa(.)

/datum/supply_pack/critter/cow
	name = "牛板条箱"
	desc = "奶牛哞哞叫！内含一头牛。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/mob/living/basic/cow)
	crate_name = "牛板条箱"

/datum/supply_pack/critter/sheep
	name = "绵羊板条箱"
	desc = "绵羊咩咩叫！内含一只绵羊。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/mob/living/basic/sheep)
	crate_name = "绵羊板条箱"

/datum/supply_pack/critter/pig
	name = "猪板条箱"
	desc = "猪哼哼叫！内含一头猪。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/mob/living/basic/pig)
	crate_name = "猪板条箱"

/datum/supply_pack/critter/pony
	name = "小马板条箱"
	desc = "小马，耶！（只有一匹。）"
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/mob/living/basic/pony)
	crate_name = "小马板条箱"

/datum/supply_pack/critter/crab
	name = "螃蟹火箭"
	desc = "螃螃螃螃螃！螃蟹火箭。螃蟹火箭。螃蟹火箭。螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹 \
		蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹 \
		蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹 \
		蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹火箭。快造。火箭。快买。快造火箭。螃蟹火火箭。 \
		螃蟹火火火箭。螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹螃蟹火火火火火火火火火火火火 \
		箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭箭 \
		箭箭箭箭箭箭箭箭箭箭。螃蟹火箭。螃蟹火火箭。螃蟹螃蟹螃蟹螃蟹螃蟹火箭火火箭。"//fun fact: i actually spent like 10 minutes and transcribed the entire video.
	cost = CARGO_CRATE_VALUE * 8
	contains = list(/mob/living/basic/crab)
	crate_name = "看啊先生，免费螃蟹"
	order_flags = ORDER_POD_ONLY

/datum/supply_pack/critter/crab/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	for(var/i in 1 to 49)
		new /mob/living/basic/crab(.)

/datum/supply_pack/critter/corgis/exotic
	name = "异色柯基板条箱"
	desc = "配得上国王的柯基，这只柯基拥有独一无二的毛色，彰显其优越血统。 \
		附赠一个可爱项圈！"
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/mob/living/basic/pet/dog/corgi/exoticcorgi,
					/obj/item/clothing/neck/petcollar,
				)
	crate_name = "异色柯基板条箱"

/datum/supply_pack/critter/fox
	name = "狐狸板条箱"
	desc = "狐狸怎么叫……？内含一只狐狸。附赠一个项圈！"//what does the fox say
	cost = CARGO_CRATE_VALUE * 4
	contains = list(
		/mob/living/basic/pet/fox,
		/obj/item/clothing/neck/petcollar,
	)
	crate_name = "狐狸板条箱"

/datum/supply_pack/critter/goat
	name = "山羊板条箱"
	desc = "山羊咩咩叫！内含一只山羊。若用作皮特的替代品，保修即告失效。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/mob/living/basic/goat)
	crate_name = "山羊板条箱"

/datum/supply_pack/critter/rabbit
	name = "兔子板条箱"
	desc = "兔子到底是怎么叫的？内含一只兔子。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/mob/living/basic/rabbit)
	crate_name = "兔子板条箱"

/datum/supply_pack/critter/mothroach
	name = "蛾蟑板条箱"
	desc = "把蛾蟑放到头上，亲眼见识真正的可爱长什么样。 \
		内含一只蛾蟑。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/mob/living/basic/mothroach)
	crate_name = "蛾蟑板条箱"

/datum/supply_pack/critter/monkey
	name = "猴子方块板条箱"
	desc = "别再耍猴了！内含七个猴子方块。只需加水！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list (/obj/item/storage/box/monkeycubes)
	crate_type = /obj/structure/closet/crate
	crate_name = "猴子方块板条箱"

/datum/supply_pack/critter/pug
	name = "巴哥犬板条箱"
	desc = "像普通的狗，但……被压扁了。内含一只巴哥犬。附赠一个漂亮项圈！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/pet/dog/pug,
					/obj/item/clothing/neck/petcollar,
				)
	crate_name = "巴哥犬板条箱"

/datum/supply_pack/critter/bullterrier
	name = "牛头梗板条箱"
	desc = "像普通的狗，但脑袋是鸡蛋形状。内含一只牛头梗。 \
		附赠一个漂亮项圈！"
	cost = CARGO_CRATE_VALUE * 4
	contains = list(/mob/living/basic/pet/dog/bullterrier,
					/obj/item/clothing/neck/petcollar,
				)
	crate_name = "牛头梗板条箱"

/datum/supply_pack/critter/snake
	name = "蛇板条箱"
	desc = "受够了这座该死的空间站上这些他妈的蛇？ \
		那这个板条箱不适合你。内含三条毒蛇。"
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/mob/living/basic/snake = 3)
	crate_name = "蛇板条箱"

/datum/supply_pack/critter/amphibians
	name = "两栖动物好友板条箱"
	desc = "两个黏糊糊、可爱得让人受不了的朋友。细胞学家最爱它们！ \
		内含一只青蛙和一只美西螈。警告：青蛙可能具有致幻特性。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(
		/mob/living/basic/axolotl,
		/obj/effect/spawner/random/frog,
	)
	crate_name = "两栖动物板条箱"

/datum/supply_pack/critter/lizard
	name = "蜥蜴板条箱"
	desc = "嘶嘶！内含一只友善的蜥蜴。别和蜥蜴人搞混了。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/mob/living/basic/lizard)
	crate_name = "蜥蜴板条箱"

/datum/supply_pack/critter/garden_gnome
	name = "花园地精板条箱"
	desc = "为你的花园把它们收集齐全吧。内含三个！"
	order_flags = ORDER_EMAG_ONLY
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/mob/living/basic/garden_gnome)
	crate_name = "花园地精板条箱"
	discountable = SUPPLY_PACK_RARE_DISCOUNTABLE

/datum/supply_pack/critter/garden_gnome/generate(atom/A, datum/bank_account/paying_account, crate_override)
	. = ..()
	for(var/i in 1 to 2)
		new /mob/living/basic/garden_gnome(.)

/datum/supply_pack/critter/fish
	test_ignored = TRUE // However, we should be wary of how possible it is to get more valuable fish out of this on average, depending on sample size.

/datum/supply_pack/critter/fish/aquarium_fish
	name = "水族箱鱼类箱"
	desc = "由猴子从我们的收藏中亲自挑选的水族鱼组合。内含两条随机鱼类。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/fish_case/random = 2)
	crate_name = "水族鱼板条箱"

/datum/supply_pack/critter/fish/freshwater_fish
	name = "淡水鱼箱"
	desc = "已清除大部分泥污的水族鱼。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/fish_case/random/freshwater = 2)
	crate_name = "淡水鱼板条箱"

/datum/supply_pack/critter/fish/saltwater_fish
	name = "海水鱼箱"
	desc = "能让房间充满海水咸味的水族鱼。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/fish_case/random/saltwater = 2)
	crate_name = "海水鱼板条箱"

/datum/supply_pack/critter/fish/tiziran_fish
	name = "提兹拉鱼箱"
	desc = "从扎戈斯海进口的提兹拉海水鱼。"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/storage/fish_case/tiziran = 2)
	crate_name = "提兹拉鱼板条箱"

/datum/supply_pack/critter/stasis/turtle
	name = "陆龟板条箱"
	desc = "可爱的植物陆龟，会向附近植物散发美好气息！"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/mob/living/basic/turtle)
	crate_name = "植物陆龟静滞板条箱"
