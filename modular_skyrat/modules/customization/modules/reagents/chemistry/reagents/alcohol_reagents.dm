// Modular Booze REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/ethanol/whiskey
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //let's not force the detective to change his alcohol brand


/datum/reagent/consumable/ethanol/bloody_mary
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING


//Drinks from tg that are made with blood, thus hemophages are able to drink them without suffering ill effects

/datum/reagent/consumable/ethanol/demonsblood
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/devilskiss
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/narsour
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/protein_blend
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/reagent/consumable/ethanol/red_mead
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

//End of tg blood-based drinks




// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/reagent/consumable/ethanol/synthanol
	name = "合成醇"
	description = "一种稀薄、具有导电能力的液体。它对合成体的作用类似于酒精对有机体的作用。"
	color = "#1BB1FF"
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC | REAGENT_PROTEAN
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "机油"

/datum/glass_style/drinking_glass/synthanol
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi' // This should cover anything synthanol related. Will have to individually tag others unless we make an object path for Skyrat drinks.
	icon_state = "synthanolglass"
	name = "一杯合成醇"
	desc = "对合成体船员而言相当于酒精。要是它们也有味蕾，一定会觉得难喝。"

/datum/reagent/consumable/ethanol/synthanol/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(!(affected_mob.mob_biotypes & MOB_ROBOTIC))
		affected_mob.reagents.remove_reagent(type, 3.6 * REM * seconds_per_tick) //gets removed from organics very fast
		if(prob(25))
			affected_mob.vomit(VOMIT_CATEGORY_DEFAULT, lost_nutrition = 5)
	return ..()

/datum/reagent/consumable/ethanol/synthanol/expose_mob(mob/living/carbon/C, method=TOUCH, volume)
	. = ..()
	if(C.mob_biotypes & MOB_ROBOTIC)
		return
	if(method == INGEST)
		to_chat(C, pick(span_danger("那太难喝了！"), span_danger("那太恶心了！")))

/datum/reagent/consumable/ethanol/synthanol/robottears
	name = "机器人眼泪"
	description = "一种油质物质，IPC 在技术上可以把它当作“饮料”。"
	color = "#363636"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "存在主义焦虑"

/datum/glass_style/drinking_glass/synthanol/robottears
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/robottears
	icon_state = "robottearsglass"
	name = "一杯机器人眼泪"
	desc = "调配这杯饮料的过程中没有机器人受到伤害。"

/datum/reagent/consumable/ethanol/synthanol/trinary
	name = "三进制"
	description = "一款专为合成体准备的果味饮料，至于怎么做到的，没人清楚。"
	color = "#ADB21f"
	quality = DRINK_GOOD
	boozepwr = 20
	taste_description = "调制解调器的杂音"

/datum/glass_style/drinking_glass/synthanol/trinary
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/trinary
	icon_state = "trinaryglass"
	name = "一杯三进制"
	desc = "为合成体船员制作的多彩饮品，看起来并不怎么好喝。"

/datum/reagent/consumable/ethanol/synthanol/servo
	name = "伺服"
	description = "含有部分有机成分的饮品，但只适合合成体饮用。"
	color = "#5B3210"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "机油与可可"

/datum/glass_style/drinking_glass/synthanol/servo
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/servo
	icon_state = "servoglass"
	name = "一杯伺服"
	desc = "为 IPC 制作的巧克力基饮品。不确定是否真有人试过这个配方。"

/datum/reagent/consumable/ethanol/synthanol/uplink
	name = "上行链路"
	description = "酒精与合成醇的烈性混合物。只对合成体有效。"
	color = "#E7AE04"
	quality = DRINK_GOOD
	boozepwr = 15
	taste_description = "Visual Basic 写的图形界面"

/datum/glass_style/drinking_glass/synthanol/uplink
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/uplink
	icon_state = "uplinkglass"
	name = "一杯上行链路"
	desc = "上等利口酒与合成醇的精妙混合。仅供合成体饮用。"

/datum/reagent/consumable/ethanol/synthanol/synthncoke
	name = "合成体配可乐"
	description = "按机器人的品味调整过的经典饮品。"
	color = "#7204E7"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "起泡的机油"

