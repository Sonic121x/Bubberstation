//code & items for the hauntedtradingpost.dmm ruin
//CONTAINS: [Lore Papers],[Outpost ID Cards],[Gimmick Treasure],[Hazards & Traps],[Custom Turrets]

// [Lore Papers]
// clues to traps that exist in the ruin or just insights into the backstory of the place
/obj/item/paper/fluff/ruins/hauntedtradingpost/warning
	name = "最后警告"
	default_raw_text = "下一个拿着那些该死的玩具枪乱搞、把自动售货机弄坏的人，当场开除。不信试试。我受够这狗屎了。<BR><BR>署名：你他妈的老板（完全有权他妈的开除你）"

/obj/item/paper/fluff/ruins/hauntedtradingpost/warning/turrets
	name = "警告！重要！读这个！"
	default_raw_text = "泡沫飞镖不要装进防御炮塔！只能装实弹！"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming
	name = "笔记"
	default_raw_text = "品牌命名：口袋里的披萨（查一下焦点小组）<BR><BR>番茄 马苏里拉 罗勒<BR>等等<BR><BR>Spider 17-02667 门店 31-00314<BR><BR>约 18,000 BSD<BR><BR>常见过敏原——？<BR><BR><BR>6127"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka
	default_raw_text = "从蛾族贸易舰队弄到了一些原料，又动用了我们的一部分自由支配预算租下了一些厂房空间。原型产品在公众和员工中都反响不错。如果能争取到中央为量产出资，根据 AI 的测算，我们的地区利润将永久增长 18%。这*完美*契合当地的早午餐市场。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka2
	default_raw_text = "完全无碳水配方的早期实验进展顺利。口味测试全部正面，只差降低成本的办法。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/brainstorming/eureka3
	default_raw_text = "大咚克计划<BR>研发部已经准备好了几个原型。<BR>测试将在本周末完成。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/rpgclub
	name = "RPG 俱乐部"
	default_raw_text = "RPG 俱乐部每周四 20:00 至凌晨 01:00 举行。该时段内进入休息室严格凭邀请。 <BR> <BR> 如有不便，敬请谅解。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/rpgrules
	name = "主持人笔记"
	default_raw_text = "第 4 场游戏的非玩家角色 <BR> 暗影战士 <BR> S  A  T  C  H <BR> 40 65 40 15 10 <BR><BR>暗影氏族霸主 <BR> S  A  T  C  H <BR> 40 65 40 15 10 <BR>备注：会暗影魔法。<BR><BR><BR>凶暴柯基 <BR> S  A  T  C  H <BR> 60 25 65 25 12 <BR><BR>如果他们打赢了，让他们在战利品表 4 上掷两次；但如果掷出 65-70 或 15-30，就换成魔法靴。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/curatorsnote
	name = "致冒险者"
	default_raw_text = "美食广场和摊位是安全的，其他地方都不安全。摊位里有保险箱，我没法打开它们，所以你要是能弄到里面的东西，算你厉害。跟着机器人就能进入员工区，但那里的安保系统是开启的。我探头看了一眼就被炮塔打了一枪，等我给自己缝好伤口、试着走另一扇门时，又踩进了陷阱，差点丢了一条胳膊。<BR><BR>如果你是在调查这个信号——小心。<BR>说句实话，我觉得里面没有任何东西值得冒这个险。如果你比我勇敢，祝你好运。<BR>署名：P 馆长。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/officememo
	name = "备忘录"
	default_raw_text = "AI 制导防御系统将无限期保持启用，以保护公司财产。请务必将所有个人物品从厂区内带走，因为一旦遗忘，将无法取回。 <BR><BR> 咚克公司对丢失的个人财产或物品概不负责。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt
	name = "旧收据"
	desc = "一张印在廉价热敏纸上的破旧销售收据。"
	default_raw_text = "咚克公司门店 6013<BR>今日为你服务的店员：COLM<BR><BR>2x DONKPOCKETPIZBOX    400<BR>1x CRYPTOGRAPHICSEQ    800<BR>2x CRYPTOGRAPHICTOY    200<BR>1x DONKPOCKETPLUSHY    120<BR><BR>总金额            1520<BR><BR>支付方式：现金"
	icon_state = "paperslip"

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt/alternate
	default_raw_text = "咚克公司门店 6013<BR>今日为你服务的店员：VLAD<BR><BR>1x DONKPOCKETBERBOX    200<BR>1x GORLEXMODSUITRED    1400<BR>1x MODSUITMICROWAVE    200<BR><BR>总金额            1800<BR><BR>支付方式：现金"

