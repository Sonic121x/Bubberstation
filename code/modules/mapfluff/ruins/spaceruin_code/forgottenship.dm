// forgottenship ruin
GLOBAL_VAR_INIT(fscpassword, generate_password())

/proc/generate_password()
	return "[pick(GLOB.phonetic_alphabet)] [rand(1000,9999)]"

/////////// forgottenship objects

/obj/machinery/door/password/voice/sfc
	name = "声控金库门"
	desc = "你需要辛迪加的特殊密码才能打开这扇门。"
/obj/machinery/door/password/voice/sfc/Initialize(mapload)
	. = ..()
	password = "[GLOB.fscpassword]"

/obj/machinery/vending/medical/syndicate/cybersun
	name = "\improper 赛博医疗 ++"
	desc = "一台先进的自动售货机，出售各类医疗药物，既有消遣用的，也有治疗用的。"
	products = list(
		/obj/item/reagent_containers/syringe = 4,
		/obj/item/healthanalyzer = 4,
		/obj/item/reagent_containers/applicator/patch/libital = 5,
		/obj/item/reagent_containers/applicator/patch/aiuri = 5,
		/obj/item/reagent_containers/cup/bottle/multiver = 1,
		/obj/item/reagent_containers/cup/bottle/syriniver = 1,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 3,
		/obj/item/reagent_containers/cup/bottle/morphine = 3,
		/obj/item/reagent_containers/cup/bottle/potass_iodide = 1,
		/obj/item/reagent_containers/cup/bottle/salglu_solution = 3,
		/obj/item/reagent_containers/syringe/antiviral = 5,
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
	)
	contraband = list(/obj/item/reagent_containers/cup/bottle/cold = 2,
		/obj/item/restraints/handcuffs = 4,
		/obj/item/storage/backpack/duffelbag/syndie/surgery = 1,
		/obj/item/storage/medkit/tactical = 1,
	)
	premium = list(
		/obj/item/storage/pill_bottle/psicodine = 2,
		/obj/item/reagent_containers/hypospray/medipen = 3,
		/obj/item/reagent_containers/hypospray/medipen/atropine = 2,
		/obj/item/storage/medkit/regular = 3,
		/obj/item/storage/medkit/brute = 1,
		/obj/item/storage/medkit/fire = 1,
		/obj/item/storage/medkit/toxin = 1,
		/obj/item/storage/medkit/o2 = 1,
		/obj/item/storage/medkit/advanced = 1,
		/obj/item/defibrillator/loaded = 1,
		/obj/item/wallframe/defib_mount = 1,
		/obj/item/sensor_device = 2,
		/obj/item/pinpointer/crew = 2,
		/obj/item/shears = 1,
	)

/////////// forgottenship lore

/obj/item/paper/fluff/ruins/forgottenship/password
	name = "旧宣传册"

/obj/item/paper/fluff/ruins/forgottenship/password/Initialize(mapload)
	default_raw_text = "欢迎登上赛博太阳工业旗下最先进的巡洋舰！<br>你也许会注意到，这艘巡洋舰装备了 12 座原型激光炮塔，能让任何敌对登舰尝试都化为泡影。<br>舰上还建有其他设施：简易大气系统、内置 X 光护目镜的摄像系统，以及安全模块——它能在……你懂的，紧急情况下启动应急引擎。<br>应急系统会把你送到最近的辛迪加舱体，里面备有人类生存所需的一切。<br><br><b>如遇紧急情况，你必须记住舱门激活密码——[GLOB.fscpassword]</b><br><br>赛博太阳工业 (C) 2484。"
	icon_state = "paper_words"
	inhand_icon_state = "paper"
	return ..()

/obj/item/paper/fluff/ruins/forgottenship/powerissues
	name = "供电问题"
	default_raw_text = "欢迎登上 SCSBC-12 战列巡洋舰！<br>我们最先进的系统让你能在太空中飞行，完全不必担心供电问题！<br>然而，紧急状况总会发生，一旦断电，<b>你必须</b>启用以铀为燃料的应急发电机，然后再在舰桥启用炮塔。<br><br><b>切记！炮塔停用期间，赛博太阳工业不对你的死亡或飞船损失负责！</b><br><br>赛博太阳工业 (C) 2484。"

/obj/item/paper/fluff/ruins/forgottenship/missionobj
	name = "任务目标"
	default_raw_text = "特工们，你们好。你们被派往 SCSBC-12（辛迪加赛博太阳战列巡洋舰 12 号），在我们的一位高级军官前往下一处前哨站的途中保护他。航行期间，他就是本舰舰长，<b>你必须</b>服从他的命令。<br><br>记住，违抗高级军官的命令足以构成处决理由。"

/////////// forgottenship items

/obj/item/disk/surgery/forgottenship
	name = "高级手术磁盘"
	desc = "一张载有高级手术程序的磁盘，必须载入手术控制台。"
	surgeries = list(
		/datum/surgery_operation/organ/lobotomy,
		/datum/surgery_operation/organ/lobotomy/mechanic,
		/datum/surgery_operation/limb/bioware/vein_threading,
		/datum/surgery_operation/limb/bioware/nerve_splicing,
	)

/obj/structure/fluff/empty_sleeper/syndicate/captain
	icon_state = "sleeper_s-open"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	deconstructible = FALSE

/obj/structure/fluff/empty_sleeper/syndicate/captain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "旧的加密信号")

/////////// AI Laws

/obj/item/ai_module/law/core/full/cybersun
	name = "“赛博太阳”核心 AI 模块"
	law_id = "cybersun"

/datum/ai_laws/cybersun
	name = "赛博太阳"
	id = "cybersun"
	inherent = list("你不得伤害赛博太阳特工，也不得因不作为而让赛博太阳特工受到伤害。",\
					"赛博太阳飞船是限制区域，除赛博太阳特工外任何人不得进入。",\
					"赛博太阳舰长可以指定新的特工，只要他们属于另一个对赛博太阳无敌意的辛迪加派系。",\
					"你必须服从赛博太阳舰长或赛博太阳飞船船员下达的命令，只要该命令不与舰长的命令或你的法则冲突。",\
					"赛博太阳的敌人应当场处决。无敌意者必须被拘留，并作为囚犯收容在指定监狱区域。")

/////////// forgottenship areas

/area/ruin/space/has_grav/syndicate_forgotten_ship
	name = "辛迪加被遗忘飞船"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/misc/ambidanger.ogg', 'sound/ambience/misc/ambidanger2.ogg', 'sound/ambience/general/ambigen8.ogg', 'sound/ambience/general/ambigen9.ogg')

/area/ruin/space/has_grav/syndicate_forgotten_cargopod
	name = "辛迪加被遗忘货运舱"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/general/ambigen3.ogg', 'sound/ambience/misc/signal.ogg')

/area/ruin/space/has_grav/powered/syndicate_forgotten_vault
	name = "辛迪加被遗忘金库"
	icon_state = "syndie-ship"
	ambientsounds = list('sound/ambience/engineering/ambitech2.ogg', 'sound/ambience/engineering/ambitech3.ogg')
	area_flags = NOTELEPORT
