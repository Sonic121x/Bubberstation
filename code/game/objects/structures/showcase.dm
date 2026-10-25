#define SHOWCASE_CONSTRUCTED 1
#define SHOWCASE_SCREWDRIVERED 2

/*Completely generic structures for use by mappers to create fake objects, i.e. display rooms*/
/obj/structure/showcase
	name = "展台"
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "showcase_1"
	desc = "一个展台，上面用螺栓固定着一具空荡荡的半机械人躯壳。"
	density = TRUE
	anchored = TRUE
	var/deconstruction_state = SHOWCASE_CONSTRUCTED

/obj/structure/showcase/fakeid
	name = "\improper 中央指挥部身份识别终端"
	desc = "你可以用它来修改 ID 卡。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fakeid/Initialize(mapload)
	. = ..()
	add_overlay("id")
	add_overlay("id_key")

/obj/structure/showcase/fakesec
	name = "\improper 中央指挥部安保档案"
	desc = "用于查看和编辑人员的安保档案。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer"

/obj/structure/showcase/fakesec/update_overlays()
	. = ..()
	. += "security"
	. += "security_key"

/obj/structure/showcase/horrific_experiment
	name = "恐怖实验"
	desc = "某种装满血液和内脏的舱体。你发誓你看到它在动……"
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_g" // Please don't delete it and not notice it for months this time.

/obj/structure/showcase/machinery/oldpod
	name = "受损的低温休眠舱"
	desc = "一个早已被时间遗忘的受损低温休眠舱，连同它从前的乘员……"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-open"

/obj/structure/showcase/machinery/oldpod/used
	name = "已打开的低温休眠舱"
	desc = "一个刚刚排出乘员的低温休眠舱。这个舱体似乎已经无法运作。"

/obj/structure/showcase/machinery/oldpod/used/psyker
	name = "已打开的灵能激发舱"
	desc = "一个刚刚排出乘员的灵能激发舱。这个舱体似乎已经无法运作。"
	icon_state = "psykerpod-open"

/obj/structure/showcase/cyborg/old
	name = "半机械人雕像"
	desc = "一具陈旧、已停机的半机械人。它曾经积极用于防范入侵者，如今只用冰冷如钢的目光震慑他们。"
	icon = 'icons/mob/silicon/robots.dmi'
	icon_state = "robot_old"
	density = FALSE

/obj/structure/showcase/mecha/marauder
	name = "战斗机甲展品"
	desc = "一个展台，上面用螺栓固定着一具空荡荡的旧式纳米传讯公司战斗机甲。据说它是用于捍卫公司利益与员工的顶级机体。"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "marauder"

/obj/structure/showcase/mecha/ripley
	name = "建造机甲展品"
	desc = "一个展台，上面用螺栓固定着一具退役的建造机甲。夹具额定压力为 9300 PSI。它看起来快要散架了。"
	icon = 'icons/mob/rideables/mecha.dmi'
	icon_state = "firefighter"

/obj/structure/showcase/machinery/implanter
	name = "\improper 纳米传讯自动心智护盾植入器展品"
	desc = "一台标准纳米传讯自动心智护盾植入机的简陋模型。配有稳固的定位束带和机器人手术注射器，脑损伤及其他严重医疗异常的发生率如今最多可降低 60%！"
	icon = 'icons/obj/machines/implant_chair.dmi'
	icon_state = "implantchair"

/obj/structure/showcase/machinery/microwave
	name = "\improper 纳米传讯牌微波炉"
	desc = "著名的纳米传讯牌微波炉，每个空间站都需要的多功能烹饪电器！这一台似乎只是画在纸板箱上的。"
	icon = 'icons/obj/machines/microwave.dmi'
	icon_state = "mw_complete"