/obj/item/paper/fluff/ruins/hauntedtradingpost/receipt/alternate_alt
	default_raw_text = "咚克公司门店 6013<BR>今日为你服务的店员：COLM<BR><BR>10xDONKPOCKETORGBOX   2000<BR>4x GORLEXMODSUITRED    9600<BR>4x MODSUITMICROWAVE    800<BR><BR>总金额           13400<BR><BR>支付方式：刷卡"

/obj/item/paper/fluff/ruins/hauntedtradingpost/nomodsuits
	name = "通知"
	desc = "这张纸片上写了一堆字。真是的，这就是未来。"
	default_raw_text = "我们的 MOD 套装已售罄。"
	icon_state = "paperslip"

/obj/item/paper/fluff/ruins/hauntedtradingpost/oldnote
	name = "旧便条"
	default_raw_text = "记得在弹药装进炮塔前检查所有弹药。如果装错口径，炮塔会故障。<BR>我们只用 9 毫米弹药。"

/obj/item/paper/fluff/ruins/hauntedtradingpost/oldnote/aiclue
	name = "旧手写便条"
	default_raw_text = "所有电器现在都接入 AI 了。如果有任何问题，向赛博太阳的代表（萨通先生）报告。"

// [Outpost ID Cards]
//ID cards for the space ruin
/obj/item/card/id/away/donk
	name = "\improper 咚克公司 ID 卡"
	desc = "一张塑料卡片，证明持卡人是咚克公司的员工。卡内嵌有电子芯片，用于与气闸及其他机器通讯。卡上没有附姓名。"
	icon_state = "card_donk"
	trim = /datum/id_trim/away/hauntedtradingpost

/obj/item/card/id/away/donk/boss
	desc = "一张塑料卡片，证明持卡人是咚克公司的高级员工。卡内嵌有电子芯片，用于与气闸及其他机器通讯。卡上没有附姓名。"
	icon_state = "card_donkboss"
	trim = /datum/id_trim/away/hauntedtradingpost/boss

// [Gimmick Treasure]
// loot & weird items that should only exist in hauntedtradingpost.dmm
//aquarium with two donkfish in it
/obj/structure/aquarium/donkfish
	name = "办公室水族箱"
	desc = "圈养鱼类的家。这一个的玻璃上刻着“咚克公司”。"
	init_mode = AQUARIUM_MODE_SAFE

/obj/structure/aquarium/donkfish/Initialize(mapload)
	. = ..()
	new /obj/item/aquarium_prop/rocks(src)
	new /obj/item/aquarium_prop/seaweed(src)
	new /obj/item/fish/donkfish(src)
	new /obj/item/fish/donkfish(src)

//gimmick ketchup bottle for healing minor injuries
/obj/item/reagent_containers/condiment/donksauce
	name = "\improper 咚克公司秘制酱"
	desc = "那款著名的番茄酱，配方高度机密。"
	list_reagents = list(
		/datum/reagent/consumable/ketchup = 25,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/consumable/astrotame = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/bungojuice = 1,
		/datum/reagent/consumable/curry_powder = 1,
		/datum/reagent/consumable/soymilk = 1,
		/datum/reagent/consumable/tomatojuice = 1,
		/datum/reagent/consumable/vitfro = 1,
	)
	icon_state = "ketchup"
	fill_icon_thresholds = null

// [Hazards & Traps]
//cyborg holobarriers that die when the boss dies, how exciting
#define SELFDESTRUCT_QUEUE "hauntedtradingpost_sd" //make sure it matches the AI cores ID
/obj/structure/holosign/barrier/cyborg/cybersun_ai_shield
	desc = "由 AI 核心投射的脆弱全息能量场。它能让不受欢迎的人形生物保持在安全距离之外。"

/obj/structure/holosign/barrier/cyborg/cybersun_ai_shield/Initialize(mapload)
	. = ..()
	if(mapload) //shouldnt queue when we arent even part of a ruin, probably admin shitspawned
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

//smes that produces power, until the boss dies then it self destructs and you gotta make your own power
/obj/machinery/power/smes/magical/cybersun
	name = "赛博太阳牌电力储存单元"
	desc = "一台高容量超导磁储能（SMES）单元。它看起来和其他 SMES 单元没什么两样，只是这一台上写着“赛博太阳”。"
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE

/obj/machinery/power/smes/magical/cybersun/Initialize(mapload)
	. = ..()
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

//this is a trigger for traps involving doors and shutters
//doors get closed and bolted, shutters get cycled open/closed
/obj/machinery/button/door/invisible_tripwire
	name = "声波绊线"
	desc = "用于百叶窗和门的隐形触发器。有人踏上该地砖时触发。"
	max_integrity = 50
	invisibility = INVISIBILITY_ABSTRACT
	anchored = TRUE
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE
	//can the trap trigger more than once?
	var/multiuse = FALSE
	//(if multiuse) how many times the trap can trigger. 0 or lower is infinite
	var/uses_remaining = 0
	//if true, the trap will unbolt all doors it bolted and cycle shutters a second time after a delay
	var/resets_self = FALSE
	//time before resets_self kicks in
	var/reset_timer = 1.8 SECONDS
	//when multiple tripwires are in the same suicide pact, they will all die when any of them die
	var/suicide_pact = FALSE
	//id of the suicide pact this tripwire is in
	var/suicide_pact_id

