/obj/item/food/pie
	icon = 'icons/obj/food/piecake.dmi'
	inhand_icon_state = "pie"
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("派" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this pie when processed by cutting tool
	var/obj/item/food/pieslice/slice_type
	/// so that the yield can change if it isn't 5
	var/yield = 5

/obj/item/food/pie/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, table_required = TRUE, screentip_verb = "切片", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/pieslice
	name = "派切片"
	icon = 'icons/obj/food/piecake.dmi'
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("派" = 1, "不确定感" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pie/plain
	name = "原味派"
	desc = "一个简单的派，依然美味。"
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("派" = 1)
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pie/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, /obj/item/food/pie/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/pie/empty
	name = "派"
	desc = "由疯狂厨师制作的自定义派。"
	icon_state = "pie_custom"
	slice_type = /obj/item/food/pieslice/empty

/obj/item/food/pieslice/empty
	name = "派切片"
	desc = "由疯狂厨师制作的自定义派切片。"
	icon_state = "pie_custom_slice"

/obj/item/food/pieslice/empty/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ingredients_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/pie/cream
	name = "香蕉奶油派"
	desc = "就像在小丑星的老家一样！HONK！"
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|FRUIT
	var/stunning = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/cream/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/splat, hit_callback = CALLBACK(src, PROC_REF(stun_and_blur)))

/obj/item/food/pie/cream/proc/stun_and_blur(mob/living/victim, can_splat_on)
	if(stunning)
		victim.Paralyze(2 SECONDS) //splat!
	if(can_splat_on)
		victim.adjust_eye_blur(2 SECONDS)
	victim.visible_message(span_warning("[victim] 被 [src] 糊了一脸奶油！"), span_userdanger("你被 [src] 糊了一脸奶油！"))
	playsound(victim, SFX_DESECRATION, 50, TRUE)

/obj/item/food/pie/cream/nostun
	stunning = FALSE

/obj/item/food/pie/berryclafoutis
	name = "浆果克拉芙缇"
	desc = "没有黑鸟，这是个好兆头。"
	icon_state = "berryclafoutis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/berryjuice = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "黑莓" = 1)
	foodtypes = GRAIN|FRUIT|DAIRY|SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/bearypie
	name = "熊熊派"
	desc = "没有棕熊，这是个好兆头。"
	icon_state = "bearypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "肉" = 1, "三文鱼" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR|MEAT|FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pie/meatpie
	name = "肉派"
	icon_state = "meatpie"
	desc = "一份古老的理发师配方，非常美味！"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("派" = 1, "肉" = 1)
	foodtypes = GRAIN|DAIRY|MEAT
	venue_value = FOOD_PRICE_NORMAL
	slice_type = /obj/item/food/pieslice/meatpie
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pieslice/meatpie
	name = "肉派切片"
	desc = "哦不错，肉派！"
	icon_state = "meatpie_slice"
	tastes = list("派" = 1, "肉" = 1)
	foodtypes = GRAIN|DAIRY|MEAT
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT / 5)

/obj/item/food/pie/tofupie
	name = "豆腐派"
	icon_state = "meatpie"
	desc = "美味的豆腐派。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "豆腐" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES
	slice_type = /obj/item/food/pieslice/tofupie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/tofupie
	name = "豆腐派切片"
	desc = "哦不错，肉派——等等！！"
	icon_state = "meatpie_slice"
	tastes = list("派" = 1, "失望" = 1, "豆腐" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/amanita_pie
	name = "毒蝇伞派"
	desc = "香甜美味的毒派。"
	icon_state = "amanita_pie"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/amatoxin = 3,
		/datum/reagent/drug/mushroomhallucinogen = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "蘑菇" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|TOXIC|GROSS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/plump_pie
	name = "肥盔菇派"
	desc = "我敢打赌你超爱用肥盔菇做的东西！"
	icon_state = "plump_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "蘑菇" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/plump_pie/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "极品肥盔菇派"
		desc = "微波炉陷入了奇异的心境！它烤出了一个极品肥盔菇派！"
		food_reagents = list(
			/datum/reagent/consumable/nutriment = 11,
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment/vitamin = 4,
		)
	. = ..()

/obj/item/food/pie/xemeatpie
	name = "异形派"
	icon_state = "xenomeatpie"
	desc = "美味的肉派。大概算是异端。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "肉" = 1, "酸" = 1)
	foodtypes = MEAT|GRAIN|DAIRY
	slice_type = /obj/item/food/pieslice/xemeatpie
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)