/datum/glass_style/drinking_glass/synthanol/synthncoke
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/synthncoke
	icon_state = "synthncokeglass"
	name = "一杯合成体配可乐"
	desc = "为迎合机器人的品味而改造的经典饮品，具有除锈特性。如果你是由碳构成的，最好别喝。"

/datum/reagent/consumable/ethanol/synthanol/synthignon
	name = "合成尼翁"
	description = "有人把葡萄酒和机器人喝的酒混在了一起。希望你为自己感到骄傲。"
	color = "#D004E7"
	quality = DRINK_GOOD
	boozepwr = 25
	taste_description = "高级机油"

/datum/glass_style/drinking_glass/synthanol/synthignon
	required_drink_type = /datum/reagent/consumable/ethanol/synthanol/synthignon
	icon_state = "synthignonglass"
	name = "一杯合成尼翁"
	desc = "有人把上好的葡萄酒和机器人烈酒混在了一起。浪漫，但难以下咽。"

// Other Booze

/datum/reagent/consumable/ethanol/gunfire
	name = "枪火"
	description = "喝起来像小型爆炸的饮品。"
	color = "#e4830d"
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "小型爆炸"

/datum/glass_style/drinking_glass/gunfire
	required_drink_type = /datum/reagent/consumable/ethanol/gunfire
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "gunfire"
	name = "一杯枪火"
	desc = "你看着它时，它不断爆响，迸出细小的火花。"

/datum/reagent/consumable/ethanol/gunfire/on_mob_life(mob/living/carbon/M)
	if (prob(3))
		to_chat(M,span_notice("你感到枪火在嘴里爆响。"))
	return ..()

/datum/reagent/consumable/ethanol/hellfire
	name = "地狱火"
	description = "一杯不错的饮品，其实没有看起来那么烫。"
	color = "#fb2203"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "舔舐上颚的冰冷火焰"

/datum/glass_style/drinking_glass/hellfire
	required_drink_type = /datum/reagent/consumable/ethanol/hellfire
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hellfire"
	name = "一杯地狱火"
	desc = "琥珀色的饮品，其实没有看起来那么烫。"

/datum/reagent/consumable/ethanol/hellfire/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, 0, BODYTEMP_NORMAL + 30)

/datum/reagent/consumable/ethanol/sins_delight
	name = "罪孽之悦"
	description = "这杯饮品闻起来带有七宗罪的气息。"
	color = "#330000"
	boozepwr = 66
	quality = DRINK_FANTASTIC
	taste_description = "铺天盖地的甜味中带着一丝酸，随后是铁锈味，以及一阵温暖夏风的感觉"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING //component drink is demon's blood, thus this drink is made with blood so hemophages can comfortably drink it

/datum/glass_style/drinking_glass/sins_delight
	required_drink_type = /datum/reagent/consumable/ethanol/sins_delight
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "sins_delight"
	name = "一杯罪孽之悦"
	desc = "你能闻到七宗罪的气息从杯口翻涌而出。"

/datum/reagent/consumable/ethanol/daiquiri/strawberry
	name = "草莓大吉利"
	description = "粉红色的含酒精饮品。"
	boozepwr = 20
	color = "#FF4A74"
	quality = DRINK_NICE
	taste_description = "甜草莓、青柠与海风"

/datum/glass_style/drinking_glass/daiquiri/strawberry
	required_drink_type = /datum/reagent/consumable/ethanol/daiquiri/strawberry
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "strawberry_daiquiri"
	name = "一杯草莓大吉利"
	desc = "粉红色的饮品，点缀着花朵，插着一根粗吸管。看起来甜美清爽，非常适合温暖的日子。"

/datum/glass_style/drinking_glass/liz_fizz
	required_drink_type = /datum/reagent/consumable/liz_fizz
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "liz_fizz"
	name = "一杯蜥蜴汽水"
	desc = "看起来像是分层的柑橘雪酪？为什么会有人想要这个，你实在想不通。"

/datum/reagent/consumable/ethanol/miami_vice
	name = "迈阿密风云"
	description = "由椰林飘香与草莓大吉利分层而成的饮品"
	boozepwr = 30
	color = "#D8FF59"
	quality = DRINK_FANTASTIC
	taste_description = "甜美清爽的风味，伴随草莓与椰子，还有一丝柑橘气息"

/datum/glass_style/drinking_glass/miami_vice
	required_drink_type = /datum/reagent/consumable/ethanol/miami_vice
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "miami_vice"
	name = "一杯迈阿密风云"
	desc = "草莓与椰子，宛如阴阳相济。"

