GLOBAL_LIST_INIT(abductor_gear, subtypesof(/datum/abductor_gear))

#define CATEGORY_BASIC_GEAR "Basic Gear"
#define CATEGORY_ADVANCED_GEAR "Advanced Gear"
#define CATEGORY_MISC_GEAR "Miscellaneous Gear"

/datum/abductor_gear
	/// Name of the gear
	var/name = "通用绑架者装备"
	/// Description of the gear
	var/description = "通用描述。"
	/// Unique ID of the gear
	var/id = "abductor_generic"
	/// Credit cost of the gear
	var/cost = 1
	/// Build path of the gear itself
	var/build_path = null
	/// Category of the gear
	var/category = CATEGORY_BASIC_GEAR

/datum/abductor_gear/agent_helmet
	name = "特工头盔"
	description = "有格调地绑架——尖刺风。可阻止数字追踪。"
	id = "agent_helmet"
	build_path = list(/obj/item/clothing/head/helmet/abductor = 1)

/datum/abductor_gear/agent_vest
	name = "特工背心"
	description = "一件装备了先进隐蔽技术的背心。它有战斗和隐蔽两种模式。"
	id = "agent_vest"
	build_path = list(/obj/item/clothing/suit/armor/abductor/vest = 1)

/datum/abductor_gear/radio_silencer
	name = "无线电静默器"
	description = "一种用于关闭通讯设备的小型装置。"
	id = "radio_silencer"
	build_path = list(/obj/item/abductor/silencer = 1)

/datum/abductor_gear/science_tool
	name = "科研工具"
	description = "双模式工具，可采集样本并扫描外貌。扫描可以通过监控摄像头进行。"
	id = "science_tool"
	build_path = list(/obj/item/abductor/gizmo = 1)

/datum/abductor_gear/advanced_baton
	name = "高级电击棍"
	description = "四模式电击棍，用于制伏和束缚样本。"
	id = "advanced_baton"
	cost = 2
	build_path = list(/obj/item/melee/baton/abductor = 1)

/datum/abductor_gear/superlingual_matrix
	name = "超语言矩阵"
	description = "一种神秘的结构，能让使用者之间即时交流。在手中使用，可将其调谐至母舰频道。挺唬人的，直到你发现得吃点东西为止。"
	id = "superlingual_matrix"
	build_path = list(/obj/item/organ/tongue/abductor = 1)
	category = CATEGORY_MISC_GEAR

/datum/abductor_gear/mental_interface
	name = "精神接口装置"
	description = "双模式工具，可直接与有知觉的大脑交流。它既能向目标发送直接讯息，\
				也能向植入了充能腺体的实验对象发送指令。"
	id = "mental_interface"
	cost = 2
	build_path = list(/obj/item/abductor/mind_device = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/reagent_synthesizer
	name = "试剂合成器"
	description = "利用原生物质合成多种试剂。"
	id = "reagent_synthesizer"
	cost = 2
	build_path = list(/obj/item/abductor_machine_beacon/chem_dispenser = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/shrink_ray
	name = "缩小射线枪"
	description = "这是一件令人胆寒的外星科技，能增强局部空间内原子的磁引力，使物体暂时缩小。\
				也可能只是太空魔法。不管怎样，它确实能把东西缩小。"
	id = "shrink_ray"
	cost = 2
	build_path = list(/obj/item/gun/energy/shrink_ray = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/omnitool
	name = "外星万能工具"
	description = "一种集成了多得离谱的工具的手持装置。对任一角色来说都是便利的工具替代品。\
				右键点击可在医疗工具组与黑客工具组之间切换。"
	id = "omnitool"
	cost = 2
	build_path = list(/obj/item/abductor/alien_omnitool = 1)
	category = CATEGORY_ADVANCED_GEAR

/datum/abductor_gear/cow
	name = "备用奶牛"
	description = "送来一头来自早前绑架行动的剩余样本。"
	id = "cow"
	build_path = list(/mob/living/basic/cow = 1, /obj/item/food/grown/wheat = 3)
	category = CATEGORY_MISC_GEAR

/datum/abductor_gear/posters
	name = "装饰海报"
	description = "一些海报，可用来装饰母舰（甚至空间站）的墙壁。"
	id = "poster"
	build_path = list(/obj/item/poster/random_abductor = 2)
	category = CATEGORY_MISC_GEAR

#undef CATEGORY_BASIC_GEAR
#undef CATEGORY_ADVANCED_GEAR
#undef CATEGORY_MISC_GEAR
