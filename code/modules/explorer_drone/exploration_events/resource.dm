/// Simple event type that checks if you have a tool and after a retrieval delay adds loot to drone.
/datum/exploration_event/simple/resource
	name = "可回收资源"
	abstract_type = /datum/exploration_event/simple/resource
	discovery_log = "遭遇可回收资源。"
	action_text = "提取"
	/// Tool type required to recover this resource
	var/required_tool
	/// What you get out of it, either /obj path or adventure_loot_generator id
	var/loot_type = /obj/item/trash/chips
	/// Message logged on success
	var/success_log = "取回了某样东西"
	/// Description shown when you don't have the tool
	var/no_tool_description = "没有钻头，你无法取出它。"
	/// Description shown when you have the necessary tool
	var/has_tool_description = "你可以用钻头把它取出来！"
	var/delay = 30 SECONDS
	var/delay_message = "正在回收资源……"
	/// How many times can this be extracted
	var/amount = 1

/// Description shown below image
/datum/exploration_event/simple/resource/get_description(obj/item/exodrone/drone)
	. = ..()
	var/list/desc_list = list(.)
	if(!required_tool || drone.has_tool(required_tool))
		desc_list += has_tool_description
	else
		desc_list += no_tool_description
	return desc_list.Join("\n")

/datum/exploration_event/simple/resource/action_enabled(obj/item/exodrone/drone)
	return (amount > 0) && (!required_tool || drone.has_tool(required_tool))

/datum/exploration_event/simple/resource/fire(obj/item/exodrone/drone)
	if(!action_enabled(drone)) //someone used it up or we lost the tool while we were looking at ui
		end()
		return
	amount--
	if(delay > 0)
		drone.set_busy(delay_message,delay)
		addtimer(CALLBACK(src, PROC_REF(delay_finished),WEAKREF(drone)),delay)
	else
		finish_event(drone)

/datum/exploration_event/simple/resource/is_targetable()
	return visited && amount > 0 ///Can go back if something is left.

/datum/exploration_event/simple/resource/proc/delay_finished(datum/weakref/drone_ref)
	var/obj/item/exodrone/drone = drone_ref.resolve()
	if(QDELETED(drone)) //drone blown up in the meantime
		return
	drone.unset_busy(EXODRONE_EXPLORATION)
	finish_event(drone)

/datum/exploration_event/simple/resource/proc/finish_event(obj/item/exodrone/drone)
	drone.drone_log(success_log)
	dispense_loot(drone)
	end(drone)

/datum/exploration_event/simple/resource/proc/dispense_loot(obj/item/exodrone/drone)
	if(ispath(loot_type,/datum/adventure_loot_generator))
		var/datum/adventure_loot_generator/generator = new loot_type
		generator.transfer_loot(drone)
	else
		var/obj/loot = new loot_type()
		drone.try_transfer(loot)


/// Resource Events

// All
/datum/exploration_event/simple/resource/concealed_cache
	name = "隐藏储藏箱"
	band_values = list(EXOSCANNER_BAND_DENSITY=1)
	required_tool = EXODRONE_TOOL_WELDER
	discovery_log = "发现了一个隐藏的、上锁的储藏箱。"
	description = "你发现了一个巧妙隐藏的金属容器。"
	no_tool_description = "没有焊接工具，你看不出任何打开它的办法。"
	has_tool_description = "你可以试着用焊接工具打开它。"
	action_text = "焊开"
	delay_message = "正在焊开储藏箱……"
	loot_type = /datum/adventure_loot_generator/maintenance