/datum/reagent/consumable/ethanol/malibu_sunset
	name = "马里布日落"
	description = "由椰子奶油与热带果汁调成的饮品"
	boozepwr = 20
	color = "#FF9473"
	quality = DRINK_VERYGOOD
	taste_description = "椰子味，伴有橙子与红石榴糖浆的点缀"

/datum/glass_style/drinking_glass/malibu_sunset
	required_drink_type = /datum/reagent/consumable/ethanol/malibu_sunset
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "malibu_sunset"
	name = "一杯马里布日落"
	desc = "充满热带风情的饮品，冰块浮在表面，红石榴糖浆将杯底染上颜色。"

/datum/reagent/consumable/ethanol/hotlime_miami
	name = "热火迈阿密"
	description = "九十年代的精髓——如果九十年代是一团血腥的乱麻的话。"
	boozepwr = 40
	color = "#A7FAE8"
	quality = DRINK_FANTASTIC
	taste_description = "椰子与唯美暴力"

/datum/glass_style/drinking_glass/hotlime_miami
	required_drink_type = /datum/reagent/consumable/ethanol/hotlime_miami
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hotlime_miami"
	name = "一杯热火迈阿密"
	desc = "这看起来非常有唯美感。"

/datum/reagent/consumable/ethanol/hotlime_miami/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.set_drugginess(1.5 MINUTES * REM * seconds_per_tick)
	if(affected_mob.adjust_stamina_loss(-2 * REM * seconds_per_tick, updating_stamina = FALSE))
		return UPDATE_MOB_HEALTH

/datum/reagent/consumable/ethanol/coggrog
	name = "齿轮格罗格"
	description = "现在你可以用拉特瓦的力量填满自己了！"
	color = rgb(255, 201, 49)
	boozepwr = 10
	quality = DRINK_FANTASTIC
	taste_description = "黄铜味，带有一丝油味"

/datum/glass_style/drinking_glass/coggrog
	required_drink_type = /datum/reagent/consumable/ethanol/coggrog
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "coggrog"
	name = "一杯齿轮格罗格"
	desc = "就连拉特瓦的四位将军也扛不住这个！ Qevax Jryy！"

/datum/reagent/consumable/ethanol/badtouch
	name = "咸猪手"
	description = "一款酸味的陈年饮品。据说发明者经常挨耳光。"
	color = rgb(31, 181, 99)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "一记耳光"

/datum/glass_style/drinking_glass/badtouch
	required_drink_type = /datum/reagent/consumable/ethanol/badtouch
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "badtouch"
	name = "一杯咸猪手"
	desc = "毕竟我们不过是哺乳动物罢了。"

/datum/reagent/consumable/ethanol/marsblast
	name = "火星冲击"
	description = "为纪念火星首批殖民者而调制的辛辣、硬汉风饮品。"
	color = rgb(246, 143, 55)
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "滚烫的红沙"

/datum/glass_style/drinking_glass/marsblast
	required_drink_type = /datum/reagent/consumable/ethanol/marsblast
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "marsblast"
	name = "一杯火星冲击"
	desc = "来一杯就足以让你的脸和那颗星球一样红。"

/datum/reagent/consumable/ethanol/mercuryblast
	name = "水星冲击"
	description = "一款酸爽、冰冷刺骨的饮品，必定能让饮用者透心凉。"
	color = rgb(29, 148, 213)
	boozepwr = 40
	quality = DRINK_VERYGOOD
	taste_description = "顺着脊背而下的寒意"

/datum/glass_style/drinking_glass/mercuryblast
	required_drink_type = /datum/reagent/consumable/ethanol/mercuryblast
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "mercuryblast"
	name = "一杯水星冲击"
	desc = "调配这杯饮品的过程中没有温度计受到伤害。"

/datum/reagent/consumable/ethanol/mercuryblast/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	affected_mob.adjust_bodytemperature(-30 * TEMPERATURE_DAMAGE_COEFFICIENT * REM * seconds_per_tick, T0C)

/datum/reagent/consumable/ethanol/piledriver
	name = "打桩机"
	description = "一杯鲜亮的饮品，喝下后会留下灼烧感。"
	color = rgb(241, 146, 59)
	boozepwr = 45
	quality = DRINK_NICE
	taste_description = "喉咙里的一团火"

