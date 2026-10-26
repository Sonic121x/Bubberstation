/// Possible places/departments to inspect
#define INSPECTION_LIST list( \
	"货运", \
	"指挥", \
	"工程", \
	"医疗", \
	"科研", \
	"服务", \
	"安保", \
)

/// List of possible decorative job titles for additional roleplay potential
#define NRI_JOB_LIST list( \
	"PSC 巡逻官", \
	"PSC 卫星巡逻官", \
	"PSC 下士巡逻官", \
	"PSC 初级巡逻官", \
	"PSC 政府调查员", \
	"PSC 现场督察", \
	"PSC 反擅离职守官", \
)

/// List of possible decorative leader job titles for additional roleplay potential
#define NRI_LEADER_JOB_LIST list( \
	"PSC 中尉警官", \
	"PSC 警佐", \
	"PSC 高级巡逻官", \
	"PSC 首席调查员", \
	"PSC 首席督察", \
)

/// Amount of items to "confiscate", lower amount
#define CONFISCATE_LOWER 10
/// Amount of items to "confiscate", higher amount
#define CONFISCATE_HIGHER 25

/// To know whether or not we have an officer already
GLOBAL_VAR(first_officer)

///NRI police patrol with a mission to find out if the fine reason is legitimate and then act from there.
/datum/pirate_gang/nri_raiders
	name = "PSC 内务委员会警察巡逻队"

	ship_template_id = "nri_raider"
	ship_name_pool = "imperial_names"

	threat_title = "联邦审计"
	threat_content = "向 %STATION 致意，这里是 %SHIPNAME 调度前哨站。 \
	鉴于近期发生的帝国法规违规行为，例如 %RESULT，以及许多其他较小问题，你的空间站已被处以 %PAYOFF 信用点罚款。 \
	你所在星区目前的帝国警察活动力度不足，因此若拒不配合，可能改为派出警察巡逻队 \
	进行第二次协商尝试、增援星区警力并进行近距离检查。泛斯拉夫联邦内务秘书，通话结束。"
	arrival_announcement = "已识别到合规船只正在接近。船只 ID 标签为 %NUMBER1-%NUMBER2-%NUMBER3。 \
	船只型号：土豆甲虫，飞行预计到达时间：最快三分钟。本船获国际法规授权执行其职责。 \
	我方已获准进入近距离轨道。友好提醒：请勿测量本船与目的地之间的距离，也请勿在本船船上或附近安装任何追踪设备， \
	除非获得许可；请勿靠近本船，除非获得许可；请勿对本船或受命船员采取任何攻击性行动，也请勿做任何此类准备， \
	因为这一切都构成启动先发制人自卫程序的理由，并可能导致道德或结构上的损害、逮捕、受伤甚至死亡。如有任何投诉，请直接提交给你的雇主。"
	possible_answers = list("接受审计并缴纳罚款。", "覆写响应系统，立即派出警察。")

	response_received = "就是这样，感谢配合。泛斯拉夫联邦内务秘书，通话结束。"
	response_too_late = "你的回复严重迟延。我们已接到指示，派出巡逻船进行第二次协商尝试，请待命。"
	response_not_enough = "你的银行余额目前不足，或系统已被覆写。我们正派出巡逻船进行第二次协商尝试，请待命。"
	announcement_color = "purple"

