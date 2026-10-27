/obj/item/food/meat
	custom_materials = list(/datum/material/meat = MEATSLAB_MATERIAL_AMOUNT)
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/meat.dmi'
	abstract_type = /obj/item/food/meat
	var/subjectname = ""
	var/subjectjob = null
	var/blood_decal_type = /obj/effect/decal/cleanable/blood

/obj/item/food/meat/Initialize(mapload, blood_dna_list = list("meaty DNA" = get_blood_type(BLOOD_TYPE_MEAT)))
	. = ..()

	if(!blood_decal_type || !length(custom_materials))
		return

	AddComponent(
		/datum/component/blood_walk,\
		blood_type = blood_decal_type,\
		blood_spawn_chance = 45,\
		transfer_blood_dna = TRUE,\
		max_blood = custom_materials[custom_materials[1]] / SHEET_MATERIAL_AMOUNT,\
		blood_dna_info = blood_dna_list,\
	)

	AddComponent(
		/datum/component/bloody_spreader,\
		blood_left = custom_materials[custom_materials[1]] / SHEET_MATERIAL_AMOUNT,\
		blood_dna = blood_dna_list,\
	)

/obj/item/food/meat/slab
	name = "肉"
	desc = "一块肉。"
	icon_state = "meat"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/fat = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //Meat has fats that a food processor can process into cooking oil
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	///Legacy code, handles the coloring of the overlay of the cutlets made from this.
	var/slab_color = COLOR_RED


/obj/item/food/meat/slab/make_dryable()
	AddElement(/datum/element/dryable,  /obj/item/food/sosjerky/healthy)

/obj/item/food/meat/slab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/plain, MEATSLAB_PROCESSED_AMOUNT, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

///////////////////////////////////// HUMAN MEATS //////////////////////////////////////////////////////

/obj/item/food/meat/slab/human
	name = "肉"
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/human/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/plain/human, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/human/mutant
	abstract_type = /obj/item/food/meat/slab/human/mutant

/obj/item/food/meat/slab/human/mutant/slime
	icon_state = "slimemeat"
	desc = "因为果冻对素食者还不够冒犯。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/slimejelly = 3,
	)
	tastes = list("史莱姆" = 1, "果冻" = 1)
	foodtypes = MEAT | RAW | TOXIC
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/golem
	icon_state = "golemmeat"
	desc = "可食用的石头，欢迎来到未来。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/iron = 3,
	)
	tastes = list("岩石" = 1)
	foodtypes = MEAT | RAW | STONE
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/golem/adamantine
	icon_state = "agolemmeat"
	desc = "从史莱姆栏到外壳再到厨房，科学。"
	foodtypes = MEAT | RAW | STONE

