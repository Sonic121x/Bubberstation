/datum/glass_style/has_foodtype/drinking_glass/eggnog          //Eggnog doesn't have a custom glass in the dm where
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi' //it should (mixed_alcohol.dm), so this exists to give it a glass.
	icon_state = "eggnog"

/datum/reagent/consumable/moth_milk
	name = "蛾奶"
	description = "当初觉得挤蛾奶是个好主意的人完全错了。这玩意儿真的算奶吗？"
	color = "#F0E9DA" // rgb: 240, 233, 218
	taste_description = "咸味油状物"
	ph = 6.5
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/moth_milk/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	. = ..()
	if(!ismoth(M))
		M.adjust_disgust(10 * REM * delta_time,DISGUST_LEVEL_DISGUSTED)
		return UPDATE_MOB_HEALTH


/mob/living/basic/mothroach/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/udder, reagent_produced_override = /datum/reagent/consumable/moth_milk)


/datum/reagent/consumable/icetea/blood_tea
	name = "血红蛋白冰茶"
	description = "血液与冰茶的混合物，还配上一片多汁的血番茄作点缀。"
	color = "#B85D52"//rgb(184, 93, 82)
	quality = DRINK_GOOD
	taste_description = "冰凉甜茶带着一丝铁味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/icetea/blood_tea/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_tea
	required_drink_type = /datum/reagent/consumable/icetea/blood_tea
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodteaglass"
	name = "一杯血红蛋白冰茶"
	desc = "以血液调味的香甜冰茶，十分美味。"


/datum/reagent/consumable/coffee/blood_coffee
	name = "鲜血咖啡"
	description = "浓郁血液调入热黑咖啡，嗜血者的最爱！"
	color = "#8E272B"//rgb(142, 39, 43)
	quality = DRINK_GOOD
	taste_description = "苦涩的铁味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/coffee/blood_coffee/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/blood_coffee
	required_drink_type = /datum/reagent/consumable/coffee/blood_coffee
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bloodcoffeeglass"
	name = "一杯鲜血咖啡"
	desc = "一杯混入新鲜血液的热黑咖啡。"


/datum/reagent/consumable/intraverde
	name = "Intraverde"
	description = "一杯蜜瓜苏打冰浮，顶上覆着掺血的鲜奶油。"
	color = "#40e729"
	quality = DRINK_GOOD
	taste_description = "酸涩的糖味，还有一点咬破嘴唇的味道。"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/intraverde/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/intraverde
	required_drink_type = /datum/reagent/consumable/intraverde
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "intraverde"
	name = "Intraverde"
	desc = "一杯能把獠牙甜坏的冰浮，常被还没喝惯灵浆的嗜血者幼崽点单。顶上的鲜奶油掺了血。"


/datum/reagent/consumable/ethanol/venetian_waltz
	name = "威尼斯华尔兹"
	description = "一款巧克力焦糖甜点鸡尾酒，专为饮血者调制。"
	color = "#38210b"
	boozepwr = 15
	quality = DRINK_GOOD
	taste_description = "浓郁带血的巧克力"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/venetian_waltz/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/venetian_waltz
	required_drink_type = /datum/reagent/consumable/ethanol/venetian_waltz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "venetian_waltz"
	name = "威尼斯华尔兹"
	desc = "尽管摆盘精致，它却因甜点般的风味而被老一辈嗤之以鼻，只能端到姊妹会和憨憨帅哥的桌上当作惩罚。"


/datum/reagent/consumable/ethanol/cranberry_cadillac
	name = "蔓越莓凯迪拉克"
	description = "一款冒着气泡、杯口镶糖的鸡尾酒。"
	color = "#ac1e2a"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "一场糖果做的肇事逃逸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/cranberry_cadillac/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/cranberry_cadillac
	required_drink_type = /datum/reagent/consumable/ethanol/cranberry_cadillac
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "cranberry_cadillac"
	name = "蔓越莓凯迪拉克"
	desc = "杯口那圈糖晶被真血染得通红，诱得饥渴者把杯子舔干净。上桌时配半片柠檬，用来压住甜味。"