/obj/machinery/button/door/invisible_tripwire/Initialize(mapload)
	. = ..()
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)
	if(suicide_pact && suicide_pact_id != null)
		SSqueuelinks.add_to_queue(src, suicide_pact_id)
		. = INITIALIZE_HINT_LATELOAD
	var/static/list/loc_connections = list(
	COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/machinery/button/door/invisible_tripwire/find_and_mount_on_atom(mark_for_late_init, late_init)
	return //these exist independently on an turf

/obj/machinery/button/door/invisible_tripwire/post_machine_initialize()
	. = ..()
	if(!suicide_pact || isnull(SSqueuelinks.queues[suicide_pact_id]))
		return // we got beat to it
	SSqueuelinks.pop_link(suicide_pact_id)

/obj/machinery/button/door/invisible_tripwire/MatchedLinks(id, list/partners)
	if(id != suicide_pact_id)
		return
	for(var/partner in partners)
		RegisterSignal(partner, COMSIG_PUZZLE_COMPLETED, TYPE_PROC_REF(/datum, selfdelete))

/obj/machinery/button/door/invisible_tripwire/proc/on_entered(atom/source, atom/movable/victim)
	SIGNAL_HANDLER
	if(!isliving(victim))
		return
	var/mob/living/target = victim
	if(target.stat != DEAD && target.mob_size == MOB_SIZE_HUMAN && target.mob_biotypes != MOB_ROBOTIC)
		tripwire_triggered(target)
		if(multiuse && uses_remaining < 1)
			uses_remaining--
		if(resets_self)
			addtimer(CALLBACK(src, PROC_REF(tripwire_triggered), victim), reset_timer)

/obj/machinery/button/door/invisible_tripwire/proc/tripwire_triggered(atom/victim)
	INVOKE_ASYNC(src, TYPE_PROC_REF(/atom, interact), victim)
	if(multiuse && uses_remaining != 1)
		return
	if(suicide_pact && suicide_pact_id)
		SEND_SIGNAL(src, COMSIG_PUZZLE_COMPLETED)
	qdel(src)

//door button that destroys itself when it is pressed
/obj/machinery/button/door/selfdestructs
	icon_state= "button-warning"
	skin = "-warning"

/obj/machinery/button/door/selfdestructs/attempt_press(mob/user)
	. = ..()
	do_sparks(rand(1,3), src)
	playsound(src, SFX_SPARKS, 100, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	qdel(src)

//trap that gloms onto the first machine it finds on its tile, and lives inside it
//then it zaps everyone who gets close. disarm by dissassembling the machine, or running out its charges
/obj/effect/overloader_trap
	name = "过载陷阱"
	desc = "一种使机器过载、以电击附近行人的陷阱。"
	alpha = 70
	max_integrity = 50
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/effects/effects.dmi'
	icon_state = "empdisable"
	//trap won't damage mobs in its faction. set this to null to make it attack everyone
	faction = list(ROLE_SYNDICATE)
	invisibility = INVISIBILITY_ABSTRACT
	plane = ABOVE_GAME_PLANE
	//datum we use to trigger when someones close
	var/datum/proximity_monitor/proximity_monitor
	// how close someone has to be to set the trap off
	var/trigger_range = 1
	// max range the trap can zap someone
	var/shock_range = 1
	/// damage from getting zapped by this trap
	var/shock_damage = 35
	// length of time target spends stunned
	var/stun_duration = 1.5 SECONDS
	// length of time targets spend jittery
	var/jitter_time = 5 SECONDS
	// length of time targets stutter
	var/stutter_time = 2 SECONDS
	//is this being used as part of the haunted trading post ruin? if true, will self destruct when boss dies
	var/donk_ai_slave = FALSE
	// machine that the trap inhabits
	var/obj/machinery/host_machine
	// turf that the trap is on
	var/turf/my_turf
	//how long until trap zaps everything, after it detects something
	var/trigger_delay = 0.7 SECONDS
	COOLDOWN_DECLARE(trigger_cooldown)
	//time until trap can be triggered again
	var/trigger_cooldown_duration = 4 SECONDS
	//max amount of times the trap can trigger
	var/uses_remaining = 4
	//amount of damage the trap does to the machine its on, when its triggered
	//this can kill the machine and if it does, the trap effectively disarms itself
	//so acts as a soft cap of sorts on number of trap activations
	var/machine_overload_damage = 80 //machine integrity is usually 200 or 300

/obj/effect/overloader_trap/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 0)
	proximity_monitor?.set_range(trigger_range)
	my_turf = get_turf(src)
	host_machine = locate(/obj/machinery) in loc
	if(donk_ai_slave)
		SSqueuelinks.add_to_queue(src, SELFDESTRUCT_QUEUE)

/obj/effect/overloader_trap/HasProximity(mob/living/target as mob)
	if(!locate(host_machine) in loc) //muh machine's gone, delete myself because im disarmed
		qdel(src)
		return
	if(!isliving(target))
		return
	if(!COOLDOWN_FINISHED(src, trigger_cooldown)) //do nothing if we're on cooldown
		return
	if(uses_remaining == 0) //deletes trap if it triggers when it has no uses left. should only happen if var edited but lets just be safe
		qdel(src)
		return
	if (IS_UNCONSCIOUS_OR_CRIT(target)) //ensure the guy triggering us is alive
		return
	if (!faction_check_atom(target)) //and make sure it ain't someone on our team
		COOLDOWN_START(src, trigger_cooldown, 4 SECONDS)
		trap_alerted()

/obj/effect/overloader_trap/proc/trap_alerted()
	if(host_machine in loc) //if someone breaks or moves the machine before the trap goes off, this should fail to do anything
		visible_message(span_boldwarning("火花从 [host_machine] 上飞溅而出，它剧烈地摇晃着！"))
		do_sparks(number = 3, source = host_machine)
		host_machine.Shake(2, 1, trigger_delay)
		addtimer(CALLBACK(src, PROC_REF(trap_effect)), trigger_delay)

/obj/effect/overloader_trap/proc/trap_effect()
	for(var/mob/living/living_mob in range(shock_range, src))
		if(faction_check_atom(living_mob))
			continue
		to_chat(living_mob, span_warning("你被一道电弧击中！"))
		src.Beam(living_mob, icon_state = "lightning[rand(1,12)]", time = 0.5 SECONDS)
		living_mob.electrocute_act(shock_damage, host_machine, 1, SHOCK_NOGLOVES, stun_duration, jitter_time, stutter_time)
	for(var/obj/item/food/deadmouse in range(shock_range, src))
		src.Beam(deadmouse, icon_state = "lightning[rand(1,12)]", time = 0.5 SECONDS)
	do_sparks(number = 1, source = host_machine)
	host_machine.take_damage(machine_overload_damage, sound_effect = FALSE)
	uses_remaining--
	if(uses_remaining <= 0)
		qdel(src)

// [Custom Turrets]
//these are the non-mob defenders of the hauntedtradingpost.dmm ruin
//they are controlled with a syndicate ID and are hostile to anything non-syndicate by default

//donk turret - 9mm
/obj/machinery/porta_turret/syndicate/donk
	//Medium speed, medium damage, fragile. Does brute damage.
	name = "\improper 咚克公司防御炮塔"
	icon_state = "donk_lethal"
	max_integrity = 120
	base_icon_state = "donk"
	stun_projectile = /obj/projectile/bullet/foam_dart/riot
	lethal_projectile = /obj/projectile/bullet/c9mm/blunttip
	lethal_projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	stun_projectile_sound = 'sound/items/weapons/gun/pistol/shot.ogg'
	desc = "一台带有咚克公司标志的弹道机枪自动炮塔。它使用 9 毫米弹药。"
	armor_type = /datum/armor/donk_turret
	scan_range = 6
	shot_delay = 1 SECONDS

/datum/armor/donk_turret
	melee = 20
	bullet = 20
	laser = 40
	energy = 40
	bomb = 20
	fire = 50
	acid = 100

/obj/projectile/bullet/c9mm/blunttip
	wound_bonus = -40 //this will still cause bleeding wounds, but less often.

//cybersun turret - plasma beam
/obj/machinery/porta_turret/syndicate/energy/cybersun
	//Slow speed, high damage. Does burn damage.
	name = "\improper 赛博太阳等离子自动炮塔"
	icon_state = "red_lethal"
	base_icon_state = "red"
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/items/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/cybersun
	lethal_projectile_sound = 'sound/items/weapons/lasercannonfire.ogg'
	desc = "一台带有赛博太阳标志的能量枪自动炮塔。它发射高能等离子束，伤害很高，但射速可能相当慢。"
	armor_type = /datum/armor/syndicate_shuttle
	scan_range = 6
	shot_delay = 5 SECONDS
	always_up = FALSE
	has_cover = TRUE

/obj/projectile/beam/laser/cybersun
	name = "等离子束"
	desc = "一道巨大的红色等离子束，正在飞行中。"
	icon_state = "lava"
	light_color = COLOR_DARK_RED
	damage = 30
	wound_bonus = -50

#undef SELFDESTRUCT_QUEUE
