/datum/uplink_category/role_restricted
	name = "职业限定"
	weight = 1

/datum/uplink_item/role_restricted
	category = /datum/uplink_category/role_restricted
	purchasable_from = ~UPLINK_ALL_SYNDIE_OPS

/datum/uplink_item/role_restricted/haunted_magic_eightball
	name = "闹鬼魔法八号球"
	desc = "大多数魔法八号球都只是里面装着骰子的玩具。虽然外观与无害的玩具一模一样，这件神秘装置却能探入灵界寻求答案。 \
			提醒一句，鬼魂往往反复无常，或者纯粹就是些小混蛋。使用方法很简单：大声说出你的问题，然后开始摇晃。"
	item = /obj/item/toy/eightball/haunted
	cost = 2
	restricted_roles = list(JOB_CURATOR)
	limited_stock = 1 //please don't spam deadchat
	surplus = 1

/datum/uplink_item/role_restricted/mail_counterfeit_kit
	name = "GLA 品牌邮件伪造套件"
	desc = "一个装有五台能伪造 NT 邮件的装置的盒子。也可以用来在里面存放物品，方便走私违禁品。 \
			此外，你还可以选择把里面的物品“武装”，这样邮件被打开的瞬间物品就会像被人拿在手里使用一样启动。 \
			这项功能最常用于手榴弹，因为它会强制手榴弹进入引爆序列。如果设成瞬间引爆，还能额外加分。 \
			附赠一台用于配置的集成微型计算机。"
	item = /obj/item/storage/box/syndie_kit/mail_counterfeit
	cost = 2
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_QUARTERMASTER)
	surplus = 5

/datum/uplink_item/role_restricted/bureaucratic_error
	name = "有机资本扰动病毒"
	desc = "随机化呈现给新入职者的职位。可能导致安保人员和/或小丑过多或过少。一次性使用。"
	item = ABSTRACT_UPLINK_ITEM
	surplus = 0
	limited_stock = 1
	cost = 2
	restricted = TRUE
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_QUARTERMASTER)

/datum/uplink_item/role_restricted/bureaucratic_error/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	force_event(/datum/round_event_control/bureaucratic_error, "一种辛迪加病毒")
	return source

/datum/uplink_item/role_restricted/clumsinessinjector //clown ops can buy this too, but it's in the pointless badassery section for them
	name = "笨拙注射器"
	desc = "给自己注射后，你会变得和小丑一样笨拙……或者给别人注射，让那个人变得和小丑一样笨拙。对于想重拾昔日小丑本性的小丑，或者想在杀死猎物前戏弄一番的小丑都很有用。"
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/banana_slippers
	name = "香蕉拖鞋"
	desc = "献给想把偷鞋事业提升到新高度的罪犯。直接扔向目标的腿，保证滑倒，否则退还你的 TC！警告：取下它需要朋友帮忙。"
	item = /obj/item/clothing/shoes/banana_slippers
	cost = 4
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND

/datum/uplink_item/role_restricted/ancient_jumpsuit
	name = "古老连体服"
	desc = "一件破旧不堪的连体服，对你绝对没有任何好处。"
	item = /obj/item/clothing/under/color/grey/ancient
	cost = 20
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/oldtoolboxclean
	name = "古老工具箱"
	desc = "一款极具标志性的工具箱设计，在助理中臭名昭著。这种设计经过专门打造，里面装的传送水晶越多它就越结实！附赠工具和绝缘手套。"
	item = /obj/item/storage/toolbox/mechanical/old/clean
	cost = 2
	restricted_roles = list(JOB_ASSISTANT)
	surplus = 0

/datum/uplink_item/role_restricted/clownpin
	name = "超级搞笑击针"
	desc = "一种击针，装入枪械后，该枪械将只能由小丑和笨拙的人使用，而且任何人试图开火时枪都会发出洪克声。"
	cost = 4
	item = /obj/item/firing_pin/clown/ultra
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/clownsuperpin
	name = "超级无敌搞笑击针"
	desc = "和超级搞笑击针一样，只不过当不是笨拙者或小丑的人试图开火时，装入此击针的枪械会直接爆炸。"
	cost = 7
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	restricted_roles = list(JOB_CLOWN)
	uplink_item_flags = SYNDIE_TRIPS_CONTRABAND
	surplus = 25

/datum/uplink_item/role_restricted/syndimmi
	name = "辛迪加品牌人机接口"
	desc = "一种经过改装的人机接口，能为半机械人设定听命于辛迪加的法则，同时不会因密码序列器而损坏其接口。这不会解锁它们隐藏的模块。"
	item = /obj/item/brain_processor/organic/syndie
	cost = 2
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_CORONER, JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER)
	surplus = 0