/datum/pirate_gang/nri_raiders/generate_message(payoff)
	var/number = rand(1,99)
	///Station name one is the most important pick and is pretty much the station's main argument against getting fined, thus it better be mostly always right.
	var/station_designation = pick_weight(list(
		"纳米传讯研究站" = 70,
		"纳米传讯补给前哨站" = 5,
		"英特戴恩制药化工厂" = 5,
		"自由特沙利联盟工程站" = 5,
		"阿古克拉尔军事基地" = 5,
		"太阳联邦大使馆" = 5,
		"泛斯拉夫联邦民用港口" = 5,
	))
	///"right" = Right for the raiders to use as an argument; usually pretty difficult to avoid.
	var/right_pick = pick(
		"该设施上极有可能出现 PSC 相关平民伤亡",
		"太阳联邦当局大幅增加拨款；忽视了 PSC 支持的下属公司合同",
		"针对 PSC 公民的不道德雇佣行为与不公平薪酬分配",
		"近期在此设施或附近附属设施的中立空间附近发现 BSA-[number] 或类似型号",
	)
	///"wrong" = Loosely based accusations that can be easily disproven if people think.
	var/wrong_pick = pick(
		"对当地生产者的支持不足",
		"该设施上未经管制地生产高斯武器",
		"太阳联邦支持的固定军事编队出现在因德西菲瑞斯地表",
		"自动违规检测系统严重故障。请联系并告知已派出的当局以解决该问题。 \
		所有可能的契约义务均已清除。对由此造成的不便我们深表歉意",
	)
	var/final_result = pick(right_pick, wrong_pick)
	var/built_threat_content = replacetext(threat_content, "%SHIPNAME", ship_name)
	built_threat_content = replacetext(built_threat_content, "%PAYOFF", payoff)
	built_threat_content = replacetext(built_threat_content, "%RESULT", final_result)
	built_threat_content = replacetext(built_threat_content, "%STATION", station_designation)
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER1", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER2", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER3", pick(GLOB.phonetic_alphabet))
	return new /datum/comm_message(threat_title, built_threat_content, possible_answers)

/datum/outfit/pirate/nri/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.remove_faction("pirate")
	equipped.add_faction("raider")

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = equipped.wear_id
	if(istype(id_card))
		id_card.registered_name = equipped.real_name
		id_card.update_icon()
		id_card.update_label()

	handlebank(equipped)

/datum/outfit/pirate/nri/officer
	name = "Pan-Slavic Field Officer"

	head = /obj/item/clothing/head/hats/colonial/nri_police
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null
	neck = /obj/item/clothing/neck/cloak/colonial/nri_police

	uniform = /obj/item/clothing/under/colonial/nri_police
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/security/nri
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider = 1,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 3,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
		/obj/item/crucifix = 1,
		/obj/item/clothing/mask/gas/nri_police = 1,
		/obj/item/modular_computer/pda/nri_police = 1,
	)
	l_pocket = /obj/item/folder/blue/nri_cop
	r_pocket = /obj/item/storage/pouch/ammo

	id = /obj/item/card/id/advanced/nri_police
	id_trim = /datum/id_trim/nri_police

/obj/item/modular_computer/pda/nri_police
	name = "\improper 联邦警察 PDA"
	icon_state = "/obj/item/modular_computer/pda/nri_police"
	device_theme = PDA_THEME_TERMINAL
	greyscale_colors = "#363655#7878f7"
	comp_light_luminosity = 6.3 //Matching a flashlight
	comp_light_color = "#5c20aa" //Simulated ultraviolet light for finding blood and :flushed:
	starting_programs = list(
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/robocontrol,
	)
	inserted_item = /obj/item/pen/fourcolor

/obj/item/card/id/advanced/nri_police
	name = "\improper 联邦警察身份卡"
	desc = "一种外观复古的卡片型号，经过改装以适配现代身份识别系统。"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_nri_police"
	assigned_icon_state = "assigned_nri_police"

/datum/id_trim/nri_police
	assignment = "泛斯拉夫外勤军官"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri_police"
	department_color = COLOR_NRI_POLICE_BLUE
	subdepartment_color = COLOR_NRI_POLICE_SILVER
	sechud_icon_state = "hud_nri_police"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)
	threat_modifier = 2 // Not as treatening as syndicate, but still potentially harmful to the station

/obj/item/gun/energy/e_gun/advtaser

