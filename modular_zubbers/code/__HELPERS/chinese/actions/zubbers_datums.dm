/proc/chinese_zubbers_datums_action_storage(value, action_type)
	if(value == "更改全息工具设置" && ispath(action_type, /datum/action/item_action/change_tool))
		return "Change Holotool Setting"
	if(value == "更改全息工具颜色" && ispath(action_type, /datum/action/item_action/change_ht_color))
		return "Change Holotool Color"
	if(value == "切换自身尺寸显示" && ispath(action_type, /datum/action/oversized_self_view))
		return "Toggle Self-Size View"
	if(value == "收回控制权" && ispath(action_type, /datum/action/innate/absorb_control))
		return "Take Back Control"
	if(value == "交还控制权" && ispath(action_type, /datum/action/innate/absorb_control/prey))
		return "Yield Control"
	if(value == "吞食模式" && ispath(action_type, /datum/action/innate/vore_mode))
		return "Vore Mode"
	if(value == "谐和脉冲" && ispath(action_type, /datum/action/cooldown/mob_cooldown/turtle_tree/healer/harmonizing_pulses))
		return "Harmonizing Pulses"
	if(value == "将手持物品设为传家宝" && ispath(action_type, /datum/action/mark_family_heirloom))
		return "Mark Held Item As Heirloom"
	if(value == "注入催情剂" && ispath(action_type, /datum/action/cooldown/mob_cooldown/aphrodisiacal_bite))
		return "Inject Aphrodisiac"
	if(value == "改变形态" && ispath(action_type, /datum/action/innate/alter_form/body_morpher))
		return "Alter Form"
	if(value == "产卵" && ispath(action_type, /datum/action/cooldown/spell/egg_production))
		return "Produce an Egg"
	if(value == "悬挂" && ispath(action_type, /datum/action/cooldown/spell/perch))
		return "Perch"
	if(value == "切换念力持物" && ispath(action_type, /datum/action/innate/toggle_floating_items))
		return "Toggle Psionic Holding"
	if(value == "注入毒液" && ispath(action_type, /datum/action/cooldown/mob_cooldown/venomous_bite))
		return "Inject Venom"
	if(value == "制造科技结构" && ispath(action_type, /datum/action/cooldown/fleshmind_create_structure))
		return "Create Tech Structure"
	if(value == "制造基础结构" && ispath(action_type, /datum/action/cooldown/fleshmind_create_structure/basic))
		return "Create Basic Structure"
	if(value == "呼叫血肉援军" && ispath(action_type, /datum/action/cooldown/fleshmind_flesh_call))
		return "Call Flesh Reinforcements"
	if(value == "血肉交流" && ispath(action_type, /datum/action/innate/fleshmind_flesh_chat))
		return "Flesh Chat"
	if(value == "种植线缆蔓" && ispath(action_type, /datum/action/cooldown/fleshmind_plant_weeds))
		return "Create Wireweed"
	if(value == "自爆" && ispath(action_type, /datum/action/cooldown/mob_cooldown/floater_explode))
		return "explode"
	if(value == "范围挥击" && ispath(action_type, /datum/action/cooldown/hiborg_slash))
		return "Slash (AOE)"
	if(value == "假死" && ispath(action_type, /datum/action/cooldown/himan_fake_death))
		return "Fake Death"
	if(value == "释放纳米机器人" && ispath(action_type, /datum/action/cooldown/mob_cooldown/treader_dispense_nanites))
		return "Dispense Nanites"
	if(value == "制造分身" && ispath(action_type, /datum/action/cooldown/phaser_phase_ability))
		return "Create Clones"
	if(value == "主激光炮" && ispath(action_type, /datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_laser))
		return "Main Laser"
	if(value == "发射火箭" && ispath(action_type, /datum/action/cooldown/mob_cooldown/projectile_attack/tyrant_rocket))
		return "Shoot Rocket"
	return value