/obj/item/food/meat/slab/human/mutant/lizard
	icon_state = "lizardmeat"
	desc = "美味的恐龙肉。"
	tastes = list("肉" = 4, "鳞片" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_MUTANT
	starting_reagent_purity = 0.4 // Take a look at their diet

/obj/item/food/meat/slab/human/mutant/lizard/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human/lizard, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/human/mutant/plant
	icon_state = "plantmeat"
	desc = "健康饮食的全部乐趣，外加食人的全部快感。"
	tastes = list("沙拉" = 1, "木头" = 1)
	foodtypes = VEGETABLES
	custom_materials = null
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = /obj/effect/decal/cleanable/food/plant_smudge

/obj/item/food/meat/slab/human/mutant/shadow
	icon_state = "shadowmeat"
	desc = "哎，真是太中二了。"
	tastes = list("黑暗" = 1, "肉" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_MUTANT_RARE

/obj/item/food/meat/slab/human/mutant/fly
	icon_state = "flymeat"
	desc = "没有什么比塞满蛆虫的放射性变异肉更能代表美味了。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/uranium = 3,
	)
	tastes = list("蛆虫" = 1, "反应堆内部" = 1)
	foodtypes = MEAT | RAW | GROSS | BUGS | GORE
	venue_value = FOOD_MEAT_MUTANT
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/human/mutant/moth
	icon_state = "mothmeat"
	desc = "粉末感很强又干，口感很不讨喜。不过还挺好看的。"
	tastes = list("灰尘" = 1, "粉末" = 1, "肉" = 2)
	foodtypes = MEAT | RAW | BUGS | GORE
	venue_value = FOOD_MEAT_MUTANT

/obj/item/food/meat/slab/human/mutant/skeleton
	name = "骨头"
	icon_state = "skeletonmeat"
	desc = "凡事总有个该停下的界限，而我们显然早就越过了。"
	tastes = list("骨头" = 1)
	foodtypes = GROSS | GORE
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/skeleton/make_processable()
	return //skeletons don't have cutlets

/obj/item/food/meat/slab/human/mutant/skeleton/make_grillable()
	return

/obj/item/food/meat/slab/human/mutant/zombie
	name = "肉（腐烂）"
	icon_state = "rottenmeat"
	desc = "已经半只脚踏进你家花园的肥料行列了。"
	tastes = list("脑" = 1, "肉" = 1)
	foodtypes = RAW | MEAT | TOXIC | GORE | GROSS

/obj/item/food/meat/slab/human/mutant/ethereal
	icon_state = "etherealmeat"
	desc = "闪闪发亮，让你觉得吃下去自己也会跟着发光。"
	food_reagents = list(/datum/reagent/consumable/liquidelectricity = 10)
	tastes = list("纯电流" = 2, "肉" = 1)
	foodtypes = RAW | MEAT | TOXIC | GORE
	venue_value = FOOD_MEAT_MUTANT
	blood_decal_type = null

////////////////////////////////////// OTHER MEATS ////////////////////////////////////////////////////////

/obj/item/food/meat/slab/synthmeat
	name = "合成肉"
	icon_state = "meat_old"
	desc = "一块合成肉。"
	foodtypes = RAW | MEAT //hurr durr chemicals were harmed in the production of this meat thus its non-vegan.
	venue_value = FOOD_PRICE_WORTHLESS
	starting_reagent_purity = 0.3

/obj/item/food/meat/slab/synthmeat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/synth, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/meatproduct
	name = "肉制品"
	icon_state = "meatproduct"
	desc = "一块由空间站回收物经化学加工制成的肉制品。"
	tastes = list("肉味香精" = 2, "改性淀粉" = 2, "天然与人工色素" = 1, "丁酸" = 1)
	foodtypes = RAW | MEAT
	starting_reagent_purity = 0.3

/obj/item/food/meat/slab/meatproduct/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/meatproduct, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/monkey
	name = "猴肉"
	foodtypes = RAW | MEAT
	starting_reagent_purity = 0.3 // Monkeys are considered synthetic life

/obj/item/food/meat/slab/bugmeat
	name = "虫肉"
	icon_state = "spidermeat"
	foodtypes = RAW | MEAT | BUGS
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/bugmeat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, health_modifier = 2, color_chances = string_list(list(/datum/raptor_color/green = 2)))

/obj/item/food/meat/slab/mouse
	name = "鼠肉"
	desc = "一块鼠肉。最好别生吃。"
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/mouse/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOUSE, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/corgi
	name = "柯基肉"
	desc = "尝起来像……嗯，你知道的……"
	tastes = list("肉" = 4, "对戴帽子的热爱" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/corgi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CORGI, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/mothroach
	name = "蛾蟑肉"
	desc = "一块清淡的肉。"
	foodtypes = RAW | MEAT | GROSS

/obj/item/food/meat/slab/mothroach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/pug
	name = "巴哥犬肉"
	desc = "尝起来像……嗯，你知道的……"
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/pug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_PUG, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/killertomato
	name = "杀手番茄肉"
	desc = "一片来自巨型番茄的切片。"
	icon_state = "tomatomeat"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	custom_materials = null
	tastes = list("番茄" = 1)
	foodtypes = FRUIT
	blood_decal_type = /obj/effect/decal/cleanable/food/tomato_smudge

/obj/item/food/meat/slab/killertomato/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/killertomato, rand(70 SECONDS, 85 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/killertomato/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/killertomato, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/bear
	name = "熊肉"
	desc = "一块非常有男子气概的肉。"
	icon_state = "bearmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/medicine/morphine = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/fat = 6,
	)
	tastes = list("肉" = 1, "鲑鱼" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/bear/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/bear, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/bear/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/bear, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/bear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BEAR, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/xeno
	name = "异形肉"
	desc = "一块肉。"
	icon_state = "xenomeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 4
	tastes = list("肉" = 1, "酸液" = 1)
	foodtypes = RAW | MEAT
	blood_decal_type = /obj/effect/decal/cleanable/blood/xeno

/obj/item/food/meat/slab/xeno/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/xeno, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/xeno, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/spider
	name = "蜘蛛肉"
	desc = "一块蜘蛛肉。这太卡夫卡了。"
	icon_state = "spidermeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蛛网" = 1)
	foodtypes = RAW | MEAT | TOXIC
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/spider/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/spider, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/spider, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/goliath
	name = "歌利亚肉"
	desc = "一块歌利亚肉。现在不太能吃，但在熔岩里烤得恰到好处。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 5,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	icon_state = "goliathmeat"
	tastes = list("肉" = 1)
	foodtypes = RAW | MEAT | TOXIC
	foodtypes_removed_when_cooked = RAW | TOXIC

/obj/item/food/meat/slab/goliath/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, attack_modifier = 0.5, speed_modifier = -0.05, color_chances = string_list(list(/datum/raptor_color/red = 5)))

