///Spawns a big, amped up fat anomaly
/obj/effect/spawner/random/big_anomaly
	name = "大型异常生成器"
	icon_state = "big_anomaly"
	loot = list(
		/obj/effect/anomaly/pyro/big,
		/obj/effect/anomaly/flux/big,
		/obj/effect/anomaly/bluespace/big,
		/obj/effect/anomaly/grav/high/big,
	)

///Spawns a stable anomally that doesnt drop cores and doesn't destroy or alter the environment
/obj/effect/spawner/random/environmentally_safe_anomaly
	name = "安全异常生成器"
	icon_state = "anomaly"
	loot = list(
		/obj/effect/anomaly/flux,
		/obj/effect/anomaly/bluespace,
		/obj/effect/anomaly/hallucination,
		/obj/effect/anomaly/bioscrambler/docile,
	)

	///Do we anchor the anomaly? Set to true if you don't want anomalies drifting away (like if theyre in space or something)
	var/anchor_anomaly = FALSE

/obj/effect/spawner/random/environmentally_safe_anomaly/make_item(spawn_loc, type_path_to_make)
	. = ..()

	var/obj/effect/anomaly/anomaly = .
	anomaly.stabilize(anchor = anchor_anomaly, has_core = FALSE)

/obj/effect/spawner/random/environmentally_safe_anomaly/bioscramblerless
	name = "不含生物扰乱器的安全异常生成器"
	loot = list(
		/obj/effect/anomaly/flux,
		/obj/effect/anomaly/bluespace,
		/obj/effect/anomaly/hallucination,
	)

/obj/effect/spawner/random/environmentally_safe_anomaly/immobile
	name = "固定式安全异常生成器"
	icon_state = "anomaly_stationary"
	anchor_anomaly = TRUE

/obj/item/paper/fluff/ruins/anomaly_research/intro
	name = "启示"
	default_raw_text = {"异常？！？？！？？ 他们全都忙着用异常做护甲、武器和无聊的玩具，
	<br> 没有一个人想弄清它们的本质！没人好奇为什么异常会对无线电信号做出反应，还会掉出包装得整整齐齐的异常包裹？
	<br> 有些异常代表着我们宇宙的基本层面：蓝空间、重力、通量、热能，但一个“肢解”异常到底他妈算什么东西？
	<br> 一个该死的幻觉异常？幽灵异常？？？有些根本就说不通。它们到底在向我们隐瞒什么？？？？？？？
	<br>
	<br> 我拿了他们 20 个异常核心，反正他们也不会用。我用第二法则命令一个半机械人给我造了一座太空实验室，我的完美帝国。可怜的小机械人。
	<br> 我，安娜·莫莉博士，将揭示真相！！
	"}

/obj/item/paper/fluff/ruins/anomaly_research/stabilizer
	name = "稳定器"
	default_raw_text = {"真可惜异常很少能在周围待久，通常几分钟就消失了（有些例外）。
	<br> 但这说得通，如果异常来自现实的不同层面，
	<br> 它们只是在四处弹来弹去，最终会被拉回属于它们的地方。除非它们被取了核心。
	<br> 但我做到了！！！这东西极难获得，不过零液正是稳定器的最后一个组件。
	<br> 既然我能对活跃异常进行长期研究了，我的成就将无可限量！！
	"}

/obj/item/paper/fluff/ruins/anomaly_research/mega_anomally
	name = "超级异常"
	default_raw_text = {"这耗尽了我每一个异常，还有我几乎全部的稳定器储备，但我做到了。
	<br> 我创造了终极超级异常！！我用零液改造了一套 MOD 外骨骼，应该能让我进入其中！
	<br> 我把莫菲送到了我妈那儿，以防我回不来。如果你读到这个，气死你吧，我在异常宇宙里（或者已经死了）哈哈哈哈哈！！
	<br> 安娜·莫莉博士，下线。
	"}

/area/misc/anomaly_research
	name = "异常研究设施"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "anomaly_research"
	requires_power = FALSE
	area_flags = HIDDEN_AREA
	default_gravity = ZERO_GRAVITY

/obj/item/reagent_containers/cup/bottle/wittel
	name = "维特尔瓶"
	list_reagents = list(/datum/reagent/wittel = 5)