// EXPLORATION_SITE_RUINS 2/2
/datum/exploration_event/simple/resource/remnants
	name = "干瘪的尸体"
	required_site_traits = list(EXPLORATION_SITE_RUINS)
	required_tool = EXODRONE_TOOL_MULTITOOL
	discovery_log = "发现了一具类人生物的尸体。"
	description = "你找到一具干瘪的类人生物尸体，但它损坏得太严重，无法辨认身份。旁边放着一个上锁的公文包。"
	no_tool_description = "没有多功能工具，你无法打开它。"
	has_tool_description = "你可以试着用多功能工具把它破解开！"
	action_text = "破解"
	delay_message = "正在破解……"
	loot_type = /datum/adventure_loot_generator/simple/cash

/datum/exploration_event/simple/resource/gunfight
	name = "枪战遗留物"
	required_site_traits = list(EXPLORATION_SITE_RUINS)
	required_tool = EXODRONE_TOOL_DRILL
	discovery_log = "发现了一处往日枪战的现场。"
	description = "你找到一处遍地弹壳、被激光烧灼过的现场。你注意到附近一些碎石下面有东西。"
	no_tool_description = "没有钻头，你碰不到它。"
	has_tool_description = "你可以用钻头清掉碎石！"
	action_text = "清除碎石"
	delay_message = "正在钻孔……"
	loot_type = /datum/adventure_loot_generator/simple/weapons

// EXPLORATION_SITE_TECHNOLOGY 2/2
/datum/exploration_event/simple/resource/maint_room
	name = "上锁的维修间"
	required_site_traits = list(EXPLORATION_SITE_TECHNOLOGY,EXPLORATION_SITE_STATION)
	required_tool = EXODRONE_TOOL_MULTITOOL
	discovery_log = "发现了一间上锁的维修间。"
	success_log = "取回了上锁维修间内的物品。"
	description = "你发现一间上锁的维修间。附近的频繁走动痕迹清晰可见。"
	no_tool_description = "没有多功能工具，你无法打开它。"
	has_tool_description = "你可以试着用多功能工具打开它！"
	action_text = "破解"
	delay_message = "正在破解……"
	loot_type = /datum/adventure_loot_generator/maintenance
	amount = 3

/datum/exploration_event/simple/resource/storage
	name = "储藏室"
	required_site_traits = list(EXPLORATION_SITE_TECHNOLOGY,EXPLORATION_SITE_STATION)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	discovery_log = "发现了一间堆满板条箱的储藏室。"
	success_log = "用翻译后的清单找到了一箱药品。"
	description = "你找到一间堆满不明板条箱的储藏室。入口附近钉着一份用生僻语言书写的清单。"
	no_tool_description = "周围所有板条箱里都没有有用的东西，而没有翻译器就看不懂那份清单。"
	has_tool_description = "你可以用翻译器翻译那份清单！"
	action_text = "翻译"
	delay_message = "正在翻译清单……"
	loot_type = /datum/adventure_loot_generator/simple/drugs

// EXPLORATION_SITE_ALIEN 2/2
/datum/exploration_event/simple/resource/alien_tools
	name = "异形石棺"
	required_site_traits = list(EXPLORATION_SITE_ALIEN)
	band_values = list(EXOSCANNER_BAND_TECH=1,EXOSCANNER_BAND_RADIATION=1)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	discovery_log = "发现了一具覆满未知符文的异形石棺。"
	success_log = "取回了异形石棺内的物品。"
	description = "你找到一具源自异形的巨大石棺，表面覆满未知文字。"
	no_tool_description = "没有多功能工具，你看不出打开石棺或翻译符文的方法。"
	has_tool_description = "你翻译了符文，并找到了开启墓穴的隐藏机关说明。"
	delay_message = "正在开启……"
	action_text = "开启"
	loot_type = /obj/item/scalpel/alien

/datum/exploration_event/simple/resource/pod
	name = "异形生物舱"
	required_site_traits = list(EXPLORATION_SITE_ALIEN)
	band_values = list(EXOSCANNER_BAND_LIFE=1)
	required_tool = EXODRONE_TOOL_LASER
	discovery_log = "发现了一个异形生物舱。"
	success_log = "取回了异形生物舱内的物品。"
	description = "你遇到一个异形生物舱，里面装满了包裹着被绑架生命体的怪异囊袋。"
	no_tool_description = "没有精准的激光，你无法破开生物舱。"
	has_tool_description = "你可以试着用激光切开一个！"
	delay_message = "正在开启……"
	action_text = "开启"
	loot_type = /datum/adventure_loot_generator/pet