/obj/item/food/meat/slab/goliath/burn()
	visible_message(span_notice("[src] 烤好了！"))
	new /obj/item/food/meat/steak/goliath(loc)
	qdel(src)

/obj/item/food/meat/slab/meatwheat
	name = "肉麦团"
	desc = "这看起来不像肉，不过你的标准本来也没<i>那么</i>高。"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/blood = 5, /datum/reagent/consumable/nutriment/fat = 1)
	icon_state = "meatwheat_clump"
	bite_consumption = 4
	tastes = list("肉" = 1, "小麦" = 1)

/obj/item/food/meat/slab/gorilla
	name = "大猩猩肉"
	desc = "比猴肉有肉多了。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat = 5, //Plenty of fat!
	)

/obj/item/food/meat/rawbacon
	name = "生培根片"
	desc = "一片生培根。"
	icon_state = "bacon"
	bite_consumption = 2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("培根" = 1)
	foodtypes = RAW | MEAT
	foodtypes_added_when_cooked = BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/meat/rawbacon/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/bacon, rand(25 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/meat/bacon
	name = "培根片"
	desc = "一片美味的培根。"
	icon_state = "baconcooked"
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	tastes = list("培根" = 1)
	foodtypes = MEAT | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/slab/gondola
	name = "贡多拉肉"
	desc = "古老的传说称，食用生贡多拉肉能让人获得内心的平静。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/gondola_mutation_toxin = 5,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("肉" = 4, "宁静" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/gondola/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/gondola, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/gondola/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/gondola, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/penguin
	name = "企鹅肉"
	icon_state = "birdmeat"
	desc = "一块企鹅肉。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("牛肉" = 1, "鳕鱼" = 1)

/obj/item/food/meat/slab/penguin/make_processable()
	. = ..()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/penguin, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/penguin, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/rawcrab
	name = "生蟹肉"
	desc = "一堆生蟹肉。"
	icon_state = "crabmeatraw"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("生蟹" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/rawcrab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/crab, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/crab
	name = "蟹肉"
	desc = "一些烹制得美味的蟹肉。"
	icon_state = "crabmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	tastes = list("蟹" = 1)
	foodtypes = SEAFOOD
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/slab/chicken
	name = "鸡肉"
	icon_state = "birdmeat"
	desc = "一块生鸡肉。记得洗手！"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6) //low fat
	tastes = list("鸡肉" = 1)
	starting_reagent_purity = 1

/obj/item/food/meat/slab/chicken/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/chicken, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切", sound_to_play = SFX_KNIFE_SLICE)

/obj/item/food/meat/slab/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe? (no this is chicken)

/obj/item/food/meat/slab/chicken/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CHICKEN, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/pig
	name = "生猪肉"
	desc = "一块生猪肉。这只小猪去了屠宰场。"
	icon_state = "pig_meat"
	tastes = list("猪肉" = 1)
	foodtypes = RAW | MEAT | GORE
	foodtypes_removed_when_cooked = RAW | GORE
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/fat = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) // Fatty piece
	starting_reagent_purity = 1

/obj/item/food/meat/slab/pig/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/pig, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/grassfed
	name = "生态肉"
	desc = "一块 100% 草饲、屡获殊荣的农场肉。"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/fat = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) // Marble
	starting_reagent_purity = 1

