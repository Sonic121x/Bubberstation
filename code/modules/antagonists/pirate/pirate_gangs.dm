///global lists of all pirate gangs that can show up today. they will be taken out of the global lists as spawned so dupes cannot spawn.
GLOBAL_LIST_INIT(light_pirate_gangs, init_pirate_gangs(is_heavy = FALSE))
GLOBAL_LIST_INIT(heavy_pirate_gangs, init_pirate_gangs(is_heavy = TRUE))

///initializes the pirate gangs glob list, adding all subtypes that can roll today.
/proc/init_pirate_gangs(is_heavy)
	var/list/pirate_gangs = list()

	for(var/type in subtypesof(/datum/pirate_gang))
		var/datum/pirate_gang/possible_gang = new type
		if(!possible_gang.can_roll())
			qdel(possible_gang)
		else if(possible_gang.is_heavy_threat == is_heavy)
			pirate_gangs += possible_gang
	return pirate_gangs

///datum for a pirate team that is spawning to attack the station.
/datum/pirate_gang
	///name of this gang, for spawning feedback
	var/name = "太空虫群"

	///Whether or not this pirate crew is a heavy-level threat
	var/is_heavy_threat = FALSE
	///the random ship name chosen from pirates.json
	var/ship_name
	///the ship they load in on.
	var/ship_template_id = "ERROR"
	///the key to the json list of pirate names
	var/ship_name_pool = "some_json_key"
	///inbound message title the station receives
	var/threat_title = "花钱打发太空虫群"
	///the contents of the message sent to the station.
	///%SHIPNAME in the content will be replaced with the pirate ship's name
	///%PAYOFF in the content will be replaced with the requested credits.
	var/threat_content = "这里是 %SHIPNAME。给我们 %PAYOFF 信用点，否则我们就放虫子把宇宙搅得一团糟！"
	///station receives this message upon the ship's spawn
	var/arrival_announcement = "我们来取你的邦戈积分了！"
	///what the station can say in response, first item pays the pirates, second item rejects it.
	var/list/possible_answers = list("求你们走吧！我们付钱！", "我接受湮灭。")

	///station responds to message and pays the pirates
	var/response_received = "美味！邦戈积分！"
	///station responds to message and pays the pirates
	var/response_rejected = "呸！没有邦戈积分！"
	///station pays the pirates, but after the ship spawned
	var/response_too_late = "你的邦戈积分来得太迟了，正在重启世界……"
	///station pays the pirates... but doesn't have enough cash.
	var/response_not_enough = "打入我银行账户的邦戈积分不够，正在重启世界……"

	/// Have the pirates been paid off?
	var/paid_off = FALSE
	/// The colour of their announcements when sent to players
	var/announcement_color = "red"

/datum/pirate_gang/New()
	. = ..()
	ship_name = pick(strings(PIRATE_NAMES_FILE, ship_name_pool))

///whether this pirate gang can roll today. this is called when the global list initializes, so
///returning FALSE means it cannot show up at all for the entire round.
/datum/pirate_gang/proc/can_roll()
	return TRUE

///returns a new comm_message datum from this pirate gang
/datum/pirate_gang/proc/generate_message(payoff)
	var/built_threat_content = replacetext(threat_content, "%SHIPNAME", ship_name)
	built_threat_content = replacetext(built_threat_content, "%PAYOFF", payoff)
	return new /datum/comm_message(threat_title, built_threat_content, possible_answers)

///classic FTL-esque space pirates.
/datum/pirate_gang/rogues
	name = "无赖帮"

	ship_template_id = "default"
	ship_name_pool = "rogue_names"

	threat_title = "星区保护服务报价"
	threat_content = "嘿，伙计，这里是 %SHIPNAME。忍不住注意到你正开着那么一艘狂野\
		又疯狂的小型穿梭机，却一点保险都没买！太疯狂了。万一它出点什么事呢，嗯？！我们\
		已经快速评估了你在本星区的费率，现在报出 %PAYOFF 的价，为你的\
		穿梭机提供任何灾难情况下的保障。"
	arrival_announcement = "想重新考虑我们的报价吗？很遗憾，谈判的时间已经过去了。开门吧，我们马上登船。"
	possible_answers = list("购买保险。","拒绝报价。")

	response_received = "真好，白拿的钱。弟兄们，我们撤。"
	response_rejected = "不付钱是个错误，现在你该去补一堂经济学课了。"
	response_too_late = "付不付钱都无所谓，无视我们是关乎尊严的事。现在该让我们教教你什么叫尊重了。"
	response_not_enough = "你以为少付点我们就不会注意到？真有趣。我们很快就会见面。"

