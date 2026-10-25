/**
 * Defines a theme used by guardian mobs for visuals and some text output
 * The default is used for ones created by wizards
 */
/datum/guardian_fluff
	/// What name do we apply before one has been selected?
	var/name = "守护灵"
	/// Mob description to apply
	var/desc = "一个神秘的存在，始终守护着它的主人，从不懈怠。"
	/// Are we magical or technological? Mostly just used to pick a surname
	var/fluff_type = GUARDIAN_MAGIC
	/// What speech bubble do we use?
	var/bubble_icon = "guardian"
	/// What is our base icon state?
	var/icon_state = "magicbase"
	/// What is the icon state for our coloured overlay?
	var/overlay_state = "magic"
	/// Emote used for speaking
	var/list/speak_emote = list("嘶嘶作响")
	/// Verb shown to viewers when attacking
	var/attack_verb_continuous = "挥拳猛击"
	/// Verb shown to attacker when attacking
	var/attack_verb_simple = "挥拳猛击"
	/// Sound played when we attack
	var/attack_sound = 'sound/items/weapons/punch1.ogg'
	/// Visible effect when we attack
	var/attack_vis_effect = ATTACK_EFFECT_PUNCH
	/// An associative list of type of guardian to some kind of descriptive text to show on appearance.
	var/guardian_fluff = list(
		GUARDIAN_ASSASSIN = "……抽到了太空忍者，一位致命而隐形的刺客。",
		GUARDIAN_CHARGER = "……抽到了猎人，快速突袭的外星大师。",
		GUARDIAN_DEXTROUS = "……抽到了猴子，学会了使用工具的进阶野兽。",
		GUARDIAN_EXPLOSIVE = "……抽到了科学家，爆炸性死亡的先驱。",
		GUARDIAN_GASEOUS = "……抽到了大气技术员，笼罩在紫色迷雾之中。",
		GUARDIAN_GRAVITOKINETIC = "……抽到了奇点，一股可怕而不可抗拒的力量……",
		GUARDIAN_LIGHTNING = "……抽到了超物质，一泓令人震惊的致命能量之源。",
		GUARDIAN_PROTECTOR = "……抽到了柯基，一位寸步不离主人的坚定守护者。",
		GUARDIAN_RANGED = "……抽到了守望者，从远处刺穿猎物。",
		GUARDIAN_STANDARD = "……抽到了助手，面目模糊却绝不可小觑。",
		GUARDIAN_SUPPORT = "……抽到了急救员，生死的仲裁者。",
	)

/// Applies relevant visual properties to our guardian
/datum/guardian_fluff/proc/apply(mob/living/basic/guardian/guardian)
	guardian.name = name
	guardian.real_name = name
	guardian.bubble_icon = bubble_icon
	guardian.icon_living = icon_state
	guardian.icon_state = icon_state

	guardian.speak_emote = speak_emote
	guardian.attack_verb_continuous = attack_verb_continuous
	guardian.attack_verb_simple = attack_verb_simple
	guardian.attack_sound = attack_sound
	guardian.attack_vis_effect = attack_vis_effect

	guardian.overlay = mutable_appearance(guardian.icon, overlay_state)

/// Output an appropriate fluff string for our guardian when it is created
/datum/guardian_fluff/proc/get_fluff_string(guardian_type)
	return span_holoparasite(guardian_fluff[guardian_type] || "你召唤出了一只故障的可憎之物，这本不该存在！请联系程序员处理。")

/// Used by holoparasites in the Traitor uplink
/datum/guardian_fluff/tech
	name = "全息寄生体"
	fluff_type = GUARDIAN_TECH
	bubble_icon = "holo"
	icon_state = "techbase"
	overlay_state = "tech"
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "启动程序完成。隐匿模块已加载。全息寄生体群已上线。",
		GUARDIAN_CHARGER = "启动程序完成。动力引擎超频中。全息寄生体群已上线。",
		GUARDIAN_DEXTROUS = "启动程序完成。武装战斗程序已加载。全息寄生体群已上线。",
		GUARDIAN_EXPLOSIVE = "启动程序完成。载荷发生器已上线。全息寄生体群已上线。",
		GUARDIAN_GASEOUS = "启动程序完成。大气投影器运行中。全息寄生体群已上线。",
		GUARDIAN_GRAVITOKINETIC = "启动程序完成。重力引擎加速启动中。全息寄生体群已上线。",
		GUARDIAN_LIGHTNING = "启动程序完成。特斯拉投射器充能完毕。全息寄生体群已上线。",
		GUARDIAN_PROTECTOR = "启动程序完成。保镖程序已加载。全息寄生体群已上线。",
		GUARDIAN_RANGED = "启动程序完成。飞镖发射器运行中。全息寄生体群已上线。",
		GUARDIAN_STANDARD = "启动程序完成。近身格斗套件已启用。全息寄生体群已上线。",
		GUARDIAN_SUPPORT = "启动程序完成。医疗套件已激活。全息寄生体群已上线。",
	)