/datum/uplink_item/role_restricted/explosive_hot_potato
	name = "爆炸烫手山芋"
	desc = "一个装有炸药的土豆。激活后，特殊机构会启动，使它无法被丢弃。 \
			如果你正拿着它，唯一的摆脱方法就是用它攻击别人，让它转而黏在那个人身上。"
	item = /obj/item/hot_potato/syndicate
	cost = 4
	restricted_roles = list(JOB_COOK, JOB_BOTANIST, JOB_CLOWN, JOB_MIME)

/datum/uplink_item/role_restricted/combat_baking
	name = "战斗烘焙套件"
	desc = "一套隐秘的烘焙武器。内含一根法棍，熟练的默剧演员可以把它当作剑来用， \
		一对投掷牛角包，以及随时再做更多的配方。完事之后，把证据吃掉。"
	item = /obj/item/storage/box/syndie_kit/combat_baking
	cost = 7
	restricted_roles = list(JOB_COOK, JOB_MIME)

/datum/uplink_item/role_restricted/ez_clean_bundle
	name = "EZ 清洁手榴弹组合"
	desc = "一盒三枚采用华夫公司专利配方的清洁手榴弹。可以当作清洁剂使用，并对附近站立的人造成酸蚀伤害。 \
			酸液只影响碳基生物。"
	item = /obj/item/storage/box/syndie_kit/ez_clean
	cost = 6
	surplus = 20
	restricted_roles = list(JOB_JANITOR)

/datum/uplink_item/role_restricted/reverse_bear_trap
	name = "反向捕熊夹"
	desc = "一种巧妙至极的处刑装置，戴在（或被强行按在）头上。开启后，捕熊夹上安装的厨房计时器开始一分钟倒计时。时间一到，夹爪会 \
	猛烈张开，把佩戴者的下巴撕成两半，当场致死。使用方法：趁目标没戴头部装备时用它攻击对方，持续三秒不被打断 \
	就能把它强行扣到对方头上。"
	cost = 5
	item = /obj/item/reverse_bear_trap
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/modified_syringe_gun
	name = "改装注射枪"
	desc = "一把注射枪，可发射 DNA 注射器而非普通注射器。"
	item = /obj/item/gun/syringe/dna
	cost = 14
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/meathook
	name = "屠夫肉钩"
	desc = "一把固定在长链条上的残暴砍刀，可以把你想要的人拉到身边。"
	item = /obj/item/gun/magic/hook
	cost = 11
	restricted_roles = list(JOB_COOK)

/datum/uplink_item/role_restricted/moltobeso
	name = "Molt'Obeso 酱汁瓶"
	desc = "一瓶 Molt'Obeso 品牌的酱汁。这种酱汁能刺激人的食欲，让他们吃得比原本打算的更多。 \
			它还能增强人体对食物中热量的吸收。"
	item = /obj/item/storage/box/syndie_kit/moltobeso
	cost = 2
	restricted_roles = list(JOB_COOK)

/datum/uplink_item/role_restricted/turretbox
	name = "一次性哨戒炮"
	desc = "一套一次性哨戒炮部署系统，巧妙地伪装成工具箱，用扳手敲一下即可启用。"
	item = /obj/item/storage/toolbox/emergency/turret
	cost = 11
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)

/datum/uplink_item/role_restricted/rebarxbowsyndie
	name = "辛迪加钢筋弩"
	desc = "工程师那款土制钢筋弩的专业得多版本。6 发弹匣、装填更快、弹药更好。附使用手册。"
	item = /obj/item/storage/box/syndie_kit/rebarxbowsyndie
	cost = 12
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN)

/datum/uplink_item/role_restricted/magillitis_serum
	name = "马吉利炎血清自动注射器"
	desc = "一支一次性自动注射器，内含实验性血清，能让类人猿科生物快速肌肉增长。 \
			副作用可能包括多毛症、暴力爆发，以及对香蕉永无止境的痴迷。 \
			现在还含有再生化学物质，让使用者在锻炼新长出的肌肉时保持健康。"
	item = /obj/item/reagent_containers/hypospray/medipen/magillitis
	cost = 15
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/gorillacube
	name = "大猩猩方块"
	desc = "一块华夫公司品牌的大猩猩方块。吃得多才能长得壮。 \
			注意：本产品接触水后可能会重新水化。"
	item = /obj/item/food/monkeycube/gorilla
	cost = 6
	restricted_roles = list(JOB_GENETICIST, JOB_RESEARCH_DIRECTOR)