/datum/glass_style/drinking_glass/piledriver
	required_drink_type = /datum/reagent/consumable/ethanol/piledriver
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "piledriver"
	name = "一杯打桩机"
	desc = "能让你喉咙发痛的，可不止这一样东西。"

/datum/reagent/consumable/ethanol/zenstar
	name = "禅意之星"
	description = "一款酸而寡淡的饮品，相当令人失望。"
	color = rgb(51, 87, 203)
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "失望"

/datum/glass_style/drinking_glass/zenstar
	required_drink_type = /datum/reagent/consumable/ethanol/zenstar
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "zenstar"
	name = "一杯禅意之星"
	desc = "你大概会以为这么均衡的东西味道应该不错……那你可就大错特错了。"


// RACE SPECIFIC DRINKS

/datum/reagent/consumable/ethanol/coldscales
	name = "冷鳞"
	color = "#5AEB52" //(90, 235, 82)
	description = "一款看起来冰冷的饮品，专为有鳞片的人调制。"
	boozepwr = 50 //strong!
	taste_description = "死苍蝇"

/datum/glass_style/drinking_glass/coldscales
	required_drink_type = /datum/reagent/consumable/ethanol/coldscales
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "coldscales"
	name = "一杯冷鳞"
	desc = "一杯柔和的绿色饮品，看起来相当诱人！"

