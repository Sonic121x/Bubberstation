/obj/item/clothing/accessory/medal
	name = "铜质奖章"
	desc = "一枚铜质奖章。"
	icon_state = "bronze"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	resistance_flags = FIRE_PROOF
	/// Sprite used for medalbox
	var/medaltype = "medal"
	/// Has this been use for a commendation?
	var/commendation_message
	/// Who was first given this medal
	var/awarded_to
	/// Who gave out this medal
	var/awarder

/obj/item/clothing/accessory/medal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/pinnable_accessory, on_pre_pin = CALLBACK(src, PROC_REF(provide_reason)))

/// Input a reason for the medal for the round end screen
/obj/item/clothing/accessory/medal/proc/provide_reason(mob/living/carbon/human/distinguished, mob/user)
	commendation_message = tgui_input_text(user, "此次表彰的理由是什么？纳米传讯将会记录在案。", "表彰", max_length = 140)
	return !!commendation_message

/obj/item/clothing/accessory/medal/try_attach(obj/item/clothing/under/attach_to, mob/living/attacher)
	var/mob/living/distinguished = attach_to.loc
	if(isnull(attacher) || !istype(distinguished) || distinguished == attacher || awarded_to)
		// You can't be awarded by nothing, you can't award yourself, and you can't be awarded someone else's medal
		return ..()

	awarder = attacher.real_name
	awarded_to = distinguished.real_name

	update_appearance(UPDATE_DESC)
	add_memory_in_range(distinguished, 7, /datum/memory/received_medal, protagonist = distinguished, deuteragonist = attacher, medal_type = src, medal_text = commendation_message)
	distinguished.log_message("获得了由 <b>[key_name(attacher)]</b> 颁发的以下表彰：[commendation_message]", LOG_GAME, color = "green")
	message_admins("<b>[key_name_admin(distinguished)]</b> 获得了由 <b>[key_name_admin(attacher)]</b> 颁发的以下表彰：[commendation_message]")
	GLOB.commendations += "[awarder] 授予 <b>[awarded_to]</b> <span class='medaltext'>[name]</span>！ \n- [commendation_message]"
	SSblackbox.record_feedback("associative", "commendation", 1, list("commender" = "[awarder]", "commendee" = "[awarded_to]", "medal" = "[src]", "reason" = commendation_message))

	return ..()

/obj/item/clothing/accessory/medal/update_desc(updates)
	. = ..()
	if(commendation_message && awarded_to && awarder)
		desc += span_info("<br>铭文写道：[commendation_message] —— 授予 [awarded_to]，授予人 [awarder]")

/obj/item/clothing/accessory/medal/conduct
	name = "杰出行为奖章"
	desc = "一枚因杰出行为而授予的铜质奖章。尽管是一项殊荣，但这是纳米传讯颁发的最基础的奖项。通常由船长授予其船员。"

/obj/item/clothing/accessory/medal/bronze_heart
	name = "铜心奖章"
	desc = "一枚因牺牲而授予的铜质心形奖章。它通常被追授，或授予在执行任务中身受重伤者。"
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/ribbon
	name = "绶带"
	desc = "一条绶带。"
	icon_state = "cargo"

/obj/item/clothing/accessory/medal/ribbon/cargo
	name = "\"本班次最佳货运技师\"奖"
	desc = "此奖项仅授予那些始终恪尽职守、秉承货运共和国最高传统的货运技师。"