/datum/uplink_item/role_restricted/brainwash_disk
	name = "洗脑手术程序"
	desc = "一张磁盘，内含执行洗脑手术的流程，可让你向目标植入一个目标。 \
	插入手术控制台即可启用该流程。"
	item = /obj/item/disk/surgery/brainwashing
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_CORONER, JOB_ROBOTICIST)
	cost = 5
	surplus = 50

/datum/uplink_item/role_restricted/advanced_plastic_surgery
	name = "高级整形手术程序"
	desc = "一件收藏品的盗版拷贝，这张磁盘内含执行高级整形手术的流程，可让你根据副手持有的相机拍下的照片，塑造某人的面容和声音。 \
	所有改变都仅停留在表面，不会改变其基因构成。 \
	插入手术控制台即可启用该流程。"
	item = /obj/item/disk/surgery/advanced_plastic_surgery
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_ROBOTICIST)
	cost = 1
	surplus = 50

/datum/uplink_item/role_restricted/springlock_module
	name = "大幅改装的弹簧锁 MOD 外骨骼模块"
	desc = "一种覆盖 MOD 单元整体尺寸的模块，安装在外壳之下。 \
		这副机械外骨骼会在使用者进入时向一旁推开，并协助启动装具， \
		但现代套装已将其弃用，因为弹簧锁在潮湿环境中容易“啪”地弹回原位。 \
		你知道让整副外骨骼进入身体是什么感觉吗？ \
		此版本的模块经过改装，可实现 MOD 外骨骼的近乎瞬间激活。 \
		适合快速穿上或脱下外骨骼，或者通过一场悲惨的事故处理掉某个目标。"
	item = /obj/item/mod/module/springlock/bite_of_87
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	cost = 2
	surplus = 15

/datum/uplink_item/role_restricted/reverse_revolver
	name = "反向左轮手枪"
	desc = "一把总是朝使用者开火的左轮手枪。“不小心”把你的武器掉在地上，然后看着那些贪婪的企业肥猪把自己的脑袋打得溅满墙壁。 \
	这把左轮手枪本身倒是真的。只有笨拙的人和小丑才能正常开火。附赠一个拥抱盒。洪克。"
	cost = 14
	item = /obj/item/storage/box/hug/reverse_revolver
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/pressure_mod
	name = "动能加速器压力改装件"
	desc = "一款改装套件，可让动能加速器在室内造成大幅提升的伤害。 \
			占用 35% 改装容量。"
	item = /obj/item/borg/upgrade/modkit/indoors
	cost = 5 //you need two for full damage, so total of 10 for maximum damage
	limited_stock = 2 //you can't use more than two!
	restricted_roles = list("Shaft Miner")
	surplus = 20

/datum/uplink_item/role_restricted/mimery
	name = "高级默剧教程系列"
	desc = "经典的默剧技巧进阶两部曲。学习这套教程后，使用者应该能制造 3x1 的隐形墙，并从手指射出子弹。 \
			显然只对默剧演员有效。"
	cost = 12
	item = /obj/item/storage/box/syndie_kit/mimery
	restricted_roles = list(JOB_MIME)
	surplus = 10

/datum/uplink_item/role_restricted/laser_arm
	name = "激光臂植入体"
	desc = "一种植入体，能在你的手臂内提供一把可充能的激光枪。易受 EMP 影响。附一台辛迪加自动手术器，可立即自行安装。"
	cost = 10
	item = /obj/item/autosurgeon/syndicate/laser_arm
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	surplus = 20

/datum/uplink_item/role_restricted/chemical_gun
	name = "试剂飞镖枪"
	desc = "一把经过大幅改装的注射枪，能用输入的试剂自行合成化学飞镖。可容纳 90u 试剂。"
	item = /obj/item/gun/chem
	cost = 12
	restricted_roles = list(JOB_CHEMIST, JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_BOTANIST)

/datum/uplink_item/role_restricted/pie_cannon
	name = "香蕉奶油馅饼炮"
	desc = "为特别的小丑准备的特别馅饼炮。这台装置最多可装 20 个馅饼，并且每两秒自动制造一个！"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	restricted_roles = list(JOB_CLOWN)

/datum/uplink_item/role_restricted/clown_bomb
	name = "小丑炸弹"
	desc = "小丑炸弹是一种滑稽的装置，能制造大规模的恶作剧。它配有可调节的计时器， \
		最短为 %MIN_BOMB_TIMER 秒，并且可以用扳手固定在地面上以防止 \
		移动。炸弹体积笨重，无法搬动；订购此物品时，会有一个较小的信标 \
		被传送到你身边，激活后会把真正的炸弹传送到信标处。请注意，这枚炸弹 \
		可以被拆除，有些船员可能会尝试这么做。"
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	restricted_roles = list(JOB_CLOWN)
	surplus = 10

