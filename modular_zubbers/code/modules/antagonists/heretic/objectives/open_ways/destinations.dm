/datum/way_destination
	abstract_type = /datum/way_destination
	var/name
	var/desc
	/// Displayed on examine by a non-heretic, alongst a lot of brain damage. Starts with YOU CATCH A GLIMPSE: and ends with --!!!
	var/glimpse
	var/glimpse_heretic
	/// Displayed when the way opens fully.
	var/spawn_text

/datum/way_destination/proc/open(obj/effect/unopened_way/way, mob/living/opener)
	return

/datum/way_destination/proc/get_spawn_turfs(obj/effect/unopened_way/way, range = 1)
	RETURN_TYPE(/list/turf)

	var/list/turf/turfs = list()

	turfs += get_turf(way)

	for(var/turf/nearby_turf in oview(range, get_turf(way))) // oview, since we always add our loc to the list
		if(!nearby_turf.is_blocked_turf())
			turfs += nearby_turf

	return turfs

#define MOLS_TO_SPAWN 4000

/datum/way_destination/atmosphere
	name = "云海"
	desc = "鲜有存在敢踏入漫宿的天空。那里空无几物，偶有事物出现，也会很快被光焚烧、卷走。\
	然而，在连鸮也看不见的一个角落，聚集着一片气云，其中的气体有些属于凡世与夜境，有些则全然陌生。"
	glimpse = "雾气弥漫绿红蓝白纹路斑马光与暗与"
	glimpse_heretic = "光灼烧着眼前的雾气，形成一场只有你才会为之着迷的邪异光景。"
	spawn_text = "五彩气云形成的旋风从中喷涌而出！"
	var/static/list/spawnable_gasses = list(
		// neutral/slightly negative
		/datum/gas/nitrous_oxide = 50,
		/datum/gas/bz = 50,
		// desirable
		///datum/gas/healium = 500, // fire alarms dont activate :/
		/datum/gas/goblin = 10, // rare asf
		/datum/gas/hypernoblium = 200,
		/datum/gas/freon = 300,
		/datum/gas/pluoxium = 300,
		/datum/gas/nitrium = 200,
		// downright bad
		/datum/gas/zauker = 300,
		/datum/gas/miasma = 400,
		/datum/gas/carbon_dioxide = 100,
	)

/datum/way_destination/atmosphere/open(obj/effect/unopened_way/way, mob/living/opener)
	var/datum/gas/picked_gas = pick_weight(spawnable_gasses)
	var/list/turf/turfs = RANGE_TURFS(1, get_turf(way))
	for (var/turf/iter_turf as anything in turfs)
		iter_turf.atmos_spawn_air("[picked_gas.id]=[MOLS_TO_SPAWN]")

#undef MOLS_TO_SPAWN

/datum/way_destination/flesh_organs
	name = "屠宰场"
	desc = "密林深处，浓密灌木掩藏着一座工厂，只出产漫宿最上等的肉块。口味独特者\
	会前往这处隐秘角落，满足更加罪恶的嗜好，也许顺便再带走一两条胳膊。此地由残暴的\
	钢铁之神织皮者统治，幽灵与其他恶意存在往往敬而远之。"
	glimpse = "天啊！天啊！！这么多血！！肉！！器官！！眼睛！！挂在肉钩上！！下一个就是我！！下一个就是我"
	glimpse_heretic = "一名面带微笑的屠夫面对着敞开的通路，招手让你靠近。沾满血肉的屠刀在光中闪耀，\
	等待着切入你的血肉，将你化为神圣的佳肴……"
	spawn_text = "一阵骇人的血肉、内脏与器官从中喷出！"
	var/static/list/potential_mob_spawns = list(
		/mob/living/basic/heretic_summon/raw_prophet/ruins = 50,
	)
	var/static/list/potential_organ_spawns = list(
		/obj/item/organ/heart/evolved = 100,
		/obj/item/organ/liver/evolved = 100,
		/obj/item/organ/lungs/evolved = 100,
		/obj/item/organ/stomach/evolved = 100,
		/obj/item/organ/ears/babbelfish = 10,
		/obj/item/organ/stomach/alien = 10,
		/obj/item/organ/eyes/alien = 10,
	)
	var/static/mobs_to_spawn = 6
	var/static/organs_to_spawn = 4

/datum/way_destination/flesh_organs/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	new /obj/effect/gibspawner/generic(get_turf(way))
	new /obj/effect/gibspawner/generic(get_turf(way))
	new /obj/effect/gibspawner/generic(get_turf(way))

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/mob/living/basic/heretic_summon/typepath = pick_weight(potential_mob_spawns)
		var/mob/living/monster = new typepath(pick(potential_locations))
		monster.set_faction(list(FACTION_HERETIC_WILD))

	var/to_spawn_organs = organs_to_spawn
	while (to_spawn_organs-- > 0)
		var/obj/item/organ/typepath = pick(potential_organ_spawns)
		new typepath(get_turf(way))

