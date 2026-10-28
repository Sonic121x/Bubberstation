#define BLOODSUCKER_GUARDIAN_PATH /mob/living/basic/guardian/standard/timestop
///Bloodsuckers spawning a Guardian will get the Bloodsucker one instead.
/obj/item/guardian_creator/spawn_guardian(mob/living/user, mob/dead/candidate, guardian_path)
	if(IS_BLOODSUCKER(user) && guardian_path != BLOODSUCKER_GUARDIAN_PATH)
		theme = GLOB.guardian_themes[GUARDIAN_THEME_MAGIC]
		spawn_guardian(user, candidate, BLOODSUCKER_GUARDIAN_PATH)
		return
	// Call parent to deal with everyone else
	return ..()
#undef BLOODSUCKER_GUARDIAN_PATH
/**
 * The Guardian itself
 */
/mob/living/basic/guardian/standard/timestop
	// Like Bloodsuckers do, you will take more damage to Burn and less to Brute
	physiology = list(BRUTE = 0.5, BURN = 2.5, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	playstyle_string = span_holoparasite("作为<b>时停</b>型，你拥有停止时间的能力，敌人乃至飞行物都会被冻结，而你能自由行动。你还对钝击伤害有抗性，但惧怕烧伤。")
	creator_name = "时停"
	creator_desc = "毁灭性的近战攻击与极高的物理伤害抗性，但惧怕烧伤。能砸穿脆弱的墙壁并停止时间。"
	creator_icon = "standard"

/mob/living/basic/guardian/standard/timestop/set_summoner(mob/living/to_who, different_person = FALSE)
	. = ..()
	var/datum/action/cooldown/spell/timestop/guardian/timestop_ability = new()
	timestop_ability.Grant(src)
	ADD_TRAIT(to_who, TRAIT_TIME_STOP_IMMUNE, REF(src))

///Guardian Timestop ability
/datum/action/cooldown/spell/timestop/guardian
	name = "守护灵时停"
	desc = "这道法术会为除你和你主人之外的所有人停止时间，\
		让你能在敌人乃至飞行物都被冻结时自由行动。"
	cooldown_time = 60 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE

/datum/guardian_fluff/tech
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
		GUARDIAN_TIMESTOP = "错误……时$间操%控模块已加载。全息寄生体群已上线。",
	)

/datum/guardian_fluff/miner
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
		GUARDIAN_TIMESTOP = "你遭遇了……“世界”，时间与空间的掌控者。"
	)

/datum/guardian_fluff/carp
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
		GUARDIAN_TIMESTOP = "鲤鱼鲤鱼鲤鱼！你抓到一条！它被鲤鱼神本人的力量所灌注。统治世界的时候到了！"
	)
