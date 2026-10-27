// Hey! Listen! Update \config\lavaruinblacklist.txt with your new ruins!

/datum/map_template/ruin/lavaland
	ruin_type = ZTRAIT_LAVA_RUINS
	prefix = "_maps/RandomRuins/LavaRuins/"
	default_area = /area/lavaland/surface/outdoors/unexplored

/datum/map_template/ruin/lavaland/biodome
	cost = 5
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/biodome/beach
	name = "Lava-Ruin Biodome Beach"
	id = "biodome-beach"
	description = "这片海滩仿佛直接搬自热带胜地，宁静凉爽，咸涩的海浪在远处轻声翻涌。\
	附带一间质朴的木制酒吧，以及一名有自杀倾向的酒保。"
	suffix = "lavaland_biodome_beach.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/biodome/winter
	name = "Lava-Ruin Biodome Winter"
	id = "biodome-winter"
	description = "如果你想回归自然，却又不愿离开日常生活中戒备森严的军事基地，这里就是理想的度假胜地。\
	内含独一无二(*)的激光手枪展柜，以及新近推出的 I.C.E(tm)。"
	suffix = "lavaland_surface_biodome_winter.dmm"

/datum/map_template/ruin/lavaland/biodome/clown
	name = "Lava-Ruin Biodome Clown Planet"
	id = "biodome-clown"
	description = "欢迎来到小丑星球！HONK HONK HONK，诸如此类！"
	suffix = "lavaland_biodome_clown_planet.dmm"

/datum/map_template/ruin/lavaland/lizgas
	name = "Lava-Ruin The Lizard's Gas"
	id = "lizgas2"
	description = "蜥蜴加油站连锁品牌新近开设的一家分店。"
	prefix = "_maps/RandomRuins/LavaRuins/bubberstation/" //BUBBER ADDITION
	suffix = "lavaland_surface_gas_bubber.dmm" //BUBBER EDIT - ORIGINAL: lavaland_surface_gas.dmm
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/cube
	name = "Lava-Ruin The Wishgranter Cube"
	id = "wishgranter-cube"
	description = "这里不会有什么好事。吸取他们的教训，回头吧。"
	suffix = "lavaland_surface_cube.dmm"
	cost = 10
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/seed_vault
	name = "Lava-Ruin Seed Vault"
	id = "seed-vault"
	description = "这些宝库由一个高度发达而仁慈的种族建造，他们将许多宝库送往群星，希望帮助新生的文明。\
	然而，里面的居民似乎只顾着种毒品和枪。"
	suffix = "lavaland_surface_seed_vault.dmm"
	cost = 10
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/ash_walker
	name = "Lava-Ruin Ash Walker Nest"
	id = "ash-walker"
	description = "这里住着一群不需要呼吸的蜥蜴人，跑得比人类更快，崇拜一座破败死城，还能用某种涉及触手的方式繁殖？\
	最好还是离远点。"
	prefix = "_maps/RandomRuins/LavaRuins/skyrat/" // SKYRAT ADDITION
	suffix = "lavaland_surface_ash_walker1_skyrat.dmm" // SKYRAT EDIT - ORIGINAL: lavaland_surface_ash_walker1.dmm
	cost = 1000 //SKYRAT EDIT: Original: 20
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE
//SKYRAT EDIT REMOVAL BEGIN - MAPPING
/*
/datum/map_template/ruin/lavaland/syndicate_base
	name = "Lava-Ruin Syndicate Lava Base"
	id = "lava-base"
	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
	suffix = "lavaland_surface_syndicate_base1.dmm"
	cost = 20
	allow_duplicates = FALSE
*/
//SKYRAT EDIT REMOVAL END
/datum/map_template/ruin/lavaland/free_golem
	name = "Lava-Ruin Free Golem Ship"
	id = "golem-ship"
	description = "这艘船里活动着由贵重金属构成、步履笨重的人形生物。它们经常外出采矿，再用某种方法把矿物变成更多同类。\
	它们似乎很重视研究和个人自由，还有按地质学取名字？"
	cost = 20
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "golem_ship.dmm"
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/gaia
	name = "Lava-Ruin Patch of Eden"
	id = "gaia"
	description = "谁能想到如此可怕的星球上，会有这样宁静的地方？"
	cost = 5
	suffix = "lavaland_surface_gaia.dmm"
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/sin
	cost = 10
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/sin/envy
	name = "Lava-Ruin Ruin of Envy"
	id = "envy"
	description = "等你拥有了他们拥有的一切，你就终于会幸福了。"
	suffix = "lavaland_surface_envy.dmm"

/datum/map_template/ruin/lavaland/sin/gluttony
	name = "Lava-Ruin Ruin of Gluttony"
	id = "gluttony"
	description = "只要吃得够多，你的人生就只剩下吃。"
	suffix = "lavaland_surface_gluttony.dmm"