/datum/way_destination/knowledgebooks
	name = "登临秘藏馆"
	desc = "在漫宿群峰的极高处，越过刀山与蠕虫之宴，矗立着被遗忘、也令人无法记住的\
	秘藏馆。蛛灵将各类知识收集于此，封存起来，永不阅读。任何愚蠢的闯入者\
	都会立即遭到镜魔袭击，脚步过响者则会被守望女士抹杀。"
	glimpse = "知识知识知识知%@识^%%&%&%!%&^^!$$!"
	glimpse_heretic = "无穷无尽的知识洪流穿过帷幕的缝隙，庞大的数量几乎令你失明。你完全无法\
	理解……但即便在这里，光也无处不在。"
	spawn_text = "原始知识及其守护者的洪流从中喷涌而出！"
	var/static/list/potential_book_spawns = list(
		/obj/item/book/granter/crafting_recipe/death_sandwich = 500,
		/obj/item/book/granter/crafting_recipe/trash_cannon = 500,
		/obj/item/book/granter/crafting_recipe/boneyard_notes = 500,
		/obj/item/book/granter/crafting_recipe/cooking_sweets_101 = 500,
		/obj/item/book/granter/crafting_recipe/dusting/laser_musket_prime = 500,
		/obj/item/book/granter/crafting_recipe/dusting/pipegun_prime = 500,
		/obj/item/book/granter/crafting_recipe/dusting/smoothbore_disabler_prime = 500,
		/obj/item/book/granter/crafting_recipe/fletching = 200,
		/obj/item/book/granter/crafting_recipe/donk_secret_recipe = 200,
		/obj/item/book/granter/crafting_recipe/regal_condor = 1,
	)
	var/static/mobs_to_spawn = 4
	var/static/books_to_spawn = 4
	var/static/cooling = 500

/datum/way_destination/knowledgebooks/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/mob/living/maid = new /mob/living/basic/heretic_summon/maid_in_the_mirror(pick(potential_locations))
		maid.set_faction(list(FACTION_HERETIC_WILD))

	var/to_spawn_organs = books_to_spawn
	while (to_spawn_organs-- > 0)
		var/obj/typepath = pick_weight(potential_book_spawns)
		new typepath(pick(potential_locations))

	for (var/turf/target_turf as anything in potential_locations)
		var/datum/gas_mixture/enviro = target_turf.return_air()
		enviro.temperature = max(enviro.temperature - cooling, 10)
		target_turf.air_update_turf(FALSE, FALSE)

/datum/way_destination/clown_planet
	name = "小丑深渊"
	desc = "在极深、极深、极深的无何有之地，在深渊之中，远离活神的目光，远离任何存在的感知——安息着\
	一位死神。比人类与非人所知的一切都更死寂、更冰冷。黑暗、黄橙色和永恒不死的守卫簇拥着\
	这位无名、无闻的神。祂唯一的遗产……便是……嘟。"
	glimpse = "嘟——————————————"
	glimpse_heretic = "巨神躺在你面前，周围环绕着腐化的黄金与守卫。守卫凝视着你，在\
	这道不受欢迎的狭窄侵入口与受守护者之间筑起一道墙。这里没有光，从来都没有光。当你凝望\
	深渊时，一阵寒意掠过脊背。"
	spawn_text = "刺耳的喇叭声响起，随后喷出了奇异的金色金属与披金守卫！"
	var/static/clowns_to_spawn = 6
	var/static/bananium_sheet_size = 20

/datum/way_destination/clown_planet/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = clowns_to_spawn
	while (to_spawn-- > 0)
		new /mob/living/basic/clown/clownhulk/destroyer(pick(potential_locations))

	new /obj/item/stack/sheet/mineral/bananium(get_turf(way), bananium_sheet_size)

	playsound(way, 'sound/items/airhorn/airhorn.ogg', 100, TRUE)
	for(var/mob/living/honk_victim in hearers(6, way))
		if(issilicon(honk_victim))
			continue
		var/turf/victim_turf = get_turf(honk_victim)
		if(isspaceturf(victim_turf) && !victim_turf.Adjacent(way)) //Prevents getting honked in space
			continue
		if(honk_victim.soundbang_act(SOUNDBANG_NORMAL, stun_pwr = 5, damage_pwr = 15, deafen_pwr = 30)) //Ear protection will prevent these effects
			honk_victim.set_jitter_if_lower(120 SECONDS)
			to_chat(honk_victim, span_clown("嘟————！"))