/datum/uplink_item/role_restricted/clown_bomb/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/role_restricted/clowncar
	name = "小丑车"
	desc = "对于任何合格的小丑来说，小丑车都是终极交通工具！ \
			只需插入你的自行车喇叭然后上车，准备好体验一生中最搞笑的旅程！ \
			你可以撞上遇到的任何太空人，把他们塞进车里绑架囚禁起来，直到 \
			有人来救他们，或者他们自己爬出来。注意不要撞上墙壁或自动售货机，因为弹簧座椅 \
			非常敏感。现在还配备了润滑油防御机制，能保护你免受任何愤怒狗屎安保的侵害！ \
			高级功能可用密码序列器解锁！"
	item = /obj/vehicle/sealed/car/clowncar
	cost = 20
	restricted_roles = list(JOB_CLOWN)
	surplus = 10

/datum/uplink_item/role_restricted/clowncar/spawn_item_for_generic_use(mob/user)
	var/obj/vehicle/sealed/car/clowncar/car = ..()
	car.enforce_clown_role = FALSE
	var/obj/item/key = new car.key_type(user.loc)
	car.visible_message(span_notice("[key] 从 [car] 里掉到地上。"))
	return car

/datum/uplink_item/role_restricted/his_grace
	name = "圣恩"
	desc = "一件极其危险的武器，是从一个被灰色浪潮吞没的空间站上回收的。一旦激活，祂就会渴求鲜血，必须用杀戮来满足这份渴求。 \
	圣恩会赋予持有者缓慢再生和完全免疫眩晕的能力，但要小心：如果祂太饿，就会变得无法丢弃，并且若得不到喂养，最终会杀死你。 \
	不过，如果放着不管足够久，祂就会重新陷入沉睡。 \
	要激活圣恩，只需解开祂的扣锁。"
	lock_other_purchases = TRUE
	cant_discount = TRUE
	item = /obj/item/his_grace
	cost = 500 // BUBBER EDIT
	surplus = 0
	restricted_roles = list(JOB_CHAPLAIN)
	purchasable_from = ~UPLINK_SPY

/datum/uplink_item/role_restricted/concealed_weapon_bay
	name = "隐藏武器舱"
	desc = "一种用于非战斗型外骨骼的改装，可让它们装备一件为战斗单位设计的装备。 \
			将其安装到已装载装备的外骨骼上，可让武器舱伪装成那件装备。被牺牲的装备将会丢失。\
			或者，你也可以把武器舱装到空的装备槽上，但这样武器舱就不会被隐藏。一旦武器舱 \
			安装完毕，就可以在里面装入一件外骨骼武器。"
	item = /obj/item/mecha_parts/mecha_equipment/concealed_weapon_bay
	cost = 3
	restricted_roles = list(JOB_ROBOTICIST, JOB_RESEARCH_DIRECTOR)
	surplus = 15

/* // SKYRAT EDIT REMOVAL START
/datum/uplink_item/role_restricted/spider_injector
	name = "Australicus Slime Mutator"
	desc = "Crikey mate, it's been a wild travel from the Australicus sector but we've managed to get \
			some special spider extract from the giant spiders down there. Use this injector on a gold slime core \
			to create a few of the same type of spiders we found on the planets over there. They're a bit tame until you \
			also give them a bit of sentience though."
	item = /obj/item/reagent_containers/syringe/spider_extract
	population_minimum = TRAITOR_POPULATION_LOWPOP
	cost = 10
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)
	surplus = 10

*/
// SKYRAT EDIT REMOVAL END
/* /datum/uplink_item/role_restricted/blastcannon - BUBBER REMOVE START
	name = "Blast Cannon"
	desc = "A highly specialized weapon, the Blast Cannon is actually relatively simple. It contains an attachment for a tank transfer valve mounted to an angled pipe specially constructed \
			withstand extreme pressure and temperatures, and has a mechanical trigger for triggering the transfer valve. Essentially, it turns the explosive force of a bomb into a narrow-angle \
			blast wave \"projectile\". Aspiring scientists may find this highly useful, as forcing the pressure shockwave into a narrow angle seems to be able to bypass whatever quirk of physics \
			disallows explosive ranges above a certain distance, allowing for the device to use the theoretical yield of a transfer valve bomb, instead of the factual yield. Its simple design makes it easy to conceal."
	item = /obj/item/gun/blastcannon
	cost = 14 //High cost because of the potential for extreme damage in the hands of a skilled scientist.
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST)
	surplus = 5
BUBBER REMOVE END*/
/datum/uplink_item/role_restricted/evil_seedling
	name = "邪恶幼苗"
	desc = "我们回收的一颗稀有种子，能长成危险的物种，并在你的任务中助你一臂之力！"
	item = /obj/item/seeds/seedling/evil
	cost = 8
	restricted_roles = list(JOB_BOTANIST)