/obj/item/food/meat/slab/blood_worm
	name = "血虫肉"
	desc = "谁会认为吃这东西是个好主意？至少它挺多汁的……"
	foodtypes = RAW | MEAT | BUGS | GORE
	foodtypes_removed_when_cooked = RAW | GORE
	food_reagents = list(
		/datum/reagent/blood = 30, // What did you expect?
		/datum/reagent/consumable/nutriment/protein = 5, // Rich in protein.
		/datum/reagent/consumable/nutriment/vitamin = 3, // Rich in vitamins.
		/datum/reagent/consumable/nutriment/fat = 2, // Rather lean.
	)
	bite_consumption = 10
	starting_reagent_purity = 1

/obj/item/food/meat/slab/blood_worm/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/blood_worm, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

////////////////////////////////////// MEAT STEAKS ///////////////////////////////////////////////////////////
/obj/item/food/meat/steak
	name = "肉排"
	desc = "一块滚烫辛辣的肉。"
	icon_state = "meatsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/fat = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = MEAT
	tastes = list("肉" = 1)
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/steak/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED_RESULT, PROC_REF(on_microwave_cooked))

/obj/item/food/meat/steak/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	SIGNAL_HANDLER

	name = "[source_item.name] 肉排"

/obj/item/food/meat/steak/plain

/obj/item/food/meat/steak/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

///Make sure the steak has the correct name
/obj/item/food/meat/steak/plain/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "[origin_meat.subjectname] 肉排"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] 肉排"


/obj/item/food/meat/steak/killertomato
	name = "杀手番茄排"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT

/obj/item/food/meat/steak/bear
	name = "熊肉排"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/steak/xeno
	name = "异形肉排"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/meat/steak/spider
	name = "蜘蛛肉排"
	tastes = list("蛛网" = 1)
	foodtypes = parent_type::foodtypes | TOXIC

/obj/item/food/meat/steak/goliath
	name = "歌利亚肉排"
	desc = "一块美味的熔岩烤排。"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon_state = "goliathsteak"
	trash_type = null
	tastes = list("肉" = 1, "岩石" = 1)

/obj/item/food/meat/steak/goliath/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/raptor_food, attack_modifier = 1, speed_modifier = -0.075, color_chances = string_list(list(/datum/raptor_color/red = 7)))

/obj/item/food/meat/steak/gondola
	name = "贡多拉肉排"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/steak/penguin
	name = "企鹅肉排"
	icon_state = "birdsteak"
	tastes = list("牛肉" = 1, "鳕鱼" = 1)

/obj/item/food/meat/steak/chicken
	name = "鸡肉排" //Can you have chicken steaks? Maybe this should be renamed once it gets new sprites.
	icon_state = "birdsteak"
	tastes = list("鸡肉" = 1)

/obj/item/food/meat/steak/plain/human/lizard
	name = "蜥蜴肉排"
	icon_state = "birdsteak"
	tastes = list("多汁鸡肉" = 3, "鳞片" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/steak/meatproduct
	name = "热加工肉制品"
	icon_state = "meatproductsteak"
	tastes = list("增强焦香" = 2, "可疑的柔嫩" = 2, "天然与人工色素" = 2, "乳化剂" = 1)

/obj/item/food/meat/steak/plain/synth
	name = "合成肉排"
	desc = "一块合成肉排。看起来不太对劲，对吧？"
	icon_state = "meatsteak_old"
	tastes = list("肉" = 4, "冷冻剂" = 1)

/obj/item/food/meat/steak/plain/pig
	name = "猪排"
	desc = "一块猪排。别烦我了！"
	icon_state = "pigsteak"
	tastes = list("猪肉" = 1)
	foodtypes = MEAT

/obj/item/food/meat/steak/blood_worm
	name = "血虫肉排"
	desc = "这才是真正血腥美味的肉排！"
	tastes = list("肉" = 1)
	foodtypes = MEAT | BUGS

//////////////////////////////// MEAT CUTLETS ///////////////////////////////////////////////////////

//Raw cutlets

/obj/item/food/meat/rawcutlet
	name = "生肉片"
	desc = "一片生肉。"
	icon_state = "rawcutlet"
	bite_consumption = 2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	var/meat_type = "肉"

/obj/item/food/meat/rawcutlet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/food_storage)

