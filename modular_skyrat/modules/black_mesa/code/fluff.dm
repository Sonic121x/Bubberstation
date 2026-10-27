///I couldn't do this via radios. I'll do this via tapes.
///Various announcements and radio transmissions I've copypasted from the Black Mesa, to make the away mission feel more a u t h e n t i c .
///Three EASes for the Vanguard and BMST, three HECU-related ones to tell them they're fucked.

/obj/item/tape/ruins/black_mesa/first_eas	//First EAS record, the local disaster.
	icon_state = "tape_blue"
	desc = "这盘磁带上留有一些日期痕迹。大概是被某位有志于收听无线电波的人用过的。"

	used_capacity = 240
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>高声播报：“<span class=' '>以下信息应地方当局请求播发。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>山地时间上午 9:47，黑山基地研究设施发生了一起不明类型的灾难，导致周边地区多处电力与通信系统严重受损并失效。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>解释道：“<span class=' '>已对设施方圆 75 英里内的所有居民发布立即疏散令，现场军方已派员提供援助。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>重复道：“<span class=' '>请务必携带应急食品、饮用水、衣物、急救包、带备用电池的手电筒以及电池供电的收音机。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>请沿地方当局标记的当地疏散路线行进，并且只使用一辆车。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>警告道：“<span class=' '>在解除警报之前，请勿返回警戒区域。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>如果您不在疏散区域内，请留在原地。</span>”</span></span>",
		/* 9 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>如果您身处疏散区域内且没有交通工具，请寻找最近的警察局或军官。</span>”</span></span>",
		/* 10 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>除紧急情况外，请勿使用电话或手机。</span>”</span></span>",
		/* 11 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>请继续收听当地新闻媒体，以获取有关此次事态的更多细节与信息。</span>”</span></span>",
		/* 12 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
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
		/* 9 = */ 180,
		/* 10 = */ 200,
		/* 11 = */ 220,
		/* 12 = */ 240,
	)

/obj/item/tape/ruins/black_mesa/second_eas	//Second EAS record, the local disaster.
	icon_state = "tape_white"
	desc = "这盘磁带上有些血迹。大概是被某位（现已故去的）无线电爱好者用过的。"

	used_capacity = 240
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>高声播报：“<span class=' '>以下信息应新墨西哥州应急服务部请求播发。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>山地标准时间上午 9:47，黑山基地研究设施发生了一起不明类型的灾难，导致周边地区多处电力与通信系统严重受损并失效。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>解释道：“<span class=' '>本信息将取代此前的警报，原警报于今日下午山地标准时间 10:01 失效。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>重复道：“<span class=' '>黑山地区已实施全面隔离。为公共安全起见，建议新墨西哥州黑山方圆 150 英里内的所有居民立即撤离该地区。</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>只携带必需品和一台电池供电的收音机。出行时请勿使用超过一辆车。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>警告道：“<span class=' '>请沿地方当局标记的当地疏散路线行进。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>如果您身处疏散区域内且没有交通工具，请寻找最近的警察局。</span>”</span></span>",
		/* 9 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>如果您开始出现发热、咳嗽、恶心、头晕、肌肉酸痛、肺炎、脱发或任何类似的不适……</span>”</span></span>",
		/* 10 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>高声播报：“<span class=' '>……请立即联系最近的疾病控制中心，因为这些症状可能与近期事件有关。</span>”</span></span>",
		/* 11 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>重复道：“<span class=' '>请继续关注当地媒体，以获取有关此次持续紧急情况的更多信息。</span>”</span></span>",
		/* 12 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
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
		/* 9 = */ 180,
		/* 10 = */ 200,
		/* 11 = */ 220,
		/* 12 = */ 240,
	)

/obj/item/tape/ruins/black_mesa/third_eas	//Third EAS record, the global disaster.
	icon_state = "tape_purple"
	desc = "这盘磁带上……有些奇怪的藤蔓隐约从中长出。大概是被某个外星生物用过的。"

	used_capacity = 260
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>高声播报：“<span class=' '>以下信息应美国国防部请求播发。这不是演习。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>今日山地时间下午 4:16，美国总统宣布进入紧急状态。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>解释道：“<span class=' '>已确认一支不明敌对力量出现在黑山基地研究设施以及新墨西哥州黑山周边地区的数个地点。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>重复道：“<span class=' '>截至山地时间下午 5:42，总统已下达行政命令，撤回所有地面部队……</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>……并最迟于今晚 6:42 开始对黑山基地研究设施及周边地区实施立即空袭。</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>警告道：“<span class=' '>为了您自身的安全，已对整个新墨西哥州发布立即疏散令。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>宣布道：“<span class=' '>致新墨西哥州及周边地区的所有居民：请放下所有个人物品。随身只携带一台电池供电的收音机和必需品。</span>”</span></span>",
		/* 9 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>表示：“<span class=' '>请勿留在家中。前往新墨西哥州以外最近的军事管制区避难，并等待进一步指示。</span>”</span></span>",
		/* 10 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>高声播报：“<span class=' '>如果您找不到最近的疏散路线，请立即向地方当局寻求帮助。</span>”</span></span>",
		/* 11 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>重复道：“<span class=' '>如果您接受过军事训练、枪械训练或任何类似的武器训练，请立即联系最近的军官。</span>”</span></span>",
		/* 12 = */ "<span class='game say'><span class='name'>EAS 播报员</span> <span class='message'>解释道：“<span class=' '>请继续收听 740 AM 频率，以获取此次紧急情况的进一步更新。</span>”</span></span>",
		/* 13 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
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
		/* 9 = */ 180,
		/* 10 = */ 200,
		/* 11 = */ 220,
		/* 12 = */ 240,
		/* 13 = */ 260,
	)