/datum/reagent/consumable/ethanol/jubokko
	name = "树婴"
	description = "一份清酒套餐，外加掺了血的夕烧酒。"
	color = "#ac1e2a"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "头顶迫近的危险"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/jubokko/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/jubokko
	required_drink_type = /datum/reagent/consumable/ethanol/jubokko
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "jubokko"
	name = "树婴"
	desc = "火星的吸血财阀用它招待客人。看起来再怎么雅致，任何懂行的诗人都能看出摆在眼前的伏笔。"


/datum/reagent/consumable/ethanol/morocco_coffin
	name = "摩洛哥棺材"
	description = "一杯带着铁锈味的冷萃咖啡。"
	color = "#200608"
	boozepwr = 20
	overdose_threshold = 75
	quality = DRINK_GOOD
	taste_description = "午夜醒来的滋味"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/ethanol/morocco_coffin/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_jitter_if_lower(10 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/morocco_coffin/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-4 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_bodytemperature(-5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal())

/datum/reagent/consumable/ethanol/morocco_coffin/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/morocco_coffin
	required_drink_type = /datum/reagent/consumable/ethanol/morocco_coffin
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "morocco_coffin"
	name = "摩洛哥棺材"
	desc = "专为太阳落山时醒来的人准备。让你冷静下来，也让你清醒过来。"


/datum/reagent/consumable/ethanol/bat_outta_hell
	name = "地狱狂蝠"
	description = "勇敢的公牛混入血液，上面再刷一层苦艾酒“清漆”。"
	color = "#3d1013"
	boozepwr = 70
	overdose_threshold = 47
	quality = DRINK_VERYGOOD
	taste_description = "一记全垒打那令人目眩的快感，宝贝！！"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING
	metabolization_rate = 1.2 * REAGENTS_METABOLISM

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.remove_status_effect(/datum/status_effect/drowsiness)
	affected_mob.AdjustSleeping(-2 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.add_traits(list(TRAIT_GOOD_HEARING, TRAIT_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")
	metabolization_rate = 4.5 * REAGENTS_METABOLISM
	affected_mob.set_jitter_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_dizzy_if_lower(5 SECONDS * REM * seconds_per_tick)
	affected_mob.set_temp_blindness_if_lower(5 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/bat_outta_hell/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.remove_traits(list(TRAIT_GOOD_HEARING, TRAIT_NIGHT_VISION),"Overdose:/datum/reagent/consumable/ethanol/bat_outta_hell")

/datum/reagent/consumable/ethanol/bat_outta_hell/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()
	if(!(methods & INGEST))
		return
	var/obj/item/organ/stomach/stomach = affected_mob.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(!istype(stomach) || !affected_mob.has_quirk(/datum/quirk/hemophage) || reac_volume <= 0)
		return
	affected_mob.blood_volume = min(affected_mob.blood_volume + reac_volume, BLOOD_VOLUME_MAXIMUM)

/datum/glass_style/drinking_glass/bat_outta_hell
	required_drink_type = /datum/reagent/consumable/ethanol/bat_outta_hell
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "bat_outta_hell"
	name = "地狱狂蝠"
	desc = "劲道足得能把你轰出球场！也可能只是让你踉跄几步……"

//Ethereal Drinks

/datum/reagent/consumable/ethanol/karakrak
	name = "卡拉拉克"
	description = "用过滤葡萄酒制成的轻充能配给饮品"
	color = "#5c0b12"
	boozepwr = 0
	quality = DRINK_NICE
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	taste_description = "苦涩、被稀释的能量"

/datum/reagent/consumable/ethanol/karakrak/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 3 * ETHEREAL_DISCHARGE_RATE)

/datum/glass_style/drinking_glass/karakrak
	required_drink_type = /datum/reagent/consumable/ethanol/karakrak
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "karakrak"
	name = "卡拉拉克"
	desc = "一种带电的脱醇葡萄酒，供给以太人底层民众，通常由教会分发。上桌时垫着橡胶杯垫，以免那点微薄的电荷散进桌面。"


/datum/reagent/consumable/ethanol/szzszz
	name = "滋滋"
	description = "以太人修道院葡萄酒的私酿版本"
	color = "#5c0b12"
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "苦甜交织的罪恶"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/szzszz/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 4 * ETHEREAL_DISCHARGE_RATE)
	else //If you are NOT an ethereal, you jitter
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/ethanol/szzszz/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1, COLOR_MAROON)

/datum/reagent/consumable/ethanol/szzszz/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/szzszz/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/szzszz
	required_drink_type = /datum/reagent/consumable/ethanol/szzszz
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "szzszz"
	name = "滋滋"
	desc = "神圣导管专属修道院葡萄酒的私酿版本。它的味道被上千条舌头揣摩近似，而那些人因惧怕迫害，其实从未真正尝过。"


/datum/reagent/consumable/blumpkin_compot
	name = "蓝瓜果羹"
	description = "炖煮的果实、糖与马黛叶。以太人的能量饮料。"
	color = "#3cc6e9"
	quality = DRINK_VERYGOOD
	taste_description = "干净可靠的能源"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)

/datum/reagent/consumable/blumpkin_compot/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 7 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)

