#define MUT_MSG_IMMEDIATE 1
#define MUT_MSG_EXTENDED 2
#define MUT_MSG_ABOUT2TURN 3

#define CYCLES_TO_TURN 20
#define CYCLES_MSG_IMMEDIATE 6
#define CYCLES_MSG_EXTENDED 16

/datum/reagent/transformative_virus/
	var/transformation_disease = /datum/disease/transformation_race

/datum/reagent/transformative_virus/expose_mob(mob/living/exposed_mob, methods = TOUCH, reac_volume, show_message = TRUE, touch_protection = 0)
	. = ..()
	if((methods & (PATCH | INGEST | INJECT | INHALE)) || ((methods & (VAPOR | TOUCH)) && prob(min(reac_volume,100) * (1 - touch_protection))))
		exposed_mob.ForceContractDisease(new transformation_disease(), FALSE, TRUE)

/datum/reagent/mutationtoxin/on_mob_life(mob/living/carbon/human/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	if(SPT_PROB(12, seconds_per_tick))
		var/list/pick_ur_fav = list()
		var/filter = NONE
		if(current_cycle <= CYCLES_MSG_IMMEDIATE)
			filter = MUT_MSG_IMMEDIATE
		else if(current_cycle <= CYCLES_MSG_EXTENDED)
			filter = MUT_MSG_EXTENDED
		else
			filter = MUT_MSG_ABOUT2TURN

		for(var/i in mutationtexts)
			if(mutationtexts[i] == filter)
				pick_ur_fav += i
		to_chat(affected_mob, span_warning("[pick(pick_ur_fav)]"))

/datum/reagent/mutationtoxin/abductor
	mutationtexts = list(
		"你的皮肤正在变成灰色。" = MUT_MSG_IMMEDIATE,
		"你的头发一撮撮地脱落。" = MUT_MSG_IMMEDIATE,
		"你发现自己越来越难开口说话。" = MUT_MSG_EXTENDED,
		"你感到头部一阵刺痛。" = MUT_MSG_EXTENDED,
		"Xap Xoorp!" = MUT_MSG_ABOUT2TURN)


/datum/reagent/mutationtoxin/akula
	name = "阿库拉突变毒素"
	description = "一种阿库拉毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/akula
	taste_description = "鱼"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你觉得浑身发痒。" = MUT_MSG_IMMEDIATE,
		"你的皮肤湿漉漉的。" = MUT_MSG_IMMEDIATE,
		"你的皮肤上正在长出鱼鳞。" = MUT_MSG_EXTENDED,
		"你呼吸困难。" = MUT_MSG_EXTENDED,
		"你得赶紧找到水，马上！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/transformative_virus/android
	name = "仿生人纳米机器"
	description = "与机械合而为一。"
	color = "#535E66"  //RGB: 94, 255, 59
	taste_description = "电路与钢铁"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	transformation_disease = /datum/disease/transformation_race/android

/datum/reagent/mutationtoxin/anthromorph
	name = "兽人突变毒素"
	description = "一种兽人化毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/mammal
	taste_description = "湿狗"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你感到皮肤上有阵阵针刺感。" = MUT_MSG_IMMEDIATE,
		"你注意到身上覆了一层细毛。" = MUT_MSG_IMMEDIATE,
		"你的毛越来越浓密了。" = MUT_MSG_EXTENDED,
		"你的鼻子湿了。" = MUT_MSG_EXTENDED,
		"你觉得自己毛茸茸的。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ash
	mutationtexts = list(
		"你觉得非常冷。" = MUT_MSG_IMMEDIATE,
		"你的皮肤很干燥。" = MUT_MSG_IMMEDIATE,
		"你的皮肤开始长出鳞片，摸起来十分坚硬。" = MUT_MSG_EXTENDED,
		"你的思绪一片混沌。" = MUT_MSG_EXTENDED,
		"你渴望回到火山荒原。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/dwarf
	name = "矮人突变毒素"
	description = "一种矮人化毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/dwarf
	taste_description = "麦酒与泥土"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你想喝点麦酒。" = MUT_MSG_IMMEDIATE,
		"你感到一阵眩晕。" = MUT_MSG_IMMEDIATE,
		"那些幽闭的维护隧道让你感到宾至如归。" = MUT_MSG_EXTENDED,
		"你的骨头感觉更密实了。" = MUT_MSG_EXTENDED,
		"岩石与矿石，深入骨髓。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ethereal
	name = "以太人突变毒素"
	description = "一种灯泡毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ethereal
	taste_description = "电流"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你感到皮肤微微发麻。" = MUT_MSG_IMMEDIATE,
		"你的头发竖了起来。" = MUT_MSG_IMMEDIATE,
		"你觉得暖和。" = MUT_MSG_EXTENDED,
		"附近的电子设备似乎嗡鸣得更响了。" = MUT_MSG_EXTENDED,
		"你的血肉发出明亮的光芒。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/felinid
	mutationtexts = list(
		"你感到皮肤微微发麻。" = MUT_MSG_IMMEDIATE,
		"你的头发竖了起来。" = MUT_MSG_IMMEDIATE,
		"你的耳朵开始变得毛茸茸的。" = MUT_MSG_EXTENDED,
		"激光开始吸引你的注意力。" = MUT_MSG_EXTENDED,
		"喵呜 咕噜 喵嗷！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/felinid/primitive
	name = "冰行者突变毒素"
	description = "一种冰行者毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/human/felinid/primitive
	taste_description = "某种古老而冰冷的东西"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的思绪一片混沌。" = MUT_MSG_IMMEDIATE,
		"你的头发竖了起来。" = MUT_MSG_IMMEDIATE,
		"你觉得非常暖和。" = MUT_MSG_EXTENDED,
		"你想去打猎。" = MUT_MSG_EXTENDED,
		"你在雪地里感觉更自在。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/fly
	mutationtexts = list(
		"你的舌头一阵发麻。" = MUT_MSG_IMMEDIATE,
		"你的胃翻腾不止。" = MUT_MSG_IMMEDIATE,
		"你的眼睛刺痛。" = MUT_MSG_IMMEDIATE,
		"你的舌头变成了一根口器。" = MUT_MSG_EXTENDED,
		"你的眼睛变成复眼，视野被分散成成千上万个画面。" = MUT_MSG_EXTENDED,
		"垃圾和腐肉开始变得诱人。" = MUT_MSG_EXTENDED,
		"嗡嗡嗡。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/ghoul
	name = "食尸鬼突变毒素"
	description = "一种食尸鬼毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/ghoul
	taste_description = "腐肉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的肌肉酸痛。" = MUT_MSG_IMMEDIATE,
		"你的胃翻腾不止。" = MUT_MSG_IMMEDIATE,
		"你注意到皮肤上出现了腐败的斑点。" = MUT_MSG_EXTENDED,
		"腐肉开始变得诱人。" = MUT_MSG_EXTENDED,
		"你的大片血肉脱落下来。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/golem
	mutationtexts = list(
		"你感觉胃里像塞满了碎石。" = MUT_MSG_IMMEDIATE,
		"你的关节僵硬。" = MUT_MSG_IMMEDIATE,
		"你的关节非常僵硬。" = MUT_MSG_EXTENDED,
		"岩石开始在你皮肤上生长。奇怪的是，它并不觉得沉重。" = MUT_MSG_EXTENDED,
		"石质增生将你完全包裹。 " = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/insect
	name = "昆虫人突变毒素"
	description = "一种昆虫化毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/insect
	taste_description = "蜂蜜"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的舌头一阵发麻。" = MUT_MSG_IMMEDIATE,
		"你的皮肤松松垮垮的。" = MUT_MSG_IMMEDIATE,
		"你的皮肤开始撕裂，露出下面发亮的甲壳。" = MUT_MSG_EXTENDED,
		"你的舌头变成一根口器，你开始渴望蜂蜜。" = MUT_MSG_EXTENDED,
		"一对触角从你头上长了出来。 " = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/jelly
	mutationtexts = list(
		"你的嘴里黏糊糊的" = MUT_MSG_IMMEDIATE,
		"你的皮肤变得湿滑，并开始带上透明的质感" = MUT_MSG_IMMEDIATE,
		"你的四肢开始化为黏液，手指融在了一起。" = MUT_MSG_EXTENDED,
		"你的双腿瘫软，你整个人化成一滩自己" = MUT_MSG_EXTENDED,
		"你的器官聚合成一颗史莱姆核心。你重新塑形成更接近人形的样子。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/lizard
	mutationtexts = list(
		"你觉得冷。" = MUT_MSG_IMMEDIATE,
		"你的皮肤很干燥。" = MUT_MSG_IMMEDIATE,
		"你的皮肤开始长出鳞片。" = MUT_MSG_EXTENDED,
		"你弹了弹舌头。" = MUT_MSG_EXTENDED,
		"你想舔舔自己的眼球。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/monkey
	name = "猴子突变毒素"
	description = "一种猴子化毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/monkey
	taste_description = "香蕉"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你开始用嘴呼吸。" = MUT_MSG_IMMEDIATE,
		"你很想吃香蕉。" = MUT_MSG_IMMEDIATE,
		"你的背好痛。" = MUT_MSG_EXTENDED,
		"你的思绪一片混沌。" = MUT_MSG_EXTENDED,
		"你想胡闹一番。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/moth
	mutationtexts = list(
		"你的眼睛突然对光非常敏感。" = MUT_MSG_IMMEDIATE,
		"你的皮肤刺痒。" = MUT_MSG_IMMEDIATE,
		"你长出了一身蓬松的蛾绒。" = MUT_MSG_EXTENDED,
		"一对触角从你头上长了出来。" = MUT_MSG_EXTENDED,
		"一对蛾翅从你背上长了出来。" = MUT_MSG_EXTENDED,
		"你想去抱一盏灯。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/plasma
	mutationtexts = list(
		"你的胃里传来一阵剧痛" = MUT_MSG_IMMEDIATE,
		"你的皮肤上长出紫色的脓疱" = MUT_MSG_IMMEDIATE,
		"随着血肉融化，你皮肤上的脓疱爆裂开来，被紫色黏液取代" = MUT_MSG_EXTENDED,
		"你能看见自己的骨架。" = MUT_MSG_EXTENDED,
		"你开始迅速升温。你需要的是等离子体，不是空气！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/pod
	mutationtexts = list(
		"你的皮肤开始泛出绿色。" = MUT_MSG_IMMEDIATE,
		"你的嘴很干。" = MUT_MSG_IMMEDIATE,
		"普通食物似乎不再像以前那样能维持你的生命了。" = MUT_MSG_EXTENDED,
		"在黑暗中你觉得非常虚弱。" = MUT_MSG_EXTENDED,
		"你想去阳光下晒一晒。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/shadekin
	name = "影裔突变毒素"
	description = "一种影裔毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadekin
	taste_description = "某种黑暗而毛茸茸的东西"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你在黑暗中感到自在。" = MUT_MSG_IMMEDIATE,
		"你注意到身上覆了一层细毛。" = MUT_MSG_IMMEDIATE,
		"你的毛越来越浓密了。" = MUT_MSG_EXTENDED,
		"你的耳朵垂到了头上。" = MUT_MSG_EXTENDED,
		"你脑中响起一片嘈杂的声音。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/shadow
	name = "暗影人突变毒素"
	description = "一种暗影毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/shadow
	taste_description = "夜晚"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你在黑暗中感到自在。" = MUT_MSG_IMMEDIATE,
		"你的眼睛对阴影的适应变快了。" = MUT_MSG_IMMEDIATE,
		"光线让你偏头痛发作" = MUT_MSG_EXTENDED,
		"你的皮肤变黑，并变得透明。" = MUT_MSG_EXTENDED,
		"光线在灼烧你！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/skeleton
	mutationtexts = list(
		"你正在变瘦" = MUT_MSG_IMMEDIATE,
		"你渴望牛奶。" = MUT_MSG_IMMEDIATE,
		"你瘦得只剩皮包骨。" = MUT_MSG_EXTENDED,
		"你的眼窝深深陷了进去。" = MUT_MSG_EXTENDED,
		"你身上剩下的血肉从骨头上脱落。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/skrell
	name = "斯克雷尔突变毒素"
	description = "一种斯克雷尔毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/skrell
	taste_description = "咸鱿鱼"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的皮肤像橡胶一样" = MUT_MSG_IMMEDIATE,
		"你的头发结成一块块。" = MUT_MSG_IMMEDIATE,
		"你的皮肤覆上了一层黏液。" = MUT_MSG_EXTENDED,
		"你的头发聚合成粗大的头部触须。" = MUT_MSG_EXTENDED,
		"在水边你感觉最自在。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/transformative_virus/synthetic
	name = "合成人纳米机器"
	description = "我们可以重建他们。"
	color = "#535E66"  //RGB: 94, 255, 59
	taste_description = "金属"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	transformation_disease = /datum/disease/transformation_race/synthetic

/datum/reagent/mutationtoxin/tajaran
	name = "塔亚拉突变毒素"
	description = "一种塔亚拉毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/tajaran
	taste_description = "弓形虫病"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你感到皮肤上有阵阵针刺感。" = MUT_MSG_IMMEDIATE,
		"你注意到身上覆了一层细毛。" = MUT_MSG_IMMEDIATE,
		"你的毛越来越浓密了。" = MUT_MSG_EXTENDED,
		"你的鼻子湿了。" = MUT_MSG_EXTENDED,
		"你觉得自己毛茸茸的。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/teshari
	name = "特沙利突变毒素"
	description = "一种特沙利毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/teshari
	taste_description = "炸鸡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你感到皮肤上有阵阵针刺感。" = MUT_MSG_IMMEDIATE,
		"你的皮肤油乎乎的。" = MUT_MSG_IMMEDIATE,
		"你开始长出羽毛。" = MUT_MSG_EXTENDED,
		"你觉得异常兴奋。" = MUT_MSG_EXTENDED,
		"你觉得自己像只小捣蛋鬼，总想去干点坏事。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vox
	name = "沃克斯突变毒素"
	description = "一种沃克斯毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox
	taste_description = "带着金属味的尖啸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的喉咙发痒。" = MUT_MSG_IMMEDIATE,
		"你的肺在燃烧！" = MUT_MSG_IMMEDIATE,
		"刺羽从你的皮肤里钻了出来。" = MUT_MSG_EXTENDED,
		"你的脸上长出了一张喙。" = MUT_MSG_EXTENDED,
		"你得赶紧找到氮气！嘶克嘞！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vox_primalis
	name = "原初沃克斯突变毒素"
	description = "一种原初沃克斯毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vox_primalis
	taste_description = "带着金属味的尖啸"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的喉咙发痒。" = MUT_MSG_IMMEDIATE,
		"你的肺在燃烧！" = MUT_MSG_IMMEDIATE,
		"刺羽从你的皮肤里钻了出来。" = MUT_MSG_EXTENDED,
		"你的脸上长出一张喙，并裂成三瓣。" = MUT_MSG_EXTENDED,
		"你得赶紧找到氮气！嘶克嘞！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/vulpkanin
	name = "狐狸突变毒素"
	description = "一种狐狸毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/vulpkanin
	taste_description = "橙皮鸡"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你感到皮肤上有阵阵针刺感。" = MUT_MSG_IMMEDIATE,
		"你注意到身上覆了一层细毛。" = MUT_MSG_IMMEDIATE,
		"你的毛越来越浓密了。" = MUT_MSG_EXTENDED,
		"你的鼻子湿了。" = MUT_MSG_EXTENDED,
		"你觉得自己毛茸茸的。" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/xenohybrid
	name = "异形杂交体突变毒素"
	description = "一种异形杂交体毒素。"
	color = "#5EFF3B" //RGB: 94, 255, 59
	race = /datum/species/xeno
	taste_description = "酸苹果"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED|REAGENT_NO_RANDOM_RECIPE
	mutationtexts = list(
		"你的喉咙发痒。" = MUT_MSG_IMMEDIATE,
		"你能感觉到有什么东西……在里面动。" = MUT_MSG_IMMEDIATE,
		"你的皮肤绷得很紧。" = MUT_MSG_EXTENDED,
		"你的血液沸腾了！" = MUT_MSG_EXTENDED,
		"你的皮肤感觉像是要炸开一样！" = MUT_MSG_ABOUT2TURN)

/datum/reagent/mutationtoxin/zombie
	mutationtexts = list(
		"你闻到一股恶臭。那是你自己。" = MUT_MSG_IMMEDIATE,
		"你的皮肤上浮现黑绿色的斑点。" = MUT_MSG_IMMEDIATE,
		"你的血肉在腐烂，你却毫无感觉！" = MUT_MSG_EXTENDED,
		"你的血液凝固了！" = MUT_MSG_EXTENDED,
		"你渴望血肉与脑髓" = MUT_MSG_ABOUT2TURN)

//New chemical which only causes people to perform the 'weh' emote. No way to create this, currently will only be in rare foam grenades found as loot
/datum/reagent/juice_that_makes_you_weh
	name = "让你呜呜叫的果汁"
	description = "一种奇特的绿色化学物质，会让活物不由自主地“呜呜”叫上一阵"
	color = "#37e427" // rgb: 165, 240, 238
	taste_description = "带着一丝辛辣的奇特甜味"
	metabolization_rate = 2 // metabolises 10x faster, will occur more often but not hang around for ages
	penetrates_skin = VAPOR
	ph = 5.5

//This code allows it to randomly proc regularly, causing a random pitch 'weh' sound
/datum/reagent/juice_that_makes_you_weh/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	if (prob(50))
		to_chat(affected_mob, span_warning("你有一种想呜呜叫的冲动……"))
		addtimer(CALLBACK(src, PROC_REF(do_weh), affected_mob), rand(1, 4) SECONDS)

/datum/reagent/juice_that_makes_you_weh/proc/do_weh(mob/living/carbon/M)
	if (QDELETED(M))
		return
	M.emote("weh")

//A chemical you can spray on plushies to turn them into a 'shell'
//Hugging the plushie turns yourself into the plushie!
/datum/reagent/plushmium
	name = "毛绒素"
	description = "一种奇特的化学物质，看上去几乎毛茸茸的——要不是它是液体的话。已知会对毛绒玩偶产生奇怪的效果。"
	color = "#fbcbd7"
	taste_description = "毛绒玩偶柔软的触感"
	ph = 5

/datum/reagent/plushmium/expose_obj(obj/exposed_obj, reac_volume, methods, show_message)
	. = ..()
	if(istype(exposed_obj, /obj/item/toy/plush) && reac_volume >= 5)
		exposed_obj.loc.visible_message(span_warning("这只毛绒玩偶似乎也在盯着你看。"))
		var/obj/item/toy/plushie_shell/new_shell = new /obj/item/toy/plushie_shell(exposed_obj.loc)
		new_shell.name = exposed_obj.name
		new_shell.icon = exposed_obj.icon
		new_shell.icon_state = exposed_obj.icon_state
		new_shell.stored_plush = exposed_obj
		exposed_obj.forceMove(new_shell)

//Extra interaction for which spraying it on an existing sentient plushie aheals them, so they can be revived!
/datum/reagent/plushmium/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(istype(exposed_mob, /mob/living/basic/pet/plush) && reac_volume >= 1)
		exposed_mob.revive(ADMIN_HEAL_ALL)

#undef MUT_MSG_IMMEDIATE
#undef MUT_MSG_EXTENDED
#undef MUT_MSG_ABOUT2TURN

#undef CYCLES_TO_TURN
#undef CYCLES_MSG_IMMEDIATE
#undef CYCLES_MSG_EXTENDED