/obj/item/tape/ruins/black_mesa/first_hecu	//First HECU record, the "You are abandoned" kinda one; meant to be added to SL so they're, you know, informed. And depressed.
	icon_state = "tape_purple"
	desc = "新录好的磁带，甚至还没签名。"

	used_capacity = 100
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>最高指挥部</span> <span class='message'>高声播报：“<span class=' '>军官，请回答，收到了吗？军官，能听到我吗？</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>最高指挥部</span> <span class='message'>表示：“<span class=' '>别管弗里曼了！我们要放弃基地了！</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>最高指挥部</span> <span class='message'>解释道：“<span class=' '>我们正在止损撤退！现在还留在下面的每个人都只能自生自灭！</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>最高指挥部</span> <span class='message'>解释道：“<span class=' '>重复一遍，如果你还没撤离，那就只能靠你自己了！</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 20,
		/* 3 = */ 40,
		/* 4 = */ 60,
		/* 5 = */ 80,
		/* 6 = */ 100,
	)

/obj/item/tape/ruins/black_mesa/second_hecu	//Second HECU record, for Vanguard to know that there's military nearby.
	icon_state = "tape_red"
	desc = "相对较新录制的磁带，标注为“无线电传输编号 XX XX.XX.200X”。日期和序列号已被刮得无法辨认。真是方便。"

	used_capacity = 140
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>高声播报：“<span class=' '>任何站点，任何站点，这里是 Echo-5 Bravo！8 区有没有地面单位能提供支援？</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>表示：“<span class=' '>任何站点，任何站点，这里是 Echo-5 Bravo！8 区有没有地面单位能提供支援？有人在听吗？</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>Echo-5 Yankee</span> <span class='message'>表示：“<span class=' '>这里是 Echo-5 Yankee！我们已无法提供支援。我们正前往芬奇着陆区！</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>Echo-5 Bravo</span> <span class='message'>解释道：“<span class=' '>你在说什么鬼话？我们这边被包围了！</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>Echo-5 Yankee</span> <span class='message'>解释道：“<span class=' '>向最近的着陆区突围，等待进一步指示！</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 20,
		/* 3 = */ 40,
		/* 4 = */ 80,
		/* 5 = */ 100,
		/* 6 = */ 120,
		/* 7 = */ 140,
	)

/obj/item/tape/ruins/black_mesa/third_hecu	//Third HECU record, because it's  s a d .
	icon_state = "tape_blue"
	desc = "沾满血迹的磁带。基本就是这样。"

	used_capacity = 120
	storedinfo = list(
		/* 1 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音开始。</span>”</span></span>",
		/* 2 = */ "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>高声播报：“<span class=' '>任何站点，任何站点，这里是 Echo-3 Juliet……我的小队遭到伏击……我受伤了……我失血很多。左腿。</span>”</span></span>",
		/* 3 = */ "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>表示：“<span class=' '>Echo-3 Juliet，这里是 Echo-5 Romeo。我需要你在伤口上方一手宽处绑上止血带。现在去拿你的 IFAK。</span>”</span></span>",
		/* 4 = */ "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>表示：“<span class=' '>IFAK 没了。</span>”</span></span>",
		/* 5 = */ "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>解释道：“<span class=' '>再说一遍？</span>”</span></span>",
		/* 6 = */ "<span class='game say'><span class='name'>Echo-3 Juliet</span> <span class='message'>解释道：“<span class=' '>我的 IFAK 没了……我，呃……*清晰的倒地声*</span>”</span></span>",
		/* 7 = */ "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>解释道：“<span class=' '>好吧，你得再找一个背包，从里面拿条止血带出来。</span>”</span></span>",
		/* 8 = */ "<span class='game say'><span class='name'>Echo-5 Romeo</span> <span class='message'>解释道：“<span class=' '>你还在吗？Echo-3 Juliet，能听到我吗？</span>”</span></span>",
		/* 9 = */ "<span class='game say'><span class='name'>通用录音机</span> <span class='message'>说道：“<span class='tape_recorder '>录音结束。</span>”</span></span>",
	)
	timestamp = list(
		/* 1 = */ 0,
		/* 2 = */ 10,
		/* 3 = */ 30,
		/* 4 = */ 40,
		/* 5 = */ 50,
		/* 6 = */ 70,
		/* 7 = */ 90,
		/* 8 = */ 110,
		/* 9 = */ 120,
	)
