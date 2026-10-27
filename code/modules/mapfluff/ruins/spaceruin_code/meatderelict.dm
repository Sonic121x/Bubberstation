/obj/item/keycard/meatderelict/director
	name = "主管钥匙卡"
	desc = "一张花哨的钥匙卡。大概能打开主管办公室。名牌上的字全糊了。"
	color = "#990000"
	puzzle_id = "md_director"

/obj/item/keycard/meatderelict/engpost
	name = "岗位钥匙卡"
	desc = "一张花哨的钥匙卡。上面印着工程部徽记。"
	color = "#f0da12"
	puzzle_id = "md_engpost"

/obj/item/keycard/meatderelict/armory
	name = "军械库钥匙卡"
	desc = "一张红色钥匙卡。上面印着一把特别酷的枪。真花哨。"
	color = "#FF7276"
	puzzle_id = "md_armory"

/obj/item/paper/crumpled/bloody/fluff/meatderelict/directoroffice
	name = "主管的便条"
	default_raw_text = "<i>研究本来进展顺利……但实验没有按计划进行。他抽搐着、尖叫着，慢慢变异成了……那个东西。它开始向四处蔓延，连实验室外也有了。我们根本没法再掩饰这里不是什么传送研究前哨站，所以我封锁了实验室，但他们已经知道了。他们派了一支小队来救我们，可是……</i>"

/obj/item/paper/crumpled/fluff/meatderelict/shieldgens
	name = "护盾门营销草图"
	default_raw_text = "The <b>QR-109 护盾门</b>是一种坚固的硬光装置，能产生强力护盾以阻止进入。通过与控制面板整合，它可以从任何地方启用或停用，比如飞船的舰桥、<b>工程舱</b>，或者其他任何地方！<i>其余部分已经褪色……</i>"

/obj/item/paper/crumpled/fluff/meatderelict
	name = "工程师便条"
	default_raw_text = "我把发电机超频了，好给实验补上所需的电力，不过它们有点不稳定。"

/obj/item/paper/crumpled/fluff/meatderelict/fridge
	name = "工程师的抱怨"
	default_raw_text = "不管是谁一直从我冰箱里偷我那该死的冰淇淋，我发誓我一定会把你揍得不成人形。把这么好吃的冰淇淋弄到这儿来可不便宜，对你来说也一样。<b>还有，别碰我抽屉里的零食！</b>"

/obj/machinery/computer/terminal/meatderelict
	upperinfo = "纳米软件-TM 版权所有 2500——禁止再分发——现已支持音频！" //not that old
	content = list(
		"实验测试卫星 37B<br/>纳米传讯™️ 认可的深空实验实验室<br/><br/>记录 1：<br/><br/>对象——\[物种 501-C-12\]<br/>日期——\[已隐去\]<br/>我们从遥远边疆的一处纳米传讯前哨站获得了一份来源不明的生物样本 \[物种 501-C-12\]。初步实验已确定该样本是一种从未被记录过的生物。它重约 7 克，似乎很温顺。初步检查表明，它是一种复制速度极快的生物，能改变自身生理结构，呈现出多种不同形态。\[记录终止\]<br/>——菲尔·科尼利厄斯博士",
		"记录 2：<br/><br/>对象——\[物种 501-C-12\]<br/>日期——\[已隐去\]<br/>该生物会对电刺激做出反应。它对光、热、冷、氧气、等离子、二氧化碳、氮气均无反应。片刻之间，它那原本无定形的躯体似乎生成了肌肉组织，并远离了电源。喂养该生物很简单，它几乎能吃掉任何形式的蛋白质。它似乎能迅速消化蛋白质并将其转化为更多的自身。任何无法消化的产物则被原样留下。将继续监测该生物，并向纳米传讯中央指挥部提交报告。\[记录终止\]<br/>——菲尔·科尼利厄斯博士",
		"记录 3：<br/><br/>对象——\[物种 501-C-12\]<br/>日期——\[已隐去\]<br/>一切联系纳米传讯的尝试都失败了。我从没见过这样的东西。我……我觉得我撑不了多久了，我能听见它在推我的房门。如果有人读到这个，请告诉我的家人，我——\[巨响\]<br/>滚开 \[枪声\]<br/>啊啊啊啊啊啊啊啊啊 \[记录终止\]<br/>——菲尔·科尼利厄斯博士"
	)

/obj/machinery/door/puzzle/meatderelict
	name = "封锁门"
	desc = "一扇满是击打痕迹的门，依然坚固。常规破坏手段对它无效，附近一定有办法打开它。"
	icon = 'icons/obj/doors/puzzledoor/danger.dmi'
	puzzle_id = "md_prevault"