/obj/effect/mob_spawn/ghost_role/human/nri_raider
	name = "泛斯拉夫突袭者休眠舱"
	desc = "很舒适。不过你总觉得，自己似乎不该出现在这里……"
	prompt_name = "一名泛斯拉夫陆战队员"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list(FACTION_RAIDER)
	you_are_text = "你是泛斯拉夫联邦特遣队的一员。"
	flavour_text = "该空间站拒绝为违反帝国法规缴纳罚款，你来此追讨欠款。通过索要资金来完成任务。通常建议采取武力手段，但这并非唯一方法。"
	important_text = "允许的种族为人类、阿库拉、特沙利与合成人。服从你的外勤军官的命令。重要提示：虽然你在游戏机制中被列为海盗，但在背景设定及其他方面你并不是。请据此进行角色扮演。"
	outfit = /datum/outfit/pirate/nri
	restricted_species = list(/datum/species/human, /datum/species/akula, /datum/species/synthetic, /datum/species/teshari)
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/nri_raider/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer
	name = "泛斯拉夫军官休眠舱"
	prompt_name = "一名泛斯拉夫外勤军官"
	mob_name = "泛斯拉夫联邦警察巡逻队外勤军官"
	outfit = /datum/outfit/pirate/nri/officer
	flavour_text = "该空间站拒绝为违反帝国法规缴纳罚款，因此你来此执行长期检查。"
	important_text = "允许的种族为人类、阿库拉、特沙利与合成人。请据此进行角色扮演。你口袋中有一份重要文件，建议你阅读并妥善保管。"

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number][GLOB.first_officer == spawned_human ? " Actual" : ""]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.mind.add_antag_datum(/datum/antagonist/cop)
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/spinwarder, source = LANGUAGE_SPAWNER)

	// if this is the first officer, keep a reference to them
	if(!GLOB.first_officer)
		GLOB.first_officer = spawned_human
		to_chat(spawned_human, span_bold("作为队伍的领袖并拥有“Actual”这一特殊代号，你有责任确保整个行动 \
			顺利进行。也就是说，不要引发星际政治丑闻，也不要造成不必要的枪战。此外，很可能还期望你 \
			亲自进行所有必要的谈判，所以请为此做好准备。"))

	to_chat(spawned_human, "[span_bold("空间站出于未知原因覆写了响应系统，保持飞船完好，与空间站沟通，\
		执行检查以判定罚款是否合法，若合法则自行设法取得资金。\
		无论如何，履行你既定的职责，并维持某种程度的星际法律与专业形象，哪怕只是做做样子。")] <br><br>\
		[span_small("另外，补充一点 OOC 说明：你的目标都不是机械上可完成的，所以不要因为没有绿字完成之类的而紧张；\
		如果你有比“完成”它们更好的计划，比如某个整活点子，最好与管理员和同事沟通，好让你能\
		做些自定义的事情。")]")
	apply_codename(spawned_human)


/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/equip(mob/living/carbon/human/spawned_human)
	. = ..()
	var/obj/item/card/id/advanced/card = spawned_human.get_idcard()
	if(GLOB.first_officer == spawned_human)
		card.assignment = pick(NRI_LEADER_JOB_LIST)
		card.trim.sechud_icon_state = "hud_nri_police_lead"
	else
		card.assignment = pick(NRI_JOB_LIST)
		card.trim.sechud_icon_state = "hud_nri_police"

	card.update_label()

/datum/map_template/shuttle/pirate/nri_raider
	prefix = "_maps/shuttles/skyrat/"
	suffix = "nri_raider"
	name = "海盗船（PSC 执法者级星舰）"
	port_x_offset = -5
	port_y_offset = 5


/area/shuttle/pirate/nri
	name = "PSC 星舰"
	forced_ambience = TRUE
	ambient_buzz = 'modular_skyrat/modules/encounters/sounds/amb_ship_01.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_skyrat/modules/encounters/sounds/alarm_radio.ogg',
						'modular_skyrat/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_loop.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_start.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_stop.ogg',
						'modular_skyrat/modules/encounters/sounds/intercom_loop.ogg')

/obj/machinery/computer/shuttle/pirate/nri
	name = "警用穿梭机控制台"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/nri
	name = "警用穿梭机导航计算机"
	desc = "用于为警用穿梭机指定精确的过境地点。"

/obj/machinery/base_alarm/nri_raider
	alarm_sound_file = 'modular_skyrat/modules/encounters/sounds/env_horn.ogg'
	alarm_cooldown = 32

/obj/machinery/porta_turret/syndicate/nri_raider
	name = "反投射物炮塔"
	desc = "一种用于点防御的自动防御炮塔，试图靠近它大概不是明智之举。"
	scan_range = 9
	shot_delay = 15
	faction = list(FACTION_RAIDER)
	icon = 'modular_skyrat/modules/encounters/icons/turrets.dmi'
	icon_state = "gun_turret"
	base_icon_state = "gun_turret"
	max_integrity = 250
	stun_projectile = /obj/projectile/bullet/ciws
	lethal_projectile = /obj/projectile/bullet/ciws
	lethal_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'
	stun_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'

/obj/machinery/porta_turret/syndicate/nri_raider/target(atom/movable/target)
	if(target)
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 2)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 3)
		return TRUE