/datum/reagent/consumable/blumpkin_compot/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/glass_style/drinking_glass/blumpkin_compot
	required_drink_type = /datum/reagent/consumable/blumpkin_compot
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "blumpkin_compot"
	name = "蓝瓜果羹"
	desc = "以太人侨民发明的饮品，用炖烂的蓝瓜果肉和整颗浆果制成。糖分能帮助析出导电成分，使它成为一杯礼貌又提神的饮料，喝起来也绝不像玻璃清洁剂。"


/datum/reagent/consumable/ethanol/storm_over_avon
	name = "埃文河上风暴"
	description = "一款为以太人工匠调制的杜松子薄荷鸡尾酒。"
	color = "#ffca37"
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "精力充沛的势利"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/storm_over_avon/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 8 * ETHEREAL_DISCHARGE_RATE)
	else //If you are not etheral, jitter. Random chance to ZAP you, every sip. Roll a one; zap.
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 15)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("你感觉舌尖迸出一阵尖锐的能量电击！"))
			affected_mob.electrocute_act(rand(1, 5), "埃文河上风暴电击", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 30, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_dizzy(-10 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-6 SECONDS * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/storm_over_avon/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/storm_over_avon
	required_drink_type = /datum/reagent/consumable/ethanol/storm_over_avon
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "storm_over_avon"
	name = "埃文河上风暴"
	desc = "一款工序复杂的鸡尾酒，深受“永恒音符”信徒喜爱。它的原始配料在斯普劳特之外无处可寻，但这款仿制品仍散发着只有音乐教团才能磨出的那股做派。已知偶尔会电到非以太人。"


/datum/reagent/consumable/ethanol/coilhouse_cocktail
	name = "线圈屋鸡尾酒"
	description = "一款柑橘味的带电饮品，用橙汁和柠檬调成。"
	color = "#d6ff21"
	boozepwr = 30
	quality = DRINK_VERYGOOD
	taste_description = "嘴里的一颗迪斯科球"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/coilhouse_cocktail/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 6 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 6)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("你感觉舌尖迸出一阵尖锐的能量电击！"))
			affected_mob.electrocute_act(rand(2, 8), "线圈屋鸡尾酒电击", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_YELLOW)

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/coilhouse_cocktail/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/coilhouse_cocktail
	required_drink_type = /datum/reagent/consumable/ethanol/coilhouse_cocktail
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "coilhouse_cocktail"
	name = "线圈屋鸡尾酒"
	desc = "一款过于张扬、不像是诞生于索阿托领空的以太人鸡尾酒。对于不是电构成的人，它又叫“电镇颤抖”，原因很快就会显现。"


