/// Preserve button-position keys for translated Skyrat system actions.
/proc/chinese_skyrat_systems_action_storage(value, action_type)
	if(ispath(action_type, /datum/action/cooldown/spell/sniff) && value == "嗅闻食物")
		return "Sniff Food"
	if(ispath(action_type, /datum/action/item_action/synth/open_internal_computer) && value == "打开个人电脑模拟器")
		return "Open persocom emulation"
	if(ispath(action_type, /datum/action/innate/monitor_change) && value == "更换屏幕")
		return "Screen Change"
	if(ispath(action_type, /datum/action/cooldown/alien/skyrat))
		var/static/list/alien_names = list("休息" = "Rest", "进化" = "Evolve", "治疗光环" = "Healing Aura", "强效治疗光环" = "Strong Healing Aura", "震耳尖啸" = "Deafening Screech", "坚忍" = "Endure", "闪避" = "Evade", "敏捷模式" = "Agility Mode")
		return alien_names[value] || value
	if(ispath(action_type, /datum/action/cooldown/alien/acid/skyrat))
		var/static/list/spit_names = list("喷吐神经毒素" = "Spit Neurotoxin", "喷吐酸液" = "Spit Acid", "散射神经毒素" = "Spit Neurotoxin Spread", "散射酸液" = "Spit Acid Spread")
		return spit_names[value] || value
	if(ispath(action_type, /datum/action/cooldown/spell/aoe/repulse/xeno/skyrat_tailsweep))
		var/static/list/tail_names = list("碎骨扫尾" = "Crushing Tail Sweep", "击飞扫尾" = "Flinging Tail Sweep", "利刃扫尾" = "Slicing Tail Sweep")
		return tail_names[value] || value
	if(ispath(action_type, /datum/action/cooldown/mob_cooldown/charge/basic_charge/defender) && value == "冲锋攻击")
		return "Charge Attack"
	if(ispath(action_type, /datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager) && value == "三连冲锋")
		return "Triple Charge Attack"
	return value
