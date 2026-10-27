/datum/opposing_force_equipment/language
	category = OPFOR_EQUIPMENT_CATEGORY_LANGUAGE
	item_type = /obj/effect/gibspawner/generic
	/// The language typepath to be given to the mind's language holder
	var/language

/datum/opposing_force_equipment/language/on_issue(mob/living/target)
	target.grant_language(language, source = LANGUAGE_MIND)

/datum/opposing_force_equipment/language/codespeak
	name = "暗语"
	description = "辛迪加特工可以用一连串暗号传递复杂信息，而旁听者只会听到毫无关联的概念和饮料名称。"
	language = /datum/language/codespeak

/datum/opposing_force_equipment/language/narsie
	name = "纳尔西语"
	description = "纳尔西邪教徒所用的古老语言，浸透鲜血，复杂得令人难以置信。"
	language = /datum/language/narsie

/datum/opposing_force_equipment/language/piratespeak
	name = "海盗语"
	description = "太空海盗的语言。"
	language = /datum/language/piratespeak

/datum/opposing_force_equipment/language/calcic
	name = "钙语"
	description = "等离子人的语言，零碎而短促。骷髅也能理解。"
	language = /datum/language/calcic

/datum/opposing_force_equipment/language/shadowtongue
	name = "暗影语"
	description = "何等宏伟而令人陶醉的天真。"
	language = /datum/language/shadowtongue

/datum/opposing_force_equipment/language/buzzwords
	name = "嗡鸣语"
	description = "所有昆虫通用的语言，通过有节奏地振翅发出。"
	language = /datum/language/buzzwords

/datum/opposing_force_equipment/language/xenocommon
	name = "异形语"
	description = "异形的通用语言。"
	language = /datum/language/xenocommon

/datum/opposing_force_equipment/language/monkey
	name = "黑猩猩语"
	description = "呜呜呜。"
	language = /datum/language/monkey

/datum/opposing_force_equipment/language/nekomimetic
	name = "猫语"
	description = "在普通旁观者听来，这种语言是一团无法理解的蹩脚日语。猫人却不知为何能听懂。"
	language = /datum/language/nekomimetic

/datum/opposing_force_equipment/language/mushroom
	name = "蘑菇语"
	description = "一种由间歇喷出饱含孢子的气流声构成的语言。"
	language = /datum/language/mushroom

/datum/opposing_force_equipment/language/drone
	name = "无人机语"
	description = "经过高度编码的损管协调数据流，包含专门的帽子标记。"
	language = /datum/language/drone

/datum/opposing_force_equipment/language/beachbum
	name = "海滩语"
	description = "来自遥远海滩星球的古老语言。人们在太空毒品的作用下会神奇地学会说这种语言。"
	language = /datum/language/beachbum


/datum/opposing_force_equipment/organs
	category = OPFOR_EQUIPMENT_CATEGORY_ORGANS

/datum/opposing_force_equipment/organs/xeno
	name = "异形器官植入套件"
	description = "装有非法获取的异形器官的植入套件。"
	admin_note = "赋予建造树脂结构、喷吐酸液和熔蚀空间站结构的能力。"
	item_type = /obj/item/storage/organbox/strange

/datum/opposing_force_equipment/organs/xeno_eggsac
	name = "异形器官及卵囊植入套件"
	description = "装有非法获取的异形器官的植入套件。包含能够繁育原生异形的卵囊。"
	admin_note = "提供全部异形器官，包括确实能生成真正异形的那个器官。"
	item_type = /obj/item/storage/organbox/strange/eggsac