/datum/reagent/consumable/ethanol/electric_avenue
	name = "电气大道"
	description = "一款用金箔肉桂酒与柑橘调制、再加盐的鸡尾酒。"
	color = "#d37810"
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "酸涩的电椅"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.6 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/electric_avenue/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 10 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(10 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 3)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("你感觉舌尖迸出一阵剧烈的能量电击！"))
			affected_mob.electrocute_act(rand(15, 35), "电气大道电击", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 55, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.3, 1.5, COLOR_VERY_SOFT_YELLOW)

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/electric_avenue/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/electric_avenue
	required_drink_type = /datum/reagent/consumable/ethanol/electric_avenue
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "electric_avenue"
	name = "电气大道"
	desc = "这款酒得名于太阳系中的一处神话地点，本意是让人用细长的铜吸管慢慢啜饮，体会人生悠长又轻快的滋味。但对非以太人而言，它是直奔急诊室的捷径。"


/datum/reagent/consumable/ethanol/ira_de_zeus
	name = "宙斯之怒"
	description = "一款以电与火调和而成的深蓝色鸡尾酒。"
	color = "#3e1ef1"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "尖锐、加了香料的虚伪"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	metabolized_traits = list(TRAIT_STIMULATED)
	metabolization_rate = 1.1 * REAGENTS_METABOLISM
	var/obj/effect/light_holder
	var/shock_timer = 0
	var/unluckyshock = 0

/datum/reagent/consumable/ethanol/ira_de_zeus/expose_mob(mob/living/affected_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH)) || !iscarbon(affected_mob))
		return

	var/mob/living/carbon/exposed_carbon = affected_mob
	var/obj/item/organ/stomach/ethereal/stomach = exposed_carbon.get_organ_slot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		stomach.adjust_charge(reac_volume * 5 * ETHEREAL_DISCHARGE_RATE)
	else
		affected_mob.set_jitter_if_lower(5 SECONDS * REM * reac_volume)
		unluckyshock = rand(1, 8)
		if(unluckyshock == 1)
			to_chat(affected_mob, span_userdanger("你感觉舌尖迸出一阵剧烈的能量电击！"))
			affected_mob.electrocute_act(rand(10, 25), "宙斯之怒电击", 1, SHOCK_NOGLOVES)
			playsound(affected_mob, 'sound/machines/defib/defib_zap.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_metabolize(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..() //Gives glow
	light_holder = new(affected_mob)
	light_holder.set_light(1.2, 3.5, COLOR_BRIGHT_BLUE)

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_bodytemperature(15 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, affected_mob.get_body_temp_normal()+ 20)
	if(QDELETED(light_holder))
		holder.del_reagent(type) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != affected_mob)
		light_holder.forceMove(affected_mob)
	return ..()

/datum/reagent/consumable/ethanol/ira_de_zeus/on_mob_end_metabolize(mob/living/affected_mob)
	. = ..()
	QDEL_NULL(light_holder)

/datum/glass_style/drinking_glass/ira_de_zeus
	required_drink_type = /datum/reagent/consumable/ethanol/ira_de_zeus
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "ira_de_zeus"
	name = "宙斯之怒"
	desc = "一款光芒四射的以太人饮品，暖身又撩舌。据传其原始配方出自斯普劳特上层祭司的餐桌，那将意味着最高等级的异端。好在它只是个传说……可能会电到非以太人。"

/datum/reagent/consumable/ethanol/orange_creamsicle
	name = "橙香奶油冰棒"
	color = "#f8dd64" //(248, 221, 100)
	description = "一款香甜、微酸、果味十足的橙色饮品，尾韵奶香浓郁。"
	boozepwr = 40
	taste_description = "香甜奶滑的柑橘与怀旧味"
	quality = DRINK_VERYGOOD

/datum/glass_style/drinking_glass/orange_creamsicle
	required_drink_type = /datum/reagent/consumable/ethanol/orange_creamsicle
	icon = 'modular_zubbers/icons/obj/drinks/mixed_drinks.dmi'
	icon_state = "orange_creamsicle"
	name = "橙香奶油冰棒"
	desc = "一杯清爽的橙香奶油冰棒饮品，顶上旋着一圈鲜奶油，再配一片橙子。最适合空间站炎热的一天，或者任何时候你想感觉自己正在热带度假。"