/obj/item/food/pieslice/xemeatpie
	name = "异形派切片"
	desc = "天啊……那东西还在动吗？"
	icon_state = "xenopie_slice"
	tastes = list("派" = 1, "酸" = 1, "肉" = 1)
	foodtypes = GRAIN|DAIRY|MEAT
	crafting_complexity = FOOD_COMPLEXITY_3
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT / 5)

/obj/item/food/pie/applepie
	name = "苹果派"
	desc = "一个装着甜甜爱意……或者苹果的派。"
	icon_state = "applepie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "苹果" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	slice_type = /obj/item/food/pieslice/apple
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/apple
	name = "苹果派切片"
	desc = "一片温馨的苹果派，温暖的秋日回忆在前。"
	icon_state = "applepie_slice"
	tastes = list("派" = 1, "苹果" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3


/obj/item/food/pie/cherrypie
	name = "樱桃派"
	desc = "好吃到让成年男人落泪。"
	icon_state = "cherrypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 7, "妮可·佩吉·布鲁克斯" = 2)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	slice_type = /obj/item/food/pieslice/cherry
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/cherry
	name = "樱桃派切片"
	desc = "一片美味的樱桃派，希望用的是莫雷洛樱桃！"
	icon_state = "cherrypie_slice"
	tastes = list("派" = 1, "苹果" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/pumpkinpie
	name = "南瓜派"
	desc = "秋日月份的美味点心。"
	icon_state = "pumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "南瓜" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	slice_type = /obj/item/food/pieslice/pumpkin
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/pumpkin
	name = "南瓜派切片"
	desc = "一片南瓜派，上面淋着打发奶油。完美。"
	icon_state = "pumpkinpieslice"
	tastes = list("派" = 1, "南瓜" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/appletart
	name = "金苹果酥粒挞"
	desc = "美味的甜点，过不了金属探测器。"
	icon_state = "gappletart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/gold = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "苹果" = 1, "昂贵的金属" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/grapetart
	name = "葡萄挞"
	desc = "美味的甜点，让你想起自己没酿成的葡萄酒。"
	icon_state = "grapetart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "葡萄" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/mimetart
	name = "默剧演员挞"
	desc = "..."
	icon_state = "mimetart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nothing = 10,
	)
	tastes = list("虚无" = 3)
	foodtypes = GRAIN|DAIRY|SUGAR
	crafted_food_buff = /datum/status_effect/food/trait/mute

/obj/item/food/pie/berrytart
	name = "浆果挞"
	desc = "薄派皮上铺满各种小浆果的美味甜点。"
	icon_state = "berrytart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "浆果" = 2)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR

/obj/item/food/pie/cocolavatart
	name = "巧克力熔岩挞"
	desc = "由巧克力制成的美味甜点，内芯是流心的。" //But it doesn't even contain chocolate...
	icon_state = "cocolavatart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "黑巧克力" = 3)
	foodtypes = GRAIN|DAIRY|SUGAR

/obj/item/food/pie/blumpkinpie
	name = "蓝南瓜派"
	desc = "用有毒蓝南瓜做成的古怪蓝色派。"
	icon_state = "blumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 13,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "满嘴泳池水" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	slice_type = /obj/item/food/pieslice/blumpkin
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/blumpkin
	name = "蓝南瓜派切片"
	desc = "一片蓝南瓜派，上面淋着打发奶油。这能吃吗？"
	icon_state = "blumpkinpieslice"
	tastes = list("派" = 1, "满嘴泳池水" = 1)
	foodtypes = GRAIN|DAIRY|VEGETABLES|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/dulcedebatata
	name = "红薯甜糕"
	desc = "用红薯制成的美味甜冻。"
	icon_state = "dulcedebatata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("果冻" = 1, "红薯" = 1)
	foodtypes = VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_EXOTIC
	slice_type = /obj/item/food/pieslice/dulcedebatata
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/dulcedebatata
	name = "红薯甜糕切片"
	desc = "一片香甜的红薯甜冻。"
	icon_state = "dulcedebatataslice"
	tastes = list("果冻" = 1, "红薯" = 1)
	foodtypes = VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/frostypie
	name = "霜冻派"
	desc = "尝起来像蓝色和寒冷。"
	icon_state = "frostypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("薄荷" = 1, "派" = 1)
	foodtypes = GRAIN|DAIRY|FRUIT|SUGAR
	slice_type = /obj/item/food/pieslice/frostypie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/frostypie
	name = "霜冻派切片"
	desc = "美味的蓝色，就像我最爱的蜡笔！"
	icon_state = "frostypie_slice"
	tastes = list("派" = 1, "薄荷" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/baklava
	name = "果仁蜜饼"
	desc = "由坚果层与薄面皮制成的令人愉悦的健康点心。"
	icon_state = "baklava"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("坚果" = 1, "派" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	slice_type = /obj/item/food/pieslice/baklava
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pieslice/baklava
	name = "果仁蜜饼一份"
	desc = "一份由坚果层与薄面皮制成的令人愉悦的健康点心"
	icon_state = "baklavaslice"
	tastes = list("坚果" = 1, "派" = 1)
	foodtypes = GRAIN|DAIRY|SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/frenchsilkpie
	name = "法式丝绸派"
	desc = "由奶油巧克力慕斯内馅制成、顶部铺着打发奶油与巧克力碎屑的奢华派。可切片。"
	icon_state = "frenchsilkpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "丝滑巧克力" = 1, "打发奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/pieslice/frenchsilk
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/frenchsilk
	name = "法式丝绸派切片"
	desc = "一片法式丝绸派，内馅是巧克力慕斯，顶部铺着打发奶油与巧克力碎屑。美味到让你落泪。"
	icon_state = "frenchsilkpieslice"
	tastes = list("派" = 1, "丝滑巧克力" = 1, "打发奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/shepherds_pie
	name = "牧羊人派"
	desc = "由肉末与什锦蔬菜在奶油土豆泥层下烤制而成的菜肴。可切片。"
	icon_state = "shepherds_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("多汁的肉" = 2, "土豆泥" = 2, "烤蔬菜" = 2)
	foodtypes = MEAT | DAIRY | VEGETABLES
	slice_type = /obj/item/food/pieslice/shepherds_pie
	yield = 4
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)

/obj/item/food/pieslice/shepherds_pie
	name = "牧羊人派切片"
	desc = "一份凌乱的牧羊人派切片，由肉末与什锦蔬菜在奶油土豆泥层下烤制而成。危险地美味。"
	icon_state = "shepherds_pie_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("多汁的肉" = 1, "土豆泥" = 1, "烤蔬菜" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_5
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT)

/obj/item/food/pie/asdfpie
	name = "派味派"
	desc = "我给你烤了个派！"
	icon_state = "asdfpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("派" = 1, "遥远的 2010 年" = 1)
	foodtypes = GRAIN|DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pie/bacid_pie
	name = "电池酸液派"
	desc = "哦，这是个用……电池酸液做的派？你想以太人或许会觉得吃这个挺享受。"
	icon_state = "bacid_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/liquidelectricity = 18
	)
	tastes = list("电池酸液" = 2, "电流" = 2, "赛博世界" = 2)
	foodtypes = GRAIN|DAIRY|TOXIC
	slice_type = /obj/item/food/pieslice/bacid_pie
	yield = 4
	crafting_complexity = FOOD_COMPLEXITY_3


/obj/item/food/pieslice/bacid_pie
	name = "电池酸液派切片"
	desc = "电池酸液内馅呈现出一种令人不安却诱人的亮绿色"
	icon_state = "bacid_pie_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4.5,
		/datum/reagent/consumable/liquidelectricity = 4.5
	)
	tastes = list("电池酸液" = 1, "电流" = 1, "赛博世界" = 1)
	foodtypes = TOXIC
	crafting_complexity = FOOD_COMPLEXITY_3