///aristocrat lizards looking to hunt the serfs
/datum/pirate_gang/silverscales
	name = "银鳞帮"

	ship_template_id = "silverscale"
	ship_name_pool = "silverscale_names"

	threat_title = "贡品要求"
	threat_content = "这里是 %SHIPNAME。银鳞帮希望从你们这些下等蜥蜴那里收点贡品。\
		%PAYOFF 信用点应该就够了。"
	arrival_announcement = "当然，你们船上的那些东西你们不配拥有。它们在我们身上要合适得多。"
	possible_answers = list("我们付钱。","贡品？认真的？滚开。")

	response_received = "一份极为慷慨的捐赠。愿提兹拉的爪牙伸向宇宙最遥远的角落。"
	response_rejected = "那可就白搭了，狩猎的第一条规矩就是绝不空手而归。"
	response_too_late = "我看得出你想付钱，但狩猎已经开始了。"
	response_not_enough = "你送来了一份侮辱性的“捐赠”。猎杀你的行动开始了。"

///undead skeleton crew looking for booty
/datum/pirate_gang/skeletons
	name = "骷髅海盗"

	is_heavy_threat = TRUE
	ship_template_id = "dutchman"
	ship_name_pool = "skeleton_names" //just points to THE ONE AND ONLY

	threat_title = "货物移交"
	threat_content = "啊嘿！这里是 %SHIPNAME。乖乖交出 %PAYOFF 信用点，不然就让你走跳板。"
	arrival_announcement = "海盗旗可不会永远等下去，伙计们；我们就停在旁边，准备给你们送点礼物。"
	possible_answers = list("我们付钱。","我们不会任人勒索。")

	response_received = "谢谢你的信用点，旱鸭子。"
	response_rejected = "见鬼！全员上甲板，我们去抢他们的财宝！"
	response_too_late = "现在求饶太晚了！"
	response_not_enough = "想骗我们？你会后悔的！"

///Expirienced formed employes of Interdyne Pharmaceutics now in a path of thievery and reckoning
/datum/pirate_gang/interdyne
	name = "不安分的前药剂师"

	is_heavy_threat = TRUE
	ship_template_id = "ex_interdyne"
	ship_name_pool = "interdyne_names"

	threat_title = "科研经费"
	threat_content = "你们好，这里是 %SHIPNAME。我们的制药业务需要一些资金。\
		%PAYOFF 信用点应该就够了。"
	arrival_announcement = "我们谦卑地请求为今后的事业研究提供一笔可观的资金。你要是生了病那可就太遗憾了，不过我们能治好。"
	possible_answers = list("好吧。","去找份工作！")

	response_received = "感谢你的慷慨。你的钱不会被浪费。"
	response_rejected = "哦，你不是空间站，你是个肿瘤。那我们只好把它切掉。"
	response_too_late = "希望你喜欢皮肤癌！"
	response_not_enough = "这对我们的行动来说远远不够。恐怕我们只好自己借一些了。"
	announcement_color = "purple"

///Previous Nanotrasen Assitant workers fired for many reasons now looking for revenge and your bank account.
/datum/pirate_gang/grey
	name = "灰色浪潮"

	ship_template_id = "grey"
	ship_name_pool = "grey_names"

	threat_title = "这是抢劫"
	threat_content = "嘿，这里是 %SHIPNAME。给我们钱。\
		%PAYOFF 大概就够了。"
	arrival_announcement = "你那儿的东西不错，现在是我们的了。"
	possible_answers = list("求你别伤害我。","你们要向法律负责！！")

	response_received = "等等，你们真的把钱给我们了？谢了，不过剩下的我们还是要来拿！"
	response_rejected = "向法律负责？我们就是法律！而你要为此负责！"
	response_too_late = "什么都没有，是吧？看来浪潮要登船了！"
	response_not_enough = "想骗我们？没关系，我们就拿你的空间站当抵押。"
	announcement_color = "yellow"