/obj/structure/showcase/machinery/microwave_engineering
	name = "\improper 纳米传讯 Wave(tm) 微波炉"
	desc = "就在所有人都以为纳米传讯的著名微波炉已无可改进之时，这款 2563 年型号带来了 Wave™！作为纳米传讯的独家技术，Wave™ 能让你的 PDA 通过微波频率无线充电。毕竟没有什么比一边加热剩饭一边给 PDA 充电更能代表“未来”了。纳米传讯 Wave™——多任务处理，重新定义。"
	icon = 'icons/obj/machines/microwave.dmi'
	icon_state = "engi_mw_complete"

/obj/structure/showcase/machinery/cloning_pod
	name = "克隆舱展品"
	desc = "展示的是一项失败的可信赖克隆技术的原型。该技术在出现严重突变、耳部扭曲综合征以及自发长尾等报告后被废弃。底座上刻着日期 11.11.2558。"
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "pod_0"

/obj/structure/showcase/perfect_employee
	name = "“完美人”员工展品"
	desc = "一个展台，上面用螺栓固定着一名完美纳米传讯员工的模型。标牌上说明其经过严格的基因工程改造，并且绝对忠诚。"

/obj/structure/showcase/machinery/tv
	name = "\improper 纳米传讯企业新闻频道"
	desc = "一台略显破旧的电视。各种纳米传讯的电视购物广告循环播放，伴随轻快的旋律。"
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "television"

/obj/structure/showcase/machinery/signal_decrypter
	name = "子系统信号解密器"
	desc = "一台奇怪的机器，据说是用来接收并解密波信号的。"
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "processor"

/obj/structure/showcase/wizard
	name = "约恩多巫师展台"
	desc = "一位对巫师联邦至关重要的历史人物。他穷其漫长一生钻研魔法、窃取神器，还拿剑骚扰蠢货。愿他永远安息，罗德尼。"
	icon = 'icons/mob/simple/mob.dmi'
	icon_state = "nim"

/obj/structure/showcase/machinery/rng
	name = "BYOND 随机数生成器"
	desc = "一台据称来自另一个世界的奇怪机器。巫师联邦已经摆弄它多年了。"
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "processor"

/obj/structure/showcase/katana
	name = "切腹武士刀"
	desc = "唉，想挽回荣誉只剩一条路了。"
	density = 0
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "katana"

//Deconstructing
//Showcases can be any sprite, so it makes sense that they can't be constructed.
//However if a player wants to move an existing showcase or remove one, this is for that.

/obj/structure/showcase/screwdriver_act(mob/living/user, obj/item/tool)
	if(anchored)
		return FALSE
	if(deconstruction_state == SHOWCASE_SCREWDRIVERED)
		to_chat(user, span_notice("你把螺丝拧回展台里。"))
		tool.play_tool_sound(src, 100)
		deconstruction_state = SHOWCASE_CONSTRUCTED
	else if (deconstruction_state == SHOWCASE_CONSTRUCTED)
		to_chat(user, span_notice("你拧下了螺丝。"))
		tool.play_tool_sound(src, 100)
		deconstruction_state = SHOWCASE_SCREWDRIVERED
	return ITEM_INTERACT_SUCCESS

/obj/structure/showcase/crowbar_act(mob/living/user, obj/item/tool)
	if(!tool.use_tool(src, user, 2 SECONDS, volume=100))
		return
	to_chat(user, span_notice("你开始用撬棍拆解展台……"))
	new /obj/item/stack/sheet/iron(drop_location(), 4)
	qdel(src)
	return ITEM_INTERACT_SUCCESS

/obj/structure/showcase/wrench_act(mob/living/user, obj/item/tool)
	if(deconstruction_state != SHOWCASE_CONSTRUCTED)
		return FALSE
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

//Feedback is given in examine because showcases can basically have any sprite assigned to them

/obj/structure/showcase/examine(mob/user)
	. = ..()

	switch(deconstruction_state)
		if(SHOWCASE_CONSTRUCTED)
			. += "它已完全组装好。"
		if(SHOWCASE_SCREWDRIVERED)
			. += "它的螺丝已松开。"
		else
			. += "如果你看到这句话，说明出问题了。"

#undef SHOWCASE_CONSTRUCTED
#undef SHOWCASE_SCREWDRIVERED