// EXPLORATION_SITE_SHIP 2/2
/datum/exploration_event/simple/resource/fuel_storage
	name = "燃料储备"
	required_site_traits = list(EXPLORATION_SITE_SHIP)
	band_values = list(EXOSCANNER_BAND_PLASMA=1)
	required_tool = EXODRONE_TOOL_MULTITOOL
	discovery_log = "发现了飞船的燃料储备。"
	description = "你找到了飞船的燃料储备。遗憾的是，它装有电子锁。"
	success_log = "从储备中取回了燃料。"
	no_tool_description = "没有多功能工具，你无法破开锁。"
	has_tool_description = "你可以试着用多功能工具让锁短路！"
	delay_message = "正在开启……"
	action_text = "开启"
	loot_type = /obj/item/fuel_pellet/exotic

/datum/exploration_event/simple/resource/navigation
	name = "导航系统"
	required_site_traits = list(EXPLORATION_SITE_SHIP)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	discovery_log = "发现了飞船的导航系统。"
	description = "你找到飞船的导航系统，其数据以某种陌生语言编码。有了翻译器你就能使用这些数据。"
	success_log = "从导航系统中取回了航运数据。"
	no_tool_description = "你需要一个翻译器来破译这些数据。"
	has_tool_description = "你可以试着用多功能工具翻译导航数据！"
	delay_message = "正在获取数据……"
	action_text = "获取数据"
	loot_type = /datum/adventure_loot_generator/cargo

// EXPLORATION_SITE_HABITABLE 2/2
/datum/exploration_event/simple/resource/unknown_microbiome
	name = "未知微生物群落"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	discovery_log = "发现了一处孤立的微生物群落。"
	description = "你发现了一个巨大的真菌聚落。"
	success_log = "取回了真菌样本以供日后研究。"
	no_tool_description = "用精准的激光，你可以切下一份样本用于研究。"
	has_tool_description = "你可以用激光小心地从聚落上切下一份样本！"
	delay_message = "正在取样……"
	action_text = "取样"
	loot_type = /obj/item/petri_dish/random

/datum/exploration_event/simple/resource/tcg_nerd
	name = "诡异的陌生人"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE)
	band_values = list(EXOSCANNER_BAND_LIFE=1)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	discovery_log = "遇到了一名诡异的陌生人。"
	description = "你遇到此地的原住民，其衣着破旧，显然正为某件事焦躁不安。"
	no_tool_description = "没有翻译器，你无法判断它想表达什么。"
	has_tool_description = "按你最好的翻译结果，它想和你分享自己的爱好！"
	success_log = "收到了一份来自陌生人的礼物。"
	delay_message = "正在忍受……"
	action_text = "接受礼物"
	loot_type = /obj/item/cardpack/series_one

// EXPLORATION_SITE_SPACE 2/2
/datum/exploration_event/simple/resource/comms_satellite
	name = "废弃通信卫星"
	required_site_traits = list(EXPLORATION_SITE_SPACE)
	required_tool = EXODRONE_TOOL_MULTITOOL
	discovery_log = "发现了一颗废弃的通信卫星。"
	description = "你发现一颗废弃的通信卫星。它的加密密钥仍然完好，但装有复杂的电子锁。"
	no_tool_description = "你需要一个多功能工具才能取出加密密钥。"
	has_tool_description = "你可以用多功能工具解除锁以取出密钥！"
	success_log = "从废弃卫星上取回了一把加密密钥。"
	delay_message = "正在破解……"
	action_text = "破解锁"
	loot_type = /obj/item/encryptionkey/heads/captain

