/// Danger event - unskippable, if you have appriopriate tool you can mitigate damage.
/datum/exploration_event/simple/danger
	abstract_type = /datum/exploration_event/simple/danger
	description = "你遭遇了一个巨大的错误。"
	var/required_tool = EXODRONE_TOOL_LASER
	var/has_tool_action_text = "战斗"
	var/no_tool_action_text = "硬扛"
	var/has_tool_description = ""
	var/no_tool_description = ""
	var/avoid_log = "从危险中安然逃脱。"
	var/damage = 30
	skippable = FALSE

/datum/exploration_event/simple/danger/get_description(obj/item/exodrone/drone)
	. = ..()
	var/list/desc_parts = list(.)
	desc_parts += can_escape_danger(drone) ? has_tool_description : no_tool_description
	return desc_parts.Join("\n")

/datum/exploration_event/simple/danger/get_action_text(obj/item/exodrone/drone)
	return can_escape_danger(drone) ? has_tool_action_text : no_tool_action_text

/datum/exploration_event/simple/danger/proc/can_escape_danger(obj/item/exodrone/drone)
	return !required_tool || drone.has_tool(required_tool)

/datum/exploration_event/simple/danger/fire(obj/item/exodrone/drone)
	if(can_escape_danger(drone))
		drone.drone_log(avoid_log)
	else
		drone.damage(damage)
	end(drone)

/// Danger events
/datum/exploration_event/simple/danger/carp
	name = "太空鲤鱼袭击"
	required_site_traits = list(EXPLORATION_SITE_SPACE)
	blacklisted_site_traits = list(EXPLORATION_SITE_CIVILIZED)
	deep_scan_description = "你探测到该地点有损伤痕迹，表明此处存在太空鲤鱼。"
	description = "一条独行的太空鲤鱼伏击了你！"
	has_tool_action_text = "战斗"
	no_tool_action_text = "逃跑！"
	has_tool_description = "你为激光充能，将它击退。"
	no_tool_description = "没有任何武器，你只能试着仓皇逃跑！"
	avoid_log = "击败了一条太空鲤鱼。"

/// They get everywhere
/datum/exploration_event/simple/danger/carp/surface_variety
	required_site_traits = list(EXPLORATION_SITE_SURFACE)

/datum/exploration_event/simple/danger/assistant
	name = "助理袭击"
	required_site_traits = list(EXPLORATION_SITE_STATION)
	deep_scan_description = "检测到的面具使用系数表明，该地点聚集了相当数量的不良分子。"
	description = "你遇到一个身穿灰衣、毛发蓬乱的生物！那是个疯狂的助理！"
	has_tool_action_text = "战斗"
	no_tool_action_text = "逃跑！"
	has_tool_description = "你为激光充能，将它击退。"
	no_tool_description = "没有任何武器，你只能试着仓皇逃跑！"
	avoid_log = "击败了一名助理。"

/datum/exploration_event/simple/danger/collapse
	name = "坍塌"
	required_site_traits = list(EXPLORATION_SITE_RUINS)
	required_tool = EXODRONE_TOOL_DRILL
	deep_scan_description = "扫描表明该地点的结构已经破败不堪，建议谨慎行动。"
	description = "当你探查一条未探索的通道时，一处受损的天花板塌了下来！你被碎石困住了。"
	has_tool_action_text = "挖出去"
	no_tool_action_text = "硬挤出去。"
	has_tool_description = "你可以用钻头挖出去。"
	no_tool_description = "没有任何工具，你只好刮掉一些零件才能脱身。"
	avoid_log = "从坍塌的通道中挖了出来。"

/datum/exploration_event/simple/danger/loose_wires
	name = "松脱的电线"
	required_site_traits = list(EXPLORATION_SITE_TECHNOLOGY)
	required_tool = EXODRONE_TOOL_MULTITOOL
	deep_scan_description = "扫描显示该地点存在大量受损的线路。"
	description = "你听见身后传来一声巨响！一堆冒着火花的高压电线挡住了你的出口。"
	has_tool_action_text = "切断电源"
	no_tool_action_text = "被电熟。"
	has_tool_description = "你可以试着用多功能工具切断电源以脱身。"
	no_tool_description = "你只能冒着烧毁电子设备的风险逃出去。"
	avoid_log = "从松脱的电线中逃脱。"

/datum/exploration_event/simple/danger/cosmic_rays
	name = "宇宙射线爆发"
	required_site_traits = list(EXPLORATION_SITE_SURFACE)
	required_tool = EXODRONE_TOOL_MULTITOOL
	deep_scan_description = "该地点暴露在太空辐射之下。建议使用自检多功能工具附件。"
	description = "无人机的画面突然乱成一团！看来无人机被一阵宇宙射线击中了！你只能等信号恢复。"
	has_tool_description = "你的多功能工具应该能让相当一部分损伤自行修复。" //wait, what?
	no_tool_description = "除了等待并评估损失，你也无事可做。"
	has_tool_action_text = "等待"
	no_tool_action_text = "等待"
	avoid_log = "用多功能工具避免了宇宙射线损伤。"

/datum/exploration_event/simple/danger/alien_sentry
	name = "外星安保措施"
	required_site_traits = list(EXPLORATION_SITE_ALIEN)
	required_tool = EXODRONE_TOOL_TRANSLATOR
	deep_scan_description = "在该地点检测到来源不明的自动安保措施。"
	description = "一台外形危险的机器从地板中滑出，开始闪烁着奇怪的符号，同时发出尖锐的声音！"
	has_tool_description = "你的翻译器认出这些符号是安保警告，并建议你表明自己是访客。"
	no_tool_description = "紧接着那台机器就开始射击。"
	has_tool_action_text = "表明身份"
	no_tool_action_text = "逃跑"
	avoid_log = "避开了外星安保措施。"

/datum/exploration_event/simple/danger/beast
	name = "外星遭遇"
	required_site_traits = list(EXPLORATION_SITE_HABITABLE)
	blacklisted_site_traits = list(EXPLORATION_SITE_CIVILIZED)
	required_tool = EXODRONE_TOOL_LASER
	deep_scan_description = "在该地点检测到危险的动物群。"
	description = "你遭遇了一头不寻常的野兽！它正准备发起攻击。"
	has_tool_action_text = "战斗"
	no_tool_action_text = "逃跑"
	has_tool_description = "你准备好了激光。"
	no_tool_description = "没有任何武器，你只能试着仓皇逃跑！"
	avoid_log = "击败了一头野兽。"

/datum/exploration_event/simple/danger/beast/New()
	. = ..()
	var/beast_name = pick_list(EXODRONE_FILE,"alien_fauna")
	description = replacetext(description,"BEAST",beast_name)
	avoid_log = replacetext(avoid_log,"BEAST",beast_name)

/datum/exploration_event/simple/danger/rad
	name = "辐射区段"
	required_site_traits = list(EXPLORATION_SITE_SHIP)
	required_tool = EXODRONE_TOOL_MULTITOOL
	deep_scan_description = "扫描显示存在危险的放射性物质。"
	description = "你进入了一段毫无特征的船舱区段。"
	has_tool_action_text = "绕路"
	no_tool_action_text = "逃离并减轻损伤。"
	has_tool_description = "你的多功能工具突然闪起警告！前方区段受到辐射，你必须绕行才能避免损伤。"
	no_tool_description = "无人机突然报告严重损伤，看来这个区段受到了强烈的辐射。"
	avoid_log = "避开了辐射区段。"