/datum/way_destination/anomalies
	name = "混沌穹域"
	desc = "漫宿深处，越过骨门，在玻璃博物馆后方，有一座环境变幻不定的缥缈穹顶。\
	穹顶内，织皮者为自身目的孕育了无法理解的混沌，连漫宿的法则都随之扭曲变化。只有\
	原住者和飞升者能毫发无伤地穿过穹顶，却鲜有人愿意谈起其中所见。"
	glimpse = "你看不懂你眼前的东西你看不懂你无法描述它你不能你不能你" // yeah its utterly incomprehensible
	glimpse_heretic = "即使你的心智久经锤炼，透过狭窄通路望向混沌穹顶也令你痛苦。然而——在\
	变幻的混沌潮汐、成千上万的宇宙之间，你瞥见了它。光。"
	spawn_text = "一缕混沌在通路彻底关闭之前逸散而出！"
	var/static/list/spawnable_anomalies = list(
		/obj/effect/anomaly/pyro = 500,
		/obj/effect/anomaly/grav/high = 500,
		/obj/effect/anomaly/hallucination = 500,
		/obj/effect/anomaly/dimensional = 500,
		/obj/effect/anomaly/bluespace = 300,
		/obj/effect/anomaly/ectoplasm = 200,
		/obj/effect/anomaly/bioscrambler = 100,
		/obj/effect/anomaly/flux = 50,
		/obj/effect/anomaly/bhole = 1
	)
	var/static/anomalies_to_spawn = 5

/datum/way_destination/anomalies/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = anomalies_to_spawn
	while (to_spawn-- > 0)
		var/obj/effect/anomaly/typepath = pick_weight(spawnable_anomalies)
		new typepath(pick(potential_locations), 180 SECONDS)

// bad destinations - no benefit

/datum/way_destination/heretic_mobs
	name = "铸怪工坊"
	desc = "铸怪工坊曾属于一位逝去已久的神，如今在新生钢铁之神的掌管下继续履行肃穆的职责。它盘踞\
	在远古深渊的绝壁上，有缺陷的野兽被丢下去喂食饥饿的渊鹫，其余的则\
	投入永无止境的战争——无论死者还是生者，都不记得这场战争的目的。"
	glimpse = "成千上万的野兽与工具与肉与骨！锈蚀和脑组织构成的恐怖怪物"
	glimpse_heretic = "整齐排列的食人魔、野兽和白骨食尸鬼在你面前绵延开来，展现出成千上万甚至数百万只\
	可怕的怪物。远处，闪耀着光的神钢工具正把新死者的血肉改造成这些畸形造物。\
	工作仍将继续。"
	spawn_text = "无数可怕的野兽和怪物在通路彻底关闭前逃了出来！"
	var/static/list/potential_mob_spawns = list(
		/mob/living/basic/heretic_summon/raw_prophet/ruins = 50,
		/mob/living/basic/heretic_summon/ash_spirit = 50,
		/mob/living/basic/heretic_summon/maid_in_the_mirror = 50,
		/mob/living/basic/heretic_summon/rust_walker = 50,
		/mob/living/basic/heretic_summon/fire_shark = 50,
		/mob/living/basic/heretic_summon/stalker = 5,
	)
	var/static/mobs_to_spawn = 7

/datum/way_destination/heretic_mobs/open(obj/effect/unopened_way/way, mob/living/opener)
	var/list/potential_locations = get_spawn_turfs(way, 1)

	var/to_spawn = mobs_to_spawn
	while (to_spawn-- > 0)
		var/obj/effect/anomaly/typepath = pick_weight(potential_mob_spawns)
		var/mob/living/monster = new typepath(pick(potential_locations))
		monster.set_faction(list(FACTION_HERETIC_WILD))

/datum/way_destination/emp
	name = "魂之风暴"
	desc = "错过骨门、迷失漫宿者，可能转而撞见这道邪异能量的漩涡。\
	在贵胄的庇护下，魂之风暴化身为这些迷失者的绝望、恐惧与灵魂空洞。\
	此地极度危险。这条通路恐怕无法长久维持安全。"
	glimpse = "尖叫与闪电构成的紫色漩涡还有不断壮大的存在"
	glimpse_heretic = "你难以直视。痛苦尖叫的灵魂绕着无尽圆环盘旋，以一切可想象的姿态扭曲挣扎。\
	背景中的虚空微笑着。然而……你依然看见了一丝光。"
	spawn_text = "就在彻底关闭前，魂之风暴的一缕支流击中了通路，释放出恐怖能量！"

/datum/way_destination/emp/open(obj/effect/unopened_way/way, mob/living/opener)
	empulse(get_turf(way), 3, 12, emp_source = way)