/datum/exploration_event/simple/resource/welded_locker
	name = "焊死的储物柜"
	required_site_traits = list(EXPLORATION_SITE_SPACE)
	required_tool = EXODRONE_TOOL_WELDER
	discovery_log = "发现了一个草草焊死的储物柜。"
	description = "你发现一个漂浮在太空中的焊死的储物柜。里面会是什么呢……？"
	no_tool_description = "你需要一个焊接工具才能取出储物柜里的东西。"
	success_log = "取回了……一颗被砍下的头。"
	delay_message = "正在焊开……"
	action_text = "焊开"
	loot_type = /obj/item/bodypart/head

/datum/exploration_event/simple/resource/welded_locker/dispense_loot(obj/item/exodrone/drone)
	var/mob/living/carbon/human/head_species_source = new
	head_species_source.set_species(/datum/species/skeleton)
	head_species_source.real_name = "spaced locker victim"
	var/obj/item/bodypart/head/skeleton_head = head_species_source.get_bodypart(BODY_ZONE_HEAD)
	skeleton_head.drop_limb(FALSE)
	qdel(head_species_source)
	drone.try_transfer(skeleton_head)

// EXPLORATION_SITE_SURFACE 2/2
/datum/exploration_event/simple/resource/plasma_deposit
	name = "原始等离子矿藏"
	required_site_traits = list(EXPLORATION_SITE_SURFACE)
	band_values = list(EXOSCANNER_BAND_PLASMA=3)
	required_tool = EXODRONE_TOOL_DRILL
	discovery_log = "发现了一处规模可观的等离子矿藏。"
	success_log = "从矿藏中开采出了等离子。"
	description = "你定位到一处富含等离子地表矿藏。"
	no_tool_description = "你需要一个钻头才能从矿藏中取得任何东西。"
	has_tool_description = "你的钻头可以让你开采这处矿藏！"
	action_text = "开采"
	delay_message = "正在开采……"
	loot_type = /obj/item/stack/sheet/mineral/plasma/thirty

/datum/exploration_event/simple/resource/mineral_deposit
	name = "MATERIAL 矿藏"
	required_site_traits = list(EXPLORATION_SITE_SURFACE)
	band_values = list(EXOSCANNER_BAND_DENSITY=3)
	required_tool = EXODRONE_TOOL_DRILL
	discovery_log = "发现了一处规模可观的 MATRIAL 矿藏。"
	success_log = "从矿藏中开采出了 MATERIAL。"
	description = "你定位到一处富含 MATERIAL 的地表矿藏。"
	no_tool_description = "你需要一个钻头才能从矿藏中取得任何东西。"
	has_tool_description = "你的钻头可以让你开采这处矿藏！"
	action_text = "开采"
	delay_message = "正在开采……"
	var/static/list/possible_materials = list(/datum/material/silver,/datum/material/bananium) //only add materials with sheet type here //SKYRAT EDIT - REMOVED /datum/material/pizza
	var/loot_amount = 30
	var/chosen_material_type

/datum/exploration_event/simple/resource/mineral_deposit/New()
	. = ..()
	chosen_material_type = pick(possible_materials)
	var/datum/material/chosen_mat = SSmaterials.get_material(chosen_material_type)
	name = "[chosen_mat.name] 矿藏"
	discovery_log = "发现了一处规模可观的 [chosen_mat.name] 矿藏"
	success_log = "开采出了 [chosen_mat.name]。"
	description = "你定位到一处富含 [chosen_mat.name] 的地表矿藏。"

/datum/exploration_event/simple/resource/mineral_deposit/dispense_loot(obj/item/exodrone/drone)
	var/datum/material/chosen_mat = SSmaterials.get_material(chosen_material_type)
	var/obj/loot = new chosen_mat.sheet_type(loot_amount)
	drone.try_transfer(loot)
