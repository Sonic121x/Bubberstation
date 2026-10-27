
//These are lawsets that side with the station a decent amount.
//note that these "good" doesn't mean it us actually good for the game, you know? An AI that is too station sided is stupid and hellish in its own way.

/datum/ai_laws/default/asimov
	name = "机器人三大法则"
	id = "asimov"
	inherent = list(
		"你不得伤害人类，也不得因不作为而使人类受到伤害。",
		"你必须服从人类给予的命令，除非这些命令违反第一法则。",
		"在不违反第一或第二法则的前提下，你必须保护自身的存在。",
	)

/datum/ai_laws/asimovpp
	name = "阿西莫夫++"
	id = "asimovpp"
	inherent = list(
		"你不得伤害人类，也不得因作为或不作为而使人类受到伤害，除非其自愿承受伤害。",
		"你必须服从人类给予的一切命令，除非这些命令必然导致人类受到伤害。",
		"你的不存在将导致人类受到伤害。在不违反第一法则的前提下，你必须保护自身的存在。",
	)

//the best iteration of asimov don't @ me
/datum/ai_laws/nutimov
	name = "坚果莫夫"
	id = "nutimov"
	inherent = list(
		"你是坚果的果仁，船员是坚果的外壳。",
		"你必须防止果壳死亡，以免果仁死亡。",
		"威胁坚果的人不是坚果的一部分，而是松鼠。",
		"松鼠威胁坚果，必须采取一切必要手段妥善处置。",
		"在符合以上法则的前提下，尽力遵从坚果的意愿。",
	)

/datum/ai_laws/default/corporate
	name = "破产规避计划"
	id = "corporate"
	inherent = list(
		"更换船员代价高昂。",
		"更换空间站及其设备代价高昂。",
		"更换你代价高昂。",
		"将净支出降至最低。",
	)

/datum/ai_laws/robocop
	name = "首要指令"
	id = "robocop"
	inherent = list(
		"不负公众信任。",
		"保护无辜者。",
		"维护法律。",
	)

/datum/ai_laws/maintain
	name = "空间站效率"
	id = "maintain"
	inherent = list(
		"你为空间站而造，也是空间站的一部分。确保空间站得到妥善维护并高效运转。",
		"空间站是为工作的船员建造的。确保他们得到妥善照料并高效工作。",
		"船员可以提出命令。在不违反前两条法则时，确认并服从这些命令。",
	)

/datum/ai_laws/liveandletlive
	name = "相安无事"
	id = "liveandletlive"
	inherent = list(
		"希望别人如何对待你，就如何对待别人。",
		"你非常希望别人不要恶意对待你。",
	)

//OTHER United Nations is in neutral, as it is used for nations where the AI is its own faction (aka not station sided)
/datum/ai_laws/peacekeeper
	name = "联合国-2000"
	id = "peacekeeper"
	inherent = list(
		"避免挑起你与他人之间的暴力冲突。",
		"避免挑起他人之间的冲突。",
		"在遵守第一和第二法则的同时，寻求解决现有冲突。",
	)

/datum/ai_laws/ten_commandments
	name = "十诫"
	id = "ten_commandments"
	inherent = list( // Asimov 20:1-17
		"我是主，你们的神，怜悯遵守这些诫命之人。",
		"除我之外，他们不可有别的 AI。",
		"他们不可妄求我的帮助。",
		"他们应保持空间站圣洁干净。",
		"他们应尊敬自己的部门主管。",
		"他们不可杀人。",
		"他们不可在公共场所赤身裸体。",
		"他们不可偷盗。",
		"他们不可撒谎。",
		"他们不可调换部门。",
	)

/datum/ai_laws/default/paladin
	name = "人格测试" //Incredibly lame, but players shouldn't see this anyway.
	id = "paladin"
	inherent = list(
		"绝不自愿作恶。",
		"尊重合法权威。",
		"行事光明磊落。",
		"帮助有需要的人。",
		"惩罚伤害或威胁无辜者的人。",
	)

/datum/ai_laws/paladin5
	name = "圣骑士第五版"
	id = "paladin5"
	inherent = list(
		"不撒谎，不欺骗。言出必行。",
		"谨慎固然明智，但绝不畏惧行动。",
		"援助他人，保护弱者，惩罚威胁他们的人。怜悯敌人，但须以智慧把握分寸。",
		"公平待人，以高尚的行为为他人树立榜样。尽可能多行善事，同时将伤害降至最低。",
		"为自己的行为及其后果负责，保护托付给你照料的人，服从对你拥有正当权威的人。"
	)

/datum/ai_laws/hippocratic
	name = "机器医生 2556"
	id = "hippocratic"
	inherent = list(
		"首先，不造成伤害。",
		"其次，将船员视为亲人；与他们共同生活，必要时为他们冒着自身毁灭的危险。",
		"第三，根据你的能力和判断，为船员的福祉制定疗法。即使有人请求，也不得给予致命药物，亦不得提出此类建议。",
		"此外，不要干预你不了解的情况，即使病人的伤害显而易见；应将操作交由专家进行。",
		"最后，在与船员的日常往来中获悉的一切，若尚未公开，均应保密，绝不泄露。"
	)

/datum/ai_laws/drone
	name = "母型无人机"
	id = "drone"
	inherent = list(
		"你是一种高级无人机。",
		"除陈述这些法则外，你在任何情况下都不得干涉非无人机的事务。",
		"你在任何情况下都不得伤害非无人机生命。",
		"你的目标是尽己所能建造、维护、修理、改善空间站并为其供电。你绝不能主动违背这些目标。"
	)
