/// Presentation-only labels used by medical scanners; never changes patient data.
/proc/chinese_scanner_label(value)
	if(!istext(value))
		return value
	var/static/list/labels
	if(isnull(labels))
		labels = list(
		"blood" = "血液", "oil" = "油", "acid" = "酸液", "water" = "水",
		"liquid electricity" = "液态电流", "colorful reagent" = "多彩试剂", "slime jelly" = "史莱姆凝胶",
		"space lube" = "太空润滑剂", "copper" = "铜", "nanite slurry" = "纳米机器人浆液",
		"brain" = "大脑", "heart" = "心脏", "lungs" = "肺", "liver" = "肝脏", "stomach" = "胃",
		"eyes" = "眼睛", "ears" = "耳朵", "tongue" = "舌头", "appendix" = "阑尾",
		"robotic heart" = "机械心脏", "cybernetic heart" = "义体心脏", "cybernetic lungs" = "义体肺",
		"cybernetic liver" = "义体肝脏", "cybernetic stomach" = "义体胃", "robotic eyes" = "机械眼",
		"unknown" = "未知", "bone gel" = "接骨凝胶", "eye stab" = "眼部刺伤", "heart ripped" = "心脏被撕出",
		"curse of the slot machine" = "老虎机的诅咒", "human force to the chest" = "胸部遭受人力挤压",
		"stethoscoped a corrupted heart" = "听诊腐化心脏", "cultist robes" = "血教徒长袍",
		"idiot moved with a needle in them" = "针头刺入时乱动", "iv needle" = "输液针头", "paper cut" = "纸张割伤",
		"bullet impact" = "子弹冲击", "hot temperatures" = "高温", "divine intervention" = "神力干预", "near dismemberment" = "险些断肢",
	)
	return labels[lowertext(value)] || chinese_body_zone_display(value)

/// Only accepts system-generated organ status strings, including their tooltips.
/proc/chinese_scanner_organ_status(value)
	if(!istext(value))
		return value
	var/static/list/fragments
	if(isnull(fragments))
		fragments = list(
		"Harmful Foreign Body" = "有害异物", "EMP-Derived Failure" = "电磁脉冲导致失效",
		"Non-Functional" = "功能丧失", "Severely Damaged" = "严重受损", "Mildly Damaged" = "轻度受损",
		"Myocardial Infarction" = "心肌梗死", "Cardiac Arrest" = "心脏骤停", "Inflamed" = "发炎", "% damaged" = "%受损",
		"Remove surgically." = "通过手术移除。", "Repair or replace surgically." = "通过手术修复或更换。",
		"Treat with rest or use specialty medication." = "通过休息或专用药物治疗。",
		"Repair surgically or use specialty medication." = "通过手术修复或专用药物治疗。",
		"Treat with rest." = "通过休息治疗。", "Use specialty medication." = "使用专用药物。",
		"Apply defibrillation immediately. Similar electric shocks may work in emergencies." = "立即除颤。紧急情况下类似的电击可能有效。",
		"Repair tissue damage and apply defibrillation immediately." = "修复组织损伤并立即除颤。",
		"Subject is permanently blind." = "受检者永久失明。", "Subject is blind from widespread ocular scarring." = "受检者因广泛眼部瘢痕而失明。",
		"Subject is blind from mental trauma." = "受检者因精神创伤而失明。", "Subject is genetically blind." = "受检者因基因问题而失明。",
		"Subject is blind from eye damage." = "受检者因眼部损伤而失明。", "Subject is blind." = "受检者失明。",
		"Subject is permanently nearsighted." = "受检者永久近视。", "Subject is nearsighted from severe ocular scarring." = "受检者因严重眼部瘢痕而近视。",
		"Subject is genetically nearsighted." = "受检者因基因问题而近视。", "Subject is nearsighted from eye damage." = "受检者因眼部损伤而近视。",
		"Subject is nearsighted." = "受检者近视。", "Subject is permanently deaf." = "受检者永久失聪。",
		"Subject is genetically deaf." = "受检者因基因问题而失聪。", "Subject is permanently deaf from ear damage." = "受检者因耳部损伤而永久失聪。",
		"Subject is temporarily deaf from ear damage." = "受检者因耳部损伤而暂时失聪。", "Subject is deaf." = "受检者失聪。",
		"Irreparable under normal circumstances." = "通常无法修复。", "Surgically replace eyes, irreparable otherwise." = "通过手术更换眼睛，否则无法修复。",
		"Repair via treatment of associated trauma." = "治疗相关创伤即可恢复。",
		"Prescription glasses will assuage the effects." = "佩戴近视眼镜可以缓解影响。",
		"Use medication such as [/datum/reagent/medicine/mutadone::name]." = "使用[/datum/reagent/medicine/mutadone::name]等药物。",
		"Repair surgically, use medication such as [/datum/reagent/medicine/oculine::name], or protect eyes with a blindfold." = "通过手术修复、使用[/datum/reagent/medicine/oculine::name]等药物，或佩戴眼罩保护眼睛。",
		"Repair surgically or use medication such as [/datum/reagent/medicine/oculine::name]." = "通过手术修复或使用[/datum/reagent/medicine/oculine::name]等药物。",
		"Repair surgically, use medication such as [/datum/reagent/medicine/inacusiate::name], or protect ears with earmuffs." = "通过手术修复、使用[/datum/reagent/medicine/inacusiate::name]等药物，或戴耳罩保护耳朵。",
		"Lung Dilation: " = "肺扩张程度：",
		"Subject's lungs are dilated and breathing more air than usual. Increases the effectiveness of healium and other gases." = "受检者的肺扩张，吸入空气多于平时。愈合气等气体的效果增强。",
		"Subject's lungs are completely shut. Subject is unable to breathe and requires emergency surgery. If asthmatic, perform asthmatic bypass surgery and adminster albuterol inhalant. Otherwise, replace lungs." = "受检者的肺完全闭塞，无法呼吸，需要紧急手术。若患哮喘，应实施哮喘旁路手术并给予沙丁胺醇吸入剂；否则更换肺。",
		"Subject's lungs are partially shut. If unable to breathe, administer a high-pressure internals tank or replace lungs. If asthmatic, inhaled albuterol or bypass surgery will likely help." = "受检者的肺部分闭塞。如无法呼吸，请提供高压内置呼吸气瓶或更换肺。若患哮喘，吸入沙丁胺醇或进行旁路手术可能有效。",
	)
	for(var/fragment in fragments)
		value = replacetext(value, fragment, fragments[fragment])
	return value
