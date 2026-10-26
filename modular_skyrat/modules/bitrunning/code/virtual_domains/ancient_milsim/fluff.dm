/obj/item/tape/ruins/ancient_milsim
	icon_state = "tape_blue"
	name = "开发者解说"
	desc = "这盘录音大概录制于二十三世纪前后——至少那些模糊的标签是这么写的。为什么模糊？大概是为了显得真实吧。"


/obj/item/tape/ruins/ancient_milsim/devlog_one
	name = "开发者解说，日志 1：背景设定"
	used_capacity = 160

	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>未知人物</span> <span class='message'>大声说道：“<span class=' '>各位好，我叫莱昂·加德纳，欢迎参加众人期待已久的续作——《英勇时刻：边境救援》的续篇《英勇时刻 2》——的测试版。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>莱昂·加德纳</span> <span class='message'>陈述道：“<span class=' '>经过三年的开发，希望这份等待是值得的。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>莱昂·加德纳</span> <span class='message'>说明道：“<span class=' '>在接下来的发售前测试中，你将通关游戏的序幕关卡，它会详细讲述边境战争的早期阶段，并向你介绍智能 NPC 与完整的分子模拟等全新机制。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>莱昂·加德纳</span> <span class='message'>回应道：“<span class=' '>把背景设定在边境战争如此早期的阶段，是因为这样能与前作的故事相互补足。前作中有一些设定没能得到恰当的解释，玩家也未必完全看得懂，因此我们额外花了功夫，让新玩家更容易跟上剧情。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>莱昂·加德纳</span> <span class='message'>陈述道：“<span class=' '>正因如此，本作中收录的大多数 NPC 与物品都通过公开文件、对战争老兵的采访以及其他途径，与现实中对应的原型进行了交叉比对。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>莱昂·加德纳</span> <span class='message'>警告道：“<span class=' '>当前这张地图“intro-underscore-two”，是对战争头几个月中地球政府发起的众多秘密行动的简化呈现。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)

	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 20,
		/* 3 = */ 40,
		/* 4 = */ 80,
		/* 5 = */ 100,
		/* 6 = */ 120,
		/* 7 = */ 140,
		/* 8 = */ 160,
	)

/obj/item/tape/ruins/ancient_milsim/devlog_two
	name = "开发者解说，日志 2：机制"
	used_capacity = 160

	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>未知人物</span> <span class='message'>大声说道：“<span class=' '>大家好，我叫瓦妮莎·帕克，是即将推出的游戏《英勇时刻 2》的主机制开发。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>瓦妮莎·帕克</span> <span class='message'>陈述道：“<span class=' '>与上一部作品相比，新的软件与硬件升级让我们能够为玩家和 SNPC 打造深入的分子模拟以及逼真的伤害计算。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>瓦妮莎·帕克</span> <span class='message'>说明道：“<span class=' '>因此，在游戏的早期测试阶段，玩家和 SNPC 常常在最初的几场遭遇中就失血过多或因疼痛休克而死，导致体验很差。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>瓦妮莎·帕克</span> <span class='message'>回应道：“<span class=' '>我们决定解决这个问题，为此加入了一些自行设计、贴合设定的技术，比如医疗站。它们被安置在重要的兴趣点周围，玩家和他们更聪明的敌人可以使用它们恢复生命值，并消除那些曾经随处可见的流血伤口。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>瓦妮莎·帕克</span> <span class='message'>陈述道：“<span class=' '>另一个常见的问题是，SNPC 会随着时间推移越来越熟悉关卡，于是还没等玩家开始穿戴装备就冲上来把他们杀掉。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>瓦妮莎·帕克</span> <span class='message'>警告道：“<span class=' '>我们通过在 NPC 区与 SNPC 区之间设置“战争迷雾”解决了这一点。具体做法是立起一道半衰期长达数十年的电离气体力场墙，以确保这片力场不会随机消失。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 20,
		/* 3 = */ 40,
		/* 4 = */ 80,
		/* 5 = */ 100,
		/* 6 = */ 120,
		/* 7 = */ 140,
		/* 8 = */ 160,
	)

/obj/item/tape/ruins/ancient_milsim/devlog_three
	name = "开发者解说，日志 3：SNPC"
	used_capacity = 160

	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>未知人物</span> <span class='message'>大声说道：“<span class=' '>嗨，我是马克·马歇尔，《英勇时刻 2》的 SNPC 神经编程员。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>马克·马歇尔</span> <span class='message'>陈述道：“<span class=' '>新的智能 NPC 系统曾在首部作品的最终 Boss 战中短暂用于主要敌人，以确保那场战斗更有成就感、也更耐玩。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>马克·马歇尔</span> <span class='message'>说明道：“<span class=' '>而在新作中，SNPC 技术已大幅改进，我们决定在剧情中增加更多“更聪明”的战斗段落。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>马克·马歇尔</span> <span class='message'>回应道：“<span class=' '>他们会像普通玩家一样呼吸、进食和视物，并完整模拟自己的神经与认知模型，而不是像那些被简化、缺乏神经、思考与恐惧模拟的普通怪物。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>马克·马歇尔</span> <span class='message'>陈述道：“<span class=' '>它们拥有智能的学习曲线，能够适应并从与其他玩家的交手经验中学习，这意味着每一场战斗都应当是独一无二的。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>马克·马歇尔</span> <span class='message'>警告道：“<span class=' '>他们的模型也经过了大幅重制，允许其他人提交自己的角色外观，因此他们不会看起来千篇一律。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>通用记录仪</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 20,
		/* 3 = */ 40,
		/* 4 = */ 80,
		/* 5 = */ 100,
		/* 6 = */ 120,
		/* 7 = */ 140,
		/* 8 = */ 160,
	)