/mob/living/basic/meteor_heart/opens_puzzle_door
	///the puzzle id we send on death
	var/id
	///queue size, must match
	var/queue_size = 2

/mob/living/basic/meteor_heart/opens_puzzle_door/Initialize(mapload)
	. = ..()
	new /obj/effect/puzzle_death_signal_holder(loc, src, id, queue_size)

/obj/effect/puzzle_death_signal_holder // ok apparently registering signals on qdeling stuff is not very functional
	///delay
	var/delay = 2.5 SECONDS
	invisibility = INVISIBILITY_ABSTRACT

/obj/effect/puzzle_death_signal_holder/Initialize(mapload, mob/listened, id, queue_size = 2)
	. = ..()
	if(isnull(id))
		return INITIALIZE_HINT_QDEL
	RegisterSignal(listened, COMSIG_LIVING_DEATH, PROC_REF(on_death))
	SSqueuelinks.add_to_queue(src, id, queue_size)

/obj/effect/puzzle_death_signal_holder/proc/on_death(datum/source)
	SIGNAL_HANDLER
	addtimer(CALLBACK(src, PROC_REF(send_sig)), delay)

/obj/effect/puzzle_death_signal_holder/proc/send_sig()
	SEND_SIGNAL(src, COMSIG_PUZZLE_COMPLETED)
	qdel(src)

/obj/machinery/puzzle/button/meatderelict
	name = "封锁控制面板"
	desc = "控制此前哨站封锁状态的面板。"
	id = "md_prevault"

/obj/machinery/puzzle/button/meatderelict/on_puzzle_complete()
	. = ..()
	playsound(src, 'sound/effects/alert.ogg', 100, TRUE)
	visible_message(span_warning("[src] 发出警报声，封锁解除了！"))

/obj/structure/puzzle_blockade/meat
	name = "血肉与牙齿之团"
	desc = "一团令人作呕的血肉与牙齿。它看得见你吗？但愿没有。几乎坚不可摧，一定有路可以绕过去。"
	icon = 'icons/obj/structures.dmi'
	icon_state = "meatblockade"
	opacity = TRUE

/obj/structure/puzzle_blockade/meat/try_signal(datum/source)
	Shake(duration = 0.5 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(open_up)), 0.5 SECONDS)

/obj/structure/puzzle_blockade/meat/proc/open_up()
	new /obj/effect/gibspawner/generic(drop_location())
	qdel(src)

/obj/lightning_thrower
	name = "过载的 SMES"
	desc = "一台超频的 SMES，能量满溢。"
	anchored = TRUE
	density = TRUE
	icon = 'icons/obj/machines/engine/other.dmi'
	icon_state = "smes"
	/// do we currently want to shock diagonal tiles? if not, we shock cardinals
	var/throw_diagonals = FALSE
	/// flags we apply to the shock
	var/shock_flags = SHOCK_KNOCKDOWN | SHOCK_NOGLOVES
	/// damage of the shock
	var/shock_damage = 20
	/// list of turfs that are currently shocked so we can unregister the signal
	var/list/signal_turfs = list()
	/// how long do we shock
	var/shock_duration = 0.5 SECONDS

/obj/lightning_thrower/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSprocessing, src)

/obj/lightning_thrower/Destroy()
	. = ..()
	clear_signals()
	signal_turfs = null
	STOP_PROCESSING(SSprocessing, src)

/obj/lightning_thrower/process(seconds_per_tick)
	var/list/dirs = throw_diagonals ? GLOB.diagonals : GLOB.cardinals
	throw_diagonals = !throw_diagonals
	playsound(src, 'sound/effects/magic/lightningbolt.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, ignore_walls = FALSE)
	if(length(signal_turfs))
		clear_signals()
	for(var/direction in dirs)
		var/victim_turf = get_step(src, direction)
		if(isclosedturf(victim_turf))
			continue
		Beam(victim_turf, icon_state="lightning[rand(1,12)]", time = shock_duration)
		RegisterSignal(victim_turf, COMSIG_ATOM_ENTERED, PROC_REF(shock_victim)) //we cant move anyway
		signal_turfs += victim_turf
		for(var/mob/living/victim in victim_turf)
			shock_victim(null, victim)
	addtimer(CALLBACK(src, PROC_REF(clear_signals)), shock_duration)

/obj/lightning_thrower/proc/clear_signals()
	for(var/turf in signal_turfs)
		UnregisterSignal(turf, COMSIG_ATOM_ENTERED)
		signal_turfs -= turf

/obj/lightning_thrower/proc/shock_victim(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(!istype(victim))
		return
	victim.electrocute_act(shock_damage, src, flags = shock_flags)