///Agents from the space I.R.S. heavily armed to stea- I mean, collect the station's tax dues
/datum/pirate_gang/irs
	name = "太空税务局特工"

	is_heavy_threat = TRUE
	ship_template_id = "irs"
	ship_name_pool = "irs_names"

	threat_title = "欠缴税款"
	threat_content = "这里是 %SHIPNAME。我们注意到你的空间站一直没有缴税……\
		让我们来纠正这一点，你欠缴的税款共计 %PAYOFF。\
		我们强烈建议你立刻缴税，\
		我们不必派一支小队到你的空间站去解决问题，对吧？"
	arrival_announcement = "这里是税务冲突解决小组，如果你未能按时缴税，\
		请准备好资产被清算，并以税务欺诈罪被起诉。"
	possible_answers = list("你知道的，我本来就打算付那笔钱了。谢谢提醒！","我不管税务局派谁来，我都不会缴税！")

	response_received = "已收到付款，我们向守法的纳税人致敬"
	response_rejected = "我们理解，我正在派一支小队到你的空间站解决此事。"
	response_too_late = "太晚了，一支小队已经被派出直接解决此事。"
	response_not_enough = "你的报税有误，一支小队已被派出协助清算资产并以税务欺诈罪逮捕你。\
		别往心里去，孩子。"
	announcement_color = "yellow"

//Mutated Ethereals who have adopted bluespace technology in all the wrong ways.
/datum/pirate_gang/lustrous
	name = "晶洞拾荒者"

	ship_template_id = "geode"
	ship_name_pool = "geode_names"

	threat_title = "异常传输"
	threat_content = "母虚空的晶体裂开，%SHIPNAME 从中而来。我们即是辉光者，晶体之王的手。\
		我们的蓝空间尘储备已近枯竭，因而合成即将停止。%PAYOFF 信用点可以弥补这一切！"
	arrival_announcement = "我们已抵达，我们一直都在这里，而我们已经离开。"
	possible_answers = list("呃，好吧？行。","我们没时间听疯话，走开。")


	response_received = "收获极佳，合成将得以继续。"
	response_rejected = "你言语中的无礼必须被中和。而我们正好可以立刻帮你做到。"
	response_too_late = "当时你没有准备好，如今时机已过。我们只能向前，永不能回头。"
	response_not_enough = "你侮辱了我们，但不会有宿怨，只有迅捷的正义！"
	announcement_color = "purple"

//medieval militia, from OUTER SPACE!
/datum/pirate_gang/medieval
	name = "中世纪好战者"

	is_heavy_threat = TRUE
	ship_template_id = "medieval"
	ship_name_pool = "medieval_names"

	threat_title = "效忠金缴纳请求"
	threat_content = "致敬，这里是 %SHIPNAME，我们正在向领地内的附庸收钱，\
		而你们恰好也在我们的领地里！！通常\
		我们会把像你们这样擅闯我们土地的弱者宰掉，但只要你们缴纳 %PAYOFF 作为对我们法律的效忠金，\
		我们愿意欢迎你们进入我们的太空。明智地做出你的选择！！\
		（发送消息。发送消息。为什么消息发不出去？）。"
	arrival_announcement = "我搞明白怎么开我的船了，我们马上就会靠到你们旁边！！"
	possible_answers = list("好吧，我还挺喜欢我的脑袋完整的。","你们真蠢，去别处角色扮演吧。")

	response_received = "这样就够了，记住你们归谁所有！！"
	response_rejected = "愚蠢的决定，我会拿你的尸体做榜样！！（有人还记得怎么开我们的船吗？）"
	response_too_late = "你已经被围攻了，你这个丑角，你是脑子有病还是无知？！！"
	response_not_enough = "你当我是小丑吗？你死定了！！（我忘了怎么开船，真见鬼。）"