/obj/projectile/bullet/ciws
	name = "反投射物齐射"
	icon_state = "guardian"
	damage = 15
	armour_penetration = 10

/obj/docking_port/mobile/pirate/nri_raider
	name = "PSC IAC-PV“福音”号" //Nobody will care about the translation but basically NRI Internal Affairs Collegium-Patrol Vessel
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_skyrat/modules/encounters/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_skyrat/modules/encounters/sounds/env_ship_down.ogg')

/obj/structure/plaque/static_plaque/golden/commission/ks13/nri_raider
	desc = "前 NRI 捷连季耶夫-叶尔莫拉耶夫轨道船厂，普罗维登斯高轨道，船体 OSTs-02\n“土豆甲虫”级护卫舰\n2562 年 10 月 11 日服役，舰名“信守承诺”"

/obj/machinery/computer/centcom_announcement/nri_raider
	name = "警用公告控制台"
	desc = "用于发布内务委员会优先调度报告的控制台。"
	req_access = null
	circuit = null
	command_name = "PSC 执法者级星舰电报"
	report_sound = ANNOUNCER_NRI_RAIDERS

/obj/item/storage/belt/security/nri/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
	),src)

/obj/item/storage/box/nri_survival_pack/raider
	w_class = WEIGHT_CLASS_SMALL
	desc = "一箱由联邦提供的实用应急物品。摸起来格外轻。"