/obj/item/food/meat/rawcutlet/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/OnCreatedFromProcessing(mob/living/user, obj/item/work_tool, list/chosen_option, atom/original_atom)
	. = ..()
	if(!istype(original_atom, /obj/item/food/meat/slab))
		return
	var/obj/item/food/meat/slab/original_slab = original_atom
	var/mutable_appearance/filling = mutable_appearance(icon, "rawcutlet_coloration")
	filling.color = original_slab.slab_color
	add_overlay(filling)
	name = "生[original_atom.name]肉片"
	meat_type = original_atom.name

/obj/item/food/meat/rawcutlet/plain
	foodtypes = MEAT

/obj/item/food/meat/rawcutlet/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE

/obj/item/food/meat/rawcutlet/plain/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain/human, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/plain/human/OnCreatedFromProcessing(mob/living/user, obj/item/item, list/chosen_option, atom/original_atom)
	. = ..()
	if(!istype(original_atom, /obj/item/food/meat))
		return
	var/obj/item/food/meat/origin_meat = original_atom
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "生[origin_meat.subjectname]肉片"
	else if(subjectjob)
		name = "生[origin_meat.subjectjob]肉片"

/obj/item/food/meat/rawcutlet/killertomato
	name = "生杀手番茄肉片"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT
	blood_decal_type = /obj/effect/decal/cleanable/food/tomato_smudge

/obj/item/food/meat/rawcutlet/killertomato/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/killertomato, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/bear
	name = "生熊肉片"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/rawcutlet/bear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BEAR, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/rawcutlet/bear/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/bear, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/xeno
	name = "生异形肉片"
	tastes = list("肉" = 1, "酸液" = 1)
	blood_decal_type = /obj/effect/decal/cleanable/blood/xeno

/obj/item/food/meat/rawcutlet/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/xeno, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/spider
	name = "生蜘蛛肉片"
	tastes = list("蛛网" = 1)
	blood_decal_type = /obj/effect/decal/cleanable/insectguts
	foodtypes = parent_type::foodtypes | TOXIC

/obj/item/food/meat/rawcutlet/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/spider, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/gondola
	name = "生贡多拉肉片"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/rawcutlet/gondola/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/gondola, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/penguin
	name = "生企鹅肉片"
	tastes = list("牛肉" = 1, "鳕鱼" = 1)

/obj/item/food/meat/rawcutlet/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/penguin, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/chicken
	name = "生鸡肉片"
	tastes = list("鸡肉" = 1)

/obj/item/food/meat/rawcutlet/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/chicken, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/chicken/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CHICKEN, CELL_VIRUS_TABLE_GENERIC_MOB)

//Cooked cutlets

/obj/item/food/meat/cutlet
	name = "肉片"
	desc = "一片熟肉片。"
	icon_state = "cutlet"
	bite_consumption = 2
	custom_materials = list(/datum/material/meat = MEATDISH_MATERIAL_AMOUNT)
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/cutlet/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED_RESULT, PROC_REF(on_microwave_cooked))

/obj/item/food/meat/cutlet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/food_storage)

///This proc handles setting up the correct meat name for the cutlet, this should definitely be changed with the food rework.
/obj/item/food/meat/cutlet/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	SIGNAL_HANDLER

	if(!istype(source_item, /obj/item/food/meat/rawcutlet))
		return

	var/obj/item/food/meat/rawcutlet/original_cutlet = source_item
	name = "[original_cutlet.meat_type]肉片"

/obj/item/food/meat/cutlet/plain

/obj/item/food/meat/cutlet/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/cutlet/plain/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	if(subjectname)
		name = "[origin_meat.subjectname][initial(name)]"
	else if(subjectjob)
		name = "[origin_meat.subjectjob][initial(name)]"

/obj/item/food/meat/cutlet/killertomato
	name = "杀手番茄肉片"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT

/obj/item/food/meat/cutlet/bear
	name = "熊肉片"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/cutlet/xeno
	name = "异形肉片"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/meat/cutlet/spider
	name = "蜘蛛肉片"
	tastes = list("蛛网" = 1)
	foodtypes = parent_type::foodtypes | TOXIC

/obj/item/food/meat/cutlet/gondola
	name = "贡多拉肉片"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/cutlet/penguin
	name = "企鹅肉片"
	tastes = list("牛肉" = 1, "鳕鱼" = 1)

/obj/item/food/meat/cutlet/chicken
	name = "鸡肉片"
	tastes = list("鸡肉" = 1)
