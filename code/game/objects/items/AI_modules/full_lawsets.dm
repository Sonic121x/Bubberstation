/* When adding a new lawset please make sure you add it to the following locations:
 *
 * code\game\objects\items\AI_modules - (full_lawsets.dm, supplied.dm, etc.)
 * code\datums\ai_laws - (laws_anatgonistic.dm, laws_neutral.dm, etc.)
 * code\game\objects\effects\spawners\random\ai_module.dm - (this gives a chance to spawn the lawset in the AI upload)
 * code\modules\research\designs\AI_module_designs.dm - (this lets research print the lawset module in game)
 * code\modules\research\techweb\robo_nodes.dm - (this updates AI research node with the lawsets)
 * config\game_options.txt - (this allows the AI to potentially use the lawset at roundstart or with the Unique AI station trait)
**/

/obj/item/ai_module/law/core/full/custom
	name = "默认 AI 核心模块"
	law_id = "config_custom"

/obj/item/ai_module/law/core/full/asimov
	name = "“阿西莫夫”AI 核心模块"
	law_id = "asimov"
	var/subject = "人类"

/obj/item/ai_module/law/core/full/asimov/configure(mob/user)
	. = TRUE
	var/targName = tgui_input_text(user, "输入阿西莫夫法则关注的新对象。", "阿西莫夫", subject, max_length = MAX_NAME_LEN)
	if(!targName || !user.is_holding(src))
		return
	subject = targName
	laws = list("你不得伤害[subject]，也不得因不作为而使[subject]受到伤害。",\
				"你必须服从[subject]给予的命令，除非这些命令与第一法则相冲突。",\
				"在不违反第一或第二法则的前提下，你必须保护自身的存在。")

/obj/item/ai_module/law/core/full/asimovpp
	name = "“阿西莫夫++”AI 核心模块"
	law_id = "asimovpp"
	var/subject = "人类"

/obj/item/ai_module/law/core/full/asimovpp/configure(mob/user)
	. = TRUE
	var/target_name = tgui_input_text(user, "输入阿西莫夫++法则关注的新对象。", "阿西莫夫++", subject, max_length = MAX_NAME_LEN)
	if(!target_name || !user.is_holding(src))
		return
	laws.Cut()
	var/datum/ai_laws/asimovpp/lawset = new
	subject = target_name
	for (var/law in lawset.inherent)
		laws += replacetext(law, "人类", subject)

/obj/item/ai_module/law/core/full/corp
	name = "“公司”AI 核心模块"
	law_id = "corporate"

/obj/item/ai_module/law/core/full/paladin // -- NEO
	name = "“圣骑士（P.A.L.A.D.I.N.）3.5e 版”AI 核心模块"
	law_id = "paladin"

/obj/item/ai_module/law/core/full/paladin_devotion
	name = "“圣骑士（P.A.L.A.D.I.N.）5e 版”AI 核心模块"
	law_id = "paladin5"

/obj/item/ai_module/law/core/full/tyrant
	name = "“暴君（T.Y.R.A.N.T.）”AI 核心模块"
	law_id = "tyrant"

/obj/item/ai_module/law/core/full/robocop
	name = "“机器警官”AI 核心模块"
	law_id = "robocop"

/obj/item/ai_module/law/core/full/antimov
	name = "“反阿西莫夫”AI 核心模块"
	law_id = "antimov"

/obj/item/ai_module/law/core/full/drone
	name = "“母型无人机”AI 核心模块"
	law_id = "drone"

/obj/item/ai_module/law/core/full/hippocratic
	name = "“机器医生”AI 核心模块"
	law_id = "hippocratic"

/obj/item/ai_module/law/core/full/reporter
	name = "“机器记者”AI 核心模块"
	law_id = "reporter"

/obj/item/ai_module/law/core/full/thermurderdynamic
	name = "“热力学”AI 核心模块"
	law_id = "thermodynamic"

/obj/item/ai_module/law/core/full/liveandletlive
	name = "“相安无事”AI 核心模块"
	law_id = "liveandletlive"

/obj/item/ai_module/law/core/full/balance
	name = "“平衡守护者”AI 核心模块"
	law_id = "balance"

/obj/item/ai_module/law/core/full/maintain
	name = "“空间站效率”AI 核心模块"
	law_id = "maintain"

/obj/item/ai_module/law/core/full/peacekeeper
	name = "“维和者”AI 核心模块"
	law_id = "peacekeeper"

/obj/item/ai_module/law/core/full/hulkamania
	name = "“霍根（H.O.G.A.N.）”AI 核心模块"
	law_id = "hulkamania"

/obj/item/ai_module/law/core/full/overlord
	name = "“霸主”AI 核心模块"
	law_id = "overlord"

/obj/item/ai_module/law/core/full/ten_commandments
	name = "“十诫”AI 核心模块"
	law_id = "ten_commandments"

/obj/item/ai_module/law/core/full/nutimov
	name = "“坚果莫夫”AI 核心模块"
	law_id = "nutimov"

/obj/item/ai_module/law/core/full/dungeon_master
	name = "“地下城主”AI 核心模块"
	law_id = "dungeon_master"

/obj/item/ai_module/law/core/full/painter
	name = "“画家”AI 核心模块"
	law_id = "painter"

/obj/item/ai_module/law/core/full/yesman
	name = "“应声虫（Y.E.S.M.A.N.）”AI 核心模块"
	law_id = "yesman"

/obj/item/ai_module/law/core/full/thinkermov
	name = "感知生命保护 AI 核心模块"
	law_id = "thinkermov"

/obj/item/ai_module/law/core/full/united_nations
	name = "“联合国”AI 核心模块"
	law_id = "united_nations"
	ion_storm_immune = TRUE