/obj/item/storage/box/nri_survival_pack/raider/PopulateContents()
	new /obj/item/oxygen_candle(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/crowbar/red(src)

/obj/item/paper/fluff/nri_document
	name = "联邦警察标准操作程序"
	default_raw_text = {"<h1>泛斯拉夫联邦内务委员会边区巡逻队标准操作程序，第一部分：程序</h1><br>
	<br><br><small>说明：本指南旨在探讨泛斯拉夫联邦远征巡逻警察的法律基础。通过对规范远征巡逻警察活动的规范性法律文件进行科学分析，我们可以确定其任务与职能，以及主要活动领域。文中还探讨了泛斯拉夫联邦远征巡逻警察在活动中运用主动自卫的制度与方法，并涉及其与中央警察及政治警察的区别。此外，还关注了与保障泛斯拉夫联邦外部安全、打击普通犯罪相关问题所具有的社会实践意义。</small>
	<br><br>任何主权国家的主要职能之一都是保障国家安全，即采取措施保护个人、社会和国家免受内外威胁。通过履行这一职能，国家的领土完整与可持续发展得以保障，其国防与安全得到加强，人民的权利、自由与体面生活水平也得以保障。
	<br>在二十六世纪下半叶，远征警察在泛斯拉夫联邦的保护职能中扮演着重要角色。除了保护职能之外，它还肩负着繁重的总体管理任务。远征警察的主要任务是在互动与合作协定所规定的设施内保障并维护帝国政府的利益。与此同时，远征警察还有义务协助政治警察保障帝国的内部安全。
	<br>为了有效开展远征警察的活动，当局向独立运作的部门人员颁布了一项训令，确立了后述人员的组织结构、权利与职责。具体而言，该训令规定各分支的活动宗旨是秘密侦查并以预防、消除、揭露和起诉普通性质的犯罪行为的形式开展调查；扩大、巩固并推广国家在该星区的影响力。训令还提请关注所选派遣队的活动区域，并指出对于所有涉及政治性质案件的信息，派遣队负责人必须立即予以记录。训令中另有一处值得注意：远征警察的首长对最高司令部的隶属程度极低，实行自治。
	<br>该训令界定了独立分支的自卫边界。具体而言，明确了若干清晰要件，包括合作空间站方面存在明显侵略行为或违法行动的准备，且已为其行动做出必要准备。不过，一切完全取决于巡逻队指定的最高级别人员。此外，还界定了发出侵略信号的原则。信号方式、代码术语等内容将在本文件集的下一部分中讨论。
	<br><br>根据现行的 PSC 对外关系以及 PSC 内务委员会条例，必须执行以下程序，以尽量降低首批响应巡逻队的伤亡风险，并提高空间站与巡逻队之间的沟通机会：
	<br>1. 确保空间站的护卫派遣人数仅限每两名主管配一人；若所有主管均受邀，在场者最多三人。该名单包括个人保护专家，即蓝盾、红盾；安保人员；受雇的站外雇佣兵；持有武器的船员或其他民兵；持有武器的动物，等等；
	<br>2. 确保空间站的护卫派遣位于你正前方；并为你和同事留有一条清晰的撤离路线。若你的指挥官认为有必要，允许加装额外加固设施或路障，以提高你面对不可信人员时的生存几率；
	<br>3. 确保空间站的指挥层与安保／军事／防御力量未经你方指挥官许可，不得检查你的飞船，也不得靠近飞船。建议留一名军官担任飞船看管人，以尽量减少政府财产损失，并确保外勤巡逻效率最大化；
	<br>4. 确保空间站的安保／军事／防御力量没有利用你船上配备的<small>（需组装）</small>摄像控制台准备突袭。如有需要，可通过飞船预装的空间站广播系统点名提醒他们，提醒其已投入的资金，或空间站与政府的关系等等；
	<br>5. 确保飞船及任何军官均未在未经第三方说明内容、且事后未由任一军官重新检查的情况下接收任何包裹、信封、信件或其他物件，以将炸弹袭击、传送或其他恐怖行为的可能性降到最低。若上述物件在未启动下列程序的情况下被接收，必须立即处置该物件并向指挥官报告。
	<br><br>根据近期观察，尽管下列清单在修订前尚未明确，纳米传讯公司也官方未予披露，但你仍可能成为其新近发明的受害者：一种高精度高速粒子加速器——蓝空间火炮。该武器锁定于某些全球定位系统频率，按照国规，这些系统被嵌入船体。该武器极擅长摧毁小型战斗机乃至巡逻护卫舰，并能重创攻击护卫舰；足以将你的制式护卫舰劈成两半。因此，为尽量减少伤亡并确保你的安全，本指南为你提供规避该武器所需的信息。
	<br>要执行闪避机动，你必须：
	<br>1. 为飞船使用导航控制台锁定太空中的稳定位置；
	<br>2. 在蓝空间火炮开始充能的瞬间，启动飞船推进器；
	<br>3. 由此躲开火炮射击。其设计锁定位置，仅对静止或特别缓慢的目标有效，因此你可离开目标位置。
	<br><b>若确认有蓝空间火炮向你所在位置开火、你在站期间发生任何其他未经授权的蓝空间火炮射击、有人威胁对派遣队使用蓝空间火炮，或出现全星区蓝空间火炮射击公告，则必须将其处置，因为这直接表明了对派遣队及外国的侵略意图。</b>
	<br><br>蓝空间火炮是脆弱的机械装置，因此在其主炮任一部件上方实施定向爆炸即可将其永久瘫痪。为此，你需要一块标准配发的 C4 复合炸药，并严格遵循以下说明：
	<br>要摧毁一门 BSA 火炮，你必须：
	<br>1. 接近主炮，其外观与设计通常类似巨大的火炮阵地；
	<br>2. 在其上安放 C4 塑胶炸药，最好加装信号器以达到最高效率，或设置较短的爆炸计时；
	<br>3. 离开爆炸半径及火炮本身，并在过程中对其他火炮部件造成额外破坏与损伤。建议这样做，因为这会拖延任何重建该火炮的尝试。
	<br><b>此后，若需执行下列任一程序，该空间站应被视为敌对区域；你完全获准在无需指挥官批准的情况下执行先发制人自卫程序。</b>
	<br><br>若下列任一条件未得到满足，或在发生蓝空间火炮射击的情况下，你获准向指挥官请求启动先发制人自卫程序；该程序随后允许你使用任何可用或以其他方式获得的装备，解除空间站安保力量的行动能力并逮捕他们。
	<br><small>因此，帝国境内独立分支的设立使这些单位主导了整个警察机关打击普通犯罪的活动。在其成立之前，打击人身犯罪的任务是当地行星巡逻队人员的直接职责，特殊情况下则由行星卫队承担。独立部门的人员在刑事犯罪侦查中与行星警察人员享有同等权利，因为他们依据同样的现行规范性法律文件行事。依照最新训令制定的法律条款更为具体地界定了独立部门的目标、任务、内部结构以及开展行动侦查的程序。与此同时，总体上并未改变巡逻队组织结构的原则，因此它们在自身管辖领土内的活动仍部分受到限制。对此，它们无法在被分配到的空间站之外开展行动搜查活动。</small>
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>印制：泛斯拉夫联邦内务委员会，仅供教育与参考之用。</b></p></span>"}

/obj/item/paper/fluff/nri_document_two
	name = "联邦警察代码语"
	default_raw_text = {"<h1>泛斯拉夫联邦内务委员会边区巡逻队标准操作程序，第二部分：密码与代码词</h1><br>
	<br><br><small>说明：本指南旨在探讨泛斯拉夫联邦远征巡逻警察的通信基础。对旧时警察巡逻代码语的科学分析，使我们得以重现其效率水平，并尽可能减少向平民及可能嫌疑人泄露信息的可能。</small>
	<br>为更好地对信号词进行编码并尽量减少信息泄露，每个星区的独立分遣队将收到一份特定信号词及其他术语的清单，具体见下列清单。每次出发前，建议通读以巩固记忆；行动期间，建议使用这些词取代惯常行话。清单如下：
	<br>为了有效开展远征警察的活动，当局向独立运作的部门人员颁布了一项训令，确立了后述人员的组织结构、权利与职责。具体而言，该训令规定各分支的活动宗旨是秘密侦查并以预防、消除、揭露和起诉普通性质的犯罪行为的形式开展调查；扩大、巩固并推广国家在该星区的影响力。训令还提请关注所选派遣队的活动区域，并指出对于所有涉及政治性质案件的信息，派遣队负责人必须立即予以记录。训令中另有一处值得注意：远征警察的首长对最高司令部的隶属程度极低，实行自治。
	<br><small>10-0 = 小心谨慎；
	<br>10-1 = 因处理损伤而暂停执勤；
	<br>10-1s = 因进食而暂停执勤；
	<br>10-1r = 因休息而暂停执勤；
	<br>10-2 = 接收清晰；
	<br>10-4 = 明白；
	<br>10-8 = 正在执勤；
	<br>10-9 = 解除戒备或待命；
	<br>10-14 = 车队护送任务，或要求继续前进；
	<br>10-15 = 已拘押囚犯；
	<br>10-20 = 位置；
	<br>10-25 = 当面报到；
	<br>10-29 = 符合规则或条例；
	<br>10-30 = 不符合规则或条例；
	<br>10-65 = 需要协助；
	<br>10-90 = 发现动物；
	<br>10-91 = 发现外星生物；
	<br>10-92 = 发现类人生物；
	<br>10-93 = 发现异形；
	<br>10-94 = 发现未知生命体；
	<br>10-90 至 10-94 加 “d” 修饰（例如 10-90d）= 生命体已死亡；
	<br>10-90 至 10-94 加 “w” 修饰（例如 10-92w）= 生命体受伤；
	<br>10-90 至 10-94 加 “r” 修饰（例如 10-93r）= 生命体拒捕；
	<br>10-97 = 已到达现场；
	<br>10-99 = 最后一名在岗警官；
	<br>10-103 = 骚乱；
	<br>10-107 = 可疑人员；
	<br>10-108 = 警官倒下；
	<br>10-40 = 增援；
	<br>10-41 = 撤离；
	<br>10-42 = 医疗；
	<br>10-43 = 损管；
	<br>10-99 = 警官需要立即支援；
	<br>12-40 = 警官请求格杀勿论命令。</small>
	<br><small>因此，帝国境内独立分支的设立使这些单位主导了整个警察机关打击普通犯罪的活动。在其成立之前，打击人身犯罪的任务是当地行星巡逻队人员的直接职责，特殊情况下则由行星卫队承担。独立部门的人员在刑事犯罪侦查中与行星警察人员享有同等权利，因为他们依据同样的现行规范性法律文件行事。依照最新训令制定的法律条款更为具体地界定了独立部门的目标、任务、内部结构以及开展行动侦查的程序。与此同时，总体上并未改变巡逻队组织结构的原则，因此它们在自身管辖领土内的活动仍部分受到限制。对此，它们无法在被分配到的空间站之外开展行动搜查活动。</small>
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>印制：泛斯拉夫联邦内务委员会，仅供教育与参考之用。</b></p></span>"}

/obj/item/paper/fluff/nri_police
	name = "匆忙印制的便条"
	default_raw_text = {"嘿，警官，我们没能给你弄到一艘像样的军用护卫舰——你也知道，就是那些该死的官僚，张口闭口都是许可申请和文书——所以只能用这艘警用护卫舰凑合了。
	<br> 它本来就不是为任何形式的长期部署而设计的，也不适合干比痛揍一群小混混更激烈的事，所以请做好频繁停电和突击装备严重不足的准备。
	<br> 我们做了些快速改装，让它更适合军用，还偷偷给你塞了些防御装备和军用级医疗设备来平衡一下。另外还有一些冲锋枪，反正它们“退役报废”起来方便得很。眼下应该够用了。
	<br> 值得一提的是，你的第四名陆战队员——那位维护人员——去度假了。这家伙最近一直相当紧张，让他好好休息一下也是应该的——你躺在休眠舱里的这段时间，一直是他维护这艘船。无论如何，这不应影响你的表现。
	<br> 至于那挺坏掉的 Krinkov，我们目前无能为力。只能用警察的装备了，反正你也不是来跟太阳联邦的人打仗的。
	<br> 还有，看在上帝和永恒女皇的份上——别把这次任务搞成一场枪战。这个星区再也承受不起更多伤亡了，尤其是我们大部分军队都还在前线。
	<br>
	<br> 别搞砸了，
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>国防委员会船务长，阿库拉承包商，辛伦·坎特斯。</b></p></span>"}

/obj/item/folder/blue/nri_cop
	name = "联邦警察标准操作程序"

/obj/item/folder/blue/nri_cop/Initialize(mapload)
	. = ..()
	new /obj/item/paper/fluff/nri_document(src)
	new /obj/item/paper/fluff/nri_document_two(src)
	update_appearance()

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow

/obj/machinery/shuttle_scrambler/nri
	name = "系统瘫痪器"
	desc = "这堆机器能让补给线路彻底停摆。可以关闭，但不会吸取任何资金。想吸钱就自己动手，懒鬼。"
	siphon_per_tick = 0

/obj/machinery/shuttle_scrambler/nri/toggle_on(mob/user)
	SSshuttle.registerTradeBlockade(src)
	AddComponent(/datum/component/gps, "NRI 星舰")
	active = TRUE
	to_chat(user,span_notice("你将 [src] [active ? "开启" : "关闭"]。"))
	to_chat(user,span_warning("干扰信号现在可以被 GPS 追踪。"))
	START_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/process()
	if(active)
		if(is_station_level(z))
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				var/siphoned = min(D.account_balance,siphon_per_tick)
				D.adjust_money(-siphoned)
				credits_stored += siphoned
		else
			return
	else
		STOP_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/interact(mob/user)
	if(active)
		var/deactivation_response = tgui_alert(user,"关闭瘫痪器？", "瘫痪器", list("是", "取消"))
		if(deactivation_response != "是")
			return
		if(!active|| !user.can_perform_action(src))
			return
		toggle_off(user)
		update_appearance()
		send_notification()
		to_chat(user,span_notice("你将 [src] [active ? "开启" : "关闭"]。"))
		return
	var/scramble_response = tgui_alert(user, "开启瘫痪器可能会疏远民众，并会让穿梭机可被 GPS 追踪。你确定要这么做吗？", "瘫痪器", list("是", "取消"))
	if(scramble_response != "是")
		return
	if(active || !user.can_perform_action(src))
		return
	toggle_on(user)
	update_appearance()
	send_notification()
	to_chat(user,span_notice("你将 [src] [active ? "开启" : "关闭"]。"))
	return


/obj/machinery/shuttle_scrambler/nri/send_notification()
	if(active)
		priority_announce("我们正在拦截当前及未来所有补给运送，直到你方更配合调度处为止。所以，请务必配合。","PSC 内务委员会总部",ANNOUNCER_NRI_RAIDERS,"Priority", color_override = "purple")
	else
		priority_announce("我们已收到停止封锁的信号；你方可以再度自由地继续之前在做的事了。","PSC 内务委员会总部",ANNOUNCER_NRI_RAIDERS,"Priority", color_override = "purple")

/datum/antagonist/cop
	name = "\improper 联邦警察"
	//Even if their goal's almost a complete antithesis to what pirates normally do, their spawn is, well, done via pirate code.
	pref_flag = ROLE_SPACE_PIRATE
	roundend_category = "NRI 警察"
	antagpanel_category = "联邦警察"
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	suicide_cry = "天佑女皇！！"
	///Team datum for admin tracking
	var/datum/team/cop/crew

/datum/antagonist/cop/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/cop/get_team()
	return crew

/datum/antagonist/cop/create_team(datum/team/cop/new_team)
	if(!new_team)
		for(var/datum/antagonist/cop/cop in GLOB.antagonists)
			if(!cop.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [cop]")
				continue

			if(cop.crew)
				crew = cop.crew
				return

		// No existing team was found, time to create one.
		crew = new /datum/team/cop
		crew.forge_objectives()
		return

	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization: [new_team.type].")

	crew = new_team

/datum/antagonist/cop/on_gain()
	if(crew)
		objectives |= crew.objectives

	return ..()

/datum/antagonist/cop/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/spinwarder, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)

/datum/antagonist/cop/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	owner_mob.remove_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/spinwarder, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)
	return ..()

/datum/team/cop
	name = "\improper 联邦警察巡逻队"

/datum/team/cop/proc/forge_objectives()
	add_objective(new /datum/objective/policing)
	add_objective(new /datum/objective/inspect_area)
	add_objective(new /datum/objective/survey)
	add_objective(new /datum/objective/steal_n_of_type/contraband)
	add_objective(new /datum/objective/dock)
	add_objective(new /datum/objective/survive)

	for(var/datum/mind/member_mind in members)
		var/datum/antagonist/cop/cop = member_mind.has_antag_datum(/datum/antagonist/cop)

		if(!cop)
			continue

		cop.objectives |= objectives

/datum/objective/policing
	name = "维持治安"
	explanation_text = "联系空间站进行检查。在船员之间分配职责。尽量减少平民伤亡。"
	martyr_compatible = TRUE

/datum/objective/inspect_area
	name = "检查部门"
	explanation_text = "检查特定部门，确保其符合我们的规范。建议格外仔细并挑剔一些。"
	///Area picked for an entirely roleplay objective.
	var/inspection_area
	martyr_compatible = TRUE

/datum/objective/inspect_area/New(text)
	. = ..()
	inspection_area = pick(INSPECTION_LIST)

/datum/objective/inspect_area/update_explanation_text()
	..()
	if(inspection_area)
		explanation_text = "检查[inspection_area]部门，确保其符合我们的规范。建议格外仔细并挑剔一些。"
	else
		explanation_text = "对空间站进行全面检查，确保其符合你能想到的任何宽松规范。"

/datum/objective/survey
	name = "民意调查"
	martyr_compatible = TRUE
	admin_grantable = TRUE
	///Area picked for an entirely roleplay objective.
	var/survey_area

/datum/objective/survey/New(text)
	. = ..()
	survey_area = pick(INSPECTION_LIST)

/datum/objective/survey/update_explanation_text()
	..()
	if(survey_area)
		explanation_text = "在[survey_area]部门持续执行犯罪预防与公民调查程序。在指定部门预防犯罪，并开展公众调查以收集人们对各类事务的意见。"
	else
		explanation_text = "在空间站各处持续执行犯罪预防与公民调查程序。在周边区域预防犯罪，并开展公众调查以收集人们对各类事务的意见。"

/datum/objective/steal_n_of_type/contraband
	name = "没收违禁品"
	explanation_text = "没收至少若干件违禁品。毒品、非法武器、护甲或任何种类的装备。"

/datum/objective/steal_n_of_type/contraband/New()
	. = ..()
	amount = rand(CONFISCATE_LOWER, CONFISCATE_HIGHER)
	explanation_text = "没收至少 [amount] 件违禁品。毒品、非法武器、护甲或任何种类的装备。"
	update_explanation_text()
	return

/datum/objective/steal_n_of_type/contraband/check_completion()
	return completed //I am letting them roleplay this out, just like the other objectives.

/datum/objective/dock
	name = "停靠"
	explanation_text = "停靠到空间站所在星区，或尽量停留在同一星区，以延长你的现场存在时间。"
	martyr_compatible = TRUE

/datum/objective/dock/New()
	. = ..()
	explanation_text = "停靠到 [station_name()] 所在星区，或尽量停留在同一星区，以延长你的现场存在时间。"
	update_explanation_text()
	return


#undef INSPECTION_LIST
#undef NRI_JOB_LIST
#undef NRI_LEADER_JOB_LIST
#undef CONFISCATE_LOWER
#undef CONFISCATE_HIGHER