/obj/item/clothing/accessory/medal/silver
	name = "银质奖章"
	desc = "一枚银质奖章。"
	icon_state = "silver"
	medaltype = "medal-silver"
	custom_materials = list(/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/silver/valor
	name = "英勇奖章"
	desc = "一枚授予表现非凡英勇行为的银质奖章。"

/obj/item/clothing/accessory/medal/silver/security
	name = "强悍安保奖"
	desc = "为表彰在保卫纳米传讯商业利益中的杰出战斗表现与牺牲而颁发的奖项。通常授予安保人员。"

/obj/item/clothing/accessory/medal/silver/excellence
	name = "\proper 人事主管卓越领域杰出成就奖"
	desc = "纳米传讯的词典将卓越定义为“卓越的品质或状态”。此奖授予那些符合该定义的少数船员。"

/obj/item/clothing/accessory/medal/silver/bureaucracy
	name = "\improper 行政卓越奖章"
	desc = "为表彰在受雇于纳米传讯期间所提供的模范管理服务而授予。"

/obj/item/clothing/accessory/medal/gold
	name = "金质奖章"
	desc = "一枚尊贵的金质奖章。"
	icon_state = "gold"
	medaltype = "medal-gold"
	custom_materials = list(/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/med_medal
	name = "模范表现奖章"
	desc = "一枚授予在医疗部门中表现出杰出行为、业绩与主动性的奖章。"
	icon_state = "med_medal"

/obj/item/clothing/accessory/medal/med_medal2
	name = "医学卓越奖章"
	desc = "一枚授予在医疗部门中表现出超越一切期待的传奇业绩、能力与主动性的奖章。"
	icon_state = "med_medal2"

/obj/item/clothing/accessory/medal/gold/captain
	name = "船长勋章"
	desc = "一枚仅授予晋升至船长军衔者的金色勋章。它象征着船长对纳米传讯的法定职责，以及对其船员无可争议的权威。"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/accessory/medal/gold/heroism
	name = "非凡英雄主义勋章"
	desc = "一枚极其罕见的金色勋章，仅由中央指挥部颁发。获此勋章乃最高荣誉，因此存世极少。此勋章几乎从不授予指挥官以外的人。"

/obj/item/clothing/accessory/medal/plasma
	name = "等离子体奖章"
	desc = "一枚由等离子体制成的古怪奖章。"
	icon_state = "plasma"
	medaltype = "medal-plasma"
	custom_materials = list(/datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)

/obj/item/clothing/accessory/medal/plasma/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/item/clothing/accessory/medal/plasma/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > 300

/obj/item/clothing/accessory/medal/plasma/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	atmos_spawn_air("[GAS_PLASMA]=20;[TURF_TEMPERATURE(exposed_temperature)]")
	visible_message(span_danger("[src] 突然燃起火焰！"), span_userdanger("你的 [src] 突然燃起火焰！"))
	qdel(src)

/obj/item/clothing/accessory/medal/plasma/nobel_science
	name = "诺贝尔科学奖"
	desc = "一枚代表对科研或工程领域作出重大贡献的等离子体奖章。"

/obj/item/clothing/accessory/medal/silver/emergency_services
	name = "应急服务奖"
	desc = "一枚授予纳米传讯杰出应急服务人员的银质奖章，他们不畏艰险、孜孜不倦地携手协作，在恶劣的外层空间环境中守护船员的安全与呼吸。"
	icon_state = "emergencyservices"

	/// Flavor text that is appended to the description.
	var/insignia_desc = null

/obj/item/clothing/accessory/medal/silver/emergency_services/Initialize(mapload)
	. = ..()
	if(istext(insignia_desc))
		desc += " [insignia_desc]"

/obj/item/clothing/accessory/medal/silver/emergency_services/engineering
	icon_state = "emergencyservices_engi"
	insignia_desc = "奖章背面刻有一把橙色扳手。"

/obj/item/clothing/accessory/medal/silver/emergency_services/medical
	icon_state = "emergencyservices_med"
	insignia_desc = "奖章背面刻有一个深蓝色十字。"

/obj/item/clothing/accessory/medal/silver/elder_atmosian
	name = "大气学精通奖"
	desc = "常被称为“资深大气学家”奖，此奖章授予那些拓展边界、展现大气学精通的模范科学家与技师。"
	icon_state = "elderatmosian"