/datum/map_template/ruin/lavaland/sin/greed
	name = "Lava-Ruin Ruin of Greed"
	id = "greed"
	description = "当然，你并不需要魔法力量，但你想要它们，\
		这才是最重要的。"
	suffix = "lavaland_surface_greed.dmm"

/datum/map_template/ruin/lavaland/sin/pride
	name = "Lava-Ruin Ruin of Pride"
	id = "pride"
	description = "虫洞救生腰带是给失败者用的，而你比他们强。"
	suffix = "lavaland_surface_pride.dmm"

/datum/map_template/ruin/lavaland/sin/sloth
	name = "Lava-Ruin Ruin of Sloth"
	id = "sloth"
	description = "..."
	suffix = "lavaland_surface_sloth.dmm"
	// Generates nothing but atmos runtimes and salt
	cost = 0
	terrain_padding = 2

/datum/map_template/ruin/lavaland/ratvar
	name = "Lava-Ruin Dead God"
	id = "ratvar"
	description = "拉特瓦的最终安息之地。"
	suffix = "lavaland_surface_dead_ratvar.dmm"
	cost = 0
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/hierophant
	name = "Lava-Ruin Hierophant's Arena"
	id = "hierophant"
	description = "一块巨大而奇异的方形金属。里面等待你的只有死亡，以及无数的方块。"
	suffix = "lavaland_surface_hierophant.dmm"
	always_place = TRUE
	allow_duplicates = FALSE
	terrain_padding = 2

/datum/map_template/ruin/lavaland/blood_drunk_miner
	name = "Lava-Ruin Blood-Drunk Miner"
	id = "blooddrunk"
	description = "一片排列诡异的石砖，以及一名凝视着它们、疯狂如野兽的矿工。"
	suffix = "lavaland_surface_blooddrunk1.dmm"
	cost = 0
	allow_duplicates = FALSE //will only spawn one variant of the ruin
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/blood_drunk_miner/guidance
	name = "Lava-Ruin Blood-Drunk Miner (Guidance)"
	suffix = "lavaland_surface_blooddrunk2.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/blood_drunk_miner/hunter
	name = "Lava-Ruin Blood-Drunk Miner (Hunter)"
	suffix = "lavaland_surface_blooddrunk3.dmm"
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/blood_drunk_miner/random
	name = "Lava-Ruin Blood-Drunk Miner (Random)"
	suffix = null
	always_place = TRUE

/datum/map_template/ruin/lavaland/blood_drunk_miner/random/New()
	suffix = pick("lavaland_surface_blooddrunk1.dmm", "lavaland_surface_blooddrunk2.dmm", "lavaland_surface_blooddrunk3.dmm")
	return ..()

/datum/map_template/ruin/lavaland/ufo_crash
	name = "Lava-Ruin UFO Crash"
	id = "ufo-crash"
	description = "原来让被绑架者保持昏迷真的很重要。谁能想到呢？"
	suffix = "lavaland_surface_ufo_crash.dmm"
	cost = 5
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/xeno_nest
	name = "Lava-Ruin Xenomorph Nest"
	id = "xeno-nest"
	description = "这些异形厌倦了在空间站上残忍屠杀人类，于是在这片遍布熔岩的美好地狱安家，专注于生命中真正重要的事。\
	优质梗图。"
	suffix = "lavaland_surface_xeno_nest.dmm"
	cost = 20
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/fountain
	name = "Lava-Ruin Fountain Hall"
	id = "lava_fountain"
	description = "喷泉侧面有一条警告。危险：可能存在未注明的副作用，使用后才会显现。"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"
	cost = 5

/datum/map_template/ruin/lavaland/survivalcapsule
	name = "Lava-Ruin Survival Capsule Ruins"
	id = "survivalcapsule"
	description = "这里曾是普通矿工的避难所，如今却成了他们的坟墓。"
	suffix = "lavaland_surface_survivalpod.dmm"
	cost = 5

/datum/map_template/ruin/lavaland/pizza
	name = "Lava-Ruin Ruined Pizza Party"
	id = "pizza"
	description = "一个蓝空间异常经过后，小蒂米的生日披萨派对变成了一场灾难。"
	suffix = "lavaland_surface_pizzaparty.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/cultaltar
	name = "Lava-Ruin Summoning Ritual"
	id = "cultaltar"
	description = "一处邪恶的祭祀场所，中央的血色涂画散发着诡异光芒。恶魔的笑声在洞穴中回荡。"
	suffix = "lavaland_surface_cultaltar.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/lavaland/hermit
	name = "Lava-Ruin Makeshift Shelter"
	id = "hermitcave"
	description = "一位孤独隐士的避难所，他在这里艰难度日。"
	suffix = "lavaland_surface_hermit.dmm"
	allow_duplicates = FALSE
	cost = 10

