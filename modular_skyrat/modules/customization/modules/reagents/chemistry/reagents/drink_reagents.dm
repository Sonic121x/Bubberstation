// Modular DRINK REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/pinkmilk
	name = "草莓奶"
	description = "一杯来自往昔时代的饮品，牛奶与人工甜味剂的味道仿佛回到了某颗岩质星球上的日子。"
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "甜甜的草莓与奶霜"

/datum/glass_style/drinking_glass/pinkmilk
	required_drink_type = /datum/reagent/consumable/pinkmilk
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "pinkmilk"
	name = "高杯草莓奶"
	desc = "美味的草莓糖浆风味，混合着牛奶。"

/datum/reagent/consumable/pinkmilk/on_mob_life(mob/living/carbon/M)
	if(prob(15))
		to_chat(M, span_notice("[pick("你忍不住微笑起来。","你突然感到一阵怀念。","你想起了要放松一下。")]"))
	..()
	. = 1

/datum/reagent/consumable/pinktea //Tiny Tim song
	name = "草莓茶"
	description = "永恒的经典！"
	color = "#f76aeb"//rgb(247, 106, 235)
	quality = DRINK_VERYGOOD
	taste_description = "带有一丝草莓味的甜茶"

/datum/glass_style/drinking_glass/pinktea
	required_drink_type = /datum/reagent/consumable/pinktea
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "pinktea"
	name = "一杯草莓茶"
	desc = "以草莓调味的传统好茶。"

/datum/reagent/consumable/pinktea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		to_chat(M, span_notice("[pick("钻石般的天空，白鹿在其中飞翔。","啜饮着草莓茶。","银色的雨滴飘过永恒无尽的六月。","水晶……珍珠自由，满载爱意！","把爱意照进我心中。")]"))
	..()
	. = TRUE

/datum/reagent/consumable/catnip_tea
	name = "猫薄荷茶"
	description = "一杯令人困倦又美味的猫薄荷茶！"
	color = "#101000" // rgb: 16, 16, 0
	taste_description = "糖与猫薄荷"

/datum/glass_style/drinking_glass/catnip_tea
	required_drink_type = /datum/reagent/consumable/catnip_tea
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "catnip_tea"
	name = "一杯猫薄荷茶"
	desc = "对猫来说喵不可言的饮品。"

/datum/reagent/consumable/catnip_tea/on_mob_life(mob/living/carbon/M)
	M.adjust_stamina_loss(min(50 - M.get_stamina_loss(), 3))
	if(isfeline(M))
		if(prob(20))
			M.emote("nya")
		if(prob(20))
			to_chat(M, span_notice("[pick("被摸头的感觉真好。", "要是有人给揉背就好了。", "喵")]"))
	else
		to_chat(M, span_notice("[pick("我感到莫名的平静。", "我感到很放松。", "喵？")]"))
	..()

/datum/reagent/consumable/ethanol/beerbatter
	name = "啤酒面糊"
	description = "喝下这种……糊状物，大概不是什么好主意。"
	color = "#f5f4e9"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	taste_description = "面粉与廉价酒"
	boozepwr = 8 // beer diluted at about a 1:3 ratio
	ph = 6

/datum/glass_style/drinking_glass/beerbatter
	required_drink_type = /datum/reagent/consumable/ethanol/beerbatter
	icon = 'icons/obj/drinks/shakes.dmi'
	icon_state = "chocolatepudding"
	name = "一杯啤酒面糊"
	desc = "用于烹饪，纯正胆固醇，苏格兰人真吃这个。"

/datum/reagent/consumable/liz_fizz
	name = "蜥蜴汽水"
	description = "三重柑橘风味，层层叠入冰块与奶油。"
	color = "#D8FF59"
	quality = DRINK_NICE
	taste_description = "冰透大脑的酸味"