/datum/reagent/consumable/ethanol/coldscales/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(islizard(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/oil_drum
	name = "油桶"
	color = "#000000" //(0, 0, 0)
	description = "工业级油掺入一些乙醇做成的饮品。不知怎的，它并不被认为有毒。"
	boozepwr = 45
	taste_description = "漏油"

/datum/glass_style/drinking_glass/oil_drum
	required_drink_type = /datum/reagent/consumable/ethanol/oil_drum
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "oil_drum"
	name = "一桶油"
	desc = "一罐灰色的酒和油……"

/datum/reagent/consumable/ethanol/oil_drum/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(MOB_ROBOTIC)
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/nord_king
	name = "诺德之王"
	color = "#EB1010" //(235, 16, 16)
	description = "在烈性蜂蜜酒中掺入更多蜂蜜与乙醇。深受人类顾客喜爱。"
	boozepwr = 50 //strong!
	taste_description = "蜂蜜与红葡萄酒"
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING //component drink is red mead, thus this drink is made with blood so hemophages can comfortably drink it

/datum/glass_style/drinking_glass/nord_king
	required_drink_type = /datum/reagent/consumable/ethanol/nord_king
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "nord_king"
	name = "一小桶诺德之王"
	desc = "一桶滴着酒液的红蜂蜜酒。"

/datum/reagent/consumable/ethanol/nord_king/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(ishumanbasic(exposed_mob) || isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/velvet_kiss
	name = "天鹅绒之吻"
	color = "#EB1010" //(235, 16, 16)
	description = "掺入葡萄酒的血色饮品。"
	boozepwr = 10 //weak
	taste_description = "铁锈味混合葡萄汁"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING

/datum/glass_style/drinking_glass/velvet_kiss
	required_drink_type = /datum/reagent/consumable/ethanol/velvet_kiss
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "velvet_kiss"
	name = "一杯天鹅绒之吻"
	desc = "为上层阶级或亡者准备的红白色饮品。"

/datum/reagent/consumable/ethanol/velvet_kiss/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(exposed_mob.has_status_effect(/datum/status_effect/zombie) || isvampire(exposed_mob) || isdullahan(exposed_mob) || exposed_mob.has_quirk(/datum/quirk/hemophage)) //Rare races!
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/velvet_kiss/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.blood_volume < BLOOD_VOLUME_NORMAL)
		drinker.blood_volume = min(drinker.blood_volume + (1 * REM * seconds_per_tick), BLOOD_VOLUME_NORMAL) //Same as Bloody Mary, as it is roughly the same difficulty to make.  Gives hemophages a bit more choices to supplant their blood levels.

/datum/reagent/consumable/ethanol/abduction_fruit
	name = "绑架果实"
	color = "#DEFACD" //(222, 250, 205)
	description = "把几种果汁混在一起，调出外星风味。"
	boozepwr = 80 //Strong
	taste_description = "青草与青柠"

/datum/glass_style/drinking_glass/abduction_fruit
	required_drink_type = /datum/reagent/consumable/ethanol/abduction_fruit
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "abduction_fruit"
	name = "一杯绑架果实"
	desc = "本不该混在一起的果汁被混在了一起……"

/datum/reagent/consumable/ethanol/abduction_fruit/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isabductor(exposed_mob) || isxenohybrid(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/bug_zapper
	name = "灭虫灯"
	color = "#F5882A" //(222, 250, 205)
	description = "铜与柠檬汁。勉强算得上是饮料。"
	boozepwr = 5 //No booze really
	taste_description = "铜与交流电"

/datum/glass_style/drinking_glass/bug_zapper
	required_drink_type = /datum/reagent/consumable/ethanol/bug_zapper
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "bug_zapper"
	name = "一杯灭虫灯"
	desc = "铜、柠檬汁与电力混合成的古怪饮品，专供非人类饮用。"

/datum/reagent/consumable/ethanol/bug_zapper/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isinsect(exposed_mob) || isflyperson(exposed_mob) || ismoth(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/mush_crush
	name = "蘑菇压榨"
	color = "#F5882A" //(222, 250, 205)
	description = "一杯泥土。"
	boozepwr = 5 //No booze really
	taste_description = "泥土与铁"

/datum/glass_style/drinking_glass/mush_crush
	required_drink_type = /datum/reagent/consumable/ethanol/mush_crush
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "mush_crush"
	name = "一杯蘑菇压榨"
	desc = "在那些想自己种食物而不是喝土的人当中很受欢迎。"

/datum/reagent/consumable/ethanol/mush_crush/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(ispodperson(exposed_mob) || issnail(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/hollow_bone
	name = "中空之骨"
	color = "#FCF7D4" //(252, 247, 212)
	description = "令人震惊地并无害处的毒素与牛奶混合物。"
	boozepwr = 15
	taste_description = "牛奶与盐"

/datum/glass_style/drinking_glass/hollow_bone
	required_drink_type = /datum/reagent/consumable/ethanol/hollow_bone
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hollow_bone"
	name = "一骷髅杯中空之骨"
	desc = "牛奶与“伤骨果汁”混合而成的饮品，深受相当瘦弱的人喜爱。"

/datum/reagent/consumable/ethanol/hollow_bone/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isplasmaman(exposed_mob) || isskeleton(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/jell_wyrm
	name = "果冻蠕虫"
	color = "#FF6200" //(255, 98, 0)
	description = "二氧化碳、毒素与热量混合成的可怕饮品。专供史莱姆类生命饮用。"
	boozepwr = 40
	taste_description = "热带海洋"

/datum/glass_style/drinking_glass/jell_wyrm
	required_drink_type = /datum/reagent/consumable/ethanol/jell_wyrm
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "jell_wyrm"
	name = "一杯果冻蠕虫"
	desc = "一杯气泡充盈的饮品，对不知道它给谁喝的人来说相当诱人。"

/datum/reagent/consumable/ethanol/jell_wyrm/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(prob(20))
		if(affected_mob.adjust_tox_loss(0.5 * REM * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH

#define JELLWYRM_DISGUST 25

/datum/reagent/consumable/ethanol/jell_wyrm/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isjellyperson(exposed_mob) || isslimeperson(exposed_mob) || isluminescent(exposed_mob))
		quality = RACE_DRINK
	else //if youre not a slime, jell wyrm should be GROSS
		exposed_mob.adjust_disgust(JELLWYRM_DISGUST)
	return ..()

#undef JELLWYRM_DISGUST

/datum/reagent/consumable/ethanol/laval_spit //Yes Laval
	name = "熔岩之唾"
	color = "#DE3009" //(222, 48, 9)
	description = "加热的矿物质加上一些莫纳罗亚。专供岩石类生命饮用。"
	boozepwr = 30
	taste_description = "热带岛屿"

/datum/glass_style/drinking_glass/laval_spit
	required_drink_type = /datum/reagent/consumable/ethanol/laval_spit
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "laval_spit"
	name = "一杯熔岩之唾"
	desc = "滚烫的饮品，献给能受得了熔岩高温的人。"

/datum/reagent/consumable/ethanol/laval_spit/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isgolem(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/frisky_kitty
	name = "活泼小猫"
	color = "#FCF7D4" //(252, 247, 212)
	description = "掺了猫薄荷的温牛奶。"
	boozepwr = 0
	taste_description = "温牛奶与猫薄荷"

/datum/glass_style/drinking_glass/frisky_kitty
	required_drink_type = /datum/reagent/consumable/ethanol/frisky_kitty
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "frisky_kitty"
	name = "一杯活泼小猫"
	desc = "温牛奶和一些猫薄荷。"

/datum/reagent/consumable/ethanol/frisky_kitty/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isfeline(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()


/datum/reagent/consumable/ethanol/bloodshot_base
	name = "血红之眼基液"
	description = "用来调制血红之眼的私酿营养与酒精混合物。单喝并不怎么好喝——至少对嗜血者来说是如此。"
	color = "#c29ca1"
	boozepwr = 25 // Still more concentrated than in Bloodshot.
	taste_description = "带有酒精劲道的营养混合物"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED


/datum/reagent/consumable/ethanol/bloodshot
	name = "血红之眼"
	description = "“血红之眼”的来历源自一种无味化学混合物，其设计目的是向嗜血者增生器官输送营养。由于正宗产品价格高昂，且制作过程充满医疗气息，这款烈酒被设计成一种“简易”替代品；不过喝起来仍像解酒药。它闻起来有铁锈味，这暗示了关键成分。"
	color = "#a30000"
	boozepwr = 20 // The only booze in it is Bloody Mary
	taste_description = "充满各类营养的血液"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	chemical_flags_skyrat = REAGENT_BLOOD_REGENERATING


/datum/glass_style/drinking_glass/bloodshot
	required_drink_type = /datum/reagent/consumable/ethanol/bloodshot
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "bloodshot"
	name = "一杯血红之眼"
	desc = "“血红之眼”的来历源自一种无味化学混合物，其设计目的是向嗜血者增生器官输送营养。由于正宗产品价格高昂，且制作过程充满医疗气息，这款烈酒被设计成一种“简易”替代品；不过喝起来仍像解酒药。它闻起来有铁锈味，这暗示了关键成分。"


#define BLOODSHOT_DISGUST 25

/datum/reagent/consumable/ethanol/bloodshot/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(exposed_mob.has_quirk(/datum/quirk/hemophage))
		quality = RACE_DRINK

	else if(exposed_mob.blood_volume < exposed_mob.blood_volume_normal)
		quality = DRINK_GOOD

	if(!quality) // Basically, you don't have a reason to want to have this in your system, it doesn't taste good to you!
		exposed_mob.adjust_disgust(BLOODSHOT_DISGUST)

	return ..()

#undef BLOODSHOT_DISGUST

/datum/reagent/consumable/ethanol/bloodshot/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(drinker.blood_volume < drinker.blood_volume_normal)
		drinker.blood_volume = max(drinker.blood_volume, min(drinker.blood_volume + (3 * REM * seconds_per_tick), BLOOD_VOLUME_NORMAL)) //Bloodshot quickly restores blood loss.

/datum/reagent/consumable/ethanol/blizzard_brew
	name = "暴雪酿"
	description = "一份古老的配方。最好冰镇到矮人所能做到的极限。"
	color = rgb(180, 231, 216)
	boozepwr = 25
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "远古冰锥"
	overdose_threshold = 25
	var/obj/structure/ice_stasis/cube
	var/atom/movable/screen/alert/status_effect/freon/cryostylane_alert

/datum/glass_style/drinking_glass/blizzard_brew
	required_drink_type = /datum/reagent/consumable/ethanol/blizzard_brew
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "blizzard_brew"
	name = "一杯暴雪酿"
	desc = "一份古老的配方。最好冰镇到矮人所能做到的极限。"

/datum/reagent/consumable/ethanol/blizzard_brew/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_NICE
	return ..()

/datum/reagent/consumable/ethanol/blizzard_brew/overdose_start(mob/living/carbon/drinker)
	. = ..()
	cube = new /obj/structure/ice_stasis(get_turf(drinker))
	cube.color = COLOR_CYAN
	cube.set_anchored(TRUE)
	drinker.forceMove(cube)
	cryostylane_alert = drinker.throw_alert("cryostylane_alert", /atom/movable/screen/alert/status_effect/freon/stasis)
	cryostylane_alert.attached_effect = src //so the alert can reference us, if it needs to

/datum/reagent/consumable/ethanol/blizzard_brew/on_mob_delete(mob/living/carbon/drinker, amount)
	QDEL_NULL(cube)
	drinker.clear_alert("cryostylane_alert")
	return ..()

/datum/reagent/consumable/ethanol/molten_mead
	name = "熔融蜂蜜酒"
	description = "以能点燃胡须而闻名。饮用风险自负！"
	color = rgb(224, 78, 16)
	boozepwr = 35
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	taste_description = "燃烧的黄蜂"
	overdose_threshold = 25

/datum/glass_style/drinking_glass/molten_mead
	required_drink_type = /datum/reagent/consumable/ethanol/molten_mead
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "molten_mead"
	name = "一杯熔融蜂蜜酒"
	desc = "以能点燃胡须而闻名。饮用风险自负！"

/datum/reagent/consumable/ethanol/molten_mead/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_VERYGOOD
	return ..()

/datum/reagent/consumable/ethanol/molten_mead/overdose_start(mob/living/carbon/drinker)
	drinker.adjust_fire_stacks(2)
	drinker.ignite_mob()
	..()

/datum/reagent/consumable/ethanol/hippie_hooch
	name = "嬉皮私酒"
	description = "和平与爱！应人事部的要求，这款饮品必定能让你迅速清醒。"
	color = rgb(77, 138, 34)
	boozepwr = -20
	taste_description = "蛋味大麻"
	var/static/list/status_effects_to_clear = list(
		/datum/status_effect/confusion,
		/datum/status_effect/dizziness,
		/datum/status_effect/drowsiness,
		/datum/status_effect/speech/slurring/drunk,
	)

/datum/glass_style/drinking_glass/hippie_hooch
	required_drink_type = /datum/reagent/consumable/ethanol/hippie_hooch
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "hippie_hooch"
	name = "一杯嬉皮私酒"
	desc = "和平与爱！应人事部的要求，这款饮品必定能让你迅速清醒。"

/datum/reagent/consumable/ethanol/hippie_hooch/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_FANTASTIC
	return ..()

/datum/reagent/consumable/ethanol/hippie_hooch/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	for(var/effect in status_effects_to_clear)
		affected_mob.remove_status_effect(effect)
	affected_mob.reagents.remove_reagent(/datum/reagent/consumable/ethanol, 3 * REM * seconds_per_tick, include_subtypes = TRUE)
	. = ..()
	if(affected_mob.adjust_tox_loss(-0.2 * REM * seconds_per_tick, updating_health = FALSE, required_biotype = affected_biotype))
		. = UPDATE_MOB_HEALTH
	affected_mob.adjust_drunk_effect(-10 * REM * seconds_per_tick)

/datum/reagent/consumable/ethanol/research_rum
	name = "研究朗姆"
	description = "由矮人科学家调配，这款发光的粉色酿酒必定能让你的思维火力全开。怎么做到的？科学！"
	color = rgb(169, 69, 169)
	boozepwr = 50
	taste_description = "滑腻的灰质"

/datum/glass_style/drinking_glass/research_rum
	required_drink_type = /datum/reagent/consumable/ethanol/research_rum
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "research_rum"
	name = "一杯研究朗姆"
	desc = "由矮人科学家调配，这款发光的粉色酿酒必定能让你的思维火力全开。怎么做到的？科学！"

/datum/reagent/consumable/ethanol/research_rum/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_GOOD
	return ..()

/datum/reagent/consumable/ethanol/research_rum/on_mob_life(mob/living/carbon/drinker, seconds_per_tick, times_fired)
	. = ..()
	if(prob(5))
		drinker.say(pick_list_replacements(VISTA_FILE, "ballmer_good_msg"), forced = "ballmer")

/datum/reagent/consumable/ethanol/golden_grog
	name = "黄金格罗格"
	description = "由一位时间和金钱都多得没处花的矮人货运主管调配的饮品。常被想要炫富的网红点单。"
	color = rgb(247, 230, 141)
	boozepwr = 70
	taste_description = "甜甜的信用点全息芯片"

/datum/glass_style/drinking_glass/golden_grog
	required_drink_type = /datum/reagent/consumable/ethanol/golden_grog
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "golden_grog"
	name = "一杯黄金格罗格"
	desc = "由一位时间和金钱都多得没处花的矮人货运主管调配的饮品。常被想要炫富的网红点单。"

/datum/reagent/consumable/ethanol/golden_grog/expose_mob(mob/living/exposed_mob, methods, reac_volume)
	if(isdwarf(exposed_mob))
		quality = RACE_DRINK
	else
		quality = DRINK_FANTASTIC
	return ..()

// RACIAL DRINKS END

/datum/reagent/consumable/ethanol/appletini
	name = "苹果马天尼"
	color = "#9bd1a9" //(155, 209, 169)
	description = "那款无人能拒绝的电光绿苹果饮品！"
	boozepwr = 50
	taste_description = "甜而青绿"
	quality = DRINK_GOOD

/datum/glass_style/drinking_glass/appletini
	required_drink_type = /datum/reagent/consumable/ethanol/appletini
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "appletini"
	name = "一杯苹果马天尼"
	desc = "装在马天尼杯里的苹果饮品"

/datum/reagent/consumable/ethanol/quadruple_sec/cityofsin //making this a subtype was some REAL JANK, but it saves me a headache, and it looks good!
	name = "罪恶之城"
	color = "#eb9378" //(235, 147, 120)
	description = "一款顺口而精致的饮品，献给名声不佳的人"
	boozepwr = 70
	taste_description = "你自己的罪孽"
	quality = DRINK_VERYGOOD //takes extra effort
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/cityofsin
	required_drink_type = /datum/reagent/consumable/ethanol/quadruple_sec/cityofsin
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "cityofsin"
	name = "一杯罪恶之城"
	desc = "看着它就会让你想起自己犯过的每一个错误。"

/datum/reagent/consumable/ethanol/shakiri
	name = "沙基里"
	description = "由发酵基里果实酿成的甜美芳香红色饮品。在光线下似乎会轻轻闪烁。"
	boozepwr = 45
	color = "#cf3c3c"
	quality = DRINK_GOOD
	taste_description = "融化后美味的果冻"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/glass_style/drinking_glass/shakiri
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri"
	name = "一杯沙基里"
	desc = "由发酵基里果实酿成的甜美芳香红色饮品。在光线下似乎会轻轻闪烁。"

/datum/reagent/consumable/ethanol/shakiri_spritz
	name = "沙基里汽酒"
	description = "用沙基里、橙汁和苏打水调制的碳酸鸡尾酒。"
	color = "#cf863c"
	quality = DRINK_GOOD
	boozepwr = 45
	taste_description = "酸爽带气的甜味"

/datum/glass_style/drinking_glass/shakiri_spritz
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri_spritz
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri_spritz"
	name = "一杯沙基里汽酒"
	desc = "用沙基里、橙汁和苏打水调制的碳酸鸡尾酒。"

/datum/reagent/consumable/ethanol/crimson_hurricane
	name = "绯红飓风"
	description = "一款源自人类的烈性柑橘鸡尾酒，如今改用沙基里与基里果冻调制，甜得令人愉悦。"
	color = "#b86637"
	quality = DRINK_VERYGOOD
	boozepwr = 60
	taste_description = "浓稠的果味甜香，后劲十足"

/datum/glass_style/drinking_glass/crimson_hurricane
	required_drink_type = /datum/reagent/consumable/ethanol/crimson_hurricane
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "crimson_hurricane"
	name = "一杯绯红飓风"
	desc = "一款源自人类的烈性柑橘鸡尾酒，如今加入沙基里与基里果冻，甜得令人愉悦。"

/datum/reagent/consumable/ethanol/shakiri_rogers
	name = "沙基里罗杰斯"
	description = "对经典“罗伊·罗杰斯”的改编，用沙基里代替红石榴糖浆。甜美清爽。"
	color = "#6F2B1A"
	quality = DRINK_GOOD
	boozepwr = 45
	taste_description = "果味碳酸汽水，略带后劲"

/datum/glass_style/drinking_glass/shakiri_rogers
	required_drink_type = /datum/reagent/consumable/ethanol/shakiri_rogers
	icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	icon_state = "shakiri_rogers"
	name = "一杯沙基里罗杰斯"
	desc = "对经典“罗伊·罗杰斯”的改编，用沙基里代替红石榴糖浆。甜美清爽。"