/// Used by powerminers found in necropolis chests
/datum/guardian_fluff/miner
	name = "能量矿工"
	icon_state = "minerbase"
	overlay_state = "miner"
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "碎片揭示了……玻璃，锋利却脆弱的伏击者。",
		GUARDIAN_CHARGER = "碎片揭示了……钛，轻盈敏捷的战士。",
		GUARDIAN_DEXTROUS = "碎片揭示了……黄金，可塑的财宝囤积者。",
		GUARDIAN_EXPLOSIVE = "碎片揭示了……爆裂矿，易爆而令人意外。",
		GUARDIAN_GASEOUS = "碎片揭示了……等离子体，火焰的带来者。",
		GUARDIAN_GRAVITOKINETIC = "碎片揭示了……香蕉矿，动力的操纵者。",
		GUARDIAN_LIGHTNING = "碎片揭示了……铁，导电的闪电之源。",
		GUARDIAN_PROTECTOR = "碎片揭示了……铀，致密而坚韧。",
		GUARDIAN_RANGED = "碎片揭示了……钻石，投射出百万锋刃。",
		GUARDIAN_STANDARD = "碎片揭示了……塑钛，强大的战士。",
		GUARDIAN_SUPPORT = "碎片揭示了……蓝空间，位移的大师。",
	)

/// Used by holocarp spawned by admins
/datum/guardian_fluff/carp
	name = "全息鲤鱼"
	fluff_type = GUARDIAN_TECH
	desc = "一条神秘的鱼，游弋在主人身边，永远保持警觉。"
	icon_state = null // Handled entirely by the overlay
	bubble_icon = "holo"
	overlay_state = "carp"
	speak_emote = list("磨着牙")
	guardian_fluff = list(
		GUARDIAN_ASSASSIN = "鲤鱼鲤鱼鲤鱼！抓到一条！是一条刺客鲤鱼！正当你以为回到水里就安全了……可惜这没用，因为我们在太空里。",
		GUARDIAN_CHARGER = "鲤鱼鲤鱼鲤鱼！抓到一条！是一条喜欢朝人猛冲的冲锋鲤鱼。可它没有腿……",
		GUARDIAN_DEXTROUS = "鲤鱼鲤鱼鲤鱼！你抓到一条！是一条灵巧鲤鱼，只要捡起一条鱼，就准备拿鱼抽人。",
		GUARDIAN_EXPLOSIVE = "鲤鱼鲤鱼鲤鱼！抓到一条！是一条爆炸鲤鱼！你们俩一定会炸翻天。",
		GUARDIAN_GASEOUS = "鲤鱼鲤鱼鲤鱼！你抓到一条！是一条气态鲤鱼，不过别担心，它闻起来其实挺香的！",
		GUARDIAN_GRAVITOKINETIC = "鲤鱼鲤鱼鲤鱼！抓到一条！是一条重力动能鲤鱼！现在你明白局势有多严重了吧？",
		GUARDIAN_LIGHTNING = "鲤鱼鲤鱼鲤鱼！抓到一条！是一条闪电鲤鱼！结果真是令人震惊！",
		GUARDIAN_PROTECTOR = "鲤鱼鲤鱼鲤鱼！你抓到一条！等等，不……是它抓到了你！渔夫反倒成了鱼饵……",
		GUARDIAN_RANGED = "鲤鱼鲤鱼鲤鱼！你抓到一条！是一条远程鲤鱼！它一直在收集玻璃碎片，为这一刻做准备。",
		GUARDIAN_STANDARD = "鲤鱼鲤鱼鲤鱼！你抓到一条！这条有点普通，令人失望……最好去捶穿几堵墙来缓解一下紧张。",
		GUARDIAN_SUPPORT = "鲤鱼鲤鱼鲤鱼！你抓到了一条辅助鲤鱼！现在它在这边，你却在那边了！",
	)