/datum/uplink_item/role_restricted/bee_smoker
	name = "蜜蜂熏烟器"
	desc = "一种烧大麻运行的装置，能把大麻变成一种可催眠蜜蜂听从我们命令的气体。"
	item = /obj/item/bee_smoker
	cost = 4
	restricted_roles = list(JOB_BOTANIST)
	surplus = 0 //requires too much setup to be worth including in surplus crates

/datum/uplink_item/role_restricted/monkey_agent
	name = "猿猴特工增援"
	desc = "从我们辛迪加香蕉部呼叫一名训练有素的猴子秘密特工。 \
		它们受过操作机械的训练，也会识字，但不会说通用语。 \
		请注意，这些是散养猴子，不会与去突变药反应。可能含有对物种变化现象的严重过敏。"
	item = /obj/item/antag_spawner/loadout/monkey_man
	cost = 6
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_GENETICIST, JOB_ASSISTANT, JOB_MIME, JOB_CLOWN, JOB_PUN_PUN)
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/role_restricted/monkey_supplies
	name = "猿猴特工补给"
	desc = "有时候你需要比一只狂躁猴子更强的火力。比如一只狂躁的、武装起来的猴子！ \
		猴子可以打开这套工具，获得一个装着廉价枪械、弹药以及一些杂项补给的袋子。"
	item = /obj/item/storage/toolbox/guncase/monkeycase
	cost = 4
	limited_stock = 3
	restricted_roles = list(JOB_ASSISTANT, JOB_MIME, JOB_CLOWN, JOB_PUN_PUN)
	restricted = TRUE
	refundable = FALSE


/datum/uplink_item/role_restricted/reticence
	name = "“缄默”隐形刺杀外骨骼"
	desc = "一台安静、快速、近乎隐形，但极其脆弱的默剧外骨骼！ \
	配备一把近乎无声的手枪，以及一台满足你最佳刺杀需求的 RCD。不含工具，概不退款。"
	item = /obj/vehicle/sealed/mecha/reticence/loaded
	cost = 20
	restricted_roles = list(JOB_MIME)
	restricted = TRUE
	refundable = FALSE
	purchasable_from = parent_type::purchasable_from & ~UPLINK_SPY

/datum/uplink_item/role_restricted/concussivedisk
	name = "超震荡二极管磁盘"
	desc = "一张二极管配置磁盘，可让发射器射出强力的爆炸激光。 \
	请注意，这会使发射器的射速减半。"
	item = /obj/item/emitter_disk/blast
	cost = 5
	restricted_roles = list(JOB_STATION_ENGINEER, JOB_CHIEF_ENGINEER)

/datum/uplink_item/role_restricted/briefcase_gun
	name = "公文包内置枪械扳机"
	desc = "一个公文包，其提手内嵌有击发机构，并与包内收纳的第一件武器相连。 \
		“瞄准并开枪”公文包时，实际触发的是击发机构，让武器从隐蔽的小孔中射出子弹。 \
		适用于任何能装进包里的枪械。"
	item = /obj/item/storage/briefcase/gun
	purchasable_from = UPLINK_TRAITORS
	cant_discount = TRUE // remove this when we get uplink logic to have one discount apply to all items on the same stock key
	cost = 4
	surplus = 0
	uplink_item_flags = NONE
	stock_key = "briefcase_gun"
	restricted_roles = list(
		JOB_HEAD_OF_PERSONNEL,
		JOB_LAWYER,
		JOB_QUARTERMASTER,
	)

/datum/uplink_item/role_restricted/briefcase_gun/with_gun
	name = "公文包内置枪械扳机（组合优惠）"
	desc = parent_type::desc + " 这份组合优惠还附赠一把预装好的马卡洛夫手枪！（不过不含额外弹匣。）"
	item = /obj/item/storage/briefcase/gun/preloaded
	purchasable_from = parent_type::purchasable_from | UPLINK_SPY
	cost = 8
	surplus = 50
	population_minimum = /datum/uplink_item/dangerous/pistol::population_minimum
	relevant_child_items = /datum/uplink_item/dangerous/pistol::relevant_child_items
