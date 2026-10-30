/// Which crime is the prisoner permabrigged for. For fluff!
/datum/preference/choiced/prisoner_crime
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "prisoner_crime"
	should_update_preview = FALSE

/datum/preference/choiced/prisoner_crime/init_possible_values()
	return assoc_to_keys(GLOB.prisoner_crimes) + "Random"

/datum/preference/choiced/prisoner_crime/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return

/datum/preference/choiced/prisoner_crime/create_default_value()
	return "Random"

/datum/preference/choiced/prisoner_crime/is_accessible(datum/preferences/preferences)
	return ..() && highest_priority_job_is(preferences, /datum/job/prisoner)

/// Types of Crimes Prisoners will have on their record roundstart.
/// (They also can choose Random, which picks from these options... randomly!)
GLOBAL_LIST_INIT(prisoner_crimes, init_prisoner_crimes())

/proc/init_prisoner_crimes()
	var/list/instances = list()
	for(var/datum/prisoner_crime/crime as anything in subtypesof(/datum/prisoner_crime))
		crime = new crime()
		instances[crime.name] = crime
	return instances

/datum/prisoner_crime
	/// crime name
	var/name = "把游戏搞出了 Bug"
	/// what the record will say about the crime
	var/desc = "参与了大规模破坏游戏的行为，且未在 Github 上报告。顺便一提，请在 Github 上报告此事！"
	/// how many tattoos come from the crime. People who committed murder have more than tax evaders!
	var/tattoos = -1

/datum/prisoner_crime/New()
	. = ..()
	if(tattoos == -1)
		tattoos = 1
		stack_trace("\"[src]\" prisoner_crime does not have a set amount of tattoos!")

/datum/prisoner_crime/negligence
	name = "Abhorrent Criminal Negligence"
	desc = "因无能而使众多生命陷入危险。"
	tattoos = 0

/datum/prisoner_crime/cloning
	name = "Attempted Development of Cloning"
	desc = "在克隆领域从事非法研究。克隆、克隆设施建造及相关研发已于 2560 年被取缔。"
	tattoos = 0

/datum/prisoner_crime/attempted_murder
	name = "Attempted Murder"
	desc = "企图恶意杀害他人。"
	tattoos = 2

/datum/prisoner_crime/bio_terrorism
	name = "Biological Terrorism"
	desc = "制造和/或释放了致命的生物制剂/生物体。"
	tattoos = 3

/datum/prisoner_crime/classified
	name = "Classified"
	desc = "请咨询法务部门。"
	tattoos = 0

/datum/prisoner_crime/espionage
	name = "Corporate Espionage"
	desc = "为商业目的对纳米传讯实施间谍活动。"
	tattoos = 1

/datum/prisoner_crime/counterfeiting
	name = "Counterfeiting"
	desc = "参与了大规模欺诈。"
	tattoos = 1

/datum/prisoner_crime/enemy_of_the_corp
	name = "Enemy of the Corporation"
	desc = "充当纳米传讯的敌人，或明知故犯地协助敌人。"
	tattoos = 1

/datum/prisoner_crime/grand_sabo
	name = "Grand Sabotage"
	desc = "实施恶意破坏行为，严重威胁纳米传讯员工和/或基础设施。"
	tattoos = 2

/datum/prisoner_crime/grand_theft
	name = "Grand Theft"
	desc = "窃取高价值或敏感物品。"
	tattoos = 1

/datum/prisoner_crime/identity_theft
	name = "Identity Theft of High-Ranking Figure"
	desc = "冒充高级别要员。"
	tattoos = 0 //well, obviously can't impersonate people with tats. if they want to go back to doing that

/datum/prisoner_crime/jaywalker
	name = "Jaywalker"
	desc = "在非绿色电车通道、穿梭机停靠区和/或太空中乱穿马路。"
	tattoos = 0 // Or should it be 6?

/datum/prisoner_crime/kidnapping
	name = "Kidnapping"
	desc = "策划并实施了绑架。"
	tattoos = 1

/datum/prisoner_crime/mass_murder
	name = "Mass Murder"
	desc = "恶意策划并实施了对多人的屠杀。"
	tattoos = 6

/datum/prisoner_crime/malpractice
	name = "Medical Malpractice"
	desc = "从事器官摘取、肢体窃取或其他恶意医疗操作。"
	tattoos = 2

/datum/prisoner_crime/murder
	name = "Murder"
	desc = "恶意杀害他人。"
	tattoos = 3

/datum/prisoner_crime/mutiny
	name = "Mutiny"
	desc = "企图推翻或破坏指挥链。"
	tattoos = 5 //+rep for trying

/datum/prisoner_crime/other
	name = "Other"
	desc = "请咨询法务部门。"
	tattoos = 1

/datum/prisoner_crime/ai_tampering
	name = "Tampering of Artificial Intelligence"
	desc = "向人工智能上传恶意、疏忽或其他被列入黑名单的指令。"
	tattoos = 3

/datum/prisoner_crime/tax_evasion
	name = "Tax Evasion"
	desc = "存在大量未结清的逃税行为。"
	tattoos = 1

/datum/prisoner_crime/cultist
	name = "Worship of Blacklisted Deities"
	desc = "信奉被列入黑名单的神祇。"
	tattoos = 1