/datum/map_template/ruin/lavaland/miningripley
	name = "Lava-Ruin Ripley"
	id = "ripley"
	description = "一台严重损坏的雷普利采矿机甲，属于一名非常倒霉的矿工。修好它恐怕得费一番功夫。"
	suffix = "lavaland_surface_random_ripley.dmm"
	allow_duplicates = FALSE
	cost = 5
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/dark_wizards
	name = "Lava-Ruin Dark Wizard Altar"
	id = "dark_wizards"
	description = "一座有黑巫师盘踞的遗迹。他们守护着什么秘密？"
	suffix = "lavaland_surface_wizard.dmm"
	cost = 5
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/strong_stone
	name = "Lava-Ruin Strong Stone"
	id = "strong_stone"
	description = "一块看起来格外强大的石头。"
	suffix = "lavaland_strong_rock.dmm"
	allow_duplicates = FALSE
	cost = 2

/datum/map_template/ruin/lavaland/puzzle
	name = "Lava-Ruin Ancient Puzzle"
	id = "puzzle"
	description = "一个有待解开的谜。"
	suffix = "lavaland_surface_puzzle.dmm"
	cost = 5

/datum/map_template/ruin/lavaland/elite_tumor
	name = "Lava-Ruin Pulsating Tumor"
	id = "tumor"
	description = "一个孕育着强大野兽的奇异肿瘤……"
	suffix = "lavaland_surface_elite_tumor.dmm"
	cost = 5
	always_place = TRUE
	allow_duplicates = TRUE

/datum/map_template/ruin/lavaland/elephant_graveyard
	name = "Lava-Ruin Elephant Graveyard"
	id = "Graveyard"
	description = "一片荒废的墓地，呼唤着那些无法继续前行的生命。"
	suffix = "lavaland_surface_elephant_graveyard.dmm"
	allow_duplicates = FALSE
	cost = 10
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/bileworm_nest
	name = "Lava-Ruin Bileworm Nest"
	id = "bileworm_nest"
	description = "一处躲避险恶荒野的小小庇护所……前提是你是一条胆汁虫。"
	cost = 5
	suffix = "lavaland_surface_bileworm_nest.dmm"
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/lava_phonebooth
	name = "Lava-Ruin Phonebooth"
	id = "lava_phonebooth"
	description = "纳米传讯为推广全息通讯台而推出的项目。这一座不知怎么来到了这里。"
	suffix = "lavaland_surface_phonebooth.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/battle_site
	name = "Lava-Ruin Battle Site"
	id = "battle_site"
	description = "野兽与人形生物久远战斗的遗址。胜者不明，败者却一目了然。"
	suffix = "lavaland_battle_site.dmm"
	allow_duplicates = TRUE
	cost = 3

/datum/map_template/ruin/lavaland/vent
	name = "Lava-Ruin Ore Vent"
	id = "ore_vent"
	description = "一个喷出矿石的喷口。似乎是自然现象。"
	suffix = "lavaland_surface_ore_vent.dmm"
	allow_duplicates = TRUE
	cost = 0
	mineral_cost = 1
	always_place = TRUE

/datum/map_template/ruin/lavaland/watcher_grave
	name = "Lava-Ruin Watchers' Grave"
	id = "watcher-grave"
	description = "一座孤寂的洞穴，失去双亲的幼崽在这里等待新的父母。"
	suffix = "lavaland_surface_watcher_grave.dmm"
	cost = 5
	allow_duplicates = FALSE

/datum/map_template/ruin/lavaland/mook_village
	name = "Lava-Ruin Mook Village"
	id = "mook_village"
	description = "一座住着友善小怪们的村庄！"
	suffix = "lavaland_surface_mookvillage.dmm"
	allow_duplicates = FALSE
	cost = 5

/datum/map_template/ruin/lavaland/shuttle_wreckage
	name = "Lava-Ruin Shuttle Wreckage"
	id = "shuttle_wreckage"
	description = "并不是每艘穿梭机都能返回中央指挥部。"
	suffix = "lavaland_surface_shuttle_wreckage.dmm"
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE


/datum/map_template/ruin/lavaland/crashsite
	name = "Lava-Ruin Pod Crashsite"
	id = "crashsite"
	description = "他们发射得太早了。"
	suffix = "lavaland_surface_crashsite.dmm"
	allow_duplicates = FALSE
	enclosed_for_terrain = TRUE

/datum/map_template/ruin/lavaland/shoe_facotry
	name = "Lava-Ruin Shoe Factory"
	id = "shoe_factory"
	description = "一座废弃的制鞋厂。"
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "shoe_factory.dmm"
	allow_duplicates = FALSE
	cost = 10
